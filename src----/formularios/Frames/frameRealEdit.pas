unit frameRealEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask;

type
  TRealEdit = class(TFrame)
    edtValor: TMaskEdit;
    procedure edtValorChange(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorEnter(Sender: TObject);
  private
    NumDigitado :String;
    apagando :Boolean;

    procedure moedaBanco;
    function getValor:Real;

  public
    property Valor :Real read getValor;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TRealEdit.moedaBanco;
  var tamanhoNum :integer;
begin
  if length(NumDigitado) = edtValor.MaxLength then begin
    abort;
    exit;
  end;
  tamanhoNum := (length(NumDigitado)+1);

  if tamanhoNum > 2 then
    inc(tamanhoNum);

  edtValor.SelStart := edtValor.MaxLength - tamanhoNum;

  edtValor.Text := NumDigitado;
  edtValor.SelStart := 2;
end;

procedure TRealEdit.edtValorChange(Sender: TObject);
begin
  moedaBanco;
end;

procedure TRealEdit.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if (length(NumDigitado) = edtValor.MaxLength -1) and (key <> #8) then
    key := #0;

  if key in ['0'..'9'] then begin

     if Length(trim(edtValor.Text)) = 0 then
       edtValor.EditMask := '!99999999\0,\09;0; '
     else
       if Length(trim(edtValor.Text)) = 1 then
         edtValor.EditMask := '!99999999\0,99;0; '
     else
       if Length(trim(edtValor.Text)) = 2 then
         edtValor.EditMask := '!999999999,99;0; ';

     NumDigitado := NumDigitado + key;
     apagando := false;

  end
  else if key = #8 then begin
      NumDigitado := copy(NumDigitado,1,length(Numdigitado)-1);

      if Length(trim(edtValor.Text)) = 1 then
        edtValor.EditMask := '!99999999\0,\0\0;0; '
      else
        if Length(trim(edtValor.Text)) = 2 then
          edtValor.EditMask := '!99999999\0,\09;0; '
      else
        if Length(trim(edtValor.Text)) = 3 then
          edtValor.EditMask := '!99999999\0,99;0; ';

    apagando := true;
  end;
end;

procedure TRealEdit.edtValorEnter(Sender: TObject);
begin
  edtValor.SelStart := 2;
end;

function TRealEdit.getValor: Real;
var FRetorno :String;
begin
  if Length(trim(edtValor.text)) > 2 then begin
    edtValor.EditMask := '!999999999,99;1; ';
    FRetorno := trim(edtValor.text);
  end
  else
    if Length(trim(edtValor.text)) = 2 then
      FRetorno := '0,'+ trim(edtValor.text)
  else
    if Length(trim(edtValor.text)) = 1 then
      FRetorno := '0,0'+ trim(edtValor.text);

  Result := strToFloat(FRetorno);
end;

end.
