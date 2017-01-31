unit RepositorioRetornoNFe;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioRetornoNFe = class(TRepositorio)

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
  RetornoNFe,
  SysUtils;

{ TRepositorioRetornoNFe }

function TRepositorioRetornoNFe.Get(Dataset: TDataSet): TObject;
begin
   result := TRetornoNFe.Create(Dataset.FieldByName('codigo_nota_fiscal').AsInteger,
                                Dataset.FieldByName('status').AsString,
                                Dataset.FieldByName('motivo').AsString);
end;

function TRepositorioRetornoNFe.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TRetornoNFe(Objeto).CodigoNotaFiscal;
end;

function TRepositorioRetornoNFe.GetNomeDaTabela: String;
begin
   result := 'notas_fiscais_nfe_retorno';
end;

function TRepositorioRetornoNFe.GetRepositorio: TRepositorio;
begin
   result := TRepositorioRetornoNFe.Create;
end;

function TRepositorioRetornoNFe.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioRetornoNFe.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioRetornoNFe.SetParametros(Objeto: TObject);
var
  RetornoNFe :TRetornoNFe;
begin
   RetornoNFe := (Objeto as TRetornoNFe);

   inherited SetParametro('codigo_nota_fiscal', RetornoNFe.CodigoNotaFiscal);
   inherited SetParametro('status',             RetornoNFe.Status);
   inherited SetParametro('motivo',             RetornoNFe.Motivo);
end;

function TRepositorioRetornoNFe.SQLGet: String;
begin
   result := ' select * from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioRetornoNFe.SQLGetAll: String;
begin
   result := ' select * from '+ self.GetNomeDaTabela+' order by codigo_nota_fiscal '; 
end;

function TRepositorioRetornoNFe.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioRetornoNFe.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+'  (codigo_nota_fiscal,    status,  motivo) '+
                                                      'values (:codigo_nota_fiscal,  :status, :motivo) ';
end;

end.
