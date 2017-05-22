unit RepositorioCFOP;

interface

uses DB, Repositorio;

type
  TRepositorioCFOP = class(TRepositorio)

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

uses SysUtils, CFOP;

{ TRepositorioCFOP }

function TRepositorioCFOP.Get(Dataset: TDataSet): TObject;
var
  CFOP :TCFOP;
begin
   CFOP:= TCFOP.Create;
   CFOP.codigo          := self.FQuery.FieldByName('codigo').AsInteger;
   CFOP.descricao       := self.FQuery.FieldByName('descricao').AsString;
   CFOP.cfop            := self.FQuery.FieldByName('cfop').AsString;
   CFOP.suspensao_icms  := self.FQuery.FieldByName('suspensao_icms').AsString;

   result := CFOP;
end;

function TRepositorioCFOP.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TCFOP(Objeto).Codigo;
end;

function TRepositorioCFOP.GetNomeDaTabela: String;
begin
  result := 'NATUREZAS_OPERACAO';
end;

function TRepositorioCFOP.GetRepositorio: TRepositorio;
begin
  result := TRepositorioCFOP.Create;
end;

function TRepositorioCFOP.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TCFOP(Objeto).Codigo <= 0);
end;

procedure TRepositorioCFOP.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TCFOP(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioCFOP.SetParametros(Objeto: TObject);
var
  CFOP :TCFOP;
begin
  CFOP := (Objeto as TCFOP);

  self.FQuery.ParamByName('codigo').AsInteger         := CFOP.codigo;
  self.FQuery.ParamByName('descricao').AsString       := CFOP.descricao;
  self.FQuery.ParamByName('cfop').AsString            := CFOP.cfop;
  self.FQuery.ParamByName('suspensao_icms').AsString  := CFOP.suspensao_icms;
end;

function TRepositorioCFOP.SQLGet: String;
begin
  result := 'select * from NATUREZAS_OPERACAO where codigo = :ncod';
end;

function TRepositorioCFOP.SQLGetAll: String;
begin
  result := 'select * from NATUREZAS_OPERACAO';
end;

function TRepositorioCFOP.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from NATUREZAS_OPERACAO where '+ campo +' = :ncampo';
end;

function TRepositorioCFOP.SQLRemover: String;
begin
  result := ' delete from NATUREZAS_OPERACAO where codigo = :codigo ';
end;

function TRepositorioCFOP.SQLSalvar: String;
begin
  result := 'update or insert into NATUREZAS_OPERACAO (CODIGO ,DESCRICAO ,CFOP, SUSPENSAO_ICMS) '+
           '                      values ( :CODIGO , :DESCRICAO , :CFOP, :SUSPENSAO_ICMS) ';
end;

end.

