unit uCadastroDepartamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, StdCtrls, DB, DBClient, ImgList, Grids,
  DBGrids, DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, contNrs;

type
  TfrmCadastroDepartamento = class(TfrmCadastroPadrao)
    edtCodigo: TEdit;
    lblRazao: TLabel;
    edtDepartamento: TEdit;
    cdsCODIGO: TIntegerField;
    cdsDEPARTAMENTO: TStringField;
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
  frmCadastroDepartamento: TfrmCadastroDepartamento;

implementation

uses repositorio, fabricaRepositorio, Departamento;

{$R *.dfm}

{ TfrmCadastroDepartamento }

procedure TfrmCadastroDepartamento.AlterarRegistroNoCDS(Registro: TObject);
var
  Departamento :TDepartamento;
begin
  inherited;

  Departamento := (Registro as TDepartamento);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Departamento.codigo;
  self.cdsDEPARTAMENTO.AsString := Departamento.nome;
  self.cds.Post;
end;

procedure TfrmCadastroDepartamento.CarregarDados;
var
  Departamentos :TObjectList;
  Repositorio   :TRepositorio;
  nX            :Integer;
begin
  inherited;

  Repositorio   := nil;
  Departamentos := nil;

  try
    Repositorio   := TFabricaRepositorio.GetRepositorio(TDepartamento.ClassName);
    Departamentos := Repositorio.GetAll;

    if Assigned(Departamentos) and (Departamentos.Count > 0) then begin

       for nX := 0 to (Departamentos.Count-1) do
         self.IncluirRegistroNoCDS(Departamentos.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Departamentos);
  end;
end;

procedure TfrmCadastroDepartamento.ExecutarDepoisAlterar;
begin
  inherited;
  edtDepartamento.SetFocus;
end;

procedure TfrmCadastroDepartamento.ExecutarDepoisIncluir;
begin
  inherited;
  edtDepartamento.SetFocus;
end;

function TfrmCadastroDepartamento.GravarDados: TObject;
var
  Departamento             :TDepartamento;
  RepositorioDepartamento  :TRepositorio;
begin
   Departamento             := nil;
   RepositorioDepartamento  := nil;

   try
     RepositorioDepartamento  := TFabricaRepositorio.GetRepositorio(TDepartamento.ClassName);
     Departamento             := TDepartamento(RepositorioDepartamento.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Departamento) then
      Departamento := TDepartamento.Create;

     Departamento.nome       := self.edtDepartamento.Text;

     RepositorioDepartamento.Salvar(Departamento);

     if self.EstadoTela = tetIncluir then
       Departamento.codigo := 0;

     if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       RepositorioDepartamento.Salvar_2(Departamento);

     result := Departamento;

   finally
     FreeAndNil(RepositorioDepartamento);
   end;
end;

procedure TfrmCadastroDepartamento.IncluirRegistroNoCDS(Registro: TObject);
var
  Departamento :TDepartamento;
begin
  inherited;

  Departamento := (Registro as TDepartamento);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := Departamento.codigo;
  self.cdsDEPARTAMENTO.AsString := Departamento.nome;
  self.cds.Post;
end;

procedure TfrmCadastroDepartamento.LimparDados;
begin
  inherited;
  self.edtCodigo.Clear;
  self.edtDepartamento.Clear;
end;

procedure TfrmCadastroDepartamento.MostrarDados;
var
  Departamento                              :TDepartamento;
  RepositorioDepartamento                   :TRepositorio;
begin
  inherited;

  Departamento                              := nil;
  RepositorioDepartamento                   := nil;

  try
    RepositorioDepartamento  := TFabricaRepositorio.GetRepositorio(TDepartamento.ClassName);
    Departamento             := TDepartamento(RepositorioDepartamento.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Departamento) then exit;

    self.edtCodigo.Text         := IntToStr(Departamento.codigo);
    self.edtDepartamento.Text   := Departamento.nome;

  finally
    FreeAndNil(RepositorioDepartamento);
    FreeAndNil(Departamento);
  end;
end;

function TfrmCadastroDepartamento.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtDepartamento.Text) = '' then begin
    avisar('Favor informar o nome do departamento');
    edtDepartamento.SetFocus;
  end
  else
    result := true;
end;

end.
