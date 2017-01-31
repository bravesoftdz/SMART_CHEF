unit RepositorioCofinsNt;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioCofinsNt = class(TRepositorio)

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
   CofinsNt,
   SysUtils;

{ TRepositorioCofinsNt }

function TRepositorioCofinsNt.Get(Dataset: TDataSet): TObject;
begin
   result := TCofinsNt.Create;
end;

function TRepositorioCofinsNt.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TCofinsNt(Objeto).CodigoItem;
end;

function TRepositorioCofinsNt.GetNomeDaTabela: String;
begin
   result := 'itens_nf_cofins_nt';
end;

function TRepositorioCofinsNt.GetRepositorio: TRepositorio;
begin
   result := TRepositorioCofinsNt.Create;
end;

function TRepositorioCofinsNt.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioCofinsNt.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioCofinsNt.SetParametros(Objeto: TObject);
var
  Obj :TCofinsNt;
begin
   Obj := (Objeto as TCofinsNt);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
end;

function TRepositorioCofinsNt.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioCofinsNt.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioCofinsNt.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioCofinsNt.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item)   '+
             ' values (:codigo_item) ';
end;

end.
