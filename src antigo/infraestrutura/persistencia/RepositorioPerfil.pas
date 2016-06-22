unit RepositorioPerfil;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioPerfil = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;    

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;

end;

implementation

uses
  SysUtils,
  Perfil;

{ TRepositorioPerfil }

function TRepositorioPerfil.Get(Dataset: TDataSet): TObject;
var
  Perfil :TPerfil;
begin
   Perfil        := TPerfil.Create;
   Perfil.Codigo := self.FQuery.FieldByName('codigo').AsInteger;
   Perfil.Nome   := self.FQuery.FieldByName('nome').AsString;
   Perfil.Acesso := self.FQuery.FieldByName('acesso').AsString;

   result := Perfil;
end;

function TRepositorioPerfil.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPerfil(Objeto).Codigo;
end;

function TRepositorioPerfil.GetNomeDaTabela: String;
begin
   result := 'PERFIS';
end;

function TRepositorioPerfil.GetRepositorio: TRepositorio;
begin
   result := TRepositorioPerfil.Create;
end;

function TRepositorioPerfil.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TPerfil(Objeto).Codigo <= 0);
end;

procedure TRepositorioPerfil.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  PerfilAntigo :TPerfil;
  PerfilNovo   :TPerfil;
begin
   PerfilAntigo := (AntigoObjeto as TPerfil);
   PerfilNovo   := (Objeto       as TPerfil);

   if (PerfilAntigo.Nome <> PerfilNovo.Nome) then
    Auditoria.AdicionaCampoAlterado('nome', PerfilAntigo.Nome, PerfilNovo.Nome);

   if (PerfilAntigo.Acesso <> PerfilNovo.Acesso) then
    Auditoria.AdicionaCampoAlterado('acesso', PerfilAntigo.Acesso, PerfilNovo.Acesso);
end;

procedure TRepositorioPerfil.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Perfil :TPerfil;
begin
   Perfil := (Objeto as TPerfil);

   Auditoria.AdicionaCampoExcluido('codigo', IntToStr(Perfil.Codigo));
   Auditoria.AdicionaCampoExcluido('nome',   Perfil.Nome);
   Auditoria.AdicionaCampoExcluido('acesso', Perfil.Acesso);
end;

procedure TRepositorioPerfil.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Perfil :TPerfil;
begin
   Perfil := (Objeto as TPerfil);

   Auditoria.AdicionaCampoIncluido('codigo', IntToStr(Perfil.Codigo));
   Auditoria.AdicionaCampoIncluido('nome',   Perfil.Nome);
   Auditoria.AdicionaCampoIncluido('acesso', Perfil.Acesso);
end;

procedure TRepositorioPerfil.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TPerfil(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioPerfil.SetParametros(Objeto: TObject);
var
  Perfil :TPerfil;
begin
   Perfil := (Objeto as TPerfil);

   self.FQuery.ParamByName('codigo').AsInteger := Perfil.Codigo;
   self.FQuery.ParamByName('nome').AsString    := Perfil.Nome;
   self.FQuery.ParamByName('acesso').AsString  := Perfil.Acesso;
end;

function TRepositorioPerfil.SQLGet: String;
begin
  result := 'select * from Perfis where codigo = :ncod';
end;

function TRepositorioPerfil.SQLGetAll: String;
begin
   result := 'select * from perfis'; 
end;

function TRepositorioPerfil.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Perfis where '+ campo +' = :ncampo';
end;

function TRepositorioPerfil.SQLRemover: String;
begin
   result := ' delete from perfis where codigo = :codigo ';
end;

function TRepositorioPerfil.SQLSalvar: String;
begin
   result := 'update or insert into Perfis (codigo, nome, acesso)   '+
             '                      values (:codigo, :nome, :acesso)';
end;

end.
