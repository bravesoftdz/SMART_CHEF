unit ExcecaoSistemaEmManutencao;

interface

uses
  SysUtils;

type
  TExcecaoSistemaEmManutencao = class(Exception)

  public
    constructor Create;

end;

implementation

{ TExcecaoSistemaEmManutencao }

constructor TExcecaoSistemaEmManutencao.Create;
begin
   inherited Create('ATEN��O!'+#13+'O sistema encontra-se em manuten��o. O sistema ser� fechado!');
end;

end.
