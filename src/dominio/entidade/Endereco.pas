unit Endereco;

interface

uses SysUtils, Contnrs, Cidade;

type
  TEndereco = class

  private
    Fcodigo :Integer;
    Fcodigo_cliente :Integer;
    Fcep :String;
    Flogradouro :String;
    Fnumero :String;
    Freferencia :String;
    Fbairro :String;
    Fcodigo_cidade :Integer;
    Fuf :String;
    FCidade :TCidade;
    Ffone :String;
    FCodigo_pessoa :integer;

  private
    function GetCidade: TCidade;

  public
    property codigo           :Integer read Fcodigo         write Fcodigo;
    property codigo_pessoa    :integer read FCodigo_pessoa  write FCodigo_pessoa;
    property cep              :String  read Fcep            write Fcep;
    property logradouro       :String  read Flogradouro     write Flogradouro;
    property numero           :String  read Fnumero         write Fnumero;
    property referencia       :String  read Freferencia     write Freferencia;
    property bairro           :String  read Fbairro         write Fbairro;
    property codigo_cidade    :Integer read Fcodigo_cidade  write Fcodigo_cidade;
    property uf               :String  read Fuf             write Fuf;
    property fone             :String  read Ffone           write Ffone;

  public
    property Cidade           :TCidade read GetCidade;
end;

implementation

uses Funcoes, repositorio, FabricaRepositorio, EspecificacaoCidadePorCodigoIBGE;

{ TEndereco }

function TEndereco.GetCidade: TCidade;
var repositorio   :TRepositorio;
    especificacao :TEspecificacaoCidadePorCodigoIBGE;
begin

  if not assigned(FCidade) then
  begin
    repositorio   := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
    especificacao := TEspecificacaoCidadePorCodigoIBGE.Create(self.codigo_cidade);
    FCidade       := TCidade(repositorio.GetPorEspecificacao(especificacao));
  end;

  result := FCidade;
end;

end.
