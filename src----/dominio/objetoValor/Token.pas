unit Token;

interface

type
  TToken = class

  private
    FCodigoSeguranca: String;
    FID: String;
    procedure SetCodigoSeguranca(const Value: String);
    procedure setID(const Value: String);

  public
    property ID :String read FID write setID;
    property CodigoSeguranca :String read FCodigoSeguranca write SetCodigoSeguranca;
end;

implementation

{ TToken }

{ TToken }

procedure TToken.SetCodigoSeguranca(const Value: String);
begin
  FCodigoSeguranca := Value;
end;

procedure TToken.setID(const Value: String);
begin
  FID := Value;
end;

end.
