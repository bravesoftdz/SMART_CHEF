unit Auditoria;

interface

uses
  Usuario,
  Contnrs;

type
  TAuditoria = class

  private
    FCodigo           :Integer;
    FCodigoUsuario    :Integer;
    FHora             :TDateTime;
    FNomeTerminal     :String;
    FNomeTabela       :String;
    FData             :TDateTime;
    FUsuario          :TUsuario;
    FCamposAlterados  :TObjectList;
    FCamposIncluidos  :TObjectList;
    FCamposExcluidos  :TObjectList;

    FCriouUsuario         :Boolean;
    FCriouCamposAlterados :Boolean;
    FCriouCamposIncluidos :Boolean;
    FCriouCamposExcluidos :Boolean;

    procedure SetCodigo         (const Value: Integer);
    procedure SetCodigoUsuario  (const Value: Integer);
    procedure SetData           (const Value: TDateTime);
    procedure SetHora           (const Value: TDateTime);
    procedure SetNomeTabela     (const Value: String);
    procedure SetNomeTerminal   (const Value: String);
    procedure SetUsuario        (const Value: TUsuario);

    procedure SetCamposIncluidos(const Value: TObjectList);
    procedure SetCamposAlterados(const Value: TObjectList);
    procedure SetCamposExcluidos(const Value: TObjectList);
    function GetTemCamposParaPersistir: Boolean;

  private
    function GetCamposAlterados: TObjectList;
    function GetCamposExcluidos: TObjectList;
    function GetCamposIncluidos: TObjectList;

  private
    function GetUsuario: TUsuario;

  public
    property Codigo        :Integer   read FCodigo        write SetCodigo;
    property CodigoUsuario :Integer   read FCodigoUsuario write SetCodigoUsuario;
    property Usuario       :TUsuario  read GetUsuario     write SetUsuario;
    property NomeTabela    :String    read FNomeTabela    write SetNomeTabela;
    property NomeTerminal  :String    read FNomeTerminal  write SetNomeTerminal;
    property Data          :TDateTime read FData          write SetData;
    property Hora          :TDateTime read FHora          write SetHora;

    property CamposIncluidos :TObjectList read GetCamposIncluidos write SetCamposIncluidos;
    property CamposAlterados :TObjectList read GetCamposAlterados write SetCamposAlterados;
    property CamposExcluidos :TObjectList read GetCamposExcluidos write SetCamposExcluidos;

    property TemCamposParaPersistir :Boolean read GetTemCamposParaPersistir;

  public
    constructor Create(Usuario       :TUsuario; NomeTabela, NomeTerminal :String); overload;
    constructor Create(NomeTabela, NomeTerminal :String); overload;
    destructor  Destroy; override;

  public
    procedure AdicionaCampoIncluido(NomeDoCampo, ValorDoCampo :String);
    procedure AdicionaCampoExcluido(NomeDoCampo, ValorDoCampo :String);
    procedure AdicionaCampoAlterado(NomeDoCampo, ValorAntigo, ValorNovo :String);
end;

implementation

uses
  Repositorio,
  FabricaRepositorio,
  SysUtils, CampoAuditoria, CampoAlteracaoAuditoria;

{ TAuditoria }

constructor TAuditoria.Create(Usuario: TUsuario; NomeTabela,
  NomeTerminal: String);
begin
   self.Codigo       := 0;
   self.Usuario      := Usuario;
   self.NomeTabela   := NomeTabela;
   self.NomeTerminal := NomeTerminal;
   self.Data         := Date;
   self.Hora         := Time;

   self.FCamposAlterados := nil;
   self.FCamposIncluidos := nil;
   self.FCamposExcluidos := nil;

   self.FCriouCamposAlterados := false;
   self.FCriouCamposIncluidos := false;
   self.FCriouCamposExcluidos := false;
end;

procedure TAuditoria.AdicionaCampoIncluido(NomeDoCampo,
  ValorDoCampo: String);
var
  CampoAuditoria :TCampoAuditoria;
begin
   if not Assigned(self.FCamposIncluidos) then begin
     self.FCamposIncluidos := TObjectList.Create;
     self.FCriouCamposIncluidos := true;
   end;

  CampoAuditoria            := TCampoAuditoria.Create;
  CampoAuditoria.NomeCampo  := UpperCase(Trim(NomeDoCampo));
  CampoAuditoria.ValorCampo := Trim(ValorDoCampo);
  CampoAuditoria.Auditoria  := self;

  self.FCamposIncluidos.Add(CampoAuditoria);
end;

constructor TAuditoria.Create(NomeTabela, NomeTerminal: String);
begin
   self.Create(nil, NomeTabela, NomeTerminal);
end;

destructor TAuditoria.Destroy;
begin
  if self.FCriouUsuario and Assigned(self.FUsuario) then
    FreeAndNil(self.FUsuario);

  if self.FCriouCamposIncluidos and Assigned(self.FCamposIncluidos) then
    FreeAndNil(self.FCamposIncluidos);

  if self.FCriouCamposAlterados and Assigned(self.FCamposAlterados) then
    FreeAndNil(self.FCamposAlterados);

  if self.FCriouCamposExcluidos and Assigned(self.FCamposExcluidos) then
    FreeAndNil(self.FCamposExcluidos);

  inherited;
end;

function TAuditoria.GetCamposAlterados: TObjectList;
begin
   result := self.FCamposAlterados
end;

function TAuditoria.GetCamposExcluidos: TObjectList;
begin
   result := self.FCamposExcluidos
end;

function TAuditoria.GetCamposIncluidos: TObjectList;
begin
   result := self.FCamposIncluidos;
end;

function TAuditoria.GetUsuario: TUsuario;
var
  Repositorio :TRepositorio;
begin
   result := nil;

   Repositorio := nil;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);

     if not Assigned(self.FUsuario) then begin
        self.FUsuario      := TUsuario(Repositorio.Get(self.FCodigoUsuario));
        self.FCriouUsuario := true;
     end;

     result := self.FUsuario;
   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TAuditoria.SetCamposAlterados(const Value: TObjectList);
begin
  FCamposAlterados := Value;
end;

procedure TAuditoria.SetCamposExcluidos(const Value: TObjectList);
begin
  FCamposExcluidos := Value;
end;

procedure TAuditoria.SetCamposIncluidos(const Value: TObjectList);
begin
  FCamposIncluidos := Value;
end;

procedure TAuditoria.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TAuditoria.SetCodigoUsuario(const Value: Integer);
begin
  FCodigoUsuario := Value;

  if (self.FCodigoUsuario > 0) and
     (Assigned(self.FUsuario) and (self.FCodigoUsuario <> self.FUsuario.Codigo)) then begin
     
     if self.FCriouUsuario then
      FreeAndNil(self.FUsuario);

     self.Usuario;
  end;
end;

procedure TAuditoria.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TAuditoria.SetHora(const Value: TDateTime);
begin
  FHora := Value;
end;

procedure TAuditoria.SetNomeTabela(const Value: String);
begin
  FNomeTabela := Value;
end;

procedure TAuditoria.SetNomeTerminal(const Value: String);
begin
  FNomeTerminal := Value;
end;

procedure TAuditoria.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;

  if Assigned(self.FUsuario) then
    self.FCodigoUsuario := self.FUsuario.Codigo;
end;

procedure TAuditoria.AdicionaCampoExcluido(NomeDoCampo,
  ValorDoCampo: String);
var
  CampoAuditoria :TCampoAuditoria;
begin
   if not Assigned(self.FCamposExcluidos) then begin
     self.FCamposExcluidos := TObjectList.Create;
     self.FCriouCamposExcluidos := true;
   end;

  CampoAuditoria            := TCampoAuditoria.Create;
  CampoAuditoria.NomeCampo  := UpperCase(Trim(NomeDoCampo));
  CampoAuditoria.ValorCampo := Trim(ValorDoCampo);
  CampoAuditoria.Auditoria  := self;

  self.FCamposExcluidos.Add(CampoAuditoria);
end;

procedure TAuditoria.AdicionaCampoAlterado(NomeDoCampo, ValorAntigo,
  ValorNovo: String);
var
  CampoAlteracaoAuditoria :TCampoAlteracaoAuditoria;
begin
   if not Assigned(self.FCamposAlterados) then begin
     self.FCamposAlterados := TObjectList.Create;
     self.FCriouCamposAlterados := true;
   end;

  CampoAlteracaoAuditoria                  := TCampoAlteracaoAuditoria.Create;
  CampoAlteracaoAuditoria.NomeCampo        := UpperCase(Trim(NomeDoCampo));
  CampoAlteracaoAuditoria.ValorCampoAntigo := Trim(ValorAntigo);
  CampoAlteracaoAuditoria.ValorCampoNovo   := Trim(ValorNovo);
  CampoAlteracaoAuditoria.Auditoria        := self;

  self.FCamposAlterados.Add(CampoAlteracaoAuditoria);
end;

function TAuditoria.GetTemCamposParaPersistir: Boolean;
begin
   result := (Assigned(self.FCamposIncluidos) and (self.FCamposIncluidos.Count > 0)) or
             (Assigned(self.FCamposAlterados) and (self.FCamposAlterados.Count > 0)) or
             (Assigned(self.FCamposExcluidos) and (self.FCamposExcluidos.Count > 0));
end;

end.
