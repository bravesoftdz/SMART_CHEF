unit EspecificacaoItensDoPedido;

interface

uses
  Especificacao,
  Pedido;

type
  TEspecificacaoItensDoPedido = class(TEspecificacao)

  private
    FPedido :TPedido;

  public
    constructor Create(Pedido :TPedido);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Item;

{ TEspecificacaoItensDoPedido }

constructor TEspecificacaoItensDoPedido.Create(Pedido: TPedido);
begin
   self.FPedido := Pedido;
end;

function TEspecificacaoItensDoPedido.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Item :TItem;
begin
   Item := (Objeto as TItem);

   result := (Item.codigo_pedido = self.FPedido.codigo);
end;

end.
