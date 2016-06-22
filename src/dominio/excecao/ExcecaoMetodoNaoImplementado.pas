unit ExcecaoMetodoNaoImplementado;

interface

uses
  SysUtils;

type
  TExcecaoMetodoNaoImplementado = class(Exception)

  public
    constructor Create(NomeDaClasse :String; NomeDoMetodo :String);
end;

implementation

{ TExcecaoMetodoNaoImplementado }

constructor TExcecaoMetodoNaoImplementado.Create(NomeDaClasse,
  NomeDoMetodo: String);
begin
   inherited Create('O método '+NomeDoMetodo+' da classe '+NomeDaClasse+' não foi implementado!');
end;

end.
