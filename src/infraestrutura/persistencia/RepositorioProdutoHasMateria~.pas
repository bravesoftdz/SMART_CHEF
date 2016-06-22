unit RepositorioProdutoHasMateria;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioProdutoHasMateria = class(TRepositorio)

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
  ProdutoHasMateria;

{ TRepositorioProdutoHasMateria }

function TRepositorioProdutoHasMateria.Get(Dataset: TDataSet): TObject;
var
  ProdutoHasMateria :TProdutoHasMateria;
begin
   ProdutoHasMateria                := TProdutoHasMateria.Create;
   ProdutoHasMateria.Codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   ProdutoHasMateria.codigo_produto := self.FQuery.FieldByName('codigo_produto').AsInteger;
   ProdutoHasMateria.codigo_materia := self.FQuery.FieldByName('codigo_mateira').AsInteger;

   result := ProdutoHasMateria;
end;

function TRepositorioProdutoHasMateria.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TProdutoHasMateria(Objeto).Codigo;
end;

function TRepositorioProdutoHasMateria.GetNomeDaTabela: String;
begin
   result := 'produtos_has_materias';
end;

function TRepositorioProdutoHasMateria.GetRepositorio: TRepositorio;
begin
   result := TRepositorioProdutoHasMateria.Create;
end;

function TRepositorioProdutoHasMateria.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TProdutoHasMateria(Objeto).Codigo <= 0);
end;

procedure TRepositorioProdutoHasMateria.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ProdutoHasMateriaAntigo :TProdutoHasMateria;
  ProdutoHasMateriaNovo   :TProdutoHasMateria;
begin
   ProdutoHasMateriaAntigo := (AntigoObjeto as TProdutoHasMateria);
   ProdutoHasMateriaNovo   := (Objeto       as TProdutoHasMateria);

   if (ProdutoHasMateriaAntigo.codigo_produto <> ProdutoHasMateriaNovo.codigo_produto) then
    Auditoria.AdicionaCampoAlterado('codigo_produto', IntToStr(ProdutoHasMateriaAntigo.codigo_produto), IntToStr(ProdutoHasMateriaNovo.codigo_produto));

   if (ProdutoHasMateriaAntigo.codigo_materia <> ProdutoHasMateriaNovo.codigo_materia) then
    Auditoria.AdicionaCampoAlterado('codigo_materia', IntToStr(ProdutoHasMateriaAntigo.codigo_materia), IntToStr(ProdutoHasMateriaNovo.codigo_materia));
end;

procedure TRepositorioProdutoHasMateria.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ProdutoHasMateria :TProdutoHasMateria;
begin
   ProdutoHasMateria := (Objeto as TProdutoHasMateria);

   Auditoria.AdicionaCampoExcluido('codigo',         IntToStr(ProdutoHasMateria.codigo));
   Auditoria.AdicionaCampoExcluido('codigo_produto', IntToStr(ProdutoHasMateria.codigo_produto));
   Auditoria.AdicionaCampoExcluido('codigo_materia', IntToStr(ProdutoHasMateria.codigo_materia));
end;

procedure TRepositorioProdutoHasMateria.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ProdutoHasMateria :TProdutoHasMateria;
begin
   ProdutoHasMateria := (Objeto as TProdutoHasMateria);

   Auditoria.AdicionaCampoIncluido('codigo',         IntToStr(ProdutoHasMateria.codigo));
   Auditoria.AdicionaCampoIncluido('codigo_produto', IntToStr(ProdutoHasMateria.codigo_produto));
   Auditoria.AdicionaCampoIncluido('codigo_materia', IntToStr(ProdutoHasMateria.codigo_materia));
end;

procedure TRepositorioProdutoHasMateria.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TProdutoHasMateria(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioProdutoHasMateria.SetParametros(Objeto: TObject);
var
  ProdutoHasMateria :TProdutoHasMateria;
begin
   ProdutoHasMateria := (Objeto as TProdutoHasMateria);

   self.FQuery.ParamByName('codigo').AsInteger         := ProdutoHasMateria.Codigo;
   self.FQuery.ParamByName('codigo_produto').AsInteger := ProdutoHasMateria.codigo_produto;
   self.FQuery.ParamByName('codigo_materia').AsInteger := ProdutoHasMateria.codigo_materia;
end;

function TRepositorioProdutoHasMateria.SQLGet: String;
begin
  result := 'select * from produtos_has_materias where codigo = :ncod';
end;

function TRepositorioProdutoHasMateria.SQLGetAll: String;
begin
   result := 'select * from produtos_has_materias';
end;

function TRepositorioProdutoHasMateria.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from produtos_has_materias where '+ campo +' = :ncampo';
end;

function TRepositorioProdutoHasMateria.SQLRemover: String;
begin
   result := ' delete from produtos_has_materias where codigo = :codigo ';
end;

function TRepositorioProdutoHasMateria.SQLSalvar: String;
begin
   result := 'update or insert into produtos_has_materias (codigo, codigo_produto, codigo_materia) '+
             '                               values (:codigo, :codigo_produto, :codigo_materia)    ';
end;

end.
