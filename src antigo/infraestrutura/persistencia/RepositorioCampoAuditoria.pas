unit RepositorioCampoAuditoria;

interface

uses
  Repositorio,
  DB;

type
  TRepositorioCampoAuditoria = class(TRepositorio)


  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;

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

uses
  CampoAuditoria;

{ TRepositorioCampoAuditoria }

function TRepositorioCampoAuditoria.Get(Dataset: TDataSet): TObject;
var
  Campo :TCampoAuditoria;
begin
   Campo                   := TCampoAuditoria.Create;
   Campo.Codigo            := Dataset.FieldByName('codigo').AsInteger;
   Campo.NomeCampo         := Dataset.FieldByName('nome_campo').AsString;
   Campo.ValorCampo        := Dataset.FieldByName('valor_campo').AsString;
   Campo.CodigoAuditoria   := Dataset.FieldByName('codigo_auditoria').AsInteger;

   result := Campo;
end;

function TRepositorioCampoAuditoria.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TCampoAuditoria(Objeto).Codigo;
end;

function TRepositorioCampoAuditoria.GetNomeDaTabela: String;
begin
   { Método a ser implementado na sub-classe }
end;

function TRepositorioCampoAuditoria.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TCampoAuditoria(Objeto).Codigo <= 0);
end;

procedure TRepositorioCampoAuditoria.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TCampoAuditoria(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioCampoAuditoria.SetParametros(Objeto: TObject);
var
  Obj :TCampoAuditoria;
begin
   Obj := (Objeto as TCampoAuditoria);

   inherited SetParametro('codigo',           Obj.Codigo);
   inherited SetParametro('codigo_auditoria', Obj.CodigoAuditoria);
   inherited SetParametro('nome_campo',       Obj.NomeCampo);
   inherited SetParametro('valor_campo',      Obj.ValorCampo);
end;

function TRepositorioCampoAuditoria.SQLGet: String;
begin
   result := ' select * from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioCampoAuditoria.SQLGetAll: String;
begin
   result := ' select * from '+self.GetNomeDaTabela;
end;

function TRepositorioCampoAuditoria.SQLGetExiste(campo: String): String;
begin
   result := ' select codigo from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioCampoAuditoria.SQLRemover: String;
begin
   result := ' delete from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioCampoAuditoria.SQLSalvar: String;
begin
   result := ' update or insert into '+self.GetNomeDaTabela+ '                '+
             '       (codigo, codigo_auditoria, nome_campo, valor_campo)      '+
             ' values (:codigo, :codigo_auditoria, :nome_campo, :valor_campo) ';
end;

end.
