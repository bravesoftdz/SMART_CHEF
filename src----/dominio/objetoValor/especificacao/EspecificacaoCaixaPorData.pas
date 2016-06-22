unit EspecificacaoCaixaPorData;

interface

uses
  Especificacao, Dialogs;

type
  TEspecificacaoCaixaPorData = class(TEspecificacao)

  private
    FData :TDateTime;
    FA_F  :String;

  public
    constructor Create(Data :TDateTime; const A_F :String = 'A');

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Caixa, SysUtils;

{ TEspecificacaoCaixaPorData }

constructor TEspecificacaoCaixaPorData.Create(Data: TDateTime; const A_F :String);
begin
  self.FData := Data;
  FA_F       := A_F;
end;

function TEspecificacaoCaixaPorData.SatisfeitoPor(Objeto: TObject): Boolean;
var Caixa :TCaixa;
begin
  Caixa := (Objeto as TCaixa);

  if self.FA_F = 'A' then
    result := ( FormatDateTime('dd/mm/yyyy', Caixa.data_abertura) = DateToStr(self.FData) )
  else
    result := ( FormatDateTime('dd/mm/yyyy',Caixa.data_fechamento) = DateToStr(self.FData) );

end;

end.
