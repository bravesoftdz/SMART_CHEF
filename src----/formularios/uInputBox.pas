unit uInputBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TfrmInputBox = class(TForm)
    Panel1: TPanel;
    panTopo: TPanel;
    Label1: TLabel;
    panCentro: TPanel;
    memRetorno: TMemo;
    edtRetorno: TMaskEdit;
    panRodaPe: TPanel;
    panBotoes: TPanel;
    btnCancela: TBitBtn;
    btnConfirma: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    procedure edtRetornoChange(Sender: TObject);
    procedure edtRetornoKeyPress(Sender: TObject; var Key: Char);
    procedure edtRetornoEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtRetornoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memRetornoKeyPress(Sender: TObject; var Key: Char);
  private
    FRetorno :String;

    NumDigitado :String;
    apagando :Boolean;
    tipo :String;

    procedure moedaBanco;
    procedure configuraForm;
    procedure trataRetorno;
  public

    property Retorno :String  read FRetorno;

    constructor Create(AOwner: TComponent; tipoData, titulo: String); overload; virtual;
  end;

var
  frmInputBox: TfrmInputBox;

implementation

{$R *.dfm}

constructor TfrmInputBox.Create(AOwner: TComponent; tipoData, titulo: String);
begin
  self.Create(aOwner);
  tipo := UpperCase(tipoData);
  label1.Caption := titulo;
end;

procedure TfrmInputBox.configuraForm;
begin
  if tipo = 'TEXT' then begin
    memRetorno.visible := true;
    self.Height := 250;
    self.Width  := 600;
    PanBotoes.Left := (panRodaPe.Width - PanBotoes.Width) div 2;
    PanBotoes.Top := (panRodaPe.Height - PanBotoes.Height) div 2;
  end
  else begin
    edtRetorno.visible := true;
    self.Height := 123;
    self.Width  := 346;

    if tipo = 'STRING' then
      edtRetorno.Width := 300;

    edtRetorno.Left := (panCentro.Width - edtRetorno.Width) div 2;
    edtRetorno.Top  := (panCentro.Height - edtRetorno.Height) div 2;
  end;

  if tipo = 'STRING' then
    edtRetorno.EditMask := ''
  else if tipo = 'INTEGER' then
    edtRetorno.EditMask := '!999999999;0; '
  else if tipo = 'REAL' then
    edtRetorno.EditMask := '!99999999\0,\0\0;0; '
  else if tipo = 'DATE' then
    edtRetorno.EditMask := '!99/99/9999;1; ';
end;


procedure TfrmInputBox.moedaBanco;
  var tamanhoNum :integer;
begin
  if length(NumDigitado) = edtRetorno.MaxLength then begin
    abort;
    exit;
  end;
  tamanhoNum := (length(NumDigitado)+1);

  if tamanhoNum > 2 then
    inc(tamanhoNum);

  edtRetorno.SelStart := edtRetorno.MaxLength - tamanhoNum;

  edtRetorno.Text := NumDigitado;
  edtRetorno.SelStart := 2;
end;

procedure TfrmInputBox.edtRetornoChange(Sender: TObject);
begin
  if tipo <> 'REAL' then
    exit;

  moedaBanco;
end;

procedure TfrmInputBox.edtRetornoKeyPress(Sender: TObject; var Key: Char);
begin
  if (length(NumDigitado) = edtRetorno.MaxLength -1) and (key <> #8) then
    key := #0;

  if tipo <> 'REAL' then
    exit;

  if key in ['0'..'9'] then begin

     if Length(trim(edtRetorno.Text)) = 0 then
       edtRetorno.EditMask := '!99999999\0,\09;0; '
     else
       if Length(trim(edtRetorno.Text)) = 1 then
         edtRetorno.EditMask := '!99999999\0,99;0; '
     else
       if Length(trim(edtRetorno.Text)) = 2 then
         edtRetorno.EditMask := '!999999999,99;0; ';

     NumDigitado := NumDigitado + key;
     apagando := false;

  end
  else if key = #8 then begin
      NumDigitado := copy(NumDigitado,1,length(Numdigitado)-1);

      if Length(trim(edtRetorno.Text)) = 1 then
        edtRetorno.EditMask := '!99999999\0,\0\0;0; '
      else
        if Length(trim(edtRetorno.Text)) = 2 then
          edtRetorno.EditMask := '!99999999\0,\09;0; '
      else
        if Length(trim(edtRetorno.Text)) = 3 then
          edtRetorno.EditMask := '!99999999\0,99;0; ';

    apagando := true;
  end;
end;

procedure TfrmInputBox.edtRetornoEnter(Sender: TObject);
begin
  if tipo <> 'REAL' then
    edtRetorno.SelStart := 0
  else
    edtRetorno.SelStart := 2;
end;

procedure TfrmInputBox.FormShow(Sender: TObject);
begin
  configuraForm;
end;

procedure TfrmInputBox.btnCancelaClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmInputBox.btnConfirmaClick(Sender: TObject);
begin
  trataRetorno;
  self.ModalResult := mrOk;
end;

procedure TfrmInputBox.trataRetorno;
var s :string;
begin
  if tipo = 'REAL' then begin

    if Length(trim(edtRetorno.text)) > 2 then begin
      edtRetorno.EditMask := '!999999999,99;1; ';
      FRetorno := trim(edtRetorno.text);
    end
    else
      if Length(trim(edtRetorno.text)) = 2 then
        FRetorno := '0,'+ trim(edtRetorno.text)
    else
      if Length(trim(edtRetorno.text)) = 1 then
        FRetorno := '0,0'+ trim(edtRetorno.text);

  end
  else
    if tipo = 'INTEGER' then
      FRetorno := trim(edtRetorno.Text)
  else
    if tipo = 'STRING' then
      FRetorno  := trim(edtRetorno.Text)
  else
    if tipo = 'TEXT' then
      FRetorno := trim(memRetorno.Text)
  else
    if tipo = 'DATE' then
      FRetorno  := edtRetorno.Text;

end;

procedure TfrmInputBox.edtRetornoExit(Sender: TObject);
begin
  if tipo = 'DATE' then begin
    try
      strToDate(edtRetorno.Text);
    except
      showmessage('Data inválida');
      edtRetorno.SetFocus;
    end;
  end;
end;

procedure TfrmInputBox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
    btnCancela.Click;
end;

procedure TfrmInputBox.memRetornoKeyPress(Sender: TObject; var Key: Char);
begin
  If ( key in[';'] ) then
    key:=#0;
end;

end.
