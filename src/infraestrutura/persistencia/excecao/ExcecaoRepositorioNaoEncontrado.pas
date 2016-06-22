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
   inherited Create('Reposit�rio para a '+ NomeDaEntidade + ' n�o foi encontrado!');
end;

end.
