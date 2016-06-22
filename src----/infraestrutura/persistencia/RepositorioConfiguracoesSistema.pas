unit RepositorioConfiguracoesSistema;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioConfiguracoesSistema = class(TRepositorio)

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

uses SysUtils, ConfiguracoesSistema, Math, StrUtils;

{ TRepositorioConfiguracoesSistema }

function TRepositorioConfiguracoesSistema.Get(Dataset: TDataSet): TObject;
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
   ConfiguracoesSistema                         := TConfiguracoesSistema.Create;
   ConfiguracoesSistema.codigo                  := self.FQuery.FieldByName('codigo').AsInteger;
   ConfiguracoesSistema.possui_boliche          := self.FQuery.FieldByName('possui_boliche').AsString = '0';
   ConfiguracoesSistema.possui_dispensadora     := self.FQuery.FieldByName('possui_dispensadora').AsString = '0';
   ConfiguracoesSistema.duas_vias_pedido        := self.FQuery.FieldByName('duas_vias_pedido').AsString = '0';
   ConfiguracoesSistema.preco_produto_alteravel := self.FQuery.FieldByName('preco_produto_alteravel').AsString = '0';
   ConfiguracoesSistema.Utiliza_comandas        := self.FQuery.FieldByName('Utiliza_comandas').AsString = '0';
   ConfiguracoesSistema.possui_delivery         := self.FQuery.FieldByName('possui_delivery').AsString = '0';
   ConfiguracoesSistema.imp_dep_espacada        := self.FQuery.FieldByName('imp_dep_espacada').AsString = '0';

   result := ConfiguracoesSistema;
end;

function TRepositorioConfiguracoesSistema.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TConfiguracoesSistema(Objeto).Codigo;
end;

function TRepositorioConfiguracoesSistema.GetNomeDaTabela: String;
begin
  result := 'CONFIGURACOES_SISTEMA';
end;

function TRepositorioConfiguracoesSistema.GetRepositorio: TRepositorio;
begin
  result := TRepositorioConfiguracoesSistema.Create;
end;

function TRepositorioConfiguracoesSistema.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TConfiguracoesSistema(Objeto).Codigo <= 0);
end;

procedure TRepositorioConfiguracoesSistema.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ConfiguracoesSistemaAntigo :TConfiguracoesSistema;
  ConfiguracoesSistemaNovo :TConfiguracoesSistema;
begin
   ConfiguracoesSistemaAntigo := (AntigoObjeto as TConfiguracoesSistema);
   ConfiguracoesSistemaNovo   := (Objeto       as TConfiguracoesSistema);

   if (ConfiguracoesSistemaAntigo.possui_boliche <> ConfiguracoesSistemaNovo.possui_boliche) then
     Auditoria.AdicionaCampoAlterado('possui_boliche', IfThen(ConfiguracoesSistemaAntigo.possui_boliche,'0','1'), IfThen(ConfiguracoesSistemaNovo.possui_boliche,'0','1'));

   if (ConfiguracoesSistemaAntigo.possui_dispensadora <> ConfiguracoesSistemaNovo.possui_dispensadora) then
     Auditoria.AdicionaCampoAlterado('possui_dispensadora', IfThen(ConfiguracoesSistemaAntigo.possui_dispensadora,'0','1'), IfThen(ConfiguracoesSistemaNovo.possui_dispensadora,'0','1'));

   if (ConfiguracoesSistemaAntigo.duas_vias_pedido <> ConfiguracoesSistemaNovo.duas_vias_pedido) then
     Auditoria.AdicionaCampoAlterado('duas_vias_pedido', IfThen(ConfiguracoesSistemaAntigo.duas_vias_pedido,'0','1'), IfThen(ConfiguracoesSistemaNovo.duas_vias_pedido,'0','1'));

   if (ConfiguracoesSistemaAntigo.preco_produto_alteravel <> ConfiguracoesSistemaNovo.preco_produto_alteravel) then
     Auditoria.AdicionaCampoAlterado('preco_produto_alteravel', IfThen(ConfiguracoesSistemaAntigo.preco_produto_alteravel,'0','1'), IfThen(ConfiguracoesSistemaNovo.preco_produto_alteravel,'0','1'));

   if (ConfiguracoesSistemaAntigo.Utiliza_comandas <> ConfiguracoesSistemaNovo.Utiliza_comandas) then
     Auditoria.AdicionaCampoAlterado('Utiliza_comandas', IfThen(ConfiguracoesSistemaAntigo.Utiliza_comandas,'0','1'), IfThen(ConfiguracoesSistemaNovo.Utiliza_comandas,'0','1'));

   if (ConfiguracoesSistemaAntigo.possui_delivery <> ConfiguracoesSistemaNovo.possui_delivery) then
     Auditoria.AdicionaCampoAlterado('possui_delivery', IfThen(ConfiguracoesSistemaAntigo.possui_delivery,'0','1'), IfThen(ConfiguracoesSistemaNovo.possui_delivery,'0','1'));

   if (ConfiguracoesSistemaAntigo.imp_dep_espacada <> ConfiguracoesSistemaNovo.imp_dep_espacada) then
     Auditoria.AdicionaCampoAlterado('imp_dep_espacada', IfThen(ConfiguracoesSistemaAntigo.imp_dep_espacada,'0','1'), IfThen(ConfiguracoesSistemaNovo.imp_dep_espacada,'0','1'));
end;

procedure TRepositorioConfiguracoesSistema.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  ConfiguracoesSistema := (Objeto as TConfiguracoesSistema);
  Auditoria.AdicionaCampoExcluido('codigo'             , IntToStr(ConfiguracoesSistema.codigo));
  Auditoria.AdicionaCampoExcluido('possui_boliche'     , IfThen(ConfiguracoesSistema.possui_boliche,'0','1'));
  Auditoria.AdicionaCampoExcluido('possui_dispensadora', IfThen(ConfiguracoesSistema.possui_dispensadora,'0','1'));
  Auditoria.AdicionaCampoExcluido('duas_vias_pedido'   , IfThen(ConfiguracoesSistema.duas_vias_pedido,'0','1'));
  Auditoria.AdicionaCampoExcluido('preco_produto_alteravel'   , IfThen(ConfiguracoesSistema.preco_produto_alteravel,'0','1'));
  Auditoria.AdicionaCampoExcluido('Utiliza_comandas'   , IfThen(ConfiguracoesSistema.Utiliza_comandas,'0','1'));
  Auditoria.AdicionaCampoExcluido('possui_delivery'    , IfThen(ConfiguracoesSistema.possui_delivery,'0','1'));
  Auditoria.AdicionaCampoExcluido('imp_dep_espacada'    , IfThen(ConfiguracoesSistema.imp_dep_espacada,'0','1'));
end;

procedure TRepositorioConfiguracoesSistema.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  ConfiguracoesSistema := (Objeto as TConfiguracoesSistema);
  Auditoria.AdicionaCampoIncluido('codigo'             , IntToStr(ConfiguracoesSistema.codigo));
  Auditoria.AdicionaCampoIncluido('possui_boliche'     , IfThen(ConfiguracoesSistema.possui_boliche,'0','1'));
  Auditoria.AdicionaCampoIncluido('possui_dispensadora', IfThen(ConfiguracoesSistema.possui_dispensadora,'0','1'));
  Auditoria.AdicionaCampoIncluido('duas_vias_pedido'   , IfThen(ConfiguracoesSistema.duas_vias_pedido,'0','1'));
  Auditoria.AdicionaCampoIncluido('preco_produto_alteravel'   , IfThen(ConfiguracoesSistema.preco_produto_alteravel,'0','1'));
  Auditoria.AdicionaCampoIncluido('Utiliza_comandas'   , IfThen(ConfiguracoesSistema.Utiliza_comandas,'0','1'));
  Auditoria.AdicionaCampoIncluido('possui_delivery'    , IfThen(ConfiguracoesSistema.possui_delivery,'0','1'));
  Auditoria.AdicionaCampoIncluido('imp_dep_espacada'    , IfThen(ConfiguracoesSistema.imp_dep_espacada,'0','1'));
end;

procedure TRepositorioConfiguracoesSistema.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TConfiguracoesSistema(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioConfiguracoesSistema.SetParametros(Objeto: TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  ConfiguracoesSistema := (Objeto as TConfiguracoesSistema);

  self.FQuery.ParamByName('codigo').AsInteger              := ConfiguracoesSistema.codigo;
  self.FQuery.ParamByName('possui_boliche').AsInteger      := IfThen(ConfiguracoesSistema.possui_boliche,0,1);
  self.FQuery.ParamByName('possui_dispensadora').AsInteger := IfThen(ConfiguracoesSistema.possui_dispensadora,0,1);
  self.FQuery.ParamByName('duas_vias_pedido').AsInteger    := IfThen(ConfiguracoesSistema.duas_vias_pedido,0,1);
  self.FQuery.ParamByName('preco_produto_alteravel').AsInteger    := IfThen(ConfiguracoesSistema.preco_produto_alteravel,0,1);
  self.FQuery.ParamByName('Utiliza_comandas').AsInteger    := IfThen(ConfiguracoesSistema.Utiliza_comandas,0,1);
  self.FQuery.ParamByName('possui_delivery').AsInteger := IfThen(ConfiguracoesSistema.possui_delivery,0,1);
  self.FQuery.ParamByName('imp_dep_espacada').AsInteger := IfThen(ConfiguracoesSistema.imp_dep_espacada,0,1);
end;

function TRepositorioConfiguracoesSistema.SQLGet: String;
begin
  result := 'select * from CONFIGURACOES_SISTEMA where codigo = :ncod';
end;

function TRepositorioConfiguracoesSistema.SQLGetAll: String;
begin
  result := 'select * from CONFIGURACOES_SISTEMA';
end;

function TRepositorioConfiguracoesSistema.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CONFIGURACOES_SISTEMA where '+ campo +' = :ncampo';
end;

function TRepositorioConfiguracoesSistema.SQLRemover: String;
begin
  result := ' delete from CONFIGURACOES_SISTEMA where codigo = :codigo ';
end;

function TRepositorioConfiguracoesSistema.SQLSalvar: String;
begin
  result := 'update or insert into CONFIGURACOES_SISTEMA (CODIGO ,POSSUI_BOLICHE ,POSSUI_DISPENSADORA ,DUAS_VIAS_PEDIDO, preco_produto_alteravel, Utiliza_comandas, possui_delivery, imp_dep_espacada) '+
           '                      values ( :CODIGO , :POSSUI_BOLICHE , :POSSUI_DISPENSADORA , :DUAS_VIAS_PEDIDO, :preco_produto_alteravel, :Utiliza_comandas, :possui_delivery, :imp_dep_espacada) ';
end;

end.

