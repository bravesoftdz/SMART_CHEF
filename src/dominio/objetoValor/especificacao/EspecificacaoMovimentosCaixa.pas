unit EspecificacaoMovimentosCaixa;

interface

uses
  Especificacao, Caixa;

type
  TEspecificacaoMovimentosCaixa = class(TEspecificacao)

  private
    FCaixa :TCaixa;

  public
    constructor Create(Caixa :TCaixa);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Movimento;

{ TEspecificacaoMovimentosCaixa }

constructor TEspecificacaoMovimentosCaixa.Create(Caixa: TCaixa);
begin
  FCaixa := Caixa;
end;

function TEspecificacaoMovimentosCaixa.SatisfeitoPor(Objeto: TObject): Boolean;
var Movimento :TMovimento;
begin
  Movimento := (Objeto as TMovimento);

  result := (Movimento.codigo_caixa = self.FCaixa.codigo) and (Movimento.Pedido.situacao <> 'C');
end;

end.
 