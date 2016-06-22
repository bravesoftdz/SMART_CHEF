unit EspecificacaoPedidosComItemNaoImpresso;

interface

uses
  Especificacao;

type
  TEspecificacaoPedidosComItemNaoImpresso = class(TEspecificacao)

  private
   FCodigo_departamento :integer;

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Pedido, Classes, Item;

{ TEspecificacaoPedidosComItemNaoImpresso }

function TEspecificacaoPedidosComItemNaoImpresso.SatisfeitoPor(Objeto: TObject): Boolean;
var i      :integer;
    Pedido :TPedido;
begin
  Pedido := (Objeto as TPedido);

  result := false;

  if not assigned(Pedido.Itens) then
    Exit;
    
  for i := 0 to Pedido.Itens.Count - 1 do begin
    if not ((Pedido.Itens[i] as TItem).impresso = 'S') then begin
      Result := true;
      break;
    end;
  end;

end;

end.
