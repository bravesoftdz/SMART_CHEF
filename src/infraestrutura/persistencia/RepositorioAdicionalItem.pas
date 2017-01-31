unit RepositorioAdicionalItem;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioAdicionalItem = class(TRepositorio)

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
  AdicionalItem, StrUtils;

{ TRepositorioAdicionalItem }

function TRepositorioAdicionalItem.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FIdentificador;
end;

function TRepositorioAdicionalItem.Get(Dataset: TDataSet): TObject;
var
  AdicionalItem :TAdicionalItem;
begin
   AdicionalItem                := TAdicionalItem.Create;
   AdicionalItem.Codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   AdicionalItem.codigo_item    := self.FQuery.FieldByName('codigo_item').AsInteger;
   AdicionalItem.codigo_materia := self.FQuery.FieldByName('codigo_materia').AsInteger;
   AdicionalItem.flag           := self.FQuery.FieldByName('flag').AsString;
   AdicionalItem.quantidade     := self.FQuery.FieldByName('quantidade').AsInteger;
   AdicionalItem.valor_unitario := self.FQuery.FieldByName('valor_unitario').AsFloat;

   result := AdicionalItem;
end;

function TRepositorioAdicionalItem.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TAdicionalItem(Objeto).Codigo;
end;

function TRepositorioAdicionalItem.GetNomeDaTabela: String;
begin
   result := 'Adicionais_Item';
end;

function TRepositorioAdicionalItem.GetRepositorio: TRepositorio;
begin
   result := TRepositorioAdicionalItem.Create;
end;

function TRepositorioAdicionalItem.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TAdicionalItem(Objeto).Codigo <= 0);
end;

procedure TRepositorioAdicionalItem.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  AdicionalItemAntigo :TAdicionalItem;
  AdicionalItemNovo   :TAdicionalItem;
begin
   AdicionalItemAntigo := (AntigoObjeto as TAdicionalItem);
   AdicionalItemNovo   := (Objeto       as TAdicionalItem);

   if (AdicionalItemAntigo.codigo_item <> AdicionalItemNovo.codigo_item) then
    Auditoria.AdicionaCampoAlterado('codigo_item', IntToStr(AdicionalItemAntigo.codigo_item), IntToStr(AdicionalItemNovo.codigo_item));

   if (AdicionalItemAntigo.codigo_materia <> AdicionalItemNovo.codigo_materia) then
    Auditoria.AdicionaCampoAlterado('codigo_materia', IntToStr(AdicionalItemAntigo.codigo_materia), IntToStr(AdicionalItemNovo.codigo_materia));

   if (AdicionalItemAntigo.flag <> AdicionalItemNovo.flag) then
    Auditoria.AdicionaCampoAlterado('flag', AdicionalItemAntigo.flag, AdicionalItemNovo.flag);

   if (AdicionalItemAntigo.quantidade <> AdicionalItemNovo.quantidade) then
    Auditoria.AdicionaCampoAlterado('quantidade', IntToStr(AdicionalItemAntigo.quantidade), IntToStr(AdicionalItemNovo.quantidade));

   if (AdicionalItemAntigo.valor_unitario <> AdicionalItemNovo.valor_unitario) then
    Auditoria.AdicionaCampoAlterado('valor_unitario', FloatToStr(AdicionalItemAntigo.valor_unitario), FloatToStr(AdicionalItemNovo.valor_unitario));
end;

procedure TRepositorioAdicionalItem.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  AdicionalItem :TAdicionalItem;
begin
   AdicionalItem := (Objeto as TAdicionalItem);

   Auditoria.AdicionaCampoExcluido('codigo',         IntToStr(AdicionalItem.Codigo));
   Auditoria.AdicionaCampoExcluido('codigo_item',    IntToStr(AdicionalItem.codigo_item));
   Auditoria.AdicionaCampoExcluido('codigo_materia', IntToStr(AdicionalItem.codigo_materia));
   Auditoria.AdicionaCampoExcluido('flag',           AdicionalItem.flag);
   Auditoria.AdicionaCampoExcluido('quantidade',     IntToStr(AdicionalItem.quantidade));
   Auditoria.AdicionaCampoExcluido('valor_unitario', FloatToStr(AdicionalItem.valor_unitario));
end;

procedure TRepositorioAdicionalItem.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  AdicionalItem :TAdicionalItem;
begin
   AdicionalItem := (Objeto as TAdicionalItem);

   Auditoria.AdicionaCampoIncluido('codigo',         IntToStr(AdicionalItem.Codigo));
   Auditoria.AdicionaCampoIncluido('codigo_item',    IntToStr(AdicionalItem.codigo_item));
   Auditoria.AdicionaCampoIncluido('codigo_materia', IntToStr(AdicionalItem.codigo_materia));
   Auditoria.AdicionaCampoIncluido('flag',           AdicionalItem.flag);
   Auditoria.AdicionaCampoIncluido('quantidade',     IntToStr(AdicionalItem.quantidade));
   Auditoria.AdicionaCampoIncluido('valor_unitario', FloatToStr(AdicionalItem.valor_unitario));   
end;

procedure TRepositorioAdicionalItem.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TAdicionalItem(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioAdicionalItem.SetParametros(Objeto: TObject);
var
  AdicionalItem :TAdicionalItem;
begin
   AdicionalItem := (Objeto as TAdicionalItem);

   self.FQuery.ParamByName('codigo').AsInteger         := AdicionalItem.Codigo;
   self.FQuery.ParamByName('codigo_item').AsInteger    := AdicionalItem.codigo_item;
   self.FQuery.ParamByName('codigo_materia').AsInteger := AdicionalItem.codigo_materia;
   self.FQuery.ParamByName('flag').AsString            := AdicionalItem.flag;
   self.FQuery.ParamByName('quantidade').AsInteger     := AdicionalItem.quantidade;
   self.FQuery.ParamByName('valor_unitario').AsFloat   := AdicionalItem.valor_unitario;
end;

function TRepositorioAdicionalItem.SQLGet: String;
begin
  result := 'select * from Adicionais_Item where codigo = :ncod';
end;

function TRepositorioAdicionalItem.SQLGetAll: String;
begin
   result := 'select * from Adicionais_Item '+ IfThen(FIdentificador = '','', CondicaoSQLGetAll) +' order by codigo';
end;

function TRepositorioAdicionalItem.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Adicionais_Item where '+ campo +' = :ncampo';
end;

function TRepositorioAdicionalItem.SQLRemover: String;
begin
   result := ' delete from Adicionais_Item where codigo = :codigo ';
end;

function TRepositorioAdicionalItem.SQLSalvar: String;
begin
   result := 'update or insert into Adicionais_Item (codigo,  codigo_item,  codigo_materia,  flag,  quantidade, valor_unitario)  '+
             '                               values (:codigo, :codigo_item, :codigo_materia, :flag, :quantidade, :valor_unitario) ';
end;

end.
