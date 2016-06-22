unit Endereco;

interface

uses SysUtils, Contnrs;

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
    FCidade :String;
    Ffone :String;

  private
    function GetCidade: String;

  public
    property codigo           :Integer read Fcodigo         write Fcodigo;
    property codigo_cliente   :Integer read Fcodigo_cliente write Fcodigo_cliente;
    property cep              :String  read Fcep            write Fcep;
    property logradouro       :String  read Flogradouro     write Flogradouro;
    property numero           :String  read Fnumero         write Fnumero;
    property referencia       :String  read Freferencia     write Freferencia;
    property bairro           :String  read Fbairro         write Fbairro;
    property codigo_cidade    :Integer read Fcodigo_cidade  write Fcodigo_cidade;
    property uf               :String  read Fuf             write Fuf;
    property fone             :String  read Ffone           write Ffone;

  public
    property cidade                :String read GetCidade        write FCidade;
end;

implementation

uses Funcoes;

{ TEndereco }

function TEndereco.GetCidade: String;
begin
  result := campo_por_campo('CIDADES', 'NOME', 'CODIBGE', intToStr(codigo_cidade));
end;

end.
