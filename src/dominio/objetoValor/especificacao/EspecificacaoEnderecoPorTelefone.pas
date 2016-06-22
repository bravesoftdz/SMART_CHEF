unit EspecificacaoEnderecoPorTelefone;

interface

uses
  Especificacao;

type
  TEspecificacaoEnderecoPorTelefone = class(TEspecificacao)

  private
    FFone :String;

  public
    constructor Create(Fone :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Endereco;

{ TEspecificacaoClientePorTelefone }

constructor TEspecificacaoEnderecoPorTelefone.Create(Fone: String);
begin
  FFone := fone;
end;

function TEspecificacaoEnderecoPorTelefone.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TEndereco(Objeto).fone = FFone;
end;

end.
