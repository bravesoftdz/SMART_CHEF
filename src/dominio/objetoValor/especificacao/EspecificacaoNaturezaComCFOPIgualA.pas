unit EspecificacaoNaturezaComCFOPIgualA;

interface

uses
  Especificacao;

type
  TEspecificacaoNaturezaComCFOPIgualA = class(TEspecificacao)

  private
    FCFOP :String;

  public
    constructor Create(CFOP :String);

  public
    function SatisfeitoPor(Natureza :TObject) :Boolean; override;
end;

implementation

uses
  NaturezaOperacao;

{ TEspecificacaoDiretorioBackupComUsuarioIgualA }

constructor TEspecificacaoNaturezaComCFOPIgualA.Create(CFOP :String);
begin
   self.FCFOP := CFOP;
end;

function TEspecificacaoNaturezaComCFOPIgualA.SatisfeitoPor(
  Natureza: TObject): Boolean;
begin
   result := (self.FCFOP = TNaturezaOperacao(Natureza).CFOP);
end;

end.
