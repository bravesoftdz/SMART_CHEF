unit Repositorio;

interface

uses
  DB,
  ZDataset,
  uModulo,
  Variants,
  Contnrs,
  Auditoria,
  Especificacao,
  Classes,
  EventoExecutarOperacao, Dialogs, Forms;

type TTipoAuditoria = (taInclusao, taAlteracao, taExclusao);

type
  TRepositorio = class

  private
    procedure GravaAuditoria          (AntigoObjeto, Objeto :TObject; TipoAuditoria :TTipoAuditoria);

  protected
    FQuery         :TZQuery;
    FDM            :TDM;
    FAtualizarTela :TEventoExecutarOperacao;

  protected
    function Get(Dataset :TDataSet)               :TObject; overload; virtual;
    function GetNomeDaTabela                      :String;            virtual;
    function GetIdentificador(Objeto :TObject)    :Variant;           virtual;
    function GetChaveParaRemocao(Objeto :TObject) :Variant;           virtual;
    function GetRepositorio                       :TRepositorio;      virtual;

  //==============================================================================
  // Métodos que retornam SQL.
  //==============================================================================
  protected
    FCondicao :String;

    function SQLGet                            :String;            virtual;
    function CondicaoSQLGetAll                 :String;            virtual;
    function SQLGetAll                         :String;            virtual;
    function SQLGetExiste(campo:String)        :String;            virtual;
    function SQLSalvar                         :String;            virtual;
    function SQLRemover                        :String;            virtual;

    function IsInsercao(Objeto :TObject)       :Boolean;           virtual;
    function IsComponente()                    :Boolean;           virtual;
    function IsColecao()                       :Boolean;           virtual; 

  protected
    procedure SetParametros   (Objeto          :TObject                        ); virtual;
    procedure SetParametro    (NomeDoParametro :String;  Valor         :Variant);
    procedure SetParametroBlob(NomeDoParametro :String;  Stream :TMemoryStream);
    procedure SetIdentificador(Objeto          :TObject; Identificador :Variant); virtual;

  protected
    procedure LimpaParametro        (NomeDoParametro           :String);
    procedure ExecutaDepoisDeSalvar (Objeto :TObject);                            virtual;

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); virtual;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); virtual;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); virtual;

  public
    constructor Create;
    destructor  Destroy; override;

  public
   //==============================================================================
   // Métodos de recuperação de dados 
   //==============================================================================
    function Get                     (const Identificador :Variant; const campo :String = '')           :TObject; overload;
    function GetListaPorIdentificador(const Identificador :Variant)                                     :TObjectList;
    function GetAll                                                                                     :TObjectList;
    function GetExiste               (const campo         :String;        const Identificador :Variant) :Boolean;
    function GetPorEspecificacao     (Especificacao       :TEspecificacao; const condicao :String = '') :TObject;
    function GetListaPorEspecificacao(Especificacao       :TEspecificacao; const condicao :String = '') :TObjectList;

    //==============================================================================
    // Métodos de controle de transação.
    //==============================================================================
    procedure HabilitaAutoCommit;
    procedure DesabilitaAutoCommit;
    procedure ExecutaRollbackNaTransacao;
    procedure ExecutaCommitNaTransacao;

    //==============================================================================
    // Métodos de persistência no banco dados.
    //==============================================================================
    function Salvar (Objeto              :TObject) :Boolean; virtual;
    function Salvar_2(Objeto              :TObject) :Boolean; virtual;
    function Remover(Objeto              :TObject) :Boolean; virtual;
    function RemoverPorIdentificador(const Identificador :Variant) :Boolean;

    //==============================================================================
    // Evento para atualizar a tela
    //==============================================================================
    procedure AdicionarEventoDeAtualizarTela(AtualizarTela :TEventoExecutarOperacao);

   public
     class function HorarioBancoDeDados :TDateTime;
end;

implementation

uses
  SysUtils,
  ExcecaoMetodoNaoImplementado,
  FabricaRepositorio;

{ TRepositorio }

constructor TRepositorio.Create;
begin
   self.FQuery      := dm.GetConsulta;
   FDM := DM;
end;

function TRepositorio.Get(Dataset :TDataset): TObject;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'Get(Dataset :TDataset)');
end;

destructor TRepositorio.Destroy;
begin
  FreeAndNil(self.FQuery);

  inherited;
end;

function TRepositorio.Get(const Identificador :Variant; const campo :String): TObject;
begin
   try
     result := nil;

     if (self.FQuery.Connection.AutoCommit) and (self.FQuery.Connection.InTransaction) then
       self.FQuery.Connection.Commit;

     self.FQuery.SQL.Clear;

     if campo = '' then begin
       self.FQuery.SQL.Add(self.SQLGet);
       self.FQuery.Params[0].Value := Identificador;
     end
     else begin
       self.FQuery.SQL.Add(self.SQLGetExiste(campo));
       self.FQuery.ParamByName(campo).Value := Identificador;
     end;

     self.FQuery.Open;

     if not self.FQuery.IsEmpty then
       result := self.Get(self.FQuery);
   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      raise Exception.Create(E.Message);
     end;
   end;
end;

function TRepositorio.SQLGet: String;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SQLGet: String;');
end;


{-------------------------------------------------------------------------------
  Método:     TRepositorio.Salvar
  Autor:      Ricardo Medeiros
  Descrição:  Método que recebe um objeto e o persiste de acordo com os parâmetros setados na sub-classe.
  Data:       2013.07.16
  Parâmetros: Objeto :TObject;
  Retorno:    Boolean
-------------------------------------------------------------------------------}
function TRepositorio.Salvar(Objeto: TObject): Boolean;
var
  ObjetoAntigo :TObject;
  Repositorio  :TRepositorio;
begin
   Result := true;
   Repositorio  := self.GetRepositorio;
   ObjetoAntigo := nil;

   try
     try
       self.FQuery.SQL.Clear;
       self.FQuery.SQL.Add(self.SQLSalvar);

       self.SetParametros(Objeto);

       if not self.IsInsercao(Objeto) then
        ObjetoAntigo := Repositorio.Get(self.GetIdentificador(Objeto));

       self.FQuery.ExecSQL;

       if self.IsInsercao(Objeto) then begin
          if not self.IsComponente then
            self.SetIdentificador(Objeto, dm.GetValorGenerator('GEN_'+self.GetNomeDaTabela+'_ID','0'));

          self.GravaAuditoria(nil, Objeto, taInclusao);
       end
       else
          self.GravaAuditoria(ObjetoAntigo, Objeto, taAlteracao);

       self.ExecutaDepoisDeSalvar(Objeto);
     finally
       FreeAndNil(Repositorio);
       FreeAndNil(ObjetoAntigo);
     end;

   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      Result := false;
      raise Exception.create('Erro ao salvar.'+#13#10+'Para mais informações consulte o log de erros.');
     end;
   end;
end;

function TRepositorio.Salvar_2(Objeto: TObject): Boolean;
var
  ObjetoAntigo :TObject;
  Repositorio  :TRepositorio;
begin
   Result := true;
   Repositorio  := self.GetRepositorio;
   ObjetoAntigo := nil;

   try
     try
       dm.ZConnection1.AutoCommit := true;
       self.FQuery.Connection     := dm.ZConnection1;
       self.FQuery.SQL.Clear;
       self.FQuery.SQL.Add(self.SQLSalvar);
       
       self.SetParametros(Objeto);

       if not self.IsInsercao(Objeto) then
        ObjetoAntigo := Repositorio.Get(self.GetIdentificador(Objeto));

       self.FQuery.ExecSQL;

       if self.IsInsercao(Objeto) then begin
          if not self.IsComponente then
            self.SetIdentificador(Objeto, dm.GetValorGenerator('GEN_'+self.GetNomeDaTabela+'_ID','0'));

          self.GravaAuditoria(nil, Objeto, taInclusao);
       end
       else
          self.GravaAuditoria(ObjetoAntigo, Objeto, taAlteracao);

       self.ExecutaDepoisDeSalvar(Objeto);
     finally
       FreeAndNil(Repositorio);
       FreeAndNil(ObjetoAntigo);
       dm.ZConnection1.AutoCommit := false;
       self.FQuery.Connection     := dm.conexao;
     end;

   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      Result := false;
      raise Exception.create('Erro ao salvar.'+#13#10+'Para mais informações consulte o log de erros.');
     end;
   end;
end;

function TRepositorio.SQLSalvar: String;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SQLSalvar: String;');
end;

procedure TRepositorio.SetParametros(Objeto :TObject);
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SetParametros;');
end;

procedure TRepositorio.SetParametro(NomeDoParametro: String;
  Valor: Variant);
begin
   self.FQuery.ParamByName(NomeDoParametro).Value := Valor;
end;

procedure TRepositorio.LimpaParametro(NomeDoParametro: String);
begin
   self.FQuery.ParamByName(NomeDoParametro).Clear;
end;

function TRepositorio.GetAll: TObjectList;
var
  obj :TObject;
begin
   try
     result := nil;

     self.FQuery.SQL.Clear;
     self.FQuery.SQL.Add(self.SQLGetAll);
     self.FQuery.Open;

     if self.FQuery.IsEmpty then exit;

     result := TObjectList.Create;

     while not self.FQuery.Eof do begin
        obj := self.Get(self.FQuery);

        if Assigned(obj) then result.Add(obj);
        self.FQuery.Next;
     end;

   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      raise Exception.Create(E.Message);
     end;
   end;
end;

function TRepositorio.SQLGetAll: String;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SQLGetAll: String;');
end;

function TRepositorio.GetExiste(const campo :String; const Identificador :Variant): Boolean;
begin
  try
     result := false;

     self.FQuery.SQL.Clear;
     self.FQuery.SQL.Add(self.SQLGetExiste(campo));
     self.FQuery.Params[0].Value := Identificador;
     self.FQuery.Open;

     if not self.FQuery.IsEmpty then
       Result:= true;

   except
     on E: Exception do begin
       dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
        raise Exception.Create(E.Message);
     end;
  end;
end;

function TRepositorio.SQLGetExiste(campo:String): String;
begin
     raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SQLGetExiste: String;');
end;


{-------------------------------------------------------------------------------
  Método:     TRepositorio.GetPorEspecificacao
  Autor:      Ricardo Medeiros
  Descrição:  Método que recebe uma especificação de consulta. Ao encontrar o primeiro objeto que atende a especificação, o mesmo é retornado e a função é finalizada.
  Data:       2013.07.16
  Parâmetros: Especificacao: TEspecificacao
  Retorno:    TObject
-------------------------------------------------------------------------------}
function TRepositorio.GetPorEspecificacao(
  Especificacao: TEspecificacao; const condicao :String): TObject;
begin
   try
     result := nil;

     self.FQuery.SQL.Clear;
     FCondicao := condicao;
     self.FQuery.SQL.Add(self.SQLGetAll);
     self.FQuery.Open;

     if self.FQuery.IsEmpty then exit;

     while not self.FQuery.Eof do begin
        result := self.Get(self.FQuery);

        // Se o objeto não é nulo e atende a especificação então é retornado
        if Assigned(result) and Especificacao.SatisfeitoPor(result) then
          exit;

        self.FQuery.Next;
        FreeAndNil(result);
     end;

     result := nil; // se não sair no while, não encontrou

   except
     on E: Exception do begin
        dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
        raise Exception.Create(E.Message);
     end;
   end;
end;


{-------------------------------------------------------------------------------
  Método:     TRepositorio.GetListaPorEspecificacao
  Autor:      Ricardo Medeiros
  Descrição:  Método que recebe uma especificação de consulta. Ao encontrar o primeiro objeto que atende a especificação, o mesmo é adicionado na lista de retorno.
  Data:       2013.07.16
  Parâmetros: Especificacao: TEspecificacao
  Retorno:    TList
-------------------------------------------------------------------------------}
function TRepositorio.GetListaPorEspecificacao(
  Especificacao: TEspecificacao; const condicao :String): TObjectList;
var
  obj :TObject;
begin
   try
     result := nil;

     self.FQuery.SQL.Clear;
     FCondicao := condicao;
     self.FQuery.SQL.Add(self.SQLGetAll);
     self.FQuery.Open;

     if self.FQuery.IsEmpty then exit;

     result := TObjectList.Create(true);

     while not self.FQuery.Eof do begin
        obj := self.Get(self.FQuery);

        //Sleep(1);
        Application.ProcessMessages;
        { Se o objeto não é nulo e atende a especificação então ele é adicionado na lista
          para ser retornado.                                                           }
        if Assigned(obj) and Especificacao.SatisfeitoPor(obj) then
          result.Add(obj)
        else
          FreeAndNil(obj);

        self.FQuery.Next;
     end;

   except
     on E: Exception do begin
        dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
        raise Exception.Create(E.Message);
     end;
   end;
end;

function TRepositorio.GetNomeDaTabela: String;
begin
    raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'GetNomeDaTabela: String;');
end;

procedure TRepositorio.SetIdentificador(Objeto :TObject; Identificador :Variant);
begin
    raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SetIdentificador(Identificador: Variant);');
end;

function TRepositorio.IsInsercao(Objeto: TObject): Boolean;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'IsInsercao(Objeto: TObject): Boolean;');
end;

function TRepositorio.Remover(Objeto: TObject): Boolean;
begin
   try
     self.FQuery.SQL.Clear;
     self.FQuery.SQL.Add(self.SQLRemover);

     if not self.IsColecao then
       self.FQuery.Params[0].Value := self.GetIdentificador(Objeto)
     else
       self.FQuery.Params[0].Value := self.GetChaveParaRemocao(Objeto);

     self.FQuery.ExecSQL;

     self.GravaAuditoria(nil, Objeto, taExclusao);
   except
     on E: Exception do
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
   end;
end;

function TRepositorio.GetIdentificador(Objeto: TObject): Variant;
begin
    raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'GetIdentificador(Objeto: TObject): Variant');
end;

function TRepositorio.SQLRemover: String;
begin
     raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SQLRemover: String;');
end;

procedure TRepositorio.ExecutaDepoisDeSalvar;
begin
   {}
end;

procedure TRepositorio.GravaAuditoria(AntigoObjeto, Objeto: TObject; TipoAuditoria :TTipoAuditoria);
var
  Repositorio     :TRepositorio;
  Auditoria       :TAuditoria;
begin
   Auditoria       := nil;
   Repositorio     := nil;

   try
       Auditoria                 := TAuditoria.Create(dm.UsuarioLogado, self.GetNomeDaTabela, dm.NomeDoTerminal);

       if      (TipoAuditoria = taInclusao)  then self.SetCamposIncluidos(Auditoria, Objeto)
       else if (TipoAuditoria = taAlteracao) then self.SetCamposAlterados(Auditoria, AntigoObjeto, Objeto)
       else if (TipoAuditoria = taExclusao)  then self.SetCamposExcluidos(Auditoria, Objeto);

       if not Auditoria.TemCamposParaPersistir then exit;

       Repositorio := TFabricaRepositorio.GetRepositorio(TAuditoria.ClassName);
       Repositorio.Salvar(Auditoria);

   finally
     FreeAndNil(Auditoria);
     FreeAndNil(Repositorio);
   end;
end;

procedure TRepositorio.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
begin
  { Método a ser implementado nas sub-classes }
end;

procedure TRepositorio.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
begin
  { Método a ser implementado nas sub-classes }
end;

procedure TRepositorio.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
begin
   { Método a ser implementado nas sub-classes }
end;

function TRepositorio.GetRepositorio: TRepositorio;
begin
    raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'GetRepositorio: TRepositorio;');
end;

class function TRepositorio.HorarioBancoDeDados: TDateTime;
var
  Query :TZQuery;
begin
   Query  := nil;
   result := 0;

   try
     try
       Query := dm.GetConsulta('select current_time HORA_ATUAL from rdb$database');
       Query.Open;

       if not Query.IsEmpty then
         result := Query.Fields[0].AsDateTime;
     finally
       Query.Close;
       FreeAndNil(Query);
     end;
   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      raise Exception.Create(E.Message);
     end;
   end;
end;

procedure TRepositorio.DesabilitaAutoCommit;
begin
  self.FQuery.Connection.AutoCommit := false;
end;

procedure TRepositorio.HabilitaAutoCommit;
begin
  self.FQuery.Connection.AutoCommit := true;
end;

procedure TRepositorio.ExecutaCommitNaTransacao;
begin
  self.FQuery.Connection.Commit;
end;

procedure TRepositorio.ExecutaRollbackNaTransacao;
begin
  self.FQuery.Connection.Rollback;
end;

function TRepositorio.GetListaPorIdentificador(
  const Identificador: Variant): TObjectList;
var
  obj :TObject;
begin
   try
     result := nil;

     self.FQuery.SQL.Clear;
     self.FQuery.SQL.Add(self.SQLGet);
     self.FQuery.Params[0].Value := Identificador;
     self.FQuery.Open;

     if self.FQuery.IsEmpty then exit;

     result := TObjectList.Create;

     while not self.FQuery.Eof do begin
        obj := self.Get(self.FQuery);

        if Assigned(obj) then result.Add(obj);
        self.FQuery.Next;
     end;

   except
     on E: Exception do begin
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
      raise Exception.Create(E.Message);
     end;
   end;
end;

function TRepositorio.IsComponente: Boolean;
begin
   result := false;
end;

function TRepositorio.GetChaveParaRemocao(Objeto: TObject): Variant;
begin
    raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'GetChaveParaRemocao(Objeto: TObject): Variant');
end;

function TRepositorio.IsColecao: Boolean;
begin
   result := false;
end;

procedure TRepositorio.SetParametroBlob(NomeDoParametro: String;
  Stream: TMemoryStream);
begin
   self.FQuery.ParamByName(NomeDoParametro).LoadFromStream(Stream, ftBlob);
end;

procedure TRepositorio.AdicionarEventoDeAtualizarTela(
  AtualizarTela: TEventoExecutarOperacao);
begin
   self.FAtualizarTela := AtualizarTela;
end;

function TRepositorio.RemoverPorIdentificador(
  const Identificador: Variant): Boolean;
begin
   try
     self.FQuery.SQL.Clear;
     self.FQuery.SQL.Add(self.SQLRemover);

     self.FQuery.Params[0].Value := Identificador;
     self.FQuery.ExecSQL;

    // self.GravaAuditoria(nil, Objeto, taExclusao);
   except
     on E: Exception do
      dm.LogErros.AdicionaErro('Repositorio', E.ClassName, E.Message);
   end;
end;

function TRepositorio.CondicaoSQLGetAll: String;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'CondicaoSQLGetAll: String;');
end;

end.
