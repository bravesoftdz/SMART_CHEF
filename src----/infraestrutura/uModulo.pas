unit uModulo;

interface

uses
  SysUtils,
  Classes,
  ArquivoConfiguracao,
  LogErros,
  ZConnection,
  ZDataset,
  DB,
  ZAbstractRODataset,
  ZAbstractDataset,
  Usuario,
  Windows,
  Versao,
  ZAbstractConnection,
  Empresa, Dialogs,
  ConfiguracoesSistema;

type
  Tdm = class(TDataModule)
    qryGenerica: TZQuery;
    ZConnection1: TZConnection;
    qryGenerica2: TZQuery;

  // Eventos
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    FArquivoConfiguracao      :TArquivoConfiguracao;
    FLogErros                 :TLogErros;
    FNomeDoExecutavel         :String;
    FConexaoBancoDeDados      :TZConnection;
    FUsuario                  :TUsuario;
    FVersao                   :TVersao;
    FVersao_BD                :Integer;
    FVersao_Sistema           :Integer;
    FCaixa_esta_aberto        :Boolean;
    FEmpresa                  :TEmpresa;
    FConfiguracoesSistema     :TConfiguracoesSistema;

    function GetVersao        :TVersao;
    function GetConexao       :TZConnection;
    function GetLogo: String;
    function GetEmpresa: TEmpresa;
    function GetUsuario: TUsuario;
    function GetConfiguracoesSistema: TConfiguracoesSistema;

  private
    function GetDiretorioSistema        :String;
    function GetIsConectadoBancoDeDados :Boolean;
    function GetNomeDoTerminal          :String;
    function getVersaoBD                :Integer;

    procedure verifica_versao_sistema;
    function verifica_caixa_esta_aberto :Boolean;

  private
    procedure SetArquivoConfiguracao(const Value: TArquivoConfiguracao);
    procedure SetLogErros           (const Value: TLogErros);
    procedure SetUsuario            (const Value: TUsuario);
    procedure SetVersao             (const Value: TVersao);
    procedure SetVersao_BD          (const Value: integer);

    procedure PreencheDadosConexaoBancoDeDados(Sender: TObject);

  public
    constructor Create(AOwner :TComponent); override;

  public
    cancelaInicializacao :Boolean;    

  // Propriedades
  public
     property LogErros              :TLogErros            read FLogErros            write SetLogErros;
     property ArquivoConfiguracao   :TArquivoConfiguracao read FArquivoConfiguracao write SetArquivoConfiguracao;
     property UsuarioLogado         :TUsuario             read GetUsuario           write SetUsuario;
     property Versao                :TVersao              read GetVersao            write SetVersao;

     // Apenas leitura
     property DiretorioSistema          :String       read GetDiretorioSistema;
     property NomeDoTerminal            :String       read GetNomeDoTerminal;
     property IsConectadoBancoDeDados   :Boolean      read GetIsConectadoBancoDeDados;
     property conexao                   :TZConnection read GetConexao;
     property Logo                      :String       read GetLogo;
     property Versao_BD                 :integer      read getVersaoBD                 write SetVersao_BD;
     property Versao_Sistema            :integer      read FVersao_Sistema             write FVersao_Sistema;
     property Caixa_esta_aberto         :Boolean      read FCaixa_esta_aberto          write FCaixa_esta_aberto;
     property Empresa                   :TEmpresa     read GetEmpresa                  write FEmpresa;
     property Configuracoes             :TConfiguracoesSistema read GetConfiguracoesSistema write FConfiguracoesSistema;

  public
     procedure AbreConexaoBancoDeDados;
     procedure FechaConexaoBancoDeDados;

     function GetConsulta                            :TZQuery; overload;
     function GetConsulta(const SQL         :String) :TZQuery; overload;
     function GetValorGenerator(const NomeDoGenerator :String; numero :String) :Integer;
end;



var
  dm: Tdm;

implementation

uses
  FabricaRepositorio,
  Forms,
  ExcecaoBancoDeDadosInvalido,
  ExcecaoBancoDeBackupInvalido,
  Repositorio, EspecificacaoCaixaPorData, Caixa,
  ZDbcIntfs, uPadrao, uScript;

{$R *.dfm}

{ Tdm }

function Tdm.verifica_caixa_esta_aberto :Boolean;
var
  repositorio   :TRepositorio;
  Especificacao :TEspecificacaoCaixaPorData;
  Caixa         :TCaixa;
begin
  result        := false;
  repositorio   := nil;
  Caixa         := nil;
  Especificacao := nil;
  try
    Especificacao := TEspecificacaoCaixaPorData.Create(Date);

    repositorio   := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);

    Caixa               := TCaixa(repositorio.GetPorEspecificacao(Especificacao));

    if not assigned(Caixa) then Exit;

    if Caixa.data_fechamento = 0 then
      result := true;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Especificacao);
    FreeAndNil(Caixa);
  end;
end;

procedure Tdm.SetArquivoConfiguracao(const Value: TArquivoConfiguracao);
begin
  FArquivoConfiguracao := Value;
end;

procedure Tdm.SetLogErros(const Value: TLogErros);
begin
  FLogErros := Value;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  Aplicacao   :TApplication;
begin
   Aplicacao                            := (self.Owner as TApplication);
   self.FNomeDoExecutavel               := ExtractFilePath(Aplicacao.ExeName);
   self.FLogErros                       := TLogErros.Create(self.DiretorioSistema);
   self.FArquivoConfiguracao            := TArquivoConfiguracao.Create(self.DiretorioSistema);
   self.AbreConexaoBancoDeDados;

   if self.conexao.Connected then
     FCaixa_esta_aberto                   := verifica_caixa_esta_aberto;
     
   FUsuario                             := nil;
   FVersao                              := nil;

   self.verifica_versao_sistema;

   qryGenerica.Connection := self.FConexaoBancoDeDados;

   FEmpresa := Empresa;
end;

function Tdm.GetDiretorioSistema: String;
begin
   result := ExtractFilePath(self.FNomeDoExecutavel); 
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
   FreeAndNil(self.FArquivoConfiguracao);
   FreeAndNil(self.FLogErros);
   FreeAndNil(self.FConexaoBancoDeDados);
   FreeAndNil(self.FUsuario);
   FreeAndNil(self.FVersao);
end;

procedure Tdm.PreencheDadosConexaoBancoDeDados(Sender: TObject);
begin
    self.FConexaoBancoDeDados.Connected       := False;

    self.FConexaoBancoDeDados.Port            := self.FArquivoConfiguracao.PortaBancoDeDados;
    self.FConexaoBancoDeDados.Protocol        := self.FArquivoConfiguracao.ProtocoloBancoDeDados;
    self.FConexaoBancoDeDados.User            := self.FArquivoConfiguracao.UsuarioBancoDeDados;
    self.FConexaoBancoDeDados.Password        := self.FArquivoConfiguracao.SenhaBancoDeDados;
    self.FConexaoBancoDeDados.Database        := self.FArquivoConfiguracao.NomeServidorBancoDeDados + ':' + self.FArquivoConfiguracao.CaminhoBancoDeDados;

    self.ZConnection1.Connected               := False;

    self.ZConnection1.Port                    := self.FArquivoConfiguracao.PortaBancoDeDados;
    self.ZConnection1.Protocol                := self.FArquivoConfiguracao.ProtocoloBancoDeDados;
    self.ZConnection1.User                    := self.FArquivoConfiguracao.UsuarioBancoDeDados;
    self.ZConnection1.Password                := self.FArquivoConfiguracao.SenhaBancoDeDados;
    self.ZConnection1.Database                := self.FArquivoConfiguracao.NomeServidorBancoDeDados + ':' + self.FArquivoConfiguracao.CaminhoBancoDeDadosLocal;

end;

constructor Tdm.Create(AOwner: TComponent);
begin
  inherited;

  self.FConexaoBancoDeDados               := TZConnection.Create(nil);
  self.FConexaoBancoDeDados.BeforeConnect := self.PreencheDadosConexaoBancoDeDados;
end;

procedure Tdm.AbreConexaoBancoDeDados;
begin
   try
     try

       self.FConexaoBancoDeDados.TransactIsolationLevel := tiReadCommitted;

       self.FConexaoBancoDeDados.AutoCommit             := true;
       self.FConexaoBancoDeDados.Connected              := true;

       ZConnection1.Connected  := true;

     except
       on E: Exception do
        raise TExcecaoBancoDeDadosInvalido.Create;
     end;
   except
     on E: TExcecaoBancoDeDadosInvalido do
        self.FLogErros.AdicionaErro('uModulo', 'TExcecaoBancoDeDadosInvalido', E.Message);
   end;
end;

function Tdm.GetIsConectadoBancoDeDados: Boolean;
begin
   result := self.FConexaoBancoDeDados.Connected;
end;

procedure Tdm.FechaConexaoBancoDeDados;
begin
   self.FConexaoBancoDeDados.Connected := false;
   self.ZConnection1.Connected         := false; 
end;

function Tdm.GetConsulta: TZQuery;
begin
   result            := TZQuery.Create(nil);
   result.Connection := self.FConexaoBancoDeDados;
   result.SQL.Clear;
end;

function Tdm.GetConsulta(const SQL: String): TZQuery;
begin
   result := self.GetConsulta;
   result.SQL.Add(SQL);
end;

procedure Tdm.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

function Tdm.GetValorGenerator(const NomeDoGenerator: String; numero :String): Integer;
begin
   try
     qryGenerica.sql.Text := 'select gen_id(' + NomeDoGenerator + ', '+numero+' ) from rdb$database';
     qryGenerica.Open;

     result := qryGenerica.Fields[0].AsInteger;
   finally
     qryGenerica.Close;
    // FreeAndNil(qryGenerica);
   end;
end;

function Tdm.GetNomeDoTerminal: String;
var
  Buffer       :Array [0 .. 255] of Char;
  Size         :DWORD;
  ComputerName :String;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(Buffer, Size);
  ComputerName := Buffer;
  Result := ComputerName;
end;

procedure Tdm.SetVersao(const Value: TVersao);
begin
  FVersao := Value;
end;

function Tdm.GetVersao: TVersao;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FVersao) then begin
      Repositorio := TFabricaRepositorio.GetRepositorio(TVersao.ClassName);

      try
        self.FVersao := TVersao(Repositorio.Get(0));
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   if not Assigned(self.FVersao) then
    raise Exception.Create('ATENÇÃO!'+#13+'Não foi possível encontrar o registro de parâmetros no banco de dados. Informe o suporte!');

   result := self.FVersao;
end;

function Tdm.GetConexao: TZConnection;
begin
  Result := FConexaoBancoDeDados;
end;

function Tdm.GetLogo: String;
begin
   result := self.DiretorioSistema + 'logo.png';
end;

function Tdm.getVersaoBD: Integer;
var repositorio :TRepositorio;
    Versao      :TVersao;
begin
  Result := 0;

  if not self.FVersao_BD <= 0 then begin
    repositorio  := TFabricaRepositorio.GetRepositorio(TVersao.ClassName);
    Versao       := TVersao( repositorio.Get(0) );

    if assigned( Versao ) then
      self.FVersao_BD := Versao.VersaoBancoDeDados;
  end;

  Result := self.FVersao_BD;

end;

procedure Tdm.verifica_versao_sistema;
begin
  frmScript := TfrmScript.Create(nil);
  frmPadrao := TfrmPadrao.Create(nil);

  self.FVersao_Sistema := UltimaVersaoSistema;

  try
  if getVersaoBD = 0 then   frmScript.ExecutaAtualizacoesBanco;

  if UltimaVersaoSistema > self.getVersaoBD then
    begin

    if frmPadrao.confirma( '>>> Atenção <<<' + #13#10 +
                           'As atualizações que serão realizadas a seguir são irreverssíveis!' + #13#10 +
                           'Você ja fez um backup do sistema antes de atualizar?') then
      begin

          if not frmScript.ExecutaAtualizacoesBanco then
            begin
              frmPadrao.avisar('Não foi possível atualizar o banco de dados!');
              cancelaInicializacao := true;
              exit;
            end;

        end
      else
        begin
          cancelaInicializacao := true;
          exit;
        end;
    end;

  if UltimaVersaoSistema < self.FVersao_BD then
    begin
      frmPadrao.Avisar('O seu sistema encontra-se desatualizado!' + #13 + 'Favor atualizar antes de continuar!');
      cancelaInicializacao := true;
    end;

  finally
    frmPadrao.Release;
    frmPadrao := nil;
    frmScript.Release;
    frmScript := nil;
  end;
end;

procedure Tdm.SetVersao_BD(const Value: integer);
begin
  self.FVersao_BD := value;
end;

function Tdm.GetEmpresa: TEmpresa;
var repositorio :TRepositorio;
begin

  if not assigned(FEmpresa) then begin
    repositorio := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    FEmpresa    := TEmpresa( repositorio.Get(1) );
  end;

  result := FEmpresa;
end;

function Tdm.GetUsuario: TUsuario;
var
    repositorio :TRepositorio;
begin

  if not assigned(FUsuario) then begin
    repositorio := nil;
    try
      repositorio := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
      FUsuario    := TUsuario( repositorio.Get(1) );

    Finally
      FreeAndNil(repositorio);
    end;
  end;

  result := FUsuario;
end;

function Tdm.GetConfiguracoesSistema: TConfiguracoesSistema;
var repositorio :TRepositorio;
begin

  if not assigned(FConfiguracoesSistema) then begin
    repositorio           := TFabricaRepositorio.GetRepositorio(TConfiguracoesSistema.ClassName);
    FConfiguracoesSistema := TConfiguracoesSistema( repositorio.Get(1) );
  end;

  result := FConfiguracoesSistema;
end;

end.
