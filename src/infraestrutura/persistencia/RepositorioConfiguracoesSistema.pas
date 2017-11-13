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
   ConfiguracoesSistema.possuiBoliche           := self.FQuery.FieldByName('possui_boliche').AsString = '0';
   ConfiguracoesSistema.possuiDispensadora      := self.FQuery.FieldByName('possui_dispensadora').AsString = '0';
   ConfiguracoesSistema.duasViasPedido          := self.FQuery.FieldByName('duas_vias_pedido').AsString = '0';
   ConfiguracoesSistema.precoProdutoAlteravel   := self.FQuery.FieldByName('preco_produto_alteravel').AsString = '0';
   ConfiguracoesSistema.utilizaComandas         := self.FQuery.FieldByName('Utiliza_comandas').AsString = '0';
   ConfiguracoesSistema.possuiDelivery          := self.FQuery.FieldByName('possui_delivery').AsString = '0';
   ConfiguracoesSistema.impDepEspacada          := self.FQuery.FieldByName('imp_dep_espacada').AsString = '0';
   ConfiguracoesSistema.descontoPedido          := self.FQuery.FieldByName('desconto_pedido').AsString = '0';
   ConfiguracoesSistema.impressoesParciais      := self.FQuery.FieldByName('impressoes_parciais').AsString = '0';
   ConfiguracoesSistema.perguntaImprimirPedido  := self.FQuery.FieldByName('pergunta_imprimir_pedido').AsString = '0';
   ConfiguracoesSistema.controlaValidade        := self.FQuery.FieldByName('controla_validade').AsString = '0';

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

   if (ConfiguracoesSistemaAntigo.possuiBoliche <> ConfiguracoesSistemaNovo.possuiBoliche) then
     Auditoria.AdicionaCampoAlterado('possui_boliche', IfThen(ConfiguracoesSistemaAntigo.possuiBoliche,'0','1'), IfThen(ConfiguracoesSistemaNovo.possuiBoliche,'0','1'));

   if (ConfiguracoesSistemaAntigo.possuiDispensadora <> ConfiguracoesSistemaNovo.possuiDispensadora) then
     Auditoria.AdicionaCampoAlterado('possui_dispensadora', IfThen(ConfiguracoesSistemaAntigo.possuiDispensadora,'0','1'), IfThen(ConfiguracoesSistemaNovo.possuiDispensadora,'0','1'));

   if (ConfiguracoesSistemaAntigo.duasViasPedido <> ConfiguracoesSistemaNovo.duasViasPedido) then
     Auditoria.AdicionaCampoAlterado('duas_vias_pedido', IfThen(ConfiguracoesSistemaAntigo.duasViasPedido,'0','1'), IfThen(ConfiguracoesSistemaNovo.duasViasPedido,'0','1'));

   if (ConfiguracoesSistemaAntigo.precoProdutoAlteravel <> ConfiguracoesSistemaNovo.precoProdutoAlteravel) then
     Auditoria.AdicionaCampoAlterado('preco_produto_alteravel', IfThen(ConfiguracoesSistemaAntigo.precoProdutoAlteravel,'0','1'), IfThen(ConfiguracoesSistemaNovo.precoProdutoAlteravel,'0','1'));

   if (ConfiguracoesSistemaAntigo.utilizaComandas <> ConfiguracoesSistemaNovo.utilizaComandas) then
     Auditoria.AdicionaCampoAlterado('Utiliza_comandas', IfThen(ConfiguracoesSistemaAntigo.utilizaComandas,'0','1'), IfThen(ConfiguracoesSistemaNovo.utilizaComandas,'0','1'));

   if (ConfiguracoesSistemaAntigo.possuiDelivery <> ConfiguracoesSistemaNovo.possuiDelivery) then
     Auditoria.AdicionaCampoAlterado('possui_delivery', IfThen(ConfiguracoesSistemaAntigo.possuiDelivery,'0','1'), IfThen(ConfiguracoesSistemaNovo.possuiDelivery,'0','1'));

   if (ConfiguracoesSistemaAntigo.impDepEspacada <> ConfiguracoesSistemaNovo.impDepEspacada) then
     Auditoria.AdicionaCampoAlterado('imp_dep_espacada', IfThen(ConfiguracoesSistemaAntigo.impDepEspacada,'0','1'), IfThen(ConfiguracoesSistemaNovo.impDepEspacada,'0','1'));

   if (ConfiguracoesSistemaAntigo.descontoPedido <> ConfiguracoesSistemaNovo.descontoPedido) then
     Auditoria.AdicionaCampoAlterado('desconto_pedido', IfThen(ConfiguracoesSistemaAntigo.descontoPedido,'0','1'), IfThen(ConfiguracoesSistemaNovo.descontoPedido,'0','1'));

   if (ConfiguracoesSistemaAntigo.impressoesParciais <> ConfiguracoesSistemaNovo.impressoesParciais) then
     Auditoria.AdicionaCampoAlterado('impressoes_parciais', IfThen(ConfiguracoesSistemaAntigo.impressoesParciais,'0','1'), IfThen(ConfiguracoesSistemaNovo.impressoesParciais,'0','1'));

   if (ConfiguracoesSistemaAntigo.perguntaImprimirPedido <> ConfiguracoesSistemaNovo.perguntaImprimirPedido) then
     Auditoria.AdicionaCampoAlterado('pergunta_imprimir_pedido', IfThen(ConfiguracoesSistemaAntigo.perguntaImprimirPedido,'0','1'), IfThen(ConfiguracoesSistemaNovo.perguntaImprimirPedido,'0','1'));

   if (ConfiguracoesSistemaAntigo.controlaValidade <> ConfiguracoesSistemaNovo.controlaValidade) then
     Auditoria.AdicionaCampoAlterado('controla_validade', IfThen(ConfiguracoesSistemaAntigo.controlaValidade,'0','1'), IfThen(ConfiguracoesSistemaNovo.controlaValidade,'0','1'));
end;

procedure TRepositorioConfiguracoesSistema.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  ConfiguracoesSistema := (Objeto as TConfiguracoesSistema);
  Auditoria.AdicionaCampoExcluido('codigo'             , IntToStr(ConfiguracoesSistema.codigo));
  Auditoria.AdicionaCampoExcluido('possui_boliche'     , IfThen(ConfiguracoesSistema.possuiBoliche,'0','1'));
  Auditoria.AdicionaCampoExcluido('possui_dispensadora', IfThen(ConfiguracoesSistema.possuiDispensadora,'0','1'));
  Auditoria.AdicionaCampoExcluido('duas_vias_pedido'   , IfThen(ConfiguracoesSistema.duasViasPedido,'0','1'));
  Auditoria.AdicionaCampoExcluido('preco_produto_alteravel'   , IfThen(ConfiguracoesSistema.precoProdutoAlteravel,'0','1'));
  Auditoria.AdicionaCampoExcluido('Utiliza_comandas'   , IfThen(ConfiguracoesSistema.utilizaComandas,'0','1'));
  Auditoria.AdicionaCampoExcluido('possui_delivery'    , IfThen(ConfiguracoesSistema.possuiDelivery,'0','1'));
  Auditoria.AdicionaCampoExcluido('imp_dep_espacada'    , IfThen(ConfiguracoesSistema.impDepEspacada,'0','1'));
  Auditoria.AdicionaCampoExcluido('desconto_pedido'    , IfThen(ConfiguracoesSistema.descontoPedido,'0','1'));
  Auditoria.AdicionaCampoExcluido('impressoes_parciais' , IfThen(ConfiguracoesSistema.impressoesParciais,'0','1'));
  Auditoria.AdicionaCampoExcluido('pergunta_imprimir_pedido' , IfThen(ConfiguracoesSistema.perguntaImprimirPedido,'0','1'));
  Auditoria.AdicionaCampoExcluido('controla_validade'   , IfThen(ConfiguracoesSistema.controlaValidade,'0','1'));
end;

procedure TRepositorioConfiguracoesSistema.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  ConfiguracoesSistema := (Objeto as TConfiguracoesSistema);
  Auditoria.AdicionaCampoIncluido('codigo'             , IntToStr(ConfiguracoesSistema.codigo));
  Auditoria.AdicionaCampoIncluido('possui_boliche'     , IfThen(ConfiguracoesSistema.possuiBoliche,'0','1'));
  Auditoria.AdicionaCampoIncluido('possui_dispensadora', IfThen(ConfiguracoesSistema.possuiDispensadora,'0','1'));
  Auditoria.AdicionaCampoIncluido('duas_vias_pedido'   , IfThen(ConfiguracoesSistema.duasViasPedido,'0','1'));
  Auditoria.AdicionaCampoIncluido('preco_produto_alteravel'   , IfThen(ConfiguracoesSistema.precoProdutoAlteravel,'0','1'));
  Auditoria.AdicionaCampoIncluido('Utiliza_comandas'   , IfThen(ConfiguracoesSistema.utilizaComandas,'0','1'));
  Auditoria.AdicionaCampoIncluido('possui_delivery'    , IfThen(ConfiguracoesSistema.possuiDelivery,'0','1'));
  Auditoria.AdicionaCampoIncluido('imp_dep_espacada'    , IfThen(ConfiguracoesSistema.impDepEspacada,'0','1'));
  Auditoria.AdicionaCampoIncluido('desconto_pedido'    , IfThen(ConfiguracoesSistema.descontoPedido,'0','1'));
  Auditoria.AdicionaCampoIncluido('impressoes_parciais' , IfThen(ConfiguracoesSistema.impressoesParciais,'0','1'));
  Auditoria.AdicionaCampoIncluido('pergunta_imprimir_pedido' , IfThen(ConfiguracoesSistema.perguntaImprimirPedido,'0','1'));
  Auditoria.AdicionaCampoIncluido('controla_validade'   , IfThen(ConfiguracoesSistema.controlaValidade,'0','1'));
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
  self.FQuery.ParamByName('possui_boliche').AsInteger      := IfThen(ConfiguracoesSistema.possuiBoliche,0,1);
  self.FQuery.ParamByName('possui_dispensadora').AsInteger := IfThen(ConfiguracoesSistema.possuiDispensadora,0,1);
  self.FQuery.ParamByName('duas_vias_pedido').AsInteger    := IfThen(ConfiguracoesSistema.duasViasPedido,0,1);
  self.FQuery.ParamByName('preco_produto_alteravel').AsInteger    := IfThen(ConfiguracoesSistema.precoProdutoAlteravel,0,1);
  self.FQuery.ParamByName('Utiliza_comandas').AsInteger    := IfThen(ConfiguracoesSistema.utilizaComandas,0,1);
  self.FQuery.ParamByName('possui_delivery').AsInteger     := IfThen(ConfiguracoesSistema.possuiDelivery,0,1);
  self.FQuery.ParamByName('imp_dep_espacada').AsInteger    := IfThen(ConfiguracoesSistema.impDepEspacada,0,1);
  self.FQuery.ParamByName('desconto_pedido').AsInteger     := IfThen(ConfiguracoesSistema.descontoPedido,0,1);
  self.FQuery.ParamByName('impressoes_parciais').AsInteger := IfThen(ConfiguracoesSistema.impressoesParciais,0,1);
  self.FQuery.ParamByName('pergunta_imprimir_pedido').AsInteger := IfThen(ConfiguracoesSistema.perguntaImprimirPedido,0,1);
  self.FQuery.ParamByName('controla_validade').AsInteger   := IfThen(ConfiguracoesSistema.controlaValidade,0,1);
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
  result := 'update or insert into CONFIGURACOES_SISTEMA (CODIGO ,POSSUI_BOLICHE ,POSSUI_DISPENSADORA ,DUAS_VIAS_PEDIDO,                     '+
            '                                             preco_produto_alteravel, Utiliza_comandas, possui_delivery, imp_dep_espacada,      '+
            '                                             desconto_pedido, impressoes_parciais, pergunta_imprimir_pedido, controla_validade) '+
            '                                     values ( :CODIGO , :POSSUI_BOLICHE , :POSSUI_DISPENSADORA , :DUAS_VIAS_PEDIDO,             '+
            '                                              :preco_produto_alteravel, :Utiliza_comandas, :possui_delivery, :imp_dep_espacada, '+
            '                                              :desconto_pedido, :impressoes_parciais, :pergunta_imprimir_pedido, :controla_validade) ';
end;

end.

