unit ParametrosDANFE;

interface

type
  TParametrosDANFE = class
  
  private
    FViaConsumidor: Boolean;
    FVisualizarImpressao: Boolean;
    FImprimirItens: Boolean;

  public
    property VisualizarImpressao :Boolean read FVisualizarImpressao write FVisualizarImpressao;
    property ViaConsumidor :Boolean read FViaConsumidor write FViaConsumidor;
    property ImprimirItens :Boolean read FImprimirItens write FImprimirItens;
end;

implementation

{ TParametrosDANFE }

end.
