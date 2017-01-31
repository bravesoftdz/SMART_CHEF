unit RepositorioNaturezaOperacao;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioNaturezaOperacao = class(TRepositorio)

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

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  //==============================================================================
  // Auditoria
  //==============================================================================
end;

implementation

uses
  SysUtils,
  NaturezaOperacao;


{ TRepositorioNaturezaOperacao }

function TRepositorioNaturezaOperacao.Get(Dataset: TDataSet): TObject;
var
  NaturezaOperacao :TNaturezaOperacao;
begin
   NaturezaOperacao           := TNaturezaOperacao.Create;
   NaturezaOperacao.Codigo    := Dataset.FieldByName('codigo').AsInteger;
   NaturezaOperacao.Descricao := Dataset.FieldByName('descricao').AsString;
   NaturezaOperacao.CFOP      := Dataset.FieldByName('cfop').AsString;
   NaturezaOperacao.suspensao_icms := Dataset.FieldByName('suspensao_icms').AsString;

   result := NaturezaOperacao;
end;

function TRepositorioNaturezaOperacao.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TNaturezaOperacao(Objeto).Codigo;
end;

function TRepositorioNaturezaOperacao.GetNomeDaTabela: String;
begin
   result := 'naturezas_operacao';
end;

function TRepositorioNaturezaOperacao.GetRepositorio: TRepositorio;
begin
   result := TRepositorioNaturezaOperacao.Create;
end;

function TRepositorioNaturezaOperacao.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TNaturezaOperacao(Objeto).Codigo <= 0);
end;

procedure TRepositorioNaturezaOperacao.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TNaturezaOperacao(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioNaturezaOperacao.SetParametros(Objeto: TObject);
var
  obj :TNaturezaOperacao;
begin
  obj := (Objeto as TNaturezaOperacao);

  if (obj.Codigo > 0) then inherited SetParametro('codigo', obj.Codigo)
  else                     inherited LimpaParametro('codigo');

  inherited SetParametro('descricao', Obj.Descricao);
  inherited SetParametro('cfop',      Obj.CFOP);
  inherited SetParametro('suspensao_icms',      Obj.suspensao_icms);
end;

function TRepositorioNaturezaOperacao.SQLGet: String;
begin
   result := ' select * from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioNaturezaOperacao.SQLGetAll: String;
begin
   result := ' select * from '+self.GetNomeDaTabela+' order by codigo ';
end;

function TRepositorioNaturezaOperacao.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo = :codigo ';
end;

function TRepositorioNaturezaOperacao.SQLSalvar: String;
begin
   result := ' update or insert into '+self.GetNomeDaTabela+' (codigo, descricao, cfop, suspensao_icms)      '+
             '                                         values (:codigo, :descricao, :cfop, :suspensao_icms)  ';
end;

end.
