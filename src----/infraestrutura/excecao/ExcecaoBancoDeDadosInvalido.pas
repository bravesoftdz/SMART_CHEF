unit ExcecaoBancoDeDadosInvalido;

interface

uses
  ExcecaoBancoInvalido,
  TipoBanco;

type
  TExcecaoBancoDeDadosInvalido = class(TExcecaoBancoInvalido)

  public
    constructor Create;

end;

implementation

{ TExcecaoBancoDeDadosInvalido }

constructor TExcecaoBancoDeDadosInvalido.Create;
begin
   inherited Create(tbBancoDeDados);
end;

end.
