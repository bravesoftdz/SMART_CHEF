unit RepositorioManutencaoSistema;

interface

uses
  DB,
  Repositorio,
  Auditoria;

type
  TRepositorioManutencaoSistema = class(TRepositorio)

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
  ManutencaoSistema,
  SysUtils;

{ TRepositorioManutencaoSistema }

function TRepositorioManutencaoSistema.Get(Dataset: TDataSet): TObject;
var
  Manutencao :TManutencaoSistema;
begin
   Manutencao                          := TManutencaoSistema.Create;
   Manutencao.Codigo                   := self.FQuery.FieldByName('codigo').AsInteger;
   Manutencao.CodigoUsuarioResponsavel := self.FQuery.FieldByName('cod_usuario_responsavel').AsInteger;
   Manutencao.HorarioInicio            := self.FQuery.FieldByName('horario_inicio').AsDateTime;
   Manutencao.HorarioTermino           := self.FQuery.FieldByName('horario_termino').AsDateTime;
   Manutencao.TerminalResponsavel      := self.FQuery.FieldByName('terminal_responsavel').AsString;

   result := Manutencao;
end;

function TRepositorioManutencaoSistema.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TManutencaoSistema(Objeto).Codigo;
end;

function TRepositorioManutencaoSistema.GetNomeDaTabela: String;
begin
   result := 'MANUTENCAO_SISTEMA';
end;

function TRepositorioManutencaoSistema.GetRepositorio: TRepositorio;
begin
   result := TRepositorioManutencaoSistema.Create;
end;

function TRepositorioManutencaoSistema.IsInsercao(
  Objeto: TObject): Boolean;
begin
   result := (TManutencaoSistema(Objeto).Codigo <= 0);
end;

procedure TRepositorioManutencaoSistema.SetCamposAlterados(
  Auditoria: TAuditoria; AntigoObjeto, Objeto: TObject);
begin
   { Não há alteração pra esses dados. Apenas inclusão e remoção }
end;

procedure TRepositorioManutencaoSistema.SetCamposExcluidos(
  Auditoria: TAuditoria; Objeto: TObject);
var
  Manutencao :TManutencaoSistema;
begin
   Manutencao := (Objeto as TManutencaoSistema);

   Auditoria.AdicionaCampoExcluido('codigo',                  IntToStr(Manutencao.Codigo));
   Auditoria.AdicionaCampoExcluido('cod_usuario_responsavel', IntToStr(Manutencao.CodigoUsuarioResponsavel));
   Auditoria.AdicionaCampoExcluido('horario_inicio',          FormatDateTime('hh:mm:ss', Manutencao.HorarioInicio));
   Auditoria.AdicionaCampoExcluido('horario_termino',         FormatDateTime('hh:mm:ss', Manutencao.HorarioTermino));
   Auditoria.AdicionaCampoExcluido('terminal_responsavel',    Manutencao.TerminalResponsavel);
end;

procedure TRepositorioManutencaoSistema.SetCamposIncluidos(
  Auditoria: TAuditoria; Objeto: TObject);
var
  Manutencao :TManutencaoSistema;
begin
   Manutencao := (Objeto as TManutencaoSistema);

   Auditoria.AdicionaCampoIncluido('codigo',                  IntToStr(Manutencao.Codigo));
   Auditoria.AdicionaCampoIncluido('cod_usuario_responsavel', IntToStr(Manutencao.CodigoUsuarioResponsavel));
   Auditoria.AdicionaCampoIncluido('horario_inicio',          FormatDateTime('hh:mm:ss', Manutencao.HorarioInicio));
   Auditoria.AdicionaCampoIncluido('horario_termino',         FormatDateTime('hh:mm:ss', Manutencao.HorarioTermino));
   Auditoria.AdicionaCampoIncluido('terminal_responsavel',    Manutencao.TerminalResponsavel);
end;

procedure TRepositorioManutencaoSistema.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TManutencaoSistema(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioManutencaoSistema.SetParametros(Objeto: TObject);
var
  Manutencao :TManutencaoSistema;
begin
   Manutencao := (Objeto as TManutencaoSistema);

   if (Manutencao.Codigo > 0) then inherited SetParametro('codigo', Manutencao.Codigo)
   else                            inherited LimpaParametro('codigo');

   inherited SetParametro('COD_USUARIO_RESPONSAVEL', Manutencao.CodigoUsuarioResponsavel);
   inherited SetParametro('HORARIO_INICIO',          Manutencao.HorarioInicio);
   inherited SetParametro('HORARIO_TERMINO',         Manutencao.HorarioTermino);
   inherited SetParametro('terminal_responsavel',    Manutencao.TerminalResponsavel);
end;

function TRepositorioManutencaoSistema.SQLGet: String;
begin
   result := 'select first 1 * from manutencao_sistema where (codigo >= 0) and (:migue = 0)'; 
end;

function TRepositorioManutencaoSistema.SQLGetAll: String;
begin
   result := 'select * from manutencao_sistema ';
end;

function TRepositorioManutencaoSistema.SQLGetExiste(campo: String): String;
begin
   result := 'select '+ campo +' from '+ self.GetNomeDaTabela+' where '+ campo +' = :ncampo';
end;

function TRepositorioManutencaoSistema.SQLRemover: String;
begin
   result := 'delete from manutencao_sistema where (codigo >= 0) and (:migue >= 0)';
end;

function TRepositorioManutencaoSistema.SQLSalvar: String;
begin
   result := ' update or insert into manutencao_sistema '+
             ' ( codigo, cod_usuario_responsavel, horario_inicio, horario_termino, terminal_responsavel )'+
             ' values '+
             ' ( :codigo, :cod_usuario_responsavel, :horario_inicio, :horario_termino, :terminal_responsavel ) ';
end;

end.
