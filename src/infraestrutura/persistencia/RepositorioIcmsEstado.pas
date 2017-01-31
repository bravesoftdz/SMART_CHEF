unit RepositorioIcmsEstado;

interface

uses DB, Repositorio;

type
  TRepositorioIcmsEstado = class(TRepositorio)

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

uses SysUtils, IcmsEstado;

{ TRepositorioIcmsEstado }

function TRepositorioIcmsEstado.Get(Dataset: TDataSet): TObject;
var
  IcmsEstado :TIcmsEstado;
begin
   IcmsEstado:= TIcmsEstado.Create;
   IcmsEstado.codigo          := self.FQuery.FieldByName('codigo').AsInteger;
   IcmsEstado.codigo_estado   := self.FQuery.FieldByName('codigo_estado').AsInteger;
   IcmsEstado.perc_reducao_bc := self.FQuery.FieldByName('perc_reducao_bc').AsFloat;
   IcmsEstado.aliquota_icms   := self.FQuery.FieldByName('aliquota_icms').AsFloat;
   result := IcmsEstado;
end;

function TRepositorioIcmsEstado.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TIcmsEstado(Objeto).Codigo;
end;

function TRepositorioIcmsEstado.GetNomeDaTabela: String;
begin
  result := 'ICMS_ESTADO';
end;

function TRepositorioIcmsEstado.GetRepositorio: TRepositorio;
begin
  result := TRepositorioIcmsEstado.Create;
end;

function TRepositorioIcmsEstado.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TIcmsEstado(Objeto).Codigo <= 0);
end;

procedure TRepositorioIcmsEstado.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TIcmsEstado(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioIcmsEstado.SetParametros(Objeto: TObject);
var
  IcmsEstado :TIcmsEstado;
begin
  IcmsEstado := (Objeto as TIcmsEstado);

  self.FQuery.ParamByName('codigo').AsInteger          := IcmsEstado.codigo;
  self.FQuery.ParamByName('codigo_estado').AsInteger   := IcmsEstado.codigo_estado;
  self.FQuery.ParamByName('perc_reducao_bc').AsFloat   := IcmsEstado.perc_reducao_bc;
  self.FQuery.ParamByName('aliquota_icms').AsFloat     := IcmsEstado.aliquota_icms;
end;

function TRepositorioIcmsEstado.SQLGet: String;
begin
  result := 'select * from ICMS_ESTADO where codigo = :ncod';
end;

function TRepositorioIcmsEstado.SQLGetAll: String;
begin
  result := 'select * from ICMS_ESTADO';
end;

function TRepositorioIcmsEstado.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ICMS_ESTADO where '+ campo +' = :ncampo';
end;

function TRepositorioIcmsEstado.SQLRemover: String;
begin
  result := ' delete from ICMS_ESTADO where codigo = :codigo ';
end;

function TRepositorioIcmsEstado.SQLSalvar: String;
begin
  result := 'update or insert into ICMS_ESTADO ( CODIGO ,CODIGO_ESTADO ,PERC_REDUCAO_BC, ALIQUOTA_ICMS) '+
           '                      values ( :CODIGO , :CODIGO_ESTADO , :PERC_REDUCAO_BC, :ALIQUOTA_ICMS) ';
end;

end.

