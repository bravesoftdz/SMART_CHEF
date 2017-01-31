unit EspecificacaoEnderecosDoCliente;

interface

uses
  Especificacao;

type
  TEspecificacaoEnderecosDoCliente = class(TEspecificacao)

  private
    FCodigo_cliente :Integer;

  public
    constructor Create(Codigo_cliente :Integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Endereco;

{ TEspecificacaoEnderecosDoCliente }

constructor TEspecificacaoEnderecosDoCliente.Create(Codigo_cliente: Integer);
begin
  self.FCodigo_cliente := Codigo_cliente;
end;

function TEspecificacaoEnderecosDoCliente.SatisfeitoPor(Objeto: TObject): Boolean;
var Endereco :TEndereco;
begin
  Endereco := TEndereco(Objeto);

  result := Endereco.codigo_pessoa = self.FCodigo_cliente;
end;

end.
