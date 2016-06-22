unit ExcecaoRepositorioNaoEncontrado;

interface

uses
  SysUtils;

type
  TExcecaoRepositorioNaoEncontrado = class(Exception)

  public
    constructor Create(NomeDaEntidade :String);

end;

implementation

{ TExcecaoRepositorioNaoEncontrado }

constructor TExcecaoRepositorioNaoEncontrado.Create(NomeDaEntidade :String);
begin
   inherited Create('Repositório para a '+ NomeDaEntidade + ' não foi encontrado!');
end;

end.
