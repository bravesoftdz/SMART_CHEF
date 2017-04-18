unit EspecificacaoCFOPporTipo;

interface

uses
  TipoNaturezaOperacao,
  Especificacao;

type
  TEspecificacaoCFOPporTipo = class(TEspecificacao)

  private
    FTipo :TTipoNaturezaOperacao;

  public
    constructor Create(TipoNatureza :TTipoNaturezaOperacao);

  public
    function SatisfeitoPor(pCFOP :TObject) :Boolean; override;
end;

implementation

uses
  CFOP,
  SysUtils;

{ TEspecificacaoCFOPporTipo }

constructor TEspecificacaoCFOPporTipo.Create(TipoNatureza: TTipoNaturezaOperacao);
begin
   self.FTipo := TipoNatureza;
end;

function TEspecificacaoCFOPporTipo.SatisfeitoPor(pCFOP: TObject): Boolean;
var
  CFOP :TCFOP;
begin
   try
     CFOP := (pCFOP as TCFOP);
   except
     on E: EInvalidCast do
      raise EInvalidCast.Create('Erro em TEspecificacaoNaturezaPorTipo.SatisfeitoPor(Natureza: TObject): Boolean; '+
                                'O parâmetro passado não é do tipo TNaturezaOperacao. Entre em contato com o suporte!');
   end;

   result := (self.FTipo = CFOP.Tipo);
end;

end.
