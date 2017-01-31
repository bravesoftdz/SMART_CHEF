unit Estado;

interface

uses SysUtils, Contnrs;

type
  TEstado = class

  private
    Fcodigo :Integer;
    Fsigla :String;
    Fnome :String;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property sigla                 :String read Fsigla                 write Fsigla;
    property nome                  :String read Fnome                  write Fnome;
end;

implementation

{ TEstado }

end.
