unit EspecificacaoUsuarioComLoginIgualA;

interface

uses
  Especificacao;

type
  TEspecificacaoUsuarioComLoginIgualA = class(TEspecificacao)

  private
    FLogin :String;

  public
    constructor Create(Login :String);

  public
    function SatisfeitoPor(Usuario :TObject) :Boolean; override;
end;

implementation

uses
  Usuario,
  SysUtils;

{ TEspecificacaoUsuarioComLoginIgualA }

constructor TEspecificacaoUsuarioComLoginIgualA.Create(Login: String);
begin
   self.FLogin := Login;
end;

function TEspecificacaoUsuarioComLoginIgualA.SatisfeitoPor(Usuario: TObject): Boolean;
begin
   result := (Trim(TUsuario(Usuario).Login) = Trim(self.FLogin));
end;

end.
