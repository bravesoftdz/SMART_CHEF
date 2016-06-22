unit ExcecaoBancoDeBackupInvalido;

interface

uses
  ExcecaoBancoInvalido,
  TipoBanco;

type
  TExcecaoBancoDeBackupInvalido = class(TExcecaoBancoInvalido)

  public
    constructor Create;

end;

implementation

{ TExcecaoBancoDeBackupInvalido }

constructor TExcecaoBancoDeBackupInvalido.Create;
begin
   inherited Create(tbBancoDeBackup);
end;

end.
