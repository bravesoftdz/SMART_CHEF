unit EspecificacaoSangriaReforcoPorCodigoCaixa;

interface

uses
  Especificacao, Dialogs;

type
  TEspecificacaoSangriaReforcoPorCodigoCaixa = class(TEspecificacao)

  private
    FCodigoCaixa :integer;

  public
    constructor Create(codigoCaixa :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses SangriaReforco;

{ TEspecificacaoSangriaReforcoPorCodigoCaixa }

constructor TEspecificacaoSangriaReforcoPorCodigoCaixa.Create(codigoCaixa: integer);
begin
  self.FCodigoCaixa := codigoCaixa;
end;

function TEspecificacaoSangriaReforcoPorCodigoCaixa.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TSangriaReforco(Objeto).codigo_caixa = self.FCodigoCaixa;
end;

end.
