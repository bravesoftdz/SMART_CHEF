unit RepositorioCofinsAliq;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioCofinsAliq = class(TRepositorio)

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
   CofinsAliq,
   SysUtils;

{ TRepositorioCofinsAliq }

function TRepositorioCofinsAliq.Get(Dataset: TDataSet): TObject;
begin
   result := TCofinsAliq.Create(Dataset.FieldByName('aliquota').AsFloat);
end;

function TRepositorioCofinsAliq.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TCofinsAliq(Objeto).CodigoItem;
end;

function TRepositorioCofinsAliq.GetNomeDaTabela: String;
begin
   result := 'itens_nf_cofins_aliq';
end;

function TRepositorioCofinsAliq.GetRepositorio: TRepositorio;
begin
   result := TRepositorioCofinsAliq.Create;
end;

function TRepositorioCofinsAliq.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioCofinsAliq.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true; 
end;

procedure TRepositorioCofinsAliq.SetParametros(Objeto: TObject);
var
  Obj :TCofinsAliq;
begin
   Obj := (Objeto as TCofinsAliq);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
   inherited SetParametro('aliquota',   Obj.Aliquota);
end;

function TRepositorioCofinsAliq.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioCofinsAliq.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioCofinsAliq.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioCofinsAliq.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item,  aliquota)   '+
             ' values (:codigo_item, :aliquota) ';
end;

end.
