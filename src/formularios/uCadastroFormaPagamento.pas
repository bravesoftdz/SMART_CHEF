unit uCadastroFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, contnrs, Vcl.Mask, RxToolEdit, RxCurrEdit, Vcl.Imaging.pngimage;

type
  TfrmCadastroFormaPagamento = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    edtCodigo: TCurrencyEdit;
    edtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
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
  frmCadastroFormaPagamento: TfrmCadastroFormaPagamento;

implementation

uses FormaPagamento, repositorio, FabricaRepositorio;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmCadastroFormaPagamento.AlterarRegistroNoCDS(Registro: TObject);
var
  CFOP :TFormaPagamento;
begin
  inherited;

  CFOP := (Registro as TFormaPagamento);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := CFOP.codigo;
  self.cdsDESCRICAO.AsString    := CFOP.descricao;
  self.cds.Post;
end;

procedure TfrmCadastroFormaPagamento.CarregarDados;
var
  FormasPgto  :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  FormasPgto    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TFormaPagamento.ClassName);
    FormasPgto       := Repositorio.GetAll;

    if Assigned(FormasPgto) and (FormasPgto.Count > 0) then begin

       for nX := 0 to (FormasPgto.Count-1) do
         self.IncluirRegistroNoCDS(FormasPgto.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(FormasPgto);
  end;
end;

procedure TfrmCadastroFormaPagamento.ExecutarDepoisAlterar;
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadastroFormaPagamento.ExecutarDepoisIncluir;
begin
  inherited;
  edtDescricao.SetFocus;
end;

function TfrmCadastroFormaPagamento.GravarDados: TObject;
var
  FormaPagamento             :TFormaPagamento;
  Repositorio   :TRepositorio;
begin
   FormaPagamento := nil;
   Repositorio    := nil;

   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TFormaPagamento.ClassName);
     FormaPagamento   := TFormaPagamento(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(FormaPagamento) then
      FormaPagamento := TFormaPagamento.Create;

     FormaPagamento.descricao              := self.edtDescricao.Text;

     Repositorio.Salvar(FormaPagamento);

     result := FormaPagamento;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroFormaPagamento.IncluirRegistroNoCDS(Registro: TObject);
var
  FormaPagamento :TFormaPagamento;
begin
  inherited;

  FormaPagamento := (Registro as TFormaPagamento);

  self.cds.Append;
  self.cdsCODIGO.AsInteger          := FormaPagamento.codigo;
  self.cdsDESCRICAO.AsString        := FormaPagamento.descricao;
  self.cds.Post;
end;

procedure TfrmCadastroFormaPagamento.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtDescricao.Clear;
end;

procedure TfrmCadastroFormaPagamento.MostrarDados;
var
  FormaPagamento                    :TFormaPagamento;
  Repositorio                       :TRepositorio;
begin
  inherited;

  FormaPagamento          := nil;
  Repositorio             := nil;

  try
    Repositorio     := TFabricaRepositorio.GetRepositorio(TFormaPagamento.ClassName);
    FormaPagamento  := TFormaPagamento(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(FormaPagamento) then exit;

    self.edtCodigo.AsInteger        := FormaPagamento.codigo;
    self.edtDescricao.Text          := FormaPagamento.descricao;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(FormaPagamento);
  end;
end;

function TfrmCadastroFormaPagamento.VerificaDados: Boolean;
begin
  result := false;

  if length(edtDescricao.Text) < 5 then
  begin
    avisar('Favor informar a descrição da forma de pagamento.');
    edtDescricao.SetFocus;
  end
  else
    result := true;
end;

end.
