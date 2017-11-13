unit uCadastroEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, ExtCtrls, RXToolEdit, RXCurrEdit, Mask,
  frameMaskCpfCnpj, StdCtrls, DB, DBClient, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, contnrs, ImgList, pngimage, FileCtrl, frameBuscaCidade, RxDBCurrEdit;

type
  TfrmCadastroEmpresa = class(TfrmCadastroPadrao)
    edtCodigo: TEdit;
    cdsCODIGO: TIntegerField;
    cdsRAZAO: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtRazao: TEdit;
    edtFantasia: TEdit;
    CpfCnpj: TMaskCpfCnpj;
    edtInscricao: TEdit;
    edtEmail: TEdit;
    edtFone: TMaskEdit;
    TabSheet1: TTabSheet;
    pnlPadroes: TPanel;
    Shape1: TShape;
    grpPadroes: TGroupBox;
    Label7: TLabel;
    edtQuantidadeMesas: TCurrencyEdit;
    gbTaxa: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    edtTaxaServico: TCurrencyEdit;
    rgDiaCouvert: TRadioGroup;
    gbDiaCouvert: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    edtValorCouvert: TCurrencyEdit;
    GroupBox1: TGroupBox;
    edtCaminhoBoliche: TEdit;
    GroupBox2: TGroupBox;
    edtCaminhoDispensadora: TEdit;
    btnBoliche: TBitBtn;
    btnDispensadora: TBitBtn;
    gbAliquotas: TGroupBox;
    edtAliqCouvert: TCurrencyEdit;
    edtAliqTxServico: TCurrencyEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    cbTributacaoTxServico: TComboBox;
    Label11: TLabel;
    cbTributacaoCouvert: TComboBox;
    Shape3: TShape;
    edtCep: TMaskEdit;
    Label17: TLabel;
    edtRua: TEdit;
    Label18: TLabel;
    edtNumero: TEdit;
    Label19: TLabel;
    edtBairro: TEdit;
    lbbairro: TLabel;
    edtComplemento: TEdit;
    lbcomp: TLabel;
    BuscaCidade1: TBuscaCidade;
    edtCodEndereco: TCurrencyEdit;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    gpbAliquotas: TGroupBox;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edtCreditoSN: TDBCurrencyEdit;
    edtIcms: TDBCurrencyEdit;
    edtCofins: TDBCurrencyEdit;
    edtPis: TDBCurrencyEdit;
    rgpRegime: TRadioGroup;
    memoObsGeradaSistema: TMemo;
    BitBtn1: TBitBtn;
    edtSequenciaNF: TEdit;
    GroupBox3: TGroupBox;
    cmbAmbiente: TComboBox;
    Label30: TLabel;
    Label15: TLabel;
    cmbTipoEmissao: TComboBox;
    TabSheet4: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtHost: TEdit;
    edtPort: TCurrencyEdit;
    edtUser: TEdit;
    edtPassword: TEdit;
    edtAssunto: TEdit;
    memoMensagem: TMemo;
    procedure edtInscricaoKeyPress(Sender: TObject; var Key: Char);
    procedure rgDiaCouvertClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
    procedure btnBolicheClick(Sender: TObject);
    procedure btnDispensadoraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCreditoSNChange(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;

  private
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;
  end;

var
  frmCadastroEmpresa: TfrmCadastroEmpresa;

implementation

uses Empresa, repositorio, fabricarepositorio, Math, uPadrao, StrUtils,
  uModulo, Endereco;

{$R *.dfm}

{ TfrmCadastroEmpresa }

procedure TfrmCadastroEmpresa.AlterarRegistroNoCDS(Registro: TObject);
var
  Empresa :TEmpresa;
begin
  inherited;

  Empresa := (Registro as TEmpresa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger  := Empresa.codigo;
  self.cdsRAZAO.AsString    := Empresa.Razao;
  self.cds.Post;
end;

procedure TfrmCadastroEmpresa.CarregarDados;
var
  Empresas    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Empresas    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresas    := Repositorio.GetAll;

    if Assigned(Empresas) and (Empresas.Count > 0) then begin

       for nX := 0 to (Empresas.Count-1) do
         self.IncluirRegistroNoCDS(Empresas.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Empresas);
  end;
end;

procedure TfrmCadastroEmpresa.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
  pnlPadroes.Enabled := true;
end;

procedure TfrmCadastroEmpresa.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
  pnlPadroes.Enabled := true;  
end;

function TfrmCadastroEmpresa.GravarDados: TObject;
var
  Empresa      :TEmpresa;
  Repositorio  :TRepositorio;
begin
   Empresa      := nil;
   Repositorio  := nil;

   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
     Empresa       := TEmpresa(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Empresa) then
      Empresa := TEmpresa.Create;

     Empresa.Razao              := self.edtRazao.Text;
     Empresa.NomeFantasia       := edtFantasia.Text;
     Empresa.CPF_CNPJ           := CpfCnpj.edtCpf.Text;
     Empresa.RG_IE              := edtInscricao.Text;
     Empresa.Fone1              := edtFone.Text;
     Empresa.Email              := edtEmail.Text;
     Empresa.Fone1              := edtFone.Text;
     Empresa.Quantidade_mesas   := edtQuantidadeMesas.AsInteger;
     //Empresa.Couvert            := (rgDiaCouvert.ItemIndex = 0);
     //Empresa.Valor_couvert      := edtValorCouvert.Value;
    // Empresa.Taxa_servico       := edtTaxaServico.Value;
     Empresa.Aliquota_couvert   := edtAliqCouvert.Value;
     Empresa.Aliquota_TxServico := edtAliqTxServico.Value;

     case cbTributacaoCouvert.ItemIndex of
       0 : Empresa.TRIBUTACAO_COUVERT := IfThen(cbTributacaoCouvert.ItemIndex = 0,'S');
       1 : Empresa.TRIBUTACAO_COUVERT := IfThen(cbTributacaoCouvert.ItemIndex = 1,'SI');
       2 : Empresa.TRIBUTACAO_COUVERT := IfThen(cbTributacaoCouvert.ItemIndex = 2,'SN');
       3 : Empresa.TRIBUTACAO_COUVERT := IfThen(cbTributacaoCouvert.ItemIndex = 3,'SF');
     end;

     case cbTributacaoTxServico.ItemIndex of
       0 : Empresa.TRIBUTACAO_TXSERVICO := IfThen(cbTributacaoTxServico.ItemIndex = 0,'S');
       1 : Empresa.TRIBUTACAO_TXSERVICO := IfThen(cbTributacaoTxServico.ItemIndex = 1,'SI');
       2 : Empresa.TRIBUTACAO_TXSERVICO := IfThen(cbTributacaoTxServico.ItemIndex = 2,'SN');
       3 : Empresa.TRIBUTACAO_TXSERVICO := IfThen(cbTributacaoTxServico.ItemIndex = 3,'SF');
     end;

     Empresa.diretorio_boliche      := edtCaminhoBoliche.Text;
     Empresa.diretorio_dispensadora := edtCaminhoDispensadora.Text;


     { * * * SALVA ENDEREÇO * * * }
     if Assigned(Empresa.Enderecos) and (Empresa.Enderecos.Count = 0) then
         Empresa.Enderecos.Add(TEndereco.Create);

     Empresa.Enderecos[0].codigo         := edtCodEndereco.AsInteger;
     Empresa.Enderecos[0].codigo_pessoa  := strToInt(edtCodigo.Text);
     Empresa.Enderecos[0].cep            := edtCep.text;
     Empresa.Enderecos[0].logradouro     := edtRua.text;
     Empresa.Enderecos[0].numero         := edtNumero.text;
     Empresa.Enderecos[0].referencia     := edtComplemento.text;
     Empresa.Enderecos[0].bairro         := edtBairro.text;
     Empresa.Enderecos[0].codigo_cidade  := BuscaCidade1.edtCodCid.AsInteger;
     Empresa.Enderecos[0].uf             := BuscaCidade1.edtUF.Text;
     Empresa.Enderecos[0].fone           := edtFone.Text;

     { Configurações NF }
     try
       Empresa.AdicionarConfiguracoesNFe(edtCreditoSN.Value, edtIcms.Value,
                                         edtPis.Value, edtCofins.Value,
                                         '', cmbAmbiente.Items[cmbAmbiente.ItemIndex][1],
                                         '',
                                         StrToInt(copy(cmbTipoEmissao.Items[cmbTipoEmissao.ItemIndex],1,1)),
                                         rgpRegime.ItemIndex,
                                         memoObsGeradaSistema.Text, StrToIntDef(edtSequenciaNF.Text,0));

     except
       on E: Exception do begin
          if (Pos('AmbienteNFe', e.Message) > 0) then begin
            self.cmbAmbiente.SetFocus;
            raise Exception.Create('Ambiente é um campo obrigatório!');
          end;
       end;
     end;

     { Configurações E-mail }
     Empresa.AdicionarConfiguracoesEmail(self.edtHost.Text,
                                         self.edtPort.Text,
                                         self.edtUser.Text,
                                         self.edtPassword.Text,
                                         self.edtAssunto.Text,
                                         self.memoMensagem.Text);

     Repositorio.Salvar(Empresa);

     if self.EstadoTela = tetIncluir then
       Empresa.codigo := 0;

   //  if (dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
   //    Repositorio.Salvar_2(Empresa);
     
     result := Empresa;
     
     dm.Empresa.Free;
     dm.Empresa := nil;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroEmpresa.IncluirRegistroNoCDS(Registro: TObject);
var
  Empresa :TEmpresa;
begin
  inherited;

  Empresa := (Registro as TEmpresa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := Empresa.codigo;
  self.cdsRAZAO.AsString     := Empresa.Razao;
  self.cds.Post;
end;

procedure TfrmCadastroEmpresa.LimparDados;
begin
  inherited;
  edtRazao.Clear;
  edtFantasia.Clear;
  CpfCnpj.Limpa;
  edtInscricao.Clear;
  edtFone.Clear;
  edtEmail.Clear;
  edtQuantidadeMesas.Clear;
  rgDiaCouvert.ItemIndex := -1;
  edtValorCouvert.Clear;
  edtTaxaServico.Clear;
  edtAliqCouvert.Clear;
  edtAliqTxServico.Clear;
  cbTributacaoCouvert.ItemIndex := -1;
  cbTributacaoTxServico.ItemIndex := -1;
  edtCaminhoBoliche.Clear;
  edtCaminhoDispensadora.Clear;
  BuscaCidade1.limpa;
  edtRua.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  edtcep.Clear;
  edtComplemento.Clear;
  edtCreditoSN.Clear;
  edtIcms.Clear;
  edtPis.Clear;
  edtCofins.Clear;
  memoObsGeradaSistema.Clear;
end;

procedure TfrmCadastroEmpresa.MostrarDados;
var
  Empresa      :TEmpresa;
  Repositorio  :TRepositorio;
begin
  inherited;

  Empresa      := nil;
  Repositorio  := nil;

  try
    Repositorio  := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa      := TEmpresa(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Empresa) then exit;

    self.edtCodigo.Text               := IntToStr(Empresa.codigo);
    self.edtRazao.Text                := Empresa.Razao;
    self.edtFantasia.Text             := Empresa.NomeFantasia;
    self.CpfCnpj.cpfCnpj              := Empresa.CPF_CNPJ;
    self.edtInscricao.Text            := Empresa.RG_IE;
    self.edtFone.Text                 := Empresa.Fone1;
    self.edtEmail.Text                := Empresa.Email;
    self.edtQuantidadeMesas.asInteger := Empresa.Quantidade_mesas;
//    self.rgDiaCouvert.ItemIndex       := IfThen(Empresa.Couvert, 0, 1);
    self.edtAliqCouvert.Value         := Empresa.Aliquota_couvert;
    //self.edtValorCouvert.Value      := Empresa.Valor_couvert;
    //self.edtTaxaServico.Valu        :=
    self.edtAliqTxServico.Value       := Empresa.Aliquota_TxServico;

    case AnsiIndexStr(UpperCase(Empresa.TRIBUTACAO_COUVERT), ['S','SI','SN','SF']) of
     0 : cbTributacaoCouvert.ItemIndex := 0;
     1 : cbTributacaoCouvert.ItemIndex := 1;
     2 : cbTributacaoCouvert.ItemIndex := 2;
     3 : cbTributacaoCouvert.ItemIndex := 3;
    end;

    case AnsiIndexStr(UpperCase(Empresa.TRIBUTACAO_TXSERVICO), ['S','SI','SN','SF']) of
     0 : cbTributacaoTxServico.ItemIndex := 0;
     1 : cbTributacaoTxServico.ItemIndex := 1;
     2 : cbTributacaoTxServico.ItemIndex := 2;
     3 : cbTributacaoTxServico.ItemIndex := 3;
    end;

    self.edtCaminhoBoliche.Text      := Empresa.diretorio_boliche;
    self.edtCaminhoDispensadora.Text := Empresa.diretorio_dispensadora;

    { * * * CARREGA ENDEREÇO * * * }
    edtCodEndereco.AsInteger := Empresa.Enderecos.Items[0].codigo;
    edtCep.Text              := Empresa.Enderecos.Items[0].cep;
    edtRua.Text              := Empresa.Enderecos.Items[0].logradouro;
    edtBairro.Text           := Empresa.Enderecos.Items[0].bairro;
    edtNumero.Text           := Empresa.Enderecos.Items[0].numero;
    edtComplemento.Text      := Empresa.Enderecos.Items[0].referencia;
    BuscaCidade1.CodigoMunicipio := Empresa.Enderecos.Items[0].codigo_cidade;
    edtFone.Text             := Empresa.Enderecos.Items[0].fone;

    if Assigned(Empresa.ConfiguracoesNF) then
    begin
      self.rgpRegime.ItemIndex    := Empresa.ConfiguracoesNF.CRT;

      if (Empresa.ConfiguracoesNF.ambiente_nfe = 'P') then
        self.cmbAmbiente.ItemIndex := 0
      else
        self.cmbAmbiente.ItemIndex := 1;

      self.cmbTipoEmissao.ItemIndex := IfThen(Empresa.ConfiguracoesNF.Tipo_emissao = 1, 0, 1);

      self.edtCreditoSN.Value   := Empresa.ConfiguracoesNF.aliq_cred_sn;
      self.edtIcms.Value        := Empresa.ConfiguracoesNF.aliq_icms;
      self.edtPis.Value         := Empresa.ConfiguracoesNF.aliq_pis;
      self.edtCofins.Value      := Empresa.ConfiguracoesNF.aliq_cofins;
      memoObsGeradaSistema.Text := Empresa.ConfiguracoesNF.ObsGeradaPeloSistema;
      self.edtSequenciaNF.Text  := IntToStr(Empresa.ConfiguracoesNF.SequenciaNotaFiscal);
    end;

    { Configurações de E-mail }
    if Assigned(Empresa.ConfiguracoesEmail) then begin
       self.edtHost.Text          := Empresa.ConfiguracoesEmail.smtp_host;
       self.edtPort.Text          := Empresa.ConfiguracoesEmail.smtp_port;
       self.edtUser.Text          := Empresa.ConfiguracoesEmail.smtp_user;
       self.edtPassword.Text      := Empresa.ConfiguracoesEmail.smtp_password;
       self.edtAssunto.Text       := Empresa.ConfiguracoesEmail.Assunto;
       self.memoMensagem.Text     := Empresa.ConfiguracoesEmail.mensagem.Text;
    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Empresa);
  end;
end;

function TfrmCadastroEmpresa.VerificaDados: Boolean;
begin
  result := false;

  if edtQuantidadeMesas.AsInteger <= 0 then begin
    avisar('O número de mesas do estabelecimento deve ser informado');
    edtQuantidadeMesas.SetFocus;
  end
 { else if rgDiaCouvert.ItemIndex < 0 then begin
    avisar('Favor informar se há ou não couvert artístico');
    rgDiaCouvert.SetFocus;
  end
  else if (rgDiaCouvert.ItemIndex = 0) and (edtValorCouvert.Value <= 0) then begin
    avisar('Como há couvert, o valor do mesmo deve ser informado');
    edtValorCouvert.SetFocus;
  end}
 { else if (edtValorCouvert.Value > 0) and (cbTributacaoCouvert.ItemIndex < 0) then begin
    avisar('Como há couvert, o tipo de tributação deve ser informado');
    cbTributacaoCouvert.SetFocus;
  end  }
  else if (UPPERCASE(cbTributacaoCouvert.Items[cbTributacaoCouvert.itemIndex]) = 'TRIBUTADO') and (edtAliqCouvert.Value <= 0) then begin
    avisar('Como o serviço é tributado, a alíquota deve ser informada');
    edtAliqCouvert.SetFocus;
  end
  {else if (edtTaxaServico.Value > 0) and (cbTributacaoCouvert.ItemIndex < 0) then begin
    avisar('Como há taxa de serviço, o tipo de tributação deve ser informado');
    cbTributacaoTxServico.SetFocus;
  end  }
  else if (UPPERCASE(cbTributacaoTxServico.Items[cbTributacaoTxServico.itemIndex]) = 'TRIBUTADO') and (edtAliqTxServico.Value <= 0) then begin
    avisar('Como o serviço é tributado, a alíquota deve ser informada');
    edtAliqTxServico.SetFocus;
  end
  {else if (edtCaminhoBoliche.Text = '') then begin
    avisar('Favor informar o diretório, para leitura dos arquivos, referente as contas das pistas de boliche');
    edtCaminhoBoliche.SetFocus;
  end
  else if (edtCaminhoDispensadora.Text = '') then begin
    avisar('Favor informar o diretório, para o envio dos dos arquivos de controle da dispensadora de comandas');
    edtCaminhoDispensadora.SetFocus;
  end   }
  else
    result := true;
end;

procedure TfrmCadastroEmpresa.edtCreditoSNChange(Sender: TObject);
begin
  memoObsGeradaSistema.Text :=
  'DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL NAO GERA DIREITO A CREDITO FISCAL DE IPI. '                     +
  'PERMITE O APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE '+ FormatFloat('R$ ,0.00;R$ -,0.00', self.edtCreditoSN.Value)+' '+
  'CORRESPONDENTE A ALÍQUOTA DE '+FormatFloat('#0.00%', self.edtCreditoSN.Value)+', NOS TERMOS DO ART.23 DA '            +
  'LC 123/2006 VLR. DO ICMS DESTACADO EM S/NF = '+FormatFloat('R$ ,0.00;R$ -,0.00', self.edtCreditoSN.Value);
end;

procedure TfrmCadastroEmpresa.edtInscricaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroEmpresa.rgDiaCouvertClick(Sender: TObject);
begin
  inherited;
  if (rgDiaCouvert.ItemIndex = 0) and (pgGeral.ActivePageIndex = 2) and (pnlPadroes.Enabled) and (gbDiaCouvert.Enabled)then
    edtValorCouvert.SetFocus;
end;

procedure TfrmCadastroEmpresa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pnlPadroes.Enabled := false;
end;

procedure TfrmCadastroEmpresa.btnSalvarClick(Sender: TObject);
begin
  inherited;
  pnlPadroes.Enabled := false;
end;

procedure TfrmCadastroEmpresa.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.ActivePageIndex = 2 then begin
    gbAliquotas.Enabled   := not fdm.Caixa_esta_aberto;
    {rgDiaCouvert.Enabled := not fdm.Caixa_esta_aberto;
    gbDiaCouvert.Enabled := not fdm.Caixa_esta_aberto;
    gbTaxa.Enabled       := not fdm.Caixa_esta_aberto;}
    MostrarDados;
  end;
end;

procedure TfrmCadastroEmpresa.btnBolicheClick(Sender: TObject);
var
  Dir: string;
begin
   Dir := '';//'C:\';

   if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
     edtCaminhoBoliche.Text := Dir;

end;

procedure TfrmCadastroEmpresa.btnDispensadoraClick(Sender: TObject);
var
  Dir: string;
begin
   Dir := '';//'C:\';

   if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000) then
     edtCaminhoDispensadora.Text := Dir;
end;

procedure TfrmCadastroEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  CpfCnpj.pessoa := 'J';
end;

end.
