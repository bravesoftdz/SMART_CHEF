unit GeradorNFe;

interface

uses
  { Units do Delphi }
  Contnrs,

  { Units do ACBr }
  ACBrNFe,
  ACBrNFeNotasFiscais,
  ACBrNFeDANFeRLClass,

  { Units das entidades do domínio }
  NotaFiscal, Empresa,
 // Fatura,
  ConfiguracoesNF, Generics.Collections,
  StrUtils, Dialogs, funcoes, ACBrDFeSSL;

type
  TGeradorNFe = class

  private
    FACBrNFe         :TACBrNFe;
    FACBrNFeDANFE    :TACBrNFeDANFeRL;
  //  FFatura          :TFatura;

  public
   constructor Create(const CaminhoLogo :String); overload;
   constructor Create; overload;

  public
   destructor Destroy; override;

  private
    tot_icm_somado :Real;
    tot_bcicms_somada :Real;
    tot_produto_somado :Real;
    tot_frete_somado :Real;

    { Gerar NF-e }
    function  GerarNFe          (NF :TNotaFiscal) :ACBrNFeNotasFiscais.NotaFiscal;

  private
    procedure AjustarConfiguracoesDaEmpresa(ConfiguracoesNF :TConfiguracoesNF);

    procedure GerarDadosDaCobranca(                 NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarDadosProdutos  (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarDestinatario   (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarEmitente       (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarIdentificacao  (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarLocalEntrega   (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarObservacao     (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarTransportador  (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarValoresTotais  (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
    procedure GerarVolumes        (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);

    procedure InicializaComponentes(const CaminhoLogo :String);
    
  public
   // procedure AdicionarFatura        (Fatura     :TFatura);
    procedure CancelarNFe            (NotaFiscal :TNotaFiscal; Justificativa :String);
    procedure ConsultarNFe           (NotaFiscal :TNotaFiscal);
    procedure EmitirNFe              (NotaFiscal :TNotaFiscal);
    procedure EnviarEmail            (NotaFiscal :TNotaFiscal);
    procedure GerarXML               (NotaFiscal :TNotaFiscal);
    procedure ImprimirComVisualizacao(NotaFiscal :TNotaFiscal);
    procedure ImprimirDireto         (NotaFiscal :TNotaFiscal);
    procedure Recarregar;
    function inutilizarNumeracao(nIni, nFim: integer; justificativa: String; Empresa: TEmpresa) :Boolean;

  public
    function ObterCertificado :String;
end;

implementation

uses
  { Units do Delphi }
  Classes,
  SysUtils,
  DateUtils,

  { Exceções do Domínio }
  ExcecaoParametroInvalido,
  ExcecaoNotaFiscalInvalida,

  { Tipos do Domínio }
  TipoAmbienteNFe,
  TipoSerie,
  TipoNaturezaOperacao,
  TipoFrete,
  TipoStatusNotaFiscal,
  TipoOrigemMercadoria,
  TipoRegimeTributario,

  { Utilitários do ACBr }
  ACBrNFeConfiguracoes,
  pcnConversao,
  pcnConversaoNFe,
  pcnNFe,
  ACBrMail,

  { Repositórios }
  FabricaRepositorio,
  Repositorio,

  { Entidades do Domínio }
//  Pessoa,
  Produto,
 // Duplicata,

  { Objetos valor do domínio }
  ItemNotaFiscal,
  Especificacao,
 // LocalEntregaNotaFiscal,
  VolumesNotaFiscal,
  TotaisNotaFiscal,
  ObservacaoNotaFiscal,


  { Utilitários }
 // DateTimeUtilitario,
  Math,

  { Busca }
  frameBuscaCidade,
  {frameBuscaNcm,} ACBrDFeConfiguracoes, ACBrDFe,// Icms00,
  ACBrNFeWebServices, pcnProcNFe, Pessoa, UtilitarioEstoque;

{ TGeradorNFe }
            {
procedure TGeradorNFe.AdicionarFatura(Fatura: TFatura);
begin
   self.FFatura := Fatura;
end;       }

procedure TGeradorNFe.AjustarConfiguracoesDaEmpresa(
  ConfiguracoesNF: TConfiguracoesNF);
begin
  if (TTipoAmbienteNFeUtilitario.DeStringParaEnumerado(ConfiguracoesNF.ambiente_nfe) = tanfeProducao) then
   self.FACBrNFe.Configuracoes.WebServices.Ambiente := taProducao
  else
   self.FACBrNFe.Configuracoes.WebServices.Ambiente := taHomologacao;

  self.FACBrNFe.Configuracoes.Certificados.NumeroSerie := ConfiguracoesNF.num_certificado;

  if not ConfiguracoesNF.senha_certificado.IsEmpty then
   self.FACBrNFe.Configuracoes.Certificados.Senha := ConfiguracoesNF.senha_certificado;
end;

procedure TGeradorNFe.CancelarNFe(NotaFiscal :TNotaFiscal; Justificativa :String);
var
  DhEvento  :TDateTime;
begin
   if Justificativa.IsEmpty then
    Justificativa := 'CANCELAMENTO DE NF-E';

  self.AjustarConfiguracoesDaEmpresa(NotaFiscal.Empresa.ConfiguracoesNF);

   self.FACBrNFe.EventoNFe.Evento.Clear;

   with self.FACBrNFe.EventoNFe.Evento.Add do
    begin
      DhEvento    := IncSecond(DataSEFAZToDateTime(NotaFiscal.NFe.ObtemValorPorTag('dhRecbto')), 10);

      infEvento.chNFe           := NotaFiscal.NFe.ChaveAcesso;
      infEvento.CNPJ            := NotaFiscal.Emitente.CPF_CNPJ;
      infEvento.dhEvento        := DhEvento; 
      infEvento.tpEvento        := teCancelamento;
      infEvento.detEvento.xJust := Justificativa;
      infEvento.detEvento.nProt := NotaFiscal.NFe.ObtemValorPorTag('nProt');
    end;

   if self.FACBrNFe.EnviarEvento(1) then
    begin
       NotaFiscal.NFe.Retorno.AlterarStatus(IntToStr(self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat),
                                            self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);
    end;
end;

function TGeradorNFe.inutilizarNumeracao(nIni, nFim: integer; justificativa :String; Empresa: TEmpresa) :Boolean;
var retorno :Integer;
begin
  try
  try
    result := false;
    self.AjustarConfiguracoesDaEmpresa(Empresa.ConfiguracoesNF);
    self.FACBrNFe.WebServices.Inutiliza(Empresa.cpf_cnpj,
                                        justificativa,
                                        YearOf(Date), //ano
                                        55, //modelo
                                        1, //serie
                                        nIni,
                                        nFim);
    result := true;
  Except
    on e :Exception do
    begin
      raise Exception.Create(e.Message)
    end;
  end;
  finally
    retorno := FACBrNFe.WebServices.Inutilizacao.cStat;
  end;
end;

procedure TGeradorNFe.ConsultarNFe(NotaFiscal: TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ConsultarNFe(NotaFiscal: TNotaFiscal)', 'NotaFiscal');

   self.AjustarConfiguracoesDaEmpresa(NotaFiscal.Empresa.ConfiguracoesNF);

   FACBrNFe.Configuracoes.Geral.ValidarDigest := false;
   FACBrNFe.NotasFiscais.Clear;
   FACBrNFe.NotasFiscais.LoadFromString(NotaFiscal.NFe.XMLText); //verificar esse xml com o da receita e ver oq difere
   FACBrNFe.Consultar;

   NotaFiscal.AdicionarRetornoNFe(IntToStr(self.FACBrNFe.WebServices.Consulta.cStat),
                                    self.FACBrNFe.WebServices.Consulta.xMotivo);

   self.GerarXML(NotaFiscal);

   if (NotaFiscal.NFe.Retorno.Status = '100') and not(NotaFiscal.EntrouEstoque = 'S') then
   begin
     TUtilitarioEstoque.atualizaEstoquePorNFe(NotaFiscal, IfThen(NotaFiscal.Entrada_saida = 'E', -1, 1));
     NotaFiscal.EntrouEstoque := 'S';
   end;
end;

constructor TGeradorNFe.Create(const CaminhoLogo :String);
begin
  self.InicializaComponentes(CaminhoLogo);
end;

constructor TGeradorNFe.Create;
begin
   self.Create('');
end;

destructor TGeradorNFe.Destroy;
begin
  self.FACBrNFeDANFe.ACBrNFe := nil;

  FreeAndNil(self.FACBrNFe);
  FreeAndNil(self.FACBrNFeDANFE);
  
  inherited;
end;

procedure TGeradorNFe.EmitirNFe(NotaFiscal: TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'EmitirNFe(NotaFiscal: TNotaFiscal)', 'NotaFiscal');

   self.FACBrNFe.NotasFiscais.Clear;

  self.AjustarConfiguracoesDaEmpresa(NotaFiscal.Empresa.ConfiguracoesNF);

  self.GerarNFe(NotaFiscal);

  self.FACBrNFe.NotasFiscais.GerarNFe;
  self.FACBrNFe.NotasFiscais.Assinar;
  self.FACBrNFe.NotasFiscais.Validar;

  self.FACBrNFe.WebServices.Enviar.Lote  := IntToStr(NotaFiscal.Lote.Codigo);

  if not(self.FACBrNFe.WebServices.Enviar.Executar) then
    raise Exception.Create(self.FACBrNFe.WebServices.Enviar.Msg);

  NotaFiscal.AdicionarRetornoLote(IntToStr(self.FACBrNFe.WebServices.Enviar.cStat), self.FACBrNFe.WebServices.Enviar.xMotivo, self.FACBrNFe.WebServices.Enviar.Recibo);
  NotaFiscal.AdicionarChaveAcesso(self.FACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID, self.FACBrNFe.NotasFiscais.Items[0].XML);
end;

procedure TGeradorNFe.EnviarEmail(NotaFiscal :TNotaFiscal);
var
  CC                 :TStrings;
  EmailsDestinatario :TStrings;
  nX                 :Integer;
  aux                :String;
  ACBrMail1          :TACBrMail;
  Mensagem           :String;
begin
   EmailsDestinatario := nil;
   CC                 := nil;

   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'EnviarEmail(NotaFiscal :TNotaFiscal)', 'NotaFiscal');

   if (NotaFiscal.Status <> snfAutorizada) then
    raise TExcecaoNotaFiscalInvalida.Create('A nota não está com status de enviada. Não é possível enviar e-mail com XML!');

   if not Assigned(NotaFiscal.Empresa.ConfiguracoesEmail) then
    //raise Exception.Create('Nenhuma configuração de e-mail configurada!');
     exit;

   if NotaFiscal.Destinatario.Email.IsEmpty then
     exit;
//    raise Exception.Create('O destinatário '+IntToStr(NotaFiscal.Destinatario.Codigo)+' - '+NotaFiscal.Destinatario.Razao+' não possui e-mails cadastrados!');

   try
     ACBrMail1                        := TACBrMail.Create(nil);
     EmailsDestinatario               := TStringList.Create;
     EmailsDestinatario.Delimiter     := ';';
     EmailsDestinatario.DelimitedText := NotaFiscal.Destinatario.Email;

     CC               := TStringList.Create;

     for nX := 0 to (EmailsDestinatario.Count-1) do begin
       if not(EmailsDestinatario[nX].IsEmpty) then
         CC.Add(EmailsDestinatario[nX]);
     end;

     if NotaFiscal.NFe.XMLText.IsEmpty then
      NotaFiscal.RecarregarNFe;

     ACBrMail1.Host                := NotaFiscal.Empresa.ConfiguracoesEmail.smtp_host;
     ACBrMail1.Port                := NotaFiscal.Empresa.ConfiguracoesEmail.smtp_port;
     ACBrMail1.Username            := NotaFiscal.Empresa.ConfiguracoesEmail.smtp_user;
     ACBrMail1.Password            := NotaFiscal.Empresa.ConfiguracoesEmail.smtp_password;
     ACBrMail1.From                := NotaFiscal.Empresa.ConfiguracoesEmail.smtp_user; { Remetente }
     ACBrMail1.SetSSL              := NotaFiscal.Empresa.ConfiguracoesEmail.usa_ssl = 'S'; // SSL - ConexÃ£o Segura
     ACBrMail1.SetTLS              := false; // Auto TLS
     ACBrMail1.ReadingConfirmation := False; //Pede confirmaÃ§Ã£o de leitura do email
     ACBrMail1.UseThread           := False;           //Aguarda Envio do Email(nÃ£o usa thread)
     ACBrMail1.FromName            := NotaFiscal.Emitente.Razao;

     self.FACBrNFe.MAIL := ACBrMail1;

     Mensagem := #13#10+#13#10+'ATENÇÃO, favor não responder. '+#13#10+#13#10+

                 'Esta mensagem refere-se à Nota Fiscal Eletrônica de número '+intToStr(NotaFiscal.NumeroNotaFiscal)+', emitida em '+DateToStr(NotaFiscal.DataEmissao)+' por:'+#13#10+
                 'Razão Social: '+NotaFiscal.Emitente.Razao+#13#10+
                 'CNPJ: '+NotaFiscal.Emitente.CPF_CNPJ+#13#10+#13#10+

                 'Chave de acesso: '+NotaFiscal.NFe.ChaveAcesso +#13#10+#13#10+

                 'Obs.: Este e-mail foi enviado automaticamente pelo sistema Smart Chef da empresa CBN Informática - (43) 3534-2350.';

     NotaFiscal.Empresa.ConfiguracoesEmail.Mensagem.Add(Mensagem);

     self.FACBrNFe.NotasFiscais.Clear;
     self.FACBrNFe.NotasFiscais.LoadFromString(NotaFiscal.NFe.XMLText);
     self.FACBrNFe.NotasFiscais.Items[0].EnviarEmail( CC[0],
                                                      NotaFiscal.Empresa.ConfiguracoesEmail.Assunto,
                                                      NotaFiscal.Empresa.ConfiguracoesEmail.Mensagem,
                                                      True,  // Enviar PDF junto
                                                      CC,    // Lista com emails que serÃ£o enviado cÃ³pias - TStrings
                                                      nil);  // Lista de anexos - TStrings


   finally
     FreeAndNil(EmailsDestinatario);
     FreeAndNil(CC);
     FreeAndNil(ACBrMail1);
   end;
end;

procedure TGeradorNFe.GerarDadosDaCobranca(NFe :ACBrNFeNotasFiscais.NotaFiscal);
var
  nX        :Integer;
 // Duplicata :TDuplicata;
begin
  { if not Assigned(self.FFatura) then
    exit;

    { Fatura }
  {  NFe.NFe.Cobr.Fat.nFat       := self.FFatura.NumeroFaturaStr;
    NFe.NFe.Cobr.Fat.vOrig      := self.FFatura.ValorBruto;
    NFe.NFe.Cobr.Fat.vDesc      := self.FFatura.ValorDesconto;
    NFe.NFe.Cobr.Fat.vLiq       := self.FFatura.ValorLiquido;

    NFe.NFe.Cobr.Dup.Clear;
    
    { Duplicatas }
   { for nX := 0 to (self.FFatura.Duplicatas.Count-1) do begin
       Duplicata := (self.FFatura.Duplicatas[nX] as TDuplicata);

       with NFe.NFe.Cobr.Dup.Add do begin
          nDup  := Duplicata.NumeroDuplicata;
          dVenc := Duplicata.DataVencimento;
          vDup  := Duplicata.ValorDuplicata;
       end;
    end;     }
end;

procedure TGeradorNFe.GerarDadosProdutos(NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
var
  nX       :Integer;
  Item     :TItemNotaFiscal;
  ItemNFe  :TDetCollectionItem;
  Itens    :TObjectList<TITemNotaFiscal>;

  tot_desc_somado, diferenca :REal;
  icms_partilha :Real;
  perc_destinatario :Real;
  sim :boolean;
begin
   sim := true;
   Itens    := NF.Itens;

   tot_desc_somado    := 0;
   tot_icm_somado     := 0;
   tot_frete_somado   := 0;
   tot_bcicms_somada  := 0;
   tot_produto_somado := 0;
   diferenca          := 0;
   icms_partilha      := 0;

     for nX := 0 to (Itens.Count-1) do begin

        ItemNFe         := nfe.NFe.Det.Add;
        Item            := (Itens[nX] as TItemNotaFiscal);

        { Grupo de Detalhamento de Produtos e Serviços da NF-e }
        ItemNFe.Prod.nItem    := (nX+1);
        ItemNFe.Prod.cProd    := IntToStr(Item.Produto.codigo);
        ItemNFe.Prod.xProd    := Item.Produto.Descricao;
        ItemNFe.Prod.NCM      := Item.Produto.NCMIbpt.ncm_ibpt;
        ItemNFe.Prod.CFOP     := Item.NaturezaOperacao.CFOP;
        ItemNFe.Prod.uCom     := Item.Produto.Estoque.unidade_medida;
        ItemNFe.Prod.vUnCom   := Item.ValorUnitario;
        ItemNFe.Prod.qCom     := Item.Quantidade;
        ItemNFe.Prod.vProd    := RoundTo(Item.ValorBruto,-2);
        ItemNFe.Prod.uTrib    := Item.Produto.Estoque.unidade_medida;
        ItemNFe.Prod.vUnTrib  := Item.ValorUnitario;
        ItemNFe.Prod.qTrib    := Item.Quantidade;
        ItemNFe.Prod.vFrete   := Item.ValorFrete;
        ItemNFe.Prod.vSeg     := Item.ValorSeguro;
        ItemNFe.Prod.vDesc    := Item.ValorDesconto;
        ItemNFe.Prod.vOutro   := Item.ValorOutrasDespesas;

        tot_frete_somado   := tot_frete_somado + RoundTo(Item.ValorFrete, -2);
        tot_produto_somado := tot_produto_somado + ItemNFe.Prod.vProd;

        tot_desc_somado := tot_desc_somado + Item.ValorDesconto;

        if (nX = (Itens.Count - 1)) then begin
          diferenca := tot_desc_somado - NF.Totais.Descontos;

          ItemNFe.Prod.vDesc := ItemNFe.Prod.vDesc - diferenca;
        end;

        { ICMS }


        if Nf.CalculaIcmsCompartilhado then begin

          ItemNFe.Imposto.ICMSUFDest.vBCUFDest   := Item.ValorTotalItem;
          ItemNFe.Imposto.ICMSUFDest.pFCPUFDest  := NF.AliquotaFCP;
          ItemNFe.Imposto.ICMSUFDest.pICMSUFDest := Nf.AliquotaInterna;

          ItemNFe.Imposto.ICMSUFDest.pICMSInter  := NF.AliquotaInterestadual;

          ItemNFe.Imposto.ICMSUFDest.pICMSInterPart := Nf.AliquotaPartilhaDestinatario;

          ItemNFe.Imposto.ICMSUFDest.vFCPUFDest     := 0;//((ItemNFe.Imposto.ICMSUFDest.pFCPUFDest * ItemNFe.Imposto.ICMSUFDest.vBCUFDest) /100);

          icms_partilha := roundto(Item.ValorTotalItem * ((ItemNFe.Imposto.ICMSUFDest.pICMSUFDest -
                                                           ItemNFe.Imposto.ICMSUFDest.pICMSInter +
                                                           ItemNFe.Imposto.ICMSUFDest.pFCPUFDest) / 100), -2);

          ItemNFe.Imposto.ICMSUFDest.vICMSUFDest    := 0;//roundTo( (icms_partilha * Nf.AliquotaPartilhaDestinatario) /100, -2);
          ItemNFe.Imposto.ICMSUFDest.vICMSUFRemet   := 0;//roundTo( icms_partilha - ItemNFe.Imposto.ICMSUFDest.vICMSUFDest, -2);

        end;

        { ICMS para L.P/L.R. }
        if Assigned(Item.Icms00) then begin
          case Item.Icms00.OrigemMercadoria of
            tomNacional:                           ItemNFe.Imposto.ICMS.orig := oeNacional;
            tomEstrangeiraImportacaoDireta:        ItemNFe.Imposto.ICMS.orig := oeEstrangeiraImportacaoDireta;
            tomEstrangeiraAdquiridaMercadoInterno: ItemNFe.Imposto.ICMS.orig := oeEstrangeiraAdquiridaBrasil;
          end;

          //padrao
          ItemNFe.Imposto.ICMS.CST    := cst00;

          ItemNFe.Imposto.ICMS.modBC  := dbiValorOperacao;
          ItemNFe.Imposto.ICMS.vBC    := RoundTo(Item.BaseCalculoICMS,-2);
          ItemNFe.Imposto.ICMS.pICMS  := Item.Icms00.Aliquota;

               //excecao .
          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.ICMS.CST    := cst50; //cst suspensao ICMS

          if Nf.NotaDeReducao then begin
            ItemNFe.Imposto.ICMS.CST    := cst51; //cst de diferimento

            ItemNFe.Imposto.ICMS.pDif     := Item.Icms00.PercReducaoBC;
            ItemNFe.Imposto.ICMS.vICMSOp  := RoundTo((ItemNFe.Imposto.ICMS.vBC * Item.Icms00.Aliquota)/100,-2);
            ItemNFe.Imposto.ICMS.vICMSDif := RoundTo((ItemNFe.Imposto.ICMS.vICMSOp * Item.Icms00.PercReducaoBC) / 100,-2);
            ItemNFe.Imposto.ICMS.vICMS    := RoundTo(ItemNFe.Imposto.ICMS.vICMSOp - ItemNFe.Imposto.ICMS.vICMSDif,-2);
          end
          else
            ItemNFe.Imposto.ICMS.vICMS  := RoundTo(Item.ValorICMS,-2);


          tot_bcicms_somada := tot_bcicms_somada + ItemNFe.Imposto.ICMS.vBC;
          tot_icm_somado    := tot_icm_somado + ItemNFe.Imposto.ICMS.vICMS;

          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.ICMS.vBC    := 0;
        end;

        { ICMS para simples nacional }
        if Assigned(Item.IcmsSn101) then begin
          case Item.IcmsSn101.OrigemMercadoria of
            tomNacional:                           ItemNFe.Imposto.ICMS.orig := oeNacional;
            tomEstrangeiraImportacaoDireta:        ItemNFe.Imposto.ICMS.orig := oeEstrangeiraImportacaoDireta;
            tomEstrangeiraAdquiridaMercadoInterno: ItemNFe.Imposto.ICMS.orig := oeEstrangeiraAdquiridaBrasil;
          end;

        {  if NF.Destinatario.Pessoa = 'F' then
          begin  }

         ItemNFe.Imposto.ICMS.CSOSN := StrToEnumerado(sim, Item.Produto.NcmIBPT.cst, ['', '101' ,'102', '103', '201', '202', '203', '300', '400', '500', '900'],
                                                                                      [csosnVazio, csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500,csosn900]);

         { end
          else
            ItemNFe.Imposto.ICMS.CSOSN        := csosn102; //csosn101; }

          ItemNFe.Imposto.ICMS.pCredSN      := Item.IcmsSn101.AliquotaCreditoSN;
          ItemNFe.Imposto.ICMS.vCredICMSSN  := Item.IcmsSn101.ValorCreditoSN;
        end;

        { IPI }
        ItemNFe.Imposto.IPI.clEnq := '999';

        { IPI para lucro presumido }
        if Assigned(Item.IpiTrib) then begin
          ItemNFe.Imposto.IPI.CST  := ipi50;
          ItemNFe.Imposto.IPI.vBC  := Item.IpiTrib.BaseCalculo;
          ItemNFe.Imposto.IPI.pIPI := Item.IpiTrib.Aliquota;
          ItemNFe.Imposto.IPI.vIPI := Item.IpiTrib.Valor;
        end;

        { IPI para simples nacional }
        if Assigned(Item.IpiNt) then
          ItemNFe.Imposto.IPI.CST := ipi51;

        { PIS }

        { PIS para L.P/L.R. }
        if Assigned(Item.PisAliq) then begin

          //padrao
          ItemNFe.Imposto.PIS.CST    := pis02;

          //excecao
          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.PIS.CST    := pis09; //cst suspensao PIS

          ItemNFe.Imposto.PIS.vBC    := Item.PisAliq.BaseCalculo;
          ItemNFe.Imposto.PIS.pPIS   := Item.PisAliq.Aliquota;
          ItemNFe.Imposto.PIS.vPIS   := Item.PisAliq.Valor;

          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.PIS.vBC    := 0;
        end;

        { PIS para simples nacional }
        if Assigned(Item.PisNt) then
          ItemNFe.Imposto.PIS.CST    := pis07;

        { COFINS }

        { COFINS para L.P/L.R. }
        if Assigned(Item.CofinsAliq) then begin
          //padrao
          ItemNFe.Imposto.COFINS.CST     := cof02;

          //excecao
          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.COFINS.CST     := cof09; //cst suspensao COFINS

          ItemNFe.Imposto.COFINS.vBC     := Item.CofinsAliq.BaseCalculo;
          ItemNFe.Imposto.COFINS.pCOFINS := Item.CofinsAliq.Aliquota;
          ItemNFe.Imposto.COFINS.vCOFINS := Item.CofinsAliq.Valor;

          if Item.NaturezaOperacao.suspensao_icms = 'S' then
            ItemNFe.Imposto.COFINS.vBC    := 0;
        end;

        { COFINS para simples nacional }
        if Assigned(Item.CofinsNt) then begin
          ItemNFe.Imposto.COFINS.CST    := cof07; 
        end;
     end;
end;

procedure TGeradorNFe.GerarDestinatario (NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
begin
  if UpperCase(TRIM(NF.Destinatario.RG_IE)) = 'ISENTO' then begin
    if (length(NF.Destinatario.CPF_CNPJ) < 14) then
      nfe.NFe.Dest.indIEDest   := inNaoContribuinte
    else
    begin
      if NF.Destinatario.Enderecos[0].Cidade.Estado.sigla <> 'SP' then
        nfe.NFe.Dest.indIEDest   := inIsento
      else
      begin
        nfe.NFe.Dest.indIEDest   := inNaoContribuinte;
        nfe.NFe.Ide.indFinal     := cfConsumidorFinal;
      end;
    end;
  end
  else if UpperCase(TRIM(NF.Destinatario.RG_IE)) = '' then
     nfe.NFe.Dest.indIEDest   := inNaoContribuinte
  else begin
     nfe.NFe.Dest.indIEDest := inContribuinte;
     nfe.NFe.Dest.IE        := NF.Destinatario.RG_IE;
  end;

  nfe.NFe.Dest.CNPJCPF           := NF.Destinatario.CPF_CNPJ;
  nfe.NFe.Dest.xNome             := NF.Destinatario.Razao;
  nfe.NFe.Dest.EnderDest.xLgr    := NF.Destinatario.Enderecos[0].Logradouro;
  nfe.NFe.Dest.EnderDest.cPais   := 1058;
  nfe.NFe.Dest.EnderDest.xPais   := 'BRASIL';
  nfe.NFe.Dest.EnderDest.nro     := NF.Destinatario.Enderecos[0].Numero;
  nfe.NFe.Dest.EnderDest.xBairro := NF.Destinatario.Enderecos[0].Bairro;
  nfe.NFe.Dest.EnderDest.cMun    := NF.Destinatario.Enderecos[0].Cidade.codibge;
  nfe.NFe.Dest.EnderDest.xMun    := NF.Destinatario.Enderecos[0].Cidade.nome;
  nfe.NFe.Dest.EnderDest.UF      := NF.Destinatario.Enderecos[0].Cidade.Estado.sigla;
  nfe.NFe.Dest.EnderDest.CEP     := StrToIntDef(ApenasNumeros(NF.Destinatario.Enderecos[0].cep),0);
  nfe.NFe.Dest.EnderDest.fone    := ApenasNumeros(NF.Destinatario.Fone1);
end;

procedure TGeradorNFe.GerarEmitente(NF :TNotaFiscal; NFe: ACBrNFeNotasFiscais.NotaFiscal);
begin
  nfe.NFe.Emit.CNPJCPF           := NF.Emitente.CPF_CNPJ;
  nfe.NFe.Emit.xNome             := NF.Emitente.Razao;
  nfe.NFe.Emit.xFant             := NF.Emitente.Razao;
  nfe.NFe.Emit.EnderEmit.xLgr    := NF.Emitente.Enderecos[0].Logradouro;
  nfe.NFe.Emit.EnderEmit.nro     := NF.Emitente.Enderecos[0].Numero;
  nfe.NFe.Emit.EnderEmit.xBairro := NF.Emitente.Enderecos[0].Bairro;
  nfe.NFe.Emit.EnderEmit.cMun    := NF.Emitente.Enderecos[0].Cidade.codibge;
  nfe.NFe.Ide.cMunFG             := NF.Emitente.Enderecos[0].Cidade.codibge;
  nfe.NFe.Emit.EnderEmit.xMun    := NF.Emitente.Enderecos[0].Cidade.nome;
  nfe.NFe.Emit.EnderEmit.UF      := NF.Emitente.Enderecos[0].Cidade.Estado.sigla;
  nfe.NFe.Emit.EnderEmit.CEP     := StrToInt(ApenasNumeros(NF.Emitente.Enderecos[0].CEP));
  nfe.NFe.Emit.EnderEmit.fone    := ApenasNumeros(NF.Emitente.Fone1);
  nfe.NFe.Emit.IE                := NF.Emitente.RG_IE;
  //nfe.NFe.Emit.CRT               := crtRegimeNormal;

  { Para o caso do emitente ser empresa }
  case NF.Empresa.ConfiguracoesNF.RegimeTributario of
    trtSimplesNacional: nfe.NFe.Emit.CRT := crtSimplesNacional;
    trtLucroPresumido:  nfe.NFe.Emit.CRT := crtRegimeNormal;
  end;
end;

procedure TGeradorNFe.GerarIdentificacao(NF: TNotaFiscal; NFe: ACBrNFeNotasFiscais.NotaFiscal);
begin
  nfe.NFe.Ide.cUF     := 41;
  nfe.NFe.Ide.cNF     := NF.NumeroNotaFiscal;
  nfe.NFe.Ide.natOp   := NF.CFOP.Descricao;

  {if Assigned(self.FFatura) then
    nfe.NFe.Ide.indPag  := ipPrazo
  else }
  nfe.NFe.Ide.indPag  := ipVista;

  nfe.NFe.Ide.modelo  := 55;
  nfe.NFe.Ide.serie   := StrToInt(NF.Serie);
  nfe.NFe.Ide.nNF     := NF.NumeroNotaFiscal;
  nfe.NFe.Ide.dEmi    := NF.DataEmissao;
  nfe.NFe.Ide.dSaiEnt := NF.DataSaida;

  case StrToInt(NF.Finalidade) of
   1 : nfe.NFe.Ide.finNFe  := fnNormal;
   2 : nfe.NFe.Ide.finNFe  := fnComplementar;
   3 : nfe.NFe.Ide.finNFe  := fnAjuste;
   4 : nfe.NFe.Ide.finNFe  := fnDevolucao;
  end;

  if nfe.NFe.Ide.finNFe = fnDevolucao then
    with nfe.NFe.Ide.NFref.Add do begin
      refNFe  := NF.NFe_referenciada;
    end;

  if (NF.CFOP.Tipo in [tnoSaidaDentroEstado, tnoSaidaForaEstado, tnoExportacao]) then
    nfe.NFe.Ide.tpNF := tnSaida
  else
    nfe.NFe.Ide.tpNF := tnEntrada;

  if not assigned(Nf.Destinatario.Enderecos[0].Cidade) then
    raise Exception.Create('Cidade do destinatário não foi cadastrada');

  case AnsiIndexStr(UpperCase(Nf.Destinatario.Enderecos[0].Cidade.estado.sigla), [NF.Emitente.Enderecos[0].Cidade.estado.sigla, 'XX']) of
    0 : nfe.NFe.Ide.idDest := doInterna;
    1 : nfe.NFe.Ide.idDest := doExterior;
    else nfe.NFe.Ide.idDest := doInterestadual;
  end;

  case IfThen( length(Nf.Destinatario.CPF_CNPJ)>13,0,1) of
    0: nfe.NFe.Ide.indFinal := cfNao;
    1: nfe.NFe.Ide.indFinal := cfConsumidorFinal;
  end;

  nfe.NFe.Ide.indPres  := pcTeleatendimento;
  nfe.NFe.Ide.cMunFG   := 0;
  nfe.NFe.Ide.tpImp    := tiRetrato;
  nfe.NFe.Ide.tpEmis   := self.FACBrNFe.Configuracoes.Geral.FormaEmissao;

  if NF.Empresa.ConfiguracoesNF.Tipo_emissao = 7 then
  begin
    nfe.NFe.Ide.xJust    := 'Indisponibilidade do ambiente normal de autorização';
    nfe.NFe.Ide.dhCont   := NF.Empresa.ConfiguracoesNF.Dt_contingencia;
  end;

  nfe.NFe.Ide.cDV      := 0;
  nfe.NFe.Ide.tpAmb    := self.FACBrNFe.Configuracoes.WebServices.Ambiente;
  nfe.NFe.Ide.procEmi  := peAplicativoContribuinte;
  nfe.NFe.Ide.verProc  := '1.0'; //versao do erp
end;

procedure TGeradorNFe.GerarLocalEntrega(NF :TNotaFiscal; NFe: ACBrNFeNotasFiscais.NotaFiscal);

  //LocalEntrega :TLocalEntregaNotaFiscal;
begin
{   if not Assigned(NF.LocalEntrega) then
    exit;

   LocalEntrega := NF.LocalEntrega;
   
   if TStringUtilitario.EstaVazia(LocalEntrega.CnpjCpf) then
    exit;

   nfe.NFe.Entrega.CNPJCPF := LocalEntrega.CnpjCpf;
   nfe.NFe.Entrega.xLgr    := LocalEntrega.Logradouro;
   nfe.NFe.Entrega.xCpl    := LocalEntrega.Complemento;
   nfe.NFe.Entrega.xBairro := LocalEntrega.Bairro;
   nfe.NFE.Entrega.nro     := LocalEntrega.Numero;
   nfe.NFe.Entrega.cMun    := LocalEntrega.CodigoMunicipio;
   nfe.NFe.Entrega.xMun    := LocalEntrega.NomeMunicipio;
   nfe.NFe.Entrega.UF      := LocalEntrega.UF;    }
end;

function TGeradorNFe.GerarNFe(NF :TNotaFiscal) :ACBrNFeNotasFiscais.NotaFiscal;
begin
   result := self.FACBrNFe.NotasFiscais.Add;

   if NF.Empresa.ConfiguracoesNF.Tipo_emissao > 1 then
     case NF.Empresa.ConfiguracoesNF.Tipo_emissao of
       7: self.FACBrNFe.Configuracoes.Geral.FormaEmissao  := teSVCRS;
     end;

   self.GerarIdentificacao  (NF, result);
   self.GerarEmitente       (NF, result);
   self.GerarDestinatario   (NF, result);
   self.GerarLocalEntrega   (NF, result);
   self.GerarDadosProdutos  (NF, result);
   self.GerarValoresTotais  (NF, result);
   self.GerarTransportador  (NF, result);
   self.GerarVolumes        (NF, result);
   self.GerarObservacao     (NF, result);
   self.GerarDadosDaCobranca(result);
end;

procedure TGeradorNFe.GerarObservacao(NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
var
  Observacoes :TObservacaoNotaFiscal;
begin
   if not Assigned(NF.Observacoes) then exit;

   Observacoes := NF.Observacoes;
   
   nfe.NFe.InfAdic.infCpl := Observacoes.DadosAdicionais;

   if NF.CalculaIcmsCompartilhado then
  {   nfe.NFe.InfAdic.infCpl := nfe.NFe.InfAdic.infCpl + #13#10+'PARTILHA ICMS OPERAÇÃO INTERESTADUAL CONSUMIDOR FINAL, DISPOSTO NA EMENDA CONSTITUCIONAL 87/2015. '+
                               'VALOR ICMS UF DESTINO: '+ TStringUtilitario.FormataDinheiro(nfe.NFe.Total.ICMSTot.vICMSUFDest) +
                               ' - VALOR ICMS UF REMETENTE: '+ TStringUtilitario.FormataDinheiro(nfe.NFe.Total.ICMSTot.vICMSUFRemet); }
end;

procedure TGeradorNFe.GerarTransportador(NF: TNotaFiscal; NFe: ACBrNFeNotasFiscais.NotaFiscal);
begin
  if   (NF.TipoFrete = tfCIF) then
    nfe.NFe.Transp.modFrete := mfContaEmitente
  else
    nfe.NFe.Transp.modFrete := mfContaDestinatario;

  if not assigned(NF.Transportadora) then
    exit;

  nfe.NFe.Transp.Transporta.CNPJCPF := NF.Transportadora.CPF_CNPJ;
  nfe.NFe.Transp.Transporta.xNome   := NF.Transportadora.Razao;
  nfe.NFe.Transp.Transporta.IE      := NF.Transportadora.RG_IE;
  nfe.NFe.Transp.Transporta.xEnder  := NF.Transportadora.Enderecos[0].Logradouro;
  nfe.NFe.Transp.Transporta.xMun    := NF.Transportadora.Enderecos[0].Cidade.nome;
  nfe.NFe.Transp.Transporta.UF      := NF.Transportadora.Enderecos[0].Cidade.Estado.sigla;
end;

procedure TGeradorNFe.GerarValoresTotais(NF :TNotaFiscal; NFe :ACBrNFeNotasFiscais.NotaFiscal);
var
  Totais :TTotaisNotaFiscal;
  diferenca :Real;
begin
  if not Assigned(NF.Totais) then exit;

  Totais := NF.Totais;

  tot_bcicms_somada := RoundTo(tot_bcicms_somada,-2);

  if tot_bcicms_somada <> Totais.BaseCalculoICMS then begin
    diferenca := (tot_bcicms_somada - Totais.BaseCalculoICMS);
  end;

  nfe.NFe.Total.ICMSTot.vBC     := Totais.BaseCalculoICMS + diferenca;

  diferenca := 0;

  //gamb pra concertar arredondamento
  tot_icm_somado   := RoundTo(tot_icm_somado,-2);

  if tot_icm_somado <> Totais.ICMS then begin
    diferenca := (tot_icm_somado - Totais.ICMS);
  end;

  nfe.NFe.Total.ICMSTot.vICMS        := Totais.ICMS + diferenca;
  nfe.NFe.Total.ICMSTot.vBCST        := Totais.BaseCalculoST;
  nfe.NFe.Total.ICMSTot.vST          := Totais.ICMSST;

  nfe.NFe.Total.ICMSTot.vFCPUFDest   := 0;//Totais.ICMSFCP;
  nfe.NFe.Total.ICMSTot.vICMSUFDest  := 0;//Totais.ICMSUFDest;
  nfe.NFe.Total.ICMSTot.vICMSUFRemet := 0;//Totais.ICMSUFRemet;

  diferenca := 0;

  tot_produto_somado := RoundTo(tot_produto_somado,-2);

  if tot_produto_somado <> Totais.TotalProdutos then begin
    diferenca := (tot_produto_somado - Totais.TotalProdutos);
  end;

  nfe.NFe.Total.ICMSTot.vProd   := Totais.TotalProdutos + diferenca;

  diferenca := 0;

  tot_frete_somado := RoundTo(tot_frete_somado, -2);

  if tot_frete_somado <> Totais.Frete then begin
    diferenca := (tot_frete_somado - Totais.Frete);
  end;

  nfe.NFe.Total.ICMSTot.vFrete  := Totais.Frete + diferenca;
  nfe.NFe.Total.ICMSTot.vSeg    := Totais.Seguro;
  nfe.NFe.Total.ICMSTot.vDesc   := Totais.Descontos;
  nfe.NFe.Total.ICMSTot.vIPI    := Totais.IPI;
  nfe.NFe.Total.ICMSTot.vOutro  := Totais.OutrasDespesas;
  nfe.NFe.Total.ICMSTot.vNF     := Totais.TotalNF;
  nfe.NFe.Total.ICMSTot.vPIS    := Totais.PIS;
  nfe.NFe.Total.ICMSTot.vCOFINS := Totais.COFINS;
end;

procedure TGeradorNFe.GerarVolumes(NF :TNotaFiscal;  NFe: ACBrNFeNotasFiscais.NotaFiscal);
var
  Volume :TVolCollectionItem;
  VolumesNotaFiscal :TVolumesNotaFiscal;
begin
   if not Assigned(NF.Volumes) then exit;

   VolumesNotaFiscal := NF.Volumes;

   Volume := nfe.NFe.Transp.Vol.Add;

   Volume.qVol  := VolumesNotaFiscal.QuantidadeVolumes;
   Volume.esp   := VolumesNotaFiscal.Especie;
   Volume.pesoL := VolumesNotaFiscal.PesoLiquido;
   Volume.pesoB := VolumesNotaFiscal.PesoBruto;
end;

procedure TGeradorNFe.GerarXML(NotaFiscal: TNotaFiscal);
var
  XMLStream :TStringStream;
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'GerarXML(NotaFiscal: TNotaFiscal)', 'NotaFiscal');

   XMLStream := nil;

   try
     if      (NotaFiscal.Status = snfAutorizada) or (NotaFiscal.Status = snfRejeitada) then begin
       XMLStream := TStringStream.Create('');
       self.FACBrNFe.NotasFiscais.Items[0].GravarStream(XMLStream);
       NotaFiscal.NFe.AdicionarXML(XMLStream);
     end
     else if (NotaFiscal.Status = snfCancelada) then begin
       XMLStream := TStringStream.Create(self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMl);
       NotaFiscal.NFe.AdicionarXML(XMLStream);
     end;
  finally
    FreeAndNil(XMLStream);
  end;
end;

procedure TGeradorNFe.ImprimirComVisualizacao(NotaFiscal: TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ImprimirDireto(NotaFiscal :TNotaFiscal; const CaminhoDoLogo :String)', 'NotaFiscal');

   self.FACBrNFe.NotasFiscais.Clear;

   if (NotaFiscal.Status = snfAutorizada) then
     self.FACBrNFe.NotasFiscais.LoadFromString(NotaFiscal.NFe.XMLText)
   else
     self.GerarNFe(NotaFiscal);

   self.FACBrNFeDANFE.MostrarPreview := true;
   self.FACBrNFeDANFE.ImprimirDANFE();
end;

procedure TGeradorNFe.ImprimirDireto(NotaFiscal :TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ImprimirDireto(NotaFiscal :TNotaFiscal; const CaminhoDoLogo :String)', 'NotaFiscal');

   self.FACBrNFe.NotasFiscais.Clear;
   self.FACBrNFe.NotasFiscais.LoadFromString(NotaFiscal.NFe.XMLText);

   self.FACBrNFeDANFE.MostrarPreview := false;
   self.FACBrNFeDANFE.ImprimirDANFE();
end;

procedure TGeradorNFe.InicializaComponentes(const CaminhoLogo :String);
begin
   { ACBrNFe (Configurações do WebService) }
   self.FACBrNFe                                               := TACBrNFe.Create(nil); //Pode mudar isso aqui
   self.FACBrNFe.Configuracoes.WebServices.IntervaloTentativas := 4000;
   self.FACBrNFe.Configuracoes.WebServices.Tentativas          := 5;
   self.FACBrNFe.Configuracoes.WebServices.UF                  := 'PR';
   self.FACBrNFe.Configuracoes.WebServices.Visualizar          := false; // Mensagens

   self.FACBrNFe.Configuracoes.Geral.FormaEmissao              := teNormal;
   self.FACBrNFe.Configuracoes.Geral.ModeloDF                  := moNFe;
   self.FACBrNFe.Configuracoes.Geral.VersaoDF                  := ve310;
   self.FACBrNFe.Configuracoes.Geral.SSLLib                    := libCapicom;

   { DANFE (Configurações da Impressão do DANFE)}
   self.FACBrNFeDANFe                   := TACBrNFeDANFeRL.Create(nil);
   self.FACBrNFeDANFe.ACBrNFe           := self.FACBrNFe;
   self.FACBrNFeDANFe.ProdutosPorPagina := 30;

   if not CaminhoLogo.IsEmpty then
     self.FACBrNFeDANFE.Logo := CaminhoLogo;

  // self.FFatura := nil;
end;

function TGeradorNFe.ObterCertificado: String;
begin
   result := self.FACBrNFe.SSL.SelecionarCertificado;
end;

procedure TGeradorNFe.Recarregar;
var
  CaminhoLogo :String;
begin
   CaminhoLogo := self.FACBrNFeDANFE.Logo;
   
   self.FACBrNFeDANFE.ACBrNFe := nil;

   FreeAndNil(self.FACBrNFe);
   FreeAndNil(self.FACBrNFeDANFE);

   self.InicializaComponentes(CaminhoLogo);
end;

end.


