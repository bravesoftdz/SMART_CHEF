unit RepositorioUsuario;

interface

uses
  DB,
  Repositorio,
  Auditoria;

type
  TRepositorioUsuario = class(TRepositorio)

  protected
    procedure ExecutaDepoisDeSalvar(Objeto: TObject); override;

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;      override;

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

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses
  Usuario,
  FabricaRepositorio,
  DiretorioBackup,
  SysUtils, Variants;

{ TRepositorioUsuario }

procedure TRepositorioUsuario.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  nX          :Integer;
  Usuario     :TUsuario;
  Repositorio :TRepositorio;
begin
   Usuario := (Objeto as TUsuario);

   if (not Assigned(Usuario.DiretoriosBackup)) or (Usuario.DiretoriosBackup.Count <= 0) then exit;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TDiretorioBackup.ClassName);

     for nX := 0 to (Usuario.DiretoriosBackup.Count-1) do begin
        Repositorio.Salvar(Usuario.DiretoriosBackup.Items[0]);
     end;
   finally
     FreeAndNil(Repositorio);
   end;
end;

function TRepositorioUsuario.Get(Dataset: TDataSet): TObject;
var
  Usuario                     :TUsuario;
begin
   Usuario           := TUsuario.Create;
   Usuario.Codigo    := self.FQuery.FieldByName('codigo').AsInteger;
   Usuario.Nome      := self.FQuery.FieldByName('nome').AsString;
   Usuario.Login     := self.FQuery.FieldByName('login').AsString;
   Usuario.Senha     := self.FQuery.FieldByName('senha').AsString;
   Usuario.CodPerfil := self.FQuery.FieldByName('cod_Perfil').AsInteger;
   Usuario.Bloqueado := (Dataset.FieldByName('bloqueado').AsString = 'S');
   Usuario.Codigo_departamento := self.FQuery.FieldByName('codigo_departamento').AsInteger;

   result := Usuario;
end;

function TRepositorioUsuario.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TUsuario(Objeto).Codigo;
end;

function TRepositorioUsuario.GetNomeDaTabela: String;
begin
   result := 'USUARIOS';
end;

function TRepositorioUsuario.GetRepositorio: TRepositorio;
begin
   result := TRepositorioUsuario.Create;
end;

function TRepositorioUsuario.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TUsuario(Objeto).Codigo <= 0);
end;

procedure TRepositorioUsuario.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  UAntigo, UNovo :TUsuario;
begin
   UAntigo := (AntigoObjeto as TUsuario);
   UNovo   := (Objeto       as TUsuario);

   if (UAntigo.Nome <> UNovo.Nome) then
    Auditoria.AdicionaCampoAlterado('nome', UAntigo.Nome, UNovo.Nome);

   if (UAntigo.Login <> UNovo.Login) then
    Auditoria.AdicionaCampoAlterado('login', UAntigo.Login, UNovo.Login);

   if (UAntigo.Senha <> UNovo.Senha) then
    Auditoria.AdicionaCampoAlterado('senha', UAntigo.Senha, UNovo.Senha);

   if (UAntigo.CodPerfil <> UNovo.CodPerfil) then
    Auditoria.AdicionaCampoAlterado('cod_perfil', IntToStr(UAntigo.CodPerfil), IntToStr(UNovo.CodPerfil));

   if      (UAntigo.Bloqueado <> UNovo.Bloqueado) and UAntigo.Bloqueado then
    Auditoria.AdicionaCampoAlterado('bloqueado', 'S', 'N')
   else if (UAntigo.Bloqueado <> UNovo.Bloqueado) and (not UAntigo.Bloqueado) then
    Auditoria.AdicionaCampoAlterado('bloqueado', 'N', 'S');

   if (UAntigo.Codigo_departamento <> UNovo.Codigo_departamento) then
    Auditoria.AdicionaCampoAlterado('codigo_departamento', IntToStr(UAntigo.Codigo_departamento), IntToStr(UNovo.Codigo_departamento));
end;

procedure TRepositorioUsuario.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Usuario :TUsuario;
begin
   Usuario := (Objeto as TUsuario);

   Auditoria.AdicionaCampoExcluido('codigo',     IntToStr(Usuario.Codigo));
   Auditoria.AdicionaCampoExcluido('nome',       Usuario.Nome);
   Auditoria.AdicionaCampoExcluido('login',      Usuario.Login);
   Auditoria.AdicionaCampoExcluido('senha',      Usuario.Senha);
   Auditoria.AdicionaCampoExcluido('cod_perfil', IntToStr(Usuario.CodPerfil));

   if Usuario.Bloqueado then Auditoria.AdicionaCampoExcluido('bloqueado',  'S')
   else                      Auditoria.AdicionaCampoExcluido('bloqueado',  'N');
   Auditoria.AdicionaCampoExcluido('codigo_departamento', IntToStr(Usuario.Codigo_departamento));
end;

procedure TRepositorioUsuario.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Usuario :TUsuario;
begin
   Usuario := (Objeto as TUsuario);

   Auditoria.AdicionaCampoIncluido('codigo',     IntToStr(Usuario.Codigo));
   Auditoria.AdicionaCampoIncluido('nome',       Usuario.Nome);
   Auditoria.AdicionaCampoIncluido('login',      Usuario.Login);
   Auditoria.AdicionaCampoIncluido('senha',      Usuario.Senha);
   Auditoria.AdicionaCampoIncluido('cod_perfil', IntToStr(Usuario.CodPerfil));

   if Usuario.Bloqueado then Auditoria.AdicionaCampoIncluido('bloqueado',  'S')
   else                      Auditoria.AdicionaCampoIncluido('bloqueado',  'N');
   Auditoria.AdicionaCampoIncluido('codigo_departamento', IntToStr(Usuario.Codigo_departamento));
end;

procedure TRepositorioUsuario.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TUsuario(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioUsuario.SetParametros(Objeto :TObject);
var
  Usuario :TUsuario;
  nX                          :Integer;
  RepositorioDiretoriosBackup :TRepositorio;
begin
   Usuario := (Objeto as TUsuario);

   if (Usuario.Codigo > 0) then inherited SetParametro('codigo', Usuario.Codigo)
   else                         inherited LimpaParametro('codigo');

   inherited SetParametro('nome',     Usuario.Nome);
   inherited SetParametro('login',    Usuario.Login);
   inherited SetParametro('senha',    Usuario.Senha);
   inherited SetParametro('cod_Perfil', Usuario.CodPerfil);

   if Usuario.Bloqueado then inherited SetParametro('bloqueado', 'S')
   else                      inherited SetParametro('bloqueado', 'N');

   inherited SetParametro('codigo_departamento', Usuario.Codigo_departamento);

   RepositorioDiretoriosBackup := nil;

   if ( Assigned(Usuario.DiretoriosBackup) and (Usuario.DiretoriosBackup.Count > 0)) then begin
       try
         RepositorioDiretoriosBackup := TFabricaRepositorio.GetRepositorio(TDiretorioBackup.ClassName);

         for nX := 0 to (Usuario.DiretoriosBackup.Count-1) do begin
            TDiretorioBackup(Usuario.DiretoriosBackup.Items[nX]).Usuario := Usuario; // Isso aqui colocar no ADD.
            RepositorioDiretoriosBackup.Salvar(Usuario.DiretoriosBackup.Items[nX]);
         end;

       finally
         FreeAndNil(RepositorioDiretoriosBackup);
       end;
   end;       
end;

function TRepositorioUsuario.SQLGet: String;
begin
  result := 'select * from usuarios where codigo = :codigo ';
end;

function TRepositorioUsuario.SQLGetAll: String;
begin
   result := 'select * from usuarios';
end;

function TRepositorioUsuario.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from usuarios where '+ campo +' = :ncampo';
end;

function TRepositorioUsuario.SQLRemover: String;
begin
   result := ' delete from usuarios where codigo = :codigo '; 
end;

function TRepositorioUsuario.SQLSalvar: String;
begin
   result := 'update or insert into usuarios (codigo, nome, login, senha, cod_Perfil, bloqueado, codigo_departamento)'+
             '                        values (:codigo, :nome, :login, :senha, :cod_Perfil, :bloqueado, :codigo_departamento)';
end;

end.
