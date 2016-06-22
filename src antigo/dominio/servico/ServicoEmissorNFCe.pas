unit ServicoEmissorNFCe;

interface

uses
  Parametros,
  Venda,
  Empresa,
  ACBrNFeNotasFiscais,
  ACBrDANFCeFortesFr,
  ContNrs, DateTimeUtilitario, Classes, AcbrNfe,  pcnConversao, pcnNFe,
  pcnRetInutNFe, pcnRetConsSitNFe, pcnCCeNFe, ACBrNFeWebServices,
  pcnEventoNFe, pcnConversaoNFe,   pcnProcNFe, funcoes;

type
  TServicoEmissorNFCe = class

  private
    FACBrNFe :TACBrNFe;
    FACBrNFeDANFe :TACBrNFeDANFCeFortes;
    FParametros :TParametros;

  private
    procedure GerarNFCe(Venda :TVenda);
    procedure GerarIdentificacao(Configuracoes :TParametros;
                                 Venda :TVenda;
                                 NFCe :NotaFiscal);
    procedure GerarEmitente(Empresa :TEmpresa;
                            NFCe :NotaFiscal);
    procedure GerarDestinatario(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarDadosProdutos(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarValoresTotais(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarTransportador(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarPagamentos (Venda :TVenda; NFCe :NotaFiscal);

    procedure Salva_retorno_envio(codigo_pedido, numero_lote :integer);
    procedure Salva_retorno_cancelamento(Justificativa :String);
  public
    constructor Create(Configuracoes :TParametros);
    destructor Destroy; override;

  public
    procedure Emitir(Venda :TVenda; NumeroLote :Integer);
    procedure CancelarNFCe(XML: TStringStream; Justificativa :String);
end;

implementation

uses
  SysUtils, DateUtils,
  ParametrosNFCe,
  endereco,
  Item,
  Produto, Movimento,
  Token, EspecificacaoMovimentosPorCodigoPedido,
  ParametrosDANFE, NcmIBPT, ItemVenda, Dialogs, Repositorio, FabricaRepositorio, NFCe, uModulo, StrUtils, Math, EspecificacaoFiltraNFCe,
  Cliente, MaskUtils;

{ TServicoEmissorNFCe }

procedure TServicoEmissorNFCe.CancelarNFCe(XML: TStringStream; Justificativa :String);
var
  DhEvento  :TDateTime;
begin
   if (Justificativa = '') then
     Justificativa := 'CANCELAMENTO DE NF-E';

   self.FACBrNFe.NotasFiscais.Clear;
   self.FACBrNFe.NotasFiscais.LoadFromStream(XML);

   self.FACBrNFe.EventoNFe.Evento.Clear;

   with self.FACBrNFe.EventoNFe.Evento.Add do
    begin
      infEvento.chNFe           := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.chNFe;
      infEvento.CNPJ            := FACBrNFe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
      infEvento.dhEvento        := now;
      infEvento.tpEvento        := teCancelamento;
      infEvento.detEvento.xJust := Justificativa;
      infEvento.detEvento.nProt := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
    end;

   if self.FACBrNFe.EnviarEvento(1) then
      self.Salva_retorno_cancelamento( Justificativa );

end;

constructor TServicoEmissorNFCe.Create(Configuracoes: TParametros);
begin
   FParametros := Configuracoes;

   { ACBrNFe (Configurações do WebService) }
   FACBrNFe := TACBrNFe.Create(nil);
   FACBrNFe.Configuracoes.WebServices.IntervaloTentativas := Configuracoes.NFCe.IntervaloTentativas;
   FACBrNFe.Configuracoes.WebServices.Tentativas          := Configuracoes.NFCe.Tentativas;
   FACBrNFe.Configuracoes.WebServices.UF                  := Configuracoes.Empresa.estado;
   FACbrNFe.Configuracoes.WebServices.Ambiente            := TpcnTipoAmbiente( IfThen( copy(Configuracoes.NFCe.Ambiente,1,1) = 'P',0,1) );
   FACBrNFe.Configuracoes.WebServices.Visualizar          := false; // Mensagens
   FACBrNFe.Configuracoes.Geral.FormaEmissao              := TpcnTipoEmissao(Configuracoes.NFCe.FormaEmissao);
   FACBrNFe.Configuracoes.Geral.ModeloDF                  := moNFCe;
   FACBrNFe.Configuracoes.Geral.VersaoDF                  := TPcnVersaoDF(Configuracoes.NFCe.VersaoDF);
   FACBrNFe.Configuracoes.Geral.IncluirQRCodeXMLNFCe      := (FACbrNFe.Configuracoes.WebServices.Ambiente = taHomologacao);

   try
     FACBrNFe.Configuracoes.Geral.IdCSC := FParametros.NFCe.ID_TOKEN;
     FACBrNFe.Configuracoes.Geral.CSC   := FParametros.NFCe.TOKEN;
   except
   end;

   FACBrNFe.Configuracoes.Geral.Salvar := false;

   try
     FAcbrNfe.Configuracoes.Certificados.NumeroSerie := FParametros.NFCe.Certificado;
     FAcbrNfe.Configuracoes.Certificados.Senha       := FParametros.NFCe.Senha;
   except
   end;


   { DANFE (Configurações da Impressão do DANFE)}
   FACBrNFeDANFe                   := TACBrNFeDANFCeFortes.Create(nil);
   FACBrNFeDANFe.TipoDANFE         := tiNFCe;
   FACBrNFeDANFe.ACBrNFe           := self.FACBrNFe;
   FACBrNFeDANFe.MostrarPreview    := FParametros.NFCe.DANFE.VisualizarImpressao;
   FACBrNFeDANFe.ViaConsumidor     := FParametros.NFCe.DANFE.ViaConsumidor;
   FACBrNFeDANFe.ImprimirItens     := FParametros.NFCe.DANFE.ImprimirItens;
   // FACBrNFeDANFe.ImprimirDANFE;
   // FACBrNFeDANFe.ImprimirDANFEResumido();
   
   FACBrNFeDANFe.ProdutosPorPagina := 30;
   FACBrNFeDANFe.Sistema           := 'Smart Chef';

   {if not TStringUtilitario.EstaVazia(CaminhoLogo) then
     FACBrNFeDANFE.Logo := CaminhoLogo;}
end;

destructor TServicoEmissorNFCe.Destroy;
begin
   FreeAndNil(FACBrNFe);
   FParametros := nil;
   
   inherited;
end;

procedure TServicoEmissorNFCe.Emitir(Venda: TVenda; NumeroLote :Integer);
const
  IMPRIMIR = true;
  SINCRONO = true;
begin
  try
    GerarNFCe(Venda);

    try
      FACBrNFe.Enviar(NumeroLote, IMPRIMIR, SINCRONO);
    Except
      On E: Exception do begin
        dm.GetValorGenerator('gen_lote_nfce','-1');
        dm.GetValorGenerator('gen_nrnota_nfce','-1');
        raise Exception.Create(e.Message);
      end;
    end;

    Salva_retorno_envio(Venda.Codigo_pedido, NumeroLote);

  Except
    On E: Exception do begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TServicoEmissorNFCe.GerarDadosProdutos(Venda: TVenda;
  NFCe: NotaFiscal);
var
  nX :Integer;
  total_itens, percent_correspondente :Real;
begin
   //total_itens := ((Venda.Total + Venda.Desconto) - Venda.Tx_servico) - Venda.Couvert;

   for nX := 0 to (Venda.Itens.Count-1) do begin
    with NFCe.NFe.Det.Add do begin
      { Dados do Produto }
      Prod.nItem    := (nX+1);
      Prod.cProd    := IntToStr(Venda.Itens.Items[nX].Produto.codigo);
      Prod.cEAN     := '';//Venda.Itens.Items[nX].Produto.Codbar;
      Prod.xProd    := Venda.Itens.Items[nX].Produto.descricao;
      Prod.NCM      := Venda.Itens.Items[nX].Produto.NcmIBPT.ncm_ibpt;
      Prod.EXTIPI   := '';
      Prod.CFOP     := IfThen(Venda.Itens.Items[nX].Produto.tributacao = 'FF', '5405', '5102');
      Prod.uCom     := 'UN';//Venda.Itens.Items[nX].Produto.getUnidade;
      Prod.qCom     := Venda.Itens.Items[nX].Quantidade;
      Prod.vUnCom   := Venda.Itens.Items[nX].ValorUnitario;
      Prod.vProd    := Venda.Itens.Items[nX].Total;
      Prod.cEANTrib := '';//Venda.Itens.Items[nX].Produto.Codbar;
      Prod.uTrib    := 'UN';//Venda.Itens.Items[nX].Produto.getUnidade;
      Prod.qTrib    := Venda.Itens.Items[nX].Quantidade;
      Prod.vUnTrib  := Venda.Itens.Items[nX].ValorUnitario;
      Prod.vOutro   := 0;
      Prod.vFrete   := 0;
      Prod.vSeg     := 0;

      if Venda.Desconto > 0 then begin
        percent_correspondente := (Venda.Itens.Items[nX].Total * 100) / Venda.Total;

        Prod.vDesc    := (percent_correspondente * Venda.Desconto)/100;
      end
      else
        Prod.vDesc    := 0;

      { Imposto }
      with Imposto do begin

        { ICMS }
        vTotTrib := Venda.Itens.Items[nX].ValorImpostos;

        with ICMS do begin
           with ICMS do begin
           
              if Venda.Itens.Items[nX].Produto.tributacao = 'FF' then
                CSOSN        := csosn500
              else
                CSOSN        := csosn102;

              ICMS.orig    := oeNacional;
              ICMS.modBC   := dbiValorOperacao;
              ICMS.vBC     := 0;//Venda.Itens[nX].CST00.Base;
              ICMS.pICMS   := 0;//Venda.Itens[nX].CST00.Aliquota;
              ICMS.vICMS   := 0;//Venda.Itens[nX].CST00.Valor;
              ICMS.modBCST := dbisMargemValorAgregado;
              ICMS.pMVAST  := 0;
              ICMS.pRedBCST:= 0;
              ICMS.vBCST   := 0;
              ICMS.pICMSST := 0;
              ICMS.vICMSST := 0;
              ICMS.pRedBC  := 0;
           end;
        end;

     end; //with do imposto

    end;
   end;

end;

procedure TServicoEmissorNFCe.GerarDestinatario(Venda :TVenda; NFCe: NotaFiscal);
var endereco :TEndereco;
    repositorio :TRepositorio;
begin
  try
   endereco    := nil;
   repositorio := nil;

   NFCe.NFe.Dest.xNome             := IfThen((Venda.Cpf_cliente = '')or(length(Venda.Cpf_cliente)<10), 'CONSUMIDOR', Venda.nome_cliente);
   NFCe.NFe.Dest.CNPJCPF           := IfThen( not (length(Venda.Cpf_cliente) in [11,14]), '', Venda.Cpf_cliente);
   NFCe.NFe.Dest.indIEDest         := inNaoContribuinte;

   if assigned(Venda.Cliente) and
      ((assigned(Venda.Cliente.Enderecos) and (Venda.Cliente.Enderecos.count > 0)) or (venda.Codigo_endereco > 0)) then begin

     if venda.Codigo_endereco > 0 then begin
       repositorio := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
       endereco := TEndereco( repositorio.Get( venda.Codigo_endereco ) );
     end
     else
       endereco := TEndereco(Venda.Cliente.Enderecos.Items[0]);

     NFCe.NFe.Dest.EnderDest.xLgr    := endereco.logradouro;
     NFCe.NFe.Dest.EnderDest.nro     := endereco.numero;
     NFCe.NFe.Dest.EnderDest.xCpl    := endereco.referencia;
     NFCe.NFe.Dest.EnderDest.xBairro := endereco.bairro;
     NFCe.NFe.Dest.EnderDest.cMun    := endereco.codigo_cidade;
     NFCe.NFe.Dest.EnderDest.xMun    := endereco.cidade;
     NFCe.NFe.Dest.EnderDest.UF      := endereco.uf;
     NFCe.NFe.Dest.EnderDest.CEP     := StrToIntDef(endereco.cep,0);
     NFCe.NFe.Dest.EnderDest.cPais   := 1058;
     NFCe.NFe.Dest.EnderDest.xPais   := 'Brasil';
     NFCe.NFe.Dest.EnderDest.fone    := endereco.fone;
   end;

  finally
    FreeAndNil(repositorio);
    FreeAndNil(endereco);
  end;
end;

procedure TServicoEmissorNFCe.GerarEmitente(Empresa: TEmpresa; NFCe: NotaFiscal);
begin
   NFCe.NFe.Emit.CNPJCPF := Empresa.Cnpj;
   NFCe.NFe.Emit.IE      := Empresa.IE;
   NFCe.NFe.Emit.xNome   := Empresa.Razao_social;
   NFCe.NFe.Emit.xFant   := Empresa.Nome_Fantasia;

   { Endereco }
   NFCe.NFe.Emit.EnderEmit.fone    := Empresa.Telefone;
   NFCe.NFe.Emit.EnderEmit.CEP     := Empresa.Cep;
   NFCe.NFe.Emit.EnderEmit.xLgr    := Empresa.rua;
   NFCe.NFe.Emit.EnderEmit.nro     := Empresa.numero;
   NFCe.NFe.Emit.EnderEmit.xCpl    := Empresa.complemento;
   NFCe.NFe.Emit.EnderEmit.xBairro := Empresa.bairro;
   NFCe.NFe.Emit.EnderEmit.cMun    := Empresa.cod_municipio;
   NFCe.NFe.Emit.EnderEmit.xMun    := Empresa.cidade;
   NFCe.NFe.Emit.EnderEmit.UF      := Empresa.estado;
   NFCe.NFe.Emit.EnderEmit.cPais   := 1058;
   NFCe.NFe.Emit.EnderEmit.xPais   := 'BRASIL';

   NFCe.NFe.Emit.CRT := TpcnCRT(Empresa.Regime); // VERIFICAR SE PEGA CORRETO, SE VERIFICAR PAGAR TODOS ESSE COMENTARIOS crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
end;

procedure TServicoEmissorNFCe.GerarIdentificacao(
  Configuracoes: TParametros; Venda: TVenda; NFCe: NotaFiscal);
begin
   NFCe.NFe.Ide.cNF      := Venda.NumeroNFe;
   NFCe.NFe.Ide.natOp    := 'VENDA';
   NFCe.NFe.Ide.indPag   := ipVista;
   NFCe.NFe.Ide.modelo   := 65;
   NFCe.NFe.Ide.serie    := 1;
   NFCe.NFe.Ide.nNF      := Venda.NumeroNFe;
   NFCe.NFe.Ide.dEmi     := Now;
   NFCe.NFe.Ide.dSaiEnt  := Now;
   NFCe.NFe.Ide.hSaiEnt  := Now;
   NFCe.NFe.Ide.tpNF     := tnSaida;
   NFCe.NFe.Ide.tpEmis   := teNormal; //TpcnTipoEmissao(Configuracoes.NFCe.FormaEmissao); SEGUNDA_CONFIGURACAO
   NFCe.NFe.Ide.tpAmb    := TpcnTipoAmbiente( IfThen( copy(Configuracoes.NFCe.Ambiente,1,1) = 'P',0,1) );
   NFCe.NFe.Ide.cUF      := UF_TO_CODUF(Configuracoes.Empresa.estado);
   NFCe.NFe.Ide.cMunFG   := Configuracoes.Empresa.cod_municipio;
   NFCe.NFe.Ide.finNFe   := fnNormal;
   NFCe.NFe.Ide.tpImp    := tiNFCe;
   NFCe.NFe.Ide.indFinal := cfConsumidorFinal;
   NFCe.NFe.Ide.indPres  := pcPresencial;
end;

procedure TServicoEmissorNFCe.GerarNFCe(Venda: TVenda);
var
  NFCe :ACBrNFeNotasFiscais.NotaFiscal;
begin
   FACBrNFe.NotasFiscais.Clear;
   NFCe := FACBrNFe.NotasFiscais.Add;

   GerarIdentificacao  (FParametros, Venda, NFCe);
   GerarEmitente       (FParametros.Empresa, NFCe);
   GerarDestinatario   (Venda, NFCe);
   GerarDadosProdutos  (Venda, NFCe);
   GerarValoresTotais  (Venda, NFCe);
   GerarTransportador  (Venda, NFCe);
   GerarPagamentos     (Venda, NFCe);
end;

procedure TServicoEmissorNFCe.GerarPagamentos(Venda: TVenda; NFCe: NotaFiscal);
var Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
    repositorio   :TREpositorio;
    Movimentos    :TObjectList;
    i             :integer;
    descontou_tx  :boolean;
    descontou_servicos :Boolean;
begin
   Especificacao := nil;
   repositorio   := nil;
   Movimentos    := nil;
   descontou_tx  := false;
   descontou_servicos := false;
  try
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create(Venda.Codigo_pedido);
    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Movimentos    := repositorio.GetListaPorEspecificacao( Especificacao, 'codigo_pedido = '+inttostr(Venda.Codigo_pedido));

    if (Venda.Couvert + Venda.Tx_servico + Venda.Taxa_entrega) <= 0 then
      descontou_tx := true;

   for i := 0 to Movimentos.Count -1 do begin
     with NFCe.NFe.pag.Add do begin

       case TMovimento(Movimentos[i]).tipo_moeda of
         1 :  tPag := fpDinheiro;
         2 :  tPag := fpCheque;
         3 :  tPag := fpCartaoCredito;
         4 :  tPag := fpCartaoDebito;
       end;

       //if tPag in [fpCartaoCredito, fpCartaoDebito] then
         tpIntegra := tiNaoInformado;

       vPag := TMovimento(Movimentos[i]).valor_pago;

       if not descontou_tx and (vPag >= (Venda.Couvert + Venda.Tx_servico + Venda.Taxa_entrega)) then begin
         vPag         := vPag - (Venda.Couvert + Venda.Tx_servico + Venda.Taxa_entrega);
         descontou_tx := true;
       end;

       if not descontou_servicos and (vPag > Venda.Total_em_servicos) then begin
         vPag               := vPag - Venda.Total_em_servicos;
         descontou_servicos := true;
       end;
     end;
   end;

  Finally
    FreeAndNil(Especificacao);
    FreeAndNil(repositorio);
    FreeAndNil(Movimentos);
  end;
end;

procedure TServicoEmissorNFCe.GerarTransportador(Venda: TVenda;
  NFCe: NotaFiscal);
begin
   // NFC-e não pode ter frete
   NFCe.NFe.Transp.modFrete := mfSemFrete;
end;

procedure TServicoEmissorNFCe.GerarValoresTotais(Venda: TVenda;
  NFCe: NotaFiscal);
begin
   NFCe.NFe.Total.ICMSTot.vBC      := 0;
   NFCe.NFe.Total.ICMSTot.vICMS    := Venda.Icms;
   NFCe.NFe.Total.ICMSTot.vBCST    := Venda.BaseSt;
   NFCe.NFe.Total.ICMSTot.vST      := Venda.St;
   NFCe.NFe.Total.ICMSTot.vProd    := Venda.TotalBruto;
   NFCe.NFe.Total.ICMSTot.vFrete   := Venda.Frete;
   NFCe.NFe.Total.ICMSTot.vSeg     := Venda.Seguro;
   NFCe.NFe.Total.ICMSTot.vDesc    := Venda.Desconto;
   NFCe.NFe.Total.ICMSTot.vII      := 0; //Venda.ImpostoImportacao;
   NFCe.NFe.Total.ICMSTot.vIPI     := 0; //Venda.Ipi;
   NFCe.NFe.Total.ICMSTot.vPIS     := Venda.Pis;
   NFCe.NFe.Total.ICMSTot.vCOFINS  := Venda.Cofins;
   NFCe.NFe.Total.ICMSTot.vOutro   := 0; //Venda.OutrasDespesas;
   NFCe.NFe.Total.ICMSTot.vNF      := Venda.Total - Venda.Desconto;
   NFCe.NFe.Total.ICMSTot.vTotTrib := Venda.TotalTributos;
end;

procedure TServicoEmissorNFCe.Salva_retorno_cancelamento(Justificativa :String);
var  StringStream :TStringStream;
     repositorio  :TRepositorio;
     Especificacao :TEspecificacaoFiltraNFCe;
     NFCe          :TNFCe;
begin
    NFCe := nil;
    Especificacao := nil;
    repositorio   := nil;
  try
  try

    repositorio   := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
    Especificacao := TEspecificacaoFiltraNFCe.Create(Date, Date, FACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF);
    NFCe          := TNFCe( repositorio.GetPorEspecificacao( Especificacao ) );

    StringStream := TStringStream.Create( UTF8Encode(self.FACBrNFe.WebServices.EnvEvento.RetWS) );

    NFCe.XML.LoadFromStream(StringStream);

    if self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
      raise Exception.Create('Falha ao enviar.'+#13#10+self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

    NFCe.status         := IntToStr( self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat );
    NFCe.Motivo         := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;//'Cancelamento da NFC-e homologado';
    NFCe.protocolo      := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
    NFCe.dh_recebimento := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento;
    NFCe.justificativa  := Justificativa;

    repositorio.Salvar( NFCe );

  Except
    On E: Exception do begin
      raise Exception.Create(e.Message);
    end;
  end;

  Finally
    freeAndNil(repositorio);
    freeAndNil(Especificacao);
    freeAndNil(NFCe);
  end;
end;

procedure TServicoEmissorNFCe.Salva_retorno_envio(codigo_pedido, numero_lote: integer);
var NFCe :TNFCe;
    repositorio :TRepositorio;
    StringStream: TStringStream;
begin
  NFCe        := nil;
  repositorio := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TNFCE.ClassName);
    NFCe        := TNFCE.Create;

    NFCe.nr_nota        := FACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF;
    NFCe.codigo_pedido  := codigo_pedido;
    NFCe.serie          := IntToStr(FACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie);
    NFCe.chave          := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.chNFe;
    NFCe.protocolo      := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
    NFCe.dh_recebimento := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.dhRecbto;
    NFCe.status         := intToStr( FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.cStat );
    NFCe.motivo         := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo;

    StringStream := TStringStream.Create( FACBrNFe.NotasFiscais.Items[0].XML );

    NFCe.XML.LoadFromStream(StringStream);
    
    repositorio.Salvar( NFCe );

  Except
    On E: Exception do begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

end.
