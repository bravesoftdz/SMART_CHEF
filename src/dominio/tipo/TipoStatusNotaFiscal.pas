unit TipoStatusNotaFiscal;

interface

type
  TTipoStatusNotaFiscal = (snfAguardandoEnvio=0, snfAutorizada=1, snfRejeitada=2,
                           snfCancelada=3,       snfNenhum=-1);

type
  TTipoStatusNotaFiscalUtilitario = class

  public
    class function DeEnumeradoParaInteiro(TipoStatus :TTipoStatusNotaFiscal) :Integer;
    class function DeInteiroParaEnumerado(TipoStatus :Integer)               :TTipoStatusNotaFiscal;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoStatusNotaFiscalUtilitario }

class function TTipoStatusNotaFiscalUtilitario.DeEnumeradoParaInteiro(
  TipoStatus: TTipoStatusNotaFiscal): Integer;
begin
   case TipoStatus of
    snfAguardandoEnvio: result := 0;
    snfAutorizada     : result := 1;
    snfRejeitada      : result := 2;
    snfCancelada      : result := 3;
    snfNenhum         : result := -1;
   else
     raise TExcecaoParametroInvalido.Create(self.ClassName, 'DeEnumeradoParaInteiro(TipoStatus: TTipoStatusNotaFiscal): Integer;',
                                            'TipoStatus');
   end;
end;

class function TTipoStatusNotaFiscalUtilitario.DeInteiroParaEnumerado(
  TipoStatus: Integer): TTipoStatusNotaFiscal;
begin
   case TipoStatus of
    0: result := snfAguardandoEnvio;
    1: result := snfAutorizada;
    2: result := snfRejeitada;
    3: result := snfCancelada;
   -1: result := snfNenhum;
   else
     raise TExcecaoParametroInvalido.Create(self.ClassName,
                                            'TTipoStatusNotaFiscalUtilitario.DeInteiroParaEnumerado(TipoStatus: Integer): TTipoStatusNotaFiscal;',
                                            'TipoStatus');
   end;
end;

end.
