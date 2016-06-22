unit DateTimeUtilitario;

interface

uses Controls;

type
  TDateTimeUtilitario = class
  private
    class function SegundosToTime(Segundos: Cardinal): String;
    class function TimeToSegundos(hora: TTime): Cardinal;

  public
    class function DataSEFAZToDateTime(const Data :String) :TDateTime;
    class function proximo_mes(data :TDateTime) :String;
    class function SegundosParaTime(Segundos: Integer): string;
    class function TimeParaSegundos(Time :TDateTime): Integer;
    class function DiaSemanaExtenso(Data :TDateTime): String;
    class Function DataExt(Data: TDate): String;
end;

implementation

uses
  SysUtils,
  DateUtils,
  StringUtilitario;

{ TDateTimeUtilitario }


class function TDateTimeUtilitario.DataExt(Data: TDate): String;
Var Ano, dia, mes :Word;
    DiaRet, MesRet: String;
begin
  Try
    DecodeDate(Data,Ano,Mes,Dia);
    Case DayOfWeek(Data) Of
      1: DiaRet := 'Domingo';
      2: DiaRet := 'Segunda Feira';
      3: DiaRet := 'Terça Feira';
      4: DiaRet := 'Quarta Feira';
      5: DiaRet := 'Quinta Feira';
      6: DiaREt := 'Sexta Feira';
      7: DiaRet := 'Sábado';
    Else
      DiaRet    := ''
    end;

    Case Mes Of
      1 : MesRet := 'Janeiro';
      2 : MesRet := 'Fevereiro';
      3 : MesRet := 'Março';
      4 : MesRet := 'Abril';
      5 : MesRet := 'Maio';
      6 : MesRet := 'Junho';
      7 : MesRet := 'Julho';
      8 : MesRet := 'Agosto';
      9 : MesRet := 'Setembro';
      10: MesRet := 'Outubro';
      11: MesRet := 'Novembro';
      12: MesRet := 'Dezembro';
    Else
      MesRet := '';
    end;

    Result := DiaRet + ', ' + IntToStr(Dia) + ' de ' + MesRet + ' de ' + IntToStr(Ano);
  except
    Result := 'Data Inválida!'
  end;
end;

class function TDateTimeUtilitario.DataSEFAZToDateTime(const Data: String): TDateTime;
var
  Ano, Mes, Dia, Hora, Minuto, Segundo, Milisegundo: Word;
  cData :String;
  cHoras :String;
  cAno, cMes, cDia, cHora, cMinuto, cSegundo, cMilisegundo :String;
begin
   //1234567890 1 23456789
   { 2013-10-29 T 13:24:49 }
   cData := Copy(Data, 1,  10);
   cAno  := Copy(cData, 1, 4);
   cMes  := Copy(cData, 6,  2);
   cDia  := Copy(cData, 9, 2);

   cHoras   := Copy(Data, 12, 8);
   cHora    := Copy(cHoras, 1, 2);
   cMinuto  := Copy(cHoras, 4, 2);
   cSegundo := Copy(cHoras, 7, 2);

   Ano     := StrToIntDef(cAno, 0);
   Mes     := StrToIntDef(cMes, 0);
   Dia     := StrToIntDef(cDia, 0);
   Hora    := StrToIntDef(cHora, 0);
   Minuto  := StrToIntDef(cMinuto, 0);
   Segundo := StrToIntDef(cSegundo, 0);

   result := EncodeDateTime(Ano, Mes, Dia, Hora, Minuto, Segundo, 0);
end;



class function DataExt(Data: TDate): String;
Var Ano, dia, mes :Word;
    DiaRet, MesRet: String;
begin
  Try
    DecodeDate(Data,Ano,Mes,Dia);
    Case DayOfWeek(Data) Of
      1: DiaRet := 'Domingo';
      2: DiaRet := 'Segunda Feira';
      3: DiaRet := 'Terça Feira';
      4: DiaRet := 'Quarta Feira';
      5: DiaRet := 'Quinta Feira';
      6: DiaREt := 'Sexta Feira';
      7: DiaRet := 'Sábado';
    Else
      DiaRet    := ''
    end;

    Case Mes Of
      1 : MesRet := 'Janeiro';
      2 : MesRet := 'Fevereiro';
      3 : MesRet := 'Março';
      4 : MesRet := 'Abril';
      5 : MesRet := 'Maio';
      6 : MesRet := 'Junho';
      7 : MesRet := 'Julho';
      8 : MesRet := 'Agosto';
      9 : MesRet := 'Setembro';
      10: MesRet := 'Outubro';
      11: MesRet := 'Novembro';
      12: MesRet := 'Dezembro';
    Else
      MesRet := '';
    end;

    Result := DiaRet + ', ' + IntToStr(Dia) + ' de ' + MesRet + ' de ' + IntToStr(Ano);
  except
    Result := 'Data Inválida!'
  end;
end;

class function TimeToSegundos( hora :TTime): Cardinal;
var hor, min, seg, milseg :Word;
segundos :Cardinal;
begin
  DecodeTime(hora, hor, min, seg, milseg);

  segundos := hor * 60;      { transformo hora em minutos }
  segundos := segundos + min; { somo os minutos transformados com os ja existentes }
  segundos := segundos * 60;  { transformo os minutos em segundos}
  segundos := segundos + seg; { somo os segundos transformados com os ja existentes }

  Result := segundos;
end;

class function TDateTimeUtilitario.DiaSemanaExtenso(Data: TDateTime): String;
var
  NoDia : Integer;
  DiaDaSemana : array [1..7] of String[13];
begin
 { Dias da Semana }
  DiaDasemana [1]:= 'Domingo';
  DiaDasemana [2]:= 'Segunda-feira';
  DiaDasemana [3]:= 'Terça-feira';
  DiaDasemana [4]:= 'Quarta-feira';
  DiaDasemana [5]:= 'Quinta-feira';
  DiaDasemana [6]:= 'Sexta-feira';
  DiaDasemana [7]:= 'Sábado';
  
  NoDia   := DayOfWeek(Data);
  Result  := DiaDasemana[NoDia];
end;

class function TDateTimeUtilitario.proximo_mes(data: TDateTime): String;
var mes :Integer;
begin
  mes := StrToInt(FormatDateTime('mm', data));

  case mes of
    01 : Result := '02';
    02 : Result := '03';
    03 : Result := '04';
    04 : Result := '05';
    05 : Result := '06';
    06 : Result := '07';
    07 : Result := '08';
    08 : Result := '09';
    09 : Result := '10';
    10 : Result := '11';
    11 : Result := '12';
    12 : Result := '01';
  end;

end;

class function TDateTimeUtilitario.SegundosParaTime(Segundos: Integer): string;
var
  Hrs, Min: Word;
  hora, minuto, segundo :String;
begin
  Hrs := (Segundos div 3600);
  Segundos := Segundos mod 3600;
  Min := Segundos div 60;
  Segundos := Segundos mod 60;
  Result := Format('%d:%d:%d', [Hrs, Min, Segundos]);

  hora    := TStringUtilitario.CaracterAEsquerda('0', IntToStr(Hrs), 2);
  Minuto  := TStringUtilitario.CaracterAEsquerda('0', IntToStr(Min), 2);
  segundo := TStringUtilitario.CaracterAEsquerda('0', IntToStr(Segundos), 2);

  result := hora+':'+minuto+':'+segundo;
end;

class function TDateTimeUtilitario.SegundosToTime(
  Segundos: Cardinal): String;
begin

end;

class function TDateTimeUtilitario.TimeParaSegundos(Time: TDateTime): Integer;
var hora, minuto, segundo, msegundo :word ;
begin
  result := 0;

  DecodeTime(time, hora, minuto, segundo, msegundo);

  result := (hora*60)*60;
  result := result + (minuto * 60);
  result := result + segundo;

end;

class function TDateTimeUtilitario.TimeToSegundos(hora: TTime): Cardinal;
begin

end;

end.
