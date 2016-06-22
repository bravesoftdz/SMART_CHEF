unit RepositorioNcmIBPT;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioNcmIBPT = class(TRepositorio)

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

uses SysUtils, NcmIBPT;

{ TRepositorioNcmIBPT }

function TRepositorioNcmIBPT.Get(Dataset: TDataSet): TObject;
var
  NcmIBPT :TNcmIBPT;
begin
   NcmIBPT:= TNcmIBPT.Create;
   NcmIBPT.codigo                 := self.FQuery.FieldByName('codigo').AsInteger;
   NcmIBPT.ncm_ibpt               := self.FQuery.FieldByName('ncm_ibpt').AsString;
   NcmIBPT.ex_ibpt                := self.FQuery.FieldByName('ex_ibpt').AsString;
   NcmIBPT.tabela_ibpt            := self.FQuery.FieldByName('tabela_ibpt').AsString;
   NcmIBPT.aliqnacional_ibpt      := self.FQuery.FieldByName('aliqnacional_ibpt').AsFloat;
   NcmIBPT.aliqinternacional_ibpt := self.FQuery.FieldByName('aliqinternacional_ibpt').AsFloat;

   result := NcmIBPT;
end;

function TRepositorioNcmIBPT.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TNcmIBPT(Objeto).Codigo;
end;

function TRepositorioNcmIBPT.GetNomeDaTabela: String;
begin
  result := 'IBPT';
end;

function TRepositorioNcmIBPT.GetRepositorio: TRepositorio;
begin
  result := TRepositorioNcmIBPT.Create;
end;

function TRepositorioNcmIBPT.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TNcmIBPT(Objeto).Codigo <= 0);
end;

procedure TRepositorioNcmIBPT.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  NcmIBPTAntigo :TNcmIBPT;
  NcmIBPTNovo :TNcmIBPT;
begin
   NcmIBPTAntigo := (AntigoObjeto as TNcmIBPT);
   NcmIBPTNovo   := (Objeto       as TNcmIBPT);

   if (NcmIBPTAntigo.ncm_ibpt <> NcmIBPTNovo.ncm_ibpt) then
     Auditoria.AdicionaCampoAlterado('ncm_ibpt', NcmIBPTAntigo.ncm_ibpt, NcmIBPTNovo.ncm_ibpt);

   if (NcmIBPTAntigo.ex_ibpt <> NcmIBPTNovo.ex_ibpt) then
     Auditoria.AdicionaCampoAlterado('ex_ibpt', NcmIBPTAntigo.ex_ibpt, NcmIBPTNovo.ex_ibpt);

   if (NcmIBPTAntigo.tabela_ibpt <> NcmIBPTNovo.tabela_ibpt) then
     Auditoria.AdicionaCampoAlterado('tabela_ibpt', NcmIBPTAntigo.tabela_ibpt, NcmIBPTNovo.tabela_ibpt);

   if (NcmIBPTAntigo.aliqnacional_ibpt <> NcmIBPTNovo.aliqnacional_ibpt) then
     Auditoria.AdicionaCampoAlterado('aliqnacional_ibpt', FloatToStr(NcmIBPTAntigo.aliqnacional_ibpt), FloatToStr(NcmIBPTNovo.aliqnacional_ibpt));

   if (NcmIBPTAntigo.aliqinternacional_ibpt <> NcmIBPTNovo.aliqinternacional_ibpt) then
     Auditoria.AdicionaCampoAlterado('aliqinternacional_ibpt', FloatToStr(NcmIBPTAntigo.aliqinternacional_ibpt), FloatToStr(NcmIBPTNovo.aliqinternacional_ibpt));

end;

procedure TRepositorioNcmIBPT.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  NcmIBPT :TNcmIBPT;
begin
  NcmIBPT := (Objeto as TNcmIBPT);
  Auditoria.AdicionaCampoExcluido('codigo'                , IntToStr(NcmIBPT.codigo));
  Auditoria.AdicionaCampoExcluido('ncm_ibpt'              , NcmIBPT.ncm_ibpt);
  Auditoria.AdicionaCampoExcluido('ex_ibpt'               , NcmIBPT.ex_ibpt);
  Auditoria.AdicionaCampoExcluido('tabela_ibpt'           , NcmIBPT.tabela_ibpt);
  Auditoria.AdicionaCampoExcluido('aliqnacional_ibpt'     , FloatToStr(NcmIBPT.aliqnacional_ibpt));
  Auditoria.AdicionaCampoExcluido('aliqinternacional_ibpt', FloatToStr(NcmIBPT.aliqinternacional_ibpt));
end;

procedure TRepositorioNcmIBPT.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  NcmIBPT :TNcmIBPT;
begin
  NcmIBPT := (Objeto as TNcmIBPT);
  Auditoria.AdicionaCampoIncluido('codigo'                ,    IntToStr(NcmIBPT.codigo));
  Auditoria.AdicionaCampoIncluido('ncm_ibpt'              ,    NcmIBPT.ncm_ibpt);
  Auditoria.AdicionaCampoIncluido('ex_ibpt'               ,    NcmIBPT.ex_ibpt);
  Auditoria.AdicionaCampoIncluido('tabela_ibpt'           ,    NcmIBPT.tabela_ibpt);
  Auditoria.AdicionaCampoIncluido('aliqnacional_ibpt'     ,    FloatToStr(NcmIBPT.aliqnacional_ibpt));
  Auditoria.AdicionaCampoIncluido('aliqinternacional_ibpt',    FloatToStr(NcmIBPT.aliqinternacional_ibpt));
end;

procedure TRepositorioNcmIBPT.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TNcmIBPT(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioNcmIBPT.SetParametros(Objeto: TObject);
var
  NcmIBPT :TNcmIBPT;
begin
  NcmIBPT := (Objeto as TNcmIBPT);

  self.FQuery.ParamByName('codigo').AsInteger                 := NcmIBPT.codigo;
  self.FQuery.ParamByName('ncm_ibpt').AsString               := NcmIBPT.ncm_ibpt;
  self.FQuery.ParamByName('ex_ibpt').AsString                := NcmIBPT.ex_ibpt;
  self.FQuery.ParamByName('tabela_ibpt').AsString            := NcmIBPT.tabela_ibpt;
  self.FQuery.ParamByName('aliqnacional_ibpt').AsFloat      := NcmIBPT.aliqnacional_ibpt;
  self.FQuery.ParamByName('aliqinternacional_ibpt').AsFloat := NcmIBPT.aliqinternacional_ibpt;
end;

function TRepositorioNcmIBPT.SQLGet: String;
begin
  result := 'select * from IBPT where codigo = :ncod';
end;

function TRepositorioNcmIBPT.SQLGetAll: String;
begin
  result := 'select * from IBPT';
end;

function TRepositorioNcmIBPT.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from IBPT where '+ campo +' = :ncampo';
end;

function TRepositorioNcmIBPT.SQLRemover: String;
begin
  result := ' delete from IBPT where codigo = :codigo ';
end;

function TRepositorioNcmIBPT.SQLSalvar: String;
begin
  result := 'update or insert into IBPT (CODIGO ,NCM_IBPT ,EX_IBPT ,TABELA_IBPT ,ALIQNACIONAL_IBPT ,ALIQINTERNACIONAL_IBPT) '+
           '                      values ( :CODIGO , :NCM_IBPT , :EX_IBPT , :TABELA_IBPT , :ALIQNACIONAL_IBPT , :ALIQINTERNACIONAL_IBPT) ';
end;

end.

