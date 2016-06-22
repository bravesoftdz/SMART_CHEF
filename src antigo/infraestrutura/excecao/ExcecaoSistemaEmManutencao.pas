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
   inherited Create('ATENÇÃO!'+#13+'O sistema encontra-se em manutenção. O sistema será fechado!');
end;

end.
