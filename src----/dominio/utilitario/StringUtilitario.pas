unit StringUtilitario;

interface

type
  TStringUtilitario = class
  
  public
    class function ApenasNumeros    (const Texto :String)                      :String;
    class function EstaVazia        (Texto :String)                            :Boolean;
    class function FormataCEP       (const CEP   :String)                      :String; overload;
    class function FormataCEP       (const CEP   :String; UsaPonto :Boolean)   :String; overload;
    class function FormataDinheiro  (const Valor :Real)                        :String;          
    class function LetraPorSequencia(NumeroSequencia :Integer)                 :String;
    class function StringVazia                                                 :String;
    class function RemoveCaracter(const Texto :String; const caracter :String = '')          :String;
    class function CaracterAEsquerda(Caracter :Char; Texto :String; tamanho_maximo :Integer) :String;
    class function NomeDoComputador :String;
    class function MascaraFone      (const fone :String)                       :String;
    class function TamanhoArquivo(Arquivo: string)                             :Integer;
    class function MascaraTelefone(const telefone :string) :String;
end;

implementation

uses
  SysUtils, Registry, windows, Classes;

{ TStringUtilitario }

class function TStringUtilitario.ApenasNumeros(
  const Texto: String): String;
var nX: Integer;
begin
  result := '';

  for nX := 1 To Length(Texto) do begin
      if Texto[nX] in ['0'..'9'] Then
        result := result + Texto[nX];
  end;
end;

class function TStringUtilitario.TamanhoArquivo(Arquivo: string): Integer;
begin

  with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do

  try

    Result := Size;

  finally

   Free;

  end;

end;

class function TStringUtilitario.CaracterAEsquerda(Caracter :Char; Texto: String;
  tamanho_maximo: Integer): String;
var vezes :Integer;
begin

  vezes := tamanho_maximo - Length(Texto);

  Result := StringOfChar(Caracter, vezes ) + Texto;

end;

class function TStringUtilitario.EstaVazia(Texto: String): Boolean;
begin
   result := (Trim(Texto) = self.StringVazia);
end;

class function TStringUtilitario.FormataCEP(const CEP: String; UsaPonto :Boolean): String;
var
  nX: Integer;
begin
  result := '';

  for nX := 1 to Length(CEP) do begin
      if CEP[nX] in ['0'..'9'] Then
        result := result + CEP[nX];
  end;

  if (Length(Result) <> 8) then
    exit;

   if UsaPonto then
     result := copy(Result,1,2) + '.' + copy(Result,3,3) + '-' + copy(Result,6,3)
   else
     result := copy(Result,1,2) +       copy(Result,3,3) + '-' + copy(Result,6,3);
end;

class function TStringUtilitario.FormataCEP(const CEP: String): String;
begin
   result := self.FormataCEP(CEP, true);
end;

class function TStringUtilitario.FormataDinheiro(
  const Valor: Real): String;
begin
   result := FormatFloat(' ,0.00; -,0.00;', Valor);
end;

class function TStringUtilitario.NomeDoComputador: String;
var
  iLen: Cardinal;
begin
  iLen := MAX_COMPUTERNAME_LENGTH + 1;         // From Windows.pas
  Result := StringOfChar(#0, iLen);
  GetComputerName(PChar(Result), iLen);
  SetLength(Result, iLen);
end;

class function TStringUtilitario.LetraPorSequencia(
  NumeroSequencia: Integer): String;
const
  ALFABETO = 'ABCDEFGHIJLMNOPQRSTUVXZ';
begin
   result := ALFABETO[NumeroSequencia];
end;

class function TStringUtilitario.RemoveCaracter(const Texto :String; const caracter: String): String;
var I :integer;
begin
  if caracter <> '' then
    result := StringReplace(Texto, caracter, '', [rfReplaceAll])
  else
    for I := 1 To Length(Texto) do
       if Texto [I] In ['0'..'9'] Then
          Result := Result + Texto [I];
end;

class function TStringUtilitario.StringVazia: String;
begin
   result := '';
end;

class function TStringUtilitario.MascaraFone(const fone: String): String;
begin
  result := '('+copy(fone,1,2)+')'+copy(fone,3,8);
end;

class function TStringUtilitario.MascaraTelefone(const telefone: string): String;
begin
  result := '('+copy(telefone,1,2)+')'+copy(telefone,3,4)+'-'+copy(telefone,7,4); 
end;

end.
