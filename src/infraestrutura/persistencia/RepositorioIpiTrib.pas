unit RepositorioIpiTrib;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioIpiTrib = class(TRepositorio)

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
   IpiTrib,
   SysUtils;

{ TRepositorioIpiTrib }

function TRepositorioIpiTrib.Get(Dataset: TDataSet): TObject;
begin
   result := TIpiTrib.Create(Dataset.FieldByName('aliquota').AsFloat);
end;

function TRepositorioIpiTrib.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TIpiTrib(Objeto).CodigoItem;
end;

function TRepositorioIpiTrib.GetNomeDaTabela: String;
begin
   result := 'itens_nf_ipi_trib';
end;

function TRepositorioIpiTrib.GetRepositorio: TRepositorio;
begin
   result := TRepositorioIpiTrib.Create;
end;

function TRepositorioIpiTrib.IsComponente: Boolean;
begin
    result := true;
end;

function TRepositorioIpiTrib.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioIpiTrib.SetParametros(Objeto: TObject);
var
  Obj :TIpiTrib;
begin
   Obj := (Objeto as TIpiTrib);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
   inherited SetParametro('aliquota',    Obj.Aliquota);
end;

function TRepositorioIpiTrib.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item'; 
end;

function TRepositorioIpiTrib.SQLGetAll: String;
begin
   result := 'select * from '+ self.GetNomeDaTabela;
end;

function TRepositorioIpiTrib.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item ';
end;

function TRepositorioIpiTrib.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        ( codigo_item,   aliquota) '+
             ' values (:codigo_item, :aliquota)  ';
end;

end.
