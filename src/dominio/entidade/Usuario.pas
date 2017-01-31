unit Usuario;

interface

uses
  SysUtils,
  Perfil,
  Contnrs,
  Departamento, Generics.Collections;

type
  TUsuario = class
  
  private
    FCodigo           :Integer;
    FLogin            :String;
    FNome             :String;
    FSenha            :String;
    FCodPerfil        :Integer;
    FPerfil           :TPerfil;
    FDiretoriosBackup :TObjectList;
    FBloqueado: Boolean;
    Fcodigo_departamento :integer;
    FDepartamento     :TDepartamento;

    procedure CriaListaDiretoriosBackup;
    function GetDepartamento: TDepartamento;

  private
    function GetPerfil                   :TPerfil;
    function GetDiretoriosBackup         :TObjectList;

  public
    constructor Create;
    destructor  Destroy; override;

  public
    property Codigo              : Integer     read FCodigo              write FCodigo;
    property Nome                : String      read FNome                write FNome;
    property Login               : String      read FLogin               write FLogin;
    property Senha               : String      read FSenha               write FSenha;
    property CodPerfil           : Integer     read FCodPerfil           write FCodPerfil;
    property Perfil              : TPerfil     read GetPerfil;
    property DiretoriosBackup    : TObjectList read GetDiretoriosBackup  write FDiretoriosBackup;
    property Bloqueado           : Boolean     read FBloqueado           write FBloqueado;
    property Codigo_departamento : Integer     read Fcodigo_departamento write Fcodigo_departamento;

    property Departamento        :TDepartamento read GetDepartamento;

  public
    procedure AdicionaDiretorioDeBackup(DiretorioBackup :TObject);
    procedure RemoveDiretorioDeBackup  (DiretorioBackup :TObject); 

  public
    function ProcuraDiretorioPeloCaminho(const Caminho :String) :TObject;
end;

implementation

uses
  FabricaRepositorio,
  Repositorio,
  DiretorioBackup,
  Classes,
  EspecificacaoDiretorioBackupComUsuarioIgualA,
  ExcecaoParametroInvalido,
  ExcecaoAtributoDuplicado;

{ TUsuario }

procedure TUsuario.AdicionaDiretorioDeBackup(DiretorioBackup: TObject);
var
  NovoDiretorio                   :TDiretorioBackup;
  DiretorioPrincipalJaAdicionado  :TDiretorioBackup;
begin
   if not Assigned(self.FDiretoriosBackup) then
     self.CriaListaDiretoriosBackup;

   if not (DiretorioBackup is TDiretorioBackup) then
     raise TExcecaoParametroInvalido.Create(self.ClassName, 'AdicionaDiretorioDeBackup(DiretorioBackup: TObject)', 'DiretorioBackup' );

   NovoDiretorio := (DiretorioBackup as TDiretorioBackup);

  if Assigned(self.ProcuraDiretorioPeloCaminho(NovoDiretorio.Caminho)) then
    raise TExcecaoAtributoDuplicado.Create('Esse caminho de backup já foi definido para esse usuário!');

  NovoDiretorio.Usuario := self;
  self.FDiretoriosBackup.Add(NovoDiretorio);
end;

constructor TUsuario.Create;
begin
   self.FCodigo            := 0;
   self.FLogin             := '';
   self.FNome              := '';
   self.FSenha             := '';
   self.FCodPerfil         := 0;
   self.FPerfil            := nil;
   self.FDiretoriosBackup  := nil;
end;

procedure TUsuario.CriaListaDiretoriosBackup;
begin
   if Assigned(self.FDiretoriosBackup) then
    FreeAndNil(self.FDiretoriosBackup);

   self.FDiretoriosBackup := TObjectList.Create;
end;

destructor TUsuario.Destroy;
begin
  if Assigned(self.FPerfil) then
    FreeAndNil(self.FPerfil);;

  if Assigned(self.FDiretoriosBackup) then
    FreeAndNil(self.FDiretoriosBackup);

  inherited;
end;

function TUsuario.GetDiretoriosBackup: TObjectList;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoDiretorioBackupComUsuarioIgualA;
  Lista         :TObjectList<TList>;
  nX            :Integer;
begin
   Repositorio   := nil;
   Especificacao := nil;

   if not Assigned(self.FDiretoriosBackup) then
    begin
       try
         Repositorio   := TFabricaRepositorio.GetRepositorio(TDiretorioBackup.ClassName);
         Especificacao := TEspecificacaoDiretorioBackupComUsuarioIgualA.Create(self);
         Lista         := Repositorio.GetListaPorEspecificacao<TList>(Especificacao);

         if Assigned(Lista) and (Lista.Count > 0) then begin
           self.FDiretoriosBackup := TObjectList.Create;

           for nX := 0 to (Lista.Count-1) do begin
              self.FDiretoriosBackup.Add(TDiretorioBackup(Lista.Items[nX]));
              TDiretorioBackup(Lista.Items[nX]).Usuario := self;
           end;
         end;

       finally
         FreeAndNil(Repositorio);
         FreeAndNil(Especificacao);
         FreeAndNil(Lista);
       end;
    end;

   result := self.FDiretoriosBackup;
end;

function TUsuario.GetPerfil: TPerfil;
var
  rep :TRepositorio;
begin
 rep := nil;
 
 try
  if FPerfil = nil then begin
    Rep           := TFabricaRepositorio.GetRepositorio(TPerfil.ClassName);
    self.FPerfil  := TPerfil(Rep.Get(self.FCodPerfil));
  end;

  Result := FPerfil;

 finally
   FreeAndNil(rep);
 end;
end;

procedure TUsuario.RemoveDiretorioDeBackup(DiretorioBackup: TObject);
begin
   if not Assigned(self.FDiretoriosBackup) then exit;

   self.FDiretoriosBackup.Remove(DiretorioBackup);
end;

function TUsuario.ProcuraDiretorioPeloCaminho(
  const Caminho: String): TObject;
var
  nX :Integer;
begin
   result := nil;

   if not Assigned(self.FDiretoriosBackup) then exit;

   for nX := 0 to (self.FDiretoriosBackup.Count-1) do begin
      if (Trim(Caminho) = TDiretorioBackup(self.FDiretoriosBackup.Items[nX]).Caminho) then begin
         result := self.FDiretoriosBackup.Items[nX];
         exit;
      end;
   end;
end;

function TUsuario.GetDepartamento: TDepartamento;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FDepartamento) then begin
        Repositorio           := TFabricaRepositorio.GetRepositorio(TDepartamento.ClassName);
        self.FDepartamento    := TDepartamento(Repositorio.Get(self.Fcodigo_departamento));
      end;

      result := self.FDepartamento;
   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
 