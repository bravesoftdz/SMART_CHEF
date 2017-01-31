unit Icms00;

interface

uses
  TributacaoItemNotaFiscal,
  TipoOrigemMercadoria;

type
  TIcms00 = class

  private
    FOrigemMercadoria   :TTipoOrigemMercadoria;
    FCodigoItem         :integer;
    FAliquota           :Real;
    FValor              :Real;
    FPercReducaoBC      :Real;
    FBaseCalculo: Real;
    procedure SetAliquota(const Value: Real);
    procedure SetValor(const Value: Real);

  private
    function GetCST   :String;
    function GetValor :Real;
    function GetBaseCalculo: Real;

  public
    constructor Create(OrigemMercadoria :TTipoOrigemMercadoria; Aliquota, PercReducaoBC : Real);overload;
    constructor Create(OrigemMercadoria :TTipoOrigemMercadoria; Aliquota, PercReducaoBC, pBaseCalculo: Real; pcodigoItem :integer);overload;

  public
    property OrigemMercadoria   :TTipoOrigemMercadoria read FOrigemMercadoria;
    property codigoItem         :integer               read FCodigoItem        write FCodigoItem;
    property CST                :String                read GetCST;
    property Aliquota           :Real                  read FAliquota          write SetAliquota;
    property PercReducaoBC      :Real                  read FPercReducaoBC     write FPercReducaoBC;
    property Valor              :Real                  read GetValor           write SetValor;
    property BaseDeCalculo      :Real                  read GetBaseCalculo     write FBaseCalculo;
end;

implementation

uses
  ExcecaoParametroInvalido, Funcoes;

{ TIcms00 }

constructor TIcms00.Create(OrigemMercadoria: TTipoOrigemMercadoria;
  Aliquota, PercReducaoBC, pBaseCalculo: Real; pCodigoItem :integer);
begin
   self.Create(OrigemMercadoria, Aliquota, PercReducaoBC);
   self.FCodigoItem        := pCodigoItem;
   self.FBaseCalculo       := pBaseCalculo;
end;

constructor TIcms00.Create(OrigemMercadoria: TTipoOrigemMercadoria; Aliquota, PercReducaoBC: Real);
begin
   if (Aliquota < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(Aliquota :Real)', 'Aliquota');

   self.FOrigemMercadoria  := OrigemMercadoria;
   self.FAliquota          := Aliquota;
   self.FPercReducaoBC     := PercReducaoBC;
end;

function TIcms00.GetBaseCalculo: Real;
begin
  if FPercReducaoBC > 0 then
    Result := FBaseCalculo - ((FPercReducaoBC * FBaseCalculo)/100);
end;

function TIcms00.GetCST: String;
begin
   result := '00';
end;

function TIcms00.GetValor: Real;
begin
   result := ((self.BaseDeCalculo * self.FAliquota) / 100);
end;

procedure TIcms00.SetAliquota(const Value: Real);
begin
  FAliquota := Value;
end;

procedure TIcms00.SetValor(const Value: Real);
begin
  FValor := Value;
end;

end.
