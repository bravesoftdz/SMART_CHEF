unit CofinsAliq;

interface

type
  TCofinsAliq = class

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
    property CST         :String   read GetCST;
    property Aliquota    :Real     read FAliquota write SetAliquota;
    property Valor       :Real     read GetValor  write SetValor;
    property BaseCalculo    :Real   read FBaseCalculo  write FBaseCalculo;
end;

implementation

uses
  ExcecaoParametroInvalido, Funcoes;

{ TCofinsAliq }

constructor TCofinsAliq.Create(Aliquota, pBaseCalculo :Real; pCodigoItem :integer);
begin
   self.Create(Aliquota);
   self.FCodigoItem  := pCodigoItem;
   self.FBaseCalculo := pBaseCalculo;
end;

constructor TCofinsAliq.Create(Aliquota: Real);
begin
   if (Aliquota < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(Aliquota: Real)', 'Aliquota');

   self.FAliquota    := Aliquota;
end;

function TCofinsAliq.GetCST: String;
begin
   result := '01';
end;

function TCofinsAliq.GetValor: Real;
begin
   result := arredonda(((self.BaseCalculo * self.FAliquota) / 100));
end;

procedure TCofinsAliq.SetAliquota(const Value: Real);
begin
  FAliquota := Value;
end;

procedure TCofinsAliq.SetValor(const Value: Real);
begin
  FValor := Value;
end;

end.
