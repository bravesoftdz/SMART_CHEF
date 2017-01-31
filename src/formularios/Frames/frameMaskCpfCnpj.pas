unit frameMaskCpfCnpj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask;

type
  TMaskCpfCnpj = class(TFrame)
    edtCpf: TMaskEdit;
    comPessoa: TComboBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label19: TLabel;
    procedure comPessoaChange(Sender: TObject);
  private
    Fpessoa: String;
    procedure Setpessoa(const Value: String);
    procedure SetCpfCnpj(const Value: String);
    function GetPessoa: String;
    { Private declarations }
  public
    procedure Limpa;

    property pessoa :String read GetPessoa write Setpessoa;
    property cpfCnpj :String write SetCpfCnpj;
  end;

implementation

uses Math, StrUtils;

{$R *.dfm}

{ TFrame1 }

procedure TMaskCpfCnpj.Setpessoa(const Value: String);
begin
  Fpessoa := Value;
  if FPessoa = 'F' then begin
    comPessoa.ItemIndex := 0;

    if length(edtCpf.Text) > 11 then   edtCpf.Text := copy(edtCpf.Text,1,11);

    edtCpf.EditMask := '999\.999\.999\-99;0; ';
    StaticText2.Caption := 'CPF';
  end
  else if Pessoa = 'J' then begin
    comPessoa.ItemIndex := 1;
    edtCpf.EditMask := '99\.999\.999/9999\-99;0; ';
    StaticText2.Caption := 'CNPJ';
  end;
end;

procedure TMaskCpfCnpj.comPessoaChange(Sender: TObject);
begin
  if comPessoa.ItemIndex = 0 then begin

    if length(edtCpf.Text) > 11 then   edtCpf.Text := copy(edtCpf.Text,1,11);

    edtCpf.EditMask := '999\.999\.999\-99;0; ';
    StaticText2.Caption := 'CPF';
  end
  else if comPessoa.ItemIndex = 1 then begin
    edtCpf.EditMask := '99\.999\.999/9999\-99;0; ';
    StaticText2.Caption := 'CNPJ';
  end;
end;

function TMaskCpfCnpj.GetPessoa: String;
begin
  result := IfThen(edtCpf.EditMask = '999\.999\.999\-99;0; ', 'F', 'J');
end;

procedure TMaskCpfCnpj.Limpa;
begin
  edtCpf.Clear;
end;

procedure TMaskCpfCnpj.SetCpfCnpj(const Value: String);
begin
   if length(value) > 0 then
     Setpessoa( IfThen( length(value) > 11, 'J', 'F') );
   edtCpf.Text := Value;
end;

end.
