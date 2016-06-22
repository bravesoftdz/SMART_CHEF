unit ServicoBackup;

interface

uses
  ArquivoConfiguracao,
  Usuario,
  IBServices,
  EventoExecutandoOperacao;

type
  TServicoBackup = class

  private
    FIBBackup            :TIBBackupService;
    FArquivoConfiguracao :TArquivoConfiguracao;
    FUsuario             :TUsuario;

  private
    function GetNomeArquivo: String;

  private
    property NomeArquivo :String read GetNomeArquivo;

  public
    constructor Create(ArquivoConfiguracao :TArquivoConfiguracao; Usuario :TUsuario);
    destructor  Destroy; override;

  public
    procedure SetUsuario            (Usuario                  :TUsuario);
    procedure SetArquivoConfiguracao(ArquivoConfiguracao      :TArquivoConfiguracao);
    procedure RealizarOperacao      (EventoExecutandoOperacao :TEventoExecutandoOperacao);
end;

implementation

uses
  ExcecaoParametroInvalido,
  SysUtils,
  DiretorioBackup,
  Contnrs,
  DateUtils,
  Classes;

const
  ERRO_USUARIO = 'Erro em TServicoBackup. Propriedade Usuario não foi definida com o método SetUsuario(Usuario :TUsuario)'+#13+
                 'Contate a área do TI';

{ TServicoBackup }

constructor TServicoBackup.Create(ArquivoConfiguracao :TArquivoConfiguracao; Usuario :TUsuario);
begin
   self.FIBBackup             := TIBBackupService.Create(nil);

   self.FIBBackup.LoginPrompt := false;
   self.FIBBackup.Protocol    := TCP;
   self.FIBBackup.Verbose     := true;
   self.FIBBackup.Options     := [NoGarbageCollection, IgnoreLimbo];

  self.SetArquivoConfiguracao(ArquivoConfiguracao);
  self.SetUsuario(Usuario);
end;

destructor TServicoBackup.Destroy;
begin
  if Assigned(self.FIBBackup) then
    FreeAndNil(self.FIBBackup);

  FArquivoConfiguracao := nil;
  FUsuario             := nil;

  inherited;
end;

function TServicoBackup.GetNomeArquivo: String;
var
  Ano, Mes, Dia                          :Word;
  Horas, Minutos, Segundos, Milisegundos :Word;
begin
   try
      DecodeDateTime(Now, Ano, Mes, Dia,
                     Horas, Minutos, Segundos, Milisegundos);

     result := 'Backup de '+self.FUsuario.Nome+'. Hora '+IntToStr(Horas)+'-'+IntToStr(Minutos)+'-'+IntToStr(Segundos)+
                                                '. Dia '+IntToStr(Dia)  +'-'+IntToStr(Mes)  +'-'+IntToStr(Ano)+'.fbk';
   except
     on E: EAccessViolation do
      raise Exception.Create(ERRO_USUARIO);
   end;
end;

procedure TServicoBackup.RealizarOperacao(
  EventoExecutandoOperacao: TEventoExecutandoOperacao);
var
  nX      :Integer;
  Linha   :String;
begin
   try
      if not Assigned(self.FUsuario.DiretoriosBackup) or (self.FUsuario.DiretoriosBackup.Count <= 0) then
        raise Exception.Create('Erro em TServicoBackup. Nenhum diretório de backup foi definido para o usuário '+self.FUsuario.Nome+
                              '. Contate a área do TI');

      for nX := 0 to (self.FUsuario.DiretoriosBackup.Count-1) do begin
         self.FIBBackup.BackupFile.Clear;
         self.FIBBackup.BackupFile.Add(TDiretorioBackup(self.FUsuario.DiretoriosBackup.Items[nX]).Caminho + '\' + self.NomeArquivo);

         self.FIBBackup.Active := true;
         self.FIBBackup.ServiceStart;

         while not self.FIBBackup.Eof do begin
            Linha := self.FIBBackup.GetNextLine;

            if Assigned(EventoExecutandoOperacao) then
              EventoExecutandoOperacao(Linha);
         end;

         self.FIBBackup.Active := false;
      end;
   except
     on E: EAccessViolation do begin
       raise Exception.Create(ERRO_USUARIO);
     end;
   end;
end;

procedure TServicoBackup.SetArquivoConfiguracao(ArquivoConfiguracao: TArquivoConfiguracao);
var
  NomeArquivo :String;
begin
   if not Assigned(ArquivoConfiguracao) then
     raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetArquivoConfiguracao(ArquivoConfiguracao: TArquivoConfiguracao);', 'ArquivoConfiguracao');

   self.FIBBackup.Params.Clear;
   self.FIBBackup.BackupFile.Clear;
   self.FIBBackup.ServerName   := ArquivoConfiguracao.NomeServidorBancoDeDados;
   self.FIBBackup.DatabaseName := ArquivoConfiguracao.CaminhoBancoDeDados;

   self.FIBBackup.Params.Add('user_name='+ArquivoConfiguracao.UsuarioBancoDeDados);
   self.FIBBackup.Params.Add('password='+ArquivoConfiguracao.SenhaBancoDeDados);

   self.FArquivoConfiguracao := ArquivoConfiguracao;
end;

procedure TServicoBackup.SetUsuario(Usuario: TUsuario);
begin
   if not Assigned(Usuario) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetUsuario(Usuario: TUsuario);', 'Usuario');

   self.FUsuario := Usuario;
end;

end.
