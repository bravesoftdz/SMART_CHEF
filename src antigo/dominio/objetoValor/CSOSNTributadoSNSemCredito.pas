unit CSOSNTributadoSNSemCredito;

interface

type
  TCSOSNTributadoSNSemCredito = class
  
  private
    FBase: Real;
    FAliquota: Real;

  private
    function GetValor: Real;


  public
    constructor Create(Aliquota :Real; Base :Real);

  public
    property Aliquota :Real read FAliquota;
    property Base :Real read FBase;
    property Valor :Real read GetValor;

end;

implementation

{ TCSOSNTributadoSNSemCredito }

constructor TCSOSNTributadoSNSemCredito.Create(Aliquota, Base: Real);
begin
   FAliquota := Aliquota;
   FBase := Base;
end;

function TCSOSNTributadoSNSemCredito.GetValor: Real;
begin
   result := (FBase * FAliquota) / 100;
end;

end.
