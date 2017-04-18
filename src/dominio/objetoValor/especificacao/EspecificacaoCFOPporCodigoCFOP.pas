unit EspecificacaoCFOPporCodigoCFOP;

interface

uses
  Especificacao;

type
  TEspecificacaoCFOPporCodigoCFOP = class(TEspecificacao)

  private
    FCodigoCFOP :String;

  public
    constructor Create(pCodigoCFOP :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses CFOP;

{ TEspecificacaoCFOPporCodigoCFOP }

constructor TEspecificacaoCFOPporCodigoCFOP.Create(pCodigoCFOP: String);
begin
  FCodigoCFOP := pCodigoCFOP;
end;

function TEspecificacaoCFOPporCodigoCFOP.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := (TCFOP(Objeto).cfop = FCodigoCFOP);
end;

end.
