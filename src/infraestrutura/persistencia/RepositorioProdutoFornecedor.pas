unit RepositorioProdutoFornecedor;

interface

uses DB,
     Auditoria,
     Repositorio;
type
  TRepositorioProdutoFornecedor = class(TRepositorio)
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
  SysUtils, System.StrUtils,
  ProdutoFornecedor;

{ TRepositorioProdutoFornecedor }

function TRepositorioProdutoFornecedor.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FIdentificador;
end;

function TRepositorioProdutoFornecedor.Get(Dataset: TDataSet): TObject;
var
  ProdutoFornecedor :TProdutoFornecedor;
begin
   ProdutoFornecedor  := TProdutoFornecedor.Create;
   ProdutoFornecedor.CODIGO                     := self.FQuery.FieldByName('CODIGO'  ).AsInteger;
   ProdutoFornecedor.CODIGO_Produto             := self.FQuery.FieldByName('CODIGO_Produto'  ).AsInteger;
   ProdutoFornecedor.CODIGO_FORNECEDOR          := self.FQuery.FieldByName('CODIGO_FORNECEDOR'  ).AsInteger;
   ProdutoFornecedor.CODIGO_Produto_FORNECEDOR  := self.FQuery.FieldByName('CODIGO_Produto_FORNECEDOR'  ).AsString;
   result := ProdutoFornecedor;
end;

function TRepositorioProdutoFornecedor.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TProdutoFornecedor(Objeto).Codigo;
end;

function TRepositorioProdutoFornecedor.GetNomeDaTabela: String;
begin
result := 'Produto_FORNECEDOR';
end;

function TRepositorioProdutoFornecedor.GetRepositorio: TRepositorio;
begin
result := TRepositorioProdutoFornecedor.Create;
end;

function TRepositorioProdutoFornecedor.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TProdutoFornecedor(Objeto).Codigo <= 0);
end;

procedure TRepositorioProdutoFornecedor.SetCamposAlterados(Auditoria: TAuditoria;
  AntigoObjeto, Objeto: TObject);
var
  ProdutoFornecedorAntigo :TProdutoFornecedor;
  ProdutoFornecedorNovo   :TProdutoFornecedor;
begin
   ProdutoFornecedorAntigo := (AntigoObjeto as TProdutoFornecedor);
   ProdutoFornecedorNovo   := (Objeto       as TProdutoFornecedor);

   if (ProdutoFornecedorAntigo.CODIGO_Produto <> ProdutoFornecedorNovo.CODIGO_Produto) then
   Auditoria.AdicionaCampoAlterado('CODIGO_Produto', intToStr(ProdutoFornecedorAntigo.CODIGO_Produto), intToStr(ProdutoFornecedorNovo.CODIGO_Produto));

   if (ProdutoFornecedorAntigo.CODIGO_FORNECEDOR <> ProdutoFornecedorNovo.CODIGO_FORNECEDOR) then
   Auditoria.AdicionaCampoAlterado('CODIGO_FORNECEDOR', intToStr(ProdutoFornecedorAntigo.CODIGO_FORNECEDOR), intToStr(ProdutoFornecedorNovo.CODIGO_FORNECEDOR));

   if (ProdutoFornecedorAntigo.CODIGO_Produto_FORNECEDOR <> ProdutoFornecedorNovo.CODIGO_Produto_FORNECEDOR) then
   Auditoria.AdicionaCampoAlterado('CODIGO_Produto_FORNECEDOR', ProdutoFornecedorAntigo.CODIGO_Produto_FORNECEDOR, ProdutoFornecedorNovo.CODIGO_Produto_FORNECEDOR);


end;

procedure TRepositorioProdutoFornecedor.SetCamposExcluidos(Auditoria: TAuditoria;
  Objeto: TObject);
var
  ProdutoFornecedor :TProdutoFornecedor;
begin
   ProdutoFornecedor := (Objeto as TProdutoFornecedor);

   Auditoria.AdicionaCampoExcluido('CODIGO' , intToStr(ProdutoFornecedor.CODIGO));
   Auditoria.AdicionaCampoExcluido('CODIGO_Produto' , intToStr(ProdutoFornecedor.CODIGO_Produto));
   Auditoria.AdicionaCampoExcluido('CODIGO_FORNECEDOR' , intToStr(ProdutoFornecedor.CODIGO_FORNECEDOR));
   Auditoria.AdicionaCampoExcluido('CODIGO_Produto_FORNECEDOR' , ProdutoFornecedor.CODIGO_Produto_FORNECEDOR);

end;

procedure TRepositorioProdutoFornecedor.SetCamposIncluidos(Auditoria: TAuditoria;
  Objeto: TObject);
var
  ProdutoFornecedor :TProdutoFornecedor;
begin
   ProdutoFornecedor := (Objeto as TProdutoFornecedor);

   Auditoria.AdicionaCampoIncluido('CODIGO' , intToStr(ProdutoFornecedor.CODIGO));
   Auditoria.AdicionaCampoIncluido('CODIGO_Produto' , intToStr(ProdutoFornecedor.CODIGO_Produto));
   Auditoria.AdicionaCampoIncluido('CODIGO_FORNECEDOR' , intToStr(ProdutoFornecedor.CODIGO_FORNECEDOR));
   Auditoria.AdicionaCampoIncluido('CODIGO_Produto_FORNECEDOR' , ProdutoFornecedor.CODIGO_Produto_FORNECEDOR);

end;

procedure TRepositorioProdutoFornecedor.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TProdutoFornecedor(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioProdutoFornecedor.SetParametros(Objeto: TObject);
var
  ProdutoFornecedor :TProdutoFornecedor;
begin
   ProdutoFornecedor := (Objeto as TProdutoFornecedor);
  if (ProdutoFornecedor.Codigo > 0) then  inherited SetParametro('codigo', ProdutoFornecedor.Codigo)
  else                         inherited LimpaParametro('codigo');

   self.FQuery.ParamByName('CODIGO').AsInteger        := ProdutoFornecedor.CODIGO;
   self.FQuery.ParamByName('CODIGO_Produto').AsInteger        := ProdutoFornecedor.CODIGO_Produto;
   self.FQuery.ParamByName('CODIGO_FORNECEDOR').AsInteger        := ProdutoFornecedor.CODIGO_FORNECEDOR;
   self.FQuery.ParamByName('CODIGO_Produto_FORNECEDOR').AsString        := ProdutoFornecedor.CODIGO_Produto_FORNECEDOR;

end;

function TRepositorioProdutoFornecedor.SQLGet: String;
begin
  result := 'select * from Produto_FORNECEDOR where codigo = :ncod';
end;

function TRepositorioProdutoFornecedor.SQLGetAll: String;
begin
  result := 'select * from Produto_FORNECEDOR'+ IfThen(FIdentificador = '','', CondicaoSQLGetAll);;
end;

function TRepositorioProdutoFornecedor.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Produto_FORNECEDOR where '+ campo +' = :ncampo';
end;

function TRepositorioProdutoFornecedor.SQLRemover: String;
begin
   result := ' delete from Produto_FORNECEDOR where codigo = :codigo ';
end;

function TRepositorioProdutoFornecedor.SQLSalvar: String;
begin
  result := 'update or insert into Produto_FORNECEDOR                                            '+
            ' ( CODIGO, CODIGO_Produto, CODIGO_FORNECEDOR, CODIGO_Produto_FORNECEDOR)            '+
            ' Values ( :CODIGO, :CODIGO_Produto, :CODIGO_FORNECEDOR, :CODIGO_Produto_FORNECEDOR) ';
end;

end.
