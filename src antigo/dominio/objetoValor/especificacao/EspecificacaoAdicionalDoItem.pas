unit EspecificacaoAdicionalDoItem;

interface

uses
  Especificacao, Pedido, Item;

type
  TEspecificacaoAdicionalDoItem = class(TEspecificacao)

  private
    FItem :TItem;

  public
    constructor Create(Item :TItem);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses AdicionalItem;

{ TEspecificacaoAdicionalDoItem }

constructor TEspecificacaoAdicionalDoItem.Create(Item: TItem);
begin
  self.FItem := Item;
end;

function TEspecificacaoAdicionalDoItem.SatisfeitoPor(Objeto: TObject): Boolean;
var Adicional :TAdicionalItem;
begin
  Adicional := (Objeto as TAdicionalItem);

  result := (Adicional.codigo_item = self.FItem.codigo);
end;

end.
