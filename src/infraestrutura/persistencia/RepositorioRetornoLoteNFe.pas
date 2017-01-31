unit RepositorioRetornoLoteNFe;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioRetornoLoteNFe = class(TRepositorio)

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
  RetornoLoteNFe,
  SysUtils;

{ TRepositorioRetornoLoteNFe }

function TRepositorioRetornoLoteNFe.Get(Dataset: TDataSet): TObject;
begin
   result := TRetornoLoteNFe.Create(Dataset.FieldByName('codigo_lote').AsInteger,
                                    Dataset.FieldByName('status').AsString,
                                    Dataset.FieldByName('motivo').AsString,
                                    Dataset.FieldByName('recibo').AsString);
end;

function TRepositorioRetornoLoteNFe.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TRetornoLoteNFe(Objeto).CodigoLote;
end;

function TRepositorioRetornoLoteNFe.GetNomeDaTabela: String;
begin
   result := 'lotes_nfe_retorno';
end;

function TRepositorioRetornoLoteNFe.GetRepositorio: TRepositorio;
begin
   result := TRepositorioRetornoLoteNFe.Create;
end;

function TRepositorioRetornoLoteNFe.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioRetornoLoteNFe.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true; 
end;

procedure TRepositorioRetornoLoteNFe.SetParametros(Objeto: TObject);
var
  Ret :TRetornoLoteNFe;
begin
   Ret := (Objeto as TRetornoLoteNFe);

   inherited SetParametro('codigo_lote', Ret.CodigoLote);
   inherited SetParametro('status',      Ret.Status);
   inherited SetParametro('motivo',      Ret.Motivo);
   inherited SetParametro('recibo',      Ret.Recibo);   
end;

function TRepositorioRetornoLoteNFe.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_lote = :codigo_lote ';
end;

function TRepositorioRetornoLoteNFe.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' order by codigo_lote ';
end;

function TRepositorioRetornoLoteNFe.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_lote = :codigo_lote ';
end;

function TRepositorioRetornoLoteNFe.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+'  (codigo_lote,    status,  motivo,  recibo) '+
                                                      'values (:codigo_lote,  :status, :motivo, :recibo) ';
end;

end.
