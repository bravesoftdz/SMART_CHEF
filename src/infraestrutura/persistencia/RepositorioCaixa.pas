unit RepositorioCaixa;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioCaixa = class(TRepositorio)

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

uses SysUtils, Caixa;

{ TRepositorioCaixa }

function TRepositorioCaixa.Get(Dataset: TDataSet): TObject;
var
  Caixa :TCaixa;
begin
   Caixa:= TCaixa.Create;
   Caixa.codigo           := self.FQuery.FieldByName('codigo').AsInteger;
   Caixa.data_abertura    := self.FQuery.FieldByName('data_abertura').AsDateTime;
   Caixa.valor_abertura   := self.FQuery.FieldByName('valor_abertura').AsFloat;
   Caixa.data_fechamento  := self.FQuery.FieldByName('data_fechamento').AsDateTime;
   Caixa.valor_fechamento := self.FQuery.FieldByName('valor_fechamento').AsFloat;

   result := Caixa;
end;

function TRepositorioCaixa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TCaixa(Objeto).Codigo;
end;

function TRepositorioCaixa.GetNomeDaTabela: String;
begin
  result := 'CAIXA';
end;

function TRepositorioCaixa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioCaixa.Create;
end;

function TRepositorioCaixa.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TCaixa(Objeto).Codigo <= 0);
end;

procedure TRepositorioCaixa.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  CaixaAntigo :TCaixa;
  CaixaNovo :TCaixa;
begin
   CaixaAntigo := (AntigoObjeto as TCaixa);
   CaixaNovo   := (Objeto       as TCaixa);

   if (CaixaAntigo.data_abertura <> CaixaNovo.data_abertura) then
     Auditoria.AdicionaCampoAlterado('data_abertura', DateTimeToStr(CaixaAntigo.data_abertura), DateTimeToStr(CaixaNovo.data_abertura));

   if (CaixaAntigo.valor_abertura <> CaixaNovo.valor_abertura) then
     Auditoria.AdicionaCampoAlterado('valor_abertura', FloatToStr(CaixaAntigo.valor_abertura), FloatToStr(CaixaNovo.valor_abertura));

   if (CaixaAntigo.data_fechamento <> CaixaNovo.data_fechamento) then
     Auditoria.AdicionaCampoAlterado('data_fechamento', DateTimeToStr(CaixaAntigo.data_fechamento), DateTimeToStr(CaixaNovo.data_fechamento));

   if (CaixaAntigo.valor_fechamento <> CaixaNovo.valor_fechamento) then
     Auditoria.AdicionaCampoAlterado('valor_fechamento', FloatToStr(CaixaAntigo.valor_fechamento), FloatToStr(CaixaNovo.valor_fechamento));

end;

procedure TRepositorioCaixa.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Caixa :TCaixa;
begin
  Caixa := (Objeto as TCaixa);
  Auditoria.AdicionaCampoExcluido('codigo'          , IntToStr(Caixa.codigo));
  Auditoria.AdicionaCampoExcluido('data_abertura'   , DateTimeToStr(Caixa.data_abertura));
  Auditoria.AdicionaCampoExcluido('valor_abertura'  , FloatToStr(Caixa.valor_abertura));
  Auditoria.AdicionaCampoExcluido('data_fechamento' , DateTimeToStr(Caixa.data_fechamento));
  Auditoria.AdicionaCampoExcluido('valor_fechamento', FloatToStr(Caixa.valor_fechamento));
end;

procedure TRepositorioCaixa.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Caixa :TCaixa;
begin
  Caixa := (Objeto as TCaixa);
  Auditoria.AdicionaCampoIncluido('codigo'          ,    IntToStr(Caixa.codigo));
  Auditoria.AdicionaCampoIncluido('data_abertura'   ,    DateTimeToStr(Caixa.data_abertura));
  Auditoria.AdicionaCampoIncluido('valor_abertura'  ,    FloatToStr(Caixa.valor_abertura));
  Auditoria.AdicionaCampoIncluido('data_fechamento' ,    DateTimeToStr(Caixa.data_fechamento));
  Auditoria.AdicionaCampoIncluido('valor_fechamento',    FloatToStr(Caixa.valor_fechamento));
end;

procedure TRepositorioCaixa.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TCaixa(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioCaixa.SetParametros(Objeto: TObject);
var
  Caixa :TCaixa;
begin
  Caixa := (Objeto as TCaixa);

  self.FQuery.ParamByName('codigo').AsInteger           := Caixa.codigo;
  self.FQuery.ParamByName('data_abertura').AsDateTime    := Caixa.data_abertura;
  self.FQuery.ParamByName('valor_abertura').AsFloat   := Caixa.valor_abertura;
  self.FQuery.ParamByName('data_fechamento').AsDateTime  := Caixa.data_fechamento;
  self.FQuery.ParamByName('valor_fechamento').AsFloat := Caixa.valor_fechamento;
end;

function TRepositorioCaixa.SQLGet: String;
begin
  result := 'select * from CAIXA where codigo = :ncod';
end;

function TRepositorioCaixa.SQLGetAll: String;
begin
  result := 'select * from CAIXA';
end;

function TRepositorioCaixa.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CAIXA where '+ campo +' = :ncampo';
end;

function TRepositorioCaixa.SQLRemover: String;
begin
  result := ' delete from CAIXA where codigo = :codigo ';
end;

function TRepositorioCaixa.SQLSalvar: String;
begin
  result := 'update or insert into CAIXA (CODIGO ,DATA_ABERTURA ,VALOR_ABERTURA ,DATA_FECHAMENTO ,VALOR_FECHAMENTO) '+
           '                      values ( :CODIGO , :DATA_ABERTURA , :VALOR_ABERTURA , :DATA_FECHAMENTO , :VALOR_FECHAMENTO) ';
end;

end.

