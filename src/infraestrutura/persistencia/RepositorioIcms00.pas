unit RepositorioIcms00;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioIcms00 = class(TRepositorio)

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
  Icms00,
  TipoOrigemMercadoria,
  SysUtils;

{ TRepositorioIcms00 }

function TRepositorioIcms00.Get(Dataset: TDataSet): TObject;
begin
   result := TIcms00.Create(TTipoOrigemMercadoriaUtilitario.DeIntegerParaEnumerado(Dataset.FieldByName('origem').AsInteger),
                            Dataset.FieldByName('aliquota').AsFloat,
                            Dataset.FieldByName('perc_reducao_bc').AsFloat);
end;

function TRepositorioIcms00.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TIcms00(Objeto).CodigoItem;
end;

function TRepositorioIcms00.GetNomeDaTabela: String;
begin
   result := 'itens_nf_icms_00';
end;

function TRepositorioIcms00.GetRepositorio: TRepositorio;
begin
   result := TRepositorioIcms00.Create;
end;

function TRepositorioIcms00.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioIcms00.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioIcms00.SetParametros(Objeto: TObject);
var
  Obj :TIcms00;
begin
   Obj := (Objeto as TIcms00);

   inherited SetParametro('codigo_item',     Obj.CodigoItem);
   inherited SetParametro('origem',          TTipoOrigemMercadoriaUtilitario.DeEnumeradoParaInteger(Obj.OrigemMercadoria));
   inherited SetParametro('aliquota',        Obj.Aliquota);
   inherited SetParametro('perc_reducao_bc', Obj.PercReducaoBC);
end;

function TRepositorioIcms00.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIcms00.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioIcms00.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_item = :codigo_item';
end;

function TRepositorioIcms00.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo_item,  origem, aliquota, perc_reducao_bc)   '+
             ' values (:codigo_item, :origem, :aliquota, :perc_reducao_bc) ';
end;

end.
