unit TipoAmbienteNFe;

interface

type
  TTipoAmbienteNFe = (tanfeNenhum=-1, tanfeProducao=0, tanfeHomologacao=1);

type
  TTipoAmbienteNFeUtilitario = class

  public
    class function DeEnumeradoParaString (TipoAmbiente :TTipoAmbienteNFe) :String;
    class function DeEnumeradoParaInteger(TipoAmbiente :TTipoAmbienteNFe) :Integer;
    class function DeStringParaEnumerado (TipoAmbiente :String)           :TTipoAmbienteNFe;
    class function DeIntegerParaEnumerado(TipoAmbiente :Integer)          :TTipoAmbienteNFe;
end;

implementation

{ TTipoAmbienteNFeUtilitario }

class function TTipoAmbienteNFeUtilitario.DeEnumeradoParaInteger(
  TipoAmbiente: TTipoAmbienteNFe): Integer;
begin
    case TipoAmbiente of
     tanfeProducao:       result := 0;
     tanfeHomologacao:    result := 1;
    else
      result := -1;
    end;
end;

class function TTipoAmbienteNFeUtilitario.DeEnumeradoParaString(
  TipoAmbiente: TTipoAmbienteNFe): String;
begin
    case TipoAmbiente of
     tanfeProducao:       result := 'P';
     tanfeHomologacao:    result := 'H';
    else
      result := '';
    end;
end;

class function TTipoAmbienteNFeUtilitario.DeIntegerParaEnumerado(
  TipoAmbiente: Integer): TTipoAmbienteNFe;
begin
    case TipoAmbiente of
     0:  result := tanfeProducao;
     1:  result := tanfeHomologacao;
    else
      result := tanfeNenhum;
    end;
end;

class function TTipoAmbienteNFeUtilitario.DeStringParaEnumerado(
  TipoAmbiente: String): TTipoAmbienteNFe;
begin
    case TipoAmbiente[1] of
     'P':  result := tanfeProducao;
     'H':  result := tanfeHomologacao;
    else
      result := tanfeNenhum;
    end;
end;

end.
 