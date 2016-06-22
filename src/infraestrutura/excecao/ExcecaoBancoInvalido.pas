unit ExcecaoBancoInvalido;

interface

uses
  SysUtils,
  TipoBanco;

type
  TExcecaoBancoInvalido = class(Exception)

  private
    FTipoBanco :TTipoBanco;

  public
    constructor Create(TipoBanco :TTipoBanco);

  public
    property TipoBanco :TTipoBanco read FTipoBanco;
end;

implementation

{ TExcecaoBancoInvalido }

constructor TExcecaoBancoInvalido.Create(TipoBanco: TTipoBanco);
const
  CORPO = 'Não foi possível conectar ao banco ';
var
  Mensagem :String;
begin
   if (TipoBanco = tbBancoDeDados) then Mensagem := CORPO + 'de dados'
   else                                 Mensagem := CORPO + 'de backup';

   inherited Create(Mensagem);

   self.FTipoBanco := TipoBanco;
end;

end.
