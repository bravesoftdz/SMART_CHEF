unit Fornecedor;

interface

uses Pessoa;

type
  TFornecedor = class(TPessoa)

  public
    constructor create;
  end;

implementation

{ TCliente }

constructor TFornecedor.create;
begin
  inherited Create;
  inherited tipo := 'F';
end;

end.
