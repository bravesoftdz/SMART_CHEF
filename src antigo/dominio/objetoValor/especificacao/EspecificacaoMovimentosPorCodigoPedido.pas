unit EspecificacaoMovimentosPorCodigoPedido;

interface

uses
  Especificacao, Caixa;

type
  TEspecificacaoMovimentosPorCodigoPedido = class(TEspecificacao)

  private
    FCodigo_pedido :integer;

  public
    constructor Create(codigo_pedido :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Movimento;

{ TEspecificacaoMovimentosPorCodigoPedido }

constructor TEspecificacaoMovimentosPorCodigoPedido.Create(codigo_pedido: integer);
begin
  self.FCodigo_pedido := codigo_pedido;
end;

function TEspecificacaoMovimentosPorCodigoPedido.SatisfeitoPor(Objeto: TObject): Boolean;
var Movimento :TMovimento;
begin
  Movimento := TMovimento( Objeto );

  result    := (Movimento.codigo_pedido = Self.FCodigo_pedido);
end;

end.
