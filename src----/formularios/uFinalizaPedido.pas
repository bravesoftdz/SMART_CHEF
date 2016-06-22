unit uFinalizaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, ExtCtrls,
  ImgList, pngimage, DB, DBClient, Grids, DBGrids, ContNrs, Item, Menus, AdicionalItem;

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
    DBGrid1: TDBGrid;
    dsItens: TDataSource;
    DBGrid2: TDBGrid;
    Label7: TLabel;
    cdsAdicionais: TClientDataSet;
    dsAdicionais: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensCODIGO_ITEM: TIntegerField;
    cdsItensPRODUTO: TStringField;
    cdsItensQUANTIDADE: TFloatField;
    cdsItensVLR_UNITARIO: TFloatField;
    cdsItensQTD_PAGA: TFloatField;
    PopupMenu1: TPopupMenu;
    FracionarItem1: TMenuItem;
    cdsItensFRACIONADO: TStringField;
    Label8: TLabel;
    Label10: TLabel;
    Image1: TImage;
    Image2: TImage;
    cdsItensQTD_A_PAGAR: TFloatField;
    cdsItensPrePagos: TClientDataSet;
    cdsItensPrePagosCODIGO_ITEM: TIntegerField;
    cdsItensPrePagosQUANTIDADE: TFloatField;
    btnOk: TBitBtn;
    pnlExtorna: TPanel;
    DBGrid3: TDBGrid;
    dsItensPrePagos: TDataSource;
    cdsItensPrePagosPRODUTO: TStringField;
    cdsItensPrePagosVALOR: TFloatField;
    cdsItensPrePagosMOEDA: TStringField;
    btnVoltar: TSpeedButton;
    btnEstornar: TSpeedButton;
    cdsItensVLR_TOTAL: TFloatField;
    cdsItensVLR_PAGO: TFloatField;
    Shape1: TShape;
    Shape2: TShape;
    Label9: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    Label12: TLabel;
    chkSelecionarPendentes: TCheckBox;
    chkImprimeItens: TCheckBox;
    btnFracionaItem: TBitBtn;
    Label13: TLabel;
    edtTxServico: TCurrencyEdit;
    procedure edtValorPagoChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridAgrupaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsMoedasAfterPost(DataSet: TDataSet);
    procedure edtTotalPedidoChange(Sender: TObject);
    procedure cdsMoedasBeforeDelete(DataSet: TDataSet);
    procedure edtValorParcialChange(Sender: TObject);
    procedure edtValorParcialKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure btnOkClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnEstornarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkSelecionarPendentesClick(Sender: TObject);
    procedure FracionarItem1Click(Sender: TObject);
  private
    Itens :TObjectList;

  private
    procedure verifica_pago;
    procedure SetupGridPickList(const FieldName : string);
    function possui_item_adicionado(codigo_item :integer):boolean;

    procedure agrupa_itens_iguais;
    procedure calcula_totais;
    procedure armazena_pre_pagos;
    procedure carrega_movimentos;
    procedure fraciona_item;

    function verifica_obrigatorio :Boolean;

    function total_prepago(codigo_item :integer) :Real;
    function valor_item(quantidade :Real) :Real;

  public
    codigo_pedido :integer;
    houve_agrupamento :Boolean;

    procedure preenche_cds(cds :TClientDataSet);
  end;

var
  frmFinalizaPedido: TfrmFinalizaPedido;

implementation

uses Math, uModulo, Repositorio, FabricaRepositorio, Produto, MateriaPrima, EspecificacaoMovimentosPorCodigoPedido,
     Movimento, StrUtils;

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
  if edtTotalRestante.Value = edtTotalPedido.Value then begin
    avisar('Nenhum valor foi informado, para efetuar o recebimento.');
    DBGrid1.SetFocus;
    exit;
  end;

  cdsMoedas.First;

  if (cdsMoedas.IsEmpty) then begin
    avisar('Valor pago não foi informado.');
    edtValorPago.SetFocus;
  end
  else begin
    if confirma('Confirma recebimento '+IfThen(edtTotalRestante.Value = 0, 'TOTAL','PARCIAL')+' do pedido?') then
      self.ModalResult := mrOk;
  end;
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

  if (key = VK_Escape) and (pnlExtorna.Visible) then
    btnVoltar.Click;

  if key = 80 then
    edtValorParcial.SetFocus
  else if key = 77 then
    cmbTipoMoeda.SetFocus;

  if Key = VK_DELETE then
    if cdsItensPrePagos.IsEmpty then
       avisar('Não existem itens a serem estornados')
    else begin
       pnlExtorna.Left    := trunc(self.Width / 4);
       pnlExtorna.Visible := true;
    end;

  inherited;
end;

procedure TfrmFinalizaPedido.gridAgrupaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
 //   if (cdsMoedas.Active) and not(cdsMoedas.IsEmpty) then
  //    if cdsItensPrePagos.IsEmpty then
  //      cdsMoedas.Delete
  //    else begin
        if cdsItensPrePagos.IsEmpty then
          avisar('Não existem itens a serem estornados')
        else
          pnlExtorna.Left := trunc(self.Width / 4);
    //  end;
end;

procedure TfrmFinalizaPedido.FormShow(Sender: TObject);
begin
  cdsMoedas.CreateDataSet;
  DBGrid1.SelectedIndex := 6;
  TNumericField(cdsAdicionais.Fields[2]).DisplayFormat := ',0.00; ,0.00';
  label26.Caption := '<DELETE> Estornar itens';
  cdsItensAfterScroll(nil);

  (cdsAdicionais.fieldByName('QUANTIDADE') as TFloatField).DisplayFormat     := ',0.00; ,0.00';
  (cdsAdicionais.fieldByName('VALOR_UNITARIO') as TFloatField).DisplayFormat := ',0.00; ,0.00';

  carrega_movimentos;
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

 // btnConfirma.Enabled :=  (FloatToStr(total_pago) = FloatToStr(edtTotalPedido.Value));
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
  if edtValorParcial.Value > edtTotalRestante.Value then begin
    avisar('Atenção! O valor parcial deve ser menor = que o restante a ser pago.');
    edtValorParcial.Clear;
  end
  else if (edtValorParcial.Value + edtTxServico.Value) = edtTotalRestante.Value then
    edtValorParcial.Value := edtValorParcial.Value + edtTxServico.Value;
end;

procedure TfrmFinalizaPedido.edtValorParcialKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    Key := ',';
end;

procedure TfrmFinalizaPedido.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsItensPrePagos.CreateDataSet;
  houve_agrupamento := false;
end;

procedure TfrmFinalizaPedido.SetupGridPickList(const FieldName: string);
var
  slPickList:TStringList;
  i : integer;
begin
  slPickList:=TStringList.Create;
  try

    //Preencher o string list
    slPickList.Add('Dinheiro');
    slPickList.Add('Cheque');
    slPickList.Add('Cartão Crédito');
    slPickList.Add('Cartão Débito');

    //colocar a lista na coluna correta
    for i := 0 to DBGrid1.Columns.Count-1 do
      if DBGrid1.Columns[i].FieldName = FieldName then begin
        DBGrid1.Columns[i].PickList := slPickList;
        Break;
      end;

  finally
    slPickList.Free;
  end;

end;

procedure TfrmFinalizaPedido.agrupa_itens_iguais;
var produto :String;
    quantidade :Real;
    repositorio :TRepositorio;
    Item        :TItem;
    linha, id_pro :Integer;
begin
  quantidade := 0;
  cdsItens.IndexFieldNames := 'PRODUTO';
  cdsItens.First;

  repositorio := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

  while not cdsItens.Eof do begin

    if (produto = '') and not possui_item_adicionado(cdsItensCODIGO_ITEM.AsInteger) and not (cdsItensFRACIONADO.AsString = 'S') then begin
       produto := cdsItensPRODUTO.AsString;
       id_pro  := cdsItens.RecNo;
    end
    else begin

       if (produto = cdsItensPRODUTO.AsString) then begin

         if possui_item_adicionado(cdsItensCODIGO_ITEM.AsInteger) or (cdsItensFRACIONADO.AsString = 'S') then begin
           cdsItens.Next;
           continue;
         end;
          quantidade := cdsItensQUANTIDADE.AsFloat;

          repositorio.RemoverPorIdentificador(cdsItensCODIGO_ITEM.AsInteger);
          cdsItens.Delete;

          cdsItens.RecNo := id_pro;

          cdsItens.Edit;
          cdsItensQUANTIDADE.AsFloat := cdsItensQUANTIDADE.AsFloat + quantidade;
          cdsItensVLR_TOTAL.AsFloat  := cdsItensQUANTIDADE.AsFloat * cdsItensVLR_UNITARIO.AsFloat;
          cdsItens.Post;

          Item := TItem(repositorio.Get(cdsItensCODIGO_ITEM.AsInteger));
          Item.quantidade := cdsItensQUANTIDADE.AsFloat;
          repositorio.Salvar(Item);

          houve_agrupamento := true;
       end
       else if not (cdsItensFRACIONADO.AsString = 'S') then begin
          produto := cdsItensPRODUTO.AsString;
          id_pro  := cdsItens.RecNo;
       end;


    end;
    cdsItens.Next;
  end;
end;

function TfrmFinalizaPedido.possui_item_adicionado(codigo_item: integer): boolean;
begin
  result := false;

  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'select codigo from adicionais_item                   '+
                             ' where codigo_item = :cod_item and valor_unitario > 0';

  dm.qryGenerica.ParamByName('cod_item').AsInteger := codigo_item;
  dm.qryGenerica.Open;

  result := not (dm.qryGenerica.IsEmpty);
end;

procedure TfrmFinalizaPedido.preenche_cds(cds: TClientDataSet);
begin
  cdsItens.AfterScroll := nil;
  cds.First;
  while not cds.Eof do begin
    cdsItens.Append;
    cdsItensCODIGO_ITEM.AsInteger := cds.fieldByName('CODIGO').AsInteger;
    cdsItensPRODUTO.AsString      := cds.fieldByName('DESCRICAO').AsString;
    cdsItensQUANTIDADE.AsFloat    := cds.fieldByName('QUANTIDADE').AsFloat;
    cdsItensVLR_UNITARIO.AsFloat  := cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensVLR_TOTAL.AsFloat     := cds.fieldByName('QUANTIDADE').AsFloat * cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensVLR_PAGO.AsFloat      := cds.fieldByName('QUANTIDADE_PG').AsFloat * cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensFRACIONADO.AsString   := cds.fieldByName('FRACIONADO').AsString;
    cdsItensQTD_PAGA.AsFloat      := cds.fieldByName('QUANTIDADE_PG').AsFloat;
    cdsItensQTD_A_PAGAR.AsFloat   := 0;
    cdsItens.Post;

    cds.Next;
  end;

  agrupa_itens_iguais;

  cdsItens.AfterScroll := cdsItensAfterScroll;

  cdsItens.RecNo := 1;
end;

procedure TfrmFinalizaPedido.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if cdsItens.State in [dsInsert] then begin
    cdsItens.Cancel;
    exit;
  end;

  cdsAdicionais.Filtered := false;

  cdsAdicionais.Filter   := 'CODIGO_ITEM = '+cdsItensCODIGO_ITEM.AsString;
  cdsAdicionais.Filtered := true;

  btnFracionaItem.Enabled := not (cdsItensVLR_PAGO.AsFloat > 0);

  if cdsItensVLR_PAGO.AsFloat > 0 then
    DBGrid1.PopupMenu := nil
  else
    DBGrid1.PopupMenu := PopupMenu1;  
end;

procedure TfrmFinalizaPedido.DBGrid1Enter(Sender: TObject);
begin
  DBGrid1.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.DBGrid1ColEnter(Sender: TObject);
begin
  DBGrid1.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.DBGrid1CellClick(Column: TColumn);
begin
  DBGrid1.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Column.Field.FieldName = 'QTD_PAGA') or (Column.Field.FieldName = 'VLR_PAGO') then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00D5F5CF;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (Column.Field.FieldName = 'QTD_A_PAGAR') then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00FFEBD7;
     TDBGrid(Sender).Canvas.Font.Style  := [fsBold];
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (Column.Field.FieldName = 'QUANTIDADE') or (Column.Field.FieldName = 'VLR_TOTAL') then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00EFEFEF;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (Column.Field.FieldName = 'PRODUTO') and (cdsItensQUANTIDADE.AsFloat = cdsItensQTD_PAGA.asFloat) then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00D5F5CF;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (Column.Field.FieldName = 'PRODUTO') and (cdsItensQTD_A_PAGAR.AsFloat > 0) then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00F9D986;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else begin
     TDBGrid(Sender).Canvas.Brush.Color := clwhite;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;



  if (gdSelected in State) then begin
    TDBGrid(Sender).Canvas.Brush.Color := $00B97E11;
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmFinalizaPedido.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['+','-']) then key := #0;

  if (key = '+') or (key = '-') then begin
    try

       if (cdsItensFRACIONADO.AsString = 'S')and cdsItensPrePagos.Locate('CODIGO_ITEM', cdsItensCODIGO_ITEM.AsInteger,[]) then
         Exit;
       if (key = '+') and (cdsItensQTD_A_PAGAR.AsFloat = (cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat)) then
         Exit;
       if (key = '-') and ((cdsItensQTD_A_PAGAR.AsFloat = 0)or(total_prepago(cdsItensCODIGO_ITEM.AsInteger) = cdsItensQTD_A_PAGAR.AsFloat)) then
         Exit;

       cdsItens.Edit;

       if cdsItensFRACIONADO.AsString = 'S' then
         cdsItensQTD_A_PAGAR.AsFloat := cdsItensQTD_A_PAGAR.AsFloat + IfThen(key = '+',cdsItensQUANTIDADE.AsFloat,-cdsItensQUANTIDADE.AsFloat)
       else
         cdsItensQTD_A_PAGAR.AsFloat := cdsItensQTD_A_PAGAR.AsFloat + IfThen(key = '+',1,-1);

       cdsItens.Post;

    finally
      Key := #0;
    end;
  end;

  inherited;
end;

procedure TfrmFinalizaPedido.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (Column.Field.FieldName = 'VALOR') then begin
     TDBGrid(Sender).Canvas.Brush.Color := $00D5F5CF;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmFinalizaPedido.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  calcula_totais;
end;

procedure TfrmFinalizaPedido.calcula_totais;
var linha :integer;
begin
  linha := cdsItens.RecNo;
  cdsItens.DisableControls;
  cdsItens.First;

  edtValorParcial.Value := 0;

  while not cdsItens.Eof do begin

    if cdsItensQTD_A_PAGAR.AsFloat > 0 then begin
      edtValorParcial.Value := edtValorParcial.Value + (cdsItensQTD_A_PAGAR.AsFloat * cdsItensVLR_UNITARIO.AsFloat);

      cdsAdicionais.First;
      while not cdsAdicionais.Eof do begin
         edtValorParcial.Value := edtValorParcial.Value + (cdsAdicionais.fieldByName('VALOR').AsFloat * cdsItensQTD_A_PAGAR.AsFloat);

         cdsAdicionais.Next;
      end;
    end;

    cdsItens.Next;
  end;

  cdsItens.EnableControls;
  cdsItens.RecNo := linha;
end;

procedure TfrmFinalizaPedido.btnOkClick(Sender: TObject);
begin
  if not verifica_obrigatorio then
    exit;

  if edtValorPago.Value > 0 then begin

    if (edtValorParcial.Value > 0) and (edtValorPago.Value < edtValorParcial.Value) then begin
      avisar('O valor pago deve ser maior que o valor parcial informado!');
      edtValorPago.SetFocus;
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

  armazena_pre_pagos;
  DBGrid1.SetFocus;
{  if edtTotalRestante.Value = 0 then
    GroupBox1.Enabled := false; }
end;

procedure TfrmFinalizaPedido.armazena_pre_pagos;
var linha :integer;
begin
  linha := cdsItens.RecNo;
  cdsItens.DisableControls;
  cdsItens.First;
  cdsItens.AfterPost := nil;

  while not cdsItens.Eof do begin

    if cdsItensQTD_A_PAGAR.AsFloat > 0 then begin

      cdsItensPrePagos.Append;
      cdsItensPrePagosCODIGO_ITEM.AsInteger := cdsItensCODIGO_ITEM.AsInteger;
      cdsItensPrePagosQUANTIDADE.AsFloat    := cdsItensQTD_A_PAGAR.AsFloat;
      cdsItensPrePagosMOEDA.AsString        := cmbTipoMoeda.Items[cmbTipoMoeda.itemIndex];
      cdsItensPrePagosPRODUTO.AsString      := cdsItensPRODUTO.AsString;
      cdsItensPrePagosVALOR.AsFloat         := valor_item(cdsItensQTD_A_PAGAR.AsFloat);
      cdsItensPrePagos.Post;

      cdsItens.Edit;
      cdsItensQTD_PAGA.AsFloat    := cdsItensQTD_PAGA.AsFloat + cdsItensQTD_A_PAGAR.AsFloat;
      cdsItensVLR_PAGO.AsFloat    := cdsItensVLR_PAGO.AsFloat + (cdsItensQTD_A_PAGAR.AsFloat * cdsItensVLR_UNITARIO.AsFloat);
      cdsItensQTD_A_PAGAR.AsFloat := 0;
      cdsItens.Post;

    end;

    cdsItens.Next;
  end;

  cdsItens.AfterPost := cdsItensAfterPost;
  cdsItens.EnableControls;
  cdsItens.RecNo := linha;
end;

function TfrmFinalizaPedido.total_prepago(codigo_item :integer): Real;
begin
  Result := 0;

  cdsItensPrePagos.First;
  while not cdsItensPrePagos.Eof do begin

    result := result + IfThen(cdsItensPrePagosCODIGO_ITEM.AsInteger = codigo_item, cdsItensPrePagosQUANTIDADE.AsFloat, 0);
    cdsItensPrePagos.Next;
  end;
end;

procedure TfrmFinalizaPedido.btnVoltarClick(Sender: TObject);
begin
  inherited;
  pnlExtorna.Left    := 1250;
  pnlExtorna.Visible := false;
end;

procedure TfrmFinalizaPedido.btnEstornarClick(Sender: TObject);
begin
  if confirma('Estornar recebimento do item selecionado?'+#13#10+cdsItensPrePagosPRODUTO.AsString+' (recebido em '+cdsItensPrePagosMOEDA.asString+')') then begin
    cdsItens.Locate('CODIGO_ITEM',cdsItensPrePagosCODIGO_ITEM.AsInteger, []);
    cdsItens.Edit;
    cdsItensQTD_PAGA.AsFloat := cdsItensQTD_PAGA.AsFloat - cdsItensPrePagosQUANTIDADE.AsFloat;
    cdsItens.Post;

    cdsMoedas.Locate('MOEDA', cdsItensPrePagosMOEDA.AsString, []);
    cdsMoedas.Edit;
    cdsMoedasVALOR_PAGO.AsFloat := cdsMoedasVALOR_PAGO.AsFloat - cdsItensPrePagosVALOR.AsFloat;
    cdsMoedas.Post;

    edtTotalRestante.Value := edtTotalRestante.Value + cdsItensPrePagosVALOR.AsFloat;

    if cdsMoedasVALOR_PAGO.AsFloat = 0 then
      cdsMoedas.Delete;

    cdsItensPrePagos.Delete;

    avisar('Item estornado!');

    if cdsItensPrePagos.IsEmpty then
      pnlExtorna.Left := 1050;
  end;
end;

function TfrmFinalizaPedido.valor_item(quantidade: Real): Real;
begin
  Result := 0;

  Result := cdsItensVLR_UNITARIO.AsFloat * quantidade;

  cdsAdicionais.First;
  while not cdsAdicionais.Eof do begin

    result := result + cdsAdicionais.fieldByName('VALOR').AsFloat;
    cdsAdicionais.Next;
  end;
end;

function TfrmFinalizaPedido.verifica_obrigatorio :Boolean;
begin
  result := false;

  if cmbTipoMoeda.ItemIndex < 0 then begin
    avisar('O tipo da moeda deve ser informado');
    cmbTipoMoeda.SetFocus;
  end
  else if edtValorParcial.Value <= 0 then begin
    avisar('Nenhum item foi marcado como recebido');
    DBGrid1.SetFocus;
  end
  else if edtValorPago.Value <= 0 then begin
    avisar('O valor pago não foi informado');
    edtValorPago.SetFocus;
  end
  else
    result := true;
end;

procedure TfrmFinalizaPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 39) and (GroupBox1.Enabled) then
    edtValorPago.SetFocus;
end;

procedure TfrmFinalizaPedido.carrega_movimentos;
var repositorio :TRepositorio;
    Movimento   :TMovimento;
    Movimentos  :TObjectList;
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
    i :integer;
begin
  try
    repositorio := nil;
    Movimento   := nil;
    Movimentos  := nil;

    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( codigo_pedido );

    Movimentos    := repositorio.GetListaPorEspecificacao( Especificacao );

    if assigned(Movimentos) then
       for i := 0 to Movimentos.Count - 1 do begin
         cdsMoedas.Append;
         cdsMoedasTIPO_MOEDA.AsInteger := TMovimento(Movimentos.Items[i]).tipo_moeda;
         cdsMoedasVALOR_PAGO.AsFloat   := TMovimento(Movimentos.Items[i]).valor_pago;

         cmbTipoMoeda.ItemIndex        := TMovimento(Movimentos.Items[i]).tipo_moeda -1;

         cdsMoedasMOEDA.AsString       := cmbTipoMoeda.Items[ cmbTipoMoeda.itemIndex ];
         cdsMoedas.Post;

         edtTotalRestante.Value := edtTotalRestante.Value - TMovimento(Movimentos.Items[i]).valor_pago;
       end;

    cmbTipoMoeda.ItemIndex := -1;
  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Movimentos);
    FreeAndNil(Movimento);
  end;
end;

procedure TfrmFinalizaPedido.chkSelecionarPendentesClick(Sender: TObject);
var Tecla :char;
    nX :integer;
begin
  if chkSelecionarPendentes.Checked then begin
    chkSelecionarPendentes.Caption := 'Deselecionar produtos pendentes';
    edtValorPago.SetFocus;
  end
  else begin
    chkSelecionarPendentes.Caption := 'Selecionar produtos pendentes';
    DBGrid1.SetFocus;
  end;

  cdsItens.First;
  while not cdsItens.Eof do begin
    Tecla := IfThen(chkSelecionarPendentes.Checked, '+', '-')[1];

    cdsItens.Edit;
    cdsItensQTD_A_PAGAR.AsFloat := IfThen(chkSelecionarPendentes.Checked, (cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat), 0);
   // DBGrid1KeyPress(nil, Tecla);
    cdsItens.Post;

    cdsItens.Next;
  end;
end;

procedure TfrmFinalizaPedido.fraciona_item;
var partes, i, x, linha, qtd_ad:integer;
    Item   :TItem;
    Adicional :TAdicionalItem;
    repositorio :Trepositorio;
    repositorioAd :TRepositorio;
    contem_adicional :Boolean;
    sobra :Real;
    lista_adicionais :TObjectList;
begin
 try
    contem_adicional := false;
    sobra            := 0;
    partes           := StrToIntDef( chamaInput('INTEGER', 'Fracionar produto em quantas partes?'),0);

    if partes <= 1 then begin
      avisar('Quantidade de partes não informada. Operação cancelada.');
      Exit;
    end;

    if not cdsAdicionais.IsEmpty then begin
      contem_adicional := true;

      lista_adicionais := TObjectList.Create(true);
    end;

    repositorio      := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    Item            := TItem(repositorio.Get(cdsItensCODIGO_ITEM.AsInteger));

    sobra           := Item.quantidade; //recebe quantidade andes do fracionamento

    Item.quantidade := Item.quantidade / partes;
    Item.quantidade := Int(Item.quantidade*100)/100;
    Item.Fracionado := 'S';
    repositorio.Salvar(Item);

    sobra := sobra - (Item.quantidade * partes);

    Item.Adicionais.Free;

    if contem_adicional then begin
      repositorioAd := TFabricaRepositorio.GetRepositorio(TAdicionalItem.ClassName);

       cdsAdicionais.First;
       while not cdsAdicionais.Eof do begin

         if cdsAdicionais.FieldByName('VALOR').AsFloat > 0 then
         begin
            Adicional     := TAdicionalItem(repositorioAd.Get(cdsAdicionais.FieldByName('CODIGO').AsInteger) );

            repositorioAd.Salvar(Adicional);

            lista_adicionais.Add(Adicional);

         end;

         cdsAdicionais.Next;
       end;
    end;

    cdsItens.Edit;
    cdsItensQUANTIDADE.AsFloat  := cdsItensQUANTIDADE.AsFloat / partes;
    cdsItensQUANTIDADE.AsFloat  := Int(cdsItensQUANTIDADE.AsFloat*100)/100;
    cdsItensVLR_TOTAL.AsFloat   := cdsItensQUANTIDADE.AsFloat * cdsItensVLR_UNITARIO.AsFloat;
    cdsItensVLR_PAGO.AsFloat    := cdsItensQTD_PAGA.AsFloat * cdsItensVLR_UNITARIO.AsFloat;
    cdsItensFRACIONADO.AsString := 'S';
    cdsItens.Post;

    cdsItens.AfterScroll := nil;

    for i := 0 to partes -2 do begin
      Item.codigo := 0;
      Item.quantidade := cdsItensQUANTIDADE.AsFloat + IfThen(i = (partes - 2), sobra, 0);
      Item.Fracionado := 'S';
      repositorio.Salvar(Item);

      cdsItens.Insert;
      cdsItensCODIGO_ITEM.AsInteger := Item.codigo;
      cdsItensQUANTIDADE.AsFloat    := Item.quantidade;
      cdsItensPRODUTO.AsString      := Item.Produto.descricao;
      cdsItensVLR_UNITARIO.AsFloat  := Item.valor_Unitario;
      cdsItensVLR_TOTAL.AsFloat     := Item.quantidade * Item.valor_Unitario;
      cdsItensVLR_PAGO.AsFloat      := 0;
      cdsItensFRACIONADO.AsString   := 'S';
      cdsItensQTD_PAGA.AsFloat      := 0;
      cdsItensQTD_A_PAGAR.AsFloat   := 0;//Item.quantidade;
      cdsItens.Post;

      if contem_adicional then begin

         cdsAdicionais.First;
         qtd_ad := cdsAdicionais.RecordCount;

         for x := 0 to lista_adicionais.Count - 1 do begin

            TAdicionalItem(lista_adicionais.Items[x]).codigo      := 0;
            TAdicionalItem(lista_adicionais.Items[x]).codigo_item := Item.codigo;
            repositorioAd.Salvar( TAdicionalItem(lista_adicionais.Items[x]) );

            cdsAdicionais.Append;
            cdsAdicionais.FieldByName('CODIGO').AsInteger       := TAdicionalItem(lista_adicionais.Items[x]).codigo;
            cdsAdicionais.FieldByName('DESCRICAO').AsString     := TAdicionalItem(lista_adicionais.Items[x]).Materia.descricao;
            cdsAdicionais.FieldByName('VALOR').AsFloat          := TAdicionalItem(lista_adicionais.Items[x]).valor_unitario * TAdicionalItem(lista_adicionais.Items[x]).quantidade;
            cdsAdicionais.FieldByName('CODIGO_ITEM').AsInteger  := TAdicionalItem(lista_adicionais.Items[x]).codigo_item;
            cdsAdicionais.FieldByName('VALOR_UNITARIO').AsFloat := TAdicionalItem(lista_adicionais.Items[x]).valor_unitario;
            cdsAdicionais.FieldByName('QUANTIDADE').AsFloat     := TAdicionalItem(lista_adicionais.Items[x]).quantidade;
            cdsAdicionais.Post;

         end;

      end;

    end;

    cdsItens.AfterScroll     := cdsItensAfterScroll;
    cdsItensAfterScroll(nil);
    cdsItens.IndexFieldNames := 'PRODUTO';

  Finally
    lista_adicionais.Free;
  end;
end;

procedure TfrmFinalizaPedido.FracionarItem1Click(Sender: TObject);
begin
  fraciona_item;
end;

end.
