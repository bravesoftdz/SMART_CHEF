unit EspecificacaoMateriasDoProduto;

interface

uses
  Especificacao;

type
  TEspecificacaoMateriasDoProduto = class(TEspecificacao)

  private
    Fcodigo_produto :Integer;

  public
    constructor Create(codigo_produto :Integer);

  public
    function SatisfeitoPor(ProdutoHasMateria :TObject) :Boolean; override;
end;

implementation

uses
  ProdutoHasMateria,
  SysUtils;

{ TEspecificacaoMateriasDoProduto }

constructor TEspecificacaoMateriasDoProduto.Create(codigo_produto: Integer);
begin
  self.Fcodigo_produto := codigo_produto;
end;

function TEspecificacaoMateriasDoProduto.SatisfeitoPor(ProdutoHasMateria: TObject): Boolean;
begin
  result := TProdutoHasMateria( ProdutoHasMateria ).codigo_produto = self.Fcodigo_produto;
end;

end.
