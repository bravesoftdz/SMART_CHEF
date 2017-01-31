unit EspecificacaoClientePorCpfCnpj;

interface

uses
  Especificacao;

type
  TEspecificacaoClientePorCpfCnpj = class(TEspecificacao)

  private
    FCpfCnpj :String;

  public
    constructor Create(CpfCnpj :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Cliente;

{ TEspecificacaoClientePorCpfCnpj }

constructor TEspecificacaoClientePorCpfCnpj.Create(CpfCnpj: String);
begin
  FCpfCnpj := CpfCnpj;
end;

function TEspecificacaoClientePorCpfCnpj.SatisfeitoPor(Objeto: TObject): Boolean;
var
  Cliente :TCliente;
begin
   Cliente := TCliente(Objeto);

   result := false;

   if FCpfCnpj = '' then
     exit;
     
   result := (Cliente.cpf_cnpj = self.FCpfCnpj);
end;

end.
