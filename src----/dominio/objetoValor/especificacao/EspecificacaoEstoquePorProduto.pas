unit EspecificacaoEstoquePorProduto;

interface

uses
  Especificacao,
  Produto;

type
  TEspecificacaoEstoquePorProduto = class(TEspecificacao)

  private
    FProduto :TProduto;

  public
    constructor Create(Produto :TProduto);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Estoque;

{ TEspecificacaoEstoquePorProduto }

constructor TEspecificacaoEstoquePorProduto.Create(Produto: TProduto);
begin
  self.FProduto := Produto;
end;

function TEspecificacaoEstoquePorProduto.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Estoque :TEstoque;
begin
   Estoque := (Objeto as TEstoque);

   result := (Estoque.codigo_produto = self.FProduto.codigo);
end;

end.
