unit Departamento;

interface

uses SysUtils, Contnrs;

type
  TDepartamento = class

  private
    Fcodigo :integer;
    Fnome   :String;
    Fporta_lpt :String;

  public
    property codigo       :Integer read Fcodigo     write Fcodigo;
    property nome         :String  read Fnome       write Fnome;
end;

implementation

{ TDepartamento }

end.
