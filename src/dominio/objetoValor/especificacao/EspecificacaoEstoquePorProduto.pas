unit EspecificacaoEstoquePorProduto;

interface

uses
  Especificacao;

type
  TEspecificacaoEstoquePorProduto = class(TEspecificacao)

  private
    FCodigoProduto :integer;

  public
    constructor Create(codigoProduto :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Estoque;

{ TEspecificacaoEstoquePorProduto }

constructor TEspecificacaoEstoquePorProduto.Create(codigoProduto: integer);
begin
  self.FCodigoProduto := codigoProduto;
end;

function TEspecificacaoEstoquePorProduto.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Estoque :TEstoque;
begin
   Estoque := (Objeto as TEstoque);

   result := (Estoque.codigo_produto = self.FCodigoProduto);
end;

end.
