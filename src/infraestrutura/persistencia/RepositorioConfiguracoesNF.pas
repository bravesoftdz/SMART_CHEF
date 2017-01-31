unit RepositorioConfiguracoesNF;

interface

uses DB, Repositorio;

type
  TRepositorioConfiguracoesNF = class(TRepositorio)

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

end;

implementation

uses SysUtils, ConfiguracoesNF;

{ TRepositorioConfiguracoesNF }

function TRepositorioConfiguracoesNF.Get(Dataset: TDataSet): TObject;
var
  ConfiguracoesNF :TConfiguracoesNF;
begin
   ConfiguracoesNF:= TConfiguracoesNF.Create;
   ConfiguracoesNF.codigo_empresa      := self.FQuery.FieldByName('codigo_empresa').AsInteger;
   ConfiguracoesNF.aliq_cred_sn        := self.FQuery.FieldByName('aliq_cred_sn').AsFloat;
   ConfiguracoesNF.aliq_icms           := self.FQuery.FieldByName('aliq_icms').AsFloat;
   ConfiguracoesNF.aliq_pis            := self.FQuery.FieldByName('aliq_pis').AsFloat;
   ConfiguracoesNF.aliq_cofins         := self.FQuery.FieldByName('aliq_cofins').AsFloat;
   ConfiguracoesNF.num_certificado     := self.FQuery.FieldByName('num_certificado').AsString;
   ConfiguracoesNF.ambiente_nfe        := self.FQuery.FieldByName('ambiente_nfe').AsString;
   ConfiguracoesNF.senha_certificado   := self.FQuery.FieldByName('senha_certificado').AsString;
   ConfiguracoesNF.SequenciaNotaFiscal := self.FQuery.FieldByName('sequencia_nf').AsInteger;
   ConfiguracoesNF.tipo_emissao        := self.FQuery.FieldByName('tipo_emissao').AsInteger;
   ConfiguracoesNF.dt_contingencia     := self.FQuery.FieldByName('dt_contingencia').AsDateTime;
   ConfiguracoesNF.CRT                 := self.FQuery.FieldByName('CRT').AsInteger;
   ConfiguracoesNF.ObsGeradaPeloSistema:= self.FQuery.FieldByName('OBS_GERADA_SISTEMA').AsString;

   result := ConfiguracoesNF;
end;

function TRepositorioConfiguracoesNF.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TConfiguracoesNF(Objeto).codigo_empresa;
end;

function TRepositorioConfiguracoesNF.GetNomeDaTabela: String;
begin
  result := 'CONFIGURACOES_NF';
end;

function TRepositorioConfiguracoesNF.GetRepositorio: TRepositorio;
begin
  result := TRepositorioConfiguracoesNF.Create;
end;

function TRepositorioConfiguracoesNF.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TConfiguracoesNF(Objeto).codigo_empresa <= 0);
end;

procedure TRepositorioConfiguracoesNF.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TConfiguracoesNF(Objeto).codigo_empresa := Integer(Identificador);
end;
procedure TRepositorioConfiguracoesNF.SetParametros(Objeto: TObject);
var
  ConfiguracoesNF :TConfiguracoesNF;
begin
  ConfiguracoesNF := (Objeto as TConfiguracoesNF);

  self.FQuery.ParamByName('codigo_empresa').AsInteger   := ConfiguracoesNF.codigo_empresa;
  self.FQuery.ParamByName('aliq_cred_sn').AsFloat       := ConfiguracoesNF.aliq_cred_sn;
  self.FQuery.ParamByName('aliq_icms').AsFloat          := ConfiguracoesNF.aliq_icms;
  self.FQuery.ParamByName('aliq_pis').AsFloat           := ConfiguracoesNF.aliq_pis;
  self.FQuery.ParamByName('aliq_cofins').AsFloat        := ConfiguracoesNF.aliq_cofins;
  self.FQuery.ParamByName('num_certificado').AsString   := ConfiguracoesNF.num_certificado;
  self.FQuery.ParamByName('ambiente_nfe').AsString      := ConfiguracoesNF.ambiente_nfe;
  self.FQuery.ParamByName('senha_certificado').AsString := ConfiguracoesNF.senha_certificado;
  self.FQuery.ParamByName('sequencia_nf').AsInteger     := ConfiguracoesNF.SequenciaNotaFiscal;
  self.FQuery.ParamByName('tipo_emissao').AsInteger     := ConfiguracoesNF.tipo_emissao;
  self.FQuery.ParamByName('dt_contingencia').AsDateTime := ConfiguracoesNF.dt_contingencia;
  self.FQuery.ParamByName('OBS_GERADA_SISTEMA').AsString:= ConfiguracoesNF.ObsGeradaPeloSistema;

  self.FQuery.ParamByName('CRT').AsInteger              := ConfiguracoesNF.CRT;
end;

function TRepositorioConfiguracoesNF.SQLGet: String;
begin
  result := 'select * from CONFIGURACOES_NF where codigo_empresa = :ncod';
end;

function TRepositorioConfiguracoesNF.SQLGetAll: String;
begin
  result := 'select * from CONFIGURACOES_NF';
end;

function TRepositorioConfiguracoesNF.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CONFIGURACOES_NF where '+ campo +' = :ncampo';
end;

function TRepositorioConfiguracoesNF.SQLRemover: String;
begin
  result := ' delete from CONFIGURACOES_NF where codigo_empresa = :codigo ';
end;

function TRepositorioConfiguracoesNF.SQLSalvar: String;
begin
  result := 'update or insert into CONFIGURACOES_NF (CODIGO_EMPRESA ,ALIQ_CRED_SN ,ALIQ_ICMS ,ALIQ_PIS ,ALIQ_COFINS ,NUM_CERTIFICADO ,AMBIENTE_NFE ,SENHA_CERTIFICADO, SEQUENCIA_NF ,TIPO_EMISSAO ,DT_CONTINGENCIA, CRT, OBS_GERADA_SISTEMA) '+
           '                      values ( :CODIGO_EMPRESA , :ALIQ_CRED_SN , :ALIQ_ICMS , :ALIQ_PIS , :ALIQ_COFINS , :NUM_CERTIFICADO , :AMBIENTE_NFE , :SENHA_CERTIFICADO, :SEQUENCIA_NF, :TIPO_EMISSAO , :DT_CONTINGENCIA, :CRT, :OBS_GERADA_SISTEMA) ';
end;

end.

