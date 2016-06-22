unit ExcecaoScriptDeAtualizacaoInvalido;

interface

uses
  SysUtils;

type
  TExcecaoScriptDeAtualizacaoInvalido = class(Exception)

  public
    constructor Create(const Versao :Integer; const SQL :String);
end;

implementation

{ TExcecaoScriptDeAtualizacaoInvalido }

constructor TExcecaoScriptDeAtualizacaoInvalido.Create(
  const Versao: Integer; const SQL: String);
begin
   inherited Create('Erro ao executar versão ' + IntToStr(Versao) + #13+#13 + ' Erro: '+SQL);
end;

end.
