unit RepositorioAuditoria;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioAuditoria = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;       override;    

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo:String)  :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

    procedure ExecutaDepoisDeSalvar (Objeto :TObject);                   override;    
end;

implementation

uses
  Auditoria,
  FabricaRepositorio,
  SysUtils,
  CampoAuditoria, CampoAlteracaoAuditoria;

{ TRepositorioAuditoria }

procedure TRepositorioAuditoria.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  Auditoria            :TAuditoria;
  RepositorioInseridos,
  RepositorioAlterados,
  RepositorioExcluidos :TRepositorio;
  nX                   :Integer;
begin
   Auditoria            := (Objeto as TAuditoria);

   try
     RepositorioInseridos := TFabricaRepositorio.GetRepositorio('TCampoIncluidoAuditoria');

     if Assigned(Auditoria.CamposIncluidos) then begin
        for nX := 0 to (Auditoria.CamposIncluidos.Count-1) do begin
           TCampoAuditoria(Auditoria.CamposIncluidos.Items[nX]).Auditoria := Auditoria;
           RepositorioInseridos.Salvar(Auditoria.CamposIncluidos.Items[nX]);
        end;
     end;
   finally
     FreeAndNil(RepositorioInseridos);
   end;

   RepositorioAlterados := TFabricaRepositorio.GetRepositorio('TCampoAlteradoAuditoria');

   try
     if Assigned(Auditoria.CamposAlterados) then begin
        for nX := 0 to (Auditoria.CamposAlterados.Count-1) do begin
           TCampoAlteracaoAuditoria(Auditoria.CamposAlterados.Items[nX]).Auditoria := Auditoria;
           RepositorioAlterados.Salvar(Auditoria.CamposAlterados.Items[nX]);
        end;
     end;
   finally
      FreeAndNil(RepositorioAlterados);
   end;

   RepositorioExcluidos := TFabricaRepositorio.GetRepositorio('TCampoExcluidoAuditoria');

   try
     if Assigned(Auditoria.CamposExcluidos) then begin
        for nX := 0 to (Auditoria.CamposExcluidos.Count-1) do begin
           TCampoAuditoria(Auditoria.CamposExcluidos.Items[nX]).Auditoria := Auditoria;
           RepositorioExcluidos.Salvar(Auditoria.CamposExcluidos.Items[nX]);
        end;
     end;
   finally
      FreeAndNil(RepositorioExcluidos);
   end;
end;

function TRepositorioAuditoria.Get(Dataset: TDataSet): TObject;
var
  Auditoria :TAuditoria;
begin
   Auditoria        := TAuditoria.Create(Dataset.FieldByName('nome_tabela').AsString, Dataset.FieldByName('nome_terminal').AsString);
   Auditoria.Codigo := Dataset.FieldByName('codigo').AsInteger;
   Auditoria.Data   := Dataset.FieldByName('data').AsDateTime;
   Auditoria.Hora   := Dataset.FieldByName('hora').AsDateTime;

   result := Auditoria;
end;

function TRepositorioAuditoria.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TAuditoria(Objeto).Codigo;
end;

function TRepositorioAuditoria.GetNomeDaTabela: String;
begin
   result := 'AUDITORIAS';
end;

function TRepositorioAuditoria.GetRepositorio: TRepositorio;
begin
   result := TRepositorioAuditoria.Create;
end;

function TRepositorioAuditoria.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TAuditoria(Objeto).Codigo <= 0);
end;

procedure TRepositorioAuditoria.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TAuditoria(Objeto).Codigo := Identificador;
end;

procedure TRepositorioAuditoria.SetParametros(Objeto: TObject);
var
  Obj :TAuditoria;
begin
   Obj := (Objeto as TAuditoria);

   inherited SetParametro('codigo',         Obj.Codigo);
   inherited SetParametro('CODIGO_USUARIO', Obj.Usuario.Codigo);
   inherited SetParametro('NOME_TABELA',    Obj.NomeTabela);
   inherited SetParametro('NOME_TERMINAL',  Obj.NomeTerminal);
   inherited SetParametro('data',           Obj.Data);
   inherited SetParametro('hora',           Obj.Hora);
end;

function TRepositorioAuditoria.SQLGet: String;
begin
   result := 'select * from auditorias where codigo = :codigo ';
end;

function TRepositorioAuditoria.SQLGetAll: String;
begin
   result := 'select * from auditorias ';
end;

function TRepositorioAuditoria.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from auditorias where '+ campo +' = :ncampo';
end;

function TRepositorioAuditoria.SQLRemover: String;
begin
   result := 'delete from auditorias where codigo = :codigo ';
end;

function TRepositorioAuditoria.SQLSalvar: String;
begin
   result := ' update or insert into auditorias                                              '+
             ' (codigo, codigo_usuario, nome_tabela, nome_terminal, data, hora)              '+
             ' values (:codigo, :codigo_usuario, :nome_tabela, :nome_terminal, :data, :hora) ';
end;

end.
