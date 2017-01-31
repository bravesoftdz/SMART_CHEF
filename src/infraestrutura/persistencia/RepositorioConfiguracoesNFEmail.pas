unit RepositorioConfiguracoesNFEmail;

interface

uses DB, Repositorio;

type
  TRepositorioConfiguracoesNFEmail = class(TRepositorio)

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

uses SysUtils, ConfiguracoesNFEmail;

{ TRepositorioConfiguracoesNFEmail }

function TRepositorioConfiguracoesNFEmail.Get(Dataset: TDataSet): TObject;
begin
   result := TConfiguracoesNFEmail.CriaParaRepositorio(Dataset.FieldByName('codigo_empresa').AsInteger,
                                                       Dataset.FieldByName('smtp_host').AsString,
                                                       Dataset.FieldByName('smtp_port').AsString,
                                                       Dataset.FieldByName('smtp_user').AsString,
                                                       Dataset.FieldByName('smtp_password').AsString,
                                                       Dataset.FieldByName('assunto').AsString,
                                                       Dataset.FieldByName('mensagem').AsString
                                                       );
end;

function TRepositorioConfiguracoesNFEmail.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TConfiguracoesNFEmail(Objeto).codigo_empresa;
end;

function TRepositorioConfiguracoesNFEmail.GetNomeDaTabela: String;
begin
  result := 'CONFIGURACOES_NF_EMAIL';
end;

function TRepositorioConfiguracoesNFEmail.GetRepositorio: TRepositorio;
begin
  result := TRepositorioConfiguracoesNFEmail.Create;
end;

function TRepositorioConfiguracoesNFEmail.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TConfiguracoesNFEmail(Objeto).codigo_empresa <= 0);
end;

procedure TRepositorioConfiguracoesNFEmail.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TConfiguracoesNFEmail(Objeto).codigo_empresa := Integer(Identificador);
end;
procedure TRepositorioConfiguracoesNFEmail.SetParametros(Objeto: TObject);
var
  ConfiguracoesNFEmail :TConfiguracoesNFEmail;
begin
  ConfiguracoesNFEmail := (Objeto as TConfiguracoesNFEmail);

  self.FQuery.ParamByName('codigo_empresa').AsInteger := ConfiguracoesNFEmail.codigo_empresa;
  self.FQuery.ParamByName('smtp_host').AsString      := ConfiguracoesNFEmail.smtp_host;
  self.FQuery.ParamByName('smtp_port').AsString      := ConfiguracoesNFEmail.smtp_port;
  self.FQuery.ParamByName('smtp_user').AsString      := ConfiguracoesNFEmail.smtp_user;
  self.FQuery.ParamByName('smtp_password').AsString  := ConfiguracoesNFEmail.smtp_password;
  self.FQuery.ParamByName('assunto').AsString        := ConfiguracoesNFEmail.assunto;
  self.FQuery.ParamByName('mensagem').AsString       := Trim(ConfiguracoesNFEmail.mensagem.Text);
  self.FQuery.ParamByName('usa_ssl').AsString        := ConfiguracoesNFEmail.usa_ssl;
end;

function TRepositorioConfiguracoesNFEmail.SQLGet: String;
begin
  result := 'select * from CONFIGURACOES_NF_EMAIL where codigo_empresa = :ncod';
end;

function TRepositorioConfiguracoesNFEmail.SQLGetAll: String;
begin
  result := 'select * from CONFIGURACOES_NF_EMAIL';
end;

function TRepositorioConfiguracoesNFEmail.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CONFIGURACOES_NF_EMAIL where '+ campo +' = :ncampo';
end;

function TRepositorioConfiguracoesNFEmail.SQLRemover: String;
begin
  result := ' delete from CONFIGURACOES_NF_EMAIL where codigo_empresa = :codigo ';
end;

function TRepositorioConfiguracoesNFEmail.SQLSalvar: String;
begin
  result := 'update or insert into CONFIGURACOES_NF_EMAIL (CODIGO_EMPRESA ,SMTP_HOST ,SMTP_PORT ,SMTP_USER ,SMTP_PASSWORD ,ASSUNTO ,MENSAGEM ,USA_SSL) '+
           '                      values ( :CODIGO_EMPRESA , :SMTP_HOST , :SMTP_PORT , :SMTP_USER , :SMTP_PASSWORD , :ASSUNTO , :MENSAGEM , :USA_SSL) ';
end;

end.

