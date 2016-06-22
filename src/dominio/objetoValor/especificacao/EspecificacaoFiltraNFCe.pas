unit EspecificacaoFiltraNFCe;

interface

uses
  Especificacao;

type
  TEspecificacaoFiltraNFCe = class(TEspecificacao)

  private
    FDtInicio :TDateTime;
    FDtFim    :TDateTime;
    FNr_nota  :integer;

  public
    constructor Create(DtInicio, DtFim :TDateTime; const nr_nota :integer = 0);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses NFCe;

{ TEspecificacaoFiltraNFCe }


constructor TEspecificacaoFiltraNFCe.Create(DtInicio, DtFim: TDateTime; const nr_nota :integer);
begin
  self.FDtInicio := DtInicio;
  self.FDtFim    := DtFim;
  self.FNr_nota  := nr_nota;
end;

function TEspecificacaoFiltraNFCe.SatisfeitoPor(Objeto: TObject): Boolean;
var NFCe :TNFCe;
begin
  NFCe := TNFCe(Objeto);

  result := (NFCe.dh_recebimento >= self.FDtInicio) and (NFCe.dh_recebimento <= self.FDtFim);

  if self.FNr_nota = 0 then
    Exit;

  result := (self.FNr_nota = NFCe.nr_nota);  
end;

end.
