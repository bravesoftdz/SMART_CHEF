unit EspecificacaoItensDaNotaFiscal;

interface

uses
  Especificacao,
  NotaFiscal;

type
  TEspecificacaoItensDaNotaFiscal = class(TEspecificacao)

  private
    FCodigoNotaFiscal :Integer;

  public
    constructor Create(NotaFiscal :TNotaFiscal);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses
  ExcecaoParametroInvalido, ItemNotaFiscal;

{ TEspecificacaoItensDaNotaFiscal }

constructor TEspecificacaoItensDaNotaFiscal.Create(NotaFiscal: TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'TEspecificacaoItensDaNotaFiscal.Create(NotaFiscal: TNotaFiscal)', 'NotaFiscal');

   self.FCodigoNotaFiscal := NotaFiscal.CodigoNotaFiscal;
end;

function TEspecificacaoItensDaNotaFiscal.SatisfeitoPor(
  Objeto: TObject): Boolean;
var
  Item :TItemNotaFiscal;
begin
   Item := (Objeto as TItemNotaFiscal);

   result := (Item.CodigoNotaFiscal = self.FCodigoNotaFiscal);
end;

end.
