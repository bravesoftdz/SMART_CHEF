unit RepositorioCampoAlteradoAuditoria;

interface

uses
  Repositorio,
  DB;

type
  TRepositorioCampoAlteradoAuditoria = class(TRepositorio)


  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String) :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;
end;

implementation

uses CampoAlteracaoAuditoria;

{ TRepositorioCampoAlteradoAuditoria }

function TRepositorioCampoAlteradoAuditoria.Get(
  Dataset: TDataSet): TObject;
var
  Campo :TCampoAlteracaoAuditoria;
begin
   Campo                        := TCampoAlteracaoAuditoria.Create;
   Campo.Codigo                 := Dataset.FieldByName('codigo').AsInteger;
   Campo.NomeCampo              := Dataset.FieldByName('nome_campo').AsString;
   Campo.ValorCampoNovo         := Dataset.FieldByName('valor_campo_novo').AsString;
   Campo.ValorCampoAntigo       := Dataset.FieldByName('valor_campo_antigo').AsString;
   Campo.CodigoAuditoria        := Dataset.FieldByName('codigo_auditoria').AsInteger;

   Result := Campo;
end;

function TRepositorioCampoAlteradoAuditoria.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TCampoAlteracaoAuditoria(Objeto).Codigo;
end;

function TRepositorioCampoAlteradoAuditoria.GetNomeDaTabela: String;
begin
   result := 'ALTERACOES_AUDITORIA';
end;

function TRepositorioCampoAlteradoAuditoria.GetRepositorio: TRepositorio;
begin
   result := TRepositorioCampoAlteradoAuditoria.Create;
end;

function TRepositorioCampoAlteradoAuditoria.IsInsercao(
  Objeto: TObject): Boolean;
begin
   result := (TCampoAlteracaoAuditoria(Objeto).Codigo <= 0);
end;

procedure TRepositorioCampoAlteradoAuditoria.SetIdentificador(
  Objeto: TObject; Identificador: Variant);
begin
   TCampoAlteracaoAuditoria(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioCampoAlteradoAuditoria.SetParametros(
  Objeto: TObject);
var
  Obj :TCampoAlteracaoAuditoria;
begin
   Obj := (Objeto as TCampoAlteracaoAuditoria);

   inherited SetParametro('codigo',             Obj.Codigo);
   inherited SetParametro('nome_campo',         Obj.NomeCampo);
   inherited SetParametro('valor_campo_novo',   Obj.ValorCampoNovo);
   inherited SetParametro('valor_campo_antigo', Obj.ValorCampoAntigo);
   inherited SetParametro('codigo_auditoria',   Obj.Auditoria.Codigo);
end;

function TRepositorioCampoAlteradoAuditoria.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo = :codigo';
end;

function TRepositorioCampoAlteradoAuditoria.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioCampoAlteradoAuditoria.SQLGetExiste(
  campo: String): String;
begin
  result := 'select '+ campo +' from '+self.GetNomeDaTabela+' where '+ campo +' = :ncampo';
end;

function TRepositorioCampoAlteradoAuditoria.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioCampoAlteradoAuditoria.SQLSalvar: String;
begin
   result := ' update or insert into alteracoes_auditoria                                               '+
             ' (codigo, codigo_auditoria, nome_campo, valor_campo_antigo, valor_campo_novo)             '+
             ' values (:codigo, :codigo_auditoria, :nome_campo, :valor_campo_antigo, :valor_campo_novo) ';
end;

end.
