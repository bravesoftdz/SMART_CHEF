unit RepositorioVersao;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioVersao = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;      override;

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

uses Versao;

{ TRepositorioVersao }

function TRepositorioVersao.Get(Dataset: TDataSet): TObject;
var
  Versao :TVersao;
begin
   Versao                    := TVersao.Create;
   Versao.Codigo             := self.FQuery.FieldByName('codigo').AsInteger;
   Versao.VersaoBancoDeDados := self.FQuery.FieldByName('versao_banco_de_dados').AsInteger;

   result := Versao;
end;

function TRepositorioVersao.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TVersao(Objeto).Codigo;
end;

function TRepositorioVersao.GetNomeDaTabela: String;
begin
   result := 'PARAMETROS';
end;

function TRepositorioVersao.GetRepositorio: TRepositorio;
begin
   result := TRepositorioVersao.Create;
end;

function TRepositorioVersao.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TVersao(Objeto).Codigo <= 0);
end;

procedure TRepositorioVersao.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TVersao(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioVersao.SetParametros(Objeto: TObject);
var
  Versao :TVersao;
begin
   Versao := (Objeto as TVersao);

   if (Versao.Codigo > 0) then inherited SetParametro('codigo', Versao.Codigo)
   else                            inherited LimpaParametro('codigo');

   inherited SetParametro('versao_banco_de_dados', Versao.VersaoBancoDeDados);
end;

function TRepositorioVersao.SQLGet: String;
begin
   result := ' select * from parametros where (codigo = 1) and (:migue = 0) ';
end;

function TRepositorioVersao.SQLGetAll: String;
begin
   result := ' select * from parametros ';
end;

function TRepositorioVersao.SQLGetExiste(campo: String): String;
begin
   result := 'select '+ campo +' from '+ self.GetNomeDaTabela+' where '+ campo +' = :ncampo';
end;

function TRepositorioVersao.SQLRemover: String;
begin
   result := ' delete from parametros where (codigo >= 0) and (:migue >= 0)';
end;

function TRepositorioVersao.SQLSalvar: String;
begin
   result := ' update or insert into parametros (codigo, versao_banco_de_dados) values (:codigo, :versao_banco_de_dados) ';
end;

end.
