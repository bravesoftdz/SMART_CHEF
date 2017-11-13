unit uInputBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, TipoDado, RxToolEdit, RxCurrEdit;

type
  TfrmInputBox = class(TForm)
    Panel1: TPanel;
    panTopo: TPanel;
    Label1: TLabel;
    panCentro: TPanel;
    panRodaPe: TPanel;
    panBotoes: TPanel;
    btnCancela: TBitBtn;
    btnConfirma: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    procedure ComponenteRetornoChange(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ComponenteRetornoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memRetornoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    FTipoRetorno :TTipoDado;
    FRetorno :variant;
    FComponenteRetorno :TCustomEdit;

    NumDigitado :String;
    tipo :String;

    procedure trataRetorno;

    procedure configuraTela;
    procedure configuraEventos;
  public

    property Retorno :variant  read FRetorno;

    constructor Create(AOwner: TComponent; titulo: String; TipoDado :TTipoDado); overload; virtual;
  end;

var
  frmInputBox: TfrmInputBox;

implementation

{$R *.dfm}

constructor TfrmInputBox.Create(AOwner: TComponent; titulo: String; TipoDado :TTipoDado);
begin
  self.Create(aOwner);
  label1.Caption := titulo;
  FTipoRetorno   := tipoDado;
  configuraTela;
  configuraEventos;
end;

procedure TfrmInputBox.configuraEventos;
begin
  case FTipoRetorno of
    tpInteiro, tpMoeda, tpQuantidade:
      begin
        TCurrencyEdit(FComponenteRetorno).OnChange := ComponenteRetornoChange;
       // TCurrencyEdit(FComponenteRetorno).OnExit   := ComponenteRetornoExit;
      end;
    tpNome:
      begin
        TEdit(FComponenteRetorno).OnChange := ComponenteRetornoChange;
       // TEdit(FComponenteRetorno).OnExit   := ComponenteRetornoExit;
      end;
    tpTexto:
      begin
        TMemo(FComponenteRetorno).OnChange := ComponenteRetornoChange;
       // TMemo(FComponenteRetorno).OnExit   := ComponenteRetornoExit;
      end;
    tpData:
      begin
        TMaskEdit(FComponenteRetorno).OnChange := ComponenteRetornoChange;
        TMaskEdit(FComponenteRetorno).OnExit   := ComponenteRetornoExit;
      end;
  end;
end;

procedure TfrmInputBox.configuraTela;
begin
  case FTipoRetorno of
    tpInteiro:
      begin
        FComponenteRetorno := TCurrencyEdit.Create(nil);
        TCurrencyEdit(FComponenteRetorno).DisplayFormat := '0';
        TCurrencyEdit(FComponenteRetorno).Text          := '0';
      end;
    tpMoeda:
      begin
        FComponenteRetorno := TCurrencyEdit.Create(nil);
        TCurrencyEdit(FComponenteRetorno).DisplayFormat := 'R$ ,0.00;-,0.00';
        TCurrencyEdit(FComponenteRetorno).Text          := '0,001';
      end;
    tpQuantidade:
      begin
        FComponenteRetorno := TCurrencyEdit.Create(nil);
        TCurrencyEdit(FComponenteRetorno).DisplayFormat := ',0.000;-,0.000';
        TCurrencyEdit(FComponenteRetorno).DecimalPlaces := 3;
        TCurrencyEdit(FComponenteRetorno).Text          := '0,0001';
      end;
    tpNome:
        FComponenteRetorno := TEdit.Create(nil);
    tpTexto:
        FComponenteRetorno := TMemo.Create(nil);
    tpData:
      begin
        TMaskEdit(FComponenteRetorno).EditMask := '!99/99/9999;1; ';
      end;
  end;

  FComponenteRetorno.Parent := panCentro;

  case FTipoRetorno of
    tpInteiro, tpMoeda, tpQuantidade:
      begin
         FComponenteRetorno.Left := trunc((panCentro.Width/2) - (FComponenteRetorno.Width/2));
         FComponenteRetorno.top  := trunc((panCentro.Height/2) - (FComponenteRetorno.Height/2));
      end;
    tpNome:
      begin
        self.Width := 500;
        FComponenteRetorno.Left   := 40;
        FComponenteRetorno.Width  := self.Width - 80;
        FComponenteRetorno.Height := trunc((panCentro.Height/2) - (FComponenteRetorno.Height/2));
      end;
    tpTexto:
      begin
        self.Width               := 600;
        self.Height              := 200;
        FComponenteRetorno.Top    := 5;
        FComponenteRetorno.Left   := 30;
        FComponenteRetorno.Width  := self.Width - 60;
        FComponenteRetorno.Height := self.Height - 10;
      end;
  end;

  FComponenteRetorno.SelectAll;
end;

procedure TfrmInputBox.ComponenteRetornoChange(Sender: TObject);
begin
  case FTipoRetorno of
    tpInteiro:             FRetorno := TCurrencyEdit(Sender).AsInteger;
    tpMoeda, tpQuantidade: FRetorno := TCurrencyEdit(Sender).Value;
    tpNome:                FRetorno := TEdit(Sender).Text;
    tpTexto:               FRetorno := TMemo(Sender).Lines.Text;
    tpData:                FRetorno := StrToDate(TMaskEdit(Sender).Text);
  end;
end;

procedure TfrmInputBox.btnCancelaClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmInputBox.btnConfirmaClick(Sender: TObject);
begin
  self.ModalResult := mrOk;
end;

procedure TfrmInputBox.trataRetorno;
begin

end;

procedure TfrmInputBox.ComponenteRetornoExit(Sender: TObject);
begin
  if FTipoRetorno = tpData then begin
    try
      strToDate(FComponenteRetorno.Text);
    except
      showmessage('Data inválida');
      FComponenteRetorno.SetFocus;
    end;
  end;
end;

procedure TfrmInputBox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
    btnCancela.Click;
end;

procedure TfrmInputBox.FormShow(Sender: TObject);
begin
  FComponenteRetorno.SetFocus;
end;

procedure TfrmInputBox.memRetornoKeyPress(Sender: TObject; var Key: Char);
begin
  If ( key in[';'] ) then
    key:=#0;
end;

end.
