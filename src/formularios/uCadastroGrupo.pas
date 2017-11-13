unit uCadastroGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, ExtCtrls, Contnrs, ImgList, pngimage;

type
  TfrmCadastroGrupo = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    edtGrupo: TEdit;
    edtCodigo: TEdit;
    lblRazao: TLabel;
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
  frmCadastroGrupo: TfrmCadastroGrupo;

implementation

uses repositorio, fabricaRepositorio, Grupo;

{$R *.dfm}

{ TfrmCadastroGrupo }

procedure TfrmCadastroGrupo.AlterarRegistroNoCDS(Registro: TObject);
var
  Grupo :TGrupo;
begin
  inherited;

  Grupo := (Registro as TGrupo);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger   := Grupo.codigo;
  self.cdsDESCRICAO.AsString := Grupo.descricao;
  self.cds.Post;
end;

procedure TfrmCadastroGrupo.CarregarDados;
var
  Grupos      :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Grupos      := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TGrupo.ClassName);
    Grupos      := Repositorio.GetAll;

    if Assigned(Grupos) and (Grupos.Count > 0) then begin

       for nX := 0 to (Grupos.Count-1) do
         self.IncluirRegistroNoCDS(Grupos.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Grupos);
  end;
end;

procedure TfrmCadastroGrupo.ExecutarDepoisAlterar;
begin
  inherited;
  edtGrupo.SetFocus;
end;

procedure TfrmCadastroGrupo.ExecutarDepoisIncluir;
begin
  inherited;
  edtGrupo.SetFocus;
end;

function TfrmCadastroGrupo.GravarDados: TObject;
var
  Grupo             :TGrupo;
  RepositorioGrupo  :TRepositorio;
begin
   Grupo             := nil;
   RepositorioGrupo  := nil;

   try
     RepositorioGrupo  := TFabricaRepositorio.GetRepositorio(TGrupo.ClassName);
     Grupo             := TGrupo(RepositorioGrupo.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Grupo) then
      Grupo := TGrupo.Create;

     Grupo.descricao                    := self.edtGrupo.Text;

     RepositorioGrupo.Salvar(Grupo);

     if self.EstadoTela = tetIncluir then
       Grupo.codigo := 0;

   //  if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
   //    RepositorioGrupo.Salvar_2(Grupo);
     
     result := Grupo;

   finally
     FreeAndNil(RepositorioGrupo);
   end;
end;

procedure TfrmCadastroGrupo.IncluirRegistroNoCDS(Registro: TObject);
var
  Grupo :TGrupo;
begin
  inherited;

  Grupo := (Registro as TGrupo);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := Grupo.codigo;
  self.cdsDESCRICAO.AsString := Grupo.descricao;
  self.cds.Post;
end;

procedure TfrmCadastroGrupo.LimparDados;
begin
  inherited;

  self.edtCodigo.Clear;
  self.edtGrupo.Clear;
end;

procedure TfrmCadastroGrupo.MostrarDados;
var
  Grupo                              :TGrupo;
  RepositorioGrupo                   :TRepositorio;
begin
  inherited;

  Grupo                              := nil;
  RepositorioGrupo                   := nil;

  try
    RepositorioGrupo  := TFabricaRepositorio.GetRepositorio(TGrupo.ClassName);
    Grupo             := TGrupo(RepositorioGrupo.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Grupo) then exit;

    self.edtCodigo.Text                 := IntToStr(Grupo.codigo);
    self.edtGrupo.Text                  := Grupo.descricao;

  finally
    FreeAndNil(RepositorioGrupo);
    FreeAndNil(Grupo);
  end;
end;

function TfrmCadastroGrupo.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtGrupo.Text) = '' then begin
    avisar('Favor informar a Descrição do grupo');
    edtGrupo.SetFocus;
  end
  else
    result := true;
end;

end.
