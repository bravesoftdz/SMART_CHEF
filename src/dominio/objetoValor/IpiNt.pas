unit IpiNt;

interface

uses
  TributacaoItemNotaFiscal;

type
  TIpiNt = class(TTributacaoItemNotaFiscal)

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

{ TIpiNt }

constructor TIpiNt.Create(pBaseCalculo: Real; pCodigoItem: integer);
begin
  self.FBaseCalculo := pBaseCalculo;
  self.FCodigoItem  := pCodigoItem;
end;

constructor TIpiNt.Create;
begin
//
end;

function TIpiNt.GetCST: String;
begin
   result := '52';
end;

end.
