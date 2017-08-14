unit uEntradaSaidaMercadoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, ExtCtrls, pngimage, frameBuscaProduto,
  frameBuscaDispensa, Mask, RXToolEdit, RXCurrEdit, Buttons, DB, DBClient,
  Grids, DBGrids, EntradaSaida, frameBuscaPessoa, frameBuscaFornecedor;

type
  TfrmEntradaSaidaMercadoria = class(TfrmPadrao)
    rgpOperacao: TRadioGroup;
    rgpTipo: TRadioGroup;
    BuscaDispensa1: TBuscaDispensa;
    BuscaProduto1: TBuscaProduto;
    GroupBox2: TGroupBox;
    lbEstoque: TStaticText;
    edtEstoque: TCurrencyEdit;
    lbQuantidade: TStaticText;
    edtQuantidade: TCurrencyEdit;
    grpInfEntrada: TGroupBox;
    edtNumDoc: TCurrencyEdit;
    edtData: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    mmoObs: TMemo;
    StaticText3: TStaticText;
    Panel1: TPanel;
    btnExecutar: TBitBtn;
    DBGrid1: TDBGrid;
    cds: TClientDataSet;
    ds: TDataSource;
    btnAdd: TBitBtn;
    cdsCODIGO_ITEM: TIntegerField;
    cdsQUANTIDADE: TFloatField;
    cdsDESCRICAO: TStringField;
    cdsCODIGO_ESTOQUE: TIntegerField;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    btnCancelar: TBitBtn;
    cdsUN_MEDIDA: TStringField;
    StaticText6: TStaticText;
    edtPrecoCusto: TCurrencyEdit;
    cdsPRECO_CUSTO: TFloatField;
    cdsTIPO_ITEM: TStringField;
    GroupBox1: TGroupBox;
    buscaFornecedor: TBuscaFornecedor;
    edtVlrTotal: TCurrencyEdit;
    StaticText7: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure rgpTipoClick(Sender: TObject);
    procedure rgpOperacaoClick(Sender: TObject);
    procedure BuscaDispensa1Exit(Sender: TObject);
    procedure BuscaProduto1Exit(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure BuscaDispensa1edtCodigoChange(Sender: TObject);
    procedure BuscaProduto1edtCodigoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPrecoCustoChange(Sender: TObject);
  private
    procedure atualiza_estoque;
    procedure salva_entrada_saida;
    procedure limpar_campos;
    procedure limpa_info;
    procedure atualiza_preco_custo;
    procedure buscaPorAssociacao(pCodigoProduto, pCodigoFornecedor :integer; pCodigoProdutoFornecedor :String);

    function verifica_obrigatorios :Boolean;
  public
    { Public declarations }
  end;

var
  frmEntradaSaidaMercadoria: TfrmEntradaSaidaMercadoria;

implementation

uses StrUtils, Estoque, Repositorio, FabricaRepositorio, Math, Dispensa,
  Produto, uModulo, Usuario, ProdutoFornecedor, EspecificacaoProdutoFornecedorPorCodigos;

{$R *.dfm}

procedure TfrmEntradaSaidaMercadoria.FormCreate(Sender: TObject);
begin
  inherited;
//  TRadioButton(rgpOperacao.Controls[0]).Font.Color := $009B8F26;
 // TRadioButton(rgpOperacao.Controls[1]).Font.Color := $000070DF;
end;

procedure TfrmEntradaSaidaMercadoria.rgpTipoClick(Sender: TObject);
begin
  BuscaDispensa1.Visible := (rgpTipo.ItemIndex = 1);
  BuscaProduto1.Visible  := (rgpTipo.ItemIndex = 0);

  limpar_campos;
end;

procedure TfrmEntradaSaidaMercadoria.rgpOperacaoClick(Sender: TObject);
begin
  lbQuantidade.Caption := IfThen(rgpOperacao.ItemIndex = 0, 'Quantidade a dar entrada', 'Quantidade a dar saída');

//  rgpTipo.Visible := (rgpOperacao.ItemIndex = 0);

  edtPrecoCusto.Enabled := (rgpOperacao.ItemIndex = 0);

  buscaFornecedor.Limpa;
  if rgpOperacao.ItemIndex = 1 then
    BuscaFornecedor.Desabilita
  else
    BuscaFornecedor.Habilita;

  limpar_campos;
  limpa_info;
end;

procedure TfrmEntradaSaidaMercadoria.BuscaDispensa1Exit(Sender: TObject);
begin
  if assigned(BuscaDispensa1.Estoque) then begin
    edtEstoque.Value     := BuscaDispensa1.Estoque.quantidade;
    edtPrecoCusto.Value  := BuscaDispensa1.Dispensa.preco_custo;
  end;
end;

procedure TfrmEntradaSaidaMercadoria.buscaPorAssociacao(pCodigoProduto, pCodigoFornecedor :integer; pCodigoProdutoFornecedor :String);
var ProdutoFornecedor  :TProdutoFornecedor;
    repositorioForn    :TRepositorio;
    especificacao      :TEspecificacaoProdutoFornecedorPorCodigos;
begin
  try
    repositorioForn := TFabricaRepositorio.GetRepositorio(TProdutoFornecedor.ClassName);
    especificacao   := TEspecificacaoProdutoFornecedorPorCodigos.Create(pCodigoFornecedor, pCodigoProduto);
    ProdutoFornecedor := TProdutoFornecedor(repositorioForn.GetPorEspecificacao(especificacao,'CODIGO_FORNECEDOR = '+intToStr(pCodigoFornecedor)));

    if not assigned(ProdutoFornecedor) then
      ProdutoFornecedor := TProdutoFornecedor.create(pCodigoProduto, pCodigoFornecedor, pCodigoProdutoFornecedor);

    repositorioForn.Salvar(ProdutoFornecedor);
  finally
    FreeAndNil(ProdutoFornecedor);
    FreeAndNil(repositorioForn);
    FreeAndNil(especificacao);
  end;
end;

procedure TfrmEntradaSaidaMercadoria.BuscaProduto1Exit(Sender: TObject);
begin
  if assigned(BuscaProduto1.Estoque) then begin
    edtEstoque.Value    := BuscaProduto1.Estoque.quantidade;
    edtPrecoCusto.Value := BuscaProduto1.Produto.preco_custo;
  end;
end;

procedure TfrmEntradaSaidaMercadoria.btnExecutarClick(Sender: TObject);
begin
 try
 try
   if not verifica_obrigatorios then
     Exit;

   fdm.conexao.TxOptions.AutoCommit := false;
   atualiza_estoque;
   salva_entrada_saida;
   cds.EmptyDataSet;
   limpa_info;

   fdm.conexao.Commit;
   avisar('Operação realizada com sucesso!');

 Except
   On E: Exception do begin
     fdm.conexao.Rollback;
     avisar('Erro ao executar movimentação!'+#13#10+e.Message);
   end;
 end;

 finally
   fdm.conexao.TxOptions.AutoCommit := true;
 end;
end;

procedure TfrmEntradaSaidaMercadoria.atualiza_estoque;
var repositorio        :TRepositorio;
    estoque            :TEstoque;
begin
  repositorio := nil;
  estoque     := nil;
  try
  try
    repositorio     := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
    cds.First;
    while not cds.Eof do begin
      if assigned(buscaFornecedor.Pessoa) then
        buscaPorAssociacao(cdsCODIGO_ITEM.AsInteger, buscaFornecedor.Pessoa.Codigo, cdsCODIGO_ITEM.AsString);

      if cdsTIPO_ITEM.AsString = 'D' then begin

        estoque := TEstoque(repositorio.Get( cdsCODIGO_ESTOQUE.AsInteger ));

        if assigned(Estoque) then begin
          estoque.quantidade      := estoque.quantidade + (cdsQUANTIDADE.AsInteger * IfThen(rgpOperacao.ItemIndex = 0, +1, -1) );
        end
        else begin
          estoque := TEstoque.Create;

          estoque.codigo_dispensa := cdsCODIGO_ITEM.AsInteger;
          estoque.quantidade      := (cdsQUANTIDADE.AsInteger * IfThen(rgpOperacao.ItemIndex = 0, +1, -1) );
          estoque.pecas           := 1;
          estoque.unidade_medida  := cdsUN_MEDIDA.AsString;
        end;

        repositorio.Salvar( Estoque );
      end
      else begin

        estoque := TEstoque(repositorio.Get( cdsCODIGO_ESTOQUE.AsInteger ));

        if assigned(Estoque) then begin
          estoque.quantidade      := estoque.quantidade + (cdsQUANTIDADE.AsInteger * IfThen(rgpOperacao.ItemIndex = 0, +1, -1) );
          estoque.unidade_medida  := cdsUN_MEDIDA.AsString;
        end
        else begin
          estoque := TEstoque.Create;

          estoque.codigo_produto  := cdsCODIGO_ITEM.AsInteger;
          estoque.quantidade      := (cdsQUANTIDADE.AsInteger * IfThen(rgpOperacao.ItemIndex = 0, +1, -1) );
          estoque.pecas           := 1;
          estoque.unidade_medida  := cdsUN_MEDIDA.AsString;
        end;

        repositorio.Salvar( estoque );
      end;
      cds.Next;
    end;

  Except
    On E: Exception do
      raise Exception.Create(e.Message);
  end;

  finally
    FreeAndNil(repositorio);
    if assigned(estoque) then
      FreeAndNil(estoque);
  end;
end;

procedure TfrmEntradaSaidaMercadoria.edtQuantidadeChange(Sender: TObject);
begin

  if (edtQuantidade.Value > 0) and not assigned(BuscaDispensa1.Dispensa) and not assigned(BuscaProduto1.Produto) then begin
    avisar('Nenhum item de estoque foi informado!');
    limpar_campos;
    exit;
  end;

  if (rgpOperacao.ItemIndex = 1) and (edtEstoque.Value < edtQuantidade.Value) then
    edtQuantidade.Value := edtEstoque.Value;

end;

procedure TfrmEntradaSaidaMercadoria.BuscaDispensa1edtCodigoChange(
  Sender: TObject);
begin
  inherited;
  BuscaDispensa1.edtCodigoChange(Sender);
  edtEstoque.Clear;
end;

procedure TfrmEntradaSaidaMercadoria.BuscaProduto1edtCodigoChange(
  Sender: TObject);
begin
  inherited;
  BuscaProduto1.edtCodigoChange(Sender);
  edtEstoque.Clear;
end;

procedure TfrmEntradaSaidaMercadoria.limpar_campos;
begin
  BuscaDispensa1.limpa;
  BuscaProduto1.limpa;
  edtEstoque.Clear;
  edtQuantidade.Clear;
  edtPrecoCusto.Clear;
  edtPrecoCusto.Tag := 0;

  if BuscaDispensa1.Visible then  BuscaDispensa1.edtCodigo.SetFocus;
  if BuscaProduto1.Visible  then  BuscaProduto1.edtCodigo.SetFocus;
end;

function TfrmEntradaSaidaMercadoria.verifica_obrigatorios: Boolean;
begin
  Result := false;

  if rgpOperacao.ItemIndex < 0 then begin
    avisar('É necessário informar se a operação é de entrada ou saída.');
    rgpOperacao.SetFocus;
  end
  else
    Result := true;
end;

procedure TfrmEntradaSaidaMercadoria.FormShow(Sender: TObject);
begin
  inherited;
  cds.CreateDataSet;
  edtData.Text := DateToStr(Date);
end;

procedure TfrmEntradaSaidaMercadoria.btnAddClick(Sender: TObject);
var codigo_item, codigo_estoque :integer;
    descricao, unidade_medida :String;
begin
  try
    if (BuscaProduto1.edtCodigo.Text = '') and (BuscaDispensa1.edtCodigo.value <=0 ) then
      Exit
    else begin

      codigo_estoque := 0;
      codigo_item    := 0;

      if rgpTipo.ItemIndex = 0 then begin
        codigo_item    := BuscaProduto1.Produto.codigo;

        if assigned(BuscaProduto1.Estoque) then
          codigo_estoque := BuscaProduto1.Estoque.codigo;

        unidade_medida := 'UN';  
        descricao      := BuscaProduto1.Produto.descricao;
      end
      else begin

        if (BuscaDispensa1.cmbUnidadeMedida.ItemIndex < 0) then begin
          avisar('Favor informar a unidade de medida correspondente ao item de entrada.');
          BuscaDispensa1.cmbUnidadeMedida.SetFocus;
          exit;
        end
        else if (edtPrecoCusto.Value <= 0) then begin
          avisar('O preço de custo deve ser maior que zero.');
          edtPrecoCusto.SetFocus;
          exit;
        end;

        unidade_medida := BuscaDispensa1.cmbUnidadeMedida.Items[BuscaDispensa1.cmbUnidadeMedida.itemIndex];
        codigo_item    := BuscaDispensa1.Dispensa.codigo;

        if assigned(BuscaDispensa1.Estoque) then
          codigo_estoque := BuscaDispensa1.Estoque.codigo;

        descricao      := BuscaDispensa1.Dispensa.descricao_item;
      end;

      if cds.Locate('CODIGO_ITEM', codigo_item, []) then
         exit;

      cds.Append;
      cdsCODIGO_ITEM.AsInteger    := codigo_item;
      cdsQUANTIDADE.AsFloat       := edtQuantidade.Value;
      cdsDESCRICAO.AsString       := descricao;
      cdsCODIGO_ESTOQUE.AsInteger := codigo_estoque;
      cdsUN_MEDIDA.AsString       := unidade_medida;
      cdsPRECO_CUSTO.AsFloat      := edtPrecoCusto.Value;
      cdsTIPO_ITEM.AsString       := IfThen( rgpTipo.ItemIndex = 1, 'D', 'P');
      cds.Post;

      btnExecutar.Enabled := true; 
    end;

  Finally
    if edtPrecoCusto.Tag = 1 then
      atualiza_preco_custo;
    limpar_campos;
  end;

end;

procedure TfrmEntradaSaidaMercadoria.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_DELETE) and not(cds.IsEmpty) then begin
    cds.Delete;

    btnExecutar.Enabled := not cds.IsEmpty;
  end;
end;

procedure TfrmEntradaSaidaMercadoria.btnCancelarClick(Sender: TObject);
begin
  limpar_campos;
end;

procedure TfrmEntradaSaidaMercadoria.salva_entrada_saida;
var repositorio   :TRepositorio;
    entrada_saida :TEntradaSaida;
begin
  repositorio   := nil;
  entrada_saida := nil;
  try
  try
    repositorio   := TFabricaRepositorio.GetRepositorio(TEntradaSaida.ClassName);
    entrada_saida := TEntradaSaida.Create;

    entrada_saida.num_documento     := edtNumDoc.AsInteger;
    entrada_saida.data              := StrToDate(edtData.Text);
    entrada_saida.entrada_saida     := IfThen(rgpOperacao.ItemIndex = 0, 'E', 'S');
    entrada_saida.tipo              := IfThen(rgpTipo.ItemIndex = 0, 'P', 'D');
    entrada_saida.observacao        := mmoObs.Text;
    entrada_saida.codigo_usuario    := fdm.UsuarioLogado.Codigo;
    entrada_saida.codigo_fornecedor := buscaFornecedor.edtCodigo.AsInteger;
    entrada_saida.valor_total       := edtVlrTotal.Value;

    cds.First;
    while not cds.Eof do begin
      entrada_saida.codigo         := 0;
      entrada_saida.codigo_item    := cdsCODIGO_ITEM.AsInteger;
      entrada_saida.quantidade     := cdsQUANTIDADE.AsFloat;
      entrada_saida.preco_custo    := cdsPRECO_CUSTO.AsFloat;

      repositorio.Salvar(entrada_saida);
      cds.Next;
    end;

  Except
    On E: Exception do
      raise Exception.Create(e.Message);
  end;

  finally
    FreeAndNil(repositorio);
    FreeAndNil(entrada_saida);
  end;
end;

procedure TfrmEntradaSaidaMercadoria.limpa_info;
begin
  buscaFornecedor.Limpa;
  edtNumDoc.Clear;
  edtVlrTotal.Clear;
  mmoObs.Clear;
end;

procedure TfrmEntradaSaidaMercadoria.edtPrecoCustoChange(Sender: TObject);
begin
  edtPrecoCusto.Tag := 1;
end;

procedure TfrmEntradaSaidaMercadoria.atualiza_preco_custo;
var repositorio :TRepositorio;
    Classe :TClass;
begin
  try
    repositorio := nil;

    If( rgpTipo.ItemIndex = 0) then
      repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName)
    else
      repositorio := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);



    if assigned(BuscaDispensa1.Dispensa) then begin
      BuscaDispensa1.Dispensa.preco_custo := edtPrecoCusto.Value;
      repositorio.Salvar(BuscaDispensa1.Dispensa);
    end
    else begin
      BuscaProduto1.Produto.preco_custo := edtPrecoCusto.Value;
      repositorio.Salvar(BuscaProduto1.Produto);
    end;

  finally
    FreeAndNil(repositorio);
  end;
end;

end.
