unit RepositorioEntradaSaida;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioEntradaSaida = class(TRepositorio)

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
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses SysUtils, EntradaSaida;

{ TRepositorioEntradaSaida }

function TRepositorioEntradaSaida.Get(Dataset: TDataSet): TObject;
var
  EntradaSaida :TEntradaSaida;
begin
   EntradaSaida:= TEntradaSaida.Create;
   EntradaSaida.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   EntradaSaida.num_documento  := self.FQuery.FieldByName('num_documento').AsInteger;
   EntradaSaida.data           := self.FQuery.FieldByName('data').AsDateTime;
   EntradaSaida.entrada_saida  := self.FQuery.FieldByName('entrada_saida').AsString;
   EntradaSaida.tipo           := self.FQuery.FieldByName('tipo').AsString;
   EntradaSaida.observacao     := self.FQuery.FieldByName('observacao').AsString;
   EntradaSaida.codigo_item    := self.FQuery.FieldByName('codigo_item').AsInteger;
   EntradaSaida.quantidade     := self.FQuery.FieldByName('quantidade').AsFloat;
   EntradaSaida.codigo_usuario := self.FQuery.FieldByName('codigo_usuario').AsInteger;
   EntradaSaida.preco_custo    := self.FQuery.FieldByName('preco_custo').AsFloat;

   result := EntradaSaida;
end;

function TRepositorioEntradaSaida.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEntradaSaida(Objeto).Codigo;
end;

function TRepositorioEntradaSaida.GetNomeDaTabela: String;
begin
  result := 'ENTRADA_SAIDA';
end;

function TRepositorioEntradaSaida.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEntradaSaida.Create;
end;

function TRepositorioEntradaSaida.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEntradaSaida(Objeto).Codigo <= 0);
end;

procedure TRepositorioEntradaSaida.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  EntradaSaidaAntigo :TEntradaSaida;
  EntradaSaidaNovo :TEntradaSaida;
begin
   EntradaSaidaAntigo := (AntigoObjeto as TEntradaSaida);
   EntradaSaidaNovo   := (Objeto       as TEntradaSaida);

   if (EntradaSaidaAntigo.num_documento <> EntradaSaidaNovo.num_documento) then
     Auditoria.AdicionaCampoAlterado('num_documento', IntToStr(EntradaSaidaAntigo.num_documento), IntToStr(EntradaSaidaNovo.num_documento));

   if (EntradaSaidaAntigo.data <> EntradaSaidaNovo.data) then
     Auditoria.AdicionaCampoAlterado('data', DateTimeToStr(EntradaSaidaAntigo.data), DateTimeToStr(EntradaSaidaNovo.data));

   if (EntradaSaidaAntigo.entrada_saida <> EntradaSaidaNovo.entrada_saida) then
     Auditoria.AdicionaCampoAlterado('entrada_saida', EntradaSaidaAntigo.entrada_saida, EntradaSaidaNovo.entrada_saida);

   if (EntradaSaidaAntigo.tipo <> EntradaSaidaNovo.tipo) then
     Auditoria.AdicionaCampoAlterado('tipo', EntradaSaidaAntigo.tipo, EntradaSaidaNovo.tipo);

   if (EntradaSaidaAntigo.observacao <> EntradaSaidaNovo.observacao) then
     Auditoria.AdicionaCampoAlterado('observacao', EntradaSaidaAntigo.observacao, EntradaSaidaNovo.observacao);

   if (EntradaSaidaAntigo.codigo_item <> EntradaSaidaNovo.codigo_item) then
     Auditoria.AdicionaCampoAlterado('codigo_item', IntToStr(EntradaSaidaAntigo.codigo_item), IntToStr(EntradaSaidaNovo.codigo_item));

   if (EntradaSaidaAntigo.quantidade <> EntradaSaidaNovo.quantidade) then
     Auditoria.AdicionaCampoAlterado('quantidade', FloatToStr(EntradaSaidaAntigo.quantidade), FloatToStr(EntradaSaidaNovo.quantidade));

   if (EntradaSaidaAntigo.codigo_usuario <> EntradaSaidaNovo.codigo_usuario) then
     Auditoria.AdicionaCampoAlterado('codigo_usuario', IntToStr(EntradaSaidaAntigo.codigo_usuario), IntToStr(EntradaSaidaNovo.codigo_usuario));

   if (EntradaSaidaAntigo.preco_custo <> EntradaSaidaNovo.preco_custo) then
     Auditoria.AdicionaCampoAlterado('preco_custo', FloatToStr(EntradaSaidaAntigo.preco_custo), FloatToStr(EntradaSaidaNovo.preco_custo));
end;

procedure TRepositorioEntradaSaida.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  EntradaSaida :TEntradaSaida;
begin
  EntradaSaida := (Objeto as TEntradaSaida);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(EntradaSaida.codigo));
  Auditoria.AdicionaCampoExcluido('num_documento' , IntToStr(EntradaSaida.num_documento));
  Auditoria.AdicionaCampoExcluido('data'          , DateTimeToStr(EntradaSaida.data));
  Auditoria.AdicionaCampoExcluido('entrada_saida' , EntradaSaida.entrada_saida);
  Auditoria.AdicionaCampoExcluido('tipo'          , EntradaSaida.tipo);
  Auditoria.AdicionaCampoExcluido('observacao'    , EntradaSaida.observacao);
  Auditoria.AdicionaCampoExcluido('codigo_item'   , IntToStr(EntradaSaida.codigo_item));
  Auditoria.AdicionaCampoExcluido('quantidade'    , FloatToStr(EntradaSaida.quantidade));
  Auditoria.AdicionaCampoExcluido('codigo_usuario', IntToStr(EntradaSaida.codigo_usuario));
  Auditoria.AdicionaCampoExcluido('preco_custo'   , FloatToStr(EntradaSaida.preco_custo));
end;

procedure TRepositorioEntradaSaida.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  EntradaSaida :TEntradaSaida;
begin
  EntradaSaida := (Objeto as TEntradaSaida);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(EntradaSaida.codigo));
  Auditoria.AdicionaCampoIncluido('num_documento' ,    IntToStr(EntradaSaida.num_documento));
  Auditoria.AdicionaCampoIncluido('data'          ,    DateTimeToStr(EntradaSaida.data));
  Auditoria.AdicionaCampoIncluido('entrada_saida' ,    EntradaSaida.entrada_saida);
  Auditoria.AdicionaCampoIncluido('tipo'          ,    EntradaSaida.tipo);
  Auditoria.AdicionaCampoIncluido('observacao'    ,    EntradaSaida.observacao);
  Auditoria.AdicionaCampoIncluido('codigo_item'   ,    IntToStr(EntradaSaida.codigo_item));
  Auditoria.AdicionaCampoIncluido('quantidade'    ,    FloatToStr(EntradaSaida.quantidade));
  Auditoria.AdicionaCampoIncluido('codigo_usuario',    IntToStr(EntradaSaida.codigo_usuario));
  Auditoria.AdicionaCampoIncluido('preco_custo'   , FloatToStr(EntradaSaida.preco_custo));
end;

procedure TRepositorioEntradaSaida.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEntradaSaida(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEntradaSaida.SetParametros(Objeto: TObject);
var
  EntradaSaida :TEntradaSaida;
begin
  EntradaSaida := (Objeto as TEntradaSaida);

  self.FQuery.ParamByName('codigo').AsInteger         := EntradaSaida.codigo;
  self.FQuery.ParamByName('num_documento').AsInteger  := EntradaSaida.num_documento;
  self.FQuery.ParamByName('data').AsDateTime           := EntradaSaida.data;
  self.FQuery.ParamByName('entrada_saida').AsString  := EntradaSaida.entrada_saida;
  self.FQuery.ParamByName('tipo').AsString           := EntradaSaida.tipo;
  self.FQuery.ParamByName('observacao').AsString     := EntradaSaida.observacao;
  self.FQuery.ParamByName('codigo_item').AsInteger    := EntradaSaida.codigo_item;
  self.FQuery.ParamByName('quantidade').AsFloat      := EntradaSaida.quantidade;
  self.FQuery.ParamByName('codigo_usuario').AsInteger := EntradaSaida.codigo_usuario;
  self.FQuery.ParamByName('preco_custo').AsFloat      := EntradaSaida.preco_custo;
end;

function TRepositorioEntradaSaida.SQLGet: String;
begin
  result := 'select * from ENTRADA_SAIDA where codigo = :ncod';
end;

function TRepositorioEntradaSaida.SQLGetAll: String;
begin
  result := 'select * from ENTRADA_SAIDA';
end;

function TRepositorioEntradaSaida.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ENTRADA_SAIDA where '+ campo +' = :ncampo';
end;

function TRepositorioEntradaSaida.SQLRemover: String;
begin
  result := ' delete from ENTRADA_SAIDA where codigo = :codigo ';
end;

function TRepositorioEntradaSaida.SQLSalvar: String;
begin
  result := 'update or insert into ENTRADA_SAIDA (  CODIGO ,  NUM_DOCUMENTO ,  DATA ,  ENTRADA_SAIDA ,  TIPO ,  OBSERVACAO ,  CODIGO_ITEM ,  QUANTIDADE ,  CODIGO_USUARIO,  preco_custo) '+
           '                              values ( :CODIGO , :NUM_DOCUMENTO , :DATA , :ENTRADA_SAIDA , :TIPO , :OBSERVACAO , :CODIGO_ITEM , :QUANTIDADE , :CODIGO_USUARIO, :preco_custo) ';
end;

end.

