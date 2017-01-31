unit RepositorioCidade;

interface

uses DB, Repositorio;

type
  TRepositorioCidade = class(TRepositorio)

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

uses SysUtils, Cidade;

{ TRepositorioCidade }

function TRepositorioCidade.Get(Dataset: TDataSet): TObject;
var
  Cidade :TCidade;
begin
   Cidade:= TCidade.Create;
   Cidade.codigo  := self.FQuery.FieldByName('codigo').AsInteger;
   Cidade.codest  := self.FQuery.FieldByName('codest').AsInteger;
   Cidade.nome    := self.FQuery.FieldByName('nome').AsString;
   Cidade.cep     := self.FQuery.FieldByName('cep').AsString;
   Cidade.codibge := self.FQuery.FieldByName('codibge').AsInteger;

   result := Cidade;
end;

function TRepositorioCidade.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TCidade(Objeto).Codigo;
end;

function TRepositorioCidade.GetNomeDaTabela: String;
begin
  result := 'CIDADES';
end;

function TRepositorioCidade.GetRepositorio: TRepositorio;
begin
  result := TRepositorioCidade.Create;
end;

function TRepositorioCidade.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TCidade(Objeto).Codigo <= 0);
end;

procedure TRepositorioCidade.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TCidade(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioCidade.SetParametros(Objeto: TObject);
var
  Cidade :TCidade;
begin
  Cidade := (Objeto as TCidade);

  self.FQuery.ParamByName('codigo').AsInteger  := Cidade.codigo;
  self.FQuery.ParamByName('codest').AsInteger  := Cidade.codest;
  self.FQuery.ParamByName('nome').AsString    := Cidade.nome;
  self.FQuery.ParamByName('cep').AsString     := Cidade.cep;
  self.FQuery.ParamByName('codibge').AsInteger := Cidade.codibge;
end;

function TRepositorioCidade.SQLGet: String;
begin
  result := 'select * from CIDADES where codigo = :ncod';
end;

function TRepositorioCidade.SQLGetAll: String;
begin
  result := 'select * from CIDADES order by codigo';
end;

function TRepositorioCidade.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CIDADES where '+ campo +' = :ncampo';
end;

function TRepositorioCidade.SQLRemover: String;
begin
  result := ' delete from CIDADES where codigo = :codigo ';
end;

function TRepositorioCidade.SQLSalvar: String;
begin
  result := 'update or insert into CIDADES (CODIGO ,CODEST ,NOME ,CEP ,CODIBGE) '+
           '                      values ( :CODIGO , :CODEST , :NOME , :CEP , :CODIBGE) ';
end;

end.

