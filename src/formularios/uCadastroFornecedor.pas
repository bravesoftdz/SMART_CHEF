unit uCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Mask, frameFone, frameMaskCpfCnpj, contNrs;

type
  TfrmCadastroFornecedor = class(TfrmCadastroPadrao)
    edtRazao: TEdit;
    CNPJ: TMaskCpfCnpj;
    edtIE: TEdit;
    Fone1: TFone;
    edtCodigo: TEdit;
    lblRazao: TLabel;
    Label1: TLabel;
    cdsCODIGO: TIntegerField;
    cdsRAZAO_SOCIAL: TStringField;
    Fone2: TFone;
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
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

uses Fornecedor, Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmCadastroFornecedor.AlterarRegistroNoCDS(Registro: TObject);
var
  Fornecedor :TFornecedor;
begin
  inherited;

  Fornecedor := TFornecedor(Registro);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger         := Fornecedor.codigo;
  self.cdsRAZAO_SOCIAL.AsString    := Fornecedor.Razao;
  self.cds.Post;
end;

procedure TfrmCadastroFornecedor.CarregarDados;
var
  Fornecedores :TObjectList;
  Repositorio  :TRepositorio;
  nX           :Integer;
begin
  inherited;

  Repositorio := nil;
  Fornecedores    := nil;

  try
    Repositorio   := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
    Fornecedores  := Repositorio.GetAll;

    if Assigned(Fornecedores) and (Fornecedores.Count > 0) then begin

       for nX := 0 to (Fornecedores.Count-1) do
         self.IncluirRegistroNoCDS(Fornecedores.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Fornecedores);
  end;
end;

procedure TfrmCadastroFornecedor.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroFornecedor.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  CNPJ.pessoa := 'J';
end;

function TfrmCadastroFornecedor.GravarDados: TObject;
var
  Fornecedor   :TFornecedor;
  Repositorio  :TRepositorio;
  codigo_cli1  :integer;
begin
   Fornecedor      := nil;
   Repositorio  := nil;

   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
     Fornecedor       := TFornecedor(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Fornecedor) then
      Fornecedor := TFornecedor.Create;

     Fornecedor.razao     := self.edtRazao.Text;
     Fornecedor.cpf_cnpj  := self.CNPJ.edtCpf.Text;
     Fornecedor.RG_IE     := self.edtIE.Text;

     Repositorio.Salvar(Fornecedor);

     codigo_cli1    := Fornecedor.codigo;

     result := Fornecedor;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroFornecedor.IncluirRegistroNoCDS(Registro: TObject);
var
  Fornecedor :TFornecedor;
begin
  inherited;

  Fornecedor := TFornecedor(Registro);

  self.cds.Append;
  self.cdsCODIGO.AsInteger       := Fornecedor.codigo;
  self.cdsRAZAO_SOCIAL.AsString  := Fornecedor.razao;
  self.cds.Post;
end;

procedure TfrmCadastroFornecedor.LimparDados;
begin
  edtCodigo.Clear;
  edtRazao.Clear;
  edtIE.Clear;
  CNPJ.Limpa;
  Fone1.limpa;
  Fone2.limpa;
end;

procedure TfrmCadastroFornecedor.MostrarDados;
var
  Fornecedor   :TFornecedor;
  Repositorio  :TRepositorio;
  i :integer;
begin
  inherited;

  Fornecedor   := nil;
  Repositorio  := nil;

  try
    Repositorio  := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
    Fornecedor   := TFornecedor(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Fornecedor) then exit;

    edtCodigo.Text        := IntToStr(Fornecedor.codigo);
    self.edtRazao.Text    := Fornecedor.razao;
    CNPJ.cpfCnpj          := Fornecedor.cpf_cnpj;
    self.edtIE.Text       := Fornecedor.RG_IE;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Fornecedor);
  end;
end;

function TfrmCadastroFornecedor.VerificaDados: Boolean;
begin
  result := false;

  if edtRazao.Text = '' then begin
    avisar('O nome deve ser informado');
    edtRazao.SetFocus;
  end
  else
    result := true;
end;

end.
