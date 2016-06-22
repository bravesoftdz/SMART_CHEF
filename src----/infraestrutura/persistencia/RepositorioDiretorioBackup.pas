unit RepositorioDiretorioBackup;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioDiretorioBackup = class(TRepositorio)
  
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
  SysUtils,
  DiretorioBackup;

{ TRepositorioDiretorioBackup }

function TRepositorioDiretorioBackup.Get(Dataset: TDataSet): TObject;
var
  DiretorioBackup :TDiretorioBackup;
begin
   DiretorioBackup                    := TDiretorioBackup.Create;
   DiretorioBackup.Codigo             := self.FQuery.FieldByName('codigo').AsInteger;
   DiretorioBackup.Caminho            := self.FQuery.FieldByName('caminho').AsString;
   DiretorioBackup.CodigoUsuario      := self.FQuery.FieldByName('cod_usuario').AsInteger;

   result := DiretorioBackup;
end;

function TRepositorioDiretorioBackup.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TDiretorioBackup(Objeto).Codigo;
end;

function TRepositorioDiretorioBackup.GetNomeDaTabela: String;
begin
   result := 'DIRETORIOS_BACKUP';
end;

function TRepositorioDiretorioBackup.GetRepositorio: TRepositorio;
begin
   result := TRepositorioDiretorioBackup.Create;
end;

function TRepositorioDiretorioBackup.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TDiretorioBackup(Objeto).Codigo <= 0);
end;

procedure TRepositorioDiretorioBackup.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  DAntigo, DNovo :TDiretorioBackup;
begin
   DAntigo := (AntigoObjeto as TDiretorioBackup);
   DNovo   := (Objeto       as TDiretorioBackup);

   if (DAntigo.Caminho <> DNovo.Caminho) then
    Auditoria.AdicionaCampoAlterado('caminho', DAntigo.Caminho, DNovo.Caminho);

   if (DAntigo.CodigoUsuario <> DNovo.CodigoUsuario) then
    Auditoria.AdicionaCampoAlterado('cod_usuario', IntToStr(DAntigo.CodigoUsuario), IntToStr(DNovo.CodigoUsuario));
end;

procedure TRepositorioDiretorioBackup.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Obj :TDiretorioBackup;
begin
   Obj := (Objeto as TDiretorioBackup);

   Auditoria.AdicionaCampoExcluido('codigo',      IntToStr(Obj.Codigo));
   Auditoria.AdicionaCampoExcluido('caminho',     Obj.Caminho);
   Auditoria.AdicionaCampoExcluido('cod_usuario', IntToStr(Obj.Usuario.Codigo));
end;

procedure TRepositorioDiretorioBackup.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Obj :TDiretorioBackup;
begin
   Obj := (Objeto as TDiretorioBackup);

   Auditoria.AdicionaCampoIncluido('codigo',      IntToStr(Obj.Codigo));
   Auditoria.AdicionaCampoIncluido('caminho',     Obj.Caminho);
   Auditoria.AdicionaCampoIncluido('cod_usuario', IntToStr(Obj.Usuario.Codigo));
end;

procedure TRepositorioDiretorioBackup.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TDiretorioBackup(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioDiretorioBackup.SetParametros(Objeto: TObject);
var
  obj :TDiretorioBackup;
begin
  obj := (Objeto as TDiretorioBackup);

  if (obj.Codigo > 0) then inherited SetParametro('codigo', obj.Codigo)
  else                     inherited LimpaParametro('codigo');

  inherited SetParametro('caminho',     Obj.Caminho);
  inherited SetParametro('cod_usuario', Obj.CodigoUsuario);
end;

function TRepositorioDiretorioBackup.SQLGet: String;
begin
   result := ' select * from diretorios_backup where codigo = :codigo ';
end;

function TRepositorioDiretorioBackup.SQLGetAll: String;
begin
   result := ' select * from diretorios_backup order by codigo ';
end;

function TRepositorioDiretorioBackup.SQLRemover: String;
begin
   result := 'delete from diretorios_backup where codigo = :codigo ';
end;

function TRepositorioDiretorioBackup.SQLSalvar: String;
begin
   result := ' update or insert into diretorios_backup (codigo, caminho, cod_usuario)     '+
             '                                  values (:codigo, :caminho, :cod_usuario)  ';
end;

end.
