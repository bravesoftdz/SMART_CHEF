unit EspecificacaoNFePorNrNota;

interface

uses
  Especificacao, SysUtils;

type
  TEspecificacaoNFePorNrNota = class(TEspecificacao)

  private
    FNrNota :integer;

  public
    constructor Create(nrNota :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses NotaFiscal;

{ TEspecificacaoNFePorNrNota }

constructor TEspecificacaoNFePorNrNota.Create(nrNota: integer);
begin
  FNrNota := nrNota;
end;

function TEspecificacaoNFePorNrNota.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TNotaFiscal(Objeto).NumeroNotaFiscal = FNrNota;
end;

end.
