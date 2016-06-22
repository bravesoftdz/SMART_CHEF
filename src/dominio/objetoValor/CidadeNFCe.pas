unit CidadeNFCe;

interface

type
  TCidade = class

  private
    FCodigoIBGE: Integer;
    FNome: String;
    FUF: String;

  private
    procedure SetCodigoIBGE(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetUF(const Value: String);

  public
    property UF :String read FUF write SetUF;
    property CodigoIBGE :Integer read FCodigoIBGE write SetCodigoIBGE;
    property Nome :String read FNome write SetNome;

end;

implementation

{ TCidade }

procedure TCidade.SetCodigoIBGE(const Value: Integer);
begin
  FCodigoIBGE := Value;
end;

procedure TCidade.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCidade.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
