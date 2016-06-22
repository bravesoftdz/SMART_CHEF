unit ExcecaoCampoNaoInformado;

interface

uses
  SysUtils;

type
  TExcecaoCampoNaoInformado = class(Exception)

  private
    FCampo :String;

  private
    function GetCampo: String;

  public
    constructor Create(const NomeDoCampo :String);

  public
    property Campo :String read GetCampo;

end;

implementation

{ TExcecaoCampoNaoInformado }

constructor TExcecaoCampoNaoInformado.Create(const NomeDoCampo: String);
begin
   inherited Create('Campo '+NomeDoCampo+' n�o foi informado ou est� inv�lido! Verifique.');

   self.FCampo := NomeDoCampo;
end;

function TExcecaoCampoNaoInformado.GetCampo: String;
begin
   result := self.FCampo;
end;

end.
