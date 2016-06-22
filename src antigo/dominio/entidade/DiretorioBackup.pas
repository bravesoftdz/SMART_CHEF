unit DiretorioBackup;

interface

uses
  Usuario;

type
  TDiretorioBackup = class

  private
    FCodigo             :Integer;
    FCaminho            :String;
    FUsuario            :TUsuario;
    FCodigoUsuario      :Integer;

    procedure SetCaminho           (const Value: String);
    procedure SetCodigo            (const Value: Integer);
    procedure SetUsuario           (const Value: TUsuario);
    procedure SetCodigoUsuario     (const Value: Integer);

  public
    constructor Create;
    destructor  Destroy; override;

  public
    property Codigo             :Integer  read FCodigo             write SetCodigo;
    property Caminho            :String   read FCaminho            write SetCaminho;
    property CodigoUsuario      :Integer  read FCodigoUsuario      write SetCodigoUsuario;
    property Usuario            :TUsuario read FUsuario            write SetUsuario;
end;

implementation

uses
  Repositorio,
  FabricaRepositorio,
  SysUtils;

{ TDiretorioBackup }

constructor TDiretorioBackup.Create;
begin
   self.FCodigo             := 0;
   self.FCaminho            := '';
   self.FUsuario            := nil;
end;

destructor TDiretorioBackup.Destroy;
begin
  self.FUsuario := nil;

  inherited;
end;

procedure TDiretorioBackup.SetCaminho(const Value: String);
begin
  FCaminho := Value;
end;

procedure TDiretorioBackup.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TDiretorioBackup.SetCodigoUsuario(const Value: Integer);
begin
  FCodigoUsuario := Value;
end;

procedure TDiretorioBackup.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;

  if Assigned(self.FUsuario) then self.FCodigoUsuario := self.FUsuario.Codigo;
end;

end.
