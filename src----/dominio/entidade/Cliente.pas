unit Cliente;

interface

uses SysUtils, Contnrs;

type
  TCliente = class

  private
    Fcodigo :Integer;
    Fnome :String;
    Fcpf_cnpj :String;
    Ffone :String;
    Fcep :String;
    Flogradouro :String;
    Fnumero :String;
    Fcomplemento :String;
    Fbairro :String;
    Fcodigo_cidade :Integer;
    Fuf :String;
    FEnderecos :TObjectList;
    function GetObjectList: TObjectList;

  public
    property codigo     :Integer read Fcodigo     write Fcodigo;
    property nome       :String  read Fnome       write Fnome;
    property cpf_cnpj   :String  read Fcpf_cnpj   write Fcpf_cnpj;

  public
    property Enderecos  :TObjectList read GetObjectList;  
end;

implementation

uses repositorio, fabricarepositorio, EspecificacaoEnderecosDoCliente, Endereco;

{ TCliente }

function TCliente.GetObjectList: TObjectList;
var repositorio   :TRepositorio;
    especificacao :TEspecificacaoEnderecosDoCliente;
begin
  if not assigned(FEnderecos) or (FEnderecos.count <= 0) then begin
    try
      repositorio   := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
      especificacao := TEspecificacaoEnderecosDoCliente.Create(self.codigo);
      FEnderecos    := repositorio.GetListaPorEspecificacao(especificacao);

    Finally
      FreeAndNil(especificacao);
      FreeAndNil(repositorio);
    end;
  end;

  result := FEnderecos;

end;

end.
