unit Criptografia;

interface

uses
  SysUtils;

type
  TCriptografia = class

  private
    procedure dfinir_SBox(Chave:string; var s:array of integer);
  public
    function EncriptRC4(Text:String; const Chave :String = '45678'):String;
    Function DesencriptRC4(Text:String; const Chave :String = '45678'):string;

end;

implementation

procedure TCriptografia.dfinir_SBox(Chave:string; var s:array of integer);
var
  k:array[0..255] of Integer;
  i:integer;
  j:integer;
  buffer:integer;
begin
 i := 0;
 
 while i <= 255 do begin
   s[i] := i;
   inc(i);
 end;

 i := 0;
 while i <= 255 do  begin
       K[i] := ord(Chave[((i * 2) Mod length(Chave)) + 1])+
              ord(Chave[((i * 2) + 1) Mod length(Chave) + 1]);

   inc(i);
 end;

 j := 0;
 i := 0;
 while i <= 255 do  begin
        j := (j + S[i] + K[i]) Mod 256;
        Buffer := S[i];
        S[i] := S[j];
        S[j] := Buffer;
   inc(i)
 end;

end;



function TCriptografia.EncriptRC4(Text:String; const Chave :String = '45678'):String;
var
 s:array[0..255] of Integer;
 i:integer;
 j:integer;
 T:integer;
 buffer:integer;
 Seccao:integer;
 SeccaoTexto:integer;
begin
 result := '';
  dfinir_SBox(chave,s);

  i:= 0;
  j:= 0;
  Seccao := 1;
  while seccao <= length(text) do begin
    SeccaoTexto := ord(text[seccao]);
    i := (i+1) mod 256;
    j := (j+s[i]) mod 256;
    buffer := s[i];
    s[i] := s[j];
    s[j] := buffer;
    t := (s[i]+s[j]) mod 256;
    result := result + inttohex(SeccaoTexto xor s[t],2);
   inc(seccao);
  end;
end;

Function TCriptografia.DesencriptRC4(Text:String; const Chave :String = '45678'):string;
var
  s:array[0..255] of Integer;
  i:integer;
  j:integer;
  T:integer;
  buffer:integer;
  Seccao:integer;
  SeccaoTexto:integer;
begin
 result := '';
 dfinir_SBox(chave,s);

  i := 0;
  j := 0;
  Seccao := 1;
  while Seccao < length(text) do begin
    seccaotexto := strtoint('$'+copy(text,seccao,2));
    i := (i+1) mod 256;
    j := (j+s[i]) mod 256;
    buffer := s[i];
    s[i] := s[j];
    s[j] := buffer;
    t := (s[i]+s[j]) mod 256;
    result := result + Chr(SeccaoTexto Xor S[T]);
    inc(Seccao,2);
  end;

end;

end.
 