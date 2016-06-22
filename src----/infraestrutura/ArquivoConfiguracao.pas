unit ArquivoConfiguracao;

interface

uses
   IniFiles;

type
  TArquivoConfiguracao = class(TIniFile)

  private
    FDiretorioSistema         :String;

  private
    function GetCaminhoBancoDeDados       :String;
    function GetCaminhoBancoDeDadosLocal  :String;
    function GetNomeServidorBancoDeDados  :String;
    function GetPortaBancoDeDados         :Integer;
    function GetProtocoloBancoDeDados     :String;
    function GetSenhaBancoDeDados         :String;
    function GetUsuarioBancoDeDados       :String;

//    function GetCaminhoBancoDeBackup      :String;
//    function GetNomeServidorBancoDeBackup :String;
//    function GetPortaBancoDeBackup        :Integer;
//    function GetProtocoloBancoDeBackup    :String;
//    function GetSenhaBancoDeBackup        :String;
//    function GetUsuarioBancoDeBackup      :String;

  private
    procedure SetCaminhoBancoDeDados     (const Value: String);
    procedure SetCaminhoBancoDeDadosLocal(const Value: String);
    procedure SetNomeServidorBancoDeDados(const Value: String);
    procedure SetPortaBancoDeDados       (const Value: Integer);
    procedure SetProtocoloBancoDeDados   (const Value: String);
    procedure SetSenhaBancoDeDados       (const Value: String);
    procedure SetUsuarioBancoDeDados     (const Value: String);

//    procedure SetCaminhoBancoDeBackup     (const Value: String);
//    procedure SetNomeServidorBancoDeBackup(const Value: String);
//    procedure SetPortaBancoDeBackup       (const Value: Integer);
//    procedure SetProtocoloBancoDeBackup   (const Value: String);
//    procedure SetSenhaBancoDeBackup       (const Value: String);
//    procedure SetUsuarioBancoDeBackup     (const Value: String);

    procedure InicializaTags;
  private
    function GetNomeArquivo: String;

  private
    property NomeArquivo :String read GetNomeArquivo;

  public
    constructor Create(DiretorioSistema :String);

  public
    //==============================================================================
    // Propriedades de configuração do Banco de Dados padrão
    //==============================================================================
    property CaminhoBancoDeDados                :String read  GetCaminhoBancoDeDados write SetCaminhoBancoDeDados;
    property CaminhoBancoDeDadosLocal           :String read  GetCaminhoBancoDeDadosLocal write SetCaminhoBancoDeDadosLocal;    
    property NomeServidorBancoDeDados           :String read  GetNomeServidorBancoDeDados write SetNomeServidorBancoDeDados;
    property UsuarioBancoDeDados                :String read  GetUsuarioBancoDeDados write SetUsuarioBancoDeDados;
    property SenhaBancoDeDados                  :String read  GetSenhaBancoDeDados write SetSenhaBancoDeDados;
    property PortaBancoDeDados                  :Integer read GetPortaBancoDeDados write SetPortaBancoDeDados;
    property ProtocoloBancoDeDados              :String read  GetProtocoloBancoDeDados write SetProtocoloBancoDeDados;

    //==============================================================================
    // Propriedades de configuração do Banco de Dados de Backup (Que será utilizado quando banco estiver off)
    //==============================================================================
//    property CaminhoBancoDeBackup               :String  read GetCaminhoBancoDeBackup write SetCaminhoBancoDeBackup;
//    property NomeServidorBancoDeBackup          :String  read GetNomeServidorBancoDeBackup write SetNomeServidorBancoDeBackup;
//    property UsuarioBancoDeBackup               :String  read GetUsuarioBancoDeBackup write SetUsuarioBancoDeBackup;
//    property SenhaBancoDeBackup                 :String  read GetSenhaBancoDeBackup write SetSenhaBancoDeBackup;
//    property PortaBancoDeBackup                 :Integer read GetPortaBancoDeBackup write SetPortaBancoDeBackup;
//    property ProtocoloBancoDeBackup             :String  read GetProtocoloBancoDeBackup write SetProtocoloBancoDeBackup;
end;

implementation

uses
  SysUtils;

const
  NOME_ARQUIVO = 'configuracao.ini';

  // Tags do arquivo de configuração
    TAG_BANCO_DE_DADOS           = 'BANCO_DE_DADOS';
    TAG_BANCO_DE_BACKUP          = 'BANCO_DE_BACKUP';
    TAG_CAMINHO                  = 'CAMINHO';
    TAG_CAMINHO_LOCAL            = 'CAMINHO_LOCAL';
    TAG_NOME_DO_SERVIDOR         = 'NOME_DO_SERVIDOR';
    TAG_USUARIO                  = 'USUARIO';
    TAG_SENHA                    = 'SENHA';
    TAG_PORTA                    = 'PORTA';
    TAG_PROTOCOLO                = 'PROTOCOLO';


  // Valores padrão
    USUARIO_PADRAO     = 'SYSDBA';
    SENHA_PADRAO       = 'masterkey';
    PORTA_PADRAO       = 3050;
    PROTOCOLO_PADRAO   = 'firebird-2.0';

{ TArquivoConfiguracao }

constructor TArquivoConfiguracao.Create(DiretorioSistema: String);
begin
   self.FDiretorioSistema := DiretorioSistema;

   inherited Create(self.NomeArquivo);

   self.InicializaTags;
end;

//function TArquivoConfiguracao.GetCaminhoBancoDeBackup: String;
//begin
//   result := inherited ReadString(TAG_BANCO_DE_BACKUP, TAG_CAMINHO, '');
//
//   self.SetCaminhoBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetCaminhoBancoDeDados: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_CAMINHO, '');

   self.SetCaminhoBancoDeDados(result);
end;

function TArquivoConfiguracao.GetCaminhoBancoDeDadosLocal: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_CAMINHO_LOCAL, '');

   self.SetCaminhoBancoDeDadosLocal(result);
end;

function TArquivoConfiguracao.GetNomeArquivo: String;
begin
   result := (self.FDiretorioSistema + NOME_ARQUIVO);
end;

//function TArquivoConfiguracao.GetNomeServidorBancoDeBackup: String;
//begin
//   result := inherited ReadString(TAG_BANCO_DE_BACKUP, TAG_NOME_DO_SERVIDOR, '');
//
//   self.SetNomeServidorBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetNomeServidorBancoDeDados: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_NOME_DO_SERVIDOR, '');

   self.SetNomeServidorBancoDeDados(result);
end;

//function TArquivoConfiguracao.GetPortaBancoDeBackup: Integer;
//begin
//   result := inherited ReadInteger(TAG_BANCO_DE_BACKUP, TAG_PORTA, PORTA_PADRAO);
//
//   self.SetPortaBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetPortaBancoDeDados: Integer;
begin
   result := inherited ReadInteger(TAG_BANCO_DE_DADOS, TAG_PORTA, PORTA_PADRAO);

   self.SetPortaBancoDeDados(result);
end;

//function TArquivoConfiguracao.GetProtocoloBancoDeBackup: String;
//begin
//   result := inherited ReadString(TAG_BANCO_DE_BACKUP, TAG_PROTOCOLO, PROTOCOLO_PADRAO);
//
//   self.SetProtocoloBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetProtocoloBancoDeDados: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_PROTOCOLO, PROTOCOLO_PADRAO);

   self.SetProtocoloBancoDeDados(result);
end;

//function TArquivoConfiguracao.GetSenhaBancoDeBackup: String;
//begin
//   result := inherited ReadString(TAG_BANCO_DE_BACKUP, TAG_SENHA, SENHA_PADRAO);
//
//   self.SetSenhaBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetSenhaBancoDeDados: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_SENHA, SENHA_PADRAO);

   self.SetSenhaBancoDeDados(result);
end;

//function TArquivoConfiguracao.GetUsuarioBancoDeBackup: String;
//begin
//   result := inherited ReadString(TAG_BANCO_DE_BACKUP, TAG_USUARIO, USUARIO_PADRAO);
//
//   self.SetUsuarioBancoDeBackup(result);
//end;

function TArquivoConfiguracao.GetUsuarioBancoDeDados: String;
begin
   result := inherited ReadString(TAG_BANCO_DE_DADOS, TAG_USUARIO, USUARIO_PADRAO);

   self.SetUsuarioBancoDeDados(result);
end;

procedure TArquivoConfiguracao.InicializaTags;
begin
   self.CaminhoBancoDeDados;
   self.CaminhoBancoDeDadosLocal;
   self.NomeServidorBancoDeDados;
   self.UsuarioBancoDeDados;
   self.SenhaBancoDeDados;
   self.PortaBancoDeDados;
   self.ProtocoloBancoDeDados;

//   self.CaminhoBancoDeBackup;
//   self.NomeServidorBancoDeBackup;
//   self.UsuarioBancoDeBackup;
//   self.SenhaBancoDeBackup;
//   self.PortaBancoDeBackup;
//   self.ProtocoloBancoDeBackup;
end;

//procedure TArquivoConfiguracao.SetCaminhoBancoDeBackup(
//  const Value: String);
//begin
//   inherited WriteString(TAG_BANCO_DE_BACKUP, TAG_CAMINHO, Value);
//end;

procedure TArquivoConfiguracao.SetCaminhoBancoDeDados(const Value: String);
begin
   inherited WriteString(TAG_BANCO_DE_DADOS, TAG_CAMINHO, Value);
end;

//procedure TArquivoConfiguracao.SetNomeServidorBancoDeBackup(
//  const Value: String);
//begin
//   inherited WriteString(TAG_BANCO_DE_BACKUP, TAG_NOME_DO_SERVIDOR, Value);
//end;

procedure TArquivoConfiguracao.SetCaminhoBancoDeDadosLocal(
  const Value: String);
begin
   inherited WriteString(TAG_BANCO_DE_DADOS, TAG_CAMINHO_LOCAL, Value);
end;

procedure TArquivoConfiguracao.SetNomeServidorBancoDeDados(
  const Value: String);
begin
  inherited WriteString(TAG_BANCO_DE_DADOS, TAG_NOME_DO_SERVIDOR, Value);
end;

//procedure TArquivoConfiguracao.SetPortaBancoDeBackup(const Value: Integer);
//begin
//  inherited WriteInteger(TAG_BANCO_DE_BACKUP, TAG_PORTA, Value);
//end;

procedure TArquivoConfiguracao.SetPortaBancoDeDados(const Value: Integer);
begin
  inherited WriteInteger(TAG_BANCO_DE_DADOS, TAG_PORTA, Value);
end;

//procedure TArquivoConfiguracao.SetProtocoloBancoDeBackup(
//  const Value: String);
//begin
//  inherited WriteString(TAG_BANCO_DE_BACKUP, TAG_PROTOCOLO, Value);
//end;

procedure TArquivoConfiguracao.SetProtocoloBancoDeDados(
  const Value: String);
begin
  inherited WriteString(TAG_BANCO_DE_DADOS, TAG_PROTOCOLO, Value);
end;

//procedure TArquivoConfiguracao.SetSenhaBancoDeBackup(const Value: String);
//begin
//  inherited WriteString(TAG_BANCO_DE_BACKUP, TAG_SENHA, Value);
//end;

procedure TArquivoConfiguracao.SetSenhaBancoDeDados(const Value: String);
begin
  inherited WriteString(TAG_BANCO_DE_DADOS, TAG_SENHA, Value);
end;

//procedure TArquivoConfiguracao.SetUsuarioBancoDeBackup(
//  const Value: String);
//begin
//  inherited WriteString(TAG_BANCO_DE_BACKUP, TAG_USUARIO, Value);
//end;

procedure TArquivoConfiguracao.SetUsuarioBancoDeDados(const Value: String);
begin
  inherited WriteString(TAG_BANCO_DE_DADOS, TAG_USUARIO, Value);
end;

end.
