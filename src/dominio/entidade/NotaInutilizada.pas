unit NotaInutilizada;

interface

uses SysUtils, Contnrs;

type
  TNotaInutilizada = class

  private
    Fcodigo :Integer;
    Fmodelo :String;
    Fserie :String;
    Finicio :Integer;
    Ffim :Integer;
    Fjustificativa :String;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property modelo                :String read Fmodelo                write Fmodelo;
    property serie                 :String read Fserie                 write Fserie;
    property inicio                :Integer read Finicio                write Finicio;
    property fim                   :Integer read Ffim                   write Ffim;
    property justificativa         :String read Fjustificativa         write Fjustificativa;
end;

implementation

{ TNotaInutilizada }

end.
