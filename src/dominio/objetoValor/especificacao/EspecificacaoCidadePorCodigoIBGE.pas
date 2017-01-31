unit EspecificacaoCidadePorCodigoIBGE;

interface

uses
  Especificacao;

type
  TEspecificacaoCidadePorCodigoIBGE = class(TEspecificacao)

  private
    FCodigoIBGE :Integer;

  public
    constructor Create(pCodigoIBGE :Integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses Cidade;

{ TEspecificacaoCidadePorCodigoIBGE }

constructor TEspecificacaoCidadePorCodigoIBGE.Create(pCodigoIBGE: Integer);
begin
  self.FCodigoIBGE := pCodigoIBGE;
end;

function TEspecificacaoCidadePorCodigoIBGE.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TCidade(Objeto).codibge = self.FCodigoIBGE;
end;

end.
