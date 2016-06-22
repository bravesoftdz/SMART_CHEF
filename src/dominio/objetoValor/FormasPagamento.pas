unit FormasPagamento;

interface

uses
  FormaPagamento;

type
  TFormasPagamento = class

  private
    FDinheiro: TFormaPagamento;

  public
    constructor Create;

  public
    property Dinheiro :TFormaPagamento read FDinheiro;
end;

implementation

uses
  SysUtils;

{ TFormasPagamento }

constructor TFormasPagamento.Create;
begin
   FDinheiro := TFormaPagamento.Create;
end;

end.
