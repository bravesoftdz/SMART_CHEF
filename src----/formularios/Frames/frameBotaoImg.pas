unit frameBotaoImg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Buttons, pngimage;

type
  TBotaoImg = class(TFrame)
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    StaticText1: TStaticText;
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FrameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TBotaoImg.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  image1.Visible := false;
  image2.Visible := true;
  StaticText1.Font.Color := clBlue;//$00B40C8A;
end;

procedure TBotaoImg.Label1MouseLeave(Sender: TObject);
begin
  image2.Visible := false;
  image1.Visible := true;
  StaticText1.Font.Color := clBlack;
end;

procedure TBotaoImg.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Left := Image2.Left +1;
  Image2.Top  := Image2.Top +1;
end;

procedure TBotaoImg.Label1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Left := Image2.Left -1;
  Image2.Top  := Image2.Top -1;
end;

procedure TBotaoImg.FrameMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label1.BringToFront;
end;

procedure TBotaoImg.Label1Click(Sender: TObject);
begin
  //A SER IMPLEMENTADO
end;

ENd.
