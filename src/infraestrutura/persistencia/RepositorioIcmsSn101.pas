unit RepositorioIcmsSn101;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioIcmsSn101 = class(TRepositorio)

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
  IcmsSn101,
  TipoOrigemMercadoria,
  SysUtils;

{ TRepositorioIcmsSn101 }

function TRepositorioIcmsSn101.Get(Dataset: TDataSet): TObject;
begin
   result := TIcmsSn101.Create(TTipoOrigemMercadoriaUtilitario.DeIntegerParaEnumerado(Dataset.FieldByName('origem').AsInteger),
                               Dataset.FieldByName('aliquota_credito_sn').AsFloat);
end;

function TRepositorioIcmsSn101.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TIcmsSn101(Objeto).CodigoItem;
end;

function TRepositorioIcmsSn101.GetNomeDaTabela: String;
begin
   result := 'itens_nf_icms_sn_101';
end;

function TRepositorioIcmsSn101.GetRepositorio: TRepositorio;
begin
   result := TRepositorioIcmsSn101.Create;
end;

function TRepositorioIcmsSn101.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioIcmsSn101.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioIcmsSn101.SetParametros(Objeto: TObject);
var
  Obj :TIcmsSn101;
begin
   Obj := (Objeto as TIcmsSn101);

   inherited SetParametro('codigo_item', Obj.CodigoItem);
   inherited SetParametro('origem',      TTipoOrigemMercadoriaUtilitario.DeEnumeradoParaInteger(Obj.OrigemMercadoria));
   inherited SetParametro('aliquota_credito_sn',   Obj.AliquotaCreditoSN);
end;

function TRepositorioIcmsSn101.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIcmsSn101.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioIcmsSn101.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIcmsSn101.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item,  origem, aliquota_credito_sn)   '+
             ' values (:codigo_item, :origem, :aliquota_credito_sn) ';
end;

end.
