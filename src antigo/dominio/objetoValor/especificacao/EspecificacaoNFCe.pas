unit EspecificacaoNFCe;

interface

uses
  Especificacao, SysUtils;

type
  TEspecificacaoNFCe = class(TEspecificacao)

  private
    FData_ini :TDateTime;
    FData_fim :TDateTime;

  public
    constructor Create(const Data_ini :TDateTime = 0; const Data_fim :TDateTime = 0);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses NFCe;

{ TEspecificacaoNFCe }

constructor TEspecificacaoNFCe.Create(const Data_ini, Data_fim: TDateTime);
begin
  FData_ini := Data_ini;
  FData_fim := Data_fim;
end;

function TEspecificacaoNFCe.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  if FData_ini > 0 then
    result := ((TNFce(Objeto).dh_recebimento >= FData_ini) and (TNFCe(objeto).dh_recebimento <= FData_fim))
  else
    result := true;

  if result then
    if TRIM(TNFce(Objeto).chave) = '' then
      result := false;

end;

end.
 