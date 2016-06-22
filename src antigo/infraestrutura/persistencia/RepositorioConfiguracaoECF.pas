unit RepositorioConfiguracaoECF;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioConfiguracaoECF = class(TRepositorio)

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

uses SysUtils, ConfiguracaoECF;

{ TRepositorioConfiguracaoECF }

function TRepositorioConfiguracaoECF.Get(Dataset: TDataSet): TObject;
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
   ConfiguracaoECF:= TConfiguracaoECF.Create;
   ConfiguracaoECF.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   ConfiguracaoECF.modelo        := self.FQuery.FieldByName('modelo').AsString;
   ConfiguracaoECF.porta         := self.FQuery.FieldByName('porta').AsString;
   ConfiguracaoECF.timeout       := self.FQuery.FieldByName('timeout').AsInteger;
   ConfiguracaoECF.intervalo     := self.FQuery.FieldByName('intervalo').AsInteger;
   ConfiguracaoECF.linhas_buffer := self.FQuery.FieldByName('linhas_buffer').AsInteger;
   ConfiguracaoECF.tamanho_fonte := self.FQuery.FieldByName('tamanho_fonte').AsInteger;

   result := ConfiguracaoECF;
end;

function TRepositorioConfiguracaoECF.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TConfiguracaoECF(Objeto).Codigo;
end;

function TRepositorioConfiguracaoECF.GetNomeDaTabela: String;
begin
  result := 'CONFIGURACAO_ECF';
end;

function TRepositorioConfiguracaoECF.GetRepositorio: TRepositorio;
begin
  result := TRepositorioConfiguracaoECF.Create;
end;

function TRepositorioConfiguracaoECF.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TConfiguracaoECF(Objeto).Codigo <= 0);
end;

procedure TRepositorioConfiguracaoECF.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ConfiguracaoECFAntigo :TConfiguracaoECF;
  ConfiguracaoECFNovo :TConfiguracaoECF;
begin
   ConfiguracaoECFAntigo := (AntigoObjeto as TConfiguracaoECF);
   ConfiguracaoECFNovo   := (Objeto       as TConfiguracaoECF);

   if (ConfiguracaoECFAntigo.modelo <> ConfiguracaoECFNovo.modelo) then
     Auditoria.AdicionaCampoAlterado('modelo', ConfiguracaoECFAntigo.modelo, ConfiguracaoECFNovo.modelo);

   if (ConfiguracaoECFAntigo.porta <> ConfiguracaoECFNovo.porta) then
     Auditoria.AdicionaCampoAlterado('porta', ConfiguracaoECFAntigo.porta, ConfiguracaoECFNovo.porta);

   if (ConfiguracaoECFAntigo.timeout <> ConfiguracaoECFNovo.timeout) then
     Auditoria.AdicionaCampoAlterado('timeout', IntToStr(ConfiguracaoECFAntigo.timeout), IntToStr(ConfiguracaoECFNovo.timeout));

   if (ConfiguracaoECFAntigo.intervalo <> ConfiguracaoECFNovo.intervalo) then
     Auditoria.AdicionaCampoAlterado('intervalo', IntToStr(ConfiguracaoECFAntigo.intervalo), IntToStr(ConfiguracaoECFNovo.intervalo));

   if (ConfiguracaoECFAntigo.linhas_buffer <> ConfiguracaoECFNovo.linhas_buffer) then
     Auditoria.AdicionaCampoAlterado('linhas_buffer', IntToStr(ConfiguracaoECFAntigo.linhas_buffer), IntToStr(ConfiguracaoECFNovo.linhas_buffer));

   if (ConfiguracaoECFAntigo.tamanho_fonte <> ConfiguracaoECFNovo.tamanho_fonte) then
     Auditoria.AdicionaCampoAlterado('tamanho_fonte', IntToStr(ConfiguracaoECFAntigo.tamanho_fonte), IntToStr(ConfiguracaoECFNovo.tamanho_fonte));

end;

procedure TRepositorioConfiguracaoECF.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
  ConfiguracaoECF := (Objeto as TConfiguracaoECF);
  Auditoria.AdicionaCampoExcluido('codigo'       , IntToStr(ConfiguracaoECF.codigo));
  Auditoria.AdicionaCampoExcluido('modelo'       , ConfiguracaoECF.modelo);
  Auditoria.AdicionaCampoExcluido('porta'        , ConfiguracaoECF.porta);
  Auditoria.AdicionaCampoExcluido('timeout'      , IntToStr(ConfiguracaoECF.timeout));
  Auditoria.AdicionaCampoExcluido('intervalo'    , IntToStr(ConfiguracaoECF.intervalo));
  Auditoria.AdicionaCampoExcluido('linhas_buffer', IntToStr(ConfiguracaoECF.linhas_buffer));
  Auditoria.AdicionaCampoExcluido('tamanho_fonte', IntToStr(ConfiguracaoECF.tamanho_fonte));
end;

procedure TRepositorioConfiguracaoECF.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
  ConfiguracaoECF := (Objeto as TConfiguracaoECF);
  Auditoria.AdicionaCampoIncluido('codigo'       ,    IntToStr(ConfiguracaoECF.codigo));
  Auditoria.AdicionaCampoIncluido('modelo'       ,    ConfiguracaoECF.modelo);
  Auditoria.AdicionaCampoIncluido('porta'        ,    ConfiguracaoECF.porta);
  Auditoria.AdicionaCampoIncluido('timeout'      ,    IntToStr(ConfiguracaoECF.timeout));
  Auditoria.AdicionaCampoIncluido('intervalo'    ,    IntToStr(ConfiguracaoECF.intervalo));
  Auditoria.AdicionaCampoIncluido('linhas_buffer',    IntToStr(ConfiguracaoECF.linhas_buffer));
  Auditoria.AdicionaCampoIncluido('tamanho_fonte',    IntToStr(ConfiguracaoECF.tamanho_fonte));
end;

procedure TRepositorioConfiguracaoECF.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TConfiguracaoECF(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioConfiguracaoECF.SetParametros(Objeto: TObject);
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
  ConfiguracaoECF := (Objeto as TConfiguracaoECF);

  self.FQuery.ParamByName('codigo').AsInteger        := ConfiguracaoECF.codigo;
  self.FQuery.ParamByName('modelo').AsString        := ConfiguracaoECF.modelo;
  self.FQuery.ParamByName('porta').AsString         := ConfiguracaoECF.porta;
  self.FQuery.ParamByName('timeout').AsInteger       := ConfiguracaoECF.timeout;
  self.FQuery.ParamByName('intervalo').AsInteger     := ConfiguracaoECF.intervalo;
  self.FQuery.ParamByName('linhas_buffer').AsInteger := ConfiguracaoECF.linhas_buffer;
  self.FQuery.ParamByName('tamanho_fonte').AsInteger := ConfiguracaoECF.tamanho_fonte;
end;

function TRepositorioConfiguracaoECF.SQLGet: String;
begin
  result := 'select * from CONFIGURACAO_ECF where codigo = :ncod';
end;

function TRepositorioConfiguracaoECF.SQLGetAll: String;
begin
  result := 'select * from CONFIGURACAO_ECF';
end;

function TRepositorioConfiguracaoECF.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CONFIGURACAO_ECF where '+ campo +' = :ncampo';
end;

function TRepositorioConfiguracaoECF.SQLRemover: String;
begin
  result := ' delete from CONFIGURACAO_ECF where codigo = :codigo ';
end;

function TRepositorioConfiguracaoECF.SQLSalvar: String;
begin
  result := 'update or insert into CONFIGURACAO_ECF (CODIGO ,MODELO ,PORTA ,TIMEOUT ,INTERVALO ,LINHAS_BUFFER ,TAMANHO_FONTE) '+
           '                      values ( :CODIGO , :MODELO , :PORTA , :TIMEOUT , :INTERVALO , :LINHAS_BUFFER , :TAMANHO_FONTE) ';
end;

end.

