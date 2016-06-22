unit RepositorioDispensa;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioDispensa = class(TRepositorio)

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

uses SysUtils, Dispensa;

{ TRepositorioDispensa }

function TRepositorioDispensa.Get(Dataset: TDataSet): TObject;
var
  Dispensa :TDispensa;
begin
   Dispensa                := TDispensa.Create;
   Dispensa.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Dispensa.descricao_item := self.FQuery.FieldByName('descricao_item').AsString;
   Dispensa.preco_custo    := self.FQuery.FieldByName('preco_custo').AsFloat;

   result := Dispensa;
end;

function TRepositorioDispensa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TDispensa(Objeto).Codigo;
end;

function TRepositorioDispensa.GetNomeDaTabela: String;
begin
  result := 'DISPENSA';
end;

function TRepositorioDispensa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioDispensa.Create;
end;

function TRepositorioDispensa.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TDispensa(Objeto).Codigo <= 0);
end;

procedure TRepositorioDispensa.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  DispensaAntigo :TDispensa;
  DispensaNovo :TDispensa;
begin
   DispensaAntigo := (AntigoObjeto as TDispensa);
   DispensaNovo   := (Objeto       as TDispensa);

   if (DispensaAntigo.descricao_item <> DispensaNovo.descricao_item) then
     Auditoria.AdicionaCampoAlterado('descricao_item', DispensaAntigo.descricao_item, DispensaNovo.descricao_item);

   if (DispensaAntigo.preco_custo <> DispensaNovo.preco_custo) then
     Auditoria.AdicionaCampoAlterado('preco_custo', FloatToStr(DispensaAntigo.preco_custo), FloatToStr(DispensaNovo.preco_custo));
end;

procedure TRepositorioDispensa.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Dispensa :TDispensa;
begin
  Dispensa := (Objeto as TDispensa);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(Dispensa.codigo));
  Auditoria.AdicionaCampoExcluido('descricao_item', Dispensa.descricao_item);
  Auditoria.AdicionaCampoExcluido('preco_custo'   , FloatToStr(Dispensa.preco_custo));
end;

procedure TRepositorioDispensa.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Dispensa :TDispensa;
begin
  Dispensa := (Objeto as TDispensa);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(Dispensa.codigo));
  Auditoria.AdicionaCampoIncluido('descricao_item',    Dispensa.descricao_item);
  Auditoria.AdicionaCampoIncluido('preco_custo'   ,    FloatToStr(Dispensa.preco_custo));
end;

procedure TRepositorioDispensa.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TDispensa(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioDispensa.SetParametros(Objeto: TObject);
var
  Dispensa :TDispensa;
begin
  Dispensa := (Objeto as TDispensa);

  self.FQuery.ParamByName('codigo').AsInteger         := Dispensa.codigo;
  self.FQuery.ParamByName('descricao_item').AsString  := Dispensa.descricao_item;
  self.FQuery.ParamByName('preco_custo').AsFloat      := Dispensa.preco_custo;
end;

function TRepositorioDispensa.SQLGet: String;
begin
  result := 'select * from DISPENSA where codigo = :ncod';
end;

function TRepositorioDispensa.SQLGetAll: String;
begin
  result := 'select * from DISPENSA';
end;

function TRepositorioDispensa.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from DISPENSA where '+ campo +' = :ncampo';
end;

function TRepositorioDispensa.SQLRemover: String;
begin
  result := ' delete from DISPENSA where codigo = :codigo ';
end;

function TRepositorioDispensa.SQLSalvar: String;
begin
  result := 'update or insert into DISPENSA ( CODIGO ,DESCRICAO_ITEM, PRECO_CUSTO)  '+
           '                      values ( :CODIGO , :DESCRICAO_ITEM, :PRECO_CUSTO) ';
end;

end.

