unit RepositorioMovimento;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioMovimento = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;     
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

uses SysUtils, Movimento, Funcoes;

{ TRepositorioMovimento }

function TRepositorioMovimento.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FCondicao+''; 
end;

function TRepositorioMovimento.Get(Dataset: TDataSet): TObject;
var
  Movimento :TMovimento;
begin
   Movimento:= TMovimento.Create;
   Movimento.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   Movimento.codigo_caixa  := self.FQuery.FieldByName('codigo_caixa').AsInteger;
   Movimento.tipo_moeda    := self.FQuery.FieldByName('tipo_moeda').AsInteger;
   Movimento.codigo_pedido := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   Movimento.data          := self.FQuery.FieldByName('data').AsDateTime;
   Movimento.valor_pago    := self.FQuery.FieldByName('valor_pago').AsFloat;

   result := Movimento;
end;

function TRepositorioMovimento.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TMovimento(Objeto).Codigo;
end;

function TRepositorioMovimento.GetNomeDaTabela: String;
begin
  result := 'MOVIMENTOS';
end;

function TRepositorioMovimento.GetRepositorio: TRepositorio;
begin
  result := TRepositorioMovimento.Create;
end;

function TRepositorioMovimento.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TMovimento(Objeto).Codigo <= 0);
end;

procedure TRepositorioMovimento.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  MovimentoAntigo :TMovimento;
  MovimentoNovo :TMovimento;
begin
   MovimentoAntigo := (AntigoObjeto as TMovimento);
   MovimentoNovo   := (Objeto       as TMovimento);

   if (MovimentoAntigo.codigo_caixa <> MovimentoNovo.codigo_caixa) then
     Auditoria.AdicionaCampoAlterado('codigo_caixa', IntToStr(MovimentoAntigo.codigo_caixa), IntToStr(MovimentoNovo.codigo_caixa));

   if (MovimentoAntigo.tipo_moeda <> MovimentoNovo.tipo_moeda) then
     Auditoria.AdicionaCampoAlterado('tipo_moeda', IntToStr(MovimentoAntigo.tipo_moeda), IntToStr(MovimentoNovo.tipo_moeda));

   if (MovimentoAntigo.codigo_pedido <> MovimentoNovo.codigo_pedido) then
     Auditoria.AdicionaCampoAlterado('codigo_pedido', IntToStr(MovimentoAntigo.codigo_pedido), IntToStr(MovimentoNovo.codigo_pedido));

   if (MovimentoAntigo.data <> MovimentoNovo.data) then
     Auditoria.AdicionaCampoAlterado('data', DateTimeToStr(MovimentoAntigo.data), DateTimeToStr(MovimentoNovo.data));

   if (MovimentoAntigo.valor_pago <> MovimentoNovo.valor_pago) then
     Auditoria.AdicionaCampoAlterado('valor_pago', FloatToStr(MovimentoAntigo.valor_pago), FloatToStr(MovimentoNovo.valor_pago));
end;

procedure TRepositorioMovimento.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Movimento :TMovimento;
begin
  Movimento := (Objeto as TMovimento);
  Auditoria.AdicionaCampoExcluido('codigo'       , IntToStr(Movimento.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_caixa' , IntToStr(Movimento.codigo_caixa));
  Auditoria.AdicionaCampoExcluido('tipo_moeda'   , IntToStr(Movimento.tipo_moeda));
  Auditoria.AdicionaCampoExcluido('codigo_pedido', IntToStr(Movimento.codigo_pedido));
  Auditoria.AdicionaCampoExcluido('data'         , DateTimeToStr(Movimento.data));
  Auditoria.AdicionaCampoExcluido('valor_pago'   , FloatToStr(Movimento.valor_pago));
end;

procedure TRepositorioMovimento.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Movimento :TMovimento;
begin
  Movimento := (Objeto as TMovimento);
  Auditoria.AdicionaCampoIncluido('codigo'       ,    IntToStr(Movimento.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_caixa' ,    IntToStr(Movimento.codigo_caixa));
  Auditoria.AdicionaCampoIncluido('tipo_moeda'   ,    IntToStr(Movimento.tipo_moeda));
  Auditoria.AdicionaCampoIncluido('codigo_pedido',    IntToStr(Movimento.codigo_pedido));
  Auditoria.AdicionaCampoIncluido('data'         ,    DateTimeToStr(Movimento.data));
  Auditoria.AdicionaCampoIncluido('valor_pago'   , FloatToStr(Movimento.valor_pago));
end;

procedure TRepositorioMovimento.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TMovimento(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioMovimento.SetParametros(Objeto: TObject);
var
  Movimento :TMovimento;
begin
  Movimento := (Objeto as TMovimento);

  self.FQuery.ParamByName('codigo').AsInteger        := Movimento.codigo;
  self.FQuery.ParamByName('codigo_caixa').AsInteger  := StrToInt(Maior_Valor_Cadastrado('CAIXA','CODIGO'));
  self.FQuery.ParamByName('tipo_moeda').AsInteger    := Movimento.tipo_moeda;
  self.FQuery.ParamByName('codigo_pedido').AsInteger := Movimento.codigo_pedido;
  self.FQuery.ParamByName('data').AsDateTime         := Movimento.data;
  self.FQuery.ParamByName('valor_pago').AsFloat      := Movimento.valor_pago;
end;

function TRepositorioMovimento.SQLGet: String;
begin
  result := 'select * from MOVIMENTOS where codigo = :ncod';
end;

function TRepositorioMovimento.SQLGetAll: String;
begin
  result := 'select * from MOVIMENTOS';
end;

function TRepositorioMovimento.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from MOVIMENTOS where '+ campo +' = :ncampo';
end;

function TRepositorioMovimento.SQLRemover: String;
begin
  result := ' delete from MOVIMENTOS where codigo = :codigo ';
end;

function TRepositorioMovimento.SQLSalvar: String;
begin
  result := 'update or insert into MOVIMENTOS (CODIGO ,CODIGO_CAIXA ,TIPO_MOEDA ,CODIGO_PEDIDO ,DATA, VALOR_PAGO) '+
           '                      values ( :CODIGO , :CODIGO_CAIXA , :TIPO_MOEDA , :CODIGO_PEDIDO , :DATA, :VALOR_PAGO) ';
end;

end.

