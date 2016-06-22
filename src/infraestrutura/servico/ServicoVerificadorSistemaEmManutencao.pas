unit ServicoVerificadorSistemaEmManutencao;

interface

uses
  EventoAvisar,
  EventoFechar,
  EventoExecutarOperacao,
  EventoExecutandoOperacao,
  ManutencaoSistema,
  ExtCtrls;

type
  TServicoVerificadorSistemaEmManutencao = class

  private
    FCronometroVerificador        :TTimer;
    FCronometroContagemRegressiva :TTimer;
    FManutencao                   :TManutencaoSistema;
    FMostrarAviso                 :TEventoAvisar;
    FFecharSistema                :TEventoFechar;
    FIniciarContagemRegressiva    :TEventoExecutarOperacao;
    FTerminarContagemRegressiva   :TEventoExecutarOperacao;
    FMostrarTempoRestante         :TEventoExecutandoOperacao;

  private
    procedure VerificaSeEstaEmManutencao(Sender :TObject);
    procedure MostrarTempoRestante      (Sender :TObject);
    procedure IniciaContagemRegressiva;

  public
    constructor Create(FecharSisTema              :TEventoFechar;
                       MostrarAviso               :TEventoAvisar;
                       IniciarContagemRegressiva  :TEventoExecutarOperacao;
                       MostrarTempoRestante       :TEventoExecutandoOperacao;
                       TerminarContagemRegressiva :TEventoExecutarOperacao);
    destructor  Destroy; override;
end;

implementation

uses
  SysUtils, Repositorio, FabricaRepositorio, DateUtils,
  ExcecaoParametroInvalido;

const
  INTERVALO_DE_VERIFICACAO = 1000;

{ TServicoVerificadorSistemaEmManutencao }

constructor TServicoVerificadorSistemaEmManutencao.Create(FecharSistema :TEventoFechar; MostrarAviso :TEventoAvisar; IniciarContagemRegressiva :TEventoExecutarOperacao; MostrarTempoRestante :TEventoExecutandoOperacao; TerminarContagemRegressiva :TEventoExecutarOperacao);
const
  NOME_METODO = 'Create(FecharSistema :TEventoFechar; MostrarAviso :TEventoAvisar; IniciarContagemRegressiva :TEventoExecutarOperacao; MostrarTempoRestante :TEventoExecutandoOperacao; TerminarContagemRegressiva :TEventoExecutarOperacao';
begin
   if not Assigned(FecharSistema) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                          NOME_METODO,
                                          'FecharSistema');

   if not Assigned(MostrarAviso) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                          NOME_METODO,
                                          'MostrarAviso');

   if not Assigned(IniciarContagemRegressiva) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                          NOME_METODO,
                                          'IniciarContagemRegressiva');

   if not Assigned(MostrarTempoRestante) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                          NOME_METODO,
                                          'MostrarTempoRestante');

   if not Assigned(TerminarContagemRegressiva) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                          NOME_METODO,
                                          'TerminarContagemRegressiva');


   self.FCronometroVerificador                  := TTimer.Create(nil);
   self.FCronometroVerificador.Interval         := INTERVALO_DE_VERIFICACAO;
   self.FCronometroVerificador.OnTimer          := self.VerificaSeEstaEmManutencao;
   self.FCronometroVerificador.Enabled          := true;

   self.FCronometroContagemRegressiva           := TTimer.Create(nil);
   self.FCronometroContagemRegressiva.Enabled   := false;
   self.FCronometroContagemRegressiva.Interval  := INTERVALO_DE_VERIFICACAO;
   self.FCronometroContagemRegressiva.OnTimer   := self.MostrarTempoRestante;

   self.FMostrarAviso               := MostrarAviso;
   self.FFecharSistema              := FecharSisTema;
   self.FIniciarContagemRegressiva  := IniciarContagemRegressiva;
   self.FMostrarTempoRestante       := MostrarTempoRestante;
   self.FTerminarContagemRegressiva := TerminarContagemRegressiva;
end;

destructor TServicoVerificadorSistemaEmManutencao.Destroy;
begin
  if Assigned(self.FCronometroVerificador) then
    FreeAndNil(self.FCronometroVerificador);

  if Assigned(self.FCronometroContagemRegressiva) then
    FreeAndNil(self.FCronometroContagemRegressiva);

  if Assigned(self.FManutencao) then
    FreeAndNil(self.FManutencao);

   self.FMostrarAviso               := nil;
   self.FFecharSistema              := nil;
   self.FIniciarContagemRegressiva  := nil;
   self.FMostrarTempoRestante       := nil;
   self.FTerminarContagemRegressiva := nil;

  inherited;
end;

procedure TServicoVerificadorSistemaEmManutencao.IniciaContagemRegressiva;
begin
   if self.FCronometroContagemRegressiva.Enabled then exit;

   self.FCronometroContagemRegressiva.Enabled := true;
   self.FMostrarAviso('O sistema está se preparando para entrar em manutenção. Aproveite para salvar o que você está fazendo. Será aberto uma contagem regressiva para o fechamento do sistema '+
                      'e início da manutenção. Não se preocupe, o sistema fechará sozinho no término da contagem.', 10);
   self.FIniciarContagemRegressiva();
end;

procedure TServicoVerificadorSistemaEmManutencao.MostrarTempoRestante(
  Sender: TObject);
begin
   self.FMostrarTempoRestante(FormatDateTime('hh:mm:ss', (self.FManutencao.HorarioTermino - TRepositorio.HorarioBancoDeDados)));
end;

procedure TServicoVerificadorSistemaEmManutencao.VerificaSeEstaEmManutencao(
  Sender: TObject);
var
  MinutosParaEncerrar :Double;
  Repositorio         :TRepositorio;
begin
   Repositorio := TFabricaRepositorio.GetRepositorio(TManutencaoSistema.ClassName);

   try
     if not Assigned(self.FManutencao) then
      self.FManutencao := TManutencaoSistema(Repositorio.Get(0));

     if not Assigned(self.FManutencao) then
      exit;

     self.IniciaContagemRegressiva();

     if (TRepositorio.HorarioBancoDeDados >= self.FManutencao.HorarioTermino) then begin
        self.FTerminarContagemRegressiva();
        self.FMostrarAviso('O sistema será fechado e só será liberado quando a manutenção estiver concluída!', 3);
        self.FFecharSistema();
     end;
   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
