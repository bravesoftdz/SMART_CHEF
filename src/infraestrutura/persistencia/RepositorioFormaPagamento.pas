unit RepositorioFormaPagamento;

interface

uses DB, Repositorio;

type
  TRepositorioFormaPagamento = class(TRepositorio)

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

uses SysUtils, FormaPagamento;

{ TRepositorioFormaPagamento }

function TRepositorioFormaPagamento.Get(Dataset: TDataSet): TObject;
var
  FormaPagamento :TFormaPagamento;
begin
   FormaPagamento:= TFormaPagamento.Create;
   FormaPagamento.codigo    := self.FQuery.FieldByName('codigo').AsInteger;
   FormaPagamento.descricao := self.FQuery.FieldByName('descricao').AsString;

   result := FormaPagamento;
end;

function TRepositorioFormaPagamento.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TFormaPagamento(Objeto).Codigo;
end;

function TRepositorioFormaPagamento.GetNomeDaTabela: String;
begin
  result := 'FORMAS_PAGAMENTO';
end;

function TRepositorioFormaPagamento.GetRepositorio: TRepositorio;
begin
  result := TRepositorioFormaPagamento.Create;
end;

function TRepositorioFormaPagamento.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TFormaPagamento(Objeto).Codigo <= 0);
end;

procedure TRepositorioFormaPagamento.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TFormaPagamento(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioFormaPagamento.SetParametros(Objeto: TObject);
var
  FormaPagamento :TFormaPagamento;
begin
  FormaPagamento := (Objeto as TFormaPagamento);

  self.FQuery.ParamByName('codigo').AsInteger    := FormaPagamento.codigo;
  self.FQuery.ParamByName('descricao').AsString := FormaPagamento.descricao;
end;

function TRepositorioFormaPagamento.SQLGet: String;
begin
  result := 'select * from FORMAS_PAGAMENTO where codigo = :ncod';
end;

function TRepositorioFormaPagamento.SQLGetAll: String;
begin
  result := 'select * from FORMAS_PAGAMENTO';
end;

function TRepositorioFormaPagamento.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from FORMAS_PAGAMENTO where '+ campo +' = :ncampo';
end;

function TRepositorioFormaPagamento.SQLRemover: String;
begin
  result := ' delete from FORMAS_PAGAMENTO where codigo = :codigo ';
end;

function TRepositorioFormaPagamento.SQLSalvar: String;
begin
  result := 'update or insert into FORMAS_PAGAMENTO (CODIGO ,DESCRICAO) '+
           '                      values ( :CODIGO , :DESCRICAO) ';
end;

end.

