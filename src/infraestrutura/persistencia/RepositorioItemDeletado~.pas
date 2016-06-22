unit RepositorioItemDeletado;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioItemDeletado = class(TRepositorio)

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

uses SysUtils, ItemDeletado;

{ TRepositorioItemDeletado }

function TRepositorioItemDeletado.Get(Dataset: TDataSet): TObject;
var
  ItemDeletado :TItemDeletado;
begin
   ItemDeletado:= TItemDeletado.Create;
   ItemDeletado.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   ItemDeletado.codigo_pedido  := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   ItemDeletado.codigo_usuario := self.FQuery.FieldByName('codigo_usuario').AsInteger;
   ItemDeletado.codigo_produto := self.FQuery.FieldByName('codigo_produto').AsInteger;
   ItemDeletado.quantidade     := self.FQuery.FieldByName('quantidade').AsFloat;
   ItemDeletado.hora_exclusao  := self.FQuery.FieldByName('hora_exclusao').AsDateTime;
   ItemDeletado.justificativa  := self.FQuery.FieldByName('justificativa').AsString;

   result := ItemDeletado;
end;

function TRepositorioItemDeletado.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TItemDeletado(Objeto).Codigo;
end;

function TRepositorioItemDeletado.GetNomeDaTabela: String;
begin
  result := 'ITENS_DELETADOS';
end;

function TRepositorioItemDeletado.GetRepositorio: TRepositorio;
begin
  result := TRepositorioItemDeletado.Create;
end;

function TRepositorioItemDeletado.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TItemDeletado(Objeto).Codigo <= 0);
end;

procedure TRepositorioItemDeletado.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ItemDeletadoAntigo :TItemDeletado;
  ItemDeletadoNovo :TItemDeletado;
begin
   ItemDeletadoAntigo := (AntigoObjeto as TItemDeletado);
   ItemDeletadoNovo   := (Objeto       as TItemDeletado);

   if (ItemDeletadoAntigo.codigo_pedido <> ItemDeletadoNovo.codigo_pedido) then
     Auditoria.AdicionaCampoAlterado('codigo_pedido', IntToStr(ItemDeletadoAntigo.codigo_pedido), IntToStr(ItemDeletadoNovo.codigo_pedido));

   if (ItemDeletadoAntigo.codigo_usuario <> ItemDeletadoNovo.codigo_usuario) then
     Auditoria.AdicionaCampoAlterado('codigo_usuario', IntToStr(ItemDeletadoAntigo.codigo_usuario), IntToStr(ItemDeletadoNovo.codigo_usuario));

   if (ItemDeletadoAntigo.codigo_produto <> ItemDeletadoNovo.codigo_produto) then
     Auditoria.AdicionaCampoAlterado('codigo_produto', IntToStr(ItemDeletadoAntigo.codigo_produto), IntToStr(ItemDeletadoNovo.codigo_produto));

   if (ItemDeletadoAntigo.quantidade <> ItemDeletadoNovo.quantidade) then
     Auditoria.AdicionaCampoAlterado('quantidade', FloatToStr(ItemDeletadoAntigo.quantidade), FloatToStr(ItemDeletadoNovo.quantidade));

   if (ItemDeletadoAntigo.hora_exclusao <> ItemDeletadoNovo.hora_exclusao) then
     Auditoria.AdicionaCampoAlterado('hora_exclusao', DateTimeToStr(ItemDeletadoAntigo.hora_exclusao), DateTimeToStr(ItemDeletadoNovo.hora_exclusao));

   if (ItemDeletadoAntigo.justificativa <> ItemDeletadoNovo.justificativa) then
     Auditoria.AdicionaCampoAlterado('justificativa', ItemDeletadoAntigo.justificativa, ItemDeletadoNovo.justificativa);

end;

procedure TRepositorioItemDeletado.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ItemDeletado :TItemDeletado;
begin
  ItemDeletado := (Objeto as TItemDeletado);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(ItemDeletado.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_pedido' , IntToStr(ItemDeletado.codigo_pedido));
  Auditoria.AdicionaCampoExcluido('codigo_usuario', IntToStr(ItemDeletado.codigo_usuario));
  Auditoria.AdicionaCampoExcluido('codigo_produto', IntToStr(ItemDeletado.codigo_produto));
  Auditoria.AdicionaCampoExcluido('quantidade'    , FloatToStr(ItemDeletado.quantidade));
  Auditoria.AdicionaCampoExcluido('hora_exclusao' , DateTimeToStr(ItemDeletado.hora_exclusao));
  Auditoria.AdicionaCampoExcluido('justificativa' , ItemDeletado.justificativa);
end;

procedure TRepositorioItemDeletado.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ItemDeletado :TItemDeletado;
begin
  ItemDeletado := (Objeto as TItemDeletado);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(ItemDeletado.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_pedido' ,    IntToStr(ItemDeletado.codigo_pedido));
  Auditoria.AdicionaCampoIncluido('codigo_usuario',    IntToStr(ItemDeletado.codigo_usuario));
  Auditoria.AdicionaCampoExcluido('codigo_produto', IntToStr(ItemDeletado.codigo_produto));
  Auditoria.AdicionaCampoExcluido('quantidade'    , FloatToStr(ItemDeletado.quantidade));
  Auditoria.AdicionaCampoIncluido('hora_exclusao' ,    DateTimeToStr(ItemDeletado.hora_exclusao));
  Auditoria.AdicionaCampoIncluido('justificativa' ,    ItemDeletado.justificativa);
end;

procedure TRepositorioItemDeletado.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TItemDeletado(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioItemDeletado.SetParametros(Objeto: TObject);
var
  ItemDeletado :TItemDeletado;
begin
  ItemDeletado := (Objeto as TItemDeletado);

  self.FQuery.ParamByName('codigo').AsInteger         := ItemDeletado.codigo;
  self.FQuery.ParamByName('codigo_pedido').AsInteger  := ItemDeletado.codigo_pedido;
  self.FQuery.ParamByName('codigo_usuario').AsInteger := ItemDeletado.codigo_usuario;
  self.FQuery.ParamByName('codigo_produto').AsInteger := ItemDeletado.codigo_produto;
  self.FQuery.ParamByName('quantidade').AsFloat       := ItemDeletado.quantidade;
  self.FQuery.ParamByName('hora_exclusao').AsDateTime := ItemDeletado.hora_exclusao;
  self.FQuery.ParamByName('justificativa').AsString   := ItemDeletado.justificativa;
end;

function TRepositorioItemDeletado.SQLGet: String;
begin
  result := 'select * from ITENS_DELETADOS where codigo = :ncod';
end;

function TRepositorioItemDeletado.SQLGetAll: String;
begin
  result := 'select * from ITENS_DELETADOS';
end;

function TRepositorioItemDeletado.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ITENS_DELETADOS where '+ campo +' = :ncampo';
end;

function TRepositorioItemDeletado.SQLRemover: String;
begin
  result := ' delete from ITENS_DELETADOS where codigo = :codigo ';
end;

function TRepositorioItemDeletado.SQLSalvar: String;
begin
  result := 'update or insert into ITENS_DELETADOS (CODIGO ,CODIGO_PEDIDO ,CODIGO_USUARIO ,CODIGO_PEDIDO, QUANTIDADE ,HORA_EXCLUSAO ,JUSTIFICATIVA) '+
            '                     values ( :CODIGO, :CODIGO_PEDIDO, :CODIGO_USUARIO, :CODIGO_PEDIDO, :QUANTIDADE, :HORA_EXCLUSAO , :JUSTIFICATIVA) ';
end;

end.

