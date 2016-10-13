unit uConfiguraNFCe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, Spin, ACBrNFe, ContNrs;

type
  TfrmConfiguraNFCe = class(TfrmCadastroPadrao)
    cbxFormaEmissao: TComboBox;
    edtCertificado: TEdit;
    spnTentativas: TSpinEdit;
    Label7: TLabel;
    spnIntervalo: TSpinEdit;
    Label5: TLabel;
    btnSeleciona: TBitBtn;
    Label1: TLabel;
    edtSenhaCertificado: TEdit;
    lbsenha: TLabel;
    edtCodigoToken: TEdit;
    Label2: TLabel;
    edtToken: TEdit;
    Label3: TLabel;
    cbxVersaoDF: TComboBox;
    Label4: TLabel;
    Label6: TLabel;
    cdsCODIGO: TIntegerField;
    cdsTOKEN: TStringField;
    edtCodigo: TEdit;
    Shape1: TShape;
    rgpVisualizaImpressao: TRadioGroup;
    rgpViaConsumidor: TRadioGroup;
    rgpImprimeItens: TRadioGroup;
    Label8: TLabel;
    cbxAmbiente: TComboBox;
    procedure btnSelecionaClick(Sender: TObject);
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
    function indexFormaEmissao(formaEmissao :integer) :integer;
  end;

var
  frmConfiguraNFCe: TfrmConfiguraNFCe;

implementation

uses ACBrNFeConfiguracoes, ParametrosNFCe, repositorio, fabricarepositorio, Math,uPadrao,
  ACBrDFeConfiguracoes, ACBrDFe, ACBrDFeSSL;

{$R *.dfm}

procedure TfrmConfiguraNFCe.AlterarRegistroNoCDS(Registro: TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  inherited;

  ParametrosNFCe := (Registro as TParametrosNFCe);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger  := ParametrosNFCe.codigo;
  self.cdsTOKEN.AsString    := ParametrosNFCe.TOKEN;
  self.cds.Post;
end;

procedure TfrmConfiguraNFCe.btnSelecionaClick(Sender: TObject);
var ACBrNFe :TACBrNFe;
begin
  ACBrNFe             := TACBrNFe.Create(Self);
  edtCertificado.Text := ACBrNFe.SSL.SelecionarCertificado;

  if edtCertificado.Text <> '' then
    edtSenhaCertificado.SetFocus;
end;

procedure TfrmConfiguraNFCe.CarregarDados;
var
  Configuracoes :TObjectList;
  Repositorio   :TRepositorio;
  nX            :Integer;
begin
  inherited;

  Repositorio := nil;
  Configuracoes    := nil;

  try
    Repositorio   := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
    Configuracoes := Repositorio.GetAll;

    if Assigned(Configuracoes) and (Configuracoes.Count > 0) then begin

       for nX := 0 to (Configuracoes.Count-1) do
         self.IncluirRegistroNoCDS(Configuracoes.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Configuracoes);
  end;

end;

procedure TfrmConfiguraNFCe.ExecutarDepoisAlterar;
begin
  inherited;
  cbxFormaEmissao.SetFocus;
end;

procedure TfrmConfiguraNFCe.ExecutarDepoisIncluir;
begin
  inherited;
  cbxFormaEmissao.SetFocus;
end;

function TfrmConfiguraNFCe.GravarDados: TObject;
var
  ParametrosNFCe :TParametrosNFCe;
  Repositorio    :TRepositorio;
begin
   ParametrosNFCe := nil;
   Repositorio    := nil;

   try
     Repositorio    := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
     ParametrosNFCe := TParametrosNFCe(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(ParametrosNFCe) then
      ParametrosNFCe := TParametrosNFCe.Create;

     ParametrosNFCe.FormaEmissao              := StrToInt(copy(cbxFormaEmissao.Items[cbxFormaEmissao.ItemIndex],1,1));

     if (ParametrosNFCe.FormaEmissao in [8]) and (ParametrosNFCe.justContingencia = '') then
     begin
       ParametrosNFCe.justContingencia   := 'Servidor da receita indisponível';
       ParametrosNFCe.inicioContingencia := now;
     end
     else if ParametrosNFCe.FormaEmissao in [0] then
     begin
       ParametrosNFCe.justContingencia   := '';
       ParametrosNFCe.inicioContingencia := 0;
     end;

     ParametrosNFCe.VersaoDF                  := self.cbxVersaoDF.itemIndex;
     ParametrosNFCe.IntervaloTentativas       := spnIntervalo.Value;
     ParametrosNFCe.Tentativas                := spnTentativas.Value;
     ParametrosNFCe.ID_TOKEN                  := edtCodigoToken.Text;
     ParametrosNFCe.TOKEN                     := edtToken.Text;
     ParametrosNFCe.Certificado               := edtCertificado.Text;
     ParametrosNFCe.Senha                     := edtSenhaCertificado.Text;
     ParametrosNFCe.DANFE.VisualizarImpressao := (rgpVisualizaImpressao.ItemIndex = 0);
     ParametrosNFCe.DANFE.ViaConsumidor       := (rgpViaConsumidor.ItemIndex = 0);
     ParametrosNFCe.DANFE.ImprimirItens       := (rgpImprimeItens.ItemIndex = 0);
     ParametrosNFCe.Ambiente                  := cbxAmbiente.Items[ cbxAmbiente.itemIndex ];

     Repositorio.Salvar(ParametrosNFCe);
     
     result := ParametrosNFCe;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmConfiguraNFCe.IncluirRegistroNoCDS(Registro: TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  inherited;

  ParametrosNFCe := (Registro as TParametrosNFCe);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := ParametrosNFCe.codigo;
  self.cdsTOKEN.AsString     := ParametrosNFCe.TOKEN;
  self.cds.Post;
end;

function TfrmConfiguraNFCe.indexFormaEmissao(formaEmissao: integer): integer;
var i :integer;
begin
  for i := 0 to cbxFormaEmissao.Items.Count -1 do
  begin
    if copy(cbxFormaEmissao.Items[i],1,1) = intToStr(formaEmissao) then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TfrmConfiguraNFCe.LimparDados;
begin
  inherited;

end;

procedure TfrmConfiguraNFCe.MostrarDados;
var
  ParametrosNFCe :TParametrosNFCe;
  Repositorio    :TRepositorio;
begin
  inherited;

  ParametrosNFCe  := nil;
  Repositorio     := nil;

  try
    Repositorio      := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
    ParametrosNFCe   := TParametrosNFCe(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(ParametrosNFCe) then exit;

    edtCodigo.Text                   := IntToStr(ParametrosNFCe.Codigo); 
    cbxFormaEmissao.ItemIndex        := indexFormaEmissao(ParametrosNFCe.FormaEmissao);
    cbxVersaoDF.ItemIndex            := ParametrosNFCe.VersaoDF;
    spnTentativas.Value              := ParametrosNFCe.Tentativas;
    spnIntervalo.Value               := ParametrosNFCe.IntervaloTentativas;
    edtCertificado.Text              := ParametrosNFCe.Certificado;
    edtSenhaCertificado.Text         := ParametrosNFCe.Senha;
    edtCodigoToken.Text              := ParametrosNFCe.ID_TOKEN;
    edtToken.Text                    := ParametrosNFCe.TOKEN;
    rgpVisualizaImpressao.ItemIndex  := IfThen(ParametrosNFCe.DANFE.VisualizarImpressao,0,1);
    rgpViaConsumidor.ItemIndex       := IfThen(ParametrosNFCe.DANFE.ViaConsumidor,0,1);
    rgpImprimeItens.ItemIndex        := IfThen(ParametrosNFCe.DANFE.ImprimirItens,0,1);
    cbxAmbiente.ItemIndex            := cbxAmbiente.Items.IndexOf( ParametrosNFCe.Ambiente );

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(ParametrosNFCe);
  end;
end;

function TfrmConfiguraNFCe.VerificaDados: Boolean;
begin
  Result := false;

  if edtCertificado.Text = '' then begin
    avisar('Um certificado deve ser informado');
    edtCertificado.SetFocus;
  end
  else if edtCodigoToken.Text = '' then begin
    avisar('Favor informar o código do token');
    edtCodigoToken.SetFocus;
  end
  else if edtToken.Text = '' then begin
    avisar('Favor informar o token');
    edtToken.SetFocus;
  end
  else
    Result := true;
end;

end.
