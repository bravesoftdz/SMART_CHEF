unit uCadastroMateriaPrima;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, ExtCtrls, Mask, ToolEdit, CurrEdit, contnrs,
  ImgList, pngimage;

type
  TfrmCadastroMateriaPrima = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    cdsVALOR: TFloatField;
    edtMateria: TEdit;
    lblRazao: TLabel;
    edtCodigo: TEdit;
    edtValor: TCurrencyEdit;
    Label12: TLabel;
    Label1: TLabel;
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
  frmCadastroMateriaPrima: TfrmCadastroMateriaPrima;

implementation

uses materiaPrima, repositorio, fabricarepositorio;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmCadastroMateriaPrima.AlterarRegistroNoCDS(Registro: TObject);
var
  MateriaPrima :TMateriaPrima;
begin
  inherited;

  MateriaPrima := (Registro as TMateriaPrima);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger   := MateriaPrima.codigo;
  self.cdsDESCRICAO.AsString := MateriaPrima.descricao;
  self.cdsVALOR.AsFloat      := MateriaPrima.valor;  
  self.cds.Post;
end;

procedure TfrmCadastroMateriaPrima.CarregarDados;
var
  Materias    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Materias    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
    Materias    := Repositorio.GetAll;

    if Assigned(Materias) and (Materias.Count > 0) then begin

       for nX := 0 to (Materias.Count-1) do
         self.IncluirRegistroNoCDS(Materias.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Materias);
  end;

end;

procedure TfrmCadastroMateriaPrima.ExecutarDepoisAlterar;
begin
  inherited;
  edtMateria.SetFocus;
end;

procedure TfrmCadastroMateriaPrima.ExecutarDepoisIncluir;
begin
  inherited;
  edtMateria.SetFocus;
end;

function TfrmCadastroMateriaPrima.GravarDados: TObject;
var
  MateriaPrima             :TMateriaPrima;
  RepositorioMateriaPrima  :TRepositorio;
begin
   MateriaPrima             := nil;
   RepositorioMateriaPrima  := nil;

   try
     RepositorioMateriaPrima  := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
     MateriaPrima             := TMateriaPrima(RepositorioMateriaPrima.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(MateriaPrima) then
      MateriaPrima := TMateriaPrima.Create;

     MateriaPrima.descricao    := self.edtMateria.Text;
     MateriaPrima.valor        := self.edtValor.Value;

     RepositorioMateriaPrima.Salvar(MateriaPrima);

     if self.EstadoTela = tetIncluir then
       MateriaPrima.codigo := 0;

     if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       RepositorioMateriaPrima.Salvar_2(MateriaPrima);
     
     result := MateriaPrima;

   finally
     FreeAndNil(RepositorioMateriaPrima);
   end;
end;

procedure TfrmCadastroMateriaPrima.IncluirRegistroNoCDS(Registro: TObject);
var
  MateriaPrima :TMateriaPrima;
begin
  inherited;

  MateriaPrima := (Registro as TMateriaPrima);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := MateriaPrima.codigo;
  self.cdsDESCRICAO.AsString := MateriaPrima.descricao;
  self.cdsVALOR.AsFloat      := MateriaPrima.valor;
  self.cds.Post;
end;

procedure TfrmCadastroMateriaPrima.LimparDados;
begin
  inherited;

  self.edtCodigo.Clear;
  self.edtMateria.Clear;
  self.edtValor.Clear;
end;

procedure TfrmCadastroMateriaPrima.MostrarDados;
var
  MateriaPrima                              :TMateriaPrima;
  RepositorioMateriaPrima                   :TRepositorio;
begin
  inherited;

  MateriaPrima                              := nil;
  RepositorioMateriaPrima                   := nil;

  try
    RepositorioMateriaPrima  := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
    MateriaPrima             := TMateriaPrima(RepositorioMateriaPrima.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(MateriaPrima) then exit;

    self.edtCodigo.Text      := IntToStr(MateriaPrima.codigo);
    self.edtMateria.Text     := MateriaPrima.descricao;
    self.edtValor.Value      := MateriaPrima.valor; 

  finally
    FreeAndNil(RepositorioMateriaPrima);
    FreeAndNil(MateriaPrima);
  end;
end;

function TfrmCadastroMateriaPrima.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtMateria.Text) = '' then begin
    avisar('Favor informar a descrição da matéria');
    edtMateria.SetFocus;
  end
  else
    result := true;
end;

end.
 