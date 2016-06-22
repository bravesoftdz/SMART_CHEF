unit RepositorioEmpresa;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioEmpresa = class(TRepositorio)

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

uses SysUtils, Empresa, Math, StrUtils;

{ TRepositorioEmpresa }

function TRepositorioEmpresa.Get(Dataset: TDataSet): TObject;
var
  Empresa :TEmpresa;
begin
   Empresa:= TEmpresa.Create;
   Empresa.codigo                 := self.FQuery.FieldByName('codigo').AsInteger;
   Empresa.razao_social           := self.FQuery.FieldByName('razao_social').AsString;
   Empresa.nome_fantasia          := self.FQuery.FieldByName('nome_fantasia').AsString;
   Empresa.cnpj                   := self.FQuery.FieldByName('cnpj').AsString;
   Empresa.ie                     := self.FQuery.FieldByName('ie').AsString;
   Empresa.telefone               := self.FQuery.FieldByName('telefone').AsString;
   Empresa.site                   := self.FQuery.FieldByName('site').AsString;
   Empresa.quantidade_mesas       := self.FQuery.FieldByName('quantidade_mesas').AsInteger;
   Empresa.couvert                := (self.FQuery.FieldByName('couvert').AsString = 'S');
   Empresa.valor_couvert          := self.FQuery.FieldByName('valor_couvert').AsFloat;
   Empresa.cidade                 := self.FQuery.FieldByName('cidade').AsString;
   Empresa.taxa_servico           := self.FQuery.FieldByName('taxa_servico').AsFloat;
   Empresa.aliquota_couvert       := self.FQuery.FieldByName('aliquota_couvert').AsFloat;
   Empresa.aliquota_txservico     := self.FQuery.FieldByName('aliquota_txservico').AsFloat;
   Empresa.tributacao_couvert     := self.FQuery.FieldByName('tributacao_couvert').AsString;
   Empresa.tributacao_txservico   := self.FQuery.FieldByName('tributacao_txservico').AsString;
   Empresa.diretorio_boliche      := self.FQuery.FieldByName('diretorio_boliche').AsString;
   Empresa.diretorio_dispensadora := self.FQuery.FieldByName('diretorio_dispensadora').AsString;
   Empresa.estado                 := self.FQuery.FieldByName('estado').AsString;
   Empresa.cep                    := self.FQuery.FieldByName('cep').AsInteger;
   Empresa.rua                    := self.FQuery.FieldByName('rua').AsString;
   Empresa.numero                 := self.FQuery.FieldByName('numero').AsString;
   Empresa.bairro                 := self.FQuery.FieldByName('bairro').AsString;
   Empresa.complemento            := self.FQuery.FieldByName('complemento').AsString;
   Empresa.cod_municipio          := self.FQuery.FieldByName('cod_municipio').AsInteger;
   Empresa.taxa_entrega           := self.FQuery.FieldByName('taxa_entrega').AsFloat;

   result := Empresa;
end;

function TRepositorioEmpresa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEmpresa(Objeto).Codigo;
end;

function TRepositorioEmpresa.GetNomeDaTabela: String;
begin
  result := 'EMPRESA';
end;

function TRepositorioEmpresa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEmpresa.Create;
end;

function TRepositorioEmpresa.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEmpresa(Objeto).Codigo <= 0);
end;

procedure TRepositorioEmpresa.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  EmpresaAntigo :TEmpresa;
  EmpresaNovo :TEmpresa;
begin
   EmpresaAntigo := (AntigoObjeto as TEmpresa);
   EmpresaNovo   := (Objeto       as TEmpresa);

   if (EmpresaAntigo.razao_social <> EmpresaNovo.razao_social) then
     Auditoria.AdicionaCampoAlterado('razao_social', EmpresaAntigo.razao_social, EmpresaNovo.razao_social);

   if (EmpresaAntigo.nome_fantasia <> EmpresaNovo.nome_fantasia) then
     Auditoria.AdicionaCampoAlterado('nome_fantasia', EmpresaAntigo.nome_fantasia, EmpresaNovo.nome_fantasia);

   if (EmpresaAntigo.cnpj <> EmpresaNovo.cnpj) then
     Auditoria.AdicionaCampoAlterado('cnpj', EmpresaAntigo.cnpj, EmpresaNovo.cnpj);

   if (EmpresaAntigo.ie <> EmpresaNovo.ie) then
     Auditoria.AdicionaCampoAlterado('ie', EmpresaAntigo.ie, EmpresaNovo.ie);

   if (EmpresaAntigo.telefone <> EmpresaNovo.telefone) then
     Auditoria.AdicionaCampoAlterado('telefone', EmpresaAntigo.telefone, EmpresaNovo.telefone);

   if (EmpresaAntigo.site <> EmpresaNovo.site) then
     Auditoria.AdicionaCampoAlterado('site', EmpresaAntigo.site, EmpresaNovo.site);

   if (EmpresaAntigo.quantidade_mesas <> EmpresaNovo.quantidade_mesas) then
     Auditoria.AdicionaCampoAlterado('quantidade_mesas', IntToStr(EmpresaAntigo.quantidade_mesas), IntToStr(EmpresaNovo.quantidade_mesas));

   if (EmpresaAntigo.couvert <> EmpresaNovo.couvert) then
     Auditoria.AdicionaCampoAlterado('couvert', IfThen(EmpresaAntigo.Couvert, 'S', 'N'), IfThen(EmpresaNovo.Couvert, 'S', 'N'));

   if (EmpresaAntigo.valor_couvert <> EmpresaNovo.valor_couvert) then
     Auditoria.AdicionaCampoAlterado('valor_couvert', FloatToStr(EmpresaAntigo.valor_couvert), FloatToStr(EmpresaNovo.valor_couvert));

   if (EmpresaAntigo.cidade <> EmpresaNovo.cidade) then
     Auditoria.AdicionaCampoAlterado('cidade', EmpresaAntigo.cidade, EmpresaNovo.cidade);

   if (EmpresaAntigo.taxa_servico <> EmpresaNovo.taxa_servico) then
     Auditoria.AdicionaCampoAlterado('taxa_servico', FloatToStr(EmpresaAntigo.taxa_servico), FloatToStr(EmpresaNovo.taxa_servico));

   if (EmpresaAntigo.aliquota_couvert <> EmpresaNovo.aliquota_couvert) then
     Auditoria.AdicionaCampoAlterado('aliquota_couvert', FloatToStr(EmpresaAntigo.aliquota_couvert), FloatToStr(EmpresaNovo.aliquota_couvert));

   if (EmpresaAntigo.aliquota_txservico <> EmpresaNovo.aliquota_txservico) then
     Auditoria.AdicionaCampoAlterado('aliquota_txservico', FloatToStr(EmpresaAntigo.aliquota_txservico), FloatToStr(EmpresaNovo.aliquota_txservico));

   if (EmpresaAntigo.tributacao_couvert <> EmpresaNovo.tributacao_couvert) then
     Auditoria.AdicionaCampoAlterado('tributacao_couvert', EmpresaAntigo.tributacao_couvert, EmpresaNovo.tributacao_couvert);

   if (EmpresaAntigo.tributacao_txservico <> EmpresaNovo.tributacao_txservico) then
     Auditoria.AdicionaCampoAlterado('tributacao_txservico', EmpresaAntigo.tributacao_txservico, EmpresaNovo.tributacao_txservico);

   if (EmpresaAntigo.diretorio_boliche <> EmpresaNovo.diretorio_boliche) then
     Auditoria.AdicionaCampoAlterado('diretorio_boliche', EmpresaAntigo.diretorio_boliche, EmpresaNovo.diretorio_boliche);

   if (EmpresaAntigo.diretorio_dispensadora <> EmpresaNovo.diretorio_dispensadora) then
     Auditoria.AdicionaCampoAlterado('diretorio_dispensadora', EmpresaAntigo.diretorio_dispensadora, EmpresaNovo.diretorio_dispensadora);

   if (EmpresaAntigo.estado <> EmpresaNovo.estado) then
     Auditoria.AdicionaCampoAlterado('estado', EmpresaAntigo.estado, EmpresaNovo.estado);

   if (EmpresaAntigo.cep <> EmpresaNovo.cep) then
     Auditoria.AdicionaCampoAlterado('cep', IntToStr(EmpresaAntigo.cep), IntToStr(EmpresaNovo.cep));

   if (EmpresaAntigo.rua <> EmpresaNovo.rua) then
     Auditoria.AdicionaCampoAlterado('rua', EmpresaAntigo.rua, EmpresaNovo.rua);

   if (EmpresaAntigo.numero <> EmpresaNovo.numero) then
     Auditoria.AdicionaCampoAlterado('numero', EmpresaAntigo.numero, EmpresaNovo.numero);

   if (EmpresaAntigo.bairro <> EmpresaNovo.bairro) then
     Auditoria.AdicionaCampoAlterado('bairro', EmpresaAntigo.bairro, EmpresaNovo.bairro);

   if (EmpresaAntigo.complemento <> EmpresaNovo.complemento) then
     Auditoria.AdicionaCampoAlterado('complemento', EmpresaAntigo.complemento, EmpresaNovo.complemento);

   if (EmpresaAntigo.cod_municipio <> EmpresaNovo.cod_municipio) then
     Auditoria.AdicionaCampoAlterado('cod_municipio', IntToStr(EmpresaAntigo.cod_municipio), IntToStr(EmpresaNovo.cod_municipio));

   if (EmpresaAntigo.taxa_entrega <> EmpresaNovo.taxa_entrega) then
     Auditoria.AdicionaCampoAlterado('taxa_entrega', FloatToStr(EmpresaAntigo.taxa_entrega), FloatToStr(EmpresaNovo.taxa_entrega));

end;

procedure TRepositorioEmpresa.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Empresa :TEmpresa;
begin
  Empresa := (Objeto as TEmpresa);
  Auditoria.AdicionaCampoExcluido('codigo'                , IntToStr(Empresa.codigo));
  Auditoria.AdicionaCampoExcluido('razao_social'          , Empresa.razao_social);
  Auditoria.AdicionaCampoExcluido('nome_fantasia'         , Empresa.nome_fantasia);
  Auditoria.AdicionaCampoExcluido('cnpj'                  , Empresa.cnpj);
  Auditoria.AdicionaCampoExcluido('ie'                    , Empresa.ie);
  Auditoria.AdicionaCampoExcluido('telefone'              , Empresa.telefone);
  Auditoria.AdicionaCampoExcluido('site'                  , Empresa.site);
  Auditoria.AdicionaCampoExcluido('quantidade_mesas'      , IntToStr(Empresa.quantidade_mesas));
  Auditoria.AdicionaCampoExcluido('couvert'               , IfThen(Empresa.couvert, 'S', 'N'));
  Auditoria.AdicionaCampoExcluido('valor_couvert'         , FloatToStr(Empresa.valor_couvert));
  Auditoria.AdicionaCampoExcluido('cidade'                , Empresa.cidade);
  Auditoria.AdicionaCampoExcluido('taxa_servico'          , FloatToStr(Empresa.taxa_servico));
  Auditoria.AdicionaCampoExcluido('aliquota_couvert'      , FloatToStr(Empresa.aliquota_couvert));
  Auditoria.AdicionaCampoExcluido('aliquota_txservico'    , FloatToStr(Empresa.aliquota_txservico));
  Auditoria.AdicionaCampoExcluido('tributacao_couvert'    , Empresa.tributacao_couvert);
  Auditoria.AdicionaCampoExcluido('tributacao_txservico'  , Empresa.tributacao_txservico);
  Auditoria.AdicionaCampoExcluido('diretorio_boliche'     , Empresa.diretorio_boliche);
  Auditoria.AdicionaCampoExcluido('diretorio_dispensadora', Empresa.diretorio_dispensadora);
  Auditoria.AdicionaCampoExcluido('estado'                , Empresa.estado);
  Auditoria.AdicionaCampoExcluido('cep'                   , IntToStr(Empresa.cep));
  Auditoria.AdicionaCampoExcluido('rua'                   , Empresa.rua);
  Auditoria.AdicionaCampoExcluido('numero'                , Empresa.numero);
  Auditoria.AdicionaCampoExcluido('bairro'                , Empresa.bairro);
  Auditoria.AdicionaCampoExcluido('complemento'           , Empresa.complemento);
  Auditoria.AdicionaCampoExcluido('cod_municipio'         , IntToStr(Empresa.cod_municipio));
  Auditoria.AdicionaCampoExcluido('taxa_entrega'          , FloatToStr(Empresa.taxa_entrega));
end;

procedure TRepositorioEmpresa.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Empresa :TEmpresa;
begin
  Empresa := (Objeto as TEmpresa);
  Auditoria.AdicionaCampoIncluido('codigo'                ,    IntToStr(Empresa.codigo));
  Auditoria.AdicionaCampoIncluido('razao_social'          ,    Empresa.razao_social);
  Auditoria.AdicionaCampoIncluido('nome_fantasia'         ,    Empresa.nome_fantasia);
  Auditoria.AdicionaCampoIncluido('cnpj'                  ,    Empresa.cnpj);
  Auditoria.AdicionaCampoIncluido('ie'                    ,    Empresa.ie);
  Auditoria.AdicionaCampoIncluido('telefone'              ,    Empresa.telefone);
  Auditoria.AdicionaCampoIncluido('site'                  ,    Empresa.site);
  Auditoria.AdicionaCampoIncluido('quantidade_mesas'      ,    IntToStr(Empresa.quantidade_mesas));
  Auditoria.AdicionaCampoIncluido('couvert'               ,    IfThen(Empresa.couvert, 'S', 'N'));
  Auditoria.AdicionaCampoIncluido('valor_couvert'         ,    FloatToStr(Empresa.valor_couvert));
  Auditoria.AdicionaCampoIncluido('cidade'                ,    Empresa.cidade);
  Auditoria.AdicionaCampoIncluido('taxa_servico'          ,    FloatToStr(Empresa.taxa_servico));
  Auditoria.AdicionaCampoIncluido('aliquota_couvert'      ,    FloatToStr(Empresa.aliquota_couvert));
  Auditoria.AdicionaCampoIncluido('aliquota_txservico'    ,    FloatToStr(Empresa.aliquota_txservico));
  Auditoria.AdicionaCampoIncluido('tributacao_couvert'    ,    Empresa.tributacao_couvert);
  Auditoria.AdicionaCampoIncluido('tributacao_txservico'  ,    Empresa.tributacao_txservico);
  Auditoria.AdicionaCampoIncluido('diretorio_boliche'     ,    Empresa.diretorio_boliche);
  Auditoria.AdicionaCampoIncluido('diretorio_dispensadora',    Empresa.diretorio_dispensadora);
  Auditoria.AdicionaCampoIncluido('estado'                ,    Empresa.estado);
  Auditoria.AdicionaCampoIncluido('cep'                   ,    IntToStr(Empresa.cep));
  Auditoria.AdicionaCampoIncluido('rua'                   ,    Empresa.rua);
  Auditoria.AdicionaCampoIncluido('numero'                ,    Empresa.numero);
  Auditoria.AdicionaCampoIncluido('bairro'                ,    Empresa.bairro);
  Auditoria.AdicionaCampoIncluido('complemento'           ,    Empresa.complemento);
  Auditoria.AdicionaCampoIncluido('cod_municipio'         ,    IntToStr(Empresa.cod_municipio));
  Auditoria.AdicionaCampoIncluido('taxa_entrega'          , FloatToStr(Empresa.taxa_entrega));
end;

procedure TRepositorioEmpresa.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEmpresa(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEmpresa.SetParametros(Objeto: TObject);
var
  Empresa :TEmpresa;
begin
  Empresa := (Objeto as TEmpresa);

  self.FQuery.ParamByName('codigo').AsInteger                 := Empresa.codigo;
  self.FQuery.ParamByName('razao_social').AsString           := Empresa.razao_social;
  self.FQuery.ParamByName('nome_fantasia').AsString          := Empresa.nome_fantasia;
  self.FQuery.ParamByName('cnpj').AsString                   := Empresa.cnpj;
  self.FQuery.ParamByName('ie').AsString                     := Empresa.ie;
  self.FQuery.ParamByName('telefone').AsString               := Empresa.telefone;
  self.FQuery.ParamByName('site').AsString                   := Empresa.site;
  self.FQuery.ParamByName('quantidade_mesas').AsInteger       := Empresa.quantidade_mesas;
  self.FQuery.ParamByName('couvert').AsString                := IfThen(Empresa.couvert, 'S', 'N');
  self.FQuery.ParamByName('valor_couvert').AsFloat          := Empresa.valor_couvert;
  self.FQuery.ParamByName('cidade').AsString                 := Empresa.cidade;
  self.FQuery.ParamByName('taxa_servico').AsFloat           := Empresa.taxa_servico;
  self.FQuery.ParamByName('aliquota_couvert').AsFloat       := Empresa.aliquota_couvert;
  self.FQuery.ParamByName('aliquota_txservico').AsFloat     := Empresa.aliquota_txservico;
  self.FQuery.ParamByName('tributacao_couvert').AsString     := Empresa.tributacao_couvert;
  self.FQuery.ParamByName('tributacao_txservico').AsString   := Empresa.tributacao_txservico;
  self.FQuery.ParamByName('diretorio_boliche').AsString      := Empresa.diretorio_boliche;
  self.FQuery.ParamByName('diretorio_dispensadora').AsString := Empresa.diretorio_dispensadora;
  self.FQuery.ParamByName('estado').AsString                 := Empresa.estado;
  self.FQuery.ParamByName('cep').AsInteger                    := Empresa.cep;
  self.FQuery.ParamByName('rua').AsString                    := Empresa.rua;
  self.FQuery.ParamByName('numero').AsString                 := Empresa.numero;
  self.FQuery.ParamByName('bairro').AsString                 := Empresa.bairro;
  self.FQuery.ParamByName('complemento').AsString            := Empresa.complemento;
  self.FQuery.ParamByName('cod_municipio').AsInteger          := Empresa.cod_municipio;
  self.FQuery.ParamByName('taxa_entrega').AsFloat            := Empresa.taxa_entrega;  
end;

function TRepositorioEmpresa.SQLGet: String;
begin
  result := 'select * from EMPRESA where codigo = :ncod';
end;

function TRepositorioEmpresa.SQLGetAll: String;
begin
  result := 'select * from EMPRESA';
end;

function TRepositorioEmpresa.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from EMPRESA where '+ campo +' = :ncampo';
end;

function TRepositorioEmpresa.SQLRemover: String;
begin
  result := ' delete from EMPRESA where codigo = :codigo ';
end;

function TRepositorioEmpresa.SQLSalvar: String;
begin
  result := 'update or insert into EMPRESA (CODIGO ,RAZAO_SOCIAL ,NOME_FANTASIA ,CNPJ ,IE ,TELEFONE ,SITE ,QUANTIDADE_MESAS ,         '+
            '                               COUVERT ,VALOR_COUVERT ,CIDADE ,TAXA_SERVICO ,ALIQUOTA_COUVERT ,ALIQUOTA_TXSERVICO ,      '+
            '                               TRIBUTACAO_COUVERT ,TRIBUTACAO_TXSERVICO ,DIRETORIO_BOLICHE ,DIRETORIO_DISPENSADORA ,     '+
            '                               ESTADO ,CEP ,RUA ,NUMERO ,BAIRRO ,COMPLEMENTO ,COD_MUNICIPIO, TAXA_ENTREGA)               '+
            '                       values ( :CODIGO, :RAZAO_SOCIAL, :NOME_FANTASIA, :CNPJ, :IE, :TELEFONE, :SITE, :QUANTIDADE_MESAS, '+
            '                                :COUVERT, :VALOR_COUVERT, :CIDADE, :TAXA_SERVICO, :ALIQUOTA_COUVERT, :ALIQUOTA_TXSERVICO,'+
            '                                :TRIBUTACAO_COUVERT, :TRIBUTACAO_TXSERVICO, :DIRETORIO_BOLICHE, :DIRETORIO_DISPENSADORA, '+
            '                                :ESTADO, :CEP, :RUA, :NUMERO, :BAIRRO, :COMPLEMENTO, :COD_MUNICIPIO, :TAXA_ENTREGA)      ';
end;

end.

