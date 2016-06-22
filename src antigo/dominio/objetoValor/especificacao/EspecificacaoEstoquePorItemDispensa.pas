unit EspecificacaoEstoquePorItemDispensa;

interface

uses
  Especificacao,
  Dispensa;

type
  TEspecificacaoEstoquePorItemDispensa = class(TEspecificacao)

  private
    FDispensa :TDispensa;

  public
    constructor Create(Dispensa :TDispensa);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Estoque;

{ TEspecificacaoEstoquePorItemDispensa }

constructor TEspecificacaoEstoquePorItemDispensa.Create(Dispensa: TDispensa);
begin
  self.FDispensa := Dispensa;
end;

function TEspecificacaoEstoquePorItemDispensa.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Estoque :TEstoque;
begin
   Estoque := (Objeto as TEstoque);

   result := (Estoque.codigo_dispensa = self.FDispensa.codigo);
end;

end.
