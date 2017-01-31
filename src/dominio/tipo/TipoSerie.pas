unit TipoSerie;

interface

type
  TTipoSerie = (tsNormal=0, tsSCAN=1);

type
  TTipoSerieUtilitario = class

  public
    class function DeEnumeradoParaString (TipoSerie :TTipoSerie) :String;
    class function DeEnumeradoParaInteger(TipoSerie :TTipoSerie) :Integer;
    class function DeStringParaEnumerado (TipoSerie :String)     :TTipoSerie;
    class function DeIntegerParaEnumerado(TipoSerie :Integer)   :TTipoSerie;
end;

implementation

uses
  ExcecaoParametroInvalido,
  SysUtils;

{ TTipoSerieUtilitario }

class function TTipoSerieUtilitario.DeEnumeradoParaInteger(
  TipoSerie: TTipoSerie): Integer;
begin
   if      (TipoSerie = tsNormal) then result := 0
   else if (TipoSerie = tsSCAN)   then result := 1
   else
    raise TExcecaoParametroInvalido.Create('TTipoSerieUtilitario', 'DeEnumeradoParaInteger', 'TipoSerie: TTipoSerie');
end;

class function TTipoSerieUtilitario.DeEnumeradoParaString(
  TipoSerie: TTipoSerie): String;
begin
   if      (TipoSerie = tsNormal) then result := '001'
   else if (TipoSerie = tsSCAN)   then result := '900'
   else
    raise TExcecaoParametroInvalido.Create('TTipoSerieUtilitario', 'DeEnumeradoParaString', 'TipoSerie: TTipoSerie');
end;

class function TTipoSerieUtilitario.DeIntegerParaEnumerado(
  TipoSerie: Integer): TTipoSerie;
begin
   if      (TipoSerie = 0) then result := tsNormal
   else if (TipoSerie = 1) then result := tsSCAN
   else
    raise TExcecaoParametroInvalido.Create('TTipoSerieUtilitario', 'DeIntegerParaEnumerado', 'TipoSerie: TTipoSerie');
end;

class function TTipoSerieUtilitario.DeStringParaEnumerado(
  TipoSerie: String): TTipoSerie;
begin
   if      (strToInt(TipoSerie) < 9) and
           (strToInt(TipoSerie) >= 0) then result := tsNormal
   else if (Trim(TipoSerie) = '900') then result := tsSCAN
   else
    raise TExcecaoParametroInvalido.Create('TTipoSerieUtilitario', 'DeStringParaEnumerado', 'TipoSerie: TTipoSerie');
end;

end.
