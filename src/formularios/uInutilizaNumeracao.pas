unit uInutilizaNumeracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TfrmInutilizaNumeracao = class(TfrmPadrao)
    panCorpo: TPanel;
    Shape1: TShape;
    Shape3: TShape;
    Shape2: TShape;
    lbTitulo: TLabel;
    btnOk: TBitBtn;
    BitBtn1: TBitBtn;
    edtInicial: TCurrencyEdit;
    Label3: TLabel;
    Label1: TLabel;
    memoJustificativa: TMemo;
    Label2: TLabel;
    edtFinal: TSpinEdit;
    procedure btnOkClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtInicialChange(Sender: TObject);
    procedure edtFinalChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
                                                                
var
  frmInutilizaNumeracao: TfrmInutilizaNumeracao;

implementation

uses uModulo;

{$R *.dfm}

procedure TfrmInutilizaNumeracao.BitBtn1Click(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmInutilizaNumeracao.btnOkClick(Sender: TObject);
begin
  self.ModalResult := mrOk;
end;

procedure TfrmInutilizaNumeracao.edtFinalChange(Sender: TObject);
begin
  if edtInicial.Value > edtFinal.Value then
    edtInicial.Value := edtFinal.Value;
end;

procedure TfrmInutilizaNumeracao.edtInicialChange(Sender: TObject);
begin
  edtFinal.Value := edtInicial.AsInteger;
end;

procedure TfrmInutilizaNumeracao.FormCreate(Sender: TObject);
begin
  inherited;
  edtInicial.MaxValue := dm.GetValorGenerator('gen_nrnota_nfce');
  edtFinal.MaxValue   := dm.GetValorGenerator('gen_nrnota_nfce');
end;

end.
