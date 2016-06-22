unit ExcecaoParametroInvalido;

interface

uses
  SysUtils;

type
  TExcecaoParametroInvalido = class(Exception)

  private
    FNomeDaClasse     :String;
    FNomeDoMetodo     :String;
    FNomeDoParametro  :String;
    function GetNomeDaClasse: String;
    function GetNomeDoMetodo: String;
    function GetNomeDoParametro: String;

  public
    constructor Create(NomeDaClasse, NomeDoMetodo, NomeDoParametro :String); 

  public
    property NomeDaClasse     :String read GetNomeDaClasse;
    property NomeDoMetodo     :String read GetNomeDoMetodo;
    property NomeDoParametro  :String read GetNomeDoParametro;
end;

implementation

{ TExcecaoParametroInvalido }

constructor TExcecaoParametroInvalido.Create(NomeDaClasse, NomeDoMetodo,
  NomeDoParametro: String);
begin
   inherited Create('O parâmetro '+NomeDoParametro+' passado para o método '+NomeDoMetodo+' na classe '+NomeDaClasse+
                    #13+'Está inválido!');

   self.FNomeDaClasse     := NomeDaClasse;
   self.FNomeDoMetodo     := NomeDoMetodo;
   self.FNomeDoParametro  := NomeDoParametro;
end;

function TExcecaoParametroInvalido.GetNomeDaClasse: String;
begin
   result := self.FNomeDaClasse;
end;

function TExcecaoParametroInvalido.GetNomeDoMetodo: String;
begin
   result := self.FNomeDoMetodo;
end;

function TExcecaoParametroInvalido.GetNomeDoParametro: String;
begin
   result := self.FNomeDoParametro;
end;

end.
