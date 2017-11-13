unit ConfiguracoesSistema;

interface

uses SysUtils, Contnrs;

type
  TConfiguracoesSistema = class

  private
    Fcodigo              :Integer;
    Fpossui_boliche      :Boolean;
    Fpossui_dispensadora :Boolean;
    Fduas_vias_pedido    :Boolean;
    Fpreco_produto_alteravel :Boolean;
    FUtiliza_comandas :Boolean;
    Fpossui_delivery: Boolean;
    Fduas_vias_departamento  :Boolean;
    Fimp_dep_espacada         :Boolean;
    FDesconto_pedido: Boolean;
    FImpressoes_parciais: Boolean;
    FPerguntaImprimirPedido: Boolean;
    FControlaValidade: Boolean;

  public
    property codigo                  :Integer read Fcodigo                  write Fcodigo;
    property possuiBoliche           :Boolean read Fpossui_boliche          write Fpossui_boliche;
    property possuiDispensadora      :Boolean read Fpossui_dispensadora     write Fpossui_dispensadora;
    property duasViasPedido          :Boolean read Fduas_vias_pedido        write Fduas_vias_pedido;
    property precoProdutoAlteravel   :Boolean read Fpreco_produto_alteravel write Fpreco_produto_alteravel;
    property utilizaComandas         :Boolean read FUtiliza_comandas        write Futiliza_comandas;
    property possuiDelivery          :Boolean read Fpossui_delivery         write Fpossui_delivery;
    property impDepEspacada          :Boolean read Fimp_dep_espacada        write Fimp_dep_espacada;
    property descontoPedido          :Boolean read FDesconto_pedido         write FDesconto_pedido;
    property impressoesParciais      :Boolean read FImpressoes_parciais     write FImpressoes_parciais;
    property perguntaImprimirPedido  :Boolean read FPerguntaImprimirPedido  write FPerguntaImprimirPedido;
    property controlaValidade        :Boolean read FControlaValidade        write FControlaValidade;
end;

implementation

{ TConfiguracoesSistema }

end.
