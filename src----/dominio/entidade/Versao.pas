unit Versao;

interface

type
  TVersao = class

  private
    FVersaoBancoDeDados :Integer;
    FCodigo             :Integer;
    
  private
    procedure SetCodigo             (const Value: Integer);
    procedure SetVersaoBancoDeDados (const Value: Integer);

  public
    property Codigo              :Integer read FCodigo              write SetCodigo;
    property VersaoBancoDeDados  :Integer read FVersaoBancoDeDados  write SetVersaoBancoDeDados;
end;

implementation

{ TVersao }

procedure TVersao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TVersao.SetVersaoBancoDeDados(const Value: Integer);
begin
  FVersaoBancoDeDados := Value;
end;

end.
