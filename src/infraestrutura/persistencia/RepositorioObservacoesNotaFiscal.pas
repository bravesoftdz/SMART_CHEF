unit RepositorioObservacoesNotaFiscal;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioObservacoesNotaFiscal = class(TRepositorio)

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
  ObservacaoNotaFiscal,
  SysUtils;

{ TRepositorioObservacoesNotaFiscal }

function TRepositorioObservacoesNotaFiscal.Get(Dataset: TDataSet): TObject;
begin
   result := TObservacaoNotaFiscal.CriaParaRepositorio(Dataset.FieldByName('observacoes').AsString,
                                                       Dataset.FieldByName('obs_ger_pelo_sistema').AsString);
end;

function TRepositorioObservacoesNotaFiscal.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TObservacaoNotaFiscal(Objeto).CodigoNotaFiscal;
end;

function TRepositorioObservacoesNotaFiscal.GetNomeDaTabela: String;
begin
   result := 'observacoes_notas_fiscais';
end;

function TRepositorioObservacoesNotaFiscal.GetRepositorio: TRepositorio;
begin
   result := TRepositorioObservacoesNotaFiscal.Create;
end;

function TRepositorioObservacoesNotaFiscal.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioObservacoesNotaFiscal.IsInsercao(
  Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioObservacoesNotaFiscal.SetParametros(Objeto: TObject);
var
  Obs :TObservacaoNotaFiscal;
begin
   Obs := (Objeto as TObservacaoNotaFiscal);

   inherited SetParametro('codigo_nota_fiscal',   Obs.CodigoNotaFiscal);
   inherited SetParametro('observacoes',          Obs.Observacoes);
   inherited SetParametro('obs_ger_pelo_sistema', Obs.ObservacoesGeradasPeloSistema);
end;

function TRepositorioObservacoesNotaFiscal.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_Fiscal';
end;

function TRepositorioObservacoesNotaFiscal.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela;
end;

function TRepositorioObservacoesNotaFiscal.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal';
end;

function TRepositorioObservacoesNotaFiscal.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+'  (codigo_nota_fiscal,   observacoes, obs_ger_pelo_sistema)     '+
                                                      'values (:codigo_nota_fiscal,  :observacoes, :obs_ger_pelo_sistema)     ';

end;

end.
