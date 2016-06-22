unit uPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, frameBuscaComanda, ExtCtrls, Provider,
  DB, DBClient, Grids,
  DBGrids, DBGridCBN, pngimage, Buttons, frameBuscaProduto, Produto, Mask,
  RXToolEdit, RXCurrEdit, Pedido, StrUtils, contnrs, Menus, MateriaPrima, Funcoes,
  ImgList, ComCtrls, ACBrBase, DateTimeUtilitario, ACBrDevice, Parametros,
  frameBuscaCliente, System.ImageList;

type
  TfrmPedido = class(TfrmPadrao)
    pnlTopo: TPanel;
    buscaComanda1: TBuscaComanda;
    cbMesa: TComboBox;
    Label1: TLabel;
    edtData: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    lbUsuario: TLabel;
    pnlDados: TPanel;
    gridItens: TDBGridCBN;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cdsItensCODIGO: TIntegerField;
    cdsItensCODIGO_PRODUTO: TIntegerField;
    cdsItensVALOR: TFloatField;
    grpItem: TGroupBox;
    BuscaProduto1: TBuscaProduto;
    btnAdd: TBitBtn;
    cdsItensHORA: TTimeField;
    edtQuantidade: TCurrencyEdit;
    Label4: TLabel;
    Label5: TLabel;
    cdsItensDESCRICAO: TStringField;
    Shape1: TShape;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    edtQtdeTotal: TCurrencyEdit;
    edtValorTotal: TCurrencyEdit;
    grpObservacao: TGroupBox;
    memoObservacoes: TMemo;
    Label8: TLabel;
    lbQtdCaracters: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Image5: TImage;
    edtTotalItens: TCurrencyEdit;
    edtValorDesconto: TCurrencyEdit;
    edtValorAcrescimo: TCurrencyEdit;
    edtCouvert: TCurrencyEdit;
    edtTotalPedido: TCurrencyEdit;
    imgPedido: TImage;
    Label11: TLabel;
    edtStatus: TEdit;
    lbCodigoUsuario: TLabel;
    gridAdicionais: TDBGridCBN;
    cdsAdicionais: TClientDataSet;
    dsAdicionais: TDataSource;
    cdsAdicionaisCODIGO: TIntegerField;
    cdsAdicionaisDESCRICAO: TStringField;
    cdsAdicionaisVALOR: TFloatField;
    GroupBox3: TGroupBox;
    Label20: TLabel;
    edtTotalAdicionais: TCurrencyEdit;
    cdsAdicionaisFLAG: TStringField;
    Shape2: TShape;
    Shape3: TShape;
    Label12: TLabel;
    Label18: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    PopupMenu1: TPopupMenu;
    AdicionarItem1: TMenuItem;
    RemoverItem1: TMenuItem;
    cdsAdicionaisCODIGO_PRODUTO: TIntegerField;
    cdsAdicionaisCODIGO_ITEM: TIntegerField;
    cdsAdicionaisCODIGO_MATERIA: TIntegerField;
    ImageList1: TImageList;
    pnlRodape: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFinalizar: TBitBtn;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Label9: TLabel;
    lbDelete: TLabel;
    Shape7: TShape;
    Image6: TImage;
    Image7: TImage;
    cdsItensINDICE: TIntegerField;
    cdsAdicionaisINDICE_ITEM: TIntegerField;
    Label19: TLabel;
    Label21: TLabel;
    edtTaxaServico: TCurrencyEdit;
    btnImprimirPedido: TBitBtn;
    Shape14: TShape;
    cdsItensTIPO: TStringField;
    edtPercenTaxa: TCurrencyEdit;
    cdsItensVALOR_UNITARIO: TFloatField;
    cdsAdicionaisVALOR_UNITARIO: TFloatField;
    btnenviarNFCe: TBitBtn;
    btnLiberarComanda: TBitBtn;
    btnAgrupa: TSpeedButton;
    cdsAgrupaComanda: TClientDataSet;
    dsAgrupaComanda: TDataSource;
    cdsAgrupaComandaCOD_COMANDA: TIntegerField;
    edtCliente: TEdit;
    Label27: TLabel;
    cdsItensIMPRESSO: TStringField;
    Label6: TLabel;
    cdsItensCODIGO_USUARIO: TIntegerField;
    chkDuasVias: TCheckBox;
    edtPreco: TCurrencyEdit;
    Label22: TLabel;
    pnlAgrupa: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    btnConfirmaAgrupamento: TSpeedButton;
    btnCancelaAgrupamento: TSpeedButton;
    edtCodCOmanda: TCurrencyEdit;
    gridAgrupa: TDBGrid;
    lbCliente: TLabel;
    edtTaxaEntrega: TCurrencyEdit;
    edtStatusPedExterno: TEdit;
    cdsItensFRACIONADO: TStringField;
    cdsItensQUANTIDADE_PG: TFloatField;
    cdsAdicionaisQUANTIDADE: TFloatField;
    Label28: TLabel;
    edtTelefone: TMaskEdit;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    cdsItensQUANTIDADE: TStringField;
    cdsItensQTD_FRACIONADO: TIntegerField;
    edtCpf: TEdit;
    btnFinalizaRapido: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure memoObservacoesChange(Sender: TObject);
    procedure edtValorDescontoChange(Sender: TObject);
    procedure buscaComanda1Exit(Sender: TObject);
    procedure edtStatusChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memoObservacoesKeyPress(Sender: TObject; var Key: Char);
    procedure gridAdicionaisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure AdicionarItem1Click(Sender: TObject);
    procedure RemoverItem1Click(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure gridAdicionaisColEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridAdicionaisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grpItemExit(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirPedidoClick(Sender: TObject);
    procedure buscaComanda1btnBuscaClick(Sender: TObject);
    procedure btnenviarNFCeClick(Sender: TObject);
    procedure btnLiberarComandaClick(Sender: TObject);
    procedure btnAgrupaClick(Sender: TObject);
    procedure buscaComanda1edtNumeroComandaChange(Sender: TObject);
    procedure edtCodCOmandaExit(Sender: TObject);
    procedure gridAgrupaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaAgrupamentoClick(Sender: TObject);
    procedure cdsAgrupaComandaAfterInsert(DataSet: TDataSet);
    procedure cdsAgrupaComandaAfterDelete(DataSet: TDataSet);
    procedure btnCancelaAgrupamentoClick(Sender: TObject);
    procedure edtCodCOmandaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTaxaServicoChange(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure BuscaProduto1Exit(Sender: TObject);
    procedure buscaComanda1edtNumeroComandaExit(Sender: TObject);
    procedure edtCpfChange(Sender: TObject);
    procedure edtCpfKeyPress(Sender: TObject; var Key: Char);
    procedure edtTelefoneExit(Sender: TObject);
    procedure btnFinalizaRapidoClick(Sender: TObject);

  private
    Parametros           :TParametros;
    FItensDeletados      :TStringList;
    FAdicionaisDeletados :TStringList;
    comandas             :String;
    produtos_no_pedido   :Integer;
    comanda_principal    :integer;
    Fcodigo_pedido        :Integer;

    procedure carrega_padroes;
    procedure busca_item_para_inclusao(AdicionaRemove :String);

  public
    procedure adiciona_item(Produto :TProduto; quantidade, valor :Real; impresso :String; codigo_usu :integer; hora, fracionado: String; quantidade_paga :Real; qtd_fracionado :integer; const codigo :integer = 0);
    procedure adiciona_no_produto(Materia :TMateriaPrima; quantidade :Integer; codigo_produto :integer; flag :String;
                                  const codigo_item :integer =0; const codigo :integer = 0);

  private
    procedure calcula_totais;
//    procedure calculaRateioItens;

    procedure carrega_dados_pedido(Pedido :TPedido);
    procedure limpa_dados_pedido;
    procedure cria_imprime_pedido_parcial;

    function confere_obrigatorios :Boolean;
    function agrupa_comandas: Boolean;
    function unifica_pedidos :Boolean;

  private
    procedure Salva_Pedido(const mantem_na_tela :boolean = false);
    procedure Salva_Pedido_pos_recebimento(const recebendo :boolean = false; const finalizando :boolean = false);
    procedure Salva_movimento(Pedido :TPedido);

    procedure salva_recebimento_por_item;

    procedure armazena_item_selecionado;
    procedure armazena_adicional_selecionado(const pergunta :Boolean = true);

    procedure remove_itens;
    procedure remove_adicionais;

    procedure alterar_item;
    procedure atualiza_tela;

    procedure Gera_cupom_eletronico;
    procedure Baixa_estoque(Pedido :TPedido);

    function tem_movimento  :Boolean;
    procedure imprimir_pedido(const pelo_botao :boolean = false);

    procedure finalizaPedido(const rapido :Boolean = false);
    procedure Cancela_pedido;
    procedure libera_comanda(situacao :String);

end;
    
var
  frmPedido: TfrmPedido;

implementation

uses Usuario, Item, Comanda, uModulo, repositorio, FabricaRepositorio, Empresa, uAdicionaItemProduto,
     Math, AdicionalItem, CriaBalaoInformacao, uFinalizaPedido, Movimento, RepositorioPedido,
     ZConnection, Departamento, Estoque, EspecificacaoEstoquePorProduto, uInicial, PermissoesAcesso, ItemDeletado,
     uPesquisaSimples, Venda, ServicoEmissorNFCe, ConfiguracoesSistema, Cliente, Endereco,
     ParametrosNFCe, ParametrosDANFE, StringUtilitario, EspecificacaoClientePorCpfCnpj,
     EspecificacaoMovimentosPorCodigoPedido;

{$R *.dfm}

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsAdicionais.CreateDataSet;
  carrega_padroes;
  FItensDeletados      := TStringList.Create;
  FAdicionaisDeletados := TStringList.Create;
  label19.Caption      := IfThen(dm.Configuracoes.Utiliza_comandas, 'N° comanda', 'N° mesa');
  label1.Visible       := dm.Configuracoes.Utiliza_comandas;
  cbMesa.Visible       := dm.Configuracoes.Utiliza_comandas;
  cbmesa.ItemIndex     := IfThen(dm.Configuracoes.Utiliza_comandas, -1, 0);
  buscaComanda1.btnFormaBusca.Visible := dm.Configuracoes.possui_delivery;
  edtValorDesconto.Enabled := dm.Configuracoes.desconto_pedido;
end;

procedure TfrmPedido.btnAddClick(Sender: TObject);
begin
  if not assigned(BuscaProduto1.Produto) then begin
    avisar('Nenhum produto foi selecionado para a inserção');
    BuscaProduto1.edtCodigo.SetFocus;
  end
  else if edtQuantidade.Value <= 0 then begin
    avisar('A quantidade ainda não foi informada');
    edtQuantidade.SetFocus;
  end
  else if edtPreco.Value <= 0 then begin
    avisar('O preço não foi informado');
    edtPreco.SetFocus;
  end
  else begin
    adiciona_item(BuscaProduto1.Produto,
                  edtQuantidade.Value,
                  IfThen(edtpreco.Value > 0, edtPreco.Value, Buscaproduto1.Produto.valor),
                  IfThen(BuscaProduto1.Produto.tipo = 'S', 'S', ''),
                  dm.UsuarioLogado.Codigo,
                  TimeToStr(Time),
                  'N',
                  0,
                  0);

    if BuscaProduto1.edtCodigo.Enabled then
      BuscaProduto1.edtCodigo.SetFocus;
  end;
end;

procedure TfrmPedido.adiciona_item(Produto: TProduto; quantidade, valor :Real; impresso :String; codigo_usu :integer; hora, fracionado: String; quantidade_paga :Real; qtd_fracionado :integer; const codigo :integer);
var sobra, diferenca, qtde, valorD :Real;
    primeiroFracionado :Boolean;
begin
  sobra     := 0;
  qtde      := 0;
  diferenca := 0;
  primeiroFracionado := false;

  if (qtd_fracionado > 0) and not (cdsItens.Locate('CODIGO_PRODUTO;FRACIONADO',varArrayOf([Produto.codigo, fracionado]),[]))then
    primeiroFracionado := true;

  if BuscaProduto1.edtCodigo.Enabled then begin
    cdsItens.Append;

    cdsItensCODIGO.AsInteger         := codigo;
    cdsItensCODIGO_PRODUTO.AsInteger := Produto.codigo;
    cdsItensDESCRICAO.AsString       := Produto.descricao;
    cdsItensHORA.AsString            := hora;
    cdsItensINDICE.AsInteger         := cdsItens.RecordCount + 1;
    cdsItensTIPO.AsString            := Produto.tipo;
    cdsItensIMPRESSO.AsString        := impresso;
    cdsItensCODIGO_USUARIO.AsInteger := codigo_usu;
    cdsItensFRACIONADO.AsString      := fracionado;
    cdsItensQUANTIDADE_PG.AsFloat    := quantidade_paga;
    cdsItensQTD_FRACIONADO.AsInteger := qtd_fracionado;

   if cdsItensTIPO.AsString = 'P' then
     inc( produtos_no_pedido );
  end
  else begin
    cdsItens.Edit;
    BuscaProduto1.edtCodigo.Enabled := true;
    BuscaProduto1.btnBusca.Enabled  := true;
    gridItens.Enabled               := true;
    btnAdd.Caption                  := ' ADICIONA';
  end;

  cdsItensVALOR_UNITARIO.AsFloat    := valor;

  {se for serviço e for quantidade > 599, quer dizer que é boliche, que é medido em tempo e armazena os segundos}
  if (Produto.tipo = 'S') and (((quantidade > 198)and(Fracionado = 'S')) or (quantidade > 599)) then begin //00 = 10min
    cdsItensQUANTIDADE.AsString       := TDateTimeUtilitario.SegundosParaTime(trunc(quantidade));

    if qtd_fracionado > 0 then
    begin
      qtde := RoundTo(1/qtd_fracionado,-2);
      sobra := 1- (RoundTo(1/qtd_fracionado,-2) * qtd_fracionado);
    end
    else
      qtde := 1;

    if primeiroFracionado then
    begin
      valorD := roundTo( qtde * valor, -2) * qtd_fracionado;
      valorD := valorD + roundTo(sobra * valor,-2);
      diferenca := valor - valorD;

      qtde   := qtde + sobra;
    end;

    cdsItensVALOR.AsCurrency          := roundTo(valor * qtde, -2) + diferenca;
  end
  else begin
    cdsItensQUANTIDADE.AsString       := FloatToStr(quantidade);
    cdsItensVALOR.AsCurrency          := RoundTo((quantidade * valor),-2);
  end;

  cdsItens.Post;

  BuscaProduto1.limpa;
  edtQuantidade.Clear;
  edtPreco.Clear;

  calcula_totais;
end;

procedure TfrmPedido.gridItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  {Remove Horizontal}
  ShowScrollBar(gridItens.Handle,SB_HORZ,False);

  {Remove Vertical}
 // ShowScrollBar(DBGridCBN1.Handle,SB_VERT,False);
end;
 {
procedure TfrmPedido.calculaRateioItens;
var descontoPorItem :Real;
    totalRateado :Real;
    Item :TItem;
begin
  totalRAteado := 0;

  for Item in buscaComanda1.Pedido.Itens do
  begin
    descontoPorItem := roundTo( (Item.totalBruto * buscaComanda1.Pedido.valor_total)/100, -2);

    Item.desconto := (descontoPorItem * buscaComanda1.Pedido.desconto)/100;

    totalRAteado := totalRateado + Item.desconto;
  end;

  if buscaComanda1.Pedido.desconto > totalRateado then
    buscaComanda1.Pedido.Itens[0].desconto := buscaComanda1.Pedido.Itens[0].desconto + (buscaComanda1.Pedido.desconto - totalRateado);

  buscaComanda1.Pedido.Itens
end;                         }

procedure TfrmPedido.calcula_totais;
var total_valor_produtos :Real;
    total_valor_servicos :Real;
    total_qtde_itens     :Real;
    total_adicionados    :Real;
    linha                :integer;
begin
  total_valor_produtos := 0;
  total_valor_servicos := 0;
  total_qtde_itens     := 0;
  total_adicionados    := 0;
  edtQtdeTotal.Clear;
  edtValorTotal.Clear;
  edtTaxaServico.Clear;
  edtTotalItens.Clear;
  edtTotalPedido.Clear;

  if cdsItens.IsEmpty then
    Exit;

 { if edtValorDesconto.Value > 0 then
    calculaRateioItens;  }

  linha := cdsItens.RecNo;
  cdsItens.First;
  while not cdsItens.Eof do begin

    if cdsItensTIPO.AsString = 'P' then
      total_valor_produtos := total_valor_produtos + cdsItensVALOR.AsFloat
    else
      total_valor_servicos := total_valor_servicos + cdsItensVALOR.AsFloat;

    try
      total_qtde_itens  := total_qtde_itens + StrToFloat(cdsItensQUANTIDADE.AsString);
    except
      total_qtde_itens  := total_qtde_itens + 1;
    end;

    cdsItens.Next;
  end;

  cdsItens.AfterScroll   := nil;
  cdsAdicionais.Filtered := false;
  cdsAdicionais.First;
  while not cdsAdicionais.Eof do begin

    if cdsAdicionaisFLAG.AsString = 'A' then begin
      cdsItens.Locate('INDICE', cdsAdicionaisINDICE_ITEM.AsInteger,[]);

      total_adicionados := total_adicionados + RoundTo(( cdsAdicionaisVALOR.AsFloat * StrToFloat(cdsItensQUANTIDADE.AsString)), -2);
    end;

    cdsAdicionais.Next;
  end;

  cdsItens.RecNo         := linha;
  cdsAdicionais.Filtered := true;
  cdsItens.AfterScroll   := cdsItensAfterScroll;

  edtQtdeTotal.Value       := total_qtde_itens;
  edtValorTotal.Value      := total_valor_produtos + total_valor_servicos;
  edtTotalItens.Value      := total_valor_produtos + total_valor_servicos;
  edtTotalAdicionais.Value := total_adicionados;
  edtValorAcrescimo.Value  := total_adicionados;

  edtTotalPedido.Value := (edtTotalItens.Value - edtValorDesconto.Value + edtValorAcrescimo.Value);

  edtTaxaServico.Value := ((total_valor_produtos + total_adicionados) * edtPercenTaxa.Value) / 100;

  edtTotalPedido.Value := edtTotalPedido.Value + edtCouvert.Value + edtTaxaServico.Value + edtTaxaEntrega.Value;
end;

procedure TfrmPedido.memoObservacoesChange(Sender: TObject);
begin
  lbQtdCaracters.Caption := IntToStr(length(memoObservacoes.Text));
end;

procedure TfrmPedido.edtValorDescontoChange(Sender: TObject);
begin
  if edtValorDesconto.Value > edtValorTotal.Value then
    edtValorDesconto.Value := edtValorTotal.Value;

  calcula_totais;
end;

procedure TfrmPedido.finalizaPedido(const rapido: Boolean);
begin
  if not confere_obrigatorios then
    exit;

  try
    Salva_Pedido(true); //salva e mantem na tela

    atualiza_tela;

    frmFinalizaPedido := TFrmFinalizaPedido.Create(self);
    frmFinalizaPedido.chkImprimeItens.Checked := self.Parametros.NFCe.DANFE.ImprimirItens;
    frmFinalizaPedido.edtTotalPedido.Value    := self.edtTotalPedido.Value;
    frmFinalizaPedido.edtTxServico.Value      := self.edtTaxaServico.Value;
    frmFinalizaPedido.edtDesconto.Value       := self.edtValorDesconto.Value;

    frmFinalizaPedido.preenche_cds(cdsItens);
    frmFinalizaPedido.cdsAdicionais.CloneCursor(self.cdsAdicionais,true,false);
    frmFinalizaPedido.codigo_pedido  := buscaComanda1.Pedido.codigo;
    frmFinalizaPedido.finalizaRapido := rapido;

    if assigned(buscaComanda1.Pedido) and (buscaComanda1.Pedido.tipo_moeda <> '') then
      frmFinalizaPedido.cmbTipoMoeda.ItemIndex := strToInt(buscaComanda1.Pedido.tipo_moeda)-1;

    if frmFinalizaPedido.ShowModal = mrOk then begin
      try

         if frmFinalizaPedido.cdsItens.Locate('FRACIONADO', 'S', []) then begin
           buscaComanda1.Pedido := nil;
           buscaComanda1.Pedido;
         end;

         Salva_Pedido_pos_recebimento(true, (frmFinalizaPedido.edtTotalRestante.value = 0) );

         buscaComanda1.CodigoPedido := Self.Fcodigo_pedido;

         if not (frmFinalizaPedido.cdsItensPrePagos.IsEmpty) and (frmFinalizaPedido.edtTotalRestante.Value > 0) then
            cria_imprime_pedido_parcial;

         if not (frmFinalizaPedido.ckbSC.Checked) and (produtos_no_pedido > 0) and (buscaComanda1.Pedido.sts_recebimento = 'F') then begin
           try
               Aguarda('Aguarde, gerando cupom eletrônico...');
               Gera_cupom_eletronico;

           Finally;
             FimAguarda('');
           end;
         end;

      Except
        On E: Exception do
          avisar(e.Message);
      end;

      btnCancelar.Click;

    end
    else
      atualiza_tela;

  Finally
    frmFinalizaPedido.Release;
    frmFinalizaPedido := nil;
    comandas          := '';
  end;
end;

procedure TfrmPedido.buscaComanda1Exit(Sender: TObject);
begin
  inherited;

 try
   buscaComanda1.OnExit := nil;

   if not buscaComanda1.Enabled then
     Exit;

   if buscaComanda1.btnFormaBusca.TAG = 0 then begin
      if not assigned( buscaComanda1.Comanda ) then begin
        buscaComanda1.Enabled := true;
        buscaComanda1.edtNumeroComanda.SetFocus;
        TCriaBalaoInformacao.ShowBalloonTip(buscaComanda1.edtCodigo.Handle,'Primeiramente, selecione uma comanda.', 'Informação', 1);
        exit;
      end;

      if not buscaComanda1.Comanda.ativa then begin
        avisar('ATENÇÃO!!!'+#13#10+'A comanda informada está bloqueada.'+
               #13#10+'Motivo bloqueio: '+buscaComanda1.Comanda.motivo);
        btnCancelar.Click;
        Exit;
      end;
   end
   else begin
     if not assigned( buscaComanda1.Pedido ) then begin
        buscaComanda1.Enabled := true;
        buscaComanda1.edtNumeroComanda.SetFocus;        
        TCriaBalaoInformacao.ShowBalloonTip(buscaComanda1.edtCodigo.Handle,'Primeiramente, selecione um pedido externo.', 'Informação', 1);
        exit;
     end;
   end;

   Fcodigo_pedido := 0;

   carrega_dados_pedido(buscaComanda1.Pedido);

 finally
   buscaComanda1.OnExit := buscaComanda1Exit;
 end;
end;

procedure TfrmPedido.carrega_dados_pedido(Pedido :TPedido);
var i, x :integer;
    Item :TItem;
begin
  buscaComanda1.Enabled := false;

  if not assigned(Pedido) then begin
     btnImprimirPedido.Visible := false;
     edtData.Text            := DateToStr(Date);
     edtStatus.Text          := 'CRIANDO PEDIDO';
     carrega_padroes;
     pnlDados.Enabled        := true;
     BuscaProduto1.edtCodigo.SetFocus;
     Exit;
   end;

  if buscaComanda1.Pedido.situacao = 'C' then
    Exit;

 try

    if AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR']) then
      btnImprimirPedido.Visible := true;

    if buscaComanda1.Pedido.sts_recebimento = 'F' then begin
      pnlDados.Enabled        := false;
      btnFinalizar.Enabled    := false;
      btnSalvar.Enabled       := false;
      btnenviarNFCe.Visible   := AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR']);
      edtStatus.Text          := 'AGUARDANDO CUPOM ELETRÔNICO';

      if btnEnviarNFce.visible and btnEnviarNFce.Enabled then
        btnEnviarNFce.SetFocus;
    end
    else begin
      pnlDados.Enabled := true;
      edtStatus.Text          := 'ALTERANDO PEDIDO';
      BuscaProduto1.edtCodigo.SetFocus;
    end;

    if not cdsAdicionais.IsEmpty then
      cdsAdicionais.EmptyDataSet;
    if not cdsItens.IsEmpty then
      cdsItens.EmptyDataSet;

    cdsAdicionais.DisableControls;
    cdsItens.DisableControls;
    cbMesa.ItemIndex        := cbMesa.Items.IndexOf( IntToStr(IfThen(Pedido.codigo_mesa = 0, 1, Pedido.codigo_mesa)) );
    edtData.Text            := DateToStr(Pedido.data);
    memoObservacoes.Text    := Pedido.observacoes;
    edtCliente.Text         := Pedido.nome_cliente;
    edtTelefone.Text        := Pedido.telefone;
    edtCPF.Text             := Pedido.cpf_cliente;


    if not assigned(Pedido.Itens) then begin
      edtStatus.Text := 'PEDIDO SEM ITENS';

      if confirma('Pedido associado a comanda '+buscaComanda1.edtCodigo.Text+' não contém itens.'+#13#10+ 'Cancelar pedido?') then
        Cancela_pedido;

      btnCancelar.Click;

      exit;
    end;

    for i := 0 to Pedido.Itens.Count -1 do begin

      Item := (Pedido.Itens[i] as TItem);

      {Se for boliche pega o valor do arquivo e nao o cadastrado no produto}
      if (Pedido.Itens[i] as TItem).Produto.codigo = 1 then
        Item.Produto.valor := (Pedido.Itens[i] as TItem).valor_Unitario;

      adiciona_item( Item.Produto,
                     Item.quantidade,
                     Item.valor_Unitario,
                     Item.impresso,
                     Item.codigo_usuario,
                     TimeToStr(Item.hora),
                     Item.Fracionado,
                     Item.quantidade_pg,
                     Item.qtd_fracionado,
                     Item.codigo);

      if assigned((Pedido.Itens[i] as TItem).Adicionais) then begin

        for x :=0 to (Pedido.Itens[i] as TItem).Adicionais.Count -1 do
          adiciona_no_produto( (Item.Adicionais.items[x] as TAdicionalItem).Materia,
                               (Item.Adicionais.items[x] as TAdicionalItem).quantidade,
                               Item.codigo_produto,
                               (Item.Adicionais.items[x] as TAdicionalItem).flag,
                               (Item.Adicionais.items[x] as TAdicionalItem).codigo_item,
                               (Item.Adicionais.items[x] as TAdicionalItem).codigo);

      end;
    end;

    gridAdicionais.SelectedIndex := 1;
    edtValorDesconto.Value       := Pedido.desconto;
    edtValorAcrescimo.Value      := Pedido.acrescimo;
    edtCouvert.Value             := Pedido.couvert;
    edtTaxaServico.Value         := Pedido.taxa_servico;
    edtTaxaEntrega.Value         := Pedido.taxa_entrega;

    calcula_totais;

    if Pedido.codigo_comanda = 0 then
      edtStatusPedExterno.Text := IfThen(Pedido.Codigo_endereco > 0, 'PEDIDO PARA ENTREGA (TAXA DE R$'+TStringUtilitario.FormataDinheiro(buscaComanda1.Pedido.taxa_entrega)+')',
                                                                     'PEDIDO PARA RETIRADA NO LOCAL');

    cdsAdicionais.EnableControls;
    cdsItens.EnableControls;

    Fcodigo_pedido := Pedido.codigo;

 finally
   buscaComanda1.Enabled := false;
 end;
end;

procedure TfrmPedido.edtStatusChange(Sender: TObject);
begin
  case AnsiIndexStr(UpperCase(edtStatus.Text), ['CRIANDO PEDIDO', 'ALTERANDO PEDIDO','PEDIDO CANCELADO', 'AGUARDANDO CUPOM ELETRÔNICO']) of
   0 : edtStatus.Font.Color := $00AAFFAA;
   1 : edtStatus.Font.Color := $00F9E8D9;
   2 : edtStatus.Font.Color := $000000C1;
   3 : edtStatus.Font.Color := $0080FFFF;
  end;

end;

procedure TfrmPedido.limpa_dados_pedido;
begin
  buscaComanda1.limpa;
  cbmesa.ItemIndex     := IfThen(dm.Configuracoes.Utiliza_comandas, -1, 0);
  edtData.Clear;
  edtStatus.Clear;
  edtStatusPedExterno.Clear;
  memoObservacoes.Clear;
  cdsItens.EmptyDataSet;
  cdsAdicionais.EmptyDataSet;
  edtQtdeTotal.Clear;
  edtValorTotal.Clear;
  edtTotalItens.Clear;
  edtValorDesconto.Clear;
  edtValorAcrescimo.Clear;
  edtTaxaServico.Clear;
  edtTaxaEntrega.Clear;
  edtTotalPedido.Clear;
  lbUsuario.Caption       := '-';
  lbCodigoUsuario.Caption := '--';
  edtCliente.Clear;
  edtTelefone.Clear;
  edtCPF.Clear;
  BuscaProduto1.limpa;
  edtpreco.Clear;
end;

procedure TfrmPedido.btnSalvarClick(Sender: TObject);
begin
  if confere_obrigatorios then
    Salva_Pedido;
end;

function TfrmPedido.confere_obrigatorios: Boolean;
begin
  result := false;

  if buscaComanda1.edtNumeroComanda.Text = '' then begin
    avisar('Primeiramente selecione a comanda desejada.');
    buscaComanda1.edtNumeroComanda.SetFocus;
  end
  else if not (cbMesa.ItemIndex >= 0) then begin
    avisar('A mesa não foi informada.');
    cbmesa.SetFocus;
  end
  else if cdsItens.IsEmpty then begin
    avisar('Ao menos 1 item deve ser inserido ao pedido.');
    BuscaProduto1.edtCodigo.SetFocus;
  end
  {else if TRIM(edtCliente.Text) = '' then begin
    avisar('O nome do cliente deve ser informado.');
    edtCliente.SetFocus;
  end }
  else
    result := true;
end;

procedure TfrmPedido.Salva_Pedido(const mantem_na_tela :boolean);
var repositorio   :TRepositorio;
    Item          :TItem;
    Itens         :TObjectList;
    AdicionalItem :TAdicionalItem;
    Caminho_externo :String;
    before_Conect  :TNotifyEvent;
    codigo_pedido :integer;
begin
 try
   if fdm.conexao.InTransaction then
     fdm.conexao.Commit;
     
   before_Conect                      := fdm.conexao.BeforeConnect;
   fdm.conexao.BeforeConnect          := nil;
   fdm.conexao.TxOptions.AutoCommit   := false;
 try

   repositorio := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

   if not assigned(buscaComanda1.Pedido) then
     buscaComanda1.Pedido := TPedido.Create;

   //controla o codigo do pedido para quando é sem comanda
   Fcodigo_pedido := buscaComanda1.Pedido.codigo;

   //buscaComanda1.Pedido.imprime_apos_salvar := not (finalizado);

   if assigned(buscaComanda1.Comanda) then
     buscaComanda1.Pedido.codigo_comanda  := buscaComanda1.Comanda.codigo;

   buscaComanda1.Pedido.codigo_mesa     := StrToIntDef( cbMesa.Items[cbMesa.ItemIndex],0 );
   buscaComanda1.Pedido.data            := StrToDate( edtData.Text );
   buscaComanda1.Pedido.observacoes     := memoObservacoes.Text;
   buscaComanda1.Pedido.nome_cliente    := edtCliente.Text;
   buscaComanda1.Pedido.cpf_cliente     := edtCPF.Text;
   buscaComanda1.Pedido.telefone        := edtTelefone.Text;
   buscaComanda1.Pedido.situacao        := 'A';
   buscaComanda1.Pedido.couvert         := edtCouvert.Value;
   buscaComanda1.Pedido.taxa_servico    := edtTaxaServico.Value;
   buscaComanda1.Pedido.taxa_entrega    := edtTaxaEntrega.Value;
   buscaComanda1.Pedido.desconto        := edtValorDesconto.Value;
   buscaComanda1.Pedido.acrescimo       := edtValorAcrescimo.Value;
   buscaComanda1.Pedido.valor_total     := edtTotalPedido.Value;

   Itens := TObjectList.Create;
   Item  := nil;

   cdsItens.First;
   while not cdsItens.Eof do begin

     Item                := TItem.Create;
   //  testar as formas que passa por aqui.. se sempre que ja tem item que foi salvo, esta puxando o seu codigo
     Item.codigo         := cdsItensCODIGO.AsInteger;
     Item.codigo_produto := cdsItensCODIGO_PRODUTO.AsInteger;
     Item.valor_Unitario := cdsItensVALOR_UNITARIO.AsFloat;
     Item.hora           := cdsItensHORA.AsDateTime;
     Item.codigo_usuario := dm.UsuarioLogado.Codigo;
     Item.impresso       := cdsItensIMPRESSO.AsString;
     Item.codigo_usuario := cdsItensCODIGO_USUARIO.AsInteger;
     Item.quantidade_pg  := cdsItensQUANTIDADE_PG.AsFloat;
     Item.Fracionado     := cdsItensFRACIONADO.AsString;
     Item.qtd_fracionado := cdsItensQTD_FRACIONADO.AsInteger;

     try
       if cdsItensQUANTIDADE.AsFloat < 100 then
         Item.quantidade := StrToFloat(cdsItensQUANTIDADE.AsString)
       else
         Item.quantidade := StrToInt(cdsItensQUANTIDADE.AsString);
     Except
       Item.quantidade := TDateTimeUtilitario.TimeParaSegundos(cdsItensQUANTIDADE.AsDateTime);
     end;

     Item.Adicionais.Free;
     Item.Adicionais := nil;

     cdsItensAfterScroll(nil);
     if not cdsAdicionais.IsEmpty then begin

       AdicionalItem   := nil;
       Item.Adicionais := TObjectList.Create;

       {inclui o item adicional no item}
       cdsAdicionais.First;
       while not cdsAdicionais.Eof do begin

         AdicionalItem                := TAdicionalItem.Create;
         AdicionalItem.codigo         := cdsAdicionaisCODIGO.AsInteger;
         AdicionalItem.codigo_item    := cdsAdicionaisCODIGO_ITEM.AsInteger;
         AdicionalItem.codigo_materia := cdsAdicionaisCODIGO_MATERIA.AsInteger;
         AdicionalItem.flag           := cdsAdicionaisFLAG.AsString;
         AdicionalItem.quantidade     := cdsAdicionaisQUANTIDADE.AsInteger;
         AdicionalItem.valor_unitario := cdsAdicionaisVALOR_UNITARIO.asFloat;

         Item.Adicionais.Add( AdicionalItem );

         cdsAdicionais.Next;
       end;

     end;

     Itens.Add( Item );

     cdsItens.Next;
   end;

   buscaComanda1.Pedido.Itens := Itens;

   //rateia o valor do desconto e taxas entre os itens
  // calculaRateioItens;

   repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

   //salva hd externo, ou seja, onde fica com e sem cupom
   repositorio.Salvar( buscaComanda1.Pedido );

   Fcodigo_pedido := buscaComanda1.Pedido.codigo;

   fdm.conexao.Commit;
   if FItensDeletados.Count > 0       then remove_itens;
   if FAdicionaisDeletados.Count > 0  then remove_adicionais;

   if not mantem_na_tela then
      avisar('Pedido salvo com sucesso!',5);

   frmInicial.Cliente.Socket.SendText('imprime='+IntToStr(buscaComanda1.Pedido.codigo));

   if not mantem_na_tela then
     btnCancelar.Click
   else begin
     buscaComanda1.Pedido := nil;
     buscaComanda1.CodigoPedido := Self.Fcodigo_pedido;
     buscaComanda1.Pedido;
   end;

 Except
   On E: Exception do begin
     fdm.conexao.Rollback;
     buscaComanda1.Pedido.codigo := 0;

     raise Exception.Create('Erro ao salvar pedido. '+#13#10+e.Message);
   end;
 end;

 finally
   fdm.conexao.TxOptions.AutoCommit    := true;
   fdm.conexao.BeforeConnect := before_Conect;
 end;
end;

procedure TfrmPedido.Salva_Pedido_pos_recebimento(const recebendo :boolean = false; const finalizando :boolean = false);
var repositorio   :TRepositorio;
    Item          :TItem;
    Itens         :TObjectList;
    AdicionalItem :TAdicionalItem;
    Caminho_externo :String;
    before_Conect  :TNotifyEvent;
    codigo_pedido :Integer;
    Pedido : TPedido;
begin
 try
   if fdm.conexao.InTransaction then
     fdm.conexao.Commit;

   before_Conect             := fdm.conexao.BeforeConnect;
   fdm.conexao.BeforeConnect := nil;
   fdm.conexao.TxOptions.AutoCommit    := false;
 try

   repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   Pedido      := TPedido(repositorio.Get(buscaComanda1.Pedido.codigo));

   Pedido.situacao        := IfThen(finalizando,'F', 'A');

   Pedido.sts_recebimento := IfThen(finalizando,'F', 'P');

   if finalizando and (buscaComanda1.Pedido.valor_pago > 0) then
     Pedido.observacoes := Pedido.observacoes +'|'+'VALOR TOTAL: R$'+ TStringUtilitario.FormataDinheiro(Pedido.valor_total)+
                           ' TROCO: R$'+TStringUtilitario.FormataDinheiro(Pedido.valor_pago - Pedido.valor_total);

   repositorio.Salvar( Pedido );

   Fcodigo_pedido := Pedido.codigo;

   if recebendo then begin
     Salva_movimento(Pedido);

     if finalizando then begin
       Baixa_estoque(Pedido);
       imprimir_pedido(false);
     end;
   end;

   { se esta finalizando o pedido e não foi fechado com F10(sem cupom), salva tbm na base local}
   if finalizando and not(frmFinalizaPedido.ckbSC.Checked) and
      ((dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') or
       (dm.ArquivoConfiguracao.CaminhoBancoDeDados = dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal))then begin

     codigo_pedido       := Pedido.codigo;

     Caminho_externo     := dm.conexao.Params.Database;

     if fdm.conexao.InTransaction then
       fdm.conexao.Commit;

     dm.conexao.Connected := false;
     dm.conexao.Params.Database := dm.FDConnection.Params.Database;

     if not dm.conexao.Connected then
       dm.conexao.Connected := true;

     if fdm.conexao.InTransaction then
       fdm.conexao.Commit;

     {zera o codigo para não acusar como alteração na base externa}
     Pedido.codigo := 0;

     //salva base local
     repositorio.Salvar( Pedido );

     Salva_movimento(Pedido);
     fdm.conexao.Commit;

     if FItensDeletados.Count > 0       then remove_itens;
     if FAdicionaisDeletados.Count > 0  then remove_adicionais;

     dm.conexao.Connected := false;
     dm.conexao.Params.Database := Caminho_externo;

     if not dm.conexao.Connected then
       dm.conexao.Connected := true;

  //   Pedido.codigo := codigo_pedido;

   end;

   buscaComanda1.limpa;

 Except
   On E: Exception do begin
     fdm.conexao.Rollback;
     buscaComanda1.Pedido.codigo := 0;

     if dm.conexao.Params.Database = dm.FDConnection.Params.Database then begin
       if dm.conexao.Connected then
         dm.conexao.Connected := true;

       dm.conexao.Params.Database := Caminho_externo;
       dm.conexao.Connected := true;
     end;

     raise Exception.Create('Erro ao efetuar recebimento. Operação cancelada. '+#13#10+e.Message);
   end;
 end;

 finally
   fdm.conexao.TxOptions.AutoCommit    := true;
   fdm.conexao.BeforeConnect := before_Conect;
 end;
end;

procedure TfrmPedido.btnCancelarClick(Sender: TObject);
begin
  limpa_dados_pedido;
  pnlDados.Enabled          := false;
  buscaComanda1.Enabled     := true;
  buscaComanda1.edtNumeroComanda.SetFocus;
  btnImprimirPedido.Visible := false;
  btnenviarNFCe.Visible     := false;
  btnSalvar.Enabled         := true;
  btnFinalizar.Enabled      := true;
  FItensDeletados.Clear;
  FAdicionaisDeletados.Clear;
end;

procedure TfrmPedido.carrega_padroes;
var mesa :integer;
    Empresa :TEmpresa;
    repositorio :TRepositorio;
begin
 try
   Empresa := nil;
   repositorio := nil;
   mesa :=0;

   repositorio := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
   Empresa     := TEmpresa( repositorio.Get(1) );

   if not assigned(Empresa) then exit;

   while cbMesa.Items.Count < Empresa.Quantidade_mesas do begin
     inc(mesa);
     cbMesa.Items.Add( IntToStr(mesa) );
   end;
   cbMesa.Items.Add('99');
   
   if Empresa.Couvert then
     edtCouvert.Value         := Empresa.Valor_couvert
   else
     edtCouvert.Clear;
     
   edtPercenTaxa.Value      := Empresa.Taxa_servico;

 finally
   FreeAndNil(Empresa);
   FreeAndNil(repositorio);
 end;
end;

procedure TfrmPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ActiveControl = memoObservacoes) and (Key = VK_RETURN))
  or  (ActiveControl = edtCodComanda)   then
    Exit;

  if pnlRodape.Enabled then begin
    if (key = VK_F4) and (btnSalvar.Enabled) then
      self.btnSalvar.Click
    else if (key = VK_F7) and (btnFinalizaRapido.Enabled) then
      self.btnFinalizaRapido.Click
    else if (key = VK_F6) and (btnFinalizar.Enabled) and (btnFinalizar.Visible) then
      self.btnFinalizar.Click
    else if (Key = VK_F2) and (self.btnAgrupa.Enabled) then
      self.btnAgrupaClick(nil);
  end;

  inherited;
end;

procedure TfrmPedido.memoObservacoesKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpperCase(key)[1];
end;

procedure TfrmPedido.adiciona_no_produto(Materia: TMateriaPrima;
  quantidade: Integer; codigo_produto: integer; flag :String; const codigo_item :integer =0; const codigo :integer = 0);
begin
  if cdsAdicionais.Locate('CODIGO_PRODUTO;CODIGO_MATERIA', varArrayOf([codigo_produto, Materia.codigo]), []) then
    if Confirma('Já existe(m) '+cdsAdicionaisQUANTIDADE.AsString+' unidade(s) desta item, relacionada ao produto.'+#13#10+
                'Deseja substituir a relação atual pela informada?') then
      cdsAdicionais.Edit
    else
      Exit;

   if not (cdsAdicionais.State in [dsEdit]) then begin
     cdsAdicionais.Append;
     cdsAdicionaisCODIGO.AsInteger         := codigo;
   end;

   cdsAdicionaisDESCRICAO.AsString       := Materia.descricao;
   cdsAdicionaisVALOR.AsFloat            := IfThen(flag = 'A', (Materia.valor*quantidade), 0);
   cdsAdicionaisVALOR_UNITARIO.AsFloat   := IfThen(flag = 'A', (Materia.valor), 0);
   cdsAdicionaisFLAG.AsString            := flag;
   cdsAdicionaisCODIGO_PRODUTO.AsInteger := codigo_produto;
   cdsAdicionaisCODIGO_ITEM.AsInteger    := codigo_item;
   cdsAdicionaisCODIGO_MATERIA.AsInteger := Materia.codigo;
   cdsAdicionaisQUANTIDADE.AsInteger     := quantidade;
   cdsAdicionaisINDICE_ITEM.AsInteger    := cdsItensINDICE.AsInteger;
   cdsAdicionais.Post;

  calcula_totais;

  cdsItensAfterScroll(nil);
end;

procedure TfrmPedido.gridAdicionaisDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field = cdsAdicionaisFLAG then begin

    Column.Title.Font.Color := $00E5E5E5;
    
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsAdicionaisFLAG.asString = 'A' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 2, true)
    else if cdsAdicionaisFLAG.asString = 'R' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true);
  end;
end;

procedure TfrmPedido.busca_item_para_inclusao(AdicionaRemove :String);
var repositorio :TRepositorio;
    Produto     :TProduto;
begin
 try
   repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
   Produto     := TProduto( repositorio.Get(self.cdsItensCODIGO_PRODUTO.AsInteger) );

   frmAdicionaItemProduto := TfrmAdicionaItemProduto.Create(self, Produto, AdicionaRemove);
   frmAdicionaItemProduto.ShowModal;
   frmAdicionaItemProduto.Release;
   frmAdicionaItemProduto := nil;

 Finally
   FreeAndNil(repositorio);
   FreeAndNil(Produto);
 end;
end;

procedure TfrmPedido.AdicionarItem1Click(Sender: TObject);
begin
  busca_item_para_inclusao('A');
end;

procedure TfrmPedido.RemoverItem1Click(Sender: TObject);
begin
  busca_item_para_inclusao('R');
end;

procedure TfrmPedido.cdsItensAfterScroll(DataSet: TDataSet);
begin
  if cdsItensTIPO.AsString = 'S' then
    gridItens.PopupMenu := nil
  else
    gridItens.PopupMenu := PopupMenu1;

  cdsAdicionais.Filtered := false;
    
  if (cdsAdicionais.IsEmpty) or (TRIM(cdsItensCODIGO_PRODUTO.AsString) = '') then
    Exit;

  cdsAdicionais.Filter   := 'INDICE_ITEM = '+cdsItensINDICE.AsString;
  cdsAdicionais.Filtered := true;
end;

procedure TfrmPedido.gridAdicionaisColEnter(Sender: TObject);
begin
  TDBGridCBN(Sender).SelectedIndex := 1;
end;

procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FItensDeletados);
  FreeAndNil(FAdicionaisDeletados);
end;

procedure TfrmPedido.gridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = vk_delete) and not (cdsItens.IsEmpty) then
    if DirectoryExists(ExtractFilePath(Application.ExeName)+'\Pedidos') then
      armazena_item_selecionado;
 // else if key = VK_F8 then
 //   alterar_item;
end;

procedure TfrmPedido.armazena_adicional_selecionado(const pergunta :Boolean);
begin
  if pergunta and not confirma('Confirma a remoção do adicional "'+cdsAdicionaisDESCRICAO.AsString+'",'+#13#10+
                               'adicionado ao produto "'+cdsItensDESCRICAO.AsString+'"?') then
    exit;

  if cdsAdicionaisCODIGO.AsInteger > 0 then
    FAdicionaisDeletados.Add(cdsAdicionaisCODIGO.AsString);

  cdsAdicionais.Delete;
end;

procedure TfrmPedido.armazena_item_selecionado;
var usuario, justificativa :String;
begin
  if not confirma('Confirma a remoção do item "'+cdsItensDESCRICAO.AsString+'" do pedido?') then
      exit;

  try
    frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, nome from usuarios',
                                                          'CODIGO', 'Informe o usuário desejado...');
    if frmPesquisaSimples.ShowModal = mrOk then begin
      usuario := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    end
    else
      Exit;

    if cdsItensCODIGO.AsInteger > 0 then begin

      justificativa := chamaInput('TEXT','Justificativa do cancelamento');

      if justificativa <> '' then
        FItensDeletados.Add(cdsItensCODIGO.AsString+';'+justificativa+';'+usuario)
      else
        Exit;
    end;

    while not (cdsAdicionais.IsEmpty) and (cdsAdicionais.Locate('CODIGO_PRODUTO',cdsItensCODIGO_PRODUTO.AsInteger,[])) do
      armazena_adicional_selecionado(false);


    if cdsItensTIPO.AsString = 'P' then
      dec( produtos_no_pedido );

    cdsItens.Delete;

    calcula_totais;

  Finally
    frmPesquisaSimples.Release;
  end;
end;

procedure TfrmPedido.remove_adicionais;
var repositorio :TRepositorio;
    i :integer;
begin
 try
   repositorio := nil;

   for i := 0 to FAdicionaisDeletados.Count -1 do begin
     repositorio := TFabricaRepositorio.GetRepositorio(TAdicionalItem.ClassName);
     repositorio.RemoverPorIdentificador( StrToInt(FAdicionaisDeletados[i]) );
   end;

 finally
   FreeAndNil(repositorio);
 end;
end;

procedure TfrmPedido.remove_itens;
var repositorio    :TRepositorio;
    Item           :TItem;
    ItemDeletado   :TItemDeletado;
    i              :integer;
    codigo_item    :Integer;
    justificativa  :String;
    codigo_usuario :Integer;
begin
 try
   repositorio     := nil;
   Item            := nil;
   ItemDeletado    := nil;

   for i := 0 to FItensDeletados.Count -1 do begin

     codigo_item        := StrToInt( copy(FItensDeletados[i],1, pos(';',FItensDeletados[i])-1 ) );
     FItensDeletados[i] := copy(FItensDeletados[i], pos(';',FItensDeletados[i])+1, length(FItensDeletados[i]));
     justificativa      := copy(FItensDeletados[i], 1, pos(';',FItensDeletados[i])-1);
     FItensDeletados[i] := copy(FItensDeletados[i], pos(';',FItensDeletados[i])+1, length(FItensDeletados[i]));
     codigo_usuario     := StrToInt(FItensDeletados[i]);

     repositorio  := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
     Item         := TItem( repositorio.Get( codigo_item ) );
     repositorio.Remover( Item );

     repositorio  := TFabricaRepositorio.GetRepositorio(TItemDeletado.ClassName);
     ItemDeletado := TItemDeletado.Create;

     ItemDeletado.codigo_pedido  := Item.codigo_pedido;
     ItemDeletado.codigo_usuario := codigo_usuario;
     ItemDeletado.codigo_produto := Item.codigo_produto;
     ItemDeletado.quantidade     := Item.quantidade;
     ItemDeletado.hora_exclusao  := time;
     ItemDeletado.justificativa  := justificativa;

     repositorio.Salvar(ItemDeletado);

     FreeAndNil(Item);
   end;

   calcula_totais;

   if not fdm.conexao.TxOptions.AutoCommit then
     fdm.conexao.Commit;

 finally
   FreeAndNil(repositorio);
 end;
end;

procedure TfrmPedido.gridAdicionaisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = vk_delete then
    armazena_adicional_selecionado;
end;

procedure TfrmPedido.alterar_item;
begin
  BuscaProduto1.codigo             := cdsItensCODIGO_PRODUTO.AsInteger;
  BuscaProduto1.edtCodigo.Enabled  := false;
  BuscaProduto1.btnBusca.Enabled   := false;
  gridItens.Enabled                := false;
  btnAdd.Caption                   := ' CONFIRMA ALTERAÇÃO';
  edtQuantidade.AsInteger          := StrToInt(cdsItensQUANTIDADE.AsString);
end;

procedure TfrmPedido.grpItemExit(Sender: TObject);
begin
  if not BuscaProduto1.edtCodigo.Enabled then
    edtQuantidade.SetFocus;
end;

procedure TfrmPedido.btnFinalizarClick(Sender: TObject);
begin
  finalizaPedido;
end;

procedure TfrmPedido.Salva_movimento(Pedido :TPedido);
var repositorio :TRepositorio;
    Movimento   :TMovimento;
    Movimentos  :TObjectList;
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
    i :integer;
    achou :Boolean;
begin
  try
    repositorio := nil;
    Movimento   := nil;
    Movimentos  := nil;

    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( Pedido.codigo );

    Movimentos    := repositorio.GetListaPorEspecificacao( Especificacao );

    frmFinalizaPedido.cdsMoedas.First;
    while not frmFinalizaPedido.cdsMoedas.Eof do begin

       achou       := false;

       if assigned(Movimentos) then
         for i := 0 to Movimentos.Count - 1 do
            if TMovimento(Movimentos.Items[i]).tipo_moeda = frmFinalizaPedido.cdsMoedasTIPO_MOEDA.AsInteger then begin
              achou := true;
              break;
            end;

      if achou then
        Movimento               := TMovimento(Movimentos.Items[i])
      else
        Movimento               := TMovimento.Create;

      Movimento.tipo_moeda    := frmFinalizaPedido.cdsMoedasTIPO_MOEDA.AsInteger;
      Movimento.codigo_pedido := Pedido.codigo;
      Movimento.data          := now;
      Movimento.valor_pago    := frmFinalizaPedido.cdsMoedasVALOR_PAGO.AsFloat;

      repositorio.Salvar( Movimento );

      frmFinalizaPedido.cdsMoedas.Next;
    end;

    if dm.conexao.Params.Database <> dm.FDConnection.Params.Database then
      salva_recebimento_por_item;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Movimento);
  end;
end;

procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if edtStatus.Text <> '' then
    if not confirma('Atenção! Operação em andamento, deseja cancela-la e sair da tela de pedidos?') then
      abort;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  lbCodigoUsuario.Caption   := IntToStr( fdm.UsuarioLogado.Codigo );
  lbUsuario.Caption         := '- '+fdm.UsuarioLogado.Nome;
  btnFinalizar.Visible      := AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR']);
  btnAgrupa.Visible         := (AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR'])) and (dm.Configuracoes.Utiliza_comandas);
  btnLiberarComanda.Visible := AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR']) and (dm.Configuracoes.possui_dispensadora);

  Parametros                := TParametros.Create;

  produtos_no_pedido        := 0;
  chkDuasVias.Checked       := dm.Configuracoes.duas_vias_pedido;
  edtPreco.Enabled          := dm.Configuracoes.preco_produto_alteravel;
  Parametros.NFCe.DANFE.ImprimirItens := Parametros.NFCe.DANFE.ImprimirItens;
end;

procedure TfrmPedido.Gera_cupom_eletronico;
var i, x               :Integer;
    valor_adicionais   :Real;
    desconto           :Real;
    total_item         :Real;
    total_imposto      :Real;
    repositorio :TRepositorio;
    Venda              :TVenda;
    NFCe               :TServicoEmissorNFCe;
    padraoImprimeItem  :Boolean;
    Pedido             :TPedido;
begin
   repositorio    := nil;
   total_imposto  := 0;
   desconto       := 0;
   Venda          := nil;
   NFCe           := nil;
   Pedido := nil;

 try
 try
   padraoImprimeItem                   := Parametros.NFCe.DANFE.ImprimirItens;

   if assigned(frmFinalizaPedido) then
     Parametros.NFCe.DANFE.ImprimirItens := frmFinalizaPedido.chkImprimeItens.Checked;

   Venda               := TVenda.Create;
   NFCe                := TServicoEmissorNFCe.Create(Parametros);

   repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   Pedido          := TPedido(repositorio.Get(Fcodigo_pedido));

   Venda.Data          := Pedido.data;
   Venda.Codigo_pedido := Pedido.codigo;
   Venda.NumeroNFe     := fdm.GetValorGenerator('gen_nrnota_nfce','1');//StrToInt(Maior_Valor_Cadastrado('NFCE_RETORNO', 'CODIGO'))+1; // criar tab. de retorno da nf p/ poder pegar tb o cod. da nf
  // Venda.Acrescimo     := buscaComanda1.Pedido.acrescimo;
   Venda.Desconto      := Pedido.desconto;
   Venda.Couvert       := Pedido.couvert;
   Venda.Tx_servico    := Pedido.taxa_servico;
   Venda.Taxa_entrega  := Pedido.taxa_entrega;
   Venda.Cpf_cliente   := Pedido.cpf_cliente;
   Venda.nome_cliente  := Pedido.nome_cliente;
   Venda.Codigo_endereco := Pedido.Codigo_endereco;

   for i := 0 to Pedido.Itens.Count - 1 do begin
     valor_adicionais := 0;

     if (Pedido.Itens[i] as TItem).Produto.tipo = 'S' then begin
       Venda.Total_em_servicos := Venda.Total_em_servicos + ( (Pedido.Itens[i] as TItem).valor_Unitario *
                                                              IfThen((((Pedido.Itens[i] as TItem).quantidade > 198)and((Pedido.Itens[i] as TItem).Fracionado = 'S')) or ((Pedido.Itens[i] as TItem).quantidade > 599),
                                                                       1, (Pedido.Itens[i] as TItem).quantidade) );
       Continue;
     end;

     if assigned( (Pedido.Itens[i] as TItem).Adicionais ) then
       for x := 0 to (Pedido.Itens[i] as TItem).Adicionais.Count - 1 do    //Adicionados
         if ((Pedido.Itens[i] as TItem).Adicionais[x] as TAdicionalItem).flag = 'A' then
            valor_adicionais := valor_adicionais + ( ((Pedido.Itens[i] as TItem).Adicionais[x] as TAdicionalItem).valor_unitario *
                                                     ((Pedido.Itens[i] as TItem).Adicionais[x] as TAdicionalItem).quantidade);

     Venda.AdicionarItem( (Pedido.Itens[i] as TItem).codigo_produto,
                          ((Pedido.Itens[i] as TItem).valor_Unitario + valor_adicionais),
                          IfThen( (((Pedido.Itens[i] as TItem).quantidade > 198)and((Pedido.Itens[i] as TItem).Fracionado = 'S')) or ((Pedido.Itens[i] as TItem).quantidade > 599),
                                  1, (Pedido.Itens[i] as TItem).quantidade));
   end;

   NFCe.Emitir(Venda, fdm.GetValorGenerator('gen_lote_nfce','1'));

 Except
   On E: Exception do begin

     Pedido.situacao := 'A';
     
     repositorio.Salvar(Pedido);

     raise Exception.Create('Ocorreu um erro ao enviar nota fiscal.'+#13#10+e.Message);
   end;
 end;

 Finally
   FreeAndNil(repositorio);
   FreeAndNil(Pedido);
   Parametros.NFCe.DANFE.ImprimirItens := padraoImprimeItem;
 end;
end;

procedure TfrmPedido.btnImprimirPedidoClick(Sender: TObject);
begin
  imprimir_pedido(true);
end;

function TfrmPedido.tem_movimento: Boolean;
var repositorio :TRepositorio;
begin
  try
    repositorio := nil;

    repositorio := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);

    result      := repositorio.GetExiste('CODIGO_PEDIDO', buscaComanda1.Pedido.codigo);

  Finally
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmPedido.Cancela_pedido;
var repositorio   :TRepositorio;
begin
  repositorio := nil;
 try
   repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

   buscaComanda1.Pedido.situacao := 'C';

   repositorio.Salvar(buscaComanda1.Pedido);

   Avisar('Pedido cancelado. Comanda liberada.');

 finally
   FreeAndNil(repositorio);
 end;
end;

procedure TfrmPedido.buscaComanda1btnBuscaClick(Sender: TObject);
begin
 try
   inherited;
   buscaComanda1.btnBuscaClick(Sender);
 except
   on e: Exception do
     avisar(e.Message);
 end;
end;

procedure TfrmPedido.btnenviarNFCeClick(Sender: TObject);
begin
  Gera_cupom_eletronico;

  libera_comanda('F');

  avisar('Cupom eletrônico impresso!');

  btnCancelar.Click;
end;

procedure TfrmPedido.btnLiberarComandaClick(Sender: TObject);
begin
  try
    if not assigned(buscaComanda1.Comanda) then
      Exit;

    TPermissoesAcesso.VerificaPermissao(paLiberarComanda, '', true);

    if confirma('ATENÇÃO! Confirma a liberação da comanda?') then begin
      libera_comanda('C');
      avisar('Comanda Nº '+buscaComanda1.edtNumeroComanda.Text+' liberada!');
      btnCancelar.Click;
    end;

  except
    on e : Exception do
        Avisar('* * * * * * * * * * A tela não pode ser exibida * * * * * * * * * *'+#13#10+#13#10+e.Message);
  end;
end;

procedure TfrmPedido.libera_comanda(situacao :String);
var repositorio :TRepositorio;
begin
  repositorio := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
    buscaComanda1.Pedido.situacao := situacao;
    repositorio.Salvar(buscaComanda1.Pedido);

  finally
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmPedido.btnAgrupaClick(Sender: TObject);
begin
  pnlAgrupa.Tag         := 0;
  pnlAgrupa.Top         := 75;
  buscaComanda1.Enabled := false;
  pnlTopo.Enabled       := false;
  pnlDados.Enabled      := false;
  pnlRodape.Enabled     := false;
  pnlAgrupa.Visible     := True;
  edtCodCOmanda.SetFocus;
end;

procedure TfrmPedido.buscaComanda1edtNumeroComandaChange(Sender: TObject);
begin
  inherited;
  buscaComanda1.edtNumeroComandaChange(Sender);

  btnAgrupa.Enabled := not ( StrToIntDef(buscaComanda1.edtNumeroComanda.Text,0) > 0);
end;

function TfrmPedido.unifica_pedidos: Boolean;
var Pedido_principal :TPedido;
    Pedido_aux       :TPedido;
    repositorio :TRepositorio;
    rep_item    :TRepositorio;
    rep_pedido  :TRepositorioPedido;
    i      :integer;
    Item   :TItem;
    abre_consumo :Boolean;
begin
  try
  try
    result       := false;
    abre_consumo := false;

    cdsAgrupaComanda.First;

    { seleciona o primeiro pedido da lista, no qual serão agrupados os outros pedidos }
    Pedido_aux   := buscaComanda1.pedido_pela_comanda( cdsAgrupaComandaCOD_COMANDA.AsInteger );

    { carrega o pedido principal }
    repositorio       := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

    if assigned(Pedido_aux) then
      Pedido_principal                := TPedido( repositorio.Get( Pedido_aux.codigo ) )
    else begin
      Pedido_principal                := TPedido.Create;
      Pedido_principal.codigo_comanda := cdsAgrupaComandaCOD_COMANDA.AsInteger;
      abre_consumo                    := true;
    end;

    Pedido_principal.Agrupadas := comandas;
    cdsAgrupaComanda.Next;

    rep_item := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    while not cdsAgrupaComanda.Eof do begin

      Pedido_aux := buscaComanda1.pedido_pela_comanda( cdsAgrupaComandaCOD_COMANDA.AsInteger );


      if assigned(Pedido_aux) then begin

        Pedido_principal.codigo_mesa    := Pedido_aux.codigo_mesa;

        if (Pedido_aux.data < Pedido_principal.data) or (Pedido_principal.data = 0) then
          Pedido_principal.data           := Pedido_aux.data;

        Pedido_principal.observacoes    := Pedido_aux.observacoes;
        Pedido_principal.situacao       := Pedido_aux.situacao;
        Pedido_principal.couvert        := Pedido_principal.couvert      + Pedido_aux.couvert;
        Pedido_principal.taxa_servico   := Pedido_principal.taxa_servico + Pedido_aux.taxa_servico;
        Pedido_principal.desconto       := Pedido_principal.desconto     + Pedido_aux.desconto;
        Pedido_principal.acrescimo      := Pedido_principal.acrescimo    + Pedido_aux.acrescimo;
        Pedido_principal.valor_total    := Pedido_principal.valor_total  + Pedido_aux.valor_total;

        repositorio.Salvar(Pedido_principal);

        Pedido_principal.Itens;
        {transfere os itens do pedido da vez, para o principal}
        for i := 0 to Pedido_aux.Itens.Count -1 do begin
          Item               := TITem( rep_item.Get( (Pedido_aux.Itens[i] as TItem).codigo ));
          Item.codigo_pedido := Pedido_principal.codigo;

          rep_item.Salvar(Item);
        end;

        repositorio.Remover(Pedido_aux);

        rep_pedido := TRepositorioPedido.Create;
        rep_pedido.Gera_xml_para_dispensadora(Pedido_aux, false);

        FreeAndNil(Pedido_aux);
      end;

      if abre_consumo then
        rep_pedido.Gera_xml_para_dispensadora(Pedido_principal, true);

      cdsAgrupaComanda.Next;
    end;

    comanda_principal := Pedido_principal.codigo_comanda;

    result := true;

  Except
    On E: Exception do
      raise Exception.Create('Ocorreu um erro ao agrupar comandas!'+#13#10+e.Message);
  end;

  finally
    FreeAndNil(rep_item);
    FreeAndNil(repositorio);
    FreeAndNil(rep_pedido);
    FreeAndNil(Pedido_principal);
    FreeAndNil(Pedido_aux);
  end;
end;

function TfrmPedido.agrupa_comandas: Boolean;
begin
  comandas := '';
  result   := false;

  cdsAgrupaComanda.First;

  while not cdsAgrupaComanda.Eof do begin
    comandas := comandas + ', '+cdsAgrupaComandaCOD_COMANDA.AsString;

    cdsAgrupaComanda.Next;
  end;

  comandas := copy(comandas,2,length(comandas));

  if not frmPadrao.confirma('Deseja realmente agrupar os valores das comandas '+comandas+'?') then
    result := false
  else begin

    if unifica_pedidos then
      result := true;
  end;

end;

procedure TfrmPedido.edtCodCOmandaExit(Sender: TObject);
begin
  edtCodComanda.Clear;
end;

procedure TfrmPedido.gridAgrupaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    if (cdsAgrupaComanda.Active) and not(cdsAgrupaComanda.IsEmpty) then
      cdsAgrupaComanda.Delete;
end;

procedure TfrmPedido.btnConfirmaAgrupamentoClick(Sender: TObject);
var agrupou :Boolean;
begin
 try
   pnlRodape.Enabled := false;
   pnlAgrupa.Enabled := false;
 try
   agrupou := false;

   if pnlAgrupa.Tag <= 0 then
     avisar('Nenhuma das comandas informadas possui consumo!')
   else begin

     agrupou := agrupa_comandas;

     if agrupou then begin
       cdsAgrupaComanda.First;
       buscaComanda1.edtNumeroComanda.Text := IntToStr(comanda_principal);
       btnCancelaAgrupamento.Click;

       buscaComanda1.efetua_busca;
       carrega_dados_pedido(buscaComanda1.Pedido);
     end;

   end;

 Except
   On E: Exception do
     Avisar(e.message);
 end;

 Finally
   pnlRodape.Enabled := true;
   pnlAgrupa.Enabled := true;

   if not agrupou then
     edtCodCOmanda.SetFocus;
 end;
end;

procedure TfrmPedido.cdsAgrupaComandaAfterInsert(DataSet: TDataSet);
begin
  btnConfirmaAgrupamento.Enabled := true;
end;

procedure TfrmPedido.cdsAgrupaComandaAfterDelete(DataSet: TDataSet);
begin
  if cdsAgrupaComanda.IsEmpty then
      btnConfirmaAgrupamento.Enabled := false;
end;

procedure TfrmPedido.btnCancelaAgrupamentoClick(Sender: TObject);
begin
  if cdsAgrupaComanda.Active then
    cdsAgrupaComanda.EmptyDataSet;

  comanda_principal              := 0;  
  btnConfirmaAgrupamento.Enabled := false;
  buscaComanda1.Enabled          := true;
  pnlAgrupa.Visible              := False;
  pnlTopo.Enabled                := true;
  pnlDados.Enabled               := true;
  pnlRodape.Enabled              := true;
  buscaComanda1.edtNumeroComanda.SetFocus;
end;

procedure TfrmPedido.edtCodCOmandaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = VK_RETURN) or (Key = VK_TAB) then begin

    if not(edtCodCOmanda.AsInteger > 0) or (edtCodCOmanda.AsInteger > 200) then begin
      edtCodCOmanda.Clear;
      edtCodComanda.SetFocus;
      exit;
    end;

    if assigned( buscaComanda1.pedido_pela_comanda( edtCodCOmanda.AsInteger ) ) then
      pnlAgrupa.Tag := 1;

    if not cdsAgrupaComanda.Active then
      cdsAgrupaComanda.CreateDataSet;

    if cdsAgrupaComanda.Locate('COD_COMANDA', edtCodComanda.AsInteger, []) then
      cdsAgrupaComanda.Edit
    else
      cdsAgrupaComanda.Append;

    cdsAgrupaComandaCOD_COMANDA.Asinteger := edtCodComanda.AsInteger;

    cdsAgrupaComanda.Post;

    edtCodCOmanda.Clear;
    edtCodCOmanda.SetFocus;
  end;

  inherited;

end;

procedure TfrmPedido.Baixa_estoque(Pedido: TPedido);
var Estoque       :TEstoque;
    Especificacao :TEspecificacaoEstoquePorProduto;
    i             :integer;
    repositorio   :TRepositorio;
begin
  Estoque       := nil;
  Especificacao := nil;
 try
   repositorio  := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);

   for i := 0 to Pedido.Itens.Count - 1 do begin
     Especificacao := TEspecificacaoEstoquePorProduto.Create( (Pedido.Itens[i] as TItem).Produto );
     Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

     if not assigned(Estoque) then
       continue;

     if Estoque.quantidade > 0 then
       Estoque.quantidade := Estoque.quantidade - (Pedido.Itens[i] as TItem).quantidade;

     if Estoque.quantidade < 0 then
       Estoque.quantidade := 0;

     repositorio.Salvar(Estoque);

     FreeAndNil(Estoque);    

   end;

 Finally
   FreeAndNil(Estoque);
   FreeAndNil(Especificacao);
   FreeAndNil(repositorio);   
 end;
end;

procedure TfrmPedido.btnFinalizaRapidoClick(Sender: TObject);
begin
  finalizaPedido(true);
end;

procedure TfrmPedido.edtTaxaServicoChange(Sender: TObject);
begin
  edtTaxaServico.Value := arredonda(edtTaxaServico.Value);
end;

procedure TfrmPedido.edtCpfExit(Sender: TObject);
var repositorio :TRepositorio;
begin
  if (trim(edtCpf.Text) <> '') and not Valida_CPF_CNPJ( edtCPF.Text ) then begin
    avisar( IfThen(length(edtCPF.Text) >11,'CNPJ inválido','CPF inválido'));
    edtCpf.SetFocus;
    exit;
  end;

  BuscaProduto1.edtCodigo.SetFocus;

  if pnlDados.Enabled then
    Exit;

  repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

  buscaComanda1.Pedido.cpf_cliente := edtCpf.Text;

  repositorio.Salvar( buscaComanda1.Pedido );
end;

procedure TfrmPedido.BuscaProduto1Exit(Sender: TObject);
begin
  if assigned(BuscaProduto1.Produto) then
  begin
    edtPreco.Value := BuscaProduto1.Produto.valor;

    if (BuscaProduto1.Produto.altera_preco = 'S') then
    begin
      edtPreco.Enabled := true;
      edtPreco.SetFocus;
    end;

  end;

end;

procedure TfrmPedido.buscaComanda1edtNumeroComandaExit(Sender: TObject);
begin
  inherited;
  buscaComanda1.efetua_busca;

end;

procedure TfrmPedido.imprimir_pedido(const pelo_botao: boolean);
var repositorio :TRepositorioPedido;
begin
  if pelo_botao then begin
    Salva_Pedido(true);
    buscaComanda1.CodigoPedido := Fcodigo_pedido;
  end;

  if assigned(frmFinalizaPedido) or not (cdsItens.IsEmpty) then begin
    repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, comandas);

    if chkDuasVias.Checked then
      repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, comandas);
  end;
end;

procedure TfrmPedido.edtCpfChange(Sender: TObject);
var
    Especificacao :TEspecificacaoClientePorCpfCnpj;
    repositorio :TRepositorio;
    Cliente     :TCliente;
begin

  if not Valida_CPF_CNPJ( edtCPF.Text ) then begin
     lbCliente.Caption    := 'Documento inválido';
     lbCliente.Font.Color := clRed;
  end
  else if length(edtCpf.Text) in [11,14] then begin
    try
       repositorio   := nil;
       Especificacao := nil;
       Cliente       := nil;

       repositorio   := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
       Especificacao := TEspecificacaoClientePorCpfCnpj.Create(edtCpf.Text);
       Cliente       := TCliente(repositorio.GetPorEspecificacao(Especificacao));

       lbCliente.Caption    := IfThen(assigned(Cliente), 'Cliente cadastrado', 'Cliente não cadastrado');
       lbCliente.Font.Color := IfThen(assigned(Cliente), $0000B300, $00FF8000);

       if assigned(Cliente) then begin
         edtCliente.Text  := Cliente.nome;

         if assigned(Cliente.Enderecos) and (Cliente.Enderecos.count > 0) then
           edtTelefone.Text := TEndereco(Cliente.Enderecos.Items[0]).fone;
       end;

    finally
      FreeAndNil(repositorio);
      FreeAndNil(Especificacao);
      FreeAndNil(Cliente);
    end;
  end;
end;

procedure TfrmPedido.edtCpfKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then 
    key:=#0;
end;

procedure TfrmPedido.salva_recebimento_por_item;
var repositorio :TRepositorio;
    Item        :TItem;
begin
  try
    repositorio := nil;
    Item        := nil;

    repositorio := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    frmFinalizaPedido.cdsItensPrePagos.First;
    while not frmFinalizaPedido.cdsItensPrePagos.Eof do begin

      Item                    := TItem( repositorio.Get(frmFinalizaPedido.cdsItensPrePagosCODIGO_ITEM.AsInteger) );
      Item.quantidade_pg      := Item.quantidade_pg + frmFinalizaPedido.cdsItensPrePagosQUANTIDADE.AsFloat;

      repositorio.Salvar( Item );

      frmFinalizaPedido.cdsItensPrePagos.Next;
    end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Item);
  end;
end;

procedure TfrmPedido.atualiza_tela;
var
   Repositorio :TRepositorio;
   codigo_comanda :integer;
begin
   codigo_comanda := buscaComanda1.Pedido.codigo_comanda;
   btnCancelar.Click;

   if codigo_comanda > 0 then
     buscaComanda1.codigo := codigo_comanda
   else
     buscaComanda1.CodigoPedido := self.Fcodigo_pedido;

   buscaComanda1Exit(nil);
end;

procedure TfrmPedido.cria_imprime_pedido_parcial;
var repositorio :TRepositorioPedido;
begin

  repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, '', frmFinalizaPedido.cdsItensPrePagos);

end;

procedure TfrmPedido.edtTelefoneExit(Sender: TObject);
begin
  edtCpf.SetFocus;
end;

end.
