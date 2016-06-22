unit CSTTributadoIntegralmente;

interface

type
  TCSTTributadoIntegralmente = class
  
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

{ TCSTTributadoIntegralmente }

constructor TCSTTributadoIntegralmente.Create(Aliquota, Base: Real);
begin
   FAliquota := Aliquota;
   FBase := Base;
end;

function TCSTTributadoIntegralmente.GetValor: Real;
begin
   result := (FBase * FAliquota) / 100;
end;

end.
