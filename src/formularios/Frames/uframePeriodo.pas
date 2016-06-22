unit uframePeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, FocusMaskEdit, Funcoes, MarcianoBallon;

type
  TframePeriodo = class(TFrame)
    edtDtI: TFocusMaskEdit;
    edtDtF: TFocusMaskEdit;
    balao: TMarcianoBallon;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure edtDtIEnter(Sender: TObject);
    procedure edtDtIExit(Sender: TObject);
    procedure FrameExit(Sender: TObject);
  private
    { Private declarations }
  public
    function  getDataInicial: TDateTime;
    procedure setDataInicial(dDt: TDateTime);

    function  getDataFinal: TDateTime;
    procedure setDataFinal(dDt: TDateTime);

    procedure setPeriodo(dDtI, dDtF: TDateTime);
  end;

implementation

{$R *.dfm}

procedure TframePeriodo.edtDtIEnter(Sender: TObject);
begin
  TMaskEdit(Sender).SelLength := 1;
end;

procedure TframePeriodo.edtDtIExit(Sender: TObject);
begin
  If Not VerMaskData(TMaskEdit(Sender)) Then
    Abort;
end;

procedure TframePeriodo.FrameExit(Sender: TObject);
begin
  If StrToDate(edtDtI.Text) > StrToDate(edtDtF.Text) Then
    begin
      self.balao.ShowBallon(self.edtDtI, 'A data inicial não pode ser maior que a data final!');
      edtDtI.SetFocus;
    end;
end;

function TframePeriodo.getDataFinal: TDateTime;
begin
  Result := StrToDate(edtDtF.Text);
end;

function TframePeriodo.getDataInicial: TDateTime;
begin
  Result := StrToDate(edtDtI.Text);
end;

procedure TframePeriodo.setDataFinal(dDt: TDateTime);
begin
  edtDtF.Text := DateStr(dDt);
end;

procedure TframePeriodo.setDataInicial(dDt: TDateTime);
begin
  edtDtI.Text := DateStr(dDt);
end;

procedure TframePeriodo.setPeriodo(dDtI, dDtF: TDateTime);
begin
  self.setDataInicial(dDtI);
  self.setDataFinal(dDtF); 
end;

end.
