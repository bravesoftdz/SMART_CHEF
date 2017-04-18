unit Transportadora;

interface

uses Pessoa;

type
  TTransportadora = class(TPessoa)

  public
    constructor create;
  end;

implementation

{ TFornecedor }

constructor TTransportadora.create;
begin
  inherited Create;
  inherited tipo := 'T';
end;

end.
