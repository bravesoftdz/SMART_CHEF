unit RepositorioEstoque;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioEstoque = class(TRepositorio)

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

uses SysUtils, Estoque;

{ TRepositorioEstoque }

function TRepositorioEstoque.Get(Dataset: TDataSet): TObject;
var
  Estoque :TEstoque;
begin
   Estoque:= TEstoque.Create;
   Estoque.codigo          := self.FQuery.FieldByName('codigo').AsInteger;
   Estoque.codigo_produto  := self.FQuery.FieldByName('codigo_produto').AsInteger;
   Estoque.codigo_dispensa := self.FQuery.FieldByName('codigo_dispensa').AsInteger;
   Estoque.quantidade      := self.FQuery.FieldByName('quantidade').AsFloat;
   Estoque.unidade_medida  := self.FQuery.FieldByName('unidade_medida').AsString;
   Estoque.pecas           := self.FQuery.FieldByName('pecas').AsInteger;
   Estoque.quantidade_min  := self.FQuery.FieldByName('quantidade_min').AsFloat;

   result := Estoque;
end;

function TRepositorioEstoque.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEstoque(Objeto).Codigo;
end;

function TRepositorioEstoque.GetNomeDaTabela: String;
begin
  result := 'ESTOQUE';
end;

function TRepositorioEstoque.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEstoque.Create;
end;

function TRepositorioEstoque.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEstoque(Objeto).Codigo <= 0);
end;

procedure TRepositorioEstoque.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  EstoqueAntigo :TEstoque;
  EstoqueNovo :TEstoque;
begin
   EstoqueAntigo := (AntigoObjeto as TEstoque);
   EstoqueNovo   := (Objeto       as TEstoque);

   if (EstoqueAntigo.codigo_produto <> EstoqueNovo.codigo_produto) then
     Auditoria.AdicionaCampoAlterado('codigo_produto', IntToStr(EstoqueAntigo.codigo_produto), IntToStr(EstoqueNovo.codigo_produto));

   if (EstoqueAntigo.codigo_dispensa <> EstoqueNovo.codigo_dispensa) then
     Auditoria.AdicionaCampoAlterado('codigo_dispensa', IntToStr(EstoqueAntigo.codigo_dispensa), IntToStr(EstoqueNovo.codigo_dispensa));

   if (EstoqueAntigo.quantidade <> EstoqueNovo.quantidade) then
     Auditoria.AdicionaCampoAlterado('quantidade', FloatToStr(EstoqueAntigo.quantidade), FloatToStr(EstoqueNovo.quantidade));

   if (EstoqueAntigo.unidade_medida <> EstoqueNovo.unidade_medida) then
     Auditoria.AdicionaCampoAlterado('unidade_medida', EstoqueAntigo.unidade_medida, EstoqueNovo.unidade_medida);

   if (EstoqueAntigo.pecas <> EstoqueNovo.pecas) then
     Auditoria.AdicionaCampoAlterado('pecas', IntToStr(EstoqueAntigo.pecas), IntToStr(EstoqueNovo.pecas));

   if (EstoqueAntigo.quantidade_min <> EstoqueNovo.quantidade_min) then
     Auditoria.AdicionaCampoAlterado('quantidade_min', FloatToStr(EstoqueAntigo.quantidade_min), FloatToStr(EstoqueNovo.quantidade_min));
end;

procedure TRepositorioEstoque.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Estoque :TEstoque;
begin
  Estoque := (Objeto as TEstoque);
  Auditoria.AdicionaCampoExcluido('codigo'         , IntToStr(Estoque.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_produto' , IntToStr(Estoque.codigo_produto));
  Auditoria.AdicionaCampoExcluido('codigo_dispensa', IntToStr(Estoque.codigo_dispensa));
  Auditoria.AdicionaCampoExcluido('quantidade'     , FloatToStr(Estoque.quantidade));
  Auditoria.AdicionaCampoExcluido('unidade_medida' , Estoque.unidade_medida);
  Auditoria.AdicionaCampoExcluido('pecas'          , IntToStr(Estoque.pecas));
  Auditoria.AdicionaCampoExcluido('quantidade_min' , FloatToStr(Estoque.quantidade_min));
end;

procedure TRepositorioEstoque.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Estoque :TEstoque;
begin
  Estoque := (Objeto as TEstoque);
  Auditoria.AdicionaCampoIncluido('codigo'         ,    IntToStr(Estoque.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_produto' ,    IntToStr(Estoque.codigo_produto));
  Auditoria.AdicionaCampoIncluido('codigo_dispensa',    IntToStr(Estoque.codigo_dispensa));
  Auditoria.AdicionaCampoIncluido('quantidade'     ,    FloatToStr(Estoque.quantidade));
  Auditoria.AdicionaCampoIncluido('unidade_medida' ,    Estoque.unidade_medida);
  Auditoria.AdicionaCampoIncluido('pecas'          ,    IntToStr(Estoque.pecas));
  Auditoria.AdicionaCampoIncluido('quantidade_min' ,    FloatToStr(Estoque.quantidade_min));  
end;

procedure TRepositorioEstoque.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEstoque(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEstoque.SetParametros(Objeto: TObject);
var
  Estoque :TEstoque;
begin
  Estoque := (Objeto as TEstoque);

  self.FQuery.ParamByName('codigo').AsInteger          := Estoque.codigo;

  if Estoque.codigo_produto > 0 then
    self.FQuery.ParamByName('codigo_produto').AsInteger  := Estoque.codigo_produto;

  if Estoque.codigo_dispensa > 0 then
    self.FQuery.ParamByName('codigo_dispensa').AsInteger := Estoque.codigo_dispensa;
    
  self.FQuery.ParamByName('quantidade').AsFloat        := Estoque.quantidade;
  self.FQuery.ParamByName('unidade_medida').AsString   := Estoque.unidade_medida;
  self.FQuery.ParamByName('pecas').AsInteger           := Estoque.pecas;
  self.FQuery.ParamByName('quantidade_min').AsFloat    := Estoque.quantidade_min;
end;

function TRepositorioEstoque.SQLGet: String;
begin
  result := 'select * from ESTOQUE where codigo = :ncod';
end;

function TRepositorioEstoque.SQLGetAll: String;
begin
  result := 'select * from ESTOQUE';
end;

function TRepositorioEstoque.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ESTOQUE where '+ campo +' = :ncampo';
end;

function TRepositorioEstoque.SQLRemover: String;
begin
  result := ' delete from ESTOQUE where codigo = :codigo ';
end;

function TRepositorioEstoque.SQLSalvar: String;
begin
  result := 'update or insert into ESTOQUE (CODIGO ,CODIGO_PRODUTO ,CODIGO_DISPENSA ,QUANTIDADE ,UNIDADE_MEDIDA ,PECAS, QUANTIDADE_MIN) '+
           '                      values ( :CODIGO , :CODIGO_PRODUTO , :CODIGO_DISPENSA , :QUANTIDADE , :UNIDADE_MEDIDA , :PECAS, :QUANTIDADE_MIN) ';
end;

end.

