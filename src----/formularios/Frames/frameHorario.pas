unit frameHorario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, Spin;

type
  THorario = class(TFrame)
    lblNomeDoHorario: TGroupBox;
    lblHoras: TStaticText;
    edtHoras: TSpinEdit;
    lblMinutos: TStaticText;
    edtMinutos: TSpinEdit;
    edtSegundos: TSpinEdit;
    lblSegundos: TStaticText;
    lblPrimeiraSeparacao: TStaticText;
    lblSegundaSeparacao: TStaticText;

  private
    procedure SetHorario(const Value: TDateTime);
    function GetHorario: TDateTime;

  public
    property Horario :TDateTime read GetHorario write SetHorario;
  end;

implementation

uses DateUtils;

{$R *.dfm}

{ Thorario }

function THorario.GetHorario: TDateTime;
var
  Ano, Mes, Dia, Horas, Minutos, Segundos, Milisegundos :Word;
begin
   Ano          := 2001;
   Mes          := 1;
   Dia          := 1;
   Horas        := StrToIntDef(self.edtHoras.Text, 0);
   Minutos      := StrToIntDef(self.edtMinutos.Text, 0);
   Segundos     := StrToIntDef(self.edtSegundos.Text, 0);
   Milisegundos := 0;

   result := EncodeDateTime(Ano, Mes, Dia, Horas, Minutos, Segundos, Milisegundos);
end;

procedure THorario.SetHorario(const Value: TDateTime);
var
  Ano, Mes, Dia, Horas, Minutos, Segundos, Milisegundos :Word;
begin
  if (Value > 0) then begin
    DecodeDateTime(Value, Ano, Mes, Dia, Horas, Minutos, Segundos, Milisegundos);
    self.edtHoras.Text    := IntToStr(Horas);
    self.edtMinutos.Text  := IntToStr(Minutos);
    self.edtSegundos.Text := IntToStr(Segundos);
  end;
end;

end.
