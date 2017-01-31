unit IcmsSn101;

interface

uses
  TributacaoItemNotaFiscal,
  TipoOrigemMercadoria;

type
  TIcmsSn101 = class

  private
    FOrigemMercadoria         :TTipoOrigemMercadoria;
    FAliquotaCreditoSN        :Real;
    FValorCreditoSN           :Real;
    FBaseCalculo: Real;
    FCodigoItem: integer;

    procedure SetAliquotaCreditoSN(const Value: Real);
    procedure SetValorCreditoSN(const Value: Real);

  private
    function GetValorCreditoSN   :Real;
    function GetCSOSN            :String;

  public
    constructor Create(OrigemMercadoria :TTipoOrigemMercadoria; AliquotaCreditoSN :Real);overload;
    constructor Create(OrigemMercadoria :TTipoOrigemMercadoria; AliquotaCreditoSN, pBaseCalculo :Real; pCodigoItem :integer);overload;

  public
    property CodigoItem        :integer               read FCodigoItem        write FCodigoItem;
    property OrigemMercadoria  :TTipoOrigemMercadoria read FOrigemMercadoria;
    property AliquotaCreditoSN :Real                  read FAliquotaCreditoSN  write SetAliquotaCreditoSN;

    // Esse valor aqui não é destacado no total da NF
    property ValorCreditoSN   :Real       read GetValorCreditoSN    write SetValorCreditoSN;
    property CSOSN            :String     read GetCSOSN;
    property BaseCalculo      :Real       read FBaseCalculo         write FBaseCalculo;
end;

implementation

uses
  ExcecaoParametroInvalido,
  SysUtils;

{ TIcmsSn101 }

constructor TIcmsSn101.Create(OrigemMercadoria: TTipoOrigemMercadoria; AliquotaCreditoSN, pBaseCalculo :Real; pCodigoItem :integer);
begin
   self.Create(OrigemMercadoria, AliquotaCreditoSN);
   self.FAliquotaCreditoSN  := AliquotaCreditoSN;
   self.FCodigoItem         := pCodigoItem;
   self.FBaseCalculo        := pBaseCalculo;
end;

constructor TIcmsSn101.Create(OrigemMercadoria: TTipoOrigemMercadoria; AliquotaCreditoSN: Real);
begin
{   if (AliquotaCreditoSN <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                           'Create(OrigemMercadoria: TTipoOrigemMercadoria; AliquotaCreditoSN: Real)',
                                           'AliquotaCreditoSN');  fabricio}

   self.FOrigemMercadoria   := OrigemMercadoria;
end;

function TIcmsSn101.GetCSOSN: String;
begin
   result := '101';
end;

function TIcmsSn101.GetValorCreditoSN: Real;
begin
   result := ((self.BaseCalculo * self.AliquotaCreditoSN) / 100);
end;

procedure TIcmsSn101.SetAliquotaCreditoSN(const Value: Real);
begin
  FAliquotaCreditoSN := Value;
end;

procedure TIcmsSn101.SetValorCreditoSN(const Value: Real);
begin
  FValorCreditoSN := Value;
end;

end.
