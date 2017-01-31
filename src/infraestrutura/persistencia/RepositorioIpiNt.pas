unit RepositorioIpiNt;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioIpiNt = class(TRepositorio)

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
   IpiNt,
   SysUtils;

{ TRepositorioIpiNt }

function TRepositorioIpiNt.Get(Dataset: TDataSet): TObject;
begin
   result := TIpiNt.Create;
end;

function TRepositorioIpiNt.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TIpiNt(Objeto).CodigoItem;
end;

function TRepositorioIpiNt.GetNomeDaTabela: String;
begin
   result := 'itens_nf_ipi_nt';
end;

function TRepositorioIpiNt.GetRepositorio: TRepositorio;
begin
   result := TRepositorioIpiNt.Create; 
end;

function TRepositorioIpiNt.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioIpiNt.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioIpiNt.SetParametros(Objeto: TObject);
var
  Obj :TIpiNt;
begin
   Obj := (Objeto as TIpiNt);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
end;

function TRepositorioIpiNt.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIpiNt.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioIpiNt.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIpiNt.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item)   '+
             ' values (:codigo_item) ';
end;

end.
