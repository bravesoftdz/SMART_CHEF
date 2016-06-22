unit Especificacao;

interface

type
  TEspecificacao = class

  public
    function SatisfeitoPor(Objeto :TObject) :Boolean; virtual;
end;

implementation

uses
  ExcecaoMetodoNaoImplementado;

{ TEspecificacao }

function TEspecificacao.SatisfeitoPor(Objeto: TObject): Boolean;
begin
   raise TExcecaoMetodoNaoImplementado.Create(self.ClassName, 'SatisfeitoPor(Objeto: TObject): Boolean;');
end;

end.
