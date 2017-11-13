unit uPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, frameBuscaComanda, ExtCtrls, Provider,
  DB, DBClient, Grids,
  DBGrids, DBGridCBN, pngimage, Buttons, frameBuscaProduto, Produto, Mask,
  RXToolEdit, RXCurrEdit, Pedido, StrUtils, contnrs, Menus, MateriaPrima, Funcoes,
  ImgList, ComCtrls, ACBrBase, DateTimeUtilitario, ACBrDevice, Parametros,
  frameBuscaCliente, System.ImageList, generics.collections, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Cliente,
  frameFone, Item, QuantidadePorValidade;

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
    cdsItensIMPRESSO: TStringField;
    cdsItensCODIGO_USUARIO: TIntegerField;
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
    edtTaxaEntrega: TCurrencyEdit;
    edtStatusPedExterno: TEdit;
    cdsItensFRACIONADO: TStringField;
    cdsItensQUANTIDADE_PG: TFloatField;
    cdsAdicionaisQUANTIDADE: TFloatField;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    cdsItensQUANTIDADE: TStringField;
    cdsItensQTD_FRACIONADO: TIntegerField;
    btnFinalizaRapido: TBitBtn;
    Label29: TLabel;
    edtValorAberto: TCurrencyEdit;
    Label30: TLabel;
    Label31: TLabel;
    edtValorPago: TCurrencyEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Shape15: TShape;
    edtCliente: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label6: TLabel;
    edtCpf: TEdit;
    lbCliente: TLabel;
    chkDuasVias: TCheckBox;
    Shape14: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    gridClientes: TDBGrid;
    dsClientes: TDataSource;
    qryClientes: TFDQuery;
    qryClientesRAZAO: TStringField;
    qryClientesCODIGO: TIntegerField;
    pnlendereco: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtNumero: TEdit;
    edtRua: TEdit;
    edtBairro: TEdit;
    edtCodigoCliente: TCurrencyEdit;
    Fone1: TFone;
    chkMaquinaCartao: TCheckBox;
    btnConsulta: TBitBtn;
    cdsMateriaDoProduto: TClientDataSet;
    cdsMateriaDoProdutoCODIGO: TIntegerField;
    cdsMateriaDoProdutoINDICE_ITEM: TIntegerField;
    cdsMateriaDoProdutoCODIGO_ITEM: TIntegerField;
    cdsMateriaDoProdutoCODIGO_MATERIA: TIntegerField;
    cdsMateriaDoProdutoQUANTIDADE: TFloatField;
    cdsQtdValidade: TClientDataSet;
    cdsQtdValidadeCODIGO: TIntegerField;
    cdsQtdValidadeCODIGO_ITEM: TIntegerField;
    cdsQtdValidadeCODIGO_VALIDADE: TIntegerField;
    cdsQtdValidadeQUANTIDADE: TFloatField;
    cdsQtdValidadeINDICE_ITEM: TIntegerField;
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
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure edtPrecoEnter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure buscaComanda1btnFormaBuscaClick(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtClienteEnter(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure gridClientesDblClick(Sender: TObject);
    procedure gridClientesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtRuaChange(Sender: TObject);
    procedure edtTaxaEntregaChange(Sender: TObject);
    procedure chkMaquinaCartaoClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);

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
    function selecionaValidade(codigoProduto:integer; var pValidadeCadastrada :boolean):TObjectList<TQuantidadePorValidade>;
    procedure adiciona_item(Item :TItem);
    procedure adiciona_no_produto(Materia :TMateriaPrima; quantidade :Integer; codigo_produto :integer; flag :String;
                                  const codigo_item :integer =0; const codigo :integer = 0);
    procedure adicionaMateriaProduto(item :TItem);
    procedure adicionaQuantidadePorValidade(item :TItem);
    procedure adicionaMateriasDoProdutoItem(item :TItem);

  private
    procedure calcula_totais;
    function  total_pago :Real;

    procedure carrega_dados_pedido(Pedido :TPedido);
    procedure limpa_dados_pedido;
    procedure cria_imprime_pedido_parcial;

    function confere_obrigatorios :Boolean;
    function agrupa_comandas: Boolean;
    function unifica_pedidos :Boolean;

  private
    procedure Salva_Pedido(const mantem_na_tela :boolean = false);
    procedure Salva_Pedido_pos_recebimento(imprimePedido :Boolean; cpf :String; const recebendo :boolean = false; const finalizando :boolean = false);
    procedure Salva_movimento(Pedido :TPedido);

    procedure salva_recebimento_por_item;

    procedure armazena_item_selecionado;
    procedure armazena_adicional_selecionado(const pergunta :Boolean = true);

    procedure remove_itens;
    procedure remove_adicionais;

    procedure alterar_item;
    procedure atualiza_tela;

    procedure Gera_cupom_eletronico;

    function tem_movimento  :Boolean;
    function possuiValidadeCadastrada(codProduto :integer) :Boolean;
    procedure imprimir_pedido(Pedido :TPedido; const pelo_botao :boolean = false);

    procedure finalizaPedido(const rapido :Boolean = false);
    procedure consultarNFCe;
    procedure Cancela_pedido;
    procedure libera_comanda(situacao :String);
    procedure carregaCliente;
    procedure mostraCliente(Cliente :TCliente);

    procedure transfereMovimentos(PedidoVez, PedidoPrincipal :TPedido);
    procedure transfereItens(PedidoVez, PedidoPrincipal :TPedido);

end;
    
var
  frmPedido: TfrmPedido;

implementation

uses Usuario, Comanda, uModulo, repositorio, FabricaRepositorio, Empresa, uAdicionaItemProduto,
     Math, AdicionalItem, CriaBalaoInformacao, uFinalizaPedido, Movimento, RepositorioPedido,
     ZConnection, Departamento, Estoque, EspecificacaoEstoquePorProduto, uInicial, PermissoesAcesso, ItemDeletado,
     uPesquisaSimples, Venda, ServicoEmissorNFCe, ConfiguracoesSistema, Endereco, uImpressaoPedido,
     ParametrosNFCe, ParametrosDANFE, StringUtilitario, EspecificacaoClientePorCpfCnpj, MateriaDoProduto,
     EspecificacaoMovimentosPorCodigoPedido, ProdutoHasMateria, NFCe, UtilitarioEstoque, TipoDado, uSelecionaValidadeItemPedido;

{$R *.dfm}

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsAdicionais.CreateDataSet;
  cdsMateriaDoProduto.CreateDataSet;
  cdsQtdValidade.CreateDataSet;
  carrega_padroes;
  FItensDeletados      := TStringList.Create;
  FAdicionaisDeletados := TStringList.Create;
  label19.Caption      := ' N° comanda '; //IfThen(dm.Configuracoes.Utiliza_comandas, 'N° comanda', 'N° mesa');
  label1.Visible       := dm.Configuracoes.utilizaComandas;
  cbMesa.Visible       := dm.Configuracoes.utilizaComandas;
  cbmesa.ItemIndex     := IfThen(dm.Configuracoes.utilizaComandas, -1, 0);
  buscaComanda1.btnFormaBusca.Visible := dm.Configuracoes.possuiDelivery;
  edtValorDesconto.Enabled := dm.Configuracoes.descontoPedido;
end;

procedure TfrmPedido.btnAddClick(Sender: TObject);
var Item :TItem;
    codigoValidade :integer;
    validadeCadastrada :boolean;
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
  else
  begin
    try
      Item                 := TItem.Create;
      Item.codigo          := 0;
      Item.codigo_produto  := BuscaProduto1.Produto.codigo;
      Item.quantidade      := edtQuantidade.Value;
      Item.valor_Unitario  := IfThen(edtpreco.Value > 0, edtPreco.Value, Buscaproduto1.Produto.valor);
      Item.impresso        := IfThen(BuscaProduto1.Produto.tipo = 'S', 'S', '');
      Item.codigo_usuario  := dm.UsuarioLogado.Codigo;
      Item.Fracionado      := 'N';
      Item.quantidade_pg   := 0;
      Item.qtd_fracionado  := 0;

      if dm.Configuracoes.controlaValidade and possuiValidadeCadastrada(Item.codigo_produto) then
      begin
        Item.quantidadesPorValidade := selecionaValidade(Item.Produto.codigo, validadeCadastrada);
        if not assigned(Item.quantidadesPorValidade) and validadeCadastrada then
          exit;
      end;

      adiciona_item(Item);
    finally
      FreeAndNil(Item);
    end;
    if BuscaProduto1.edtCodigo.Enabled then
      BuscaProduto1.edtCodigo.SetFocus;
  end;
end;

procedure TfrmPedido.adiciona_item(Item :TItem);
var sobra, diferenca, qtde, valorD :Real;
    primeiroFracionado :Boolean;
begin
  try
  sobra     := 0;
  qtde      := 0;
  diferenca := 0;
  primeiroFracionado := false;

  if (Item.qtd_fracionado > 0) and not (cdsItens.Locate('CODIGO_PRODUTO;FRACIONADO',varArrayOf([Item.Produto.codigo, Item.fracionado]),[]))then
    primeiroFracionado := true;

  if BuscaProduto1.edtCodigo.Enabled then begin
    cdsItens.Append;

    cdsItensCODIGO.AsInteger          := Item.codigo;
    cdsItensCODIGO_PRODUTO.AsInteger  := Item.Produto.codigo;
    cdsItensDESCRICAO.AsString        := Item.Produto.descricao;
    cdsItensHORA.AsString             := TimeToStr(Item.hora);
    cdsItensINDICE.AsInteger          := cdsItens.RecordCount + 1;
    cdsItensTIPO.AsString             := Item.Produto.tipo;
    cdsItensIMPRESSO.AsString         := Item.impresso;
    cdsItensCODIGO_USUARIO.AsInteger  := Item.codigo_usuario;
    cdsItensFRACIONADO.AsString       := Item.fracionado;
    cdsItensQUANTIDADE_PG.AsFloat     := Item.quantidade_pg;
    cdsItensQTD_FRACIONADO.AsInteger  := Item.qtd_fracionado;
 //   cdsItensCODIGO_VALIDADE.AsInteger := Item.codigo_validade;

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

  cdsItensVALOR_UNITARIO.AsFloat    := Item.valor_Unitario;

  {se for serviço e for quantidade > 599, quer dizer que é boliche, que é medido em tempo e armazena os segundos}
  if (Item.Produto.tipo = 'S') and (((Item.quantidade > 198)and(Item.Fracionado = 'S')) or (Item.quantidade > 599)) then begin //00 = 10min
    cdsItensQUANTIDADE.AsString       := TDateTimeUtilitario.SegundosParaTime(trunc(Item.quantidade));

    if Item.qtd_fracionado > 0 then
    begin
      qtde := RoundTo(1/Item.qtd_fracionado,-3);
      sobra := 1- (RoundTo(1/Item.qtd_fracionado,-3) * Item.qtd_fracionado);
    end
    else
      qtde := 1;

    if primeiroFracionado then
    begin
      valorD := roundTo( qtde * Item.valor_Unitario, -3) * Item.qtd_fracionado;
      valorD := valorD + roundTo(sobra * Item.valor_Unitario,-3);
      diferenca := Item.valor_Unitario - valorD;

      qtde   := qtde + sobra;
    end;

    cdsItensVALOR.AsCurrency          := roundTo(Item.valor_Unitario * qtde, -3) + diferenca;
  end
  else begin
    cdsItensQUANTIDADE.AsString       := FormatFloat(' ,0.000; -,0.000;',Item.quantidade);
    cdsItensVALOR.AsCurrency          := RoundTo((Item.quantidade * Item.valor_Unitario),-3);
  end;

  { * * Adiciona Materias do produto * * }
  adicionaMateriaProduto(Item);

  { * * Adiciona Quantidades por Validade * * }
  adicionaQuantidadePorValidade(Item);

  cdsItens.Post;

  BuscaProduto1.limpa;
  edtQuantidade.Value:= 1;
  edtPreco.Clear;

  calcula_totais;
  finally
    if cdsItens.State in [dsEdit, dsInsert] then
      cdsItens.Cancel;
    if cdsMateriaDoProduto.State in [dsEdit, dsInsert] then
      cdsMateriaDoProduto.Cancel;
  end;
end;

procedure TfrmPedido.gridItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  {Remove Horizontal}
  ShowScrollBar(gridItens.Handle,SB_HORZ,False);
end;

procedure TfrmPedido.calcula_totais;
var total_valor_produtos :Real;
    total_valor_servicos :Real;
    total_qtde_itens     :Real;
    total_adicionados    :Real;
    linha                :integer;
begin
  edtValorAcrescimo.OnChange := nil;
  total_valor_produtos := 0;
  total_valor_servicos := 0;
  total_qtde_itens     := 0;
  total_adicionados    := 0;
  edtQtdeTotal.Clear;
  edtValorTotal.Clear;
  edtTaxaServico.Clear;
  edtTotalItens.Clear;
  edtTotalPedido.Clear;
  edtValorAcrescimo.Clear; //
  edtValorPago.Clear;
  edtTotalAdicionais.Clear;


  if cdsItens.IsEmpty then
    Exit;

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

      total_adicionados := total_adicionados + RoundTo(( cdsAdicionaisVALOR.AsFloat * StrToFloat(cdsItensQUANTIDADE.AsString)), -3);
    end;

    cdsAdicionais.Next;
  end;

  cdsItens.AfterScroll   := cdsItensAfterScroll;
  cdsItens.RecNo         := linha;
  cdsAdicionais.Filtered := true;

  edtQtdeTotal.Value       := total_qtde_itens;
  edtValorTotal.Value      := total_valor_produtos + total_valor_servicos;
  edtTotalItens.Value      := total_valor_produtos + total_valor_servicos;
  edtTotalAdicionais.Value := total_adicionados;
  edtValorAcrescimo.Value  := total_adicionados;

  edtTotalPedido.Value := (edtTotalItens.Value - edtValorDesconto.Value + edtValorAcrescimo.Value);

  edtTaxaServico.Value := ((total_valor_produtos + total_adicionados) * edtPercenTaxa.Value) / 100;

  edtTotalPedido.Value := edtTotalPedido.Value + {edtCouvert.Value +} edtTaxaServico.Value + edtTaxaEntrega.Value;

  edtValorPago.Value   := total_pago;

  edtValorAberto.Value := edtTotalPedido.Value - edtValorPago.Value;

  edtValorAcrescimo.OnChange := edtValorDescontoChange;
end;

procedure TfrmPedido.memoObservacoesChange(Sender: TObject);
begin
  lbQtdCaracters.Caption := IntToStr(length(memoObservacoes.Text));
  chkMaquinaCartao.Checked := pos('LEVAR MÁQUINA DE CARTÃO', memoObservacoes.Text) > 0;
end;

procedure TfrmPedido.edtValorDescontoChange(Sender: TObject);
begin
  if edtValorDesconto.Value > edtValorTotal.Value then
    edtValorDesconto.Value := edtValorTotal.Value;

  calcula_totais;
end;

procedure TfrmPedido.finalizaPedido(const rapido: Boolean);
var imprimePedido :Boolean;
begin
  if not confere_obrigatorios then
    exit;

  try
    Salva_Pedido(true); //salva e mantem na tela

    atualiza_tela;

    frmFinalizaPedido := TFrmFinalizaPedido.Create(self);
    frmFinalizaPedido.chkImprimeItens.Checked := self.Parametros.NFCe.DANFE.ImprimirItens;
    frmFinalizaPedido.edtTotalPedido.Value    := self.edtTotalPedido.Value;
    frmFinalizaPedido.edtTxServico.Value      := self.edtTaxaServico.Value + buscaComanda1.Pedido.taxa_entrega;
    frmFinalizaPedido.edtDesconto.Value       := self.edtValorDesconto.Value;
    frmFinalizaPedido.edtCpf.Text             := edtCpf.Text;

    frmFinalizaPedido.cdsAdicionais.CloneCursor(self.cdsAdicionais,true,false);
    frmFinalizaPedido.preenche_cds(cdsItens);
    frmFinalizaPedido.codigo_pedido   := buscaComanda1.Pedido.codigo;
    frmFinalizaPedido.totalAdicionais := edtTotalAdicionais.Value;
    frmFinalizaPedido.finalizaRapido  := rapido;

    if assigned(buscaComanda1.Pedido) and (buscaComanda1.Pedido.tipo_moeda <> '') then
      frmFinalizaPedido.cmbTipoMoeda.ItemIndex := strToInt(buscaComanda1.Pedido.tipo_moeda)-1;

    if frmFinalizaPedido.ShowModal = mrOk then
    begin
      try
         self.edtValorDesconto.Value := frmFinalizaPedido.edtDesconto.Value;
         if frmFinalizaPedido.cdsItens.Locate('FRACIONADO', 'S', []) then begin
           buscaComanda1.Pedido := nil;
           buscaComanda1.Pedido;
         end;

         edtCpf.text := frmFinalizaPedido.edtCpf.text;


         imprimePedido := true;
         if dm.Configuracoes.perguntaImprimirPedido and
           (frmFinalizaPedido.pagamento_completo or ( not frmFinalizaPedido.pagamento_completo and dm.Configuracoes.impressoesParciais)) then
           imprimePedido := confirma('Deseja imprimir pedido?');

         Salva_Pedido_pos_recebimento(imprimePedido, edtCpf.text, true, frmFinalizaPedido.pagamento_completo );

         buscaComanda1.CodigoPedido := Self.Fcodigo_pedido;

         if (imprimePedido)and((dm.Configuracoes.impressoesParciais) and not (frmFinalizaPedido.cdsItensPrePagos.IsEmpty) and (frmFinalizaPedido.edtTotalRestante.Value > 0)) then
          //or (not (dm.Configuracoes.impressoes_parciais) and (frmFinalizaPedido.pagamento_completo)) then
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
     if not assigned( buscaComanda1.Pedido ) and not buscaComanda1.CriandoPedido then begin
        buscaComanda1.Enabled := true;
        buscaComanda1.btnBusca.SetFocus;
        TCriaBalaoInformacao.ShowBalloonTip(buscaComanda1.edtCodigo.Handle,'Selecione um pedido para alteração ou crie um novo.', 'Informação', 1);
        exit;
     end;
   end;

   cbMesa.Enabled     := buscaComanda1.btnFormaBusca.TAG = 0;
   btnAgrupa.Enabled  := buscaComanda1.btnFormaBusca.TAG = 0;

   Fcodigo_pedido := 0;

   carrega_dados_pedido(buscaComanda1.Pedido);
 finally
   buscaComanda1.OnExit := buscaComanda1Exit;
 end;
end;

procedure TfrmPedido.carregaCliente;
var Cliente :TCliente;
    repositorio :TRepositorio;
begin
  Cliente := nil;
  repositorio := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    Cliente     := TCliente(repositorio.Get(qryClientesCODIGO.AsInteger));
    mostraCliente(Cliente);
  finally
    FreeAndNil(Cliente);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmPedido.carrega_dados_pedido(Pedido :TPedido);
var i, x :integer;
    Item :TItem;
    Adicional :TAdicionalItem;
    Cliente :TCliente;
    repositorio :TRepositorio;
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
      btnFinalizaRapido.Enabled := false;

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
    if not cdsMateriaDoProduto.IsEmpty then
      cdsMateriaDoProduto.EmptyDataSet;
    if not cdsQtdValidade.IsEmpty then
      cdsQtdValidade.EmptyDataSet;

    cdsAdicionais.DisableControls;
    cdsItens.DisableControls;
    cbMesa.ItemIndex        := cbMesa.Items.IndexOf( IntToStr(IfThen(Pedido.codigo_mesa = 0, 1, Pedido.codigo_mesa)) );
    edtData.Text            := DateToStr(Pedido.data);
    memoObservacoes.Text    := Pedido.observacoes;
    edtCliente.Text         := Pedido.nome_cliente;
    Fone1.Fone              := Pedido.telefone;
    edtCPF.Text             := Pedido.cpf_cliente;

    if not assigned(Pedido.Itens) then begin
      edtStatus.Text := 'PEDIDO SEM ITENS';

      if confirma('Pedido associado a comanda '+buscaComanda1.edtCodigo.Text+' não contém itens.'+#13#10+ 'Cancelar pedido?') then
        Cancela_pedido;

      btnCancelar.Click;
      exit;
    end;

    for Item in Pedido.Itens do
    begin
      {Se for boliche pega o valor do arquivo e nao o cadastrado no produto}
      if Item.Produto.codigo = 1 then
        Item.Produto.valor := Item.valor_Unitario;

      adiciona_item( Item );

      if assigned(Item.Adicionais) then
        for Adicional in Item.Adicionais do
          adiciona_no_produto( Adicional.Materia,
                               Adicional.quantidade,
                               Item.codigo_produto,
                               Adicional.flag,
                               Adicional.codigo_item,
                               Adicional.codigo);
    end;

    gridAdicionais.SelectedIndex := 1;
    edtValorDesconto.Value       := Pedido.desconto;
    edtValorAcrescimo.Value      := Pedido.acrescimo;
    //edtCouvert.Value             := Pedido.couvert;
    edtTaxaServico.Value         := Pedido.taxa_servico;
    edtTaxaEntrega.Value         := Pedido.taxa_entrega;

    calcula_totais;

    if Pedido.codigo_comanda = 0 then
    begin
      if assigned(Pedido.Endereco) then
      begin
        edtRua.Text      := Pedido.Endereco.logradouro;
        edtNumero.Text   := Pedido.Endereco.numero;
        edtBairro.Text   := Pedido.Endereco.bairro;
        try
          repositorio      := TFabricaRepositorio.getRepositorio(TCliente.ClassName);
          Cliente          := TCliente(repositorio.get(Pedido.Endereco.codigo_pessoa));

          edtCodigoCliente.AsInteger := Cliente.Codigo;
          edtCliente.Text  := Cliente.razao;
          Fone1.Fone       := Cliente.Fone1;
          edtCPF.Text      := Cliente.cpf_cnpj;
        finally
          FreeAndNil(repositorio);
          FreeAndNil(Cliente);
        end;
      end;

      edtStatusPedExterno.Text := IfThen(Pedido.Codigo_endereco > 0, 'PEDIDO PARA ENTREGA (TAXA DE R$'+TStringUtilitario.FormataDinheiro(buscaComanda1.Pedido.taxa_entrega)+')',
                                                                     'PEDIDO PARA RETIRADA NO LOCAL');
    end;

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
  cbmesa.ItemIndex     := IfThen(dm.Configuracoes.utilizaComandas, -1, 0);
  edtData.Clear;
  edtStatus.Clear;
  edtStatusPedExterno.Clear;
  memoObservacoes.Clear;
  cdsItens.EmptyDataSet;
  gridItens.Repaint;
  cdsAdicionais.EmptyDataSet;
  cdsMateriaDoProduto.EmptyDataSet;
  cdsQtdValidade.EmptyDataSet;
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
  Fone1.limpa;
  edtCPF.Clear;
  edtCodigoCliente.Clear;
  edtRua.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  BuscaProduto1.limpa;
  edtpreco.Clear;
  edtValorAberto.Clear;
  edtValorPago.Clear;
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
  else if cdsItens.IsEmpty then begin
    avisar('Ao menos 1 item deve ser inserido ao pedido.');
    BuscaProduto1.edtCodigo.SetFocus;
  end
  else if (buscaComanda1.btnFormaBusca.Tag = 1) and (TRIM(edtCliente.Text) = '') then begin
    avisar('O nome do cliente deve ser informado.');
    edtCliente.SetFocus;
  end
  else if (buscaComanda1.btnFormaBusca.Tag = 1) and ((trim(edtRua.Text) = '') or (trim(edtNumero.Text) = '') or (trim(edtBairro.Text) = '')) then
  begin
    result := confirma('Pedido sem endereço informado. Confirma retirada no local?');
  end
  else
    result := true;
end;

procedure TfrmPedido.consultarNFCe;
var
  Servico     :TServicoEmissorNFCe;
  NFCe        :TNFCe;
  repositorio :TRepositorio;
begin
 try
 try
   Servico     := TServicoEmissorNFCe.Create(Parametros);
   repositorio := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
   NFCe        := TNFCe.create;
   NFCe.codigo_pedido := buscaComanda1.Pedido.codigo;

   Servico.ConsultaNFCe(NFCe);
   repositorio.Salvar(NFCe);

   Avisar(NFCe.motivo);
   if NFCe.status = '100' then
   begin
     FreeAndNil(repositorio);
     repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
     buscaComanda1.Pedido.situacao := 'F';
     repositorio.Salvar(buscaComanda1.Pedido);
   end;

   btnCancelar.Click;
 Except
   On E: Exception do begin
     Avisar('Erro ao consultar NFC-e.'+#13#10+e.Message);
   end;
 end;
 finally
   FreeAndNil(NFCe);
   FreeAndNil(Servico);
 end;
end;

procedure TfrmPedido.Salva_Pedido(const mantem_na_tela :boolean);
var repositorio   :TRepositorio;
    Item          :TItem;
    Itens         :TObjectList<TItem>;
    AdicionalItem :TAdicionalItem;
    Materia       :TMateriaDoProduto;
    Quantidade    :TQuantidadePorValidade;
    Caminho_externo :String;
    before_Conect  :TNotifyEvent;
    codigo_pedido :integer;
    Cliente       :TCliente;
    repCliente    :TRepositorio;
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

   if assigned(buscaComanda1.Comanda) then
     buscaComanda1.Pedido.codigo_comanda  := buscaComanda1.Comanda.codigo;

   buscaComanda1.Pedido.codigo_mesa     := StrToIntDef( cbMesa.Items[cbMesa.ItemIndex],0 );
   buscaComanda1.Pedido.data            := StrToDate( edtData.Text );
   buscaComanda1.Pedido.observacoes     := memoObservacoes.Text;
   buscaComanda1.Pedido.nome_cliente    := edtCliente.Text;
   buscaComanda1.Pedido.cpf_cliente     := edtCPF.Text;
   buscaComanda1.Pedido.telefone        := ApenasNumeros(Fone1.Fone);
   buscaComanda1.Pedido.situacao        := 'A';
  // buscaComanda1.Pedido.couvert         := edtCouvert.Value;
   buscaComanda1.Pedido.taxa_servico    := edtTaxaServico.Value;
   buscaComanda1.Pedido.taxa_entrega    := 0;
   buscaComanda1.Pedido.desconto        := edtValorDesconto.Value;
   buscaComanda1.Pedido.acrescimo       := edtValorAcrescimo.Value;
   buscaComanda1.Pedido.valor_total     := edtTotalPedido.Value;

   if edtRua.Text <> '' then
   begin
     buscaComanda1.Pedido.taxa_entrega  := dm.Empresa.taxa_entrega;
     repCliente := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
     Cliente    := TCliente(repCliente.Get(edtCodigoCliente.AsInteger));

     if not assigned(Cliente) then
     begin
       Cliente          := TCliente.create;
       Cliente.Razao    := edtCliente.Text;
     end;
     Cliente.Fone1    := ApenasNumeros(Fone1.Fone);
     Cliente.CPF_CNPJ := edtCpf.Text;

     if (Cliente.Enderecos.Count = 0) then
       Cliente.Enderecos.Add(TEndereco.Create);

     Cliente.Enderecos[0].logradouro := edtRua.Text;
     Cliente.Enderecos[0].numero     := edtNumero.Text;
     Cliente.Enderecos[0].bairro     := edtBairro.Text;
     Cliente.Enderecos[0].fone       := ApenasNumeros(Fone1.Fone);

     repCliente.Salvar(Cliente);
     buscaComanda1.Pedido.Codigo_endereco := Cliente.Enderecos[0].codigo;
   end;

   Itens := TObjectList<TItem>.Create;
   Item  := nil;

   cdsItens.First;
   while not cdsItens.Eof do begin

     Item                := TItem.Create;
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
       Item.Adicionais := TObjectList<TAdicionalItem>.Create;

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

     Item.MateriasDoProduto.Free;
     Item.MateriasDoProduto := nil;

     cdsItensAfterScroll(nil);
     if not cdsMateriaDoProduto.IsEmpty then begin

       Materia   := nil;
       Item.MateriasDoProduto := TObjectList<TMateriaDoProduto>.Create;

       {salva apenas matérias que tem um "produto-matéria" associado a ela (para posterior baixa no estoque)}
       cdsMateriaDoProduto.First;
       while not cdsMateriaDoProduto.Eof do begin

         Materia                := TMateriaDoProduto.Create;
         Materia.codigo         := cdsMateriaDoProdutoCODIGO.AsInteger;
         Materia.codigo_item    := cdsMateriaDoProdutoCODIGO_ITEM.AsInteger;
         Materia.codigo_materia := cdsMateriaDoProdutoCODIGO_MATERIA.AsInteger;
         Materia.quantidade     := cdsMateriaDoProdutoQUANTIDADE.AsFloat;

         Item.MateriasDoProduto.Add( Materia );

         cdsMateriaDoProduto.Next;
       end;

     end;

     Item.quantidadesPorValidade.Free;
     Item.quantidadesPorValidade := nil;
     cdsItensAfterScroll(nil);
     if not cdsQtdValidade.IsEmpty then begin

       Quantidade   := nil;
       Item.quantidadesPorValidade := TObjectList<TQuantidadePorValidade>.Create;

       {salva apenas matérias que tem um "produto-matéria" associado a ela (para posterior baixa no estoque)}
       cdsQtdValidade.First;
       while not cdsQtdValidade.Eof do begin

         Quantidade                 := TQuantidadePorValidade.Create;
         Quantidade.codigo          := cdsQtdValidadeCODIGO.AsInteger;
         Quantidade.codigo_item     := cdsQtdValidadeCODIGO_ITEM.AsInteger;
         Quantidade.codigo_validade := cdsQtdValidadeCODIGO_VALIDADE.AsInteger;
         Quantidade.quantidade      := cdsQtdValidadeQUANTIDADE.AsFloat;

         Item.quantidadesPorValidade.Add( Quantidade );

         cdsQtdValidade.Next;
       end;

     end;

     Itens.Add( Item );

     cdsItens.Next;
   end;

   buscaComanda1.Pedido.Itens := Itens;

   //rateia o valor do desconto e taxas entre os itens
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

   btnCancelar.Click;

   if mantem_na_tela then
   begin
     buscaComanda1.Pedido := nil;
     buscaComanda1.CodigoPedido := Self.Fcodigo_pedido;
     buscaComanda1.Pedido;
     buscaComanda1.edtNumeroComanda.Text := intToStr(buscaComanda1.Pedido.codigo_comanda);
     carrega_dados_pedido(buscaComanda1.Pedido);
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

procedure TfrmPedido.Salva_Pedido_pos_recebimento(imprimePedido :Boolean; cpf :String; const recebendo :boolean = false; const finalizando :boolean = false);
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

   Pedido.cpf_cliente := cpf;
   Pedido.desconto    := edtValorDesconto.Value;
   Pedido.valor_total := frmFinalizaPedido.edtTotalPedido.Value;
   repositorio.Salvar( Pedido );

   Fcodigo_pedido := Pedido.codigo;

   if recebendo then begin
     Salva_movimento(Pedido);

     if finalizando then begin
       TUtilitarioEstoque.atualizaEstoque(Pedido, 1);

       if imprimePedido then
         imprimir_pedido(Pedido, false);
     end;
   end;

   if fdm.conexao.InTransaction then
     fdm.conexao.Commit;

   { se esta finalizando o pedido e não foi fechado com F10(sem cupom), salva tbm na base local}
  { if finalizando and not(frmFinalizaPedido.ckbSC.Checked) and
      ((dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') or
       (dm.ArquivoConfiguracao.CaminhoBancoDeDados = dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal))then
   begin

     codigo_pedido       := Pedido.codigo;

     Caminho_externo     := dm.conexao.Params.Database;

     dm.conexao.Connected := false;
     dm.conexao.Params.Database := dm.FDConnection.Params.Database;

     if not dm.conexao.Connected then
       dm.conexao.Connected := true;

     if fdm.conexao.InTransaction then
       fdm.conexao.Commit;

     //zera o codigo para não acusar como alteração na base externa
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

   end;  }

   buscaComanda1.limpa;

 Except
   On E: Exception do begin
     fdm.conexao.Rollback;
     buscaComanda1.Pedido.codigo := 0;

 {    if dm.conexao.Params.Database = dm.FDConnection.Params.Database then begin
       if dm.conexao.Connected then
         dm.conexao.Connected := true;

       dm.conexao.Params.Database := Caminho_externo;
       dm.conexao.Connected := true;
     end;   }

     raise Exception.Create('Erro ao efetuar recebimento. Operação cancelada. '+#13#10+e.Message);
   end;
 end;

 finally
   fdm.conexao.TxOptions.AutoCommit    := true;
   fdm.conexao.BeforeConnect           := before_Conect;
 end;
end;

procedure TfrmPedido.btnCancelarClick(Sender: TObject);
begin
  limpa_dados_pedido;
  if pnlDados.Enabled then
    pnlDados.Enabled := false;

  buscaComanda1.Enabled       := true;

  if buscaComanda1.edtNumeroComanda.Visible then
    buscaComanda1.edtNumeroComanda.SetFocus
  else
    buscaComanda1.btnBusca.SetFocus;

  btnImprimirPedido.Visible   := false;
  btnenviarNFCe.Visible       := false;
  btnSalvar.Enabled           := true;
  btnFinalizar.Enabled        := true;
  btnFinalizaRapido.Enabled   := true;
  FItensDeletados.Clear;
  FAdicionaisDeletados.Clear;
  buscaComanda1.CriandoPedido := false;
  btnConsulta.Enabled         := false;
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

   {if Empresa.Couvert then
     edtCouvert.Value         := Empresa.Valor_couvert
   else
     edtCouvert.Clear;   }
     
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
  or  (ActiveControl = edtCodComanda)
  or ((ActiveControl = edtCliente) and ((key = VK_RETURN)or(key = VK_TAB)))then
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

procedure TfrmPedido.mostraCliente(Cliente: TCliente);
begin
  lbCliente.Caption    := IfThen(assigned(Cliente), 'Cadastrado', 'Não cadastrado');
  lbCliente.Font.Color := IfThen(assigned(Cliente), $0038A56B, $00FAB541);

  if assigned(Cliente) then begin
    edtCodigoCliente.AsInteger := Cliente.Codigo;
    edtCliente.Text  := Cliente.Razao;
    Fone1.Fone       := Cliente.Fone1;
    edtCpf.Text      := Cliente.CPF_CNPJ;

    if assigned(Cliente.Enderecos) and (Cliente.Enderecos.count > 0) then
    begin
      Fone1.Fone       := TEndereco(Cliente.Enderecos.Items[0]).fone;
      edtRua.Text      := Cliente.Enderecos[0].logradouro;
      edtNumero.Text   := Cliente.Enderecos[0].numero;
      edtBairro.Text   := Cliente.Enderecos[0].bairro;
    end;
  end;
end;

function TfrmPedido.possuiValidadeCadastrada(codProduto: integer): Boolean;
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'select codigo from produto_validade where codigo_produto = :codpro and quantidade > 0';
  dm.qryGenerica.ParamByName('codpro').AsInteger := codProduto;
  dm.qryGenerica.Open;
  result := not dm.qryGenerica.IsEmpty;
end;

procedure TfrmPedido.adiciona_no_produto(Materia: TMateriaPrima;
  quantidade: Integer; codigo_produto: integer; flag :String; const codigo_item :integer =0; const codigo :integer = 0);
begin
  {if cdsAdicionais.Locate('CODIGO_PRODUTO;CODIGO_MATERIA', varArrayOf([codigo_produto, Materia.codigo]), []) then
    if Confirma('Já existe(m) '+cdsAdicionaisQUANTIDADE.AsString+' unidade(s) deste item, relacionada ao produto.'+#13#10+
                'Deseja substituir a relação atual pela informada?') then
      cdsAdicionais.Edit
    else
      Exit;}

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

procedure TfrmPedido.adicionaMateriaProduto(item: TItem);
var
    listaDeMaterias   :TObjectList<TProdutoHasMateria>;
    produtoMateria    :TProdutoHasMateria;
    quantidade        :Real;
begin
  try
    listaDeMaterias := nil;

    if assigned(Item.MateriasDoProduto) and (Item.MateriasDoProduto.count > 0) then
       adicionaMateriasDoProdutoItem(Item)
    else
    begin
      listaDeMaterias := TProdutoHasMateria.MateriasDoProduto(Item.Produto.codigo);

      if assigned(listaDeMaterias) then
        for produtoMateria in listaDeMaterias do
        begin
           if produtoMateria.materia_prima.codigoProduto > 0 then
           begin
             cdsMateriaDoProduto.Append;
             cdsMateriaDoProdutoINDICE_ITEM.AsInteger    := cdsItensINDICE.AsInteger;
             cdsMateriaDoProdutoCODIGO_MATERIA.AsInteger := produtoMateria.codigo_materia;
             cdsMateriaDoProdutoQUANTIDADE.AsFloat       := produtoMateria.materia_prima.quantidade;

             if cdsMateriaDoProdutoQUANTIDADE.AsFloat = 0 then
             begin
               quantidade := chamaInput(tpQuantidade, 'Quantidade de '+produtoMateria.materia_prima.descricao);

               cdsMateriaDoProdutoQUANTIDADE.AsFloat := quantidade;
               if cdsMateriaDoProdutoQUANTIDADE.AsFloat <= 0 then
                 exit;
             end;

             cdsMateriaDoProduto.Post;
           end;
        end;
    end;

  finally
    FreeAndNil(listaDeMaterias);
  end;
end;

procedure TfrmPedido.adicionaMateriasDoProdutoItem(item: TItem);
var Materia :TMateriaDoProduto;
begin
  if not assigned(item.MateriasDoProduto) then
    exit;

  for Materia in item.MateriasDoProduto do
  begin
    cdsMateriaDoProduto.Append;
    cdsMateriaDoProdutoCODIGO.AsInteger         := Materia.codigo;
    cdsMateriaDoProdutoINDICE_ITEM.AsInteger    := cdsItensINDICE.AsInteger;
    cdsMateriaDoProdutoCODIGO_ITEM.AsInteger    := Materia.codigo_item;
    cdsMateriaDoProdutoCODIGO_MATERIA.AsInteger := Materia.codigo_materia;
    cdsMateriaDoProdutoQUANTIDADE.AsFloat       := Materia.quantidade;
    cdsMateriaDoProduto.Post;
  end;
end;

procedure TfrmPedido.adicionaQuantidadePorValidade(item: TItem);
var Quantitade :TQuantidadePorValidade;
begin
  if not assigned(item.quantidadesPorValidade) then
    exit;

  for Quantitade in item.quantidadesPorValidade do
  begin
    cdsQtdValidade.Append;
    cdsQtdValidadeCODIGO.AsInteger          := Quantitade.codigo;
    cdsQtdValidadeINDICE_ITEM.AsInteger     := cdsItensINDICE.AsInteger;
    cdsQtdValidadeCODIGO_ITEM.AsInteger     := Quantitade.codigo_item;
    cdsQtdValidadeCODIGO_VALIDADE.AsInteger := Quantitade.codigo_validade;
    cdsQtdValidadeQUANTIDADE.AsFloat        := Quantitade.quantidade;
    cdsQtdValidade.Post;
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

  cdsMateriaDoProduto.Filtered := false;

  if (cdsMateriaDoProduto.IsEmpty) or (TRIM(cdsItensCODIGO_PRODUTO.AsString) = '') then
    Exit;

  cdsMateriaDoProduto.Filter   := 'INDICE_ITEM = '+cdsItensINDICE.AsString;
  cdsMateriaDoProduto.Filtered := true;

  cdsQtdValidade.Filtered := false;

  if (cdsQtdValidade.IsEmpty) then
    Exit;

  cdsQtdValidade.Filter   := 'INDICE_ITEM = '+cdsItensINDICE.AsString;
  cdsQtdValidade.Filtered := true;
end;

procedure TfrmPedido.chkMaquinaCartaoClick(Sender: TObject);
var texto :String;
begin
  memoObservacoes.OnChange := nil;
  memoObservacoes.text := TRIM(memoObservacoes.Text);
  if chkMaquinaCartao.Checked then
    memoObservacoes.Lines.add('LEVAR MÁQUINA DE CARTÃO')
  else
  begin
    texto := memoObservacoes.Text;
    if pos('LEVAR MÁQUINA DE CARTÃO', texto) > 0 then
     memoObservacoes.Text := substituiString(texto, 'LEVAR MÁQUINA DE CARTÃO', '');
  end;
  memoObservacoes.OnChange := memoObservacoesChange;
  memoObservacoesChange(nil);
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
  begin
    if cdsItensCODIGO.AsInteger = 0 then
    begin
      cdsAdicionais.First;
      while not cdsAdicionais.IsEmpty do
        cdsAdicionais.Delete;

      cdsMateriaDoProduto.First;
      while not cdsMateriaDoProduto.IsEmpty do
        cdsMateriaDoProduto.Delete;

      cdsQtdValidade.First;
      while not cdsQtdValidade.IsEmpty do
        cdsQtdValidade.Delete;

      cdsItens.Delete;
      calcula_totais;
    end
    else if DirectoryExists(ExtractFilePath(Application.ExeName)+'\Pedidos') then
    begin
      armazena_item_selecionado;
      calcula_totais;
    end;
  end;
end;

procedure TfrmPedido.armazena_adicional_selecionado(const pergunta :Boolean);
begin
  if pergunta and not confirma('Confirma a remoção do adicional "'+cdsAdicionaisDESCRICAO.AsString+'",'+#13#10+
                               'adicionado ao produto "'+cdsItensDESCRICAO.AsString+'"?') then
    exit;

  if cdsAdicionaisCODIGO.AsInteger > 0 then
    FAdicionaisDeletados.Add(cdsAdicionaisCODIGO.AsString);

  cdsAdicionais.Delete;

  calcula_totais;
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

      justificativa := chamaInput(tpTexto,'Justificativa do cancelamento');

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
    i :integer;
begin
  try
    repositorio := nil;
    Movimento   := nil;
    repositorio := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);

    frmFinalizaPedido.cdsMoedas.First;
    while not frmFinalizaPedido.cdsMoedas.Eof do begin
      if frmFinalizaPedido.cdsMoedasCODIGO.AsInteger = 0 then
      begin
        Movimento               := TMovimento.Create;
        Movimento.tipo_moeda    := frmFinalizaPedido.cdsMoedasTIPO_MOEDA.AsInteger;
        Movimento.codigo_pedido := Pedido.codigo;
        Movimento.data          := now;
        Movimento.valor_pago    := frmFinalizaPedido.cdsMoedasVALOR_PAGO.AsFloat;
        repositorio.Salvar( Movimento );
        FreeAndNil(Movimento);
      end;
      frmFinalizaPedido.cdsMoedas.Next;
    end;

   // if dm.conexao.Params.Database <> dm.FDConnection.Params.Database then
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
  btnAgrupa.Visible         := (AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR'])) and (dm.Configuracoes.utilizaComandas);
  btnLiberarComanda.Visible := AnsiMatchText(dm.UsuarioLogado.Departamento.nome, ['CAIXA','SERVIDOR']); // and (dm.Configuracoes.possui_dispensadora);

  Parametros                := TParametros.Create;

  produtos_no_pedido        := 0;
  chkDuasVias.Checked       := dm.Configuracoes.duasViasPedido;
  edtPreco.Enabled          := dm.Configuracoes.precoProdutoAlteravel;
  Parametros.NFCe.DANFE.ImprimirItens := Parametros.NFCe.DANFE.ImprimirItens;
  qryClientes.Connection    := dm.conexao;
end;

procedure TfrmPedido.Gera_cupom_eletronico;
var i, x               :Integer;
    valor_adicionais   :Real;
    repositorio :TRepositorio;
    Emissor            :TServicoEmissorNFCe;
    padraoImprimeItem  :Boolean;
    Pedido             :TPedido;
begin
   repositorio    := nil;
   Emissor        := nil;
   Pedido         := nil;

 try
 try
   padraoImprimeItem                   := Parametros.NFCe.DANFE.ImprimirItens;

   if assigned(frmFinalizaPedido) then
     Parametros.NFCe.DANFE.ImprimirItens := frmFinalizaPedido.chkImprimeItens.Checked;

   Emissor                := TServicoEmissorNFCe.Create(Parametros);

   repositorio  := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   Pedido       := TPedido(repositorio.Get(Fcodigo_pedido));

   Emissor.Emitir(Pedido);
   if Parametros.NFCe.justContingencia <> '' then
     Pedido.emContingencia := 'S';

   if Pedido.situacao = 'A' then
     Pedido.situacao := 'F';

 Except
   On E: Exception do begin

     Pedido.situacao := 'A';

     btnConsulta.Enabled := pos('Duplicidade',e.Message) > 0;

     raise Exception.Create('Ocorreu um erro ao enviar nota fiscal.'+#13#10+e.Message);
   end;
 end;

 Finally
   repositorio.Salvar(Pedido);

   FreeAndNil(repositorio);
   FreeAndNil(Pedido);
   FreeAndNil(Emissor);
   Parametros.NFCe.DANFE.ImprimirItens := padraoImprimeItem;
 end;
end;

procedure TfrmPedido.btnImprimirPedidoClick(Sender: TObject);
begin
  imprimir_pedido(buscaComanda1.Pedido, true);
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

function TfrmPedido.total_pago: Real;
var repositorio :TRepositorio;
    Movimento   :TMovimento;
    Movimentos  :TObjectList<TMovimento>;
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
begin
  if not assigned(buscaComanda1.Pedido) then
    exit(0);

  try
    result        := 0;
    repositorio   := nil;
    Movimentos    := nil;
    Especificacao := nil;

    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( buscaComanda1.Pedido.codigo );
    Movimentos    := repositorio.GetListaPorEspecificacao<TMovimento>( Especificacao );

    if not assigned(Movimentos) then
      exit(0);

    for Movimento in Movimentos do
      result := result + Movimento.valor_pago;

  finally
    FreeAndNil(repositorio);
    FreeAndNil(Movimentos);
    FreeAndNil(Especificacao);
  end;
end;

procedure TfrmPedido.transfereItens(PedidoVez, PedidoPrincipal: TPedido);
var Item        :TItem;
    repositorio :TRepositorio;
begin
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    for Item in PedidoVez.Itens do
    begin
      Item.codigo_pedido := PedidoPrincipal.codigo;
      repositorio.Salvar(Item);
    end;

  finally
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmPedido.transfereMovimentos(PedidoVez, PedidoPrincipal: TPedido);
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
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( PedidoVez.codigo );
    Movimentos    := repositorio.GetListaPorEspecificacao<TMovimento>( Especificacao );

    if assigned(Movimentos) then
       for Movimento in Movimentos do
       begin
         Movimento.codigo_pedido := PedidoPrincipal.codigo;
         repositorio.Salvar(Movimento);
       end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Movimentos);
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

procedure TfrmPedido.buscaComanda1btnFormaBuscaClick(Sender: TObject);
begin
  inherited;
  buscaComanda1.btnFormaBuscaClick(Sender);
  pnlendereco.Visible := buscaComanda1.btnFormaBusca.TAG = 1;
end;

procedure TfrmPedido.btnenviarNFCeClick(Sender: TObject);
begin
  Gera_cupom_eletronico;
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
  pnlAgrupa.Top         := 123;
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
    repositorio  := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

    { seleciona o primeiro pedido da lista, no qual serão agrupados os outros pedidos }
    Pedido_aux   := buscaComanda1.pedido_pela_comanda( cdsAgrupaComandaCOD_COMANDA.AsInteger );

    {se a primeira comanda da lista tiver um pedido associado (não for vazia), seta como pedido principal}
    if assigned(Pedido_aux) then
      Pedido_principal                := TPedido( repositorio.Get( Pedido_aux.codigo ) )
    { caso contrário, um novo pedido é criado }
    else begin
      Pedido_principal                := TPedido.Create;
      Pedido_principal.codigo_comanda := cdsAgrupaComandaCOD_COMANDA.AsInteger;
      abre_consumo                    := true;
    end;

    Pedido_principal.Agrupadas := comandas;

    {seta o cds para a segunda comanda da lista}
    cdsAgrupaComanda.Next;

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

        {transfere os itens do pedido da vez, para o principal}
        transfereItens(Pedido_aux, Pedido_principal);

        {transfere os movimentos do pedido da vez, para o principal}
        transfereMovimentos(Pedido_aux, Pedido_principal);

        repositorio.Remover(Pedido_aux);

        Pedido_principal.Itens;

        rep_pedido := TRepositorioPedido.Create;
        rep_pedido.Gera_xml_para_dispensadora(Pedido_aux, false);

        FreeAndNil(Pedido_aux);
      end;

      {se o pedido principal acabou de ser criado, é necessário abrir o cunsumo para a máquina de controle de comandas}
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

procedure TfrmPedido.edtClienteChange(Sender: TObject);
begin
  if TRIM(edtCliente.Text) = '' then
    exit;

  qryClientes.Close;
  qryClientes.SQL.Text := 'SELECT P.RAZAO, P.CODIGO FROM PESSOAS P                             '+
                          ' WHERE TIPO = ''C'' AND P.RAZAO LIKE ''%'+TRIM(edtCliente.Text)+'%''';
  qryClientes.Open;

  if not qryClientes.IsEmpty and not gridClientes.Visible then
  begin
    gridClientes.Height  := 226;
    gridClientes.Top     := 30;
    gridClientes.Visible := true;
  end;

  gridClientes.Visible   := not qryClientes.IsEmpty;
end;

procedure TfrmPedido.edtClienteEnter(Sender: TObject);
begin
  edtCliente.OnChange := edtClienteChange;
  if gridClientes.Visible then
    gridClientes.Visible := false;
end;

procedure TfrmPedido.edtClienteExit(Sender: TObject);
begin
  edtCliente.OnChange := NIL;
end;

procedure TfrmPedido.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) or (key = VK_TAB) and gridClientes.Visible then
  begin
    gridClientes.Visible := false;
    keybd_event(VK_TAB, 0, 0, 0);
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

procedure TfrmPedido.gridClientesDblClick(Sender: TObject);
begin
  carregaCliente;
  gridClientes.Visible := false;
  qryClientes.Close;
end;

procedure TfrmPedido.gridClientesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  ShowScrollBar(gridClientes.Handle,SB_HORZ,False);
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

procedure TfrmPedido.BitBtn1Click(Sender: TObject);
begin
  busca_item_para_inclusao('A');
end;

procedure TfrmPedido.BitBtn2Click(Sender: TObject);
begin
  busca_item_para_inclusao('R');
end;

procedure TfrmPedido.btnConsultaClick(Sender: TObject);
begin
  consultarNFCe;
end;

procedure TfrmPedido.btnFinalizaRapidoClick(Sender: TObject);
begin
  finalizaPedido(true);
end;

procedure TfrmPedido.edtTaxaEntregaChange(Sender: TObject);
begin
  calcula_totais;
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

  if pnlendereco.Visible then
    edtRua.SetFocus
  else
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

    if BuscaProduto1.Quantidade > 0 then
      edtQuantidade.Value := BuscaProduto1.Quantidade;
  end;
end;

procedure TfrmPedido.buscaComanda1edtNumeroComandaExit(Sender: TObject);
begin
  inherited;
  {if buscaComanda1.edtNumeroComanda.Text = '' then
    buscaComanda1btnBuscaClick(Self)
  else}
    buscaComanda1.efetua_busca;

end;

procedure TfrmPedido.imprimir_pedido(Pedido :TPedido; const pelo_botao: boolean);
//var repositorio :TRepositorioPedido;
begin
  if pelo_botao then begin
    Salva_Pedido(true);
    buscaComanda1.CodigoPedido := Fcodigo_pedido;
  end;

  if assigned(frmFinalizaPedido) or not (cdsItens.IsEmpty) then begin
      frmImpressaoPedido := TFrmImpressaoPedido.Create(nil);
      frmImpressaoPedido.imprimePedido(Pedido, dm.UsuarioLogado.Departamento, comandas);
    // repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, comandas);

    if chkDuasVias.Checked then
//      repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, comandas);
      frmImpressaoPedido.imprimePedido(Pedido, dm.UsuarioLogado.Departamento, comandas);

    frmImpressaoPedido.Release;
    frmImpressaoPedido := nil;
  end;
end;

procedure TfrmPedido.edtCpfChange(Sender: TObject);
var
    Especificacao :TEspecificacaoClientePorCpfCnpj;
    repositorio :TRepositorio;
    Cliente     :TCliente;
begin
  if trim(edtCpf.Text) = '' then
  begin
    lbCliente.Caption    := 'Não cadastrado';
    lbCliente.Font.Color := $00FAB541;
    exit;
  end;

  if not Valida_CPF_CNPJ( edtCPF.Text ) then begin
     lbCliente.Caption    := 'Doc. inválido';
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

       mostraCliente(Cliente);
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

procedure TfrmPedido.edtPrecoEnter(Sender: TObject);
begin
  if not Assigned(BuscaProduto1.Produto) then
    BuscaProduto1.edtCodigo.SetFocus;

end;

procedure TfrmPedido.edtQuantidadeEnter(Sender: TObject);
begin
  if not Assigned(BuscaProduto1.Produto) then
    BuscaProduto1.edtCodigo.SetFocus;

end;

procedure TfrmPedido.edtRuaChange(Sender: TObject);
begin
  if (TRIM(edtRua.Text) <> '') or (TRIM(edtNumero.Text) <> '') or (TRIM(edtBairro.Text) <> '') then
  begin
    edtTaxaEntrega.Value     := dm.Empresa.taxa_entrega;
    chkMaquinaCartao.Visible := true;
  end
  else
  begin
    chkMaquinaCartao.Visible := false;
    edtTaxaEntrega.Clear;
  end;
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

function TfrmPedido.selecionaValidade(codigoProduto: integer; var pValidadeCadastrada :boolean): TObjectList<TQuantidadePorValidade>;
var Quantidade :TQuantidadePorValidade;
begin
  result := nil;
  frmSelecionaValidadeItemPedido := TfrmSelecionaValidadeItemPedido.Create(nil, codigoProduto, edtQuantidade.Value);
  if frmSelecionaValidadeItemPedido.ShowModal = mrOk then
  begin
    result := TObjectList<TQuantidadePorValidade>.Create;
    frmSelecionaValidadeItemPedido.cdsValidades.First;
    while not frmSelecionaValidadeItemPedido.cdsValidades.Eof do
    begin
      if frmSelecionaValidadeItemPedido.cdsValidadesQTDE.AsFloat > 0 then
      begin
        Quantidade                 := TQuantidadePorValidade.Create;
        Quantidade.codigo_validade := frmSelecionaValidadeItemPedido.cdsValidadesCODIGO.AsInteger;
        Quantidade.quantidade      := frmSelecionaValidadeItemPedido.cdsValidadesQTDE.AsFloat;
        result.Add(Quantidade);
      end;
      frmSelecionaValidadeItemPedido.cdsValidades.Next;
    end;
  end;

  pValidadeCadastrada := not frmSelecionaValidadeItemPedido.cdsValidades.IsEmpty;

  frmSelecionaValidadeItemPedido.Release;
  frmSelecionaValidadeItemPedido := nil;
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
//var repositorio :TRepositorioPedido;
begin
//  repositorio.imprime_pedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, '', frmFinalizaPedido.cdsItensPrePagos);

  frmImpressaoPedido := TFrmImpressaoPedido.Create(nil);
  frmImpressaoPedido.imprimePedido(buscaComanda1.Pedido, dm.UsuarioLogado.Departamento, '', frmFinalizaPedido.cdsItensPrePagos);
  frmImpressaoPedido.Release;
  frmImpressaoPedido := nil;
end;

procedure TfrmPedido.edtTelefoneExit(Sender: TObject);
begin
  edtCpf.SetFocus;
end;

end.
