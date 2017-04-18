unit EspecificacaoEmpresaPorCodigoPessoa;

interface

uses
  Especificacao;

type
  TEspecificacaoEmpresaPorCodigoPessoa = class(TEspecificacao)

  private
    FCodigoPessoa :Integer;

  public
    constructor Create(CodigoPessoa :Integer);

  public
    function SatisfeitoPor(Empresa :TObject) :Boolean; override;
end;

implementation

uses
  ExcecaoParametroInvalido, Empresa, Pessoa;

{ TEspecificacaoEmpresaPorCodigoPessoa }

constructor TEspecificacaoEmpresaPorCodigoPessoa.Create(
  CodigoPessoa: Integer);
begin
   if (CodigoPessoa <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(CodigoPessoa: Integer)', 'CodigoPessoa');

   self.FCodigoPessoa := CodigoPessoa;
end;

function TEspecificacaoEmpresaPorCodigoPessoa.SatisfeitoPor(
  Empresa: TObject): Boolean;
var
  E :TEmpresa;
begin
   E := (Empresa as TEmpresa);

   result := (E.Codigo = self.FCodigoPessoa);
end;

end.
