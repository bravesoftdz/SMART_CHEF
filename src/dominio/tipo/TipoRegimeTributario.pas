unit TipoRegimeTributario;

interface

type TTipoRegimeTributario = (trtSimplesNacional=0, trtLucroPresumido=1, trtLucroReal=2);

type
  TTipoRegimeTributarioUtilitario = class

  public
    class function DeEnumeradoParaInteger(Tipo :TTipoRegimeTributario) :Integer;
    class function DeIntegerParaEnumerado(Tipo :Integer)               :TTipoRegimeTributario;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoRegimeTributarioUtilitario }
class function TTipoRegimeTributarioUtilitario.DeEnumeradoParaInteger(Tipo: TTipoRegimeTributario): Integer;
begin
   case Tipo of
    trtSimplesNacional :result := 0;
    trtLucroPresumido  :result := 1;
    trtLucroReal       :result := 2;
    
   else
     raise TExcecaoParametroInvalido.Create(self.ClassName,
                                            'DeEnumeradoParaInteger(Tipo: TTipoRegimeTributario): Integer;',
                                            'Tipo');
   end;
end;

class function TTipoRegimeTributarioUtilitario.DeIntegerParaEnumerado(
  Tipo: Integer): TTipoRegimeTributario;
begin
   case Tipo of
    0: result := trtSimplesNacional;
    1: result := trtLucroPresumido;
    2: result := trtLucroReal;

   else
     raise TExcecaoParametroInvalido.Create(self.ClassName,
                                            'DeIntegerParaEnumerado(Tipo: Integer): Integer;',
                                            'Tipo');
   end;
end;

end.
