unit RepositorioSangriaReforco;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioSangriaReforco = class(TRepositorio)

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

uses SysUtils, SangriaReforco, funcoes;

{ TRepositorioSangriaReforco }

function TRepositorioSangriaReforco.Get(Dataset: TDataSet): TObject;
var
  SangriaReforco :TSangriaReforco;
begin
   SangriaReforco:= TSangriaReforco.Create;
   SangriaReforco.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   SangriaReforco.codigo_caixa   := self.FQuery.FieldByName('codigo_caixa').AsInteger;
   SangriaReforco.codigo_usuario := self.FQuery.FieldByName('codigo_usuario').AsInteger;
   SangriaReforco.tipo           := self.FQuery.FieldByName('tipo').AsString;
   SangriaReforco.valor          := self.FQuery.FieldByName('valor').AsFloat;
   SangriaReforco.descricao      := self.FQuery.FieldByName('descricao').AsString;
   SangriaReforco.tipo_moeda     := self.FQuery.FieldByName('tipo_moeda').AsInteger;

   result := SangriaReforco;
end;

function TRepositorioSangriaReforco.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TSangriaReforco(Objeto).Codigo;
end;

function TRepositorioSangriaReforco.GetNomeDaTabela: String;
begin
  result := 'SANGRIA_REFORCO';
end;

function TRepositorioSangriaReforco.GetRepositorio: TRepositorio;
begin
  result := TRepositorioSangriaReforco.Create;
end;

function TRepositorioSangriaReforco.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TSangriaReforco(Objeto).Codigo <= 0);
end;

procedure TRepositorioSangriaReforco.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  SangriaReforcoAntigo :TSangriaReforco;
  SangriaReforcoNovo :TSangriaReforco;
begin
   SangriaReforcoAntigo := (AntigoObjeto as TSangriaReforco);
   SangriaReforcoNovo   := (Objeto       as TSangriaReforco);

   if (SangriaReforcoAntigo.codigo_caixa <> SangriaReforcoNovo.codigo_caixa) then
     Auditoria.AdicionaCampoAlterado('codigo_caixa', IntToStr(SangriaReforcoAntigo.codigo_caixa), IntToStr(SangriaReforcoNovo.codigo_caixa));

   if (SangriaReforcoAntigo.codigo_usuario <> SangriaReforcoNovo.codigo_usuario) then
     Auditoria.AdicionaCampoAlterado('codigo_usuario', IntToStr(SangriaReforcoAntigo.codigo_usuario), IntToStr(SangriaReforcoNovo.codigo_usuario));

   if (SangriaReforcoAntigo.tipo <> SangriaReforcoNovo.tipo) then
     Auditoria.AdicionaCampoAlterado('tipo', SangriaReforcoAntigo.tipo, SangriaReforcoNovo.tipo);

   if (SangriaReforcoAntigo.valor <> SangriaReforcoNovo.valor) then
     Auditoria.AdicionaCampoAlterado('valor', FloatToStr(SangriaReforcoAntigo.valor), FloatToStr(SangriaReforcoNovo.valor));

   if (SangriaReforcoAntigo.descricao <> SangriaReforcoNovo.descricao) then
     Auditoria.AdicionaCampoAlterado('descricao', SangriaReforcoAntigo.descricao, SangriaReforcoNovo.descricao);

   if (SangriaReforcoAntigo.tipo_moeda <> SangriaReforcoNovo.tipo_moeda) then
     Auditoria.AdicionaCampoAlterado('tipo_moeda', IntToStr(SangriaReforcoAntigo.tipo_moeda), IntToStr(SangriaReforcoNovo.tipo_moeda));

end;

procedure TRepositorioSangriaReforco.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  SangriaReforco :TSangriaReforco;
begin
  SangriaReforco := (Objeto as TSangriaReforco);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(SangriaReforco.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_caixa'  , IntToStr(SangriaReforco.codigo_caixa));
  Auditoria.AdicionaCampoExcluido('codigo_usuario', IntToStr(SangriaReforco.codigo_usuario));
  Auditoria.AdicionaCampoExcluido('tipo'          , SangriaReforco.tipo);
  Auditoria.AdicionaCampoExcluido('valor'         , FloatToStr(SangriaReforco.valor));
  Auditoria.AdicionaCampoExcluido('descricao'     , SangriaReforco.descricao);
  Auditoria.AdicionaCampoExcluido('tipo_moeda'    , IntToStr(SangriaReforco.tipo_moeda));
end;

procedure TRepositorioSangriaReforco.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  SangriaReforco :TSangriaReforco;
begin
  SangriaReforco := (Objeto as TSangriaReforco);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(SangriaReforco.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_caixa'  ,    IntToStr(SangriaReforco.codigo_caixa));
  Auditoria.AdicionaCampoIncluido('codigo_usuario',    IntToStr(SangriaReforco.codigo_usuario));
  Auditoria.AdicionaCampoIncluido('tipo'          ,    SangriaReforco.tipo);
  Auditoria.AdicionaCampoIncluido('valor'         ,    FloatToStr(SangriaReforco.valor));
  Auditoria.AdicionaCampoIncluido('descricao'     ,    SangriaReforco.descricao);
  Auditoria.AdicionaCampoIncluido('tipo_moeda'    , IntToStr(SangriaReforco.tipo_moeda));
end;

procedure TRepositorioSangriaReforco.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TSangriaReforco(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioSangriaReforco.SetParametros(Objeto: TObject);
var
  SangriaReforco :TSangriaReforco;
begin
  SangriaReforco := (Objeto as TSangriaReforco);

  self.FQuery.ParamByName('codigo').AsInteger         := SangriaReforco.codigo;
  self.FQuery.ParamByName('codigo_caixa').AsInteger   := StrToInt(Maior_Valor_Cadastrado('CAIXA','CODIGO'));
  self.FQuery.ParamByName('codigo_usuario').AsInteger := SangriaReforco.codigo_usuario;
  self.FQuery.ParamByName('tipo').AsString            := SangriaReforco.tipo;
  self.FQuery.ParamByName('valor').AsFloat            := SangriaReforco.valor;
  self.FQuery.ParamByName('descricao').AsString       := SangriaReforco.descricao;
  self.FQuery.ParamByName('tipo_moeda').AsInteger     := SangriaReforco.tipo_moeda;
end;

function TRepositorioSangriaReforco.SQLGet: String;
begin
  result := 'select * from SANGRIA_REFORCO where codigo = :ncod';
end;

function TRepositorioSangriaReforco.SQLGetAll: String;
begin
  result := 'select * from SANGRIA_REFORCO';
end;

function TRepositorioSangriaReforco.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from SANGRIA_REFORCO where '+ campo +' = :ncampo';
end;

function TRepositorioSangriaReforco.SQLRemover: String;
begin
  result := ' delete from SANGRIA_REFORCO where codigo = :codigo ';
end;

function TRepositorioSangriaReforco.SQLSalvar: String;
begin
  result := 'update or insert into SANGRIA_REFORCO (CODIGO ,CODIGO_CAIXA ,CODIGO_USUARIO ,TIPO ,VALOR ,DESCRICAO, TIPO_MOEDA) '+
           '                      values ( :CODIGO , :CODIGO_CAIXA , :CODIGO_USUARIO , :TIPO , :VALOR , :DESCRICAO, :TIPO_MOEDA) ';
end;

end.

