unit RepositorioEmpresa;

interface

uses DB, Auditoria, Repositorio, RepositorioPessoa;

type
  TRepositorioEmpresa = class(TRepositorioPessoa)

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
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;

  //==============================================================================
  // Métodos de persistência no banco dados.
  //==============================================================================
  public
    function Salvar (Objeto              :TObject) :Boolean; override;
    function Remover(Objeto              :TObject) :Boolean; override;
end;

implementation

uses SysUtils, Empresa, Math, StrUtils, Pessoa, FabricaRepositorio, ConfiguracoesNF, ConfiguracoesNFEmail;

{ TRepositorioEmpresa }

procedure TRepositorioEmpresa.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  Empresa                       :TEmpresa;
  RepositorioConfiguracoes      :TRepositorio;
  RepositorioConfiguracoesEmail :TRepositorio;
//  RepositorioParametrosNFCe     :TRepositorio;
 // RepositorioEndereco           :TRepositorio;
begin
   inherited ExecutaDepoisDeSalvar(Objeto);

   RepositorioConfiguracoes       := nil;
 //  RepositorioConfiguracoesEmail  := nil;

   Empresa := (Objeto as TEmpresa);

   try
     if Assigned(Empresa.ConfiguracoesNF) then begin
       Empresa.ConfiguracoesNF.codigo_empresa := Empresa.CodigoEmpresa;
       RepositorioConfiguracoes := TFabricaRepositorio.GetRepositorio(TConfiguracoesNF.ClassName);
       RepositorioConfiguracoes.Remover(Empresa.ConfiguracoesNF);
       RepositorioConfiguracoes.Salvar(Empresa.ConfiguracoesNF);

      { if Assigned(Empresa.ConfiguracoesNF.ParametrosNFCe) then begin
         Empresa.ConfiguracoesNF.ParametrosNFCe.codigo_empresa := Empresa.CodigoEmpresa;
         RepositorioParametrosNFCe := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
         RepositorioParametrosNFCe.Remover(Empresa.ConfiguracoesNF.ParametrosNFCe);
         RepositorioParametrosNFCe.Salvar(Empresa.ConfiguracoesNF.ParametrosNFCe);
       end;   }
     end;

     if Assigned(Empresa.ConfiguracoesEmail) then begin
       Empresa.ConfiguracoesEmail.codigo_empresa := Empresa.CodigoEmpresa;
       RepositorioConfiguracoesEmail := TFabricaRepositorio.GetRepositorio(TConfiguracoesNFEmail.ClassName);
       RepositorioConfiguracoesEmail.Remover(Empresa.ConfiguracoesEmail);
       RepositorioConfiguracoesEmail.Salvar(Empresa.ConfiguracoesEmail);
     end;


   finally
     FreeAndNil(RepositorioConfiguracoes);
//     FreeAndNil(RepositorioConfiguracoesEmail);
//     FreeAndNil(RepositorioParametrosNFCe);
//     FreeAndNil(RepositorioEndereco);
   end;
end;

function TRepositorioEmpresa.Get(Dataset: TDataSet): TObject;
var
  Pessoa           :TPessoa;
  Empresa          :TEmpresa;
begin
   Pessoa   := TPessoa(inherited Get(Dataset));

   result := nil;

   if not Assigned(Pessoa) then begin
     exit;
   end;

   Empresa                        := TEmpresa.Create;
   Empresa.Codigo                 := Pessoa.Codigo;
   Empresa.Razao                  := Pessoa.Razao;
   Empresa.NomeFantasia           := Pessoa.NomeFantasia;
   Empresa.CPF_CNPJ               := Pessoa.CPF_CNPJ;
   Empresa.RG_IE                  := Pessoa.RG_IE;
   Empresa.DtCadastro             := Pessoa.DtCadastro;
   Empresa.Fone1                  := Pessoa.Fone1;
   Empresa.Fone2                  := Pessoa.Fone2;
   Empresa.Fax                    := Pessoa.Fax;
   Empresa.Email                  := Pessoa.Email;
   Empresa.Observacao             := Pessoa.Observacao;
   Empresa.CodigoEmpresa          := Dataset.FieldByName('codigo').AsInteger;

   Empresa.quantidade_mesas       := self.FQuery.FieldByName('quantidade_mesas').AsInteger;
   Empresa.couvert                := (self.FQuery.FieldByName('couvert').AsString = 'S');
   Empresa.valor_couvert          := self.FQuery.FieldByName('valor_couvert').AsFloat;
   Empresa.taxa_servico           := self.FQuery.FieldByName('taxa_servico').AsFloat;
   Empresa.aliquota_couvert       := self.FQuery.FieldByName('aliquota_couvert').AsFloat;
   Empresa.aliquota_txservico     := self.FQuery.FieldByName('aliquota_txservico').AsFloat;
   Empresa.tributacao_couvert     := self.FQuery.FieldByName('tributacao_couvert').AsString;
   Empresa.tributacao_txservico   := self.FQuery.FieldByName('tributacao_txservico').AsString;
   Empresa.diretorio_boliche      := self.FQuery.FieldByName('diretorio_boliche').AsString;
   Empresa.diretorio_dispensadora := self.FQuery.FieldByName('diretorio_dispensadora').AsString;
   Empresa.taxa_entrega           := self.FQuery.FieldByName('taxa_entrega').AsFloat;

   result := Empresa;
   FreeAndNil(Pessoa);

   result := Empresa;
end;

function TRepositorioEmpresa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TPessoa(Objeto).Codigo;
end;

function TRepositorioEmpresa.GetNomeDaTabela: String;
begin
  result := inherited GetNomeDaTabela;
end;

function TRepositorioEmpresa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEmpresa.Create;
end;

function TRepositorioEmpresa.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TPessoa(Objeto).Codigo <= 0);
end;

function TRepositorioEmpresa.Remover(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     result := inherited Remover(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

function TRepositorioEmpresa.Salvar(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     RepositorioPessoa.Salvar(Objeto);

     Result := inherited Salvar(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

procedure TRepositorioEmpresa.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  EmpresaAntigo :TEmpresa;
  EmpresaNovo :TEmpresa;
begin
   EmpresaAntigo := (AntigoObjeto as TEmpresa);
   EmpresaNovo   := (Objeto       as TEmpresa);

   if (EmpresaAntigo.quantidade_mesas <> EmpresaNovo.quantidade_mesas) then
     Auditoria.AdicionaCampoAlterado('quantidade_mesas', IntToStr(EmpresaAntigo.quantidade_mesas), IntToStr(EmpresaNovo.quantidade_mesas));

   if (EmpresaAntigo.couvert <> EmpresaNovo.couvert) then
     Auditoria.AdicionaCampoAlterado('couvert', IfThen(EmpresaAntigo.Couvert, 'S', 'N'), IfThen(EmpresaNovo.Couvert, 'S', 'N'));

   if (EmpresaAntigo.valor_couvert <> EmpresaNovo.valor_couvert) then
     Auditoria.AdicionaCampoAlterado('valor_couvert', FloatToStr(EmpresaAntigo.valor_couvert), FloatToStr(EmpresaNovo.valor_couvert));

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

   if (EmpresaAntigo.taxa_entrega <> EmpresaNovo.taxa_entrega) then
     Auditoria.AdicionaCampoAlterado('taxa_entrega', FloatToStr(EmpresaAntigo.taxa_entrega), FloatToStr(EmpresaNovo.taxa_entrega));

end;

procedure TRepositorioEmpresa.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Empresa :TEmpresa;
begin
  Empresa := (Objeto as TEmpresa);
  Auditoria.AdicionaCampoExcluido('codigo'                , IntToStr(Empresa.codigo));
  Auditoria.AdicionaCampoExcluido('quantidade_mesas'      , IntToStr(Empresa.quantidade_mesas));
  Auditoria.AdicionaCampoExcluido('couvert'               , IfThen(Empresa.couvert, 'S', 'N'));
  Auditoria.AdicionaCampoExcluido('valor_couvert'         , FloatToStr(Empresa.valor_couvert));
  Auditoria.AdicionaCampoExcluido('taxa_servico'          , FloatToStr(Empresa.taxa_servico));
  Auditoria.AdicionaCampoExcluido('aliquota_couvert'      , FloatToStr(Empresa.aliquota_couvert));
  Auditoria.AdicionaCampoExcluido('aliquota_txservico'    , FloatToStr(Empresa.aliquota_txservico));
  Auditoria.AdicionaCampoExcluido('tributacao_couvert'    , Empresa.tributacao_couvert);
  Auditoria.AdicionaCampoExcluido('tributacao_txservico'  , Empresa.tributacao_txservico);
  Auditoria.AdicionaCampoExcluido('diretorio_boliche'     , Empresa.diretorio_boliche);
  Auditoria.AdicionaCampoExcluido('diretorio_dispensadora', Empresa.diretorio_dispensadora);
  Auditoria.AdicionaCampoExcluido('taxa_entrega'          , FloatToStr(Empresa.taxa_entrega));
end;

procedure TRepositorioEmpresa.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Empresa :TEmpresa;
begin
  Empresa := (Objeto as TEmpresa);
  Auditoria.AdicionaCampoIncluido('codigo'                ,    IntToStr(Empresa.codigo));
  Auditoria.AdicionaCampoIncluido('quantidade_mesas'      ,    IntToStr(Empresa.quantidade_mesas));
  Auditoria.AdicionaCampoIncluido('couvert'               ,    IfThen(Empresa.couvert, 'S', 'N'));
  Auditoria.AdicionaCampoIncluido('valor_couvert'         ,    FloatToStr(Empresa.valor_couvert));
  Auditoria.AdicionaCampoIncluido('taxa_servico'          ,    FloatToStr(Empresa.taxa_servico));
  Auditoria.AdicionaCampoIncluido('aliquota_couvert'      ,    FloatToStr(Empresa.aliquota_couvert));
  Auditoria.AdicionaCampoIncluido('aliquota_txservico'    ,    FloatToStr(Empresa.aliquota_txservico));
  Auditoria.AdicionaCampoIncluido('tributacao_couvert'    ,    Empresa.tributacao_couvert);
  Auditoria.AdicionaCampoIncluido('tributacao_txservico'  ,    Empresa.tributacao_txservico);
  Auditoria.AdicionaCampoIncluido('diretorio_boliche'     ,    Empresa.diretorio_boliche);
  Auditoria.AdicionaCampoIncluido('diretorio_dispensadora',    Empresa.diretorio_dispensadora);
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

  self.FQuery.ParamByName('codigo').AsInteger                := Empresa.codigo;
  self.FQuery.ParamByName('quantidade_mesas').AsInteger      := Empresa.quantidade_mesas;
  self.FQuery.ParamByName('couvert').AsString                := IfThen(Empresa.couvert, 'S', 'N');
  self.FQuery.ParamByName('valor_couvert').AsFloat           := Empresa.valor_couvert;
  self.FQuery.ParamByName('taxa_servico').AsFloat            := Empresa.taxa_servico;
  self.FQuery.ParamByName('aliquota_couvert').AsFloat        := Empresa.aliquota_couvert;
  self.FQuery.ParamByName('aliquota_txservico').AsFloat      := Empresa.aliquota_txservico;
  self.FQuery.ParamByName('tributacao_couvert').AsString     := Empresa.tributacao_couvert;
  self.FQuery.ParamByName('tributacao_txservico').AsString   := Empresa.tributacao_txservico;
  self.FQuery.ParamByName('diretorio_boliche').AsString      := Empresa.diretorio_boliche;
  self.FQuery.ParamByName('diretorio_dispensadora').AsString := Empresa.diretorio_dispensadora;
  self.FQuery.ParamByName('taxa_entrega').AsFloat            := Empresa.taxa_entrega;  
end;

function TRepositorioEmpresa.SQLGet: String;
begin
   result := ' select p.*, e.* '+
             ' from empresa e                           '+
             ' inner join pessoas p on (p.TIPO = ''E'') '+
             ' where e.codigo = :codigo                 ';
end;

function TRepositorioEmpresa.SQLGetAll: String;
begin
  result := ' select p.*, E.* from empresa e inner join pessoas p on (p.TIPO = ''E'')';
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
  result := 'update or insert into EMPRESA (CODIGO, QUANTIDADE_MESAS , COUVERT ,VALOR_COUVERT, TAXA_SERVICO ,ALIQUOTA_COUVERT ,  '+
            '                               ALIQUOTA_TXSERVICO, TRIBUTACAO_COUVERT ,TRIBUTACAO_TXSERVICO ,DIRETORIO_BOLICHE ,    '+
            '                               DIRETORIO_DISPENSADORA , TAXA_ENTREGA)                                               '+
            '                       values ( :CODIGO, :QUANTIDADE_MESAS, :COUVERT, :VALOR_COUVERT, :TAXA_SERVICO,       '+
            '                                :ALIQUOTA_COUVERT, :ALIQUOTA_TXSERVICO, :TRIBUTACAO_COUVERT, :TRIBUTACAO_TXSERVICO, '+
            '                                :DIRETORIO_BOLICHE, :DIRETORIO_DISPENSADORA, :TAXA_ENTREGA)';
end;

end.

