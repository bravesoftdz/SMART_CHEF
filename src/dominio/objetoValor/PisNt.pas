unit PisNt;

interface

uses
  TributacaoItemNotaFiscal;

type
  TPisNt = class(TTributacaoItemNotaFiscal)

  private
    FBaseCalculo: Real;
    FCodigoItem: integer;

    function GetCST: String;

  public
    constructor Create;overload;
    constructor Create(pBaseCalculo :Real; pCodigoItem :integer);overload;

  public
    property CST :String read GetCST;
    property BaseCalculo   :Real   read FBaseCalculo  write FBaseCalculo;
    property CodigoItem    :integer read FCodigoItem        write FCodigoItem;
end;

implementation

{ TPisNt }

constructor TPisNt.Create(pBaseCalculo: Real; pCodigoItem: integer);
begin
  self.FBaseCalculo := pBaseCalculo;
  self.FCodigoItem  := pCodigoItem;
end;

constructor TPisNt.Create;
begin
//
end;

function TPisNt.GetCST: String;
begin
   result := '07';
end;

end.
