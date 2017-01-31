unit TipoOrigemMercadoria;

interface

type TTipoOrigemMercadoria = (tomNacional=0,
                              tomEstrangeiraImportacaoDireta=1,
                              tomEstrangeiraAdquiridaMercadoInterno=2);

type
  TTipoOrigemMercadoriaUtilitario = class

  public
    class function DeEnumeradoParaInteger(TipoOrigemMercadoria :TTipoOrigemMercadoria) :Integer;
    class function DeIntegerParaEnumerado(TipoOrigemMercadoria :Integer)               :TTipoOrigemMercadoria;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoOrigemMercadoriaUtilitario }

class function TTipoOrigemMercadoriaUtilitario.DeEnumeradoParaInteger(
  TipoOrigemMercadoria: TTipoOrigemMercadoria): Integer;
begin
   case TipoOrigemMercadoria of

    tomNacional:                           result := 0;
    tomEstrangeiraImportacaoDireta:        result := 1;
    tomEstrangeiraAdquiridaMercadoInterno: result := 2;

    else raise TExcecaoParametroInvalido.Create(self.ClassName,
                                               'DeEnumeradoParaInteger(TipoOrigemMercadoria: TTipoOrigemMercadoria): Integer',
                                               'TipoOrigemMercadoria');
   end;
end;

class function TTipoOrigemMercadoriaUtilitario.DeIntegerParaEnumerado(
  TipoOrigemMercadoria: Integer): TTipoOrigemMercadoria;
begin
   case TipoOrigemMercadoria of

    0: result := tomNacional;
    1: result := tomEstrangeiraImportacaoDireta;
    2: result := tomEstrangeiraAdquiridaMercadoInterno;

   else raise TExcecaoParametroInvalido.Create(self.ClassName,
                                               'DeIntegerParaEnumerado(TipoOrigemMercadoria: Integer): TTipoOrigemMercadoria;',
                                               'TipoOrigemMErcadoria');
   end;
end;

end.
