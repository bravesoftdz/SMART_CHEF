unit RepositorioLocalEntregaNotaFiscal;

interface

uses
  DB,
  Repositorio;
  
type
  TRepositorioLocalEntregaNotaFiscal = class(TRepositorio)
  
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
  LocalEntregaNotaFiscal,
  SysUtils;

{ TRepositorioLocalEntregaNotaFiscal }

function TRepositorioLocalEntregaNotaFiscal.Get(
  Dataset: TDataSet): TObject;
var
  LE :TLocalEntregaNotaFiscal;
begin
   LE := TLocalEntregaNotaFiscal.Create;
   LE.CnpjCpf         := Dataset.FieldByName('cnpj_cpf').AsString;
   LE.Logradouro      := Dataset.FieldByName('logradouro').AsString;
   LE.Numero          := Dataset.FieldByName('numero').AsString;
   LE.Complemento     := Dataset.FieldByName('complemento').AsString;
   LE.Bairro          := Dataset.FieldByName('bairro').AsString;
   LE.CodigoMunicipio := Dataset.FieldByName('cod_mun').AsInteger;
   LE.NomeMunicipio   := Dataset.FieldByName('nome_mun').AsString;
   LE.UF              := Dataset.FieldByName('uf').AsString;
   LE.CEP             := Dataset.FieldByName('cep').AsString;

   result := LE;
end;

function TRepositorioLocalEntregaNotaFiscal.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TLocalEntregaNotaFiscal(Objeto).CodigoNotaFiscal;
end;

function TRepositorioLocalEntregaNotaFiscal.GetNomeDaTabela: String;
begin
   result := 'locais_entrega_notas_fiscais';
end;

function TRepositorioLocalEntregaNotaFiscal.GetRepositorio: TRepositorio;
begin
   result := TRepositorioLocalEntregaNotaFiscal.Create;
end;

function TRepositorioLocalEntregaNotaFiscal.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioLocalEntregaNotaFiscal.IsInsercao(
  Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioLocalEntregaNotaFiscal.SetParametros(
  Objeto: TObject);
var
  Obj :TLocalEntregaNotaFiscal;
begin
   Obj := (Objeto as TLocalEntregaNotaFiscal);

   inherited SetParametro('codigo_nota_fiscal', Obj.CodigoNotaFiscal);
   inherited SetParametro('cnpj_cpf',           Obj.CnpjCpf);
   inherited SetParametro('logradouro',         Obj.Logradouro);
   inherited SetParametro('numero',             Obj.Numero);
   inherited SetParametro('bairro',             Obj.Bairro);
   inherited SetParametro('complemento',        Obj.Complemento);
   inherited SetParametro('cod_mun',            Obj.CodigoMunicipio);
   inherited SetParametro('nome_mun',           Obj.NomeMunicipio);
   inherited SetParametro('uf',                 Obj.UF);
   inherited SetParametro('cep',                Obj.CEP);
end;

function TRepositorioLocalEntregaNotaFiscal.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioLocalEntregaNotaFiscal.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioLocalEntregaNotaFiscal.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioLocalEntregaNotaFiscal.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+' (codigo_nota_fiscal,  cnpj_cpf,  logradouro, numero, complemento,      '+
                                                           'bairro, cod_mun, nome_mun,  uf, cep)                                  '+
                             '                        values (:codigo_nota_fiscal, :cnpj_cpf, :logradouro, :numero, :complemento,   '+
                             '                                :bairro, :cod_mun, :nome_mun,  :uf, :cep)                             ';
end;

end.
