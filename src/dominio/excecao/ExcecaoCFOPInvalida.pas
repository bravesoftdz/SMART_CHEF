unit ExcecaoCFOPInvalida;

interface

uses
  SysUtils;

type
  TExcecaoCFOPInvalida = class(Exception)

  public
    constructor Create;

end;

implementation

{ TExcecaoCFOPInvalida }

constructor TExcecaoCFOPInvalida.Create;
begin
   inherited Create('CFOP inv�lida! Verifique.');
end;

end.
