unit Perfil;

interface

type
  TPerfil = class

  private
    FCodigo :Integer;
    FAcesso :String;
    FNome   :String;

  public
    property Codigo :Integer read FCodigo write FCodigo;
    property Nome   :String  read FNome   write FNome;
    property Acesso :String  read FAcesso write FAcesso;
  end;

implementation

uses
  SysUtils;

{ TPerfil }

end.
