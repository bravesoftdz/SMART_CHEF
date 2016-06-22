unit ManutencaoSistema;

interface

uses
  Usuario;

type
  TManutencaoSistema = class

  private
    FCriouUsuario                   :Boolean;
    FCodigoUsuarioResponsavel       :Integer;
    FCodigo                         :Integer;
    FHorarioInicio                  :TDateTime;
    FHorarioTermino                 :TDateTime;
    FUsuarioResponsavel             :TUsuario;
    FTerminalResponsavel            :String;

  private
    function GetUsuarioResponsavel  :TUsuario;
    function GetTerminalResponsavel :String;

  private
    procedure SetCodigo                  (const Value: Integer);
    procedure SetCodigoUsuarioResponsavel(const Value: Integer);
    procedure SetHorarioInicio           (const Value: TDateTime);
    procedure SetHorarioTermino          (const Value: TDateTime);
    procedure SetUsuarioResponsavel      (const Value: TUsuario);
    procedure SetTerminalResponsavel     (const Value: String);

  public
    constructor Create();                                                                                                        overload;
    constructor Create(UsuarioResponsavel: TUsuario; TerminalResponsavel :String; HorarioDeInicio, HorarioDeTermino: TDatetime); overload;

  public
    destructor  Destroy; override;

  public
    property Codigo                     :Integer    read FCodigo                   write SetCodigo;
    property HorarioInicio              :TDateTime  read FHorarioInicio            write SetHorarioInicio;
    property HorarioTermino             :TDateTime  read FHorarioTermino           write SetHorarioTermino;
    property CodigoUsuarioResponsavel   :Integer    read FCodigoUsuarioResponsavel write SetCodigoUsuarioResponsavel;
    property UsuarioResponsavel         :TUsuario   read GetUsuarioResponsavel     write SetUsuarioResponsavel;
    property TerminalResponsavel        :String     read GetTerminalResponsavel    write SetTerminalResponsavel;
end;

implementation

uses
  SysUtils,
  Repositorio,
  FabricaRepositorio;

{ TManutencaoSistema }

constructor TManutencaoSistema.Create;
begin
   self.FCriouUsuario               := false;
   self.FCodigoUsuarioResponsavel   := 0;
   self.FCodigo                     := 0;
   self.FHorarioInicio              := 0;
   self.FHorarioTermino             := 0;
   self.FTerminalResponsavel        := '';
   self.FUsuarioResponsavel         := nil;  
end;

constructor TManutencaoSistema.Create(UsuarioResponsavel: TUsuario; TerminalResponsavel :String; HorarioDeInicio, HorarioDeTermino: TDatetime);
begin
   if (HorarioDeInicio > HorarioDeTermino) then
    raise Exception.Create('Horário de Início deve ser menor ou igual que o horário de término');
    
   self.Create;
   self.UsuarioResponsavel   := UsuarioResponsavel;
   self.FHorarioInicio       := HorarioDeInicio;
   self.FHorarioTermino      := HorarioDeTermino;
   self.FTerminalResponsavel := TerminalResponsavel;
end;

destructor TManutencaoSistema.Destroy;
begin
  if self.FCriouUsuario and Assigned(self.FUsuarioResponsavel) then
    FreeAndNil(self.FUsuarioResponsavel);
    
  inherited;
end;

function TManutencaoSistema.GetTerminalResponsavel: String;
begin
   result := UpperCase(Trim(self.FTerminalResponsavel));
end;

function TManutencaoSistema.GetUsuarioResponsavel: TUsuario;
var
  RepositorioUsuario :TRepositorio;
begin
   if not Assigned(self.FUsuarioResponsavel) then begin
     RepositorioUsuario       := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);

     try
       self.FCriouUsuario       := true;
       self.FUsuarioResponsavel := TUsuario(RepositorioUsuario.Get(self.FCodigoUsuarioResponsavel));
     finally
       FreeAndNil(RepositorioUsuario);
     end;
   end;

   result := self.FUsuarioResponsavel;
end;

procedure TManutencaoSistema.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TManutencaoSistema.SetCodigoUsuarioResponsavel(
  const Value: Integer);
begin
  FCodigoUsuarioResponsavel := Value;

  if (self.FCodigoUsuarioResponsavel > 0) and
     Assigned(self.FUsuarioResponsavel) and (self.FUsuarioResponsavel.Codigo <> self.FCodigoUsuarioResponsavel) then
    FreeAndNil(self.FUsuarioResponsavel);
end;

procedure TManutencaoSistema.SetHorarioInicio(const Value: TDateTime);
begin
  FHorarioInicio := Value;
end;

procedure TManutencaoSistema.SetHorarioTermino(const Value: TDateTime);
begin
  FHorarioTermino := Value;
end;

procedure TManutencaoSistema.SetTerminalResponsavel(const Value: String);
begin
  FTerminalResponsavel := Value;
end;

procedure TManutencaoSistema.SetUsuarioResponsavel(const Value: TUsuario);
begin
  FUsuarioResponsavel := Value;

  if Assigned(self.FUsuarioResponsavel) then
    self.FCodigoUsuarioResponsavel := self.FUsuarioResponsavel.Codigo;
end;

end.
