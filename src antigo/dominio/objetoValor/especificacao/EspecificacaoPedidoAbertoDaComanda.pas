unit EspecificacaoPedidoAbertoDaComanda;

interface

uses
  Especificacao;

type
  TEspecificacaoPedidoAbertoDaComanda = class(TEspecificacao)

  private
    FCodigoComanda :integer;

  public
    constructor Create(codigo :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Pedido;

{ TEspecificacaoPedidoAbertoDaComanda }

constructor TEspecificacaoPedidoAbertoDaComanda.Create(codigo :integer);
begin
  self.FCodigoComanda := codigo;
end;

function TEspecificacaoPedidoAbertoDaComanda.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Pedido :TPedido;
begin
   Pedido := (Objeto as TPedido);

   result := (Pedido.codigo_comanda = self.FCodigoComanda) and (Pedido.situacao = 'A');
end;

end.
