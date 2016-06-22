unit RepositorioParametrosNFCe;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioParametrosNFCe = class(TRepositorio)

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

uses SysUtils, ParametrosNFCe, StrUtils;

{ TRepositorioParametrosNFCe }

function TRepositorioParametrosNFCe.Get(Dataset: TDataSet): TObject;
var
  ParametrosNFCe :TParametrosNFCe;
begin
   ParametrosNFCe:= TParametrosNFCe.Create;
   ParametrosNFCe.Codigo                    := self.FQuery.FieldByName('codigo').AsInteger;
   ParametrosNFCe.FormaEmissao              := self.FQuery.FieldByName('forma_emissao').AsInteger;
   ParametrosNFCe.IntervaloTentativas       := self.FQuery.FieldByName('intervalo_tentativas').AsInteger;
   ParametrosNFCe.Tentativas                := self.FQuery.FieldByName('tentativas').AsInteger;
   ParametrosNFCe.VersaoDF                  := self.FQuery.FieldByName('versao_df').AsInteger;
   ParametrosNFCe.ID_TOKEN                  := self.FQuery.FieldByName('id_token').AsString;
   ParametrosNFCe.TOKEN                     := self.FQuery.FieldByName('token').AsString;
   ParametrosNFCe.Certificado               := self.FQuery.FieldByName('certificado').AsString;
   ParametrosNFCe.senha                     := self.FQuery.FieldByName('senha').AsString;
   ParametrosNFCe.DANFE.VisualizarImpressao := (self.FQuery.FieldByName('visualiza_impressao').AsString = 'S');
   ParametrosNFCe.DANFE.ViaConsumidor       := (self.FQuery.FieldByName('via_consumidor').AsString = 'S');
   ParametrosNFCe.DANFE.ImprimirItens       := (self.FQuery.FieldByName('imprime_itens').AsString = 'S');
   ParametrosNFCe.Ambiente                  := IfThen(self.FQuery.FieldByName('ambiente').AsString = 'P', 'Produção','Homologação');

   result := ParametrosNFCe;
end;

function TRepositorioParametrosNFCe.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TParametrosNFCe(Objeto).Codigo;
end;

function TRepositorioParametrosNFCe.GetNomeDaTabela: String;
begin
  result := 'PARAMETROS_NFCE';
end;

function TRepositorioParametrosNFCe.GetRepositorio: TRepositorio;
begin
  result := TRepositorioParametrosNFCe.Create;
end;

function TRepositorioParametrosNFCe.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TParametrosNFCe(Objeto).Codigo <= 0);
end;

procedure TRepositorioParametrosNFCe.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ParametrosNFCeAntigo :TParametrosNFCe;
  ParametrosNFCeNovo :TParametrosNFCe;
begin
   ParametrosNFCeAntigo := (AntigoObjeto as TParametrosNFCe);
   ParametrosNFCeNovo   := (Objeto       as TParametrosNFCe);

   if (ParametrosNFCeAntigo.FormaEmissao <> ParametrosNFCeNovo.FormaEmissao) then
     Auditoria.AdicionaCampoAlterado('forma_emissao', IntToStr(ParametrosNFCeAntigo.FormaEmissao), IntToStr(ParametrosNFCeNovo.FormaEmissao));

   if (ParametrosNFCeAntigo.IntervaloTentativas <> ParametrosNFCeNovo.IntervaloTentativas) then
     Auditoria.AdicionaCampoAlterado('intervalo_tentativas', IntToStr(ParametrosNFCeAntigo.IntervaloTentativas), IntToStr(ParametrosNFCeNovo.IntervaloTentativas));

   if (ParametrosNFCeAntigo.tentativas <> ParametrosNFCeNovo.tentativas) then
     Auditoria.AdicionaCampoAlterado('tentativas', IntToStr(ParametrosNFCeAntigo.tentativas), IntToStr(ParametrosNFCeNovo.tentativas));

   if (ParametrosNFCeAntigo.VersaoDF <> ParametrosNFCeNovo.VersaoDF) then
     Auditoria.AdicionaCampoAlterado('versao_df', IntToStr(ParametrosNFCeAntigo.VersaoDF), IntToStr(ParametrosNFCeNovo.VersaoDF));

   if (ParametrosNFCeAntigo.ID_TOKEN <> ParametrosNFCeNovo.id_token) then
     Auditoria.AdicionaCampoAlterado('id_token', ParametrosNFCeAntigo.id_token, ParametrosNFCeNovo.id_token);

   if (ParametrosNFCeAntigo.token <> ParametrosNFCeNovo.TOKEN) then
     Auditoria.AdicionaCampoAlterado('token', ParametrosNFCeAntigo.token, ParametrosNFCeNovo.token);

   if (ParametrosNFCeAntigo.certificado <> ParametrosNFCeNovo.certificado) then
     Auditoria.AdicionaCampoAlterado('certificado', ParametrosNFCeAntigo.certificado, ParametrosNFCeNovo.certificado);

   if (ParametrosNFCeAntigo.senha <> ParametrosNFCeNovo.senha) then
     Auditoria.AdicionaCampoAlterado('senha', ParametrosNFCeAntigo.senha, ParametrosNFCeNovo.senha);

   if (ParametrosNFCeAntigo.Ambiente <> ParametrosNFCeNovo.Ambiente) then
     Auditoria.AdicionaCampoAlterado('ambiente', ParametrosNFCeAntigo.Ambiente, ParametrosNFCeNovo.Ambiente);
end;

procedure TRepositorioParametrosNFCe.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  ParametrosNFCe := (Objeto as TParametrosNFCe);
  Auditoria.AdicionaCampoExcluido('codigo'              , IntToStr(ParametrosNFCe.codigo));
  Auditoria.AdicionaCampoExcluido('forma_emissao'       , IntToStr(ParametrosNFCe.FormaEmissao));
  Auditoria.AdicionaCampoExcluido('intervalo_tentativas', IntToStr(ParametrosNFCe.IntervaloTentativas));
  Auditoria.AdicionaCampoExcluido('tentativas'          , IntToStr(ParametrosNFCe.tentativas));
  Auditoria.AdicionaCampoExcluido('versao_df'           , IntToStr(ParametrosNFCe.VersaoDF));
  Auditoria.AdicionaCampoExcluido('id_token'            , ParametrosNFCe.id_token);
  Auditoria.AdicionaCampoExcluido('token'               , ParametrosNFCe.token);
  Auditoria.AdicionaCampoExcluido('certificado'         , ParametrosNFCe.certificado);
  Auditoria.AdicionaCampoExcluido('senha'               , ParametrosNFCe.senha);
  Auditoria.AdicionaCampoExcluido('ambiente'            , ParametrosNFCe.Ambiente);
end;

procedure TRepositorioParametrosNFCe.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  ParametrosNFCe := (Objeto as TParametrosNFCe);
  Auditoria.AdicionaCampoIncluido('codigo'              ,    IntToStr(ParametrosNFCe.codigo));
  Auditoria.AdicionaCampoIncluido('forma_emissao'       ,    IntToStr(ParametrosNFCe.FormaEmissao));
  Auditoria.AdicionaCampoIncluido('intervalo_tentativas',    IntToStr(ParametrosNFCe.IntervaloTentativas));
  Auditoria.AdicionaCampoIncluido('tentativas'          ,    IntToStr(ParametrosNFCe.tentativas));
  Auditoria.AdicionaCampoIncluido('versao_df'           ,    IntToStr(ParametrosNFCe.VersaoDF));
  Auditoria.AdicionaCampoIncluido('id_token'            ,    ParametrosNFCe.id_token);
  Auditoria.AdicionaCampoIncluido('token'               ,    ParametrosNFCe.token);
  Auditoria.AdicionaCampoIncluido('certificado'         ,    ParametrosNFCe.certificado);
  Auditoria.AdicionaCampoIncluido('senha'               ,    ParametrosNFCe.senha);
  Auditoria.AdicionaCampoIncluido('Ambiente'            ,    ParametrosNFCe.Ambiente);
end;

procedure TRepositorioParametrosNFCe.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TParametrosNFCe(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioParametrosNFCe.SetParametros(Objeto: TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  ParametrosNFCe := (Objeto as TParametrosNFCe);

  self.FQuery.ParamByName('codigo').AsInteger               := ParametrosNFCe.codigo;
  self.FQuery.ParamByName('forma_emissao').AsInteger        := ParametrosNFCe.FormaEmissao;
  self.FQuery.ParamByName('intervalo_tentativas').AsInteger := ParametrosNFCe.IntervaloTentativas;
  self.FQuery.ParamByName('tentativas').AsInteger           := ParametrosNFCe.tentativas;
  self.FQuery.ParamByName('versao_df').AsInteger            := ParametrosNFCe.VersaoDF;
  self.FQuery.ParamByName('id_token').AsString              := ParametrosNFCe.id_token;
  self.FQuery.ParamByName('token').AsString                 := ParametrosNFCe.token;
  self.FQuery.ParamByName('certificado').AsString           := ParametrosNFCe.certificado;
  self.FQuery.ParamByName('senha').AsString                 := ParametrosNFCe.senha;
  self.FQuery.ParamByName('visualiza_impressao').AsString   := IfThen( ParametrosNFCe.DANFE.VisualizarImpressao, 'S', 'N');
  self.FQuery.ParamByName('via_consumidor').AsString        := IfThen( ParametrosNFCe.DANFE.ViaConsumidor, 'S', 'N');
  self.FQuery.ParamByName('imprime_itens').AsString         := IfThen( ParametrosNFCe.DANFE.ImprimirItens, 'S', 'N');
  self.FQuery.ParamByName('ambiente').AsString              := Copy(ParametrosNFCe.ambiente,1,1);

end;

function TRepositorioParametrosNFCe.SQLGet: String;
begin
  result := 'select * from PARAMETROS_NFCE where codigo = :ncod';
end;

function TRepositorioParametrosNFCe.SQLGetAll: String;
begin
  result := 'select * from PARAMETROS_NFCE';
end;

function TRepositorioParametrosNFCe.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PARAMETROS_NFCE where '+ campo +' = :ncampo';
end;

function TRepositorioParametrosNFCe.SQLRemover: String;
begin
  result := ' delete from PARAMETROS_NFCE where codigo = :codigo ';
end;

function TRepositorioParametrosNFCe.SQLSalvar: String;
begin
  result := 'update or insert into PARAMETROS_NFCE (CODIGO ,FORMA_EMISSAO ,INTERVALO_TENTATIVAS ,TENTATIVAS ,VERSAO_DF ,ID_TOKEN ,TOKEN       '+
            '                                       ,CERTIFICADO ,SENHA, VISUALIZA_IMPRESSAO, VIA_CONSUMIDOR, IMPRIME_ITENS, AMBIENTE)        '+
            '                      values ( :CODIGO , :FORMA_EMISSAO , :INTERVALO_TENTATIVAS , :TENTATIVAS , :VERSAO_DF , :ID_TOKEN ,         '+
            '                               :TOKEN , :CERTIFICADO , :SENHA, :VISUALIZA_IMPRESSAO, :VIA_CONSUMIDOR, :IMPRIME_ITENS, :AMBIENTE) ';
end;

end.

