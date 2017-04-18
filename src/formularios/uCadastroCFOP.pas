unit uCadastroCFOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, contNrs, Vcl.Imaging.pngimage;

type
  TfrmCadastroCFOP = class(TfrmCadastroPadrao)
    edtCodigo: TCurrencyEdit;
    Label1: TLabel;
    edtDescricao: TEdit;
    edtCFOP: TEdit;
    Label2: TLabel;
    cdsCODIGO: TIntegerField;
    cdsCFOP: TStringField;
    cdsDESCRICAO: TStringField;
    cdsSUSPENSAO: TStringField;
    cmbSuspensao: TComboBox;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
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
  frmCadastroCFOP: TfrmCadastroCFOP;

implementation

uses CFOP, repositorio, FabricaRepositorio, Math;

{$R *.dfm}

{ TfrmCadastroCFOP }

procedure TfrmCadastroCFOP.AlterarRegistroNoCDS(Registro: TObject);
var
  CFOP :TCFOP;
begin
  inherited;

  CFOP := (Registro as TCFOP);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := CFOP.codigo;
  self.cdsCFOP.AsString         := CFOP.cfop;
  self.cdsDESCRICAO.AsString    := CFOP.descricao;
  self.cdsSUSPENSAO.AsString    := CFOP.suspensao_icms;
  self.cds.Post;
end;

procedure TfrmCadastroCFOP.CarregarDados;
var
  CFOPs       :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  CFOPs    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
    CFOPs       := Repositorio.GetAll;

    if Assigned(CFOPs) and (CFOPs.Count > 0) then begin

       for nX := 0 to (CFOPs.Count-1) do
         self.IncluirRegistroNoCDS(CFOPs.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(CFOPs);
  end;
end;

procedure TfrmCadastroCFOP.ExecutarDepoisAlterar;
begin
  inherited;
  edtCFOP.SetFocus;
end;

procedure TfrmCadastroCFOP.ExecutarDepoisIncluir;
begin
  inherited;
  edtCFOP.SetFocus;
end;

procedure TfrmCadastroCFOP.FormShow(Sender: TObject);
begin
  inherited;
  gridConsulta.SelectedIndex := 0;
end;

function TfrmCadastroCFOP.GravarDados: TObject;
var
  CFOP             :TCFOP;
  RepositorioCFOP  :TRepositorio;
begin
   CFOP             := nil;

   RepositorioCFOP  := nil;

   try
     RepositorioCFOP  := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
     CFOP             := TCFOP(RepositorioCFOP.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(CFOP) then
      CFOP := TCFOP.Create;

     CFOP.descricao         := self.edtDescricao.Text;
     CFOP.cfop              := self.edtCFOP.Text;
     CFOP.suspensao_icms    := copy(self.cmbSuspensao.Items[self.cmbSuspensao.ItemIndex],1,1);

     RepositorioCFOP.Salvar(CFOP);

     result := CFOP;

   finally
     FreeAndNil(RepositorioCFOP);
   end;
end;

procedure TfrmCadastroCFOP.IncluirRegistroNoCDS(Registro: TObject);
var
  CFOP :TCFOP;
begin
  inherited;

  CFOP := (Registro as TCFOP);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := CFOP.codigo;
  self.cdsCFOP.AsString         := CFOP.cfop;
  self.cdsDESCRICAO.AsString    := CFOP.descricao;
  self.cdsSUSPENSAO.AsString    := CFOP.suspensao_icms;
  self.cds.Post;
end;

procedure TfrmCadastroCFOP.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtCFOP.Clear;
  edtDescricao.Clear;
end;

procedure TfrmCadastroCFOP.MostrarDados;
var
  CFOP                              :TCFOP;
  RepositorioCFOP                   :TRepositorio;
begin
  inherited;

  CFOP                              := nil;
  RepositorioCFOP                   := nil;

  try
    RepositorioCFOP  := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
    CFOP             := TCFOP(RepositorioCFOP.Get(self.ds.DataSet.FieldByName('CODIGO').AsInteger));//*f CFOP             := TCFOP(RepositorioCFOP.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(CFOP) then exit;

    self.edtCodigo.AsInteger        := CFOP.codigo;
    self.edtCFOP.Text               := CFOP.cfop;
    self.edtDescricao.Text          := CFOP.descricao;
    self.cmbSuspensao.ItemIndex     := IfThen(CFOP.suspensao_icms = 'S',0,1);

  finally
    FreeAndNil(RepositorioCFOP);
    FreeAndNil(CFOP);
  end;
end;

procedure TfrmCadastroCFOP.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.TabIndex = 1 then //*f
    MostrarDados;
end;

function TfrmCadastroCFOP.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtCFOP.Text) = '' then begin
    avisar('Favor informar o código CFOP.');
    edtCFOP.SetFocus;
  end
  else if length(edtDescricao.Text) < 5 then
  begin
    avisar('Favor informar a descrição do CFOP.');
    edtDescricao.SetFocus;
  end
  else
    result := true;
end;

end.
