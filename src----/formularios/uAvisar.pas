unit uAvisar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, pngimage;

type
  TfrmAvisar = class(TForm)
    panCorpo: TPanel;
    memMsg: TMemo;
    timEspera: TTimer;
    panRodape: TPanel;
    Shape1: TShape;
    btnOk: TBitBtn;
    Shape3: TShape;
    Shape2: TShape;
    Label1: TLabel;
    imgAlerta: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure timEsperaTimer(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure panCorpoResize(Sender: TObject);
  private
    espera    :Integer;
    FSemAtalho :Boolean;

    procedure ajustaTamanho;
    procedure ativa_alerta;
  public
    constructor Create(AOwner: TComponent; mensagem: String;
                       const tempoEspera:Integer = 0;
                       const semAtalho :String = '';
                       const tipo :Integer = 0); overload; virtual;
  end;
  {0 - aviso    1 - alerta}
var
  frmAvisar: TfrmAvisar;

implementation

{$R *.dfm}

procedure TfrmAvisar.ajustaTamanho;
begin
  // 20 é a altura de cada linha
  self.Height := self.Height + ((memMsg.Lines.Count - trunc(memMsg.Height/20)) * 20);
//  self.Height := self.Height + 20;
end;

constructor TfrmAvisar.Create(AOwner: TComponent; mensagem: String;
  const tempoEspera: Integer; const semAtalho :String; const tipo :Integer);
begin
  self.Create(aOwner);
  self.memMsg.Text  := mensagem;
  espera            := tempoEspera;
  FSemAtalho        := (semAtalho = 'S');
  if tipo = 1 then
    ativa_alerta;
end;

procedure TfrmAvisar.FormCreate(Sender: TObject);
begin
  if memMsg.Lines.Count > 2 then
    ajustaTamanho;

  if espera > 0 then begin
    timEspera.Enabled  := true;
    btnOk.Caption := '<ENTER> OK ['+intToStr(espera)+']';
  end;
end;

procedure TfrmAvisar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FSemAtalho then EXIT;
  
  if Key = VK_Return then
    btnOk.Click;
end;

procedure TfrmAvisar.timEsperaTimer(Sender: TObject);
begin
  Dec(espera);
  btnOk.Caption := '<ENTER> OK ['+intToStr(espera)+']';
  if espera = 0 then
    btnOk.Click;
end;

procedure TfrmAvisar.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAvisar.panCorpoResize(Sender: TObject);
begin
  btnOk.Left := Trunc((panCorpo.Width / 2) - (btnOk.Width / 2));
end;

procedure TfrmAvisar.ativa_alerta;
begin
  memMsg.Left       := memMsg.Left + 110;
  memMsg.Width      := memMsg.Width - 110;
  self.Width        := 790;
  memMsg.Font.Color := clMaroon;
  memMsg.Font.Size  := 15;
  imgAlerta.Visible := true;
end;

end.
