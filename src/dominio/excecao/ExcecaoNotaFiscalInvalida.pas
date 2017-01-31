unit ExcecaoNotaFiscalInvalida;

interface

uses
  SysUtils;

type
  TExcecaoNotaFiscalInvalida = class(Exception)

  public
    constructor Create(const Mensagem :String);

end;

implementation

{ TExcecaoNotaFiscalInvalida }

constructor TExcecaoNotaFiscalInvalida.Create(const Mensagem :String);
begin
   inherited Create(Mensagem);
end;

end.
