unit RepositorioDepartamento;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioDepartamento = class(TRepositorio)

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

  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses SysUtils, Departamento;

{ TRepositorioDepartamento }

function TRepositorioDepartamento.Get(Dataset: TDataSet): TObject;
var
  Departamento :TDepartamento;
begin
   Departamento:= TDepartamento.Create;
   Departamento.codigo             := self.FQuery.FieldByName('codigo').AsInteger;
   Departamento.nome               := self.FQuery.FieldByName('nome').AsString;
   Departamento.porta_lpt := self.FQuery.FieldByName('porta_lpt').AsString;

   result := Departamento;
end;

function TRepositorioDepartamento.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TDepartamento(Objeto).Codigo;
end;

function TRepositorioDepartamento.GetNomeDaTabela: String;
begin
  result := 'DEPARTAMENTOS';
end;

function TRepositorioDepartamento.GetRepositorio: TRepositorio;
begin
  result := TRepositorioDepartamento.Create;
end;

function TRepositorioDepartamento.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TDepartamento(Objeto).Codigo <= 0);
end;

procedure TRepositorioDepartamento.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  DepartamentoAntigo :TDepartamento;
  DepartamentoNovo :TDepartamento;
begin
   DepartamentoAntigo := (AntigoObjeto as TDepartamento);
   DepartamentoNovo   := (Objeto       as TDepartamento);

   if (DepartamentoAntigo.nome <> DepartamentoNovo.nome) then
     Auditoria.AdicionaCampoAlterado('nome', DepartamentoAntigo.nome, DepartamentoNovo.nome);

   if (DepartamentoAntigo.porta_lpt <> DepartamentoNovo.porta_lpt) then
     Auditoria.AdicionaCampoAlterado('porta_lpt', DepartamentoAntigo.porta_lpt, DepartamentoNovo.porta_lpt);

end;

procedure TRepositorioDepartamento.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Departamento :TDepartamento;
begin
  Departamento := (Objeto as TDepartamento);
  Auditoria.AdicionaCampoExcluido('codigo'            , IntToStr(Departamento.codigo));
  Auditoria.AdicionaCampoExcluido('nome'              , Departamento.nome);
  Auditoria.AdicionaCampoExcluido('porta_lpt', Departamento.porta_lpt);
end;

procedure TRepositorioDepartamento.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Departamento :TDepartamento;
begin
  Departamento := (Objeto as TDepartamento);
  Auditoria.AdicionaCampoIncluido('codigo'            ,    IntToStr(Departamento.codigo));
  Auditoria.AdicionaCampoIncluido('nome'              ,    Departamento.nome);
  Auditoria.AdicionaCampoIncluido('porta_lpt',    Departamento.porta_lpt);
end;

procedure TRepositorioDepartamento.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TDepartamento(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioDepartamento.SetParametros(Objeto: TObject);
var
  Departamento :TDepartamento;
begin
  Departamento := (Objeto as TDepartamento);

  self.FQuery.ParamByName('codigo').AsInteger             := Departamento.codigo;
  self.FQuery.ParamByName('nome').AsString               := Departamento.nome;
  self.FQuery.ParamByName('porta_lpt').AsString := Departamento.porta_lpt;
end;

function TRepositorioDepartamento.SQLGet: String;
begin
  result := 'select * from DEPARTAMENTOS where codigo = :ncod';
end;

function TRepositorioDepartamento.SQLGetAll: String;
begin
  result := 'select * from DEPARTAMENTOS';
end;

function TRepositorioDepartamento.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from DEPARTAMENTOS where '+ campo +' = :ncampo';
end;

function TRepositorioDepartamento.SQLRemover: String;
begin
  result := ' delete from DEPARTAMENTOS where codigo = :codigo ';
end;

function TRepositorioDepartamento.SQLSalvar: String;
begin
  result := 'update or insert into DEPARTAMENTOS (CODIGO ,NOME ,porta_lpt) '+
           '                      values (:CODIGO , :NOME , :porta_lpt) ';
end;

end.

