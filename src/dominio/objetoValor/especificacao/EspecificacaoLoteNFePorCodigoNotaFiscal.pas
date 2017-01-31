unit EspecificacaoLoteNFePorCodigoNotaFiscal;

interface

uses
  Especificacao;

type
  TEspecificacaoLoteNFePorCodigoNotaFiscal = class(TEspecificacao)

  private
    FCodigoNotaFiscal :Integer;

  public
    constructor Create(const CodigoNotaFiscal :Integer);

  public
    function SatisfeitoPor(LoteNFe :TObject) :Boolean; override;
end;

implementation

uses
  ExcecaoParametroInvalido, LoteNFe;

{ TEspecificacaoLoteNFePorCodigoNotaFiscal }

constructor TEspecificacaoLoteNFePorCodigoNotaFiscal.Create(const CodigoNotaFiscal: Integer);
begin
   if (CodigoNotaFiscal <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'Create(const CodigoNotaFiscal: Integer)', 'CodigoNotaFiscal');

   self.FCodigoNotaFiscal := CodigoNotaFiscal;
end;

function TEspecificacaoLoteNFePorCodigoNotaFiscal.SatisfeitoPor(
  LoteNFe: TObject): Boolean;
var
  L :TLoteNFe;
begin
   L := (LoteNFe as TLoteNFe);

   result := (L.CodigoNotaFiscal = self.FCodigoNotaFiscal);
end;

end.
