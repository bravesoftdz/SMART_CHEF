unit uFinalizaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, ExtCtrls,
  ImgList, pngimage, DB, DBClient, Grids, DBGrids;

type
  TfrmFinalizaPedido = class(TfrmPadrao)
    Panel1: TPanel;
    btnCancela: TBitBtn;
    btnConfirma: TBitBtn;
    gridAgrupa: TDBGrid;
    cdsMoedas: TClientDataSet;
    dsAgrupaComanda: TDataSource;
    cdsMoedasTIPO_MOEDA: TIntegerField;
    cdsMoedasVALOR_PAGO: TFloatField;
    cdsMoedasMOEDA: TStringField;
    Label26: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmbTipoMoeda: TComboBox;
    edtTotalPedido: TCurrencyEdit;
    edtValorPago: TCurrencyEdit;
    edtTroco: TCurrencyEdit;
    ckbSC: TCheckBox;
    edtTotalRestante: TCurrencyEdit;
    edtValorParcial: TCurrencyEdit;
    Label6: TLabel;
    chkImprimeItens: TCheckBox;
    Shape1: TShape;
    procedure edtValorPagoChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridAgrupaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtValorPagoExit(Sender: TObject);
    procedure cdsMoedasAfterPost(DataSet: TDataSet);
    procedure edtTotalPedidoChange(Sender: TObject);
    procedure cdsMoedasBeforeDelete(DataSet: TDataSet);
    procedure edtValorParcialChange(Sender: TObject);
    procedure edtValorParcialKeyPress(Sender: TObject; var Key: Char);
  private
    procedure verifica_pago;
  public
    { Public declarations }
  end;

var
  frmFinalizaPedido: TfrmFinalizaPedido;

implementation

uses Math;

{$R *.dfm}

procedure TfrmFinalizaPedido.edtValorPagoChange(Sender: TObject);
begin
  edtTroco.Clear;

  if (edtValorParcial.Value > 0) and (edtValorPago.Value > edtValorParcial.Value) then
    edtTroco.Value := edtValorPago.Value - edtValorParcial.Value
  else if edtValorPago.Value > edtTotalRestante.Value then
    edtTroco.Value := edtValorPago.Value - edtTotalRestante.Value;

end;

procedure TfrmFinalizaPedido.btnConfirmaClick(Sender: TObject);
begin
  cdsMoedas.First;

  if (cdsMoedas.IsEmpty) then begin
    avisar('Valor pago não foi informado.');
    edtValorPago.SetFocus;
  end
  else
    self.ModalResult := mrOk;
end;

procedure TfrmFinalizaPedido.btnCancelaClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmFinalizaPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (btnConfirma.Enabled) and ((key = VK_F3) or (Key = Vk_F10)) then begin
    ckbSC.Checked := (Key = Vk_F10);
    btnConfirma.Click;
  end;

  if key = 80 then
    edtValorParcial.SetFocus
  else if key = 77 then
    cmbTipoMoeda.SetFocus;

  inherited;

end;

procedure TfrmFinalizaPedido.gridAgrupaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    if (cdsMoedas.Active) and not(cdsMoedas.IsEmpty) then
      cdsMoedas.Delete;
end;

procedure TfrmFinalizaPedido.FormShow(Sender: TObject);
begin
  cdsMoedas.CreateDataSet;
end;

procedure TfrmFinalizaPedido.edtValorPagoExit(Sender: TObject);
begin
  if edtValorPago.Value > 0 then begin

    if (edtValorParcial.Value > 0) and (edtValorPago.Value < edtValorParcial.Value) then begin
      avisar('O valor pago deve ser maior que o valor parcial informado!');
      abort;
    end
    else if cmbTipoMoeda.ItemIndex < 0 then begin
       avisar('Tipo da moeda não foi informado');
       edtValorPago.Clear;
       cmbTipoMoeda.SetFocus;
    end
    else begin

      if (cdsMoedas.Locate('MOEDA',cmbTipoMoeda.Items[cmbTipoMoeda.ItemIndex],[])) then
        cdsMoedas.Edit
      else
        cdsMoedas.Append;

      cdsMoedasTIPO_MOEDA.AsInteger := cmbTipoMoeda.ItemIndex + 1;
      cdsMoedasMOEDA.AsString       := cmbTipoMoeda.Items[ cmbTipoMoeda.itemIndex ];

      if (edtValorPago.Value > edtTotalRestante.Value) and not(edtValorParcial.Value > 0) then
        cdsMoedasVALOR_PAGO.AsFloat   := cdsMoedasVALOR_PAGO.AsFloat + edtTotalRestante.Value
      else
        cdsMoedasVALOR_PAGO.AsFloat   := cdsMoedasVALOR_PAGO.AsFloat + IfThen(edtValorParcial.Value > 0, edtValorParcial.Value, edtValorPago.Value);

      cdsMoedas.Post;

      if (edtValorPago.Value > edtTotalRestante.Value) and not(edtValorParcial.Value > 0) then
        edtTotalRestante.Value := edtTotalRestante.Value - edtTotalRestante.Value
      else
        edtTotalRestante.Value := edtTotalRestante.Value - IfThen(edtValorParcial.Value > 0, edtValorParcial.Value, edtValorPago.Value);

      edtValorPago.Clear;

      if not(edtValorParcial.Value > 0) then
        cmbTipoMoeda.ItemIndex := -1;

    end;

    if edtValorParcial.Value > 0 then begin
      edtValorParcial.SetFocus;
      edtValorParcial.Clear;
    end
    else
      cmbTipoMoeda.SetFocus;
    edtTroco.Clear;

  end;
end;

procedure TfrmFinalizaPedido.verifica_pago;
var total_pago :Double;
begin
  total_pago := 0;

  cdsMoedas.First;
  while not cdsMoedas.Eof do begin

    total_pago := total_pago + cdsMoedasVALOR_PAGO.Value;

    cdsMoedas.Next;
  end;

  btnConfirma.Enabled :=  (FloatToStr(total_pago) = FloatToStr(edtTotalPedido.Value));
end;

procedure TfrmFinalizaPedido.cdsMoedasAfterPost(DataSet: TDataSet);
begin
  verifica_pago;
end;

procedure TfrmFinalizaPedido.edtTotalPedidoChange(Sender: TObject);
begin
  edtTotalRestante.Value := edtTotalPedido.Value;
end;

procedure TfrmFinalizaPedido.cdsMoedasBeforeDelete(DataSet: TDataSet);
begin
  edtTotalRestante.Value := edtTotalRestante.Value + cdsMoedasVALOR_PAGO.AsFloat;

  inherited;

end;

procedure TfrmFinalizaPedido.edtValorParcialChange(Sender: TObject);
begin
  if edtValorParcial.Value >= edtTotalRestante.Value then begin
    avisar('Atenção! O valor parcial deve ser menor que o restante a ser pago.');
    edtValorParcial.Clear;
  end;
end;

procedure TfrmFinalizaPedido.edtValorParcialKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    Key := ',';
end;

end.
