unit EspecificacaoMovimentosPorCodigoCaixa;

interface

uses
  Especificacao, Caixa;

type
  TEspecificacaoMovimentosPorCodigoCaixa = class(TEspecificacao)

  private
    FCaixa :TCaixa;

  public
    constructor Create(Caixa :TCaixa);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Movimento, Pedido;

{ TEspecificacaoMovimentosPorCodigoCaixa }

constructor TEspecificacaoMovimentosPorCodigoCaixa.Create(Caixa: TCaixa);
begin
  self.FCaixa := Caixa;
end;

function TEspecificacaoMovimentosPorCodigoCaixa.SatisfeitoPor(Objeto: TObject): Boolean;
var Movimento :TMovimento;
begin
  Movimento := TMovimento( Objeto );

  result    := (Movimento.codigo_caixa = self.FCaixa.codigo) and (Movimento.Pedido.situacao = 'F');
end;

end.
