unit EspecificacaoEnderecoComPessoaIgualA;

interface

uses
  Especificacao,
  Pessoa;

type
  TEspecificacaoEnderecoComPessoaIgualA = class(TEspecificacao)

  private
    FPessoa :TPessoa;

  public
    constructor Create(Pessoa :TPessoa);
    destructor Destroy; override;

  public
    function SatisfeitoPor(Endereco :TObject) :Boolean; override;

end;

implementation

uses Endereco;

{ TEspecificacaoEnderecoComPessoaIgualA }

constructor TEspecificacaoEnderecoComPessoaIgualA.Create(Pessoa: TPessoa);
begin
   self.FPessoa := Pessoa;
end;

destructor TEspecificacaoEnderecoComPessoaIgualA.Destroy;
begin
  self.FPessoa := nil;
  
  inherited;
end;

function TEspecificacaoEnderecoComPessoaIgualA.SatisfeitoPor(Endereco: TObject): Boolean;
begin
   result := (TEndereco(Endereco).codigo_pessoa = self.FPessoa.Codigo);
end;

end.
