unit CertificadoNFCE;

interface

type
  TCertificado = class

  private
    FSenha :String;
    FNumeroSerie: String;
    procedure SetNumeroSerie(const Value: String);

  public
    property NumeroSerie :String read FNumeroSerie write SetNumeroSerie;
    property Senha :String read FSenha write SetNumeroSerie;
end;

implementation

{ TCertificado }

{ TCertificado }

procedure TCertificado.SetNumeroSerie(const Value: String);
begin
  FSenha := Value;
end;

end.
