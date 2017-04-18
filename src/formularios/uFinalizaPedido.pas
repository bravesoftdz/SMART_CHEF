unit uFinalizaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, RXToolEdit, RXCurrEdit, Buttons, ExtCtrls,
  ImgList, pngimage, DB, DBClient, Grids, DBGrids, ContNrs, Item, Menus,
  AdicionalItem, Funcoes, CriaBalaoInformacao, generics.collections, System.ImageList;

type
  TfrmFinalizaPedido = class(TfrmPadrao)
    Panel1: TPanel;
    btnCancela: TBitBtn;
    btnConfirma: TBitBtn;
    gridMoedas: TDBGrid;
    cdsMoedas: TClientDataSet;
    dsMoedas: TDataSource;
    cdsMoedasTIPO_MOEDA: TIntegerField;
    cdsMoedasVALOR_PAGO: TFloatField;
    cdsMoedasMOEDA: TStringField;
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
    gridItens: TDBGrid;
    dsItens: TDataSource;
    DBGrid2: TDBGrid;
    Label7: TLabel;
    cdsAdicionais: TClientDataSet;
    dsAdicionais: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensCODIGO_ITEM: TIntegerField;
    cdsItensPRODUTO: TStringField;
    PopupMenu1: TPopupMenu;
    FracionarItem1: TMenuItem;
    cdsItensFRACIONADO: TStringField;
    Label8: TLabel;
    lbLegenda: TLabel;
    Image1: TImage;
    Image2: TImage;
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
    cdsItensPrePagosFRACIONADO: TStringField;
    Label14: TLabel;
    edtPagando: TCurrencyEdit;
    Timer1: TTimer;
    edtDesconto: TCurrencyEdit;
    Label10: TLabel;
    edtCpf: TEdit;
    Label15: TLabel;
    cdsItensQUANTIDADE: TFMTBCDField;
    cdsItensQTD_PAGA: TFMTBCDField;
    cdsItensQTD_A_PAGAR: TFMTBCDField;
    cdsItensVLR_PAGO: TFMTBCDField;
    cdsItensVLR_TOTAL: TFMTBCDField;
    cdsItensVLR_UNITARIO: TFMTBCDField;
    btnExtornaItem: TBitBtn;
    btnExtornaMoeda: TBitBtn;
    cdsItensPrePagosCODMOEDA: TIntegerField;
    cdsMoedasCODIGO: TIntegerField;
    cdsMoedasINDICE: TIntegerField;
    ImageList1: TImageList;
    procedure edtValorPagoChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsMoedasAfterPost(DataSet: TDataSet);
    procedure edtValorParcialChange(Sender: TObject);
    procedure edtValorParcialKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure gridItensEnter(Sender: TObject);
    procedure gridItensColEnter(Sender: TObject);
    procedure gridItensCellClick(Column: TColumn);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridItensKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure btnOkClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnEstornarClick(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word;
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
    procedure edtCpfChange(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure cdsItensQTD_PAGAChange(Sender: TField);
    procedure btnExtornaItemClick(Sender: TObject);
    procedure btnExtornaMoedaClick(Sender: TObject);
    procedure gridMoedasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsMoedasBeforeDelete(DataSet: TDataSet);
  private
    Itens :TObjectList;
    recebendoParcial :Boolean;

  private
    FFinalizaRapido: Boolean;
    FTotalAdicionais :Real;

    procedure verifica_pago;
    procedure SetupGridPickList(const FieldName : string);
    function possui_item_adicionado(codigo_item :integer):boolean;
    function GetTotalPago :Real;

    procedure agrupa_itens_iguais;
    procedure recalculaTotalPedido;
    procedure calculaTotalSerPago;
    procedure calculaTotalPedido;
    procedure armazena_pre_pagos;
    procedure carrega_movimentos;
    procedure fraciona_item;
    procedure corrigeValorMoedas;
    procedure rateiaValor;
    procedure ExtornarItem;

    function verifica_obrigatorio :Boolean;

    function total_prepago(codigo_item :integer) :Real;
    function totalAdicionaisItem(qtde :Real; const codigoItem :integer = 0) :Real;
    function valor_item(quantidade :Real) :Real;
    function getPagamentoCompleto: Boolean;

  public
    codigo_pedido :integer;
    houve_agrupamento :Boolean;

    procedure preenche_cds(cds :TClientDataSet);

  public
    property finalizaRapido :Boolean     read FFinalizaRapido  write FFinalizaRapido;
    property totalAdicionais :Real       read FTotalAdicionais write FTotalAdicionais;
    property pagamento_completo :Boolean read getPagamentoCompleto;
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

  pagando := edtPagando.Value;

  if (pagando > 0) and (edtValorPago.Value > pagando) then
    edtTroco.Value := edtValorPago.Value - pagando
  else if edtValorPago.Value > edtTotalRestante.Value then
    edtTroco.Value := edtValorPago.Value - edtTotalRestante.Value;

end;

procedure TfrmFinalizaPedido.edtValorPagoEnter(Sender: TObject);
begin
  edtValorPago.Color := clWhite;
  edtValorParcial.SelectAll;
end;

procedure TfrmFinalizaPedido.btnConfirmaClick(Sender: TObject);
begin
  if edtTotalRestante.Value = edtTotalPedido.Value then begin
    avisar('Nenhum valor foi informado, para efetuar o recebimento.');
    gridItens.SetFocus;
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
    if (edtCpf.Text <> '') and not Valida_CPF_CNPJ( edtCPF.Text ) then
      avisar('CPF inválido')
    else if confirma('Confirma recebimento '+IfThen(edtTotalRestante.Value = 0, 'TOTAL','PARCIAL')+' do pedido?') then
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

function TfrmFinalizaPedido.getPagamentoCompleto: Boolean;
begin
  result:=  (edtTotalRestante.Value = 0);
end;

function TfrmFinalizaPedido.GetTotalPago: Real;
var registro :integer;
begin
  result := 0;
  registro := cdsMoedas.RecNo;
  cdsMoedas.First;
  while not cdsMoedas.Eof do
  begin
    result := result + cdsMoedasVALOR_PAGO.AsFloat;
    cdsMoedas.Next;
  end;
  cdsMoedas.RecNo := registro;
end;

procedure TfrmFinalizaPedido.Image1Click(Sender: TObject);
var tecla :String;
begin
  tecla := '+';
  gridItensKeyPress(nil, tecla[1]);
end;

procedure TfrmFinalizaPedido.Image2Click(Sender: TObject);
var tecla :String;
begin
  tecla := '-';
  gridItensKeyPress(nil, tecla[1]);
end;

procedure TfrmFinalizaPedido.FormShow(Sender: TObject);
begin
  cdsMoedas.CreateDataSet;
  gridItens.SelectedIndex := 6;
  TNumericField(cdsAdicionais.Fields[2]).DisplayFormat := ',0.00; ,0.00';
  cdsItensAfterScroll(nil);
  edtDesconto.OnChange := edtDescontoChange;

  (cdsAdicionais.fieldByName('QUANTIDADE') as TFloatField).DisplayFormat     := ',0.00; ,0.00';
  (cdsAdicionais.fieldByName('VALOR_UNITARIO') as TFloatField).DisplayFormat := ',0.00; ,0.00';

  carrega_movimentos;

  if FFinalizaRapido then
  begin
    chkSelecionarPendentes.Checked := true;
    btnFracionaItem.Visible        := false;
    chkSelecionarPendentes.Visible := false;
    lbLegenda.Visible              := false;
    image1.Visible                 := false;
    image2.Visible                 := false;
    gridItens.PopupMenu            := nil;
    cmbTipoMoeda.SetFocus;
    cmbTipoMoeda.OnEnter           := cmbTipoMoedaEnter;
    cmbTipoMoeda.ItemIndex         := 0;
    edtValorPago.SetFocus;
  end;

  recalculaTotalPedido;
end;

procedure TfrmFinalizaPedido.verifica_pago;
var total_pago :Double;
begin
 { total_pago := 0;

  cdsMoedas.First;
  while not cdsMoedas.Eof do begin

    total_pago := total_pago + cdsMoedasVALOR_PAGO.Value;

    cdsMoedas.Next;
  end;
               }
 // btnConfirma.Enabled :=  (FloatToStr(total_pago) = FloatToStr(edtTotalPedido.Value));
end;

procedure TfrmFinalizaPedido.cdsMoedasAfterPost(DataSet: TDataSet);
begin
//  verifica_pago;
end;

procedure TfrmFinalizaPedido.cdsMoedasBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  recalculaTotalPedido;
end;

procedure TfrmFinalizaPedido.edtCpfChange(Sender: TObject);
begin
  if not Valida_CPF_CNPJ( edtCPF.Text ) then
    edtCpf.Font.Color := clMaroon
  else
    edtCpf.Font.Color := clGreen;
end;

procedure TfrmFinalizaPedido.edtDescontoChange(Sender: TObject);
begin
  if edtDesconto.Value > edtTotalRestante.Value then
    edtDesconto.Value := 0;

  recalculaTotalPedido;
end;

procedure TfrmFinalizaPedido.edtPagandoChange(Sender: TObject);
begin
  if roundTo(((edtPagando.Value + edtTxServico.Value - edtDesconto.Value) - edtTotalRestante.Value),-4) = 0 then
    edtPagando.Value := edtPagando.Value + edtTxServico.Value;

  edtValorPagoChange(nil);
end;

procedure TfrmFinalizaPedido.edtValorParcialChange(Sender: TObject);
var valorItens :Real;
begin
  valorItens := (edtTotalRestante.Value{ - self.FTotalAdicionais} - edtTxServico.Value + edtDesconto.Value);
  if (edtValorParcial.Value >= valorItens) and (edtValorParcial.Value < edtTotalRestante.Value) then
  begin
    edtValorParcial.Value     := edtTotalRestante.Value;
    edtValorParcial.SelStart  := Length(edtValorParcial.Text);
    edtValorParcial.SelLength := 0;
  end;

  edtValorPago.Value := edtValorParcial.Value;
  edtValorPagoChange(nil);

  rateiaValor;
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

procedure TfrmFinalizaPedido.ExtornarItem;
var registro :integer;
begin
    cdsItens.Locate('CODIGO_ITEM',cdsItensPrePagosCODIGO_ITEM.AsInteger, []);
    cdsItens.Edit;
    cdsItensQTD_PAGA.AsFloat := cdsItensQTD_PAGA.AsFloat - cdsItensPrePagosQUANTIDADE.AsFloat;
    cdsItens.Post;

    cdsMoedas.Locate('INDICE', cdsItensPrePagosCODMOEDA.AsInteger, []);

    cdsMoedas.Edit;
    cdsMoedasVALOR_PAGO.AsFloat := cdsMoedasVALOR_PAGO.AsFloat - IfThen(cdsItensPrePagosVALOR.AsFloat > cdsMoedasVALOR_PAGO.AsFloat,
                                                                        cdsMoedasVALOR_PAGO.AsFloat,
                                                                        cdsItensPrePagosVALOR.AsFloat);
    cdsMoedas.Post;

  {  if cdsMoedasVALOR_PAGO.AsFloat <= 0 then
      corrigeValorMoedas;  }

    edtTotalRestante.Value := edtTotalRestante.Value + cdsItensPrePagosVALOR.AsFloat;
    cdsItensPrePagos.Delete;

    if cortaCasasDecimais(cdsMoedasVALOR_PAGO.AsFloat, 2) = 0 then
      cdsMoedas.Delete;
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
    for i := 0 to gridItens.Columns.Count-1 do
      if gridItens.Columns[i].FieldName = FieldName then begin
        gridItens.Columns[i].PickList := slPickList;
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
          cdsItensVLR_TOTAL.AsFloat  := cdsItensVLR_TOTAL.AsFloat + totalAdicionaisItem(cdsItensQUANTIDADE.AsFloat);
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
    sobra := 0;
    linha := cds.RecNo;

    cds.RecNo := linha;

    cdsItens.Append;
    cdsItensCODIGO_ITEM.AsInteger := cds.fieldByName('CODIGO').AsInteger;
    cdsItensPRODUTO.AsString      := cds.fieldByName('DESCRICAO').AsString;

    if pos(':',cds.fieldByName('QUANTIDADE').AsString)>0 then
      quantidade := 1
    else
      quantidade := StrToFloat(cds.fieldByName('QUANTIDADE').AsString);

      // se for do tipo SERVIÇO, e for medido em tempo
    if (cds.fieldByName('QTD_FRACIONADO').AsInteger > 0) and (cds.fieldByName('TIPO').AsString = 'S') and (pos(':',cds.fieldByName('QUANTIDADE').AsString)>0)  then
    begin

      quantidade := RoundTo(1/cds.fieldByName('QTD_FRACIONADO').AsInteger,-4);

      if cdsItens.RecordCount = 0 then
      begin
        sobra := 1- (RoundTo(1/cds.fieldByName('QTD_FRACIONADO').AsInteger,-4) * cds.fieldByName('QTD_FRACIONADO').AsInteger);

        valorD := roundTo( quantidade * cds.fieldByName('VALOR_UNITARIO').AsFloat, -4) * cds.fieldByName('QTD_FRACIONADO').AsInteger;
        valorD := valorD + roundTo(sobra * cds.fieldByName('VALOR_UNITARIO').AsFloat,-4);
        diferenca := cds.fieldByName('VALOR_UNITARIO').AsFloat - valorD;

      end;

      quantidade := quantidade + sobra;
    end;

    cdsItensQUANTIDADE.AsFloat    := quantidade;
    cdsItensVLR_UNITARIO.AsFloat  := cds.fieldByName('VALOR_UNITARIO').AsFloat;
    cdsItensVLR_TOTAL.AsFloat     := roundTo((quantidade * cds.fieldByName('VALOR_UNITARIO').AsFloat),-4) + diferenca + totalAdicionaisItem(cdsItensQUANTIDADE.AsFloat, cds.fieldByName('CODIGO').AsInteger);
   // cdsItensVLR_PAGO.AsFloat      := roundTo(cds.fieldByName('QUANTIDADE_PG').AsFloat * cds.fieldByName('VALOR_UNITARIO').AsFloat,-3);
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

procedure TfrmFinalizaPedido.rateiaValor;
var resto, percentagemEq, valorFalta, pagando, calculado :Real;
begin
  cdsItens.First;
  pagando := edtValorParcial.Value;
  while not cdsItens.Eof do
  begin
    if cdsItensVLR_PAGO.AsFloat < cdsItensVLR_TOTAL.AsFloat then
    begin
      valorFalta := cdsItensVLR_TOTAL.AsFloat - cdsItensVLR_PAGO.AsFloat;

      cdsItens.Edit;
      if pagando > valorFalta then
      begin
        cdsItensQTD_A_PAGAR.AsFloat := cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat;
        pagando := pagando - valorFalta;
      end
      else
      begin
        percentagemEq := (pagando * 100 / valorFalta);
        calculado     := (cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat) * percentagemEq / 100;
                                      //trunca para 4 casas decimais
        cdsItensQTD_A_PAGAR.AsFloat := cortaCasasDecimais(calculado, 4);
        pagando       := 0;
      end;

      cdsItens.Post;
    end;
    cdsItens.Next;
  end;
end;

procedure TfrmFinalizaPedido.recalculaTotalPedido;
begin
  calculaTotalPedido;
  edtTotalRestante.Value := edtTotalPedido.Value - GetTotalPago;
  calculaTotalSerPago;
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
    gridItens.PopupMenu := nil
  else if not self.FFinalizaRapido then
    gridItens.PopupMenu := PopupMenu1;
end;

procedure TfrmFinalizaPedido.cdsItensQTD_PAGAChange(Sender: TField);
begin
   cdsItensVLR_PAGO.AsFloat    := (cdsItensQTD_PAGA.AsFloat * valor_item(1));
end;

procedure TfrmFinalizaPedido.gridItensEnter(Sender: TObject);
begin
  gridItens.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.gridItensColEnter(Sender: TObject);
begin
  gridItens.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.gridMoedasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsMoedasCODIGO then begin
    gridMoedas.Canvas.FillRect(Rect);
    TDBGrid(Sender).Canvas.Font.Color := TDBGrid(Sender).Canvas.Brush.Color;
    TDBGrid(Sender).Canvas.FillRect(Rect);
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

    if cdsMoedasCODIGO.AsInteger > 0 then
      ImageList1.Draw(gridMoedas.Canvas, Rect.Left +20, Rect.Top , 0, true);

  end;
end;

procedure TfrmFinalizaPedido.gridItensCellClick(Column: TColumn);
begin
  gridItens.SelectedIndex := 6;
end;

procedure TfrmFinalizaPedido.gridItensDrawColumnCell(Sender: TObject;
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

procedure TfrmFinalizaPedido.gridItensKeyPress(Sender: TObject; var Key: Char);
var pagoParcial :Boolean;
begin
  if not (key in ['+','-']) or FFinalizaRapido then key := #0;

  if (key = '+') or (key = '-') then begin
    try
       if Timer1.Enabled then
       begin
         Timer1.Enabled := false;
         lbLegenda.font.color := clBlack;
       end;

       {if (cdsItensFRACIONADO.AsString = 'S')and cdsItensPrePagos.Locate('CODIGO_ITEM', cdsItensCODIGO_ITEM.AsInteger,[]) then
         Exit;}
       if (key = '+') and ((cdsItensQUANTIDADE.AsString = cdsItensQTD_PAGA.AsString) or
                           (cdsItensQUANTIDADE.AsFloat = (cdsItensQTD_PAGA.AsFloat + cdsItensQTD_A_PAGAR.AsFloat)) ) then
         Exit;
       if (key = '-') and ((cdsItensQTD_A_PAGAR.AsFloat = 0)or(total_prepago(cdsItensCODIGO_ITEM.AsInteger) = cdsItensQTD_A_PAGAR.AsFloat)) then
         Exit;

       cdsItens.Edit;
       pagoParcial := (cdsItensQTD_PAGA.AsFloat - trunc(cdsItensQTD_PAGA.AsFloat)) > 0;
                                                               // ou se teve recebimento parcial do item
       if (cdsItensFRACIONADO.AsString = 'S') or pagoParcial or ((cdsItensQUANTIDADE.AsFloat - Trunc(cdsItensQUANTIDADE.AsFloat)) > 0) then
         cdsItensQTD_A_PAGAR.AsFloat := IfThen(key = '+',cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat,0)
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
  calculaTotalSerPago;
end;

procedure TfrmFinalizaPedido.calculaTotalPedido;
var linha :integer;
    totalPedido :Real;
begin
  linha := cdsItens.RecNo;
  cdsItens.DisableControls;
  cdsItens.First;
  totalPedido := 0;

  while not cdsItens.Eof do begin
    totalPedido := totalPedido + cdsItensVLR_TOTAL.AsFloat;
    cdsItens.Next;
  end;

  edtTotalPedido.Value := totalPedido {+ FTotalAdicionais} + edtTxServico.Value - edtDesconto.Value;

  cdsItens.EnableControls;
  cdsItens.RecNo := linha;
end;

procedure TfrmFinalizaPedido.calculaTotalSerPago;
var linha :integer;
    pagando :Real;
    pagoParcial, pegaValorTotal :Boolean;
begin
  pagando := 0;
  if edtValorParcial.Value > 0 then
  begin
    if edtValorParcial.Value > edtTotalRestante.Value then
      pagando := edtTotalRestante.Value
    else
      pagando := edtValorParcial.Value;

    edtPagando.Value := pagando;
  end
  else
  begin
    linha := cdsItens.RecNo;
    cdsItens.DisableControls;
    cdsItens.First;
    while not cdsItens.Eof do begin

      if cdsItensQTD_A_PAGAR.AsFloat > 0 then begin
        pegaValorTotal := (cdsItensFRACIONADO.AsString = 'S') and (cdsItensQTD_PAGA.AsFloat = 0);
        pagando        := pagando + IfThen(pegaValorTotal,
                                           cdsItensVLR_TOTAL.AsFloat,
                                           (cdsItensQTD_A_PAGAR.AsFloat * cdsItensVLR_UNITARIO.AsFloat));
        cdsAdicionais.First;
        pagoParcial := (cdsItensQTD_PAGA.AsFloat - trunc(cdsItensQTD_PAGA.AsFloat)) > 0;

        while not cdsAdicionais.Eof do begin
          if not pegaValorTotal then
           pagando := pagando + (cdsAdicionais.fieldByName('VALOR').AsFloat * IfThen(pagoParcial, cdsItensQUANTIDADE.AsFloat,cdsItensQTD_A_PAGAR.AsFloat));
           cdsAdicionais.Next;
        end;
      end;
      cdsItens.Next;
    end;

    edtPagando.Value := pagando;
    if edtPagando.Value > edtTotalRestante.Value then
      edtPagando.Value := edtTotalRestante.Value;

    if edtValorParcial.Value > 0 then
      edtPagando.Value := edtValorParcial.Value;

    cdsItens.EnableControls;
    cdsItens.RecNo := linha;
  end;
end;

procedure TfrmFinalizaPedido.btnOkClick(Sender: TObject);
var pagando :Real;
    valorPago :Real;
begin
  if not verifica_obrigatorio then
    exit;

  if edtValorPago.Value > 0 then begin

    pagando   := edtPagando.Value;

    valorPago := edtValorPago.Value;

    if (pagando > 0) and (valorPago < pagando) then begin
      avisar('O valor pago deve ser maior ou igual ao valor parcial informado!');
      edtValorPago.SetFocus;
      abort;
    end
    else
    begin

    {  if (cdsMoedas.Locate('MOEDA',cmbTipoMoeda.Items[cmbTipoMoeda.ItemIndex],[])) then
        cdsMoedas.Edit
      else}
        cdsMoedas.Append;

      cdsMoedasINDICE.AsInteger     := cdsMoedas.RecordCount + 1;
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

    edtTroco.Clear;

    edtPagando.Value := edtPagando.Value - pagando;

    edtPagando.Color   := clWhite;
    edtValorPago.Color := clWhite;
  end;

  armazena_pre_pagos;
  if edtValorParcial.Value > 0 then begin
    edtValorParcial.SetFocus;
    edtValorParcial.Clear;
  end
  else
    cmbTipoMoeda.SetFocus;

  if gridItens.enabled then
    gridItens.SetFocus;
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
      cdsItensPrePagosQUANTIDADE.AsFloat    := cdsItensPrePagosQUANTIDADE.AsFloat + cdsItensQTD_A_PAGAR.AsFloat;
      cdsItensPrePagosMOEDA.AsString        := cmbTipoMoeda.Items[cmbTipoMoeda.itemIndex];
      cdsItensPrePagosCODMOEDA.AsInteger    := cdsMoedasINDICE.AsInteger;
      cdsItensPrePagosPRODUTO.AsString      := cdsItensPRODUTO.AsString;
      cdsItensPrePagosVALOR.AsFloat         := cdsItensPrePagosVALOR.AsFloat + valor_item(cdsItensQTD_A_PAGAR.AsFloat);
      cdsItensPrePagosFRACIONADO.AsString   := cdsItensFRACIONADO.AsString;
      cdsItensPrePagos.Post;

      cdsItens.Edit;
      cdsItensQTD_PAGA.AsFloat    := cdsItensQTD_PAGA.AsFloat + cdsItensQTD_A_PAGAR.AsFloat;
      cdsItensQTD_A_PAGAR.AsFloat := 0;
      cdsItens.Post;
    end;
    cdsItens.Next;
  end;

  cdsItens.AfterPost := cdsItensAfterPost;
  cdsItens.EnableControls;
  cdsItens.RecNo := linha;
end;

function TfrmFinalizaPedido.totalAdicionaisItem(qtde :Real; const codigoItem :integer): Real;
begin
  result := 0;
  if codigoItem > 0 then
  begin
    cdsAdicionais.Filtered := false;
    cdsAdicionais.Filter   := 'CODIGO_ITEM = '+intToStr(codigoItem);
    cdsAdicionais.Filtered := true;
  end;

  cdsAdicionais.First;
  while not cdsAdicionais.Eof do
  begin
    result := result + (qtde * cdsAdicionais.fieldByName('VALOR').AsFloat);
    cdsAdicionais.Next;
  end;
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
  if confirma('Estornar recebimento do item selecionado?'+#13#10+cdsItensPrePagosPRODUTO.AsString+' (recebido em '+cdsItensPrePagosMOEDA.asString+')') then
  begin
    ExtornarItem;
    avisar('Item estornado!');

    if cdsItensPrePagos.IsEmpty then begin
      pnlExtorna.Left    := 1250;
      pnlExtorna.Visible := false;
    end;
  end;
end;

procedure TfrmFinalizaPedido.btnExtornaItemClick(Sender: TObject);
begin
  if cdsItensPrePagos.IsEmpty then
     avisar('Não existem itens a serem estornados')
  else begin
     pnlExtorna.Left    := trunc(self.Width / 4);
     pnlExtorna.Visible := true;
  end;
end;

procedure TfrmFinalizaPedido.btnExtornaMoedaClick(Sender: TObject);
var indice :integer;
begin
  if cdsMoedas.IsEmpty then
     avisar('Não existem pagamentos a serem estornados')
  else if cdsMoedasCODIGO.AsInteger > 0 then
     avisar('Um pagamento salvo não pode ser extornado')
  else begin
     indice := cdsMoedasINDICE.AsInteger;
     while cdsItensPrePagos.Locate('CODMOEDA', cdsMoedasINDICE.AsInteger, []) and (cdsMoedasINDICE.AsInteger = indice) do
       ExtornarItem;
  end;
end;

function TfrmFinalizaPedido.valor_item(quantidade: Real): Real;
begin
  Result := 0;
  Result := (cdsItensVLR_UNITARIO.AsFloat + totalAdicionaisItem(1)) * quantidade;
  result := roundTo(result, -4);
end;

function TfrmFinalizaPedido.verifica_obrigatorio :Boolean;
begin
  result := false;

  if cmbTipoMoeda.ItemIndex < 0 then begin
    avisar('O tipo da moeda deve ser informado');
    cmbTipoMoeda.SetFocus;
  end
  else if (edtPagando.Value <= 0) and (edtValorParcial.Value <= 0) then begin
    avisar('Nenhum item foi marcado como recebido');
    gridItens.SetFocus;
    Timer1.enabled := true;
  end
  else if (edtValorPago.Value <= 0) and (edtValorParcial.Value <= 0) then begin
    avisar('O valor pago não foi informado');
    edtValorPago.SetFocus;
    edtValorPago.Color := $00ACAAFD;
  end
  else
    result := true;
end;

procedure TfrmFinalizaPedido.gridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 39) and (GroupBox1.Enabled) then
    edtValorPago.SetFocus;
end;

procedure TfrmFinalizaPedido.carrega_movimentos;
var repositorio :TRepositorio;
    Movimento   :TMovimento;
    Movimentos  :TObjectList<TMovimento>;
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
    i :integer;
begin
  try
    repositorio := nil;
    Movimento   := nil;
    Movimentos  := nil;

    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( codigo_pedido );

    Movimentos    := repositorio.GetListaPorEspecificacao<TMovimento>( Especificacao );

    if assigned(Movimentos) then
       for i := 0 to Movimentos.Count - 1 do begin
         cdsMoedas.Append;
         cdsMoedasCODIGO.AsInteger     := TMovimento(Movimentos.Items[i]).codigo;
         cdsMoedasINDICE.AsInteger     := cdsMoedas.RecordCount +1;
         cdsMoedasTIPO_MOEDA.AsInteger := TMovimento(Movimentos.Items[i]).tipo_moeda;
         cdsMoedasVALOR_PAGO.AsFloat   := TMovimento(Movimentos.Items[i]).valor_pago;

         cmbTipoMoeda.ItemIndex        := TMovimento(Movimentos.Items[i]).tipo_moeda -1;

         cdsMoedasMOEDA.AsString       := cmbTipoMoeda.Items[ cmbTipoMoeda.itemIndex ];
         cdsMoedas.Post;
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
    gridItens.SetFocus;
  end;

  cdsItens.First;
  while not cdsItens.Eof do begin
    Tecla := IfThen(chkSelecionarPendentes.Checked, '+', '-')[1];

    cdsItens.Edit;
    cdsItensQTD_A_PAGAR.AsFloat := IfThen(chkSelecionarPendentes.Checked, (cdsItensQUANTIDADE.AsFloat - cdsItensQTD_PAGA.AsFloat), 0);
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
  valorNegativo := 0;
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
var partes, i, x, linha :integer;
    Item   :TItem;
    ListaItens :TObjectList<TItem>;
    Adicional :TAdicionalItem;
    repositorio :Trepositorio;
    repositorioAd :TRepositorio;
    contem_adicional :Boolean;
    diferenca, quantidade, quantidadeReal, quantidadeLocal, centavos :Real;
    lista_adicionais :TObjectList<TAdicionalItem>;
begin
 partes              := StrToIntDef( chamaInput('INTEGER', 'Fracionar produto em quantas partes?'),0);

 if (partes = 0) or not confirma('Atenção! Confirma particionamento do produto:'+#13#10+
                                 cdsItensPRODUTO.AsString+'?'#13#10+#13#10+
                                '(Será particionado em '+intToStr(partes)+' partes)') then
   exit;

 try
   ListaItens := TObjectList<TItem>.Create(true);

   if not cdsAdicionais.IsEmpty then begin
     contem_adicional := true;
     lista_adicionais := TObjectList<TAdicionalItem>.Create;
   end;

   repositorio         := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
   ListaItens.Add( TItem(repositorio.Get(cdsItensCODIGO_ITEM.AsInteger)) );

   quantidade          := RoundTo(ListaItens[0].quantidade / partes, -4);
   diferenca           := roundTo(ListaItens[0].quantidade - (quantidade * partes),-4);
   diferenca           := Trunc(diferenca * 1000) / 1000;

   if diferenca > 0.01 then
   begin
     centavos          := trunc(diferenca / 0.01);
     diferenca         := diferenca - (Trunc(diferenca * 100) / 100);
   end;

   ListaItens[0].quantidade     := quantidade + diferenca;
   ListaItens[0].Fracionado     := 'S';
   ListaItens[0].qtd_fracionado := partes;
   repositorio.Salvar(ListaItens[0]);

   if contem_adicional then
   begin
     repositorioAd := TFabricaRepositorio.GetRepositorio(TAdicionalItem.ClassName);

     cdsAdicionais.First;
     while not cdsAdicionais.Eof do begin
       if cdsAdicionais.FieldByName('VALOR').AsFloat > 0 then
       begin
          Adicional     := TAdicionalItem(repositorioAd.Get(cdsAdicionais.FieldByName('CODIGO').AsInteger) );
          lista_adicionais.Add(Adicional);
       end;
       cdsAdicionais.Next;
     end;
   end;

   for i := 1 to partes - 1 do
   begin
     ListaItens.Add(TItem.Create);
     ListaItens[i].codigo_pedido  := ListaItens[0].codigo_pedido;
     ListaItens[i].codigo_produto := ListaItens[0].codigo_produto;
     ListaItens[i].hora           := ListaItens[0].hora;
     ListaItens[i].valor_Unitario := ListaItens[0].valor_Unitario;
     ListaItens[i].codigo_usuario := ListaItens[0].codigo_usuario;
     ListaItens[i].qtd_fracionado := ListaItens[0].qtd_fracionado;
     ListaItens[i].codigo_pedido  := ListaItens[0].codigo_pedido;
     ListaItens[i].quantidade     := quantidade;

     // a sobra de centavos nunca será maior que a quantidade de itens
     if (i >= (partes-centavos)) then
       ListaItens[i].quantidade := ListaItens[i].quantidade + 0.01;

     ListaItens[i].Fracionado := 'S';
     repositorio.Salvar(ListaItens[i]);

     if contem_adicional then begin
       cdsAdicionais.First;

       //salva adicional(is) para cada item criado
       for x := 0 to lista_adicionais.Count - 1 do begin
          lista_adicionais.Items[x].codigo      := 0;
          lista_adicionais.Items[x].codigo_item := ListaItens[i].codigo;
          repositorioAd.Salvar( lista_adicionais.Items[x] );
       end;
     end;
   end;

   cdsAdicionais.EmptyDataSet;
   cdsItens.AfterScroll := nil;
   cdsItens.Delete;
   for Item in ListaItens  do
   begin
     cdsItens.Insert;
     cdsItensCODIGO_ITEM.AsInteger := Item.codigo;
     cdsItensQUANTIDADE.AsFloat    := Item.quantidade;
     cdsItensPRODUTO.AsString      := Item.Produto.descricao;
     cdsItensVLR_UNITARIO.AsFloat  := Item.valor_Unitario;
     cdsItensVLR_TOTAL.AsFloat     := roundTo(Item.quantidade * Item.valor_Unitario, -4) + roundTo(Item.quantidade * Item.totalAdicionais, -4);
     cdsItensVLR_PAGO.AsFloat      := 0;
     cdsItensFRACIONADO.AsString   := 'S';
     cdsItensQTD_PAGA.AsFloat      := 0;
     cdsItensQTD_A_PAGAR.AsFloat   := 0;
     cdsItens.Post;

     if assigned(Item.Adicionais) and (Item.Adicionais.Count > 0) then
       for Adicional in Item.Adicionais do
       begin
         cdsAdicionais.Append;
         cdsAdicionais.FieldByName('CODIGO').AsInteger       := Adicional.codigo;
         cdsAdicionais.FieldByName('DESCRICAO').AsString     := Adicional.Materia.descricao;
         cdsAdicionais.FieldByName('VALOR').AsFloat          := Adicional.valor_unitario * Adicional.quantidade;
         cdsAdicionais.FieldByName('CODIGO_ITEM').AsInteger  := Adicional.codigo_item;
         cdsAdicionais.FieldByName('VALOR_UNITARIO').AsFloat := Adicional.valor_unitario;
         cdsAdicionais.FieldByName('QUANTIDADE').AsFloat     := Adicional.quantidade;
         cdsAdicionais.Post;
       end;

   end;

   cdsItens.AfterScroll     := cdsItensAfterScroll;
   cdsItensAfterScroll(nil);
   cdsItens.IndexFieldNames := 'PRODUTO';

   recalculaTotalPedido;
  Finally
    lista_adicionais.Free;
    ListaItens.Free;
  end;
end;

procedure TfrmFinalizaPedido.FracionarItem1Click(Sender: TObject);
begin
  fraciona_item;
end;

end.
