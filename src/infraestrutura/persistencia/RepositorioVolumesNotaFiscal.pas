unit RepositorioVolumesNotaFiscal;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioVolumesNotafiscal = class(TRepositorio)

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
  VolumesNotaFiscal,
  SysUtils;

{ TRepositorioVolumesNotafiscal }

function TRepositorioVolumesNotafiscal.Get(Dataset: TDataSet): TObject;
begin
   result := TVolumesNotaFiscal.Create(Dataset.FieldByName('especie').AsString,
                                       Dataset.FieldByName('quantidade_volumes').AsInteger,
                                       Dataset.FieldByName('peso_liquido').AsFloat,
                                       Dataset.FieldByName('peso_bruto').AsFloat);
end;

function TRepositorioVolumesNotafiscal.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TVolumesNotaFiscal(Objeto).CodigoNotaFiscal;
end;

function TRepositorioVolumesNotafiscal.GetNomeDaTabela: String;
begin
   result := 'volumes_notas_fiscais';
end;

function TRepositorioVolumesNotafiscal.GetRepositorio: TRepositorio;
begin
   result := TRepositorioVolumesNotafiscal.Create;
end;

function TRepositorioVolumesNotafiscal.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioVolumesNotafiscal.IsInsercao(
  Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioVolumesNotafiscal.SetParametros(Objeto: TObject);
var
  Obj :TVolumesNotaFiscal;
begin
   Obj := (Objeto as TVolumesNotaFiscal);

   inherited SetParametro('codigo_nota_fiscal',  Obj.CodigoNotaFiscal);
   inherited SetParametro('especie',             Obj.Especie);
   inherited SetParametro('quantidade_volumes',  Obj.QuantidadeVolumes);
   inherited SetParametro('peso_liquido',        Obj.PesoLiquido);
   inherited SetParametro('peso_bruto',          Obj.PesoBruto);
end;

function TRepositorioVolumesNotafiscal.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal';
end;

function TRepositorioVolumesNotafiscal.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioVolumesNotafiscal.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal';
end;

function TRepositorioVolumesNotafiscal.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+'  (codigo_nota_fiscal,  especie,  quantidade_volumes, '+
                                                           '   peso_liquido, peso_bruto)                          '+
                                                      'values (:codigo_nota_fiscal,  :especie,  :quantidade_volumes, '+
                                                           '   :peso_liquido, :peso_bruto)                          ';
end;

end.
