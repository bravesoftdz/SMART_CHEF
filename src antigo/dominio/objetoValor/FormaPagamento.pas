unit FormaPagamento;

interface

type
  TFormaPagamento = class

  private
    FDescricao: String;

  private
    procedure SetDescricao(const Value: String);

  public
    property Descricao :String read FDescricao write SetDescricao;
end;

implementation

{ TFormaPagamento }

procedure TFormaPagamento.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
