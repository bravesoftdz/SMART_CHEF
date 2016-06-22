unit uFinalizaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, RXToolEdit, RXCurrEdit, Buttons, ExtCtrls,
  ImgList, pngimage, DB, DBClient, Grids, DBGrids, ContNrs, Item, Menus,
  AdicionalItem, Funcoes, CriaBalaoInformacao, generics.collections;

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
    cdsItensVLR_UNITARIO: TFloatField;
    cdsItensQTD_PAGA: TFloatField;
    PopupMenu1: TPopupMenu;
    FracionarItem1: TMenuItem;
    cdsItensFRACIONADO: TStringField;
    Label8: TLabel;
    lbLegenda: TLabel;
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
    cdsItensQUANTIDADE: TFloatField;
    cdsItensPrePagosFRACIONADO: TStringField;
    Label14: TLabel;
    edtPagando: TCurrencyEdit;
    Timer1: TTimer;
    edtDesconto: TCurrencyEdit;
    Label10: TLabel;
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
    procedure edtPagandoChange(Sender: TObject);
    procedure edtValorParcialEnter(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edtValorPagoEnter(Sender: TObject);
    procedure cmbTipoMoedaEnter(Sender: TObject);
  private
    Itens :TObjectList;
    recebendoParcial :Boolean;

  private
    FFinalizaRapido: Boolean;
    procedure verifica_pago;
    procedure SetupGridPickList(const FieldName : string);
    function possui_item_adicionado(codigo_item :integer):boolean;

    procedure agrupa_itens_iguais;
    procedure calcula_totais;
    procedure armazena_pre_pagos;
    procedure carrega_movimentos;
    procedure fraciona_item;
    procedure modoPagandoParcial(pagandoParcial :Boolean);
    procedure corrigeValorMoedas;

    function verifica_obrigatorio :Boolean;

    function total_prepago(codigo_item :integer) :Real;
    function valor_item(quantidade :Real) :Real;

  public
    codigo_pedido :integer;
    houve_agrupamento :Boolean;

    procedure preenche_cds(cds :TClientDataSet);

  public
    property finalizaRapido :Boolean  read FFinalizaRapido  write FFinalizaRapido;
  end;

var
  frmFinalizaPedido: TfrmFinalizaPedido;

implementation

uses Math, uModulo, Repositorio, FabricaRepositorio, Produto, MateriaPrima, EspecificacaoMovimentosPorCodigoPedido,
     Movimento, StrUtils;

{$R *.dfm}

procedure TfrmFinalizaPedido.edtValorPagoChange(Sender: TObject);
var pagando :Real;
begin
  edtTroco.Clear;

  pagando := IfThen(edtValorParcial.Value > 0, edtValorParcial.Value, edtPagando.Value);

  if (pagando > 0) and (edtValorPago.Value > pagando) then
    edtTroco.Value := edtValorPago.Value - pagando
  else if edtValorPago.Value > edtTotalRestante.Value then
    edtTroco.Value := edtValorPago.Value - edtTotalRestante.Value;

end;

procedure TfrmFinalizaPedido.edtValorPagoEnter(Sender: TObject);
begin
  edtValorPago.Color := clWhite;
end;

procedure TfrmFinalizaPedido.btnConfirmaClick(Sender: TObject);
begin
  if edtTotalRestante.Value = edtTotalPedido.Value then begin
    avisar('Nenhum valor foi informado, para efetuar o recebimento.');
    DBGrid1.SetFocus;
    exit;
  end
  else if recebendoParcial then begin
    avisar('Primeiramente finalize o recebimento parcial em andamento.');
    edtValorPago.SetFocus;
    edtPagando.Color := $00ACAAFD;
    TCriaBalaoInformacao.ShowBalloonTip(edtValorPago.Handle, 'Informe restante do valor, referente ao recebimento parcial iniciado', 'Informação', 1);
    exit;
  end
  else if cdsItensPrePagos.IsEmpty then
  begin
    avisar('Nenhum item foi recebido');
    Exit;
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

  if (key = VK_Escape) then
  begin
    if pnlExtorna.Visible then
    begin
      btnVoltar.Click;
      key := 0;
    end
    else
      if not confirma('Deseja realmente sair da tela de recebimento?') then
        Key := 0;

  end;

  if key = 80 then
    edtValorParcial.SetFocus
  else if key = 77 then
    cmbTipoMoeda.SetFocus;

  if (Key = VK_DELETE) and not FFinalizaRapido then
  begin
    if cdsItensPrePagos.IsEmpty then
       avisar('Não existem itens a serem estornados')
    else begin
       pnlExtorna.Left    := trunc(self.Width / 4);
       pnlExtorna.Visible := true;
    end;
  end;

  inherited;
end;

procedure TfrmFinalizaPedido.gridAgrupaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and not FFinalizaRapido then
 //   if (cdsMoedas.Active) and not(cdsMoedas.IsEmpty) then
  //    if cdsItensPrePagos.IsEmpty then
  //      cdsMoedas.Delete
  //    else begin
        if cdsItensPrePagos.IsEmpty then
          avisar('Não existem itens a serem estornados')
        else begin
          pnlExtorna.Left    := trunc(self.Width / 4);
          pnlExtorna.Visible := true;
        end;
end;

procedure TfrmFinalizaPedido.Image1Click(Sender: TObject);
var tecla :String;
begin
  tecla := '+';
  DBGrid1KeyPress(nil, tecla[1]);
end;

procedure TfrmFinalizaPedido.Image2Click(Sender: TObject);
var tecla :String;
begin
  tecla := '-';
  DBGrid1KeyPress(nil, tecla[1]);
end;

procedure TfrmFinalizaPedido.modoPagandoParcial(pagandoParcial: Boolean);
begin
  if pagandoParcial then
  begin
    dbgrid1.OnKeyPress   := nil;
    gridAgrupa.OnKeyDown := nil;
    DBGrid1.PopupMenu    := nil;
  end
  else
  begin
    dbgrid1.OnKeyPress   := DBGrid1KeyPress;
    gridAgrupa.OnKeyDown := gridAgrupaKeyDown;
    DBGrid1.PopupMenu    := PopupMenu1;
  end;

  dbgrid1.Enabled                := not pagandoParcial;
  gridAgrupa.Enabled             := not pagandoParcial;
  chkSelecionarPendentes.visible := not pagandoParcial;
  btnFracionaItem.Enabled        := not pagandoParcial;
  recebendoParcial               := pagandoParcial;
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

  if FFinalizaRapido then
  begin
    chkSelecionarPendentes.Checked := true;
    btnFracionaItem.Visible        := false;
    chkSelecionarPendentes.Visible := false;
    label26.Visible                := false;
    lbLegenda.Visible              := false;
    image1.Visible                 := false;
    image2.Visible                 := false;
    DBGrid1.PopupMenu              := nil;
    cmbTipoMoeda.SetFocus;
    cmbTipoMoeda.OnEnter           := cmbTipoMoedaEnter;
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

 // btnConfirma.Enabled :=  (FloatToStr(total_pago) = FloatToStr(edtTotalPedido.Value));
end;

procedure TfrmFinalizaPedido.cdsMoedasAfterPost(DataSet: TDataSet);
begin
  verifica_pago;
end;

procedure TfrmFinalizaPedido.edtPagandoChange(Sender: TObject);
begin
  if (edtPagando.Value + edtTxServico.Value) = edtTotalRestante.Value then
    edtPagando.Value := edtPagando.Value + edtTxServico.Value;

  edtValorPagoChange(nil);
  edtValorParcial.Enabled := edtPagando.Value > 0;
  edtValorParcial.Clear;
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
  if edtValorParcial.Value > edtPagando.Value then begin
    avisar('Atenção! O valor parcial deve ser menor ou igual ao valor que se está pagando.');
    edtValorParcial.Clear;
  end;

  edtValorPagoChange(nil);
end;

procedure TfrmFinalizaPedido.edtValorParcialEnter(Sender: TObject);
begin
  inherited;
  if True then

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

procedure TfrmFinalizaPedido.Timer1Timer(Sender: TObject);
begin
  lbLegenda.Font.Color := IfThen(lbLegenda.Font.Color = clRed, clBlack, clRed);
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

    if (produto = '') and not possui_item_adicionado(cdsItensCODIGO_ITEM.AsInteger)
       and not (cdsItensFRACIONADO.AsString = 'S') and (pos('BOLICHE',cdsItensPRODUTO.AsString)= 0)then begin
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
       else if not (cdsItensFRACIONADO.AsString = 'S') and (pos('BOLICHE',cdsItensPRODUTO.AsString)= 0) then begin
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
var quantidade, sobra, diferenca, valorD :Real;
    primeiroFracionado :Boolean;
    linha :integer;
begin
  quantidade := 0;
  diferenca  := 0;
  valorD     := 0;
  cdsItens.AfterScroll := nil;
  cds.First;
  while not cds.Eof do begin
    primeiroFracionado := false;
    sobra := 0;
    linha := cds.RecNo;

    if (cds.fieldByName('QTD_FRACIONADO').AsInteger > 0) and
       not (cds.Locate('CODIGO_PRODUTO;FRACIONADO',varArrayOf([cds.fieldByName('CODIGO').AsInteger, cds.fieldByName('FRACIONADO').AsString]),[])) then
      primeiroFracionado := true;

    cds.RecNo := linha;

    cdsItens.Append;
    cdsItensCODIGO_ITEM.AsInteger := cds.fieldByName('CODIGO').AsInteger;
    cdsItensPRODUTO.AsString      := cds.fieldByName('DESCRICAO').AsString;

    if pos(':',cds.fieldByName('QUANTIDADE').AsString)>0 then
      quantidade := 1
    else
      quantidade := StrToFloat(cds.fieldByName('QUANTIDADE').AsString);

    if (cds.fieldByName('QTD_FRACIONADO').AsInteger > 0) and (cds.fieldByName('TIPO').AsString = 'S') and (pos(':',cds.fieldByName('QUANTIDADE').AsString)>0)  then
    begin

      quantidade := RoundTo(1/cds.fieldByName('QTD_FRACIONADO').AsInteger,-2);

      if cdsItens.RecordCount = 0 then
      begin
        sobra := 1- (RoundTo(1/cds.fieldByName('QTD_FRACIONADO').AsInteger,-2) * cds.fieldByName('QTD_FRACIONADO').AsInteger);

        valorD := roundTo( quantidade * cds.fieldByName('VALOR_UNITARIO').AsFloat, -2) * cds.fieldByName('QTD_FRACIONADO').AsInteger;
        valorD := valorD + roundTo(sobra * cds.fieldByName('VALOR_UNITARIO').AsFloat,-2);
        diferenca := cds.fieldByName('VALOR_UNITARIO').AsFloat - valorD;

      end;

      quantidade := quantidade + sobra;



    end;

    cdsItensQUANTIDADE.AsFloat    := quantidade;
    cdsItensVLR_UNITARIO.AsFloat  := cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensVLR_TOTAL.AsFloat     := (quantidade * cds.fieldByName('VALOR_UNITARIO').AsFloat) + diferenca;
    cdsItensVLR_PAGO.AsFloat      := cds.fieldByName('QUANTIDADE_PG').AsFloat * cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensFRACIONADO.AsString   := cds.fieldByName('FRACIONADO').AsString;
    cdsItensQTD_PAGA.AsFloat      := cds.fieldByName('QUANTIDADE_PG').AsFloat;
    cdsItensQTD_A_PAGAR.AsFloat   := 0;
    cdsItens.Post;

    diferenca := 0;

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
  else if (Column.Field.FieldName = 'PRODUTO') and (cdsItensQUANTIDADE.AsString = cdsItensQTD_PAGA.asString) then begin
     TDBGrid(Sender).Canvas.Brush.Color := $0077CE88;
     TDBGrid(Sender).Canvas.FillRect(Rect);
     TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (Column.Field.FieldName = 'PRODUTO') and ((cdsItensQTD_PAGA.AsFloat > 0) and (cdsItensQTD_PAGA.AsFloat < cdsItensQUANTIDADE.AsFloat)) then begin
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
  if not (key in ['+','-']) or FFinalizaRapido then key := #0;

  if (key = '+') or (key = '-') then begin
    try
       if Timer1.Enabled then
       begin
         Timer1.Enabled := false;
         lbLegenda.font.color := clBlack;
       end;

       if (cdsItensFRACIONADO.AsString = 'S')and cdsItensPrePagos.Locate('CODIGO_ITEM', cdsItensCODIGO_ITEM.AsInteger,[]) then
         Exit;
       if (key = '+') and ((cdsItensQUANTIDADE.AsString = cdsItensQTD_PAGA.AsString) or
                           (cdsItensQUANTIDADE.AsFloat = (cdsItensQTD_PAGA.AsFloat + cdsItensQTD_A_PAGAR.AsFloat)) ) then
         Exit;
       if (key = '-') and ((cdsItensQTD_A_PAGAR.AsFloat = 0)or(total_prepago(cdsItensCODIGO_ITEM.AsInteger) = cdsItensQTD_A_PAGAR.AsFloat)) then
         Exit;

       cdsItens.Edit;

       if cdsItensFRACIONADO.AsString = 'S' then
         cdsItensQTD_A_PAGAR.AsFloat := IfThen(key = '+',cdsItensQUANTIDADE.AsFloat,0)
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

  edtPagando.Value := 0;

  while not cdsItens.Eof do begin

    if cdsItensQTD_A_PAGAR.AsFloat > 0 then begin
      edtPagando.Value := edtPagando.Value + IfThen(cdsItensFRACIONADO.AsString = 'S',
                                                    cdsItensVLR_TOTAL.AsFloat,
                                                    (cdsItensQTD_A_PAGAR.AsFloat * cdsItensVLR_UNITARIO.AsFloat));

      cdsAdicionais.First;
      while not cdsAdicionais.Eof do begin
         edtPagando.Value := edtPagando.Value + (cdsAdicionais.fieldByName('VALOR').AsFloat * cdsItensQTD_A_PAGAR.AsFloat);

         cdsAdicionais.Next;
      end;
    end;

    cdsItens.Next;
  end;

  cdsItens.EnableControls;
  cdsItens.RecNo := linha;
end;

procedure TfrmFinalizaPedido.btnOkClick(Sender: TObject);
var pagando :Real;
    valorPago :Real;
begin
  if not verifica_obrigatorio then
    exit;

  if edtValorPago.Value > 0 then begin

    pagando := IfThen(edtValorParcial.Value > 0, edtValorParcial.Value, edtPagando.Value);

    valorPago := edtValorPago.Value;

    if (pagando > 0) and (valorPago < pagando) then begin
      avisar('O valor pago deve ser maior ou igual ao valor parcial informado!');
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

      if (edtValorPago.Value > edtTotalRestante.Value) and not(pagando > 0) then
        cdsMoedasVALOR_PAGO.AsFloat   := cdsMoedasVALOR_PAGO.AsFloat + edtTotalRestante.Value
      else
        cdsMoedasVALOR_PAGO.AsFloat   := cdsMoedasVALOR_PAGO.AsFloat + IfThen(pagando > 0, pagando, edtValorPago.Value);

      cdsMoedas.Post;

      if (edtValorPago.Value > edtTotalRestante.Value) and not(pagando > 0) then
        edtTotalRestante.Value := edtTotalRestante.Value - edtTotalRestante.Value
      else
        edtTotalRestante.Value := edtTotalRestante.Value - IfThen(pagando > 0, pagando, edtValorPago.Value);

      edtValorPago.Clear;

      if not(pagando > 0) then
        cmbTipoMoeda.ItemIndex := -1;

    end;

    if edtValorParcial.Value > 0 then begin
      edtValorParcial.SetFocus;
      edtValorParcial.Clear;
    end
    else
      cmbTipoMoeda.SetFocus;

    edtTroco.Clear;

    edtPagando.Value := edtPagando.Value - pagando;

    edtPagando.Color   := clWhite;
    edtValorPago.Color := clWhite;

    if edtPagando.Value > 0 then
      modoPagandoParcial(true)
    else
      modoPagandoParcial(false);
  end;

  armazena_pre_pagos;
  if DBGrid1.enabled then
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
      cdsItensPrePagosFRACIONADO.AsString   := cdsItensFRACIONADO.AsString;
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
var registro :integer;
begin
  if confirma('Estornar recebimento do item selecionado?'+#13#10+cdsItensPrePagosPRODUTO.AsString+' (recebido em '+cdsItensPrePagosMOEDA.asString+')') then begin
    cdsItens.Locate('CODIGO_ITEM',cdsItensPrePagosCODIGO_ITEM.AsInteger, []);
    cdsItens.Edit;
    cdsItensQTD_PAGA.AsFloat := cdsItensQTD_PAGA.AsFloat - cdsItensPrePagosQUANTIDADE.AsFloat;
    cdsItens.Post;

    cdsMoedas.Locate('MOEDA', cdsItensPrePagosMOEDA.AsString, []);

    registro := cdsMoedas.Recno;
    cdsMoedas.Edit;
    cdsMoedasVALOR_PAGO.AsFloat := cdsMoedasVALOR_PAGO.AsFloat - cdsItensPrePagosVALOR.AsFloat;
    cdsMoedas.Post;
    cdsMoedas.Recno := registro;

    if cdsMoedasVALOR_PAGO.AsFloat <= 0 then
      corrigeValorMoedas;


    edtTotalRestante.Value := edtTotalRestante.Value + cdsItensPrePagosVALOR.AsFloat;

    if cdsMoedasVALOR_PAGO.AsFloat = 0 then
      cdsMoedas.Delete;

    cdsItensPrePagos.Delete;

    avisar('Item estornado!');

    if cdsItensPrePagos.IsEmpty then begin
      pnlExtorna.Left    := 1250;
      pnlExtorna.Visible := false;
    end;
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
  else if edtPagando.Value <= 0 then begin
    avisar('Nenhum item foi marcado como recebido');
    DBGrid1.SetFocus;
    Timer1.enabled := true;
  end
  else if edtValorPago.Value <= 0 then begin
    avisar('O valor pago não foi informado');
    edtValorPago.SetFocus;
    edtValorPago.Color := $00ACAAFD;
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
    //DBGrid1KeyPress(nil, Tecla);
    cdsItens.Post;

    cdsItens.Next;
  end;
end;

procedure TfrmFinalizaPedido.cmbTipoMoedaEnter(Sender: TObject);
begin
  cmbTipoMoeda.DroppedDown       := true;
end;

procedure TfrmFinalizaPedido.corrigeValorMoedas;
var valorNegativo :Real;
begin
  valorNegativo := cdsMoedasVALOR_PAGO.AsFloat;

  cdsMoedas.Delete;
  cdsMoedas.First;

  cdsMoedas.Edit;
  cdsMoedasVALOR_PAGO.AsFloat := cdsMoedasVALOR_PAGO.AsFloat + valorNegativo;
  cdsMoedas.Post;

  cdsMoedas.first;
  if cdsMoedasVALOR_PAGO.AsFloat <= 0 then
    corrigeValorMoedas;

end;

procedure TfrmFinalizaPedido.fraciona_item;
var partes, i, x, linha, qtd_ad:integer;
    Item   :TItem;
    Adicional :TAdicionalItem;
    repositorio :Trepositorio;
    repositorioAd :TRepositorio;
    contem_adicional, boliche :Boolean;
    diferenca, sobraBoliche, sobraTotal, qtde, quantidadeReal, quantidadeLocal :Real;
    lista_adicionais :TObjectList<TAdicionalItem>;
begin
 try
    contem_adicional := false;
    diferenca        := 0;
    sobraTotal       := 0;
    quantidadeReal   := 0;
    quantidadeLocal  := 0;
    qtde             := 0;
    partes           := StrToIntDef( chamaInput('INTEGER', 'Fracionar produto em quantas partes?'),0);

    if partes <= 1 then begin
      avisar('Quantidade de partes não informada. Operação cancelada.');
      Exit;
    end;

    if not cdsAdicionais.IsEmpty then begin
      contem_adicional := true;

      lista_adicionais := TObjectList<TAdicionalItem>.Create;
    end;

    repositorio      := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    Item            := TItem(repositorio.Get(cdsItensCODIGO_ITEM.AsInteger));

    boliche         := (Item.Produto.tipo = 'S') and (Item.quantidade > 599);

    //diferenca       := ifThen(boliche, 1, Item.quantidade); //recebe quantidade antes do fracionamento
    qtde            := ifThen(boliche, 1, Item.quantidade);

    if boliche then
      sobraBoliche := RoundTo(Item.valor_Unitario - (roundTo((Item.valor_Unitario/partes),-2) * partes),-2);

    DivideProporcional(qtde, diferenca, partes);

    quantidadeReal      := RoundTo(Item.quantidade / partes, -2);

    Item.quantidade     := quantidadeReal + IfThen(not boliche, diferenca, 0);

    Item.Fracionado     := 'S';
    Item.qtd_fracionado := partes;
    repositorio.Salvar(Item);


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
    cdsItensQUANTIDADE.AsFloat  := roundTo(cdsItensQUANTIDADE.AsFloat / partes, -2);

    sobraTotal := roundTo( cdsItensQUANTIDADE.AsFloat * cdsItensVLR_UNITARIO.AsFloat, -2) * partes;
    sobraTotal := sobraTotal + roundTo(diferenca * cdsItensVLR_UNITARIO.AsFloat,-2);
    sobraTotal := (IfThen(boliche, 1, roundTo(cdsItensQUANTIDADE.AsFloat * partes, -2)+diferenca )* cdsItensVLR_UNITARIO.AsFloat) - sobraTotal;

    cdsItensQUANTIDADE.AsFloat  := cdsItensQUANTIDADE.AsFloat + diferenca;
    cdsItensVLR_TOTAL.AsFloat   := roundTo(cdsItensQUANTIDADE.AsFloat * cdsItensVLR_UNITARIO.AsFloat, -2)+sobraTotal;
    cdsItensVLR_PAGO.AsFloat    := roundTo(cdsItensQTD_PAGA.AsFloat * cdsItensVLR_UNITARIO.AsFloat,-2);
    cdsItensFRACIONADO.AsString := 'S';
    cdsItens.Post;

    cdsItens.AfterScroll := nil;

    quantidadeLocal := cdsItensQUANTIDADE.AsFloat;

    for i := 0 to partes -2 do begin
      Item.codigo := 0;
      Item.quantidade := quantidadeReal;
      Item.Fracionado := 'S';
      repositorio.Salvar(Item);

      cdsItens.Insert;
      cdsItensCODIGO_ITEM.AsInteger := Item.codigo;
      cdsItensQUANTIDADE.AsFloat    := quantidadeLocal - diferenca;
      cdsItensPRODUTO.AsString      := Item.Produto.descricao;
      cdsItensVLR_UNITARIO.AsFloat  := Item.valor_Unitario;
      cdsItensVLR_TOTAL.AsFloat     := roundTo(cdsItensQUANTIDADE.AsFloat * Item.valor_Unitario, -2);

      cdsItensVLR_PAGO.AsFloat      := 0;
      cdsItensFRACIONADO.AsString   := 'S';
      cdsItensQTD_PAGA.AsFloat      := 0;
      cdsItensQTD_A_PAGAR.AsFloat   := 0;//Item.quantidade;
      cdsItens.Post;

      if contem_adicional then begin

         cdsAdicionais.First;
         qtd_ad := cdsAdicionais.RecordCount;

         for x := 0 to lista_adicionais.Count - 1 do begin

            lista_adicionais.Items[x].codigo      := 0;
            lista_adicionais.Items[x].codigo_item := Item.codigo;
            repositorioAd.Salvar( lista_adicionais.Items[x] );

            cdsAdicionais.Append;
            cdsAdicionais.FieldByName('CODIGO').AsInteger       := lista_adicionais.Items[x].codigo;
            cdsAdicionais.FieldByName('DESCRICAO').AsString     := lista_adicionais.Items[x].Materia.descricao;
            cdsAdicionais.FieldByName('VALOR').AsFloat          := lista_adicionais.Items[x].valor_unitario * lista_adicionais.Items[x].quantidade;
            cdsAdicionais.FieldByName('CODIGO_ITEM').AsInteger  := lista_adicionais.Items[x].codigo_item;
            cdsAdicionais.FieldByName('VALOR_UNITARIO').AsFloat := lista_adicionais.Items[x].valor_unitario;
            cdsAdicionais.FieldByName('QUANTIDADE').AsFloat     := lista_adicionais.Items[x].quantidade;
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
