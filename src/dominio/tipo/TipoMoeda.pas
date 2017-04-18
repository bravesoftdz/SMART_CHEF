unit TipoMoeda;

interface

type
  TTipoMoeda = (tmDinheiro = 1, tmCheque = 2, tmCartaoCredito=3, tmCartaoDebito=4);

type
  TTipoMoedaUtilitario = class

  public
    class function DeEnumeradoParaInteiro(TipoMoeda :TTipoMoeda) :Integer;
    class function DeInteiroParaEnumerado(TipoMoeda :Integer) :TTipoMoeda;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoMoedaUtilitario }

class function TTipoMoedaUtilitario.DeEnumeradoParaInteiro(TipoMoeda: TTipoMoeda): Integer;
begin
   if      (TipoMoeda = tmDinheiro)      then result := 1
   else if (TipoMoeda = tmCheque)        then result := 2
   else if (TipoMoeda = tmCartaoCredito) then result := 3
   else if (TipoMoeda = tmCartaoDebito)  then result := 4
   else
    raise TExcecaoParametroInvalido.Create('TTipoMoedaUtilitario', 'DeEnumeradoParaInteiro', 'TipoMoeda :TTipoMoeda');
end;

class function TTipoMoedaUtilitario.DeInteiroParaEnumerado(TipoMoeda: Integer): TTipoMoeda;
begin
   case TipoMoeda of
     1: result := tmDinheiro;
     2: result := tmCheque;
     3: result := tmCartaoCredito;
     4: result := tmCartaoDebito;
     else
       raise TExcecaoParametroInvalido.Create('TTipoFreteUtilitario', 'DeInteiroParaEnumerado', 'TipoFrete :TTipoFrete');
   end;
end;

end.
