unit RepositorioPisNt;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioPisNt = class(TRepositorio)

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
  PisNt,
  SysUtils;

{ TRepositorioPisNt }

function TRepositorioPisNt.Get(Dataset: TDataSet): TObject;
begin
   result := TPisNt.Create; 
end;

function TRepositorioPisNt.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPisNt(Objeto).CodigoItem;
end;

function TRepositorioPisNt.GetNomeDaTabela: String;
begin
   result := 'itens_nf_pis_nt';
end;

function TRepositorioPisNt.GetRepositorio: TRepositorio;
begin
   result := TRepositorioPisNt.Create;
end;

function TRepositorioPisNt.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioPisNt.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioPisNt.SetParametros(Objeto: TObject);
var
  Obj :TPisNt;
begin
   Obj := (Objeto as TPisNt);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
end;

function TRepositorioPisNt.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioPisNt.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioPisNt.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioPisNt.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item)   '+
             ' values (:codigo_item) ';
end;

end.
