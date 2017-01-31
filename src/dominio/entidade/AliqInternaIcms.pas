unit AliqInternaIcms;

interface

uses SysUtils, Contnrs;

type
  TAliqInternaIcms = class

  private
    Fcodigo :Integer;
    Fcodigo_estado :Integer;
    Faliquota :Real;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_estado         :Integer read Fcodigo_estado         write Fcodigo_estado;
    property aliquota              :Real    read Faliquota              write Faliquota;
end;

implementation

{ TAliqInternaIcms }

end.
