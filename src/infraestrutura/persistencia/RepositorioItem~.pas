unit RepositorioItem;

interface

uses
  DB, Auditoria, Repositorio, FabricaRepositorio;

type
  TRepositorioItem = class(TRepositorio)

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
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

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
  Item, StrUtils, AdicionalItem;

{ TRepositorioItem }

function TRepositorioItem.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FCondicao; 
end;

procedure TRepositorioItem.ExecutaDepoisDeSalvar(Objeto: TObject);
var Item        :TItem;
    repositorio :TRepositorio;
    i           :integer;
begin
 try
   repositorio  := nil;
   Item         := (Objeto as TItem);
   repositorio  := TFabricaRepositorio.GetRepositorio(TAdicionalItem.ClassName);

   if not assigned(Item.Adicionais) then
     Exit;

   for i := 0 to Item.Adicionais.Count -1 do begin
      (Item.Adicionais[i] as TAdicionalItem).codigo_item := Item.codigo;
      repositorio.Salvar( (Item.Adicionais[i] as TAdicionalItem) );
   end;

 finally
   FreeAndNil(repositorio);
 end;
end;

function TRepositorioItem.Get(Dataset: TDataSet): TObject;
var
  Item :TItem;
begin
   Item                := TItem.Create;
   Item.Codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Item.codigo_pedido  := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   Item.codigo_produto := self.FQuery.FieldByName('codigo_produto').AsInteger;
   Item.hora           := self.FQuery.FieldByName('hora').AsDateTime;
   Item.quantidade     := self.FQuery.FieldByName('quantidade').AsFloat;
   Item.impresso       := self.FQuery.FieldByName('impresso').AsString;
   Item.valor_Unitario := self.FQuery.FieldByName('valor_Unitario').AsFloat;
   Item.codigo_usuario := self.FQuery.FieldByName('codigo_usuario').AsInteger;

   result := Item;
end;

function TRepositorioItem.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TItem(Objeto).Codigo;
end;

function TRepositorioItem.GetNomeDaTabela: String;
begin
   result := 'Itens';
end;

function TRepositorioItem.GetRepositorio: TRepositorio;
begin
   result := TRepositorioItem.Create;
end;

function TRepositorioItem.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TItem(Objeto).Codigo <= 0);
end;

procedure TRepositorioItem.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ItemAntigo :TItem;
  ItemNovo   :TItem;
begin
   ItemAntigo := (AntigoObjeto as TItem);
   ItemNovo   := (Objeto       as TItem);

   if (ItemAntigo.codigo_pedido <> ItemNovo.codigo_pedido) then
    Auditoria.AdicionaCampoAlterado('codigo_pedido', IntToStr(ItemAntigo.codigo_pedido), IntToStr(ItemNovo.codigo_pedido));

   if (ItemAntigo.codigo_produto <> ItemNovo.codigo_produto) then
    Auditoria.AdicionaCampoAlterado('codigo_produto', IntToStr(ItemAntigo.codigo_produto), IntToStr(ItemNovo.codigo_produto));

   if (ItemAntigo.hora <> ItemNovo.hora) then
    Auditoria.AdicionaCampoAlterado('hora', DateTimeToStr(ItemAntigo.hora), DateTimeToStr(ItemNovo.hora) );

   if (ItemAntigo.quantidade <> ItemNovo.quantidade) then
    Auditoria.AdicionaCampoAlterado('quantidade', FloatToStr(ItemAntigo.quantidade), FloatToStr(ItemNovo.quantidade) );

   if (ItemAntigo.impresso <> ItemNovo.impresso) then
    Auditoria.AdicionaCampoAlterado('impresso', ItemAntigo.impresso, ItemNovo.impresso);

   if (ItemAntigo.valor_Unitario <> ItemNovo.valor_Unitario) then
    Auditoria.AdicionaCampoAlterado('valor_Unitario', FloatToStr(ItemAntigo.valor_Unitario), FloatToStr(ItemNovo.valor_Unitario) );

   if (ItemAntigo.codigo_usuario <> ItemNovo.codigo_usuario) then
    Auditoria.AdicionaCampoAlterado('codigo_usuario', IntToStr(ItemAntigo.codigo_usuario), IntToStr(ItemNovo.codigo_usuario));
end;

procedure TRepositorioItem.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Item :TItem;
begin
   Item := (Objeto as TItem);

   Auditoria.AdicionaCampoExcluido('codigo',         IntToStr(Item.Codigo));
   Auditoria.AdicionaCampoExcluido('codigo_pedido',  IntToStr(Item.codigo_pedido));
   Auditoria.AdicionaCampoExcluido('codigo_produto', IntToStr(Item.codigo_produto));
   Auditoria.AdicionaCampoExcluido('hora',           DateTimeToStr(Item.hora));
   Auditoria.AdicionaCampoExcluido('quantidade',     FloatToStr(Item.quantidade));
   Auditoria.AdicionaCampoExcluido('impresso',       Item.impresso);
   Auditoria.AdicionaCampoExcluido('valor_Unitario', FloatToStr(Item.valor_Unitario));
   Auditoria.AdicionaCampoExcluido('codigo_usuario', IntToStr(Item.codigo_usuario));
end;

procedure TRepositorioItem.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Item :TItem;
begin
   Item := (Objeto as TItem);

   Auditoria.AdicionaCampoIncluido('codigo',         IntToStr(Item.codigo));
   Auditoria.AdicionaCampoIncluido('codigo_pedido',  IntToStr(Item.codigo_pedido));
   Auditoria.AdicionaCampoIncluido('codigo_produto', IntToStr(Item.codigo_produto));
   Auditoria.AdicionaCampoIncluido('hora',           DateTimeToStr(Item.hora));
   Auditoria.AdicionaCampoIncluido('quantidade',     FloatToStr(Item.quantidade));
   Auditoria.AdicionaCampoIncluido('impresso',       Item.impresso);
   Auditoria.AdicionaCampoIncluido('valor_Unitario', FloatToStr(Item.valor_Unitario));
   Auditoria.AdicionaCampoIncluido('codigo_usuario', IntToStr(Item.codigo_usuario));   
end;

procedure TRepositorioItem.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TItem(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioItem.SetParametros(Objeto: TObject);
var
  Item :TItem;
begin
   Item := (Objeto as TItem);

   self.FQuery.ParamByName('codigo').AsInteger         := Item.Codigo;
   self.FQuery.ParamByName('codigo_pedido').AsInteger  := Item.codigo_pedido;
   self.FQuery.ParamByName('codigo_produto').AsInteger := Item.codigo_produto;
   self.FQuery.ParamByName('hora').AsDateTime          := Item.hora;
   self.FQuery.ParamByName('quantidade').AsFloat       := Item.quantidade;
   self.FQuery.ParamByName('impresso').AsString        := Item.impresso;
   self.FQuery.ParamByName('valor_Unitario').AsFloat   := Item.valor_Unitario;
   self.FQuery.ParamByName('codigo_usuario').AsInteger := Item.codigo_usuario;
end;

function TRepositorioItem.SQLGet: String;
begin
  result := 'select * from Itens where codigo = :ncod';
end;

function TRepositorioItem.SQLGetAll: String;
begin
  result := 'select * from ItenS '+ IfThen(FCondicao = '','', CondicaoSQLGetAll) +' order by codigo';
end;

function TRepositorioItem.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Itens where '+ campo +' = :ncampo';
end;

function TRepositorioItem.SQLRemover: String;
begin
   result := ' delete from Itens where codigo = :codigo ';
end;

function TRepositorioItem.SQLSalvar: String;
begin
   result := 'update or insert into Itens(codigo,   codigo_pedido,  codigo_produto, valor_Unitario,  hora,  quantidade,  impresso, codigo_usuario) '+
             '                     values(:codigo, :codigo_pedido, :codigo_produto, :valor_Unitario, :hora, :quantidade, :impresso, :codigo_usuario) ';
end;

end.
