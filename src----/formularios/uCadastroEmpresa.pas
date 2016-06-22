unit uCadastroEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, ExtCtrls, ToolEdit, CurrEdit, Mask,
  FocusMaskEdit, frameMaskCpfCnpj, StdCtrls, DB, DBClient, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, contnrs, ImgList, pngimage, FileCtrl;

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
    MaskCpfCnpj1: TMaskCpfCnpj;
    edtInscricao: TEdit;
    edtSite: TEdit;
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
    edtCidade: TEdit;
    Label15: TLabel;
    cmbUF: TComboBox;
    Label16: TLabel;
    edtCep: TMaskEdit;
    Label17: TLabel;
    edtRua: TEdit;
    Label18: TLabel;
    edtNumero: TEdit;
    Label19: TLabel;
    edtBairro: TEdit;
    lbbairro: TLabel;
    edtCodigoCidade: TCurrencyEdit;
    Label20: TLabel;
    edtComplemento: TEdit;
    lbcomp: TLabel;
    procedure edtInscricaoKeyPress(Sender: TObject; var Key: Char);
    procedure rgDiaCouvertClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
    procedure btnBolicheClick(Sender: TObject);
    procedure btnDispensadoraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  uModulo;

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
  self.cdsRAZAO.AsString    := Empresa.Razao_social;
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

     Empresa.Razao_social       := self.edtRazao.Text;
     Empresa.Nome_Fantasia      := self.edtFantasia.Text;
     Empresa.Cnpj               := MaskCpfCnpj1.edtCpf.Text;
     Empresa.IE                 := edtInscricao.Text;
     Empresa.Telefone           := edtFone.Text;
     Empresa.Site               := edtSite.Text;
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
     empresa.Cidade                 := edtCidade.Text;
     Empresa.Estado                 := cmbUF.Items[cmbUF.itemIndex];
     Empresa.CEP                    := StrToInt(edtCep.Text);
     Empresa.RUA                    := edtRua.Text;
     Empresa.numero                 := edtNumero.Text;
     Empresa.bairro                 := edtBairro.Text;
     Empresa.complemento            := edtComplemento.Text;

     Repositorio.Salvar(Empresa);

     if self.EstadoTela = tetIncluir then
       Empresa.codigo := 0;

     if (dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       Repositorio.Salvar_2(Empresa);
     
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
  self.cdsRAZAO.AsString     := Empresa.Razao_social;
  self.cds.Post;
end;

procedure TfrmCadastroEmpresa.LimparDados;
begin
  inherited;
  edtRazao.Clear;
  edtFantasia.Clear;
  MaskCpfCnpj1.setPadrao;
  edtInscricao.Clear;
  edtFone.Clear;
  edtSite.Clear;
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
  edtCodigoCidade.Clear;
  edtRua.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  edtcep.Clear;
  edtComplemento.Clear;
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
    self.edtRazao.Text                := Empresa.Razao_social;
    self.edtFantasia.Text             := Empresa.Nome_Fantasia;
    self.MaskCpfCnpj1.edtCpf.Text     := Empresa.Cnpj;
    self.edtInscricao.Text            := Empresa.IE;
    self.edtFone.Text                 := Empresa.Telefone;
    self.edtSite.Text                 := Empresa.Site;
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
    self.edtCidade.Text              := Empresa.Cidade;
    self.cmbUF.ItemIndex             := self.cmbUF.Items.IndexOf(Empresa.Estado);
    self.edtCodigoCidade.AsInteger   := Empresa.cod_municipio;
    self.edtRua.Text                 := Empresa.rua;
    self.edtNumero.Text              := Empresa.numero;
    self.edtBairro.Text              := Empresa.bairro;
    self.edtCep.Text                 := IntToStr(Empresa.cep);
    self.edtComplemento.Text         := Empresa.complemento;

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
  MaskCpfCnpj1.pessoa := 'J';
end;

end.
