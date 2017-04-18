unit uNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, frameBuscaEmpresa, ExtCtrls,
  StdCtrls, ComCtrls, frameBuscaFormaPagamento,
  frameBuscaTransportadora, Buttons, Mask, RxToolEdit, RxCurrEdit, Grids,
  DBGrids, DBGridCBN, DB, DBClient, NotaFiscal, Menus, frameBuscaCidade,
  ConfiguracoesNF, frameBuscaPessoa, frameBuscaCliente, frameBuscaCFOP, frameBuscaFornecedor, frameBuscaProduto;

type TEstadoTela = (etNenhum=-1, etEmCriacao=0, etEmDigitacao=1, etEmAlteracao=2);

type
  TfrmNotaFiscal = class(TfrmPadrao)
    pnlGeral: TPanel;
    pnlBotoes: TPanel;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    dsPedidos: TDataSource;
    cdsPedidos: TClientDataSet;
    cdsPedidosMARCADO_PARA_FATURAR: TStringField;
    cdsItensDoPedidoSelecionado: TClientDataSet;
    cdsItensDoPedidoSelecionadoDESCRICAO_PRODUTO: TStringField;
    cdsItensDoPedidoSelecionadoCOR_VARIANTE: TStringField;
    dsItensDoPedidoSelecionado: TDataSource;
    cdsItensDeletados: TClientDataSet;
    cdsItensFiscais: TClientDataSet;
    cdsItensFiscaisNR_ITEM: TIntegerField;
    cdsItensFiscaisQUANTIDADE: TFloatField;
    cdsItensFiscaisVALOR_UNITARIO: TCurrencyField;
    cdsItensFiscaisVALOR_TOTAL: TCurrencyField;
    cdsItensFiscaisFRETE: TCurrencyField;
    cdsItensFiscaisSEGURO: TCurrencyField;
    cdsItensFiscaisDESCONTO: TCurrencyField;
    cdsItensFiscaisOUTRAS_DESPESAS: TCurrencyField;
    cdsItensDoPedidoSelecionadoREFERENCIA_PRODUTO: TStringField;
    cdsItensFiscaisDESCRICAO_PRODUTO: TStringField;
    dsItensFiscais: TDataSource;
    cdsPedidosCODIGO_PEDIDO: TIntegerField;
    cdsItensDoPedidoSelecionadoCOR_DESCRICAO: TStringField;
    pmnuPedidos: TPopupMenu;
    mnuAdicionarTodos: TMenuItem;
    mnuRemoverTodos: TMenuItem;
    pgcNotaFiscal: TPageControl;
    tbsCabecalho: TTabSheet;
    tbsItensFiscais: TTabSheet;
    tbsPedidos: TTabSheet;
    lblCliqueCheckBox: TLabel;
    gridPedidos: TDBGridCBN;
    gpbItensDoPedidoSelecionado: TGroupBox;
    gridItensDoPedidoSelecionado: TDBGridCBN;
    tbsObservacoes: TTabSheet;
    gbObservacoes: TGroupBox;
    memoObservacoes: TMemo;
    gbObservacoesGeradasPeloSistema: TGroupBox;
    memoObservacoesGeradasPeloSistema: TMemo;
    rgTipoNota: TRadioGroup;
    cdsPedidosNR_PED: TStringField;
    cdsItensDoPedidoSelecionadoNR_PED: TStringField;
    btnItensAvulsos: TBitBtn;
    GroupBox3: TGroupBox;
    cmbFinalidade: TComboBox;
    gpbDestinatario: TGroupBox;
    buscaDestinatario: TBuscaCliente;
    gpbNatureza: TGroupBox;
    BuscaCFOP1: TBuscaCFOP;
    gpbEmpresa: TGroupBox;
    BuscaEmitente: TBuscaEmpresa;
    rgpFiltroPessoa: TRadioGroup;
    Label3: TLabel;
    Label6: TLabel;
    edtQuantidade: TCurrencyEdit;
    edtPreco: TCurrencyEdit;
    btnAddItem: TBitBtn;
    BuscaProduto: TBuscaProduto;
    rgpSerie: TGroupBox;
    edtNumeroNotalFiscal: TEdit;
    lblNumeroNotaFiscal: TLabel;
    chkSerie: TCheckBox;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    lblAlterarItem: TLabel;
    lblDeletarItem: TLabel;
    cdsItensFiscaisCOD_PRODUTO: TIntegerField;
    gbTipoFrete: TGroupBox;
    Shape2: TShape;
    cbTipoFrete: TComboBox;
    pnlFreteCalculado: TPanel;
    Label1: TLabel;
    edtFreteCalculado: TCurrencyEdit;
    gpbVolumes: TGroupBox;
    lblPesoBruto: TLabel;
    lblPesoLiquido: TLabel;
    lblQuantidadeVolumes: TLabel;
    lblEspecie: TLabel;
    edtPesoBruto: TCurrencyEdit;
    edtPesoLiquido: TCurrencyEdit;
    edtQuantidadeVolumes: TCurrencyEdit;
    edtEspecie: TEdit;
    gpbFormaPagamento: TGroupBox;
    BuscaFormaPagamento: TBuscaFormaPagamento;
    gpbDatas: TGroupBox;
    lblDataSaida: TLabel;
    lblDataEmissao: TLabel;
    dtpSaida: TDateTimePicker;
    dtpEmissao: TDateTimePicker;
    grpNfeReferenciada: TGroupBox;
    edtNfeReferenciada: TEdit;
    gpbTransportadora: TGroupBox;
    BuscaTransportadora: TBuscaTransportadora;
    gpbTotais: TGroupBox;
    lblBaseCalculoICMS: TLabel;
    lblValorICMS: TLabel;
    lblValorProdutos: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    edtBaseCalculoICMS: TCurrencyEdit;
    edtICMS: TCurrencyEdit;
    edtTotalProdutos: TCurrencyEdit;
    edtFrete: TCurrencyEdit;
    edtSeguro: TCurrencyEdit;
    edtDesconto: TCurrencyEdit;
    edtIPI: TCurrencyEdit;
    edtPIS: TCurrencyEdit;
    edtCOFINS: TCurrencyEdit;
    edtOutrasDespesas: TCurrencyEdit;
    edtTotalNF: TCurrencyEdit;
    edtPercentualDescontoFatura: TCurrencyEdit;
    chkCfopItem: TCheckBox;
    Shape1: TShape;
    cdsItensFiscaisCFOP: TStringField;
    gridItens: TDBGrid;
    btnInfoDestinatario: TBitBtn;
    BuscaFornecedor: TBuscaFornecedor;
    cdsItensDeletadosCOD_ITEM_NF: TIntegerField;
    cdsItensDeletadosCOD_ITEM_AVULSO: TIntegerField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);

    procedure gridPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pgcNotaFiscalEnter(Sender: TObject);
    procedure gridPedidosDblClick(Sender: TObject);

    procedure mnuAdicionarTodosClick(Sender: TObject);
    procedure mnuRemoverTodosClick(Sender: TObject);

    procedure cdsPedidosBeforeScroll(DataSet: TDataSet);
    procedure cdsPedidosMARCADO_PARA_FATURARChange(Sender: TField);

    procedure cbTipoFreteChange(Sender: TObject);
    procedure edtFreteChange(Sender: TObject);
    procedure edtSeguroChange(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure edtOutrasDespesasChange(Sender: TObject);
    procedure memoObservacoesChange(Sender: TObject);
    procedure BuscaEmitenteExit(Sender: TObject);
    procedure dtpEmissaoChange(Sender: TObject);
    procedure dtpSaidaChange(Sender: TObject);
    procedure edtPesoBrutoChange(Sender: TObject);
    procedure edtPesoLiquidoChange(Sender: TObject);
    procedure edtQuantidadeVolumesChange(Sender: TObject);
    procedure edtEspecieChange(Sender: TObject);
    procedure edtPercentualDescontoFaturaChange(Sender: TObject);
    procedure btnItensAvulsosClick(Sender: TObject);
    procedure rgTipoNotaClick(Sender: TObject);
    procedure cmbFinalidadeClick(Sender: TObject);
    procedure edtNfeReferenciadaExit(Sender: TObject);
    procedure edtLogradouroChange(Sender: TObject);
    procedure edtNumeroChange(Sender: TObject);
    procedure edtBairroChange(Sender: TObject);
    procedure edtCepChange(Sender: TObject);
    procedure edtComplementoChange(Sender: TObject);
    procedure edtCNPJChange(Sender: TObject);
    procedure rgpFiltroPessoaClick(Sender: TObject);
    procedure BuscaCFOP1edtDescricaoChange(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure BuscaProdutoExit(Sender: TObject);
    procedure lblAlterarItemClick(Sender: TObject);
    procedure lblDeletarItemClick(Sender: TObject);
    procedure chkCfopItemClick(Sender: TObject);
    procedure cdsItensFiscaisBeforeEdit(DataSet: TDataSet);
    procedure gridItensColExit(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsItensFiscaisAfterInsert(DataSet: TDataSet);
    procedure btnInfoDestinatarioClick(Sender: TObject);
    procedure BuscaCFOP1Exit(Sender: TObject);

  private
    FEstadoTela      :TEstadoTela;
    FNotaFiscal      :TNotaFiscal;

 { Métodos delegados }
  private
    procedure AtalhosEmCriacao                    (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AtalhosEmDigitacao                  (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AtalhosEmAlteracao                  (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AtualizarAposAdicionarPrimeiroPedido(NotaFiscal :TObject);
    procedure AtualizarNotaFiscal                 (Sender :TObject);
    procedure AtualizarAposRemoverUltimoPedido    (NotaFiscal :TObject);

  private
    function GetAliquotaCreditoSN     :Real;
    function GetPercentualReducaoICMS :Real;
    function GetAliquotaICMS          :Real;
    function GetAliquotaPIS           :Real;
    function GetAliquotaCOFINS        :Real;
  { Fim de métodos delegados }

  private
    function ValidarNotaFiscal        :Boolean;
    function CFOPCadastrado(CFOP :String) :Boolean;

  private
    procedure AdicionarPedidoNaNotaFiscal(const CodigoPedido :Integer);
    procedure AdicionarMetodosDelegadosNaNotaFiscal;
    procedure AdicionarItemAvulsoNaNota;
    procedure AlterarEstadoTela          (NovoEstado :TEstadoTela);
    procedure AlterarNotaFiscal          (Sender :TObject);
    procedure AposAcharEmpresa           (Empresa        :TObject);
    procedure AposAlterarFormaPagamento  (FormaPagamento :TObject);
    procedure AposAlterarTransportadora  (Transportadora :TObject);
    procedure AtualizarTela;
    procedure CriarNotaFiscal;
    procedure DeletaItemNota;
    procedure armazenaItemDeletado(codItemNF, codItemAvulso: Integer);
    procedure DesabilitaOnChangeComponentes;
    procedure DestacarAoPassarOMouse(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FaturarNotaFiscal          (Sender :TObject);
    procedure HabilitaOnChangeComponentes;
    procedure LimparNotaFiscal;
    procedure LimparTela;
    procedure ListarPedidos;
    procedure ListarItensDoPedido        (const CodigoPedido :Integer);
    procedure MarcarDesmarcarTodosPedidos(const Marcar :Boolean);
    procedure RemoverPedidoDaNotaFiscal  (const CodigoPedido :Integer);
    procedure VoltarAoNormalAoSairComOMouse(Sender: TObject);
    procedure selecionaEmpresa;
    procedure atualizaCFOPs(cfopDoProduto :boolean);
    procedure atualizaCFOPnoItemNota;
    procedure persisteRemocoesItem;

  public
    constructor Create(AOwner :TComponent); overload; override;
    constructor Create(AOwner :TComponent; NotaFiscal :TNotaFiscal); overload;
    destructor Destroy; override;
  end;

var
  frmNotaFiscal: TfrmNotaFiscal;

implementation

uses
   Contnrs,
   ExcecaoNotaFiscalInvalida,
   ExcecaoParametroInvalido,
   FabricaRepositorio,
   Pedido,
   Repositorio,
   TipoSerie,
   Item, CFOP,
   Produto,
   Cor,
   TipoFrete,
   TotaisNotaFiscal,
   ItemNotaFiscal,
   ExcecaoCampoNaoInformado,
   Pessoa,
   Endereco,
   Especificacao,
   EspecificacaoCFOPPorTipo,
   TipoNaturezaOperacao,
   Empresa,
   EspecificacaoCFOPporCodigoCFOP,
   EspecificacaoEmpresaPorCodigoPessoa,
   StringUtilitario,
   FormaPagamento, uPesquisaSimples,
   GeradorNFe, ItemAvulso, uItensAvulsos, uDadosPessoa,
  TipoRegimeTributario, StrUtils, Funcoes, Math, IcmsEstado;

const
  MENSAGEM_DELETAR_PEDIDO = 'Ao deletar um pedido, os valores poderão ser alterados. Tais como: FRETE, DESCONTO e etc. Deseja realmente continuar?';
  NENHUMA_CONFIGURACAO_CADASTRADA = 'Nenhuma configuração de nota fiscal cadastrada!';
  PERCENTAGEM_REDUCAO_BC_NAO_CADASTRADA = 'Percentagem de redução de base de cálculo não cadastrada para estado do ';

{$R *.dfm}

procedure TfrmNotaFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

   if not (inherited Confirma('Se você sair, a digitação atual irá ser cancelada. Deseja CANCELAR a digitação atual?')) then
    Action := caNone;
end;

procedure TfrmNotaFiscal.btnAddItemClick(Sender: TObject);
begin
   if not Assigned(self.BuscaProduto.Produto) then begin
     inherited Avisar(1,'Selecione o produto!');
     BuscaProduto.edtCodigo.SetFocus;
     exit;
   end;

   if self.edtQuantidade.Value <= 0 then begin
     inherited Avisar(1,'Nenhuma quantidade adicionada!');
     exit;
   end;

  adicionarItemAvulsoNaNota;
  BuscaProduto.Limpa;
  edtQuantidade.Clear;
  edtPreco.Clear;
  self.BuscaProduto.edtCodigo.SetFocus;
  self.AtualizarNotaFiscal(self.FNotaFiscal);
end;

procedure TfrmNotaFiscal.btnCancelarClick(Sender: TObject);
begin
  self.AlterarEstadoTela(etEmCriacao);
end;

procedure TfrmNotaFiscal.gridPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Check :Integer;
  R     :TRect;
  Grid  :TDBGrid;
begin
  if not ( Sender is TDBGrid ) then exit;

  Grid := ( Sender as TDBGrid );

  if not Assigned( Grid.DataSource.DataSet.FindField( self.cdsPedidosMARCADO_PARA_FATURAR.FieldName ) ) then exit;

  { Desenha um checkbox no dbgrid }
  if Column.FieldName = self.cdsPedidosMARCADO_PARA_FATURAR.FieldName then
   begin
      Grid.Canvas.FillRect(Rect);
      Check := 0;

      if Grid.DataSource.DataSet.FieldByName( self.cdsPedidosMARCADO_PARA_FATURAR.FieldName ).AsString = 'X' then
        Check := DFCS_CHECKED
      else Check := 0;
        R     := Rect;

      InflateRect(R,-2,-2); {Diminue o tamanho do CheckBox}
      DrawFrameControl(Grid.Canvas.Handle,R,DFC_BUTTON, DFCS_BUTTONCHECK or Check);
  end;
end;

procedure TfrmNotaFiscal.persisteRemocoesItem;
var repItemNf, repItemAvulso :TRepositorio;
    ItemNf :TItemNotaFiscal;
    ItemAvulso :TItemAvulso;
begin
  repItemNf     := TFabricaRepositorio.GetRepositorio(TItemNotaFiscal.ClassName);
  repItemAvulso := TFabricaRepositorio.GetRepositorio(TItemAvulso.ClassName);

  cdsItensDeletados.First;
  while not cdsItensDeletados.Eof do
  begin
    ItemNf   := TItemNotaFiscal(repItemNf.Get(cdsItensDeletadosCOD_ITEM_NF.AsInteger));
    repItemNf.Remover(ItemNf);
    FreeAndNil(ItemNf);

    if cdsItensDeletadosCOD_ITEM_AVULSO.AsInteger > 0 then
    begin
      ItemAvulso   := TItemAvulso(repItemNf.Get(cdsItensDeletadosCOD_ITEM_NF.AsInteger));
      repItemAvulso.Remover(ItemAvulso);
      FreeAndNil(ItemAvulso);
    end;

    cdsItensDeletados.Next;
  end;
end;

procedure TfrmNotaFiscal.pgcNotaFiscalEnter(Sender: TObject);
begin
   if (self.FEstadoTela <> etEmCriacao) then
    exit;

   try
     self.CriarNotaFiscal();
     self.ListarPedidos();
     self.AlterarEstadoTela(etEmDigitacao);
     self.pgcNotaFiscal.ActivePageIndex := 0;

   {  if BuscaFormaPagamento.Visible then
       BuscaFormaPagamento.edtCodigo.SetFocus
     else
       BuscaTransportadora.edtCodigo.SetFocus; }

   except
      on E: TExcecaoParametroInvalido do begin
          if (pos('Natureza', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe a Natureza de Operação!');
            self.BuscaCFOP1.edtCFOP.SetFocus;
          end;

          if (pos('Serie', E.Message) <> 0) {or (pos(E.Message, 'TipoSerie') <> 0))} then begin
            inherited Avisar(1,'Informe a série!');
            self.BuscaCFOP1.edtCFOP.SetFocus;
          end;

          if (pos('Destinatario', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe o destinatário!');
            if buscaDestinatario.Visible then
              self.BuscaDestinatario.edtCodigo.SetFocus
            else
              self.BuscaFornecedor.edtCodigo.SetFocus;
          end;

          if (pos('Emitente', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe o emitente!');
            self.BuscaEmitente.edtCodigo.SetFocus;
          end;
       end;

      on E: TExcecaoNotaFiscalInvalida do begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        if buscaDestinatario.Visible then
          self.BuscaDestinatario.edtCodigo.SetFocus
        else
          self.BuscaFornecedor.edtCodigo.SetFocus;
      end;

      on E: EAccessViolation do begin
        if buscaDestinatario.Visible then
          self.BuscaDestinatario.edtCodigo.SetFocus
        else
          self.BuscaFornecedor.edtCodigo.SetFocus;
        inherited Avisar(0,E.Message);
      end;
   end;
end;

constructor TfrmNotaFiscal.Create(AOwner: TComponent);
begin
  inherited;
  lblAlterarItem.OnMouseMove                      := self.DestacarAoPassarOMouse;
  lblAlterarItem.OnMouseLeave                     := self.VoltarAoNormalAoSairComOMouse;
  lblDeletarItem.OnMouseMove                      := self.DestacarAoPassarOMouse;
  lblDeletarItem.OnMouseLeave                     := self.VoltarAoNormalAoSairComOMouse;

  self.FNotaFiscal      := nil;
  self.FEstadoTela      := etNenhum;
  tbsPedidos.TabVisible := false;

  self.cdsPedidos.CreateDataSet;
  self.cdsItensDoPedidoSelecionado.CreateDataSet;
  self.cdsItensFiscais.CreateDataSet;

//  self.BuscaDestinatario.AposEncontrarObjeto       := self.AposAcharDestinatario;
//  self.BuscaTransportadora.AposEncontrarObjeto     := self.AposAcharDestinatario;
//  self.BuscaEmitente.AposEncontrarObjeto           := self.AposAcharEmpresa;
  self.BuscaTransportadora.AposEncontrarObjeto     := self.AposAlterarTransportadora;
  self.BuscaFormaPagamento.AposEncontrarObjeto     := self.AposAlterarFormaPagamento;
end;

destructor TfrmNotaFiscal.Destroy;
begin
  self.cdsPedidos.Close();
  self.cdsItensDoPedidoSelecionado.Close();
  self.cdsItensFiscais.Close();

  if (self.FEstadoTela <> etEmAlteracao) then
    FreeAndNil(self.FNotaFiscal);
    
   
  inherited;
end;

procedure TfrmNotaFiscal.CriarNotaFiscal;
var Pessoa :TPessoa;
begin
   if buscaDestinatario.Visible then
     Pessoa := self.BuscaDestinatario.Pessoa
   else
     Pessoa := self.BuscaFornecedor.Pessoa;

   if not Assigned(self.FNotaFiscal) then
    begin
       self.FNotaFiscal := TNotaFiscal.Create(
                                              self.BuscaCFOP1.CFOP,
                                              '001',
                                              self.BuscaEmitente.Pessoa,
                                              Pessoa);

       self.AdicionarMetodosDelegadosNaNotaFiscal;
    end
   else
    begin
       self.FNotaFiscal.CFOP         := self.BuscaCFOP1.CFOP;
       self.FNotaFiscal.Serie        := '001';
       self.FNotaFiscal.Emitente     := self.BuscaEmitente.Pessoa;
       self.FNotaFiscal.Destinatario := Pessoa;
    end;
end;

procedure TfrmNotaFiscal.btnSalvarClick(Sender: TObject);
begin
   { FaturarNotaFiscal(Sender :TObject) ou AlterarNotaFiscal(Sender :TObject) depende do estado da tela }
end;

procedure TfrmNotaFiscal.ListarPedidos;
begin

end;

procedure TfrmNotaFiscal.LimparTela;
var
  nX :Integer;
begin
   self.buscaCFOP1.Limpa;
  // self.BuscaEmitente.Limpa;
   self.BuscaDestinatario.Limpa;
   self.BuscaFornecedor.Limpa;
   self.BuscaFormaPagamento.Limpa;
   self.BuscaTransportadora.Limpa;

   self.cdsPedidos.EmptyDataSet;
   self.cdsItensDoPedidoSelecionado.EmptyDataSet;
   self.cdsItensFiscais.EmptyDataSet;

   self.dtpEmissao.DateTime   := Now;
   self.dtpSaida.DateTime     := Now;
   self.cbTipoFrete.ItemIndex := 0;

   self.DesabilitaOnChangeComponentes;

   for nX := 0 to (self.ComponentCount-1) do begin
//      Application.ProcessMessages;

      if (self.Components[nX] is TCustomEdit) then
        TCustomEdit(self.Components[nX]).Clear;
   end;

   self.HabilitaOnChangeComponentes;
end;

procedure TfrmNotaFiscal.cdsItensFiscaisAfterInsert(DataSet: TDataSet);
begin
  if gridItens.Focused then
    cdsItensFiscais.Cancel;
end;

procedure TfrmNotaFiscal.cdsItensFiscaisBeforeEdit(DataSet: TDataSet);
begin
  if (gridItens.Fields[gridItens.SelectedIndex].FieldName = 'QUANTIDADE') and (ActiveControl = gridItens) then
    abort;
end;

procedure TfrmNotaFiscal.cdsPedidosBeforeScroll(DataSet: TDataSet);
begin
   self.ListarItensDoPedido(Dataset.FieldByName(self.cdsPedidosCODIGO_PEDIDO.FieldName).AsInteger);
end;

procedure TfrmNotaFiscal.ListarItensDoPedido(const CodigoPedido :Integer);
begin
end;

procedure TfrmNotaFiscal.AlterarEstadoTela(NovoEstado: TEstadoTela);
begin
//   if (self.FEstadoTela = NovoEstado) then exit;
   
   case NovoEstado of
     etEmCriacao:   begin
                       self.btnSalvar.Enabled                    := false;
                       self.pnlGeral.Enabled                      := true;
                       self.OnKeyDown                             := self.AtalhosEmCriacao;
                       self.Caption                               := 'Nota Fiscal - Criação';
                       self.LimparNotaFiscal;
                       self.LimparTela;
                       self.pgcNotaFiscal.ActivePageIndex         := 0;
                       self.OnClose                               := self.FormClose;
                       if buscaDestinatario.Visible then
                         buscaDestinatario.edtCodigo.SetFocus
                       else
                         BuscaFornecedor.edtCodigo.SetFocus;
                    end;                                       

     etEmDigitacao: begin
                       self.btnSalvar.Enabled                    := true;
                       self.btnSalvar.OnClick                    := self.FaturarNotaFiscal;
                       self.btnSalvar.Caption                    := 'Salvar';
                       self.pnlGeral.Enabled                      := true;
                       self.OnKeyDown                             := self.AtalhosEmDigitacao;
                       self.OnClose                               := self.FormClose;
                     end;                                      
                                                               
     etEmAlteracao: begin
                       self.Caption                               := 'Nota Fiscal - Alteração';
                       self.btnSalvar.Enabled                    := true;
                       self.btnSalvar.OnClick                    := self.AlterarNotaFiscal;
                       self.btnSalvar.Caption                    := 'Salvar';
                       self.pnlGeral.Enabled                      := true;
                       self.OnKeyDown                             := self.AtalhosEmAlteracao;
                       self.OnClose                               := nil;
                       self.pgcNotaFiscal.ActivePageIndex         := 0;
                    end;                                        
   else
     raise TExcecaoParametroInvalido.Create('TfrmNotaFiscal', 'AlterarEstadoTela(NovoEstado: TEstadoTela)', 'NovoEstado');
   end;

   self.FEstadoTela := NovoEstado;
end;

procedure TfrmNotaFiscal.LimparNotaFiscal;
begin
   if Assigned(self.FNotaFiscal) then
    FreeAndNil(self.FNotaFiscal);
end;

procedure TfrmNotaFiscal.AtalhosEmCriacao(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_F6) then
     btnSalvar.Click
   else
   inherited FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmNotaFiscal.AtalhosEmDigitacao(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_F1) then
     self.AlterarEstadoTela(etEmCriacao)
   else if (Key = VK_F6) then
     btnSalvar.Click
   else
     inherited FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmNotaFiscal.atualizaCFOPnoItemNota;
var i :integer;
    CFOP :TCFOP;
    repositorio :TRepositorio;
    especificacao :TEspecificacaoCFOPporCodigoCFOP;
begin
  try
    repositorio   := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
    especificacao := TEspecificacaoCFOPporCodigoCFOP.Create(cdsItensFiscaisCFOP.AsString);
    CFOP          := TCFOP(repositorio.GetPorEspecificacao(especificacao));

    for i := 0 to self.FNotaFiscal.Itens.Count-1 do
      if self.FNotaFiscal.Itens[i].Produto.codigo = cdsItensFiscaisCOD_PRODUTO.AsInteger then
      begin
        self.FNotaFiscal.Itens[i].NaturezaOperacao.Free;
        self.FNotaFiscal.Itens[i].NaturezaOperacao := nil;
        self.FNotaFiscal.Itens[i].CodigoNaturezaOperacao := CFOP.codigo;
      end;

  finally
    FreeAndNil(repositorio);
    FreeAndNil(CFOP);
  end;
end;

procedure TfrmNotaFiscal.atualizaCFOPs(cfopDoProduto: boolean);
var i :integer;
begin
  if assigned(self.FNotaFiscal.Itens) then
  begin

    for i := 0 to self.FNotaFiscal.Itens.Count-1 do
    begin
      if self.FNotaFiscal.CFOPdoProduto then
        self.FNotaFiscal.Itens[i].NaturezaOperacao := self.FNotaFiscal.Itens[i].Produto.NCMIbpt.cfop
      else
        self.FNotaFiscal.Itens[i].NaturezaOperacao := self.FNotaFiscal.CFOP;
    end;

    self.AtualizarNotaFiscal(self.FNotaFiscal);
  end;
end;

procedure TfrmNotaFiscal.FormShow(Sender: TObject);
begin
  inherited;
  self.AlterarEstadoTela(etEmCriacao);
  self.pgcNotaFiscal.ActivePageIndex := 0;
  self.buscaDestinatario.semConsumidor := true;
  selecionaEmpresa;
  if buscaDestinatario.Visible then
    self.BuscaDestinatario.edtCodigo.SetFocus
  else
    self.BuscaFornecedor.edtCodigo.SetFocus;
end;

procedure TfrmNotaFiscal.gridItensColExit(Sender: TObject);
begin

  if cdsItensFiscais.State = dsEdit then
  begin
    if CFOPCadastrado(cdsItensFiscaisCFOP.AsString) then
    begin
      cdsItensFiscais.Post;
      atualizaCFOPnoItemNota;
      cdsItensFiscais.Next;
      gridItens.SelectedIndex := 2;
      {aborta o restante do evento para nao sair da coluna setada acima}
      abort;
    end
    else
    begin
      avisar(0,'CFOP não encontrado',1);
      cdsItensFiscais.Cancel;
      gridItens.SelectedIndex := 2;
      abort;
    end;
  end;
end;

procedure TfrmNotaFiscal.gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not odd(cdsItensFiscais.RecNo) then
    if not (gdSelected in State) then
      begin
      gridItens.Canvas.Brush.Color := $00EEE8DF;
      gridItens.Canvas.FillRect(Rect);
      gridItens.DefaultDrawDataCell(rect,Column.Field,state);
    end;
end;

procedure TfrmNotaFiscal.gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_F3 then
    lblAlterarItemClick(nil)
  else if key = vk_delete then
    lblDeletarItemClick(nil);
end;

procedure TfrmNotaFiscal.gridPedidosDblClick(Sender: TObject);
var
  Grid :TDBGrid;
begin
  inherited;

  Grid := (Sender as TDBGrid);

  if not Assigned(Grid.SelectedField) or self.cdsPedidos.IsEmpty then
    exit;

  if (Grid.SelectedField.FieldName = self.cdsPedidosMARCADO_PARA_FATURAR.FieldName) then begin
     self.cdsPedidos.Edit;

     if (self.cdsPedidosMARCADO_PARA_FATURAR.AsString = 'X') then begin
        if not inherited Confirma(MENSAGEM_DELETAR_PEDIDO) then
          exit;

        self.cdsPedidosMARCADO_PARA_FATURAR.AsString := '';
     end
     else
       self.cdsPedidosMARCADO_PARA_FATURAR.AsString := 'X';

     self.cdsPedidos.Post;
  end;
end;

procedure TfrmNotaFiscal.mnuAdicionarTodosClick(Sender: TObject);
begin
   self.MarcarDesmarcarTodosPedidos(true);
end;

procedure TfrmNotaFiscal.MarcarDesmarcarTodosPedidos(
  const Marcar: Boolean);
var
  Linha       :Integer;
  CDS         :TClientDataSet;
  Verificador :String;
  Valor       :String;
begin
   Linha                        := self.cdsPedidos.Recno;
   self.cdsPedidos.BeforeScroll := nil;
   CDS                          := TClientDataSet.Create(nil);
   CDS.CloneCursor(self.cdsPedidos, false);

   if Marcar then begin
     Verificador := '';
     Valor       := 'X';
   end
   else begin
     Verificador := 'X';
     Valor       := '';
   end;

   try
     CDS.First;

     while not CDS.Eof do begin
        if (CDS.FieldByName('MARCADO_PARA_FATURAR').AsString = Verificador) then begin
           if self.cdsPedidos.Locate(self.cdsPedidosCODIGO_PEDIDO.FieldName, CDS.FieldByName(self.cdsPedidosCODIGO_PEDIDO.FieldName).AsInteger, []) then
            begin
               self.cdsPedidos.Edit;
               self.cdsPedidosMARCADO_PARA_FATURAR.AsString := Valor;
               self.cdsPedidos.Post;
            end;
        end;

        CDS.Next;
     end;
   finally
     FreeAndNil(CDS);
     self.cdsPedidos.Recno     := Linha;
     self.cdsPedidos.BeforeScroll := self.cdsPedidosBeforeScroll;
   end;
end;

procedure TfrmNotaFiscal.mnuRemoverTodosClick(Sender: TObject);
begin
   if not inherited Confirma(MENSAGEM_DELETAR_PEDIDO) then
    exit;

   self.MarcarDesmarcarTodosPedidos(false);
end;

procedure TfrmNotaFiscal.cdsPedidosMARCADO_PARA_FATURARChange(
  Sender: TField);
begin
   if (Sender.AsString = 'X') then self.AdicionarPedidoNaNotaFiscal(self.cdsPedidosCODIGO_PEDIDO.AsInteger)
   else                            self.RemoverPedidoDaNotaFiscal  (self.cdsPedidosCODIGO_PEDIDO.AsInteger);
end;

function TfrmNotaFiscal.CFOPCadastrado(CFOP :String): Boolean;
begin
  fdm.qryGenerica.Close;
  fdm.qryGenerica.SQL.Text := 'SELECT CODIGO FROM NATUREZA_OPERACAO WHERE CFOP = '+QuotedStr(CFOP);
  fdm.qryGenerica.Open;

  result := not fdm.qryGenerica.IsEmpty;
end;

procedure TfrmNotaFiscal.chkCfopItemClick(Sender: TObject);
begin
  self.FNotaFiscal.CFOPdoProduto := chkCfopItem.Checked;
  atualizaCFOPs(self.FNotaFiscal.CFOPdoProduto);
end;

procedure TfrmNotaFiscal.AdicionarPedidoNaNotaFiscal(const CodigoPedido: Integer);
var
  Repositorio :TRepositorio;
  Pedido      :TPedido;
begin                                      
   Repositorio := nil;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

     try
       Pedido      := (Repositorio.Get(CodigoPedido) as TPedido);
       self.FNotaFiscal.AdicionarPedido(Pedido);

     except
       on E: EAccessViolation do
        inherited Avisar(1,'Erro em TfrmNotaFiscal.AdicionarPedidoNaNotaFiscal(const CodigoPedido: Integer)'+#13+
                           'Não foi possível adicionar o pedido!');
     end;
   finally
     FreeAndNil(Repositorio);
     FreeAndNil(Pedido);
   end;
end;

procedure TfrmNotaFiscal.RemoverPedidoDaNotaFiscal(
  const CodigoPedido: Integer);
var
  Repositorio :TRepositorio;
  Pedido      :TPedido;
begin
   Repositorio := nil;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

     try
       Pedido      := (Repositorio.Get(CodigoPedido) as TPedido);
       self.FNotaFiscal.RemoverPedido(Pedido);

     except
       on E: EAccessViolation do
        inherited Avisar(0,'Não foi encontrado o pedido '+IntToStr(CodigoPedido)+' no banco de dados. Não foi possível remove-lo da nota fiscal. Verifique!');
     end;
   finally
     FreeAndNil(Repositorio);
     FreeAndNil(Pedido);
   end;
end;

procedure TfrmNotaFiscal.AtualizarAposAdicionarPrimeiroPedido(NotaFiscal: TObject);
var
  NF :TNotaFiscal;
begin
   NF := (NotaFiscal as TNotaFiscal);

   self.BuscaFormaPagamento.codigo    := NF.FormaPagamento.Codigo;
   self.BuscaTransportadora.Pessoa    := NF.Transportadora;
   self.cbTipoFrete.ItemIndex         := TTipoFreteUtilitario.DeEnumeradoParaInteiro(NF.TipoFrete);
   self.cbTipoFrete.OnChange(self);
  // self.dtpEmissao.DateTime                   := NF.DataEmissao;
  // self.dtpSaida.DateTime                     := NF.DataSaida;
   self.edtFreteCalculado.Value               := NF.Totais.Frete;
end;

procedure TfrmNotaFiscal.AtualizarAposRemoverUltimoPedido(NotaFiscal :TObject);
begin
   self.BuscaFormaPagamento.Limpa;
   self.BuscaTransportadora.Limpa;

   self.cdsItensFiscais.EmptyDataSet;

   self.dtpEmissao.DateTime   := Now;
   self.dtpSaida.DateTime     := Now;
end;

procedure TfrmNotaFiscal.AtualizarNotaFiscal(Sender: TObject);
var
  NF          :TNotaFiscal;
  Pedido      :TPedido;
  ItemPedido  :TItem;
  Item        :TItemNotaFiscal;
  nX, nY      :Integer;
  Repositorio :TRepositorio;
  ItemAvulso  :TItemAvulso;
  PercentagemReducao, ICMSIntegral, valor_diferido :Real;
begin
   NF := (Sender as TNotaFiscal);

    self.DesabilitaOnChangeComponentes;

   try
     try

       if Nf.Entrada_saida = '' then
         Nf.Entrada_saida := IfThen( rgTipoNota.ItemIndex = 0,'E','S');

       if not ( Nf.Entrada_saida = 'E' ) and assigned(NF.FormaPagamento) then
         self.BuscaFormaPagamento.codigo  := NF.FormaPagamento.Codigo;
         
       self.BuscaTransportadora.Pessoa    :=  NF.Transportadora;
     except                                               
       on E: EAccessViolation do
        // Caso não tenha transportador e forma de pagamento só capturo o erro.
     end;

     if not (Self.FEstadoTela = TEstadoTela(1)) then begin
       self.dtpSaida.DateTime                      := NF.DataSaida;
       self.dtpEmissao.DateTime                    := NF.DataEmissao;
     end;

     if assigned(NF.Volumes) then
     begin
       self.edtPesoBruto.Value                    := NF.Volumes.PesoBruto;
       self.edtPesoLiquido.Value                  := NF.Volumes.PesoLiquido;
       self.edtQuantidadeVolumes.Value            := NF.Volumes.QuantidadeVolumes;
       self.edtEspecie.Text                       := NF.Volumes.Especie;
     end;

     self.cbTipoFrete.ItemIndex                 := TTipoFreteUtilitario.DeEnumeradoParaInteiro(NF.TipoFrete);
     self.edtBaseCalculoICMS.Value              := NF.Totais.BaseCalculoICMS;
     self.edtICMS.Value                         := NF.Totais.ICMS;
     self.edtTotalProdutos.Value                := NF.Totais.TotalProdutos;
     self.edtFrete.Value                        := NF.Totais.Frete;
     self.edtFreteCalculado.Value               := NF.Totais.FreteCalculado;
     self.edtSeguro.Value                       := NF.Totais.Seguro;
     self.edtDesconto.Value                     := NF.Totais.Descontos;
     self.edtPercentualDescontoFatura.Value     := NF.Totais.PercentualDescontoFatura;
     self.edtIPI.Value                          := NF.Totais.IPI;
     self.edtPIS.Value                          := NF.Totais.PIS;
     self.edtCOFINS.Value                       := NF.Totais.COFINS;
     self.edtOutrasDespesas.Value               := NF.Totais.OutrasDespesas;
     self.edtTotalNF.Value                      := NF.Totais.TotalNF;

     { Itens Fiscais }
     self.cdsItensFiscais.EmptyDataSet;

     for nX := 0 to (NF.Itens.Count-1) do begin
       Application.ProcessMessages;

       Item := (NF.Itens.Items[nX] as TItemNotaFiscal);

       self.cdsItensFiscais.Append;
       self.cdsItensFiscaisNR_ITEM.AsInteger            := (nX + 1);
       self.cdsItensFiscaisQUANTIDADE.AsFloat           := Item.Quantidade;
       self.cdsItensFiscaisVALOR_UNITARIO.AsFloat       := Item.ValorUnitario;
       self.cdsItensFiscaisVALOR_TOTAL.AsFloat          := Item.ValorTotalItem;
       self.cdsItensFiscaisFRETE.AsFloat                := Item.ValorFrete;
       self.cdsItensFiscaisSEGURO.AsFloat               := Item.ValorSeguro;
       self.cdsItensFiscaisDESCONTO.AsFloat             := Item.ValorDesconto;
       self.cdsItensFiscaisOUTRAS_DESPESAS.AsFloat      := Item.ValorOutrasDespesas;
       self.cdsItensFiscaisDESCRICAO_PRODUTO.AsString   := Item.Produto.Descricao;
       self.cdsItensFiscaisCFOP.AsString                := Item.NaturezaOperacao.cfop;
       self.cdsItensFiscaisCOD_PRODUTO.AsInteger        := Item.Produto.codigo;
       self.cdsItensFiscais.Post;
     end;



     self.memoObservacoes.Lines.Clear;
     self.memoObservacoes.Text := NF.Observacoes.Observacoes;

     if (NF.NotaDeReducao) and (NF.Totais.BaseCalculoICMS > 0) and
     not(pos('DIF. PARCIAL CFE ART 108 RICMS', memoObservacoes.Text) > 0) then begin
       PercentagemReducao := 0;
       ICMSIntegral       := 0;
       valor_diferido     := 0;

       try
          PercentagemReducao := StrToFloat(campo_por_campo('ICMS_ESTADO',
                                                           'PERC_REDUCAO_BC',
                                                           'CODIGO_ESTADO',
                                                           intToStr(NF.Destinatario.Endereco.Cidade.codest) ));

          ICMSIntegral     := ((NF.Totais.BaseCalculoICMS * self.GetAliquotaICMS)/100);  

          valor_diferido   := ((ICMSIntegral * PercentagemReducao) /100);

          memoObservacoes.Text := memoObservacoes.Text + #13#10 + 'DIF. PARCIAL CFE ART 108 RICMS, '+TStringUtilitario.FormataDinheiro(valor_diferido);
          

       Except
         avisar(1,PERCENTAGEM_REDUCAO_BC_NAO_CADASTRADA + NF.Destinatario.Endereco.Cidade.estado.sigla);
       end;

     end;

     self.memoObservacoesGeradasPeloSistema.Lines.Clear;

     if rgTipoNota.ItemIndex = 1 then
       self.memoObservacoesGeradasPeloSistema.Lines.Text := NF.Observacoes.ObservacoesGeradasPeloSistema;

   except
     on e: EAccessViolation DO
      // CASO NÃO TENHA NENHUM PEDIDO ADICIONADO NA NOTA FISCAL.
   end;

   self.HabilitaOnChangeComponentes;
end;

procedure TfrmNotaFiscal.cbTipoFreteChange(Sender: TObject);
begin
  inherited;

  self.FNotaFiscal.TipoFrete := TTipoFreteUtilitario.DeInteiroParaEnumerado(self.cbTipoFrete.ItemIndex);
end;

procedure TfrmNotaFiscal.edtFreteChange(Sender: TObject);
begin
  inherited;

  if Pos(',', TCurrencyEdit(Sender).Text) = Length(TCurrencyEdit(Sender).Text) then
    exit;

  self.FNotaFiscal.Totais.Frete := TCurrencyEdit(Sender).Value;

  TCurrencyEdit(Sender).SelStart := Length( TCurrencyEdit(Sender).Text );
end;

procedure TfrmNotaFiscal.edtLogradouroChange(Sender: TObject);
begin
  inherited;
  self.FNotaFiscal.LocalEntrega.Logradouro := TEdit(Sender).Text;
end;

procedure TfrmNotaFiscal.edtSeguroChange(Sender: TObject);
begin
  inherited;
  if Pos(',', TCurrencyEdit(Sender).Text) = Length(TCurrencyEdit(Sender).Text) then
    exit;

  self.FNotaFiscal.Totais.Seguro := TCurrencyEdit(Sender).Value;

  TCurrencyEdit(Sender).SelStart := Length( TCurrencyEdit(Sender).Text );
end;

procedure TfrmNotaFiscal.edtBairroChange(Sender: TObject);
begin
  inherited;
  self.FNotaFiscal.LocalEntrega.Bairro := TEdit(Sender).Text;
end;

procedure TfrmNotaFiscal.edtCepChange(Sender: TObject);
begin
  inherited;
  self.FNotaFiscal.LocalEntrega.CEP := TEdit(Sender).Text;
end;

procedure TfrmNotaFiscal.edtCNPJChange(Sender: TObject);
begin
  inherited;
    self.FNotaFiscal.LocalEntrega.CnpjCpf := TEdit(Sender).Text;
end;

procedure TfrmNotaFiscal.edtComplementoChange(Sender: TObject);
begin
  inherited;
  self.FNotaFiscal.LocalEntrega.Complemento := TEdit(Sender).Text;
end;

procedure TfrmNotaFiscal.edtDescontoChange(Sender: TObject);
begin
  inherited;
  if Pos(',', TCurrencyEdit(Sender).Text) = Length(TCurrencyEdit(Sender).Text) then
    exit;

  self.FNotaFiscal.Totais.Descontos := TCurrencyEdit(Sender).Value;

  TCurrencyEdit(Sender).SelStart := Length( TCurrencyEdit(Sender).Text );
end;

procedure TfrmNotaFiscal.edtOutrasDespesasChange(Sender: TObject);
begin
  inherited;
  if Pos(',', TCurrencyEdit(Sender).Text) = Length(TCurrencyEdit(Sender).Text) then
    exit;

  self.FNotaFiscal.Totais.OutrasDespesas := TCurrencyEdit(Sender).Value;

  TCurrencyEdit(Sender).SelStart := Length( TCurrencyEdit(Sender).Text );
end;

procedure TfrmNotaFiscal.DesabilitaOnChangeComponentes;
begin
   self.cbTipoFrete.OnChange           := nil;
   self.edtFrete.OnChange              := nil;
   self.edtSeguro.OnChange             := nil;
   self.edtDesconto.OnChange           := nil;
   self.edtOutrasDespesas.OnChange     := nil;
   self.dtpEmissao.OnChange            := nil;
   self.dtpSaida.OnChange              := nil;
   self.edtPesoBruto.OnChange          := nil;
   self.edtPesoLiquido.OnChange        := nil;
   self.edtQuantidadeVolumes.OnChange  := nil;
   self.edtEspecie.OnChange            := nil;
   self.edtPercentualDescontoFatura.OnChange := nil;          
end;

procedure TfrmNotaFiscal.HabilitaOnChangeComponentes;
begin
   self.cbTipoFrete.OnChange                 := self.cbTipoFreteChange;
   self.edtFrete.OnChange                    := self.edtFreteChange;
   self.edtSeguro.OnChange                   := self.edtSeguroChange;
   self.edtDesconto.OnChange                 := self.edtDescontoChange;
   self.edtOutrasDespesas.OnChange           := self.edtOutrasDespesasChange;
   self.dtpEmissao.OnChange                  := self.dtpEmissaoChange;
   self.dtpSaida.OnChange                    := self.dtpSaidaChange;
   self.edtPesoBruto.OnChange                := self.edtPesoBrutoChange;
   self.edtPesoLiquido.OnChange              := self.edtPesoLiquidoChange;
   self.edtQuantidadeVolumes.OnChange        := self.edtQuantidadeVolumesChange;
   self.edtEspecie.OnChange                  := self.edtEspecieChange;
   self.edtPercentualDescontoFatura.OnChange := self.edtPercentualDescontoFaturaChange;
end;

procedure TfrmNotaFiscal.lblAlterarItemClick(Sender: TObject);
begin
  inherited;
  if cdsItensFiscais.IsEmpty then
    exit;

  BuscaProduto.codigo := cdsItensFiscaisCOD_PRODUTO.AsInteger;
  edtQuantidade.Value := cdsItensFiscaisQUANTIDADE.AsFloat;
  edtPreco.Value      := cdsItensFiscaisVALOR_UNITARIO.AsFloat;
  edtQuantidade.SetFocus;
end;

procedure TfrmNotaFiscal.lblDeletarItemClick(Sender: TObject);
begin
  if cdsItensFiscais.IsEmpty then
    exit;

  deletaItemNota;
end;

function TfrmNotaFiscal.GetAliquotaCOFINS: Real;
begin
   try
     result := self.FNotaFiscal.Empresa.ConfiguracoesNF.aliq_cofins;
   except
     on E: EAccessViolation do
       raise Exception.Create(NENHUMA_CONFIGURACAO_CADASTRADA);
   end;
end;

function TfrmNotaFiscal.GetAliquotaCreditoSN: Real;
begin
   try
     result := self.FNotaFiscal.Empresa.ConfiguracoesNF.aliq_cred_sn;
   except
     on E: EAccessViolation do
       raise Exception.Create(NENHUMA_CONFIGURACAO_CADASTRADA);
   end;
end;

function TfrmNotaFiscal.GetAliquotaICMS: Real;
begin
   try
     result := self.FNotaFiscal.Empresa.ConfiguracoesNF.aliq_icms;

     if (self.FNotaFiscal.Destinatario.Endereco.Cidade.estado.sigla = 'PR') and
        (self.FNotaFiscal.Empresa.ConfiguracoesNF.RegimeTributario <> trtSimplesNacional ) then
       result := 18;

   except
     on E: EAccessViolation do
       raise Exception.Create(NENHUMA_CONFIGURACAO_CADASTRADA);
   end;
end;

function TfrmNotaFiscal.GetAliquotaPIS: Real;
begin
   try
     result := self.FNotaFiscal.Empresa.ConfiguracoesNF.aliq_pis;
   except
     on E: EAccessViolation do
       raise Exception.Create(NENHUMA_CONFIGURACAO_CADASTRADA);
   end;
end;

function TfrmNotaFiscal.GetPercentualReducaoICMS: Real;
var icms_por_estado :TIcmsEstado;
begin
  try
     result := 0;

     if self.FNotaFiscal.NotaDeReducao then
     begin
        icms_por_estado := TIcmsEstado.CreatePorEstado(self.FNotaFiscal.Destinatario.Endereco.Cidade.codest);

        result := icms_por_estado.perc_reducao_bc;
     end;
  except
    on E: EAccessViolation do
      raise Exception.Create(PERCENTAGEM_REDUCAO_BC_NAO_CADASTRADA+self.FNotaFiscal.Destinatario.Endereco.Cidade.estado.sigla);
  end;
end;

procedure TfrmNotaFiscal.memoObservacoesChange(Sender: TObject);
begin
   self.FNotaFiscal.Observacoes.Observacoes := TMemo(Sender).Lines.Text;
end;

procedure TfrmNotaFiscal.AtalhosEmAlteracao(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_F6) then
     btnSalvar.Click
   else
   inherited FormKeyDown(Sender, Key, Shift);
end;

function TfrmNotaFiscal.ValidarNotaFiscal: Boolean;
begin
   result := true;

   try
     if (not Assigned(self.FNotaFiscal.Itens) or (self.FNotaFiscal.Itens.Count <= 0)) then
       raise TExcecaoNotaFiscalInvalida.Create('Não é possível gravar essa nota fiscal! Nenhum item foi adicionado!');

     self.FNotaFiscal.ValidarDadosObrigatorios;
   except
    on E: Exception do begin
       inherited Avisar(0,E.Message);
       self.pgcNotaFiscal.ActivePageIndex := 0;

       if (E is TExcecaoCampoNaoInformado) then begin
          if (Pos('Pagamento', TExcecaoCampoNaoInformado(E).Campo) > 0) then
            self.BuscaFormaPagamento.edtCodigo.SetFocus;

          if (Pos('Transportadora', TExcecaoCampoNaoInformado(E).Campo) > 0) then
            self.BuscaTransportadora.edtCodigo.SetFocus;
       end;

       result := false;
    end;
   end;
end;

procedure TfrmNotaFiscal.FaturarNotaFiscal(Sender: TObject);
var
  RepEmpresa    :TRepositorio;
  RepNotaFiscal :TRepositorio;
begin
   RepEmpresa    := nil;
   RepNotaFiscal := nil;
   
   if not inherited Confirma('Deseja faturar essa nota fiscal?') then
    exit;

   self.FNotaFiscal.Entrada_saida := IfThen(rgTipoNota.ItemIndex = 0, 'E', 'S');
   self.FNotaFiscal.Finalidade := copy(cmbFinalidade.Items[cmbFinalidade.itemIndex], 1, 1);

   if not self.ValidarNotaFiscal() then
    exit;

   dtpEmissaoChange(dtpEmissao);
   Aguarda('Faturando Pedido'+#13#10+#13#10+'( Esta operação pode levar alguns instantes )');
   self.btnSalvar.Enabled                  := false;

   try
     RepEmpresa    := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
     RepNotaFiscal := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     RepNotaFiscal.AdicionarEventoDeAtualizarTela(self.AtualizarTela);

     {Para pegar o nr da nota atualizado, caso estiver sendo usado mais de uma tela simultaneamente}
     self.FNotaFiscal.Empresa.ConfiguracoesNF.Free;
     self.FNotaFiscal.Empresa.ConfiguracoesNF := nil;
     self.FNotaFiscal.NumeroNotaFiscal := self.FNotaFiscal.Empresa.ConfiguracoesNF.IncrementarSequencia;

     RepEmpresa.Salvar(self.FNotaFiscal.Empresa);
     RepNotaFiscal.Salvar(self.FNotaFiscal);

     inherited Avisar(1,'Nota fiscal salva com sucesso! Anote o número da nota fiscal: '+IntToStr(self.FNotaFiscal.NumeroNotaFiscal));

     self.AlterarEstadoTela(etEmCriacao);
   finally
     FreeAndNil(RepEmpresa);
     FreeAndNil(RepNotaFiscal);
     FimAguarda('');
     self.btnSalvar.Enabled                := true;
   end;
end;

procedure TfrmNotaFiscal.AlterarNotaFiscal(Sender: TObject);
var
  RepNotaFiscal      :TRepositorio;
begin
   RepNotaFiscal      := nil;

   if not inherited Confirma('Deseja alterar essa nota fiscal?') then
    exit;

   if not self.ValidarNotaFiscal() then
    exit;

   try
     RepNotaFiscal      := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     RepNotaFiscal.Salvar(self.FNotaFiscal);

     if cdsItensDeletados.Active and (cdsItensDeletados.RecordCount > 0) then
       persisteRemocoesItem;

     inherited Avisar(1,'Nota fiscal alterada com sucesso!');
     self.Close();
   finally
     FreeAndNil(RepNotaFiscal);
   end;
end;

constructor TfrmNotaFiscal.Create(AOwner: TComponent; NotaFiscal: TNotaFiscal);
var
  Repositorio    :TRepositorio;
  nX             :Integer;
  Pedido         :TPedido;
begin
     self.Create(AOwner);

     self.BuscaDestinatario.AposEncontrarObjeto   := nil;
     self.BuscaFornecedor.AposEncontrarObjeto     := nil;
     self.FNotaFiscal                             := NotaFiscal;
     self.AdicionarMetodosDelegadosNaNotaFiscal;

     if NotaFiscal.Destinatario.tipo = 'C' then
       rgpFiltroPessoa.ItemIndex := 0
     else
       rgpFiltroPessoa.ItemIndex := 1;

     if buscaDestinatario.Visible then
     begin
       buscaDestinatario.Pessoa  := NotaFiscal.Destinatario;
       buscaDestinatario.Enabled := false;
     end
     else
     begin
       BuscaFornecedor.Pessoa  := NotaFiscal.Destinatario;
       BuscaFornecedor.Enabled := false;
     end;

     self.BuscaEmitente.codigo              := NotaFiscal.Emitente.codigo;

     self.BuscaCFOP1.CFOP                   := NotaFiscal.CFOP;
     self.chkSerie.Checked                  := true;
     self.edtNumeroNotalFiscal.Text         := IntToStr(NotaFiscal.NumeroNotaFiscal);
     self.edtNfeReferenciada.Text           := NotaFiscal.NFe_referenciada;
     self.cmbFinalidade.ItemIndex           := StrToInt(NotaFiscal.Finalidade) -1;
     self.AlterarEstadoTela(etEmAlteracao);
     self.OnShow                            := nil;

     self.FNotaFiscal.RecalcularNotaFiscal;


     if self.FNotaFiscal.Entrada_saida <> '' then begin
       rgtipoNota.OnClick   := nil;
       rgTipoNota.ItemIndex := IfThen( self.FNotaFiscal.Entrada_saida = 'E',0,1);
       rgtipoNota.OnClick   := rgTipoNotaClick;
     end;

     self.Caption := 'Alteração de Nota Fiscal';

     self.AtualizarNotaFiscal(self.FNotaFiscal);
end;

procedure TfrmNotaFiscal.AdicionarItemAvulsoNaNota;
var
  ItemAvulso          :TItemAvulso;
  RepositorioProduto  :TRepositorio;
  Produto             :TProduto;
begin
  ItemAvulso                    := TItemAvulso.Create;
  ItemAvulso.Preco              := edtPreco.Value;
  ItemAvulso.PercentualDesconto := 0;
  ItemAvulso.quantidade         := edtQuantidade.Value;

  { Adicionar o produto }
  RepositorioProduto := nil;

  try
    RepositorioProduto := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produto            := (RepositorioProduto.Get(BuscaProduto.Produto.codigo) as TProduto);
    ItemAvulso.Produto := Produto;

  finally
    FreeAndNil(RepositorioProduto);
    FreeAndNil(Produto);
  end;

  { Adicionar na Nota Fiscal }
  try
    {se for cfop pelo produto, for o primeiro item inserido e ainda não tiver sido informado o cfop}
    if not assigned(self.FNotaFiscal.ItensAvulsos) and not assigned(BuscaCFOP1.CFOP) then
      BuscaCFOP1.codigo := ItemAvulso.Produto.NCMIbpt.cfop.codigo;

    self.FNotaFiscal.AdicionarItemAvulso(ItemAvulso);
  except
    on E: Exception do
     inherited Avisar(0,E.Message);
  end;
end;

procedure TfrmNotaFiscal.AdicionarMetodosDelegadosNaNotaFiscal;
begin
   self.FNotaFiscal.SetMetodoDelegadoAposAtualizarNotaFiscal      (self.AtualizarNotaFiscal);
  { self.FNotaFiscal.SetMetodoDelegadoAposAdicionarPrimeiroPedido  (self.AtualizarAposAdicionarPrimeiroPedido);
   self.FNotaFiscal.SetMetodoDelegadoAposAtualizarNotaFiscal      (self.AtualizarNotaFiscal);
   self.FNotaFiscal.SetMetodoDelegadoAposRemoverUltimoPedido      (self.AtualizarAposRemoverUltimoPedido);
   self.FNotaFiscal.SetMetodoDelegadoBuscadorAliquotaCreditoSN    (self.GetAliquotaCreditoSN);
   self.FNotaFiscal.SetMetodoDelegadoBuscadorAliquotaCOFINS       (self.GetAliquotaCOFINS); }
end;

procedure TfrmNotaFiscal.BuscaCFOP1edtDescricaoChange(Sender: TObject);
begin
  if BuscaCFOP1.edtDescricao.Text <> '' then
    rgTipoNota.ItemIndex := IfThen(pos(copy(BuscaCFOP1.edtCFOP.Text,1,1), '1,2') > 0, 0,1);
end;

procedure TfrmNotaFiscal.BuscaCFOP1Exit(Sender: TObject);
begin
  if Assigned(self.FNotaFiscal) and Assigned(self.BuscaCFOP1.CFOP) then
    self.FNotaFiscal.CFOP := self.BuscaCFOP1.CFOP;
end;

procedure TfrmNotaFiscal.BuscaEmitenteExit(Sender: TObject);
begin
   if Assigned(self.FNotaFiscal) and Assigned(self.BuscaEmitente.Pessoa) then
    self.FNotaFiscal.Emitente := self.BuscaEmitente.Pessoa;
end;

procedure TfrmNotaFiscal.DeletaItemNota;
var i, cod_item_avulso :integer;
begin
  for i := 0 to self.FNotaFiscal.Itens.Count - 1 do
  begin
    if self.FNotaFiscal.Itens[i].Produto.codigo = cdsItensFiscaisCOD_PRODUTO.AsInteger then
    begin
      cod_item_avulso := 0;

      if assigned(self.FNotaFiscal.ItensAvulsos) then
      begin
        cod_item_avulso := TItemAvulso(self.FNotaFiscal.ItensAvulsos[i]).Codigo;
        self.FNotaFiscal.ItensAvulsos.Remove(TItemAvulso(self.FNotaFiscal.ItensAvulsos[i]));
      end;

      if self.FNotaFiscal.Itens[i].Codigo > 0 then
        armazenaItemDeletado(self.FNotaFiscal.Itens[i].Codigo,
                             cod_item_avulso);

      self.FNotaFiscal.Itens.Remove(self.FNotaFiscal.Itens[i]);

      cdsItensFiscais.Delete;
    end;
  end;
end;

procedure TfrmNotaFiscal.DestacarAoPassarOMouse(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   TLabel(Sender).Font.Style := [fsBold];
end;

procedure TfrmNotaFiscal.VoltarAoNormalAoSairComOMouse(
  Sender: TObject);
begin
   TLabel(Sender).Font.Style := [];
end;

procedure TfrmNotaFiscal.AposAlterarFormaPagamento(
  FormaPagamento: TObject);
var
  Fpagto :TFormaPagamento;
begin
   FPagto := (FormaPagamento as TFormaPagamento);

   self.FNotaFiscal.FormaPagamento := Fpagto;
end;

procedure TfrmNotaFiscal.AposAlterarTransportadora(
  Transportadora: TObject);
var
  Transp :TPessoa;
begin
  Transp := (Transportadora as TPessoa);

   self.FNotaFiscal.Transportadora := Transp;
end;

procedure TfrmNotaFiscal.armazenaItemDeletado(codItemNF, codItemAvulso: Integer);
begin
  if not cdsItensDeletados.Active then
    cdsItensDeletados.CreateDataSet;

  cdsItensDeletados.Append;
  cdsItensDeletadosCOD_ITEM_NF.AsInteger     := codItemNF;
  cdsItensDeletadosCOD_ITEM_AVULSO.AsInteger := codItemAvulso;
  cdsItensDeletados.Post;
end;

procedure TfrmNotaFiscal.dtpEmissaoChange(Sender: TObject);
begin
   self.FNotaFiscal.DataEmissao := StrToDateTime(DateToStr(TDateTimePicker(Sender).Date)+' 00:00:00');
end;

procedure TfrmNotaFiscal.dtpSaidaChange(Sender: TObject);
begin
   self.FNotaFiscal.DataSaida := TDateTimePicker(Sender).DateTime;
end;

procedure TfrmNotaFiscal.edtPesoBrutoChange(Sender: TObject);
begin
   self.FNotaFiscal.Volumes.PesoBruto := TCurrencyEdit(Sender).Value;
end;

procedure TfrmNotaFiscal.edtPesoLiquidoChange(Sender: TObject);
begin
   self.FNotaFiscal.Volumes.PesoLiquido := TCurrencyEdit(Sender).Value;
end;

procedure TfrmNotaFiscal.edtQuantidadeVolumesChange(
  Sender: TObject);
begin
   self.FNotaFiscal.Volumes.QuantidadeVolumes := TCurrencyEdit(Sender).AsInteger;
end;

procedure TfrmNotaFiscal.edtEspecieChange(Sender: TObject);
begin
   try
     self.FNotaFiscal.Volumes.Especie := TEdit(Sender).Text;
   except
     on E: TExcecaoParametroInvalido do
      inherited Avisar(0,'Espécie é um campo obrigatório!');
   end;
end;

procedure TfrmNotaFiscal.BuscaProdutoExit(Sender: TObject);
begin
   if assigned(BuscaProduto.Produto) then
     self.edtPreco.Value   := BuscaProduto.Produto.Valor;
end;

procedure TfrmNotaFiscal.AtualizarTela;
begin
   Application.ProcessMessages;
end;

procedure TfrmNotaFiscal.edtPercentualDescontoFaturaChange(Sender: TObject);
begin
   self.FNotaFiscal.Totais.PercentualDescontoFatura := self.edtPercentualDescontoFatura.Value;
end;

procedure TfrmNotaFiscal.btnInfoDestinatarioClick(Sender: TObject);
begin
  inherited;
  if not assigned(buscaDestinatario.Pessoa) then
    exit;

  frmDadosPessoa      := TfrmDadosPessoa.Create(self,buscaDestinatario.Pessoa, 'Dados do destinatário');
  frmDadosPessoa.Left := (gpbDestinatario.Left*2) + self.Left;
  frmDadosPessoa.Top  := gpbDestinatario.Top + gpbDestinatario.Height + self.Top + trunc(gpbDestinatario.Height/2);
  frmDadosPessoa.ShowModal;
  frmDadosPessoa.Release;
  frmDadosPessoa := nil;
end;

procedure TfrmNotaFiscal.btnItensAvulsosClick(Sender: TObject);
begin
   if not cdsItensDoPedidoSelecionado.IsEmpty then begin
     avisar(1,'Esta operação não é possível, pois um pedido ja foi selecionado');
     Exit;
   end;

   try
     self.CriarNotaFiscal();

     frmItensAvulsos := nil;

     try
       frmItensAvulsos := TfrmItensAvulsos.Create(self.FNotaFiscal);

       frmItensAvulsos.ShowModal;
       self.AtualizarNotaFiscal(self.FNotaFiscal);

       if BuscaFormaPagamento.Visible then
         BuscaFormaPagamento.edtCodigo.SetFocus;

     finally
       frmItensAvulsos.Release;
       frmItensAvulsos := nil;
     end;
   except
      on E: TExcecaoParametroInvalido do begin
          if (pos('Natureza', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe a Natureza de Operação!');
            self.BuscaCFOP1.edtCFOP.SetFocus;
          end;

          if (pos('Serie', E.Message) <> 0) {or (pos(E.Message, 'TipoSerie') <> 0))} then begin
            inherited Avisar(1,'Informe a série!');
            self.BuscaCFOP1.edtCFOP.SetFocus;
          end;

          if (pos('Destinatario', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe o destinatário!');
            if buscaDestinatario.Visible then
              self.BuscaDestinatario.edtCodigo.SetFocus
            else
              self.BuscaFornecedor.edtCodigo.SetFocus;
          end;

          if (pos('Emitente', E.Message) <> 0) then begin
            inherited Avisar(1,'Informe o emitente!');
            self.BuscaEmitente.edtCodigo.SetFocus;
          end;
       end;
   end;
end;

procedure TfrmNotaFiscal.AposAcharEmpresa(Empresa: TObject);
var
  Emp :TEmpresa;
begin
   try
     Emp := (Empresa as TEmpresa);
   except
     on E: EInvalidCast do
      inherited Avisar(0,'TfrmNotaFiscal.AposAcharEmpresa. Contate o suporte!');
   end;

   { Para empresa VLJ que é lucro presumido. O final é 2 e não 1 }

   if (Emp.ConfiguracoesNF.RegimeTributario = trtSimplesNacional) then begin
     if      (self.BuscaCFOP1.edtCFOP.Text = '5102') then
       self.BuscaCFOP1.edtCFOP.Text := '5101'
     else if (self.BuscaCFOP1.edtCFOP.Text = '6102') then
       self.BuscaCFOP1.edtCFOP.Text := '6101';
   end
   else begin
     if      (self.BuscaCFOP1.edtCFOP.Text = '5101') then
       self.BuscaCFOP1.edtCFOP.Text := '5102'
     else if (self.BuscaCFOP1.edtCFOP.Text = '6101') then
       self.BuscaCFOP1.edtCFOP.Text := '6102';
   end;

   self.BuscaCFOP1.edtDescricaoEnter(nil);
end;

procedure TfrmNotaFiscal.rgpFiltroPessoaClick(Sender: TObject);
begin
  buscaDestinatario.Visible := rgpFiltroPessoa.ItemIndex = 0;
  BuscaFornecedor.Visible   := rgpFiltroPessoa.ItemIndex = 1;
end;

procedure TfrmNotaFiscal.rgTipoNotaClick(Sender: TObject);
begin

  if rgTipoNota.ItemIndex = 0 then begin
    self.BuscaCFOP1.Especificacao := nil;
    BuscaFormaPagamento.Visible       := false;
    //BuscaCFOP1.Limpa;
  end
  else
  begin
  {  if (buscaDestinatario.Visible) and (buscaDestinatario.enabled) then
      self.BuscaDestinatario.edtCodigo.SetFocus
    else if (BuscaFornecedor.Visible) and (BuscaFornecedor.enabled) then
      self.BuscaFornecedor.edtCodigo.SetFocus;
    }
    BuscaFormaPagamento.Visible       := true;
  end;

  //BuscaCFOP1.edtCFOP.SetFocus;

end;

procedure TfrmNotaFiscal.selecionaEmpresa;
begin
  Fdm.qryGenerica.Close;
  fdm.qryGenerica.SQL.Text := 'select codigo from pessoas where tipo = ''E'''+
                              ' order by codigo ';
  fdm.qryGenerica.Open;

  BuscaEmitente.Enabled    := fdm.qryGenerica.RecordCount > 1;
  BuscaEmitente.codigo     := fdm.qryGenerica.FieldByName('codigo').AsInteger;
end;

procedure TfrmNotaFiscal.cmbFinalidadeClick(Sender: TObject);
begin
  grpNfeReferenciada.Visible := (cmbFinalidade.ItemIndex = 3);

  if (cmbFinalidade.ItemIndex = 3) then
    edtNfeReferenciada.Clear;

  if self.FEstadoTela = etemAlteracao then
    self.FNotaFiscal.Finalidade := IntToStr(cmbFinalidade.itemIndex + 1);
end;

procedure TfrmNotaFiscal.edtNfeReferenciadaExit(Sender: TObject);
begin
  self.FNotaFiscal.NFe_referenciada := edtNfeReferenciada.Text;
end;

procedure TfrmNotaFiscal.edtNumeroChange(Sender: TObject);
begin
  inherited;
  self.FNotaFiscal.LocalEntrega.Numero := TEdit(Sender).Text;
end;

end.
