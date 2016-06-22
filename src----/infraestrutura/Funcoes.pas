unit Funcoes;

interface

uses Controls;

function substituiString(S, localizar, substituir :String): String;

{ ******* FUNÇÕES / VALORES *******}
function arredonda(valor :Real; const considerar_casas :integer = 2) :Real;

{ ******* FUNÇÕES / BANCO DE DADOS *******}
function Maior_Valor_Cadastrado(Tabela, campo :String): String;
function Campo_por_campo(Tabela, campo_procurado, campo_referencia, valor_campo_referencia :String;
          const campo_referencia2 :String = ''; const valor_referencia2 :String = '') :String;

{ ******* FUNÇÕES / FISCAL *******}
function CFOP_entrada(codigo_natureza :integer) :Boolean;
function buscaCFOPCorrespondente(CFOP: String): String;

procedure executa_SQL(SQL :STring);
procedure EmiteSomErro;
function Valida_CPF_CNPJ(Nr_CGC:String):boolean;
function UF_TO_CODUF(UF :String) :integer;


implementation

uses StrUtils, Windows, SysUtils, Types, Math, Dialogs, uModulo, DateUtils, Forms, MMSystem;

function UF_TO_CODUF(UF :String) :integer;
begin
  result := 0;

      if UF = 'RO' then result := 11
 else if UF = 'AC' then result := 12
 else if UF = 'AM' then result := 13
 else if UF = 'RR' then result := 14
 else if UF = 'PA' then result := 15
 else if UF = 'AP' then result := 16
 else if UF = 'TC' then result := 17
 else if UF = 'MR' then result := 21
 else if UF = 'PI' then result := 22
 else if UF = 'CE' then result := 23
 else if UF = 'RN' then result := 24
 else if UF = 'PB' then result := 25
 else if UF = 'PE' then result := 26
 else if UF = 'AL' then result := 27
 else if UF = 'SG' then result := 28
 else if UF = 'BH' then result := 29
 else if UF = 'MG' then result := 31
 else if UF = 'ES' then result := 32
 else if UF = 'RJ' then result := 33
 else if UF = 'SP' then result := 35
 else if UF = 'PR' then result := 41
 else if UF = 'SC' then result := 42
 else if UF = 'RS' then result := 43
 else if UF = 'MS' then result := 50
 else if UF = 'MT' then result := 51
 else if UF = 'GO' then result := 52
 else if UF = 'DF' then result := 53;

end;

procedure executa_SQL(SQL :String);
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := SQL;
  dm.qryGenerica.ExecSQL;
end;

procedure EmiteSomErro;
begin
  if FileExists(ExtractFilePath( Application.ExeName )+'\ERRO.wav') then
    PlaySound(PAnsiChar(ExtractFilePath( Application.ExeName )+'\ERRO.wav'), 1, SND_ASYNC);
end;

function Valida_CPF_CNPJ(Nr_CGC:String):boolean;
var 
  Digito1,Digito2: String;
  S,Cont,Digito,Soma: Integer;
begin
  // length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
    if ((Nr_CGC = '00000000000') or (Nr_CGC = '11111111111') or (Nr_CGC = '22222222222') or
        (Nr_CGC = '33333333333') or (Nr_CGC = '44444444444') or (Nr_CGC = '55555555555') or
        (Nr_CGC = '66666666666') or (Nr_CGC = '77777777777') or (Nr_CGC = '88888888888') or
        (Nr_CGC = '99999999999')) then begin
      Valida_CPF_CNPJ := false;
      exit;
    end;

  if Length(Nr_Cgc)=11 then begin
    {Primeiro Dígito } 
    Cont:=1; 
    Soma:=0; 
    for S:=9 Downto 1 do begin 
      Inc(Cont); 
      Soma:=Soma + StrToInt(Nr_Cgc[S]) * Cont; 
    end; 
    Soma:=Soma * 10; 
    Digito1:=IntToStr(Soma Mod 11); 
    if StrToInt(Digito1)>=10 then 
      Digito1:='0'; 
    // Segundo Dígito 
    Cont:=1; 
    Soma:=0; 
    for S:=10 Downto 1 do begin 
      Inc(Cont); 
      Soma:=Soma + StrToInt(Nr_Cgc[S]) * Cont; 
    end; 
    Soma:=Soma * 10; 
    Digito2:=IntToStr(Soma Mod 11); 
    if StrToInt(Digito2)>=10 then 
      Digito2:='0';

  end else if Length(Nr_Cgc) = 14 then begin 
    Soma:=5 * StrToInt(Nr_Cgc[1]) + 4 * StrToInt(Nr_Cgc[2]) + 3 * StrToInt(Nr_Cgc[3])+ 
          2 * StrToInt(Nr_Cgc[4]) + 9 * StrToInt(Nr_Cgc[5]) + 8 * StrToInt(Nr_Cgc[6])+ 
          7 * StrToInt(Nr_Cgc[7]) + 6 * StrToInt(Nr_Cgc[8]) + 5 * StrToInt(Nr_Cgc[9])+ 
          4 * StrToInt(Nr_Cgc[10])+ 3 * StrToInt(Nr_Cgc[11])+ 2 * StrToInt(Nr_Cgc[12]); 
    Digito:=Soma Mod 11;

    if Digito>1 then 
      Digito:=11-Digito 
    else 
      Digito:=0; 
    Digito1:=IntToStr(Digito); 

    Soma:=6 * StrToInt(Nr_Cgc[1]) + 5 * StrToInt(Nr_Cgc[2]) + 4 * StrToInt(Nr_Cgc[3])+ 
          3 * StrToInt(Nr_Cgc[4]) + 2 * StrToInt(Nr_Cgc[5]) + 9 * StrToInt(Nr_Cgc[6])+ 
          8 * StrToInt(Nr_Cgc[7]) + 7 * StrToInt(Nr_Cgc[8]) + 6 * StrToInt(Nr_Cgc[9])+ 
          5 * StrToInt(Nr_Cgc[10])+ 4 * StrToInt(Nr_Cgc[11])+ 3 * StrToInt(Nr_Cgc[12])+ 
          2 * StrToInt(Digito1); 
    Digito:=Soma Mod 11;

    if Digito>1 then 
      Digito:=11-Digito 
    else 
      Digito:=0;

    Digito2:=IntToStr(Digito); 
  end else begin 
    Result:= false; 
    Exit; 
  end; 

  if Copy(Nr_Cgc,Length(Nr_Cgc)-1,2) <> Digito1+Digito2 then 
    Result := false
  else
    Result := true;
end;

Function DataExt(Data: TDate): String;
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

{ Recebe a quantidade de segundos e converte em TTime }
function SegundosToTime( Segundos : Cardinal ) : String;
var
  Seg, Min, Hora: Cardinal;
begin
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;

  Result := FormatFloat(',00', Hora) + ':' +   
  FormatFloat('00', Min) + ':' +
  FormatFloat('00', Seg);
end;

function TimeToSegundos( hora :TTime): Cardinal;
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

{  Recebe um CFOP (de saída) e retorna o Código da Natureza de operação do CFOP correspondente (de entrada)
   ( se ele tiver equivalencia cadastrada na tabela CFOP_CORRESPONDENTE )                                   }
function buscaCFOPCorrespondente(CFOP: String): String;
var codigo_natureza :String;
begin
  codigo_natureza := campo_por_campo('NATUREZAS_OPERACAO','CODIGO','CFOP',CFOP);

  Result := '';

  if ( codigo_natureza <> '' ) then
    Result          := Campo_por_campo('CFOP_CORRESPONDENTE', 'COD_CFOP_ENTRADA', 'COD_CFOP_SAIDA',codigo_natureza)
  else
    raise Exception.Create('CFOP '+ CFOP +' não cadastrado');
end;

function CFOP_entrada(codigo_natureza :integer) :Boolean;
var CFOP :String;
    primeiro_digito :integer;
begin
  CFOP := Campo_por_campo('NATUREZAS_OPERACAO', 'CFOP', 'CODIGO', intToStr(codigo_natureza));

  if CFOP = '' then  raise  Exception.Create('Código da Natureza de operação inválido.');
  
  primeiro_digito := strToInt( copy(CFOP,1,1) );

  if primeiro_digito < 4 then  Result := true
                         else  Result := false;
end;

function Campo_por_campo(Tabela, campo_procurado, campo_referencia, valor_campo_referencia :String;
 const campo_referencia2 :String; const valor_referencia2 :String) :String;
var segunda_condicao :String;
begin
  Result := '';

  if campo_referencia2 <> '' then
    segunda_condicao := ' AND '+campo_referencia2+' = :param2';

  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'SELECT first 1 '+campo_procurado+' FROM '+Tabela+
                             ' WHERE '+campo_referencia+' = :param1'+
                             segunda_condicao;

  if strToIntDef(valor_campo_referencia, 0) > 0 then // se for numero
    dm.qryGenerica.ParamByName('param1').AsInteger := strToInt(valor_campo_referencia)
  else
    dm.qryGenerica.ParamByName('param1').AsString  := valor_campo_referencia;

  if campo_referencia2 <> '' then begin
    if strToIntDef(valor_referencia2, 0) > 0 then // se for numero
      dm.qryGenerica.ParamByName('param2').AsInteger := strToInt(valor_referencia2)
    else
      dm.qryGenerica.ParamByName('param2').AsString := valor_referencia2;

  end;
  dm.qryGenerica.Open;

  if not dm.qryGenerica.IsEmpty then
    Result := dm.qryGenerica.fieldByName(campo_procurado).AsString;
end;

//pode ser usada para recuperar ultimo registro cadastrado
function Maior_Valor_Cadastrado(Tabela, campo :String): String;
var alias :String;
begin
  alias := campo;
   
  if pos('(',campo) > 0 then begin
    alias := copy(campo, pos('(',campo)+1, length(campo) );
    alias := copy(alias, 1, pos(' ',alias)-1)
  end;

  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'SELECT MAX('+campo+') as '+alias+' FROM '+Tabela+'';
  dm.qryGenerica.Open;

  Result := dm.qryGenerica.fieldByName(alias).AsString;
end;

//substitui parte da string informada
function substituiString(S, localizar, substituir :String): String;
var
   Retorno: String;
   Posicao: Integer;
begin
   Retorno := S;

   Posicao := Pos (Localizar, Retorno);
   if Posicao <> 0 then // Verificando se a substring Localizar existe.
   begin
      // Excluindo a Localizar.
      Delete(Retorno, Posicao, Length (Localizar));
      // Inserindo a string do parâmetro Substituir
      Insert(Substituir, Retorno , Posicao);
   end;

  Result := Retorno;
end;

// ARREDONDA VALOR DUAS CASAS DECIMAIS (PARA CIMA OU PARA BAIXO)
// EX: 1,2 = 1,0 | 1,3 = 1,5 | 1,7 = 1,5 | 1,8 = 2,0
function arredonda(valor :Real; const considerar_casas :integer) :Real;
var ultimaCasa :integer;
    valorStr :String;
begin
  if considerar_casas > 2 then begin

     valorStr := formatFloat('0.000', valor);

     valorStr := formatFloat('0.00',valor);

     Result := strToFloat( valorStr );

  end
  else begin

    valorStr := formatFloat('0.00',valor);
    ultimaCasa := strToInt( copy( valorStr, length( valorStr ) ,1) );

    if ultimaCasa < 3 then  begin
      Result := strToFloat( copy( valorStr, 1, length( valorStr ) -1 )+'0' );

    end
    else if ultimaCasa > 7 then begin
      Result := strToFloat( copy( valorStr, 1, length( valorStr ) -1 )+'0' );
      Result := Result + 0.1;
    end
    else
      Result := strToFloat( copy( valorStr, 1, length( valorStr ) -1 )+'5' );

  end;

end;

end.
