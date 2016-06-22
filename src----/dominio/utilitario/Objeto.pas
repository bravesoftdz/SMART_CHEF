unit Objeto;

interface

type
  TObjeto = class

  public
    function Equals(Objeto :TObjeto) :Boolean; virtual; abstract;
end;

implementation

{ TObjeto }

end.
