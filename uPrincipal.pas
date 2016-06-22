unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TLHelp32, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function Finalizaprocesso(ExeFileName: string): integer;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function TfrmPrincipal.Finalizaprocesso(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot
  (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
  FProcessEntry32);

  while integer(ContinueLoop) <> 0 do begin

    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
    or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));

    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);

  end;

  CloseHandle(FSnapshotHandle);

  Application.Terminate;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled := false;
  self.Finalizaprocesso('SmartChef.exe');
end;

end.
