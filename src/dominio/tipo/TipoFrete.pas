unit TipoFrete;

interface
               // Single Chip             Free on board
               // Por conta do emitente   Por conta do destinatário
type           // Calcula na N.F.         Não calcula na N.F.
  TTipoFrete = (tfCIF=0,                    tfFOB=1);

type
  TTipoFreteUtilitario = class

  public
    class function DeEnumeradoParaInteiro(TipoFrete :TTipoFrete) :Integer;
    class function DeInteiroParaEnumerado(TipoFrete :Integer) :TTipoFrete;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoFreteUtilitario }

class function TTipoFreteUtilitario.DeEnumeradoParaInteiro(
  TipoFrete: TTipoFrete): Integer;
begin
   if      (TipoFrete = tfCIF) then result := 0
   else if (TipoFrete = tfFOB) then result := 1
   else
    raise TExcecaoParametroInvalido.Create('TTipoFreteUtilitario', 'DeEnumeradoParaInteiro', 'TipoFrete :TTipoFrete');
end;

class function TTipoFreteUtilitario.DeInteiroParaEnumerado(
  TipoFrete: Integer): TTipoFrete;
begin
   case TipoFrete of
     0: result := tfCIF;
     1: result := tfFOB;
   else raise TExcecaoParametroInvalido.Create('TTipoFreteUtilitario', 'DeInteiroParaEnumerado', 'TipoFrete :TTipoFrete');
   end;
end;

end.
