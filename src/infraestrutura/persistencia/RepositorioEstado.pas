unit RepositorioEstado;

interface

uses DB, Repositorio;

type
  TRepositorioEstado = class(TRepositorio)

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

end;

implementation

uses SysUtils, Estado;

{ TRepositorioEstado }

function TRepositorioEstado.Get(Dataset: TDataSet): TObject;
var
  Estado :TEstado;
begin
   Estado:= TEstado.Create;
   Estado.codigo := self.FQuery.FieldByName('codigo').AsInteger;
   Estado.sigla  := self.FQuery.FieldByName('sigla').AsString;
   Estado.nome   := self.FQuery.FieldByName('nome').AsString;

   result := Estado;
end;

function TRepositorioEstado.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEstado(Objeto).Codigo;
end;

function TRepositorioEstado.GetNomeDaTabela: String;
begin
  result := 'ESTADOS';
end;

function TRepositorioEstado.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEstado.Create;
end;

function TRepositorioEstado.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEstado(Objeto).Codigo <= 0);
end;

procedure TRepositorioEstado.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEstado(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEstado.SetParametros(Objeto: TObject);
var
  Estado :TEstado;
begin
  Estado := (Objeto as TEstado);

  self.FQuery.ParamByName('codigo').AsInteger := Estado.codigo;
  self.FQuery.ParamByName('sigla').AsString  := Estado.sigla;
  self.FQuery.ParamByName('nome').AsString   := Estado.nome;
end;

function TRepositorioEstado.SQLGet: String;
begin
  result := 'select * from ESTADOS where codigo = :ncod';
end;

function TRepositorioEstado.SQLGetAll: String;
begin
  result := 'select * from ESTADOS';
end;

function TRepositorioEstado.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ESTADOS where '+ campo +' = :ncampo';
end;

function TRepositorioEstado.SQLRemover: String;
begin
  result := ' delete from ESTADOS where codigo = :codigo ';
end;

function TRepositorioEstado.SQLSalvar: String;
begin
  result := 'update or insert into ESTADOS (CODIGO ,SIGLA ,NOME) '+
           '                      values ( :CODIGO , :SIGLA , :NOME) ';
end;

end.

