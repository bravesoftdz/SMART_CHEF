unit EspecificacaoProdutosQueContemMateria;

interface

uses
  Especificacao;

type
  TEspecificacaoProdutosQueContemMateria = class(TEspecificacao)

  private
    FCodigo_materia :integer;

  public
    constructor Create(codigo_materia :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses ProdutoHasMateria;

{ TEspecificacaoProdutosQueContemMateria }

constructor TEspecificacaoProdutosQueContemMateria.Create(codigo_materia: integer);
begin
  self.FCodigo_materia := codigo_materia;
end;

function TEspecificacaoProdutosQueContemMateria.SatisfeitoPor(Objeto: TObject): Boolean;
var
  ProdutoHasMateria :TProdutoHasMateria;
begin
  ProdutoHasMateria := (Objeto as TProdutoHasMateria);

  result := (ProdutoHasMateria.codigo_materia = self.FCodigo_materia);
end;

end.
