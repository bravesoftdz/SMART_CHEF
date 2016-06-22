unit RepositorioGrupo;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioGrupo = class(TRepositorio)

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
  Grupo;

{ TRepositorioGrupo }

function TRepositorioGrupo.Get(Dataset: TDataSet): TObject;
var
  Grupo :TGrupo;
begin
   Grupo           := TGrupo.Create;
   Grupo.Codigo    := self.FQuery.FieldByName('codigo').AsInteger;
   Grupo.descricao := self.FQuery.FieldByName('descricao').AsString;

   result := Grupo;
end;

function TRepositorioGrupo.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TGrupo(Objeto).Codigo;
end;

function TRepositorioGrupo.GetNomeDaTabela: String;
begin
   result := 'GRUPOS';
end;

function TRepositorioGrupo.GetRepositorio: TRepositorio;
begin
   result := TRepositorioGrupo.Create;
end;

function TRepositorioGrupo.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TGrupo(Objeto).Codigo <= 0);
end;

procedure TRepositorioGrupo.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  GrupoAntigo :TGrupo;
  GrupoNovo   :TGrupo;
begin
   GrupoAntigo := (AntigoObjeto as TGrupo);
   GrupoNovo   := (Objeto       as TGrupo);

   if (GrupoAntigo.descricao <> GrupoNovo.descricao) then
    Auditoria.AdicionaCampoAlterado('descricao', GrupoAntigo.descricao, GrupoNovo.descricao);

end;

procedure TRepositorioGrupo.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Grupo :TGrupo;
begin
   Grupo := (Objeto as TGrupo);

   Auditoria.AdicionaCampoExcluido('codigo',    IntToStr(Grupo.Codigo));
   Auditoria.AdicionaCampoExcluido('descricao', Grupo.descricao);
end;

procedure TRepositorioGrupo.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Grupo :TGrupo;
begin
   Grupo := (Objeto as TGrupo);

   Auditoria.AdicionaCampoIncluido('codigo',    IntToStr(Grupo.codigo));
   Auditoria.AdicionaCampoIncluido('descricao', Grupo.descricao);
end;

procedure TRepositorioGrupo.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TGrupo(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioGrupo.SetParametros(Objeto: TObject);
var
  Grupo :TGrupo;
begin
   Grupo := (Objeto as TGrupo);

   self.FQuery.ParamByName('codigo').AsInteger   := Grupo.Codigo;
   self.FQuery.ParamByName('descricao').AsString := Grupo.descricao;
end;

function TRepositorioGrupo.SQLGet: String;
begin
  result := 'select * from Grupos where codigo = :ncod';
end;

function TRepositorioGrupo.SQLGetAll: String;
begin
   result := 'select * from Grupos';
end;

function TRepositorioGrupo.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Grupos where '+ campo +' = :ncampo';
end;

function TRepositorioGrupo.SQLRemover: String;
begin
   result := ' delete from Grupos where codigo = :codigo ';
end;

function TRepositorioGrupo.SQLSalvar: String;
begin
   result := 'update or insert into Grupos (codigo, descricao)   '+
             '                      values (:codigo, :descricao) ';
end;

end.
