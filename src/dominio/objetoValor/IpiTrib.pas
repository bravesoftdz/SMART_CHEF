unit IpiTrib;

interface

uses
  TributacaoItemNotaFiscal;

type
  TIpiTrib = class

  private
    FAliquota    :Real;
    FValor       :Real;
    FBaseCalculo: Real;
    FCodigoItem: integer;

    procedure SetAliquota(const Value: Real);
    procedure SetValor(const Value: Real);

  private
    function GetCST   :String;
    function GetValor :Real;

  public
    constructor Create(Aliquota :Real);overload;
    constructor Create(Aliquota, pBaseCalculo :Real; pCodigoItem :integer);overload;

  public
    property codigoItem     :integer read FCodigoItem        write FCodigoItem;
    property CST            :String read GetCST;
    property Aliquota       :Real   read FAliquota write SetAliquota;
    property Valor          :Real   read GetValor  write SetValor;
    property BaseCalculo    :Real   read FBaseCalculo write FBaseCalculo;
end;

implementation

uses Funcoes;

{ TIpiTrib }

constructor TIpiTrib.Create(Aliquota, pBaseCalculo :Real; pCodigoItem :integer);
begin
   self.Create(Aliquota);
   self.FCodigoItem  := pCodigoItem;
   self.FBaseCalculo := pBaseCalculo;
end;

constructor TIpiTrib.Create(Aliquota: Real);
begin
   self.FAliquota    := Aliquota;
end;

function TIpiTrib.GetCST: String;
begin
   result := '50';
end;

function TIpiTrib.GetValor: Real;
begin
   result := arredonda(((self.BaseCalculo * self.FAliquota) / 100),3);
end;

procedure TIpiTrib.SetAliquota(const Value: Real);
begin
  FAliquota := Value;
end;

procedure TIpiTrib.SetValor(const Value: Real);
begin
  FValor := value;
end;

end.
