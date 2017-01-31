unit RepositorioPisAliq;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioPisAliq = class(TRepositorio)

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

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
    function IsComponente                :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
end;

implementation

uses
  PisAliq,
  SysUtils;

{ TRepositorioPisAliq }

function TRepositorioPisAliq.Get(Dataset: TDataSet): TObject;
begin
   result := TPisAliq.Create(Dataset.FieldByName('aliquota').AsFloat);
end;

function TRepositorioPisAliq.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPisAliq(Objeto).CodigoItem;
end;

function TRepositorioPisAliq.GetNomeDaTabela: String;
begin
   result := 'itens_nf_pis_aliq';
end;

function TRepositorioPisAliq.GetRepositorio: TRepositorio;
begin
   result := TRepositorioPisAliq.Create;
end;

function TRepositorioPisAliq.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioPisAliq.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioPisAliq.SetParametros(Objeto: TObject);
var
  Obj :TPisAliq;
begin
   Obj := (Objeto as TPisAliq);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
   inherited SetParametro('aliquota',   Obj.Aliquota);
end;

function TRepositorioPisAliq.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioPisAliq.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioPisAliq.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioPisAliq.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item,  aliquota)   '+
             ' values (:codigo_item, :aliquota) ';
end;

end.
