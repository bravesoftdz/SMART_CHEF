unit CriaBalaoInformacao;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

  Dialogs, Commctrl, StdCtrls;

type
  TCriaBalaoInformacao = class

  public
                                   {TIPO = 0(sem icone) 1(informacao) 2(aviso) 3(erro)}
    class procedure ShowBalloonTip(Window :HWnd; Texto, Titulo : PWideChar; Tipo : Integer);
    class procedure HideBalloonTip(Window :HWnd);

end;

  TEditBalloonTip = packed record

    cbStruct: DWORD ;

    pszTitle: LPCWSTR ;

    pszText: LPCWSTR;

    ttiIcon: Integer;

  end;

const

  ECM_FIRST = $1500;

  EM_SHOWBALLOONTIP = (ECM_FIRST + 3);

  EM_HIDEBALLOONTIP = (ECM_FIRST + 4);

  TTI_NONE = 0;

  TTI_INFO = 1;

  TTI_WARNING = 2;

  TTI_ERROR = 3;

implementation

{ TCriaBalaoInformacao }


{ TCriaBalaoInformacao }

class procedure TCriaBalaoInformacao.HideBalloonTip(Window: HWnd);
begin
  SendMessageW(Window, EM_HIDEBALLOONTIP, 0, 0);
end;

class procedure TCriaBalaoInformacao.ShowBalloonTip(Window: HWnd; Texto, Titulo : PWideChar; Tipo : Integer);
var

  EditBalloonTip : TEditBalloonTip;

begin

  EditBalloonTip.cbStruct := SizeOf(TEditBalloonTip);

  EditBalloonTip.pszText := Texto;

  EditBalloonTip.pszTitle := Titulo;

  EditBalloonTip.ttiIcon := Tipo;

  SendMessageW(Window, EM_SHOWBALLOONTIP, 0, Integer(@EditBalloonTip));
end;

end.
