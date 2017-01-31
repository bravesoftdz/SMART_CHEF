unit Icms20;

interface

uses
  TributacaoItemNotaFiscal,
  TipoOrigemMercadoria;

type
  TIcms20 = class(TTributacaoItemNotaFiscal)

  private
    FOrigemMercadoria   :TTipoOrigemMercadoria;
    FPercentualReducao  :Real;
    FAliquota           :Real;

  private
    function GetCST   :String;
    function GetValor :Real;

  public
    constructor Create(OrigemMercadoria :TTipoOrigemMercadoria; PercentualReducao, Aliquota :Real);

  public
    property OrigemMercadoria   :TTipoOrigemMercadoria read FOrigemMercadoria;
    property CST                :String                read GetCST;
    property PercentualReducao  :Real                  read FPercentualReducao;
    property Aliquota           :Real                  read FAliquota;
    property Valor              :Real                  read GetValor;
end;

implementation

uses
  ExcecaoParametroInvalido;


{ TIcms20 }

constructor TIcms20.Create(OrigemMercadoria :TTipoOrigemMercadoria; PercentualReducao, Aliquota :Real);
begin
   if (PercentualReducao <= 0) then
     raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(PercentualReducao, Aliquota :Real)', 'PercentualReducao');

   if (Aliquota <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(PercentualReducao, Aliquota :Real)', 'Aliquota');

   self.FOrigemMercadoria  := OrigemMercadoria;
   self.FPercentualReducao := PercentualReducao;
   self.FAliquota          := Aliquota;
end;

function TIcms20.GetCST: String;
begin
   result := '20';
end;

function TIcms20.GetValor: Real;
var
  NovaBaseCalculo :Real;
begin
   // Primeiro faço a redução de base de cálculo
   NovaBaseCalculo := self.BaseCalculo - ((self.BaseCalculo * self.FPercentualReducao) / 100);

   // Agora calculo o valor do ICMS
   result := ((NovaBaseCalculo * self.FAliquota) / 100);
end;

end.
