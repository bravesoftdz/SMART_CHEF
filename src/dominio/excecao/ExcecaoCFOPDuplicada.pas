unit ExcecaoCFOPDuplicada;

interface

uses
  SysUtils;

type
  TExcecaoCFOPDuplicada = class(Exception)

  public
    constructor Create;
end;

implementation

{ TExcecaoCFOPDuplicada }

constructor TExcecaoCFOPDuplicada.Create;
begin
   inherited Create('CFOP j� est� cadastrada para outra natureza de opera��o! Verifique.');
end;

end.
