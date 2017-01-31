unit Cliente;

interface

uses Pessoa;

type
  TCliente = class(TPessoa)

  public
    constructor create;
  end;

implementation

{ TCliente }

constructor TCliente.create;
begin
  inherited Create;
  inherited tipo := 'C';
end;

end.
