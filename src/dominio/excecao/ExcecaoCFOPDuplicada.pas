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
   inherited Create('CFOP já está cadastrada para outra natureza de operação! Verifique.');
end;

end.
