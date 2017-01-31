unit RepositorioProduto;

interface

uses
  DB,
  Auditoria,
  Repositorio,
  FabricaRepositorio;

type
  TRepositorioProduto = class(TRepositorio)

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
  Produto, Estoque;

{ TRepositorioProduto }

procedure TRepositorioProduto.ExecutaDepoisDeSalvar(Objeto: TObject);
var Produto      :TProduto;
    repositorio  :TRepositorio;
begin
 try
   repositorio    := nil;
   Produto        := (Objeto as TProduto);
   repositorio    := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);

   if assigned(Produto.Estoque) then begin
     Produto.Estoque.codigo_produto := Produto.codigo;
     repositorio.Salvar( Produto.Estoque );
   end;

 finally
   FreeAndNil(repositorio);
 end;
end;

function TRepositorioProduto.Get(Dataset: TDataSet): TObject;
var
  Produto :TProduto;
begin
   Produto                     := TProduto.Create;
   Produto.Codigo              := self.FQuery.FieldByName('codigo').AsInteger;
   Produto.codigo_grupo        := self.FQuery.FieldByName('codigo_grupo').AsInteger;
   Produto.descricao           := self.FQuery.FieldByName('descricao').AsString;
   Produto.valor               := self.FQuery.FieldByName('valor').AsFloat;
   Produto.ativo               := self.FQuery.FieldByName('ativo').AsString;
   Produto.codigo_departamento := self.FQuery.FieldByName('codigo_departamento').AsInteger;
   Produto.codigo_ibpt         := self.FQuery.FieldByName('codigo_ibpt').AsInteger;
   Produto.tipo                := self.FQuery.FieldByName('tipo').AsString;
   Produto.icms                := self.FQuery.FieldByName('icms').AsFloat;
   Produto.tributacao          := self.FQuery.FieldByName('tributacao').AsString;
   Produto.preparo             := self.FQuery.FieldByName('preparo').AsString;
   Produto.preco_custo         := self.FQuery.FieldByName('preco_custo').AsFloat;
   Produto.altera_preco        := self.FQuery.FieldByName('altera_preco').AsString;
   Produto.codbar              := self.FQuery.FieldByName('codbar').AsString;
   Produto.referencia          := self.FQuery.FieldByName('referencia').AsString;

   result := Produto;
end;

function TRepositorioProduto.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TProduto(Objeto).Codigo;
end;

function TRepositorioProduto.GetNomeDaTabela: String;
begin
   result := 'produtos';
end;

function TRepositorioProduto.GetRepositorio: TRepositorio;
begin
   result := TRepositorioProduto.Create;
end;

function TRepositorioProduto.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TProduto(Objeto).Codigo <= 0);
end;

procedure TRepositorioProduto.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ProdutoAntigo :TProduto;
  ProdutoNovo   :TProduto;
begin
   ProdutoAntigo := (AntigoObjeto as TProduto);
   ProdutoNovo   := (Objeto       as TProduto);

   if (ProdutoAntigo.codigo_grupo <> ProdutoNovo.codigo_grupo) then
    Auditoria.AdicionaCampoAlterado('codigo_grupo', IntToStr(ProdutoAntigo.codigo_grupo), intToStr(ProdutoNovo.codigo_grupo) );

   if (ProdutoAntigo.descricao <> ProdutoNovo.descricao) then
    Auditoria.AdicionaCampoAlterado('descricao', ProdutoAntigo.descricao, ProdutoNovo.descricao);

   if (ProdutoAntigo.valor <> ProdutoNovo.valor) then
    Auditoria.AdicionaCampoAlterado('valor', FloatToStr(ProdutoAntigo.valor), FloatToStr(ProdutoNovo.valor) );

   if (ProdutoAntigo.ativo <> ProdutoNovo.ativo) then
    Auditoria.AdicionaCampoAlterado('ativo', ProdutoAntigo.ativo, ProdutoNovo.ativo);

   if (ProdutoAntigo.codigo_departamento <> ProdutoNovo.codigo_departamento) then
    Auditoria.AdicionaCampoAlterado('codigo_departamento', IntToStr(ProdutoAntigo.codigo_departamento), intToStr(ProdutoNovo.codigo_departamento) );

   if (ProdutoAntigo.codigo_ibpt <> ProdutoNovo.codigo_ibpt) then
    Auditoria.AdicionaCampoAlterado('codigo_ibpt', IntToStr(ProdutoAntigo.codigo_ibpt), intToStr(ProdutoNovo.codigo_ibpt) );

   if (ProdutoAntigo.tipo <> ProdutoNovo.tipo) then
    Auditoria.AdicionaCampoAlterado('tipo', ProdutoAntigo.tipo, ProdutoNovo.tipo);

   if (ProdutoAntigo.icms <> ProdutoNovo.icms) then
    Auditoria.AdicionaCampoAlterado('icms', FloatToStr(ProdutoAntigo.icms), FloatToStr(ProdutoNovo.icms) );

   if (ProdutoAntigo.tributacao <> ProdutoNovo.tributacao) then
    Auditoria.AdicionaCampoAlterado('tributacao', ProdutoAntigo.tributacao, ProdutoNovo.tributacao);

   if (ProdutoAntigo.preparo <> ProdutoNovo.preparo) then
    Auditoria.AdicionaCampoAlterado('preparo', ProdutoAntigo.preparo, ProdutoNovo.preparo);

   if (ProdutoAntigo.preco_custo <> ProdutoNovo.preco_custo) then
    Auditoria.AdicionaCampoAlterado('preco_custo', FloatToStr(ProdutoAntigo.preco_custo), FloatToStr(ProdutoNovo.preco_custo) );

   if (ProdutoAntigo.altera_preco <> ProdutoNovo.altera_preco) then
    Auditoria.AdicionaCampoAlterado('altera_preco', ProdutoAntigo.altera_preco, ProdutoNovo.altera_preco);

   if (ProdutoAntigo.codbar <> ProdutoNovo.codbar) then
    Auditoria.AdicionaCampoAlterado('codbar', ProdutoAntigo.codbar, ProdutoNovo.codbar);

   if (ProdutoAntigo.referencia <> ProdutoNovo.referencia) then
    Auditoria.AdicionaCampoAlterado('referencia', ProdutoAntigo.referencia, ProdutoNovo.referencia);

end;

procedure TRepositorioProduto.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Produto :TProduto;
begin
   Produto := (Objeto as TProduto);

   Auditoria.AdicionaCampoExcluido('codigo',              IntToStr(Produto.Codigo));
   Auditoria.AdicionaCampoExcluido('codigo_grupo',        IntToStr(Produto.Codigo));
   Auditoria.AdicionaCampoExcluido('descricao',           Produto.descricao);
   Auditoria.AdicionaCampoExcluido('valor',               FloatToStr(Produto.valor));
   Auditoria.AdicionaCampoExcluido('ativo',               Produto.ativo);
   Auditoria.AdicionaCampoExcluido('codigo_departamento', IntToStr(Produto.codigo_departamento));
   Auditoria.AdicionaCampoExcluido('codigo_ibpt',         IntToStr(Produto.codigo_ibpt));
   Auditoria.AdicionaCampoExcluido('tipo',                Produto.tipo);
   Auditoria.AdicionaCampoExcluido('icms',                FloatToStr(Produto.icms));
   Auditoria.AdicionaCampoExcluido('tributacao',          Produto.tributacao);
   Auditoria.AdicionaCampoExcluido('preparo',             Produto.preparo);
   Auditoria.AdicionaCampoExcluido('preco_custo',         FloatToStr(Produto.preco_custo));
   Auditoria.AdicionaCampoExcluido('altera_preco',        Produto.altera_preco);
   Auditoria.AdicionaCampoExcluido('codbar',              Produto.codbar);
   Auditoria.AdicionaCampoExcluido('referencia',              Produto.referencia);
end;

procedure TRepositorioProduto.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Produto :TProduto;
begin
   Produto := (Objeto as TProduto);

   Auditoria.AdicionaCampoIncluido('codigo',       IntToStr(Produto.codigo));
   Auditoria.AdicionaCampoIncluido('codigo_grupo', IntToStr(Produto.codigo_grupo));
   Auditoria.AdicionaCampoIncluido('descricao',    Produto.descricao);
   Auditoria.AdicionaCampoIncluido('valor',        FloatToStr(Produto.valor));
   Auditoria.AdicionaCampoIncluido('ativo',        Produto.ativo);
   Auditoria.AdicionaCampoIncluido('codigo_departamento', IntToStr(Produto.codigo_departamento));
   Auditoria.AdicionaCampoIncluido('codigo_ibpt',         IntToStr(Produto.codigo_ibpt));
   Auditoria.AdicionaCampoIncluido('tipo',         Produto.tipo);
   Auditoria.AdicionaCampoIncluido('icms',                FloatToStr(Produto.icms));
   Auditoria.AdicionaCampoIncluido('tributacao',          Produto.tributacao);
   Auditoria.AdicionaCampoIncluido('preparo',             Produto.preparo);
   Auditoria.AdicionaCampoIncluido('preco_custo',         FloatToStr(Produto.preco_custo));
   Auditoria.AdicionaCampoIncluido('altera_preco',        Produto.altera_preco);
   Auditoria.AdicionaCampoIncluido('codbar',      Produto.codbar);
   Auditoria.AdicionaCampoIncluido('referencia',      Produto.referencia);
end;

procedure TRepositorioProduto.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TProduto(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioProduto.SetParametros(Objeto: TObject);
var
  Produto :TProduto;
begin
   Produto := (Objeto as TProduto);

   self.FQuery.ParamByName('codigo').AsInteger              := Produto.Codigo;

   if Produto.codigo_grupo > 0 then
     self.FQuery.ParamByName('codigo_grupo').AsInteger        := Produto.codigo_grupo;
     
   self.FQuery.ParamByName('descricao').AsString            := Produto.descricao;
   self.FQuery.ParamByName('valor').AsFloat                 := Produto.valor;
   self.FQuery.ParamByName('ativo').AsString                := Produto.ativo;
   self.FQuery.ParamByName('codigo_departamento').AsInteger := Produto.codigo_departamento;

   if Produto.codigo_ibpt > 0 then
     self.FQuery.ParamByName('codigo_ibpt').AsInteger         := Produto.codigo_ibpt;
     
   self.FQuery.ParamByName('tipo').AsString                 := Produto.tipo;
   self.FQuery.ParamByName('icms').AsFloat                  := Produto.icms;
   self.FQuery.ParamByName('tributacao').AsString           := Produto.tributacao;
   self.FQuery.ParamByName('preparo').AsString              := Produto.preparo;
   self.FQuery.ParamByName('preco_custo').AsFloat           := Produto.preco_custo;
   self.FQuery.ParamByName('altera_preco').AsString         := Produto.altera_preco;
   self.FQuery.ParamByName('codbar').AsString               := Produto.codbar;
   self.FQuery.ParamByName('referencia').AsString           := Produto.referencia;
end;

function TRepositorioProduto.SQLGet: String;
begin
  result := 'select * from Produtos where codigo = :ncod';
end;

function TRepositorioProduto.SQLGetAll: String;
begin
   result := 'select * from Produtos order by 1';
end;

function TRepositorioProduto.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Produtos where '+ campo +' = :ncampo';
end;

function TRepositorioProduto.SQLRemover: String;
begin
   result := ' delete from Produtos where codigo = :codigo ';
end;

function TRepositorioProduto.SQLSalvar: String;
begin
   result := 'update or insert into Produtos ( codigo,  codigo_grupo,  descricao,  valor,  ativo,  codigo_departamento,  codigo_ibpt,  tipo,  icms,  tributacao, preparo, preco_custo, altera_preco, codbar, referencia) '+
             '                        values (:codigo, :codigo_grupo, :descricao, :valor, :ativo, :codigo_departamento, :codigo_ibpt, :tipo, :icms, :tributacao, :preparo, :preco_custo, :altera_preco, :codbar, :referencia) ';
end;

end.
