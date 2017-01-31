unit CofinsNt;

interface

type
  TCofinsNt = class
  
  private
    FBaseCalculo: Real;
    FCodigoItem: integer;

    function GetCST: String;

  public
    constructor Create;overload;
    constructor Create(pBaseCalculo :Real; pCodigoItem :integer);overload;

  public
    property CST           :String read GetCST;
    property BaseCalculo   :Real   read FBaseCalculo  write FBaseCalculo;
    property CodigoItem    :integer read FCodigoItem        write FCodigoItem;
end;

implementation

{ TCofinsNt }

constructor TCofinsNt.Create(pBaseCalculo: Real; pCodigoItem: integer);
begin
  self.Create;
  self.FBaseCalculo := pBaseCalculo;
  self.FCodigoItem  := pCodigoItem;
end;

constructor TCofinsNt.Create;
begin
  //
end;

function TCofinsNt.GetCST: String;
begin
   result := '07';
end;

end.
