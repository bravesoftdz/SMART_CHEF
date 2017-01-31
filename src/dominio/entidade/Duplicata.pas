unit Duplicata;

interface

type
  TDuplicata = class

  private
    FNumeroDuplicata :String;
    FDataVencimento  :TDateTime;
    FValorDuplicata  :Real;

  private
    function GetDataVencimento  :TDateTime;
    function GetNumeroDuplicata :String;
    function GetValorDuplicata  :Real;

  public
    constructor Create(NumeroDuplicata :String;
                       DataVencimento  :TDateTime;
                       ValorDuplicata  :Real);

  public
    property NumeroDuplicata :String    read GetNumeroDuplicata;
    property DataVencimento  :TDateTime read GetDataVencimento;
    property ValorDuplicata  :Real      read GetValorDuplicata;
end;

implementation

uses
  StringUtilitario,
  ExcecaoParametroInvalido, SysUtils;

{ TDuplicata }

constructor TDuplicata.Create(NumeroDuplicata: String; DataVencimento: TDateTime; ValorDuplicata: Real);
const
  NOME_METODO = 'Create(NumeroDuplicata: String; DataVencimento: TDateTime; ValorDuplicata: Real)';
begin
   if TStringUtilitario.EstaVazia(NumeroDuplicata) then
     raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'NumeroDuplicata');

   if (DataVencimento <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'DataVencimento');

   if (ValorDuplicata <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'ValorDuplicata');

   self.FNumeroDuplicata := NumeroDuplicata;
   self.FDataVencimento  := DataVencimento;
   self.FValorDuplicata  := ValorDuplicata;
end;

function TDuplicata.GetDataVencimento: TDateTime;
begin
   result := self.FDataVencimento;
end;

function TDuplicata.GetNumeroDuplicata: String;
begin
   result := UpperCase(Trim(self.FNumeroDuplicata));
end;

function TDuplicata.GetValorDuplicata: Real;
begin
   result := self.FValorDuplicata;
end;

end.
