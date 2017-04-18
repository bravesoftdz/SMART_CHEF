unit uEntradaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ACBrNFe, ACBrNFeNotasFiscais, Repositorio,
  FabricaRepositorio, NotaFiscal, NaturezaOperacao, TipoSerie, ItemNotaFiscal,
  TotaisNotaFiscal, Empresa, TipoRegimeTributario, ExtCtrls, DB, DBClient, pcnNFe,
  Grids, DBGrids, DBGridCBN, ImgList, Menus, ACBrBase, ACBrDFe, System.ImageList, Vcl.Imaging.pngimage;

type

   TMinhaJanelaHint = class(THintWindow)
   public
       procedure doActivateHint(Sender: TObject);
end;

type

   TCellGrid = class(Grids.TCustomGrid);

type
  TfrmEntradaNota = class(TfrmPadrao)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtCaminhoXml: TEdit;
    BitBtn1: TBitBtn;
    btnImportarNota: TBitBtn;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    fornecedor_no: TImage;
    fornecedor_yes: TImage;
    Nota_no: TImage;
    Nota_yes: TImage;
    Label3: TLabel;
    Shape1: TShape;
    cdsMaterias: TClientDataSet;
    dsMaterias: TDataSource;
    ACBrNFe: TACBrNFe;
    ImageList1: TImageList;
    lbFornecedor: TLabel;
    lbNota: TLabel;
    lbInfoFornecedor: TLabel;
    lbInfoNota: TLabel;
    btnInfoFornecedor: TSpeedButton;
    btnInfoNota: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    PopupCorrecoes: TPopupMenu;
    Associarumamatria1: TMenuItem;
    Cadastrarmatria1: TMenuItem;
    AssociarumCFOP1: TMenuItem;
    CadastrarCFOPcorrespondente1: TMenuItem;
    btnLimpa: TSpeedButton;
    Label4: TLabel;
    edtCST: TEdit;
    btnAtuliza: TBitBtn;
    cdsMateriasCODMAT_FORNECEDOR: TStringField;
    cdsMateriasCODMAT_ERP: TIntegerField;
    cdsMateriasCFOP: TIntegerField;
    cdsMateriasVALIDADO: TStringField;
    GridMaterias: TDBGrid;
    ppmalteraCFOP: TPopupMenu;
    AlterarCFOP1: TMenuItem;
    Label5: TLabel;
    Desassociarproduto1: TMenuItem;
    cdsMateriasDESCRICAO_FORN: TStringField;
    cdsMateriasDESCRICAO_ERP: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnImportarNotaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInfoFornecedorClick(Sender: TObject);
    procedure btnInfoNotaClick(Sender: TObject);
    procedure DBGridCBN1CellClick(Column: TColumn);
    procedure cdsMateriasAfterScroll(DataSet: TDataSet);
    procedure Associarumamatria1Click(Sender: TObject);
    procedure Cadastrarmatria1Click(Sender: TObject);
    procedure btnLimpaClick(Sender: TObject);
    procedure AssociarumCFOP1Click(Sender: TObject);
    procedure CadastrarCFOPcorrespondente1Click(Sender: TObject);
    procedure btnAtulizaClick(Sender: TObject);
    procedure GridMateriasCellClick(Column: TColumn);
    procedure GridMateriasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridMateriasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtCSTKeyPress(Sender: TObject; var Key: Char);
    procedure GridMateriasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AlterarCFOP1Click(Sender: TObject);
    procedure GridMateriasMouseLeave(Sender: TObject);
    procedure Desassociarproduto1Click(Sender: TObject);
    procedure DBGridCBN1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    procedure MateriaCadastrada(produtoNfe :TProd; var codigo :integer; var descricao :String);
    function fornecedorCadastrado: Boolean;
    function  Nota_ja_importada(numero_nota :String) :Boolean;
    function  associar_produto(produtoNfe :TProd)    :Boolean;
    function  cadastrar_produto(produtoNfe :TProd)   :Boolean;
    function  associar_cfop(codigo_natureza :integer) :Boolean;
    function  cadastrar_cfop(codigo_natureza :integer) :Boolean;

    procedure salvaAssociacaoProduto(codigo_produto :integer; codigo_produto_fornecedor :String);
    procedure salvaAssociacaoCFOP(codigo_cfop, codigo_cfop_correspondente :Integer);

    procedure carrega_nota;
    procedure altera_cfop;

    procedure mouseToCell(X, Y: integer; var ACol, ARow: longint);
  private
    registroSelecionado :integer;
    validacoes :integer;

  public
    MeuHint: TMinhaJanelaHint;

  end;

var
  frmEntradaNota: TfrmEntradaNota;

const
  validacao_CFOP    = 'Não existe um CFOP correspondente cadastrado para o CFOP = ';
  validacao_materia = 'Não existe um produto correspondente vinculado ao produto = ';

implementation

uses importadorNotaXML, uCadastroFornecedor, PermissoesAcesso, Funcoes,
  Math, uModulo, StrUtils, uCadastroPadrao, ProdutoFornecedor, CFOPCorrespondente,
  uCadastroNaturezaOperacao, uCadastroProduto, Produto;

{$R *.dfm}

procedure TfrmEntradaNota.BitBtn1Click(Sender: TObject);
var
  Dialog :TOpenDialog;
begin
    Dialog            := TOpenDialog.Create(nil);
    Dialog.Title      := 'Selecione a Nota';
    Dialog.DefaultExt := 'xml';
    Dialog.Filter     := 'XML Nota de Entrada | *.xml';

    if Dialog.Execute then begin
      btnLimpa.Click;
      edtCaminhoXml.Text := Dialog.FileName;
      carrega_nota;
      btnImportarNota.SetFocus;
    end;
end;

procedure TfrmEntradaNota.btnImportarNotaClick(Sender: TObject);
var importador :TImportadorNotaXML;
begin
  if trim(edtCaminhoXml.Text) = '' then begin
    avisar('Nenhuma arquivo ''.xml'' foi selecionado!');
    exit;
  end
  else if Validacoes > 0 then begin
    avisar('ATENCÃO! Ainda existem itens não validados.');
    exit;
  end;

  try
  try
    Fdm.conexao.TxOptions.AutoCommit      := false;

    importador := TImportadorNotaXML.Create(edtCaminhoXml.Text,
                                            edtCST.Text,
                                            StrToInt(trim(copy(lbFornecedor.Caption, 1,
                                            pos('-',lbFornecedor.Caption)-1)) ),
                                            cdsMaterias);
    importador.XMLparaNFe;

    Avisar('Nota Fiscal importada com sucesso!');
    btnLimpa.Click;

    Fdm.conexao.Commit;

  except
    on e : Exception do
      begin
        Fdm.conexao.Rollback;
        Avisar(e.Message);
      end;
  end;

  finally
    Fdm.conexao.TxOptions.AutoCommit      := true;
    FreeAndNil(importador);
  end;

end;

procedure TfrmEntradaNota.carrega_nota;
var nX, codigo :integer;
    descricao :String;
    codigo_natureza :String;
begin
  self.AcbrNfe.NotasFiscais.Clear;
  self.AcbrNfe.NotasFiscais.LoadFromFile(self.edtCaminhoXml.Text);

  if not fornecedorCadastrado then begin
    lbInfoFornecedor.Caption := 'Fornecedor '+AcbrNfe.NotasFiscais.Items[0].NFe.Emit.xNome+' [ CNPJ: '+AcbrNfe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF+
                                ' | IE: ' + AcbrNfe.NotasFiscais.Items[0].NFe.Emit.IE + #13#10+' não consta no cadastro. Favor cadastrar.';
    fornecedor_yes.Visible  := false;
    inc(Validacoes);
    exit;
  end
  else begin
    lbInfoFornecedor.Caption := 'Fornecedor válido.';
    fornecedor_yes.Visible  := true;
  end;

  if fornecedor_yes.Visible and Nota_ja_importada( intToStr(AcbrNfe.NotasFiscais.Items[0].NFe.Ide.nNF) ) then begin
    lbInfoNota.Caption := 'Nota Fiscal de Nº '+ intToStr(AcbrNfe.NotasFiscais.Items[0].NFe.Ide.nNF)+', referente ao fornecedor:'+#13#10+#13#10+
                          '( '+lbFornecedor.Caption+')  já foi importada!';
    Nota_yes.Visible  := false;
    inc(Validacoes);
  end
  else if fornecedor_yes.Visible then begin
    lbInfoNota.Caption := 'Importação liberada.';
    Nota_yes.Visible  := true;
  end;

  for nX := 0 to (AcbrNfe.NotasFiscais.Items[0] as ACBrNFeNotasFiscais.NotaFiscal).NFe.Det.Count - 1 do begin
    codigo    := 0;
    descricao := '';

    self.MateriaCadastrada( AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[nX].Prod, codigo, descricao);

    cdsMaterias.Append;
    cdsMateriasCODMAT_FORNECEDOR.AsString := AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[nX].Prod.cProd;
    cdsMateriasDESCRICAO_FORN.AsString    := AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[nX].Prod.xProd;
    cdsMateriasCODMAT_ERP.asInteger       := codigo;
    cdsMateriasDESCRICAO_ERP.AsString     := descricao;
    codigo_natureza := buscaCFOPCorrespondente( AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[nX].Prod.CFOP );

    cdsMateriasCFOP.AsInteger             := StrToIntDef( IfThen(codigo_natureza = '', '', Campo_por_campo('NATUREZAS_OPERACAO', 'CFOP', 'CODIGO', codigo_natureza)) ,0);
    cdsMateriasVALIDADO.asString          := IfThen((cdsMateriasCODMAT_ERP.AsInteger > 0)and(cdsMateriasCFOP.AsInteger > 0), 'S', 'N');    

    if cdsMateriasCODMAT_ERP.AsInteger = 0 then
      inc(Validacoes);

    if cdsMateriasCFOP.AsInteger = 0 then
      inc(Validacoes);

    cdsMaterias.Post;
  end;

  cdsMaterias.First;
end;

procedure TfrmEntradaNota.SpeedButton1Click(Sender: TObject);
begin
  try
     self.AbreForm(TfrmCadastroFornecedor, paCadastroFornecedor);
  except
    on e : Exception do
      begin
        Avisar(e.Message);
      end;                                                               
  end;
end;

procedure TfrmEntradaNota.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMaterias.CreateDataSet;
  Validacoes := 0;
  MeuHint := TMinhaJanelaHint.Create(Self);
end;

procedure TfrmEntradaNota.MateriaCadastrada(produtoNfe: TProd; var codigo :integer; var descricao :String);
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'SELECT PRO.CODIGO, PRO.descricao FROM PRODUTO_FORNECEDOR PF              '+
                             ' LEFT JOIN PRODUTOS PRO ON PRO.codigo = PF.codigo_produto                '+
                             ' WHERE PF.CODIGO_FORNECEDOR = :CF AND PF.CODIGO_PRODUTO_FORNECEDOR = :CMF';

  dm.qryGenerica.ParamByName('CF').AsInteger   := StrToInt(trim(copy(lbFornecedor.Caption, 1 ,pos('-',lbFornecedor.Caption)-1)) );
  dm.qryGenerica.ParamByName('CMF').AsString   := produtoNfe.cProd;
  dm.qryGenerica.Open;

  if not dm.qryGenerica.IsEmpty then
  begin
    codigo    := dm.qryGenerica.FieldByName('CODIGO').AsInteger;
    descricao := dm.qryGenerica.FieldByName('DESCRICAO').AsString;
  end;
end;

function TfrmEntradaNota.fornecedorCadastrado: Boolean;
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'SELECT CODIGO, RAZAO FROM PESSOAS WHERE CPF_CNPJ = :CPF_CNPJ';// AND TIPO = ''F'' ';
  dm.qryGenerica.ParamByName('CPF_CNPJ').AsString := AcbrNfe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
  dm.qryGenerica.Open;

  if not dm.qryGenerica.IsEmpty then
    lbFornecedor.Caption := dm.qryGenerica.fieldByName('CODIGO').AsString + ' - ' + dm.qryGenerica.fieldByName('RAZAO').AsString
  else
    lbFornecedor.Caption := AcbrNfe.NotasFiscais.Items[0].NFe.Emit.xNome;

  result := not (dm.qryGenerica.IsEmpty);
end;

procedure TfrmEntradaNota.btnInfoFornecedorClick(Sender: TObject);
begin
  avisar(lbInfoFornecedor.Caption);
end;

procedure TfrmEntradaNota.btnInfoNotaClick(Sender: TObject);
begin
  avisar(lbInfoNota.Caption);
end;

function TfrmEntradaNota.Nota_ja_importada(numero_nota: String): Boolean;
begin
  Result := true;

  { Se ja existir uma NF com o mesmo numero e fornecedor da nota corrente }
  if Campo_por_campo('NOTAS_FISCAIS', 'CODIGO', 'NUMERO_NOTA_FISCAL', numero_nota, 'CODIGO_EMITENTE', trim(copy(lbFornecedor.Caption, 1 ,pos('-',lbFornecedor.Caption)-1))) <> '' then
    Result := true
  else
    Result := false;
end;

function TfrmEntradaNota.associar_produto(produtoNfe: TProd): Boolean;
begin
  try
    result := true;
    frmCadastroProduto := TfrmCadastroProduto.CreateModoBusca(nil);
    frmCadastroProduto.ShowModal;

    if (frmCadastroProduto.ModalResult = mrOK) then begin
      salvaAssociacaoProduto(frmCadastroProduto.cdsCODIGO.AsInteger, produtoNfe.cProd);

      cdsMaterias.Edit;
      cdsMateriasCODMAT_ERP.AsInteger := frmCadastroProduto.cdsCODIGO.AsInteger;
      cdsMateriasVALIDADO.AsString    := IfThen(cdsMateriasCFOP.AsInteger > 0, 'S', 'N');
      cdsMaterias.Post;
      dec(Validacoes);
     // btnAtuliza.Click;
    end
    else
      result := false;

  except
    on e :Exception do
    begin
      avisar(e.Message);
      result := false;
    end;
  end;
end;

function TfrmEntradaNota.cadastrar_produto(produtoNfe: TProd): Boolean;
var codigo_produto :integer;
begin
  frmCadastroProduto := TfrmCadastroProduto.Create(nil);
  frmCadastroProduto.produtoNfe := produtoNfe;
  frmCadastroProduto.ShowModal;

  if frmCadastroProduto.ModalResult = MrOk then begin
    Result := true;
    codigo_produto := strToInt( Maior_Valor_Cadastrado('PRODUTOS','CODIGO'));

    salvaAssociacaoProduto( codigo_produto ,produtoNfe.cProd);

    cdsMaterias.Edit;
    cdsMateriasCODMAT_ERP.AsInteger := codigo_produto;
    cdsMateriasVALIDADO.AsString    := IfThen(cdsMateriasCFOP.AsInteger > 0, 'S', 'N');
    cdsMaterias.Post;
    dec(Validacoes);
  end
  else
    result := false;

  frmCadastroProduto.Release;
end;

procedure TfrmEntradaNota.salvaAssociacaoProduto(codigo_produto: integer; codigo_produto_fornecedor: String);
var
    ProdutoFornecedor  :TProdutoFornecedor;
    repositorio        :TRepositorio;
    Produto            :TProduto;
begin
  try
  try
    repositorio       := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produto           := TProduto(repositorio.Get(codigo_produto));

    if not assigned(Produto.Estoque) or
    ((Produto.Estoque.unidade_medida = '') or (Produto.Estoque.unidade_entrada = '') or
     (Produto.Estoque.multiplicador <= 0)) then
     raise Exception.Create('É necessário que o produto tenha as unidades de medida de entrada e saída cadastradas, '+
                            'tanto quanto a quantidade que as equivalem.'+#13#10+'Para prosseguir com a importação, '+
                            'altere o cadastro do produto.');


    repositorio       := TFabricaRepositorio.GetRepositorio(TProdutoFornecedor.ClassName);
    ProdutoFornecedor := TProdutoFornecedor.Create;


    ProdutoFornecedor.codigo_produto            := codigo_produto;
    ProdutoFornecedor.codigo_fornecedor         := StrToInt( trim(copy(lbFornecedor.Caption, 1 ,pos('-',lbFornecedor.Caption)-1)) );
    ProdutoFornecedor.codigo_produto_fornecedor := codigo_produto_fornecedor;

    repositorio.Salvar(ProdutoFornecedor);

  Except
    on e :EXception do
      raise Exception.Create('A associação não pode ser completada.'+#13#10+e.Message);
  end;
  Finally
    FreeAndNil(ProdutoFornecedor);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmEntradaNota.DBGridCBN1CellClick(Column: TColumn);
begin
  if (Column.Index = 2) and ((cdsMateriasCODMAT_ERP.AsInteger = 0) or (cdsMateriasCFOP.AsInteger = 0)) then
    PopupCorrecoes.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmEntradaNota.DBGridCBN1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if gdSelected in State then
    GridMaterias.Canvas.Brush.Color := $00D79844;

  if not odd(cdsMaterias.RecNo) then
    if not (gdSelected in State) then
      begin
        GridMaterias.Canvas.Brush.Color := clMoneyGreen;
        GridMaterias.Canvas.FillRect(Rect);
      end;

  TDbGrid(Sender).DefaultDrawDataCell(Rect, TDbGrid(Sender).columns[datacol].field, State);

  if Column.Field = cdsMateriasVALIDADO then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsMateriasVALIDADO.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true)
    else
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 1, true);
  end;
end;

procedure TfrmEntradaNota.Desassociarproduto1Click(Sender: TObject);
begin
  if not confirma('Confirma desassociação dos produtos seguintes?'+#13#10+#13#10+
              '- '+cdsMateriasDESCRICAO_FORN.AsString+#13#10+
              '- '+cdsMateriasDESCRICAO_ERP.AsString) then
    exit;

  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'DELETE FROM PRODUTO_FORNECEDOR                                     '+
                             ' WHERE CODIGO_FORNECEDOR = :CF AND CODIGO_PRODUTO_FORNECEDOR = :CPF';

  dm.qryGenerica.ParamByName('CF').AsInteger   := StrToInt(trim(copy(lbFornecedor.Caption, 1 ,pos('-',lbFornecedor.Caption)-1)) );
  dm.qryGenerica.ParamByName('CPF').AsString   := cdsMateriasCODMAT_FORNECEDOR.AsString;
  dm.qryGenerica.ExecSQL;

  cdsMaterias.Edit;
  cdsMateriasCODMAT_ERP.AsInteger := 0;
  cdsMateriasVALIDADO.AsString    := 'N';
  cdsMaterias.Post;
end;

procedure TfrmEntradaNota.cdsMateriasAfterScroll(DataSet: TDataSet);
begin
  Associarumamatria1.Visible           := (cdsMateriasCODMAT_ERP.AsInteger = 0);
  Cadastrarmatria1.Visible             := (cdsMateriasCODMAT_ERP.AsInteger = 0);
  AssociarumCFOP1.Visible              := (cdsMateriasCFOP.AsInteger = 0);
  CadastrarCFOPcorrespondente1.Visible := (cdsMateriasCFOP.AsInteger = 0);
  Desassociarproduto1.Visible          := (cdsMateriasCODMAT_ERP.AsInteger > 0);
end;

procedure TfrmEntradaNota.Associarumamatria1Click(Sender: TObject);
begin
  registroSelecionado := cdsMaterias.RecNo;
 if self.associar_produto( AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.recno -1 ].Prod ) then
  cdsMaterias.RecNo   := registroSelecionado;
end;

procedure TfrmEntradaNota.Cadastrarmatria1Click(Sender: TObject);
begin
  registroSelecionado := cdsMaterias.RecNo;
  if self.cadastrar_produto( AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.recno -1 ].Prod ) then
  cdsMaterias.RecNo   := registroSelecionado;
end;

procedure TfrmEntradaNota.btnLimpaClick(Sender: TObject);
begin
  edtCaminhoXml.Clear;
  lbFornecedor.Caption     := '<Fornecedor>';
  lbNota.Caption           := '<Nota>';
  fornecedor_yes.Visible   := true;
  Nota_yes.Visible         := true;
  lbInfoFornecedor.Caption := '...';
  lbInfoNota.Caption       := '...';
  cdsMaterias.EmptyDataSet;
  GridMaterias.BorderStyle := bsNone;
  GridMaterias.BorderStyle := bsSingle;
  Validacoes               := 0;
end;

function TfrmEntradaNota.associar_cfop(codigo_natureza: integer): Boolean;
begin
  try
    result                      := true;
    frmCadastroNaturezaOperacao := TfrmCadastroNaturezaOperacao.CreateModoBusca(nil);
    frmCadastroNaturezaOperacao.filtra_cfop_entrada := true;
    frmCadastroNaturezaOperacao.ShowModal;

    if (frmCadastroNaturezaOperacao.ModalResult = mrOK) then begin
      salvaAssociacaoCFOP(codigo_natureza, frmCadastroNaturezaOperacao.cdsCODIGO.AsInteger);

      cdsMaterias.Edit;
      cdsMateriasCFOP.AsInteger       := frmCadastroNaturezaOperacao.cdsCFOP.AsInteger;
      cdsMateriasVALIDADO.AsString    := IfThen(cdsMateriasCODMAT_ERP.AsInteger > 0, 'S', 'N');
      cdsMaterias.Post;

      btnAtuliza.Click;      
    end
    else
      result := false

  except
    result := false;
  end;
end;

function TfrmEntradaNota.cadastrar_cfop(codigo_natureza: integer): Boolean;
begin
  frmCadastroNaturezaOperacao := TfrmCadastroNaturezaOperacao.Create(nil);
  frmCadastroNaturezaOperacao.cadastro_correspondente := true;
  frmCadastroNaturezaOperacao.ShowModal;

  if frmCadastroNaturezaOperacao.ModalResult = MrOk then begin
    Result := true;
    salvaAssociacaoCFOP( codigo_natureza , strToInt( Maior_Valor_Cadastrado('NATUREZAS_OPERACAO','CODIGO')));

    cdsMaterias.Edit;
    cdsMateriasCFOP.AsString     := AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.RecNo-1 ].Prod.CFOP;
    cdsMateriasVALIDADO.AsString := IfThen(cdsMateriasCODMAT_ERP.AsInteger > 0, 'S', 'N');
    cdsMaterias.Post;

    btnAtuliza.Click;
  end
  else
    result := false;

  frmCadastroNaturezaOperacao.Release;
end;

procedure TfrmEntradaNota.AssociarumCFOP1Click(Sender: TObject);
var codigo_natureza :integer;
begin
  codigo_natureza := StrToIntDef(campo_por_campo('NATUREZAS_OPERACAO','CODIGO','CFOP',
                                                 AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.RecNo-1 ].Prod.CFOP) ,0);

  if self.associar_cfop(codigo_natureza) then

end;

procedure TfrmEntradaNota.CadastrarCFOPcorrespondente1Click(Sender: TObject);
var codigo_natureza :integer;
begin
 codigo_natureza := StrToIntDef( campo_por_campo('NATUREZAS_OPERACAO','CODIGO','CFOP',
                                                 AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.RecNo-1 ].Prod.CFOP) ,0);
                                    
  if self.cadastrar_cfop(codigo_natureza) then

end;

procedure TfrmEntradaNota.salvaAssociacaoCFOP(codigo_cfop, codigo_cfop_correspondente: Integer);
var
    CFOPCorrespondente  :TCFOPCorrespondente;
    repositorio         :TRepositorio;
begin
  try
  try
    repositorio        := TFabricaRepositorio.GetRepositorio(TCFOPCorrespondente.ClassName);
    CFOPCorrespondente := TCFOPCorrespondente.Create;


    CFOPCorrespondente.cod_CFOP_Saida       := codigo_cfop;
    CFOPCorrespondente.cod_CFOP_Entrada     := codigo_cfop_correspondente;

    repositorio.Salvar(CFOPCorrespondente);

  Except
    raise Exception.Create('Erro ao salvar associação');
  end;
  Finally
    FreeAndNil(CFOPCorrespondente);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmEntradaNota.btnAtulizaClick(Sender: TObject);
var caminho :String;
begin
  if edtCaminhoXml.Text <> '' then begin
    caminho := edtCaminhoXml.Text;
    btnLimpa.Click;
    edtCaminhoXml.Text := caminho;
    carrega_nota;
    btnImportarNota.SetFocus;
  end;
end;

procedure TfrmEntradaNota.GridMateriasCellClick(Column: TColumn);
begin
  if Popupcorrecoes.PopupPoint.X = -1 then
    PopupCorrecoes.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y)
  else
    Popupcorrecoes.PopupPoint.SetLocation(-1,-1);
end;

procedure TfrmEntradaNota.GridMateriasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (gdSelected in State) and (Column.Field <> cdsMateriasVALIDADO) then
    TDBGridCBN(Sender).Canvas.Brush.Color := $00D79844;

  if not odd(cdsMaterias.RecNo) then
    if not (gdSelected in State) then
      begin
        TDBGridCBN(Sender).Canvas.Brush.Color := clMoneyGreen;
        TDBGridCBN(Sender).Canvas.FillRect(Rect);
      end;

  TDbGrid(Sender).DefaultDrawDataCell(Rect, TDbGrid(Sender).columns[datacol].field, State);

  if Column.Field = cdsMateriasVALIDADO then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);
    TDBGridCBN(Sender).Canvas.Font.Color := clWhite;

    if cdsMateriasVALIDADO.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true)
    else
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 1, true);
  end;

end;

procedure TfrmEntradaNota.mouseToCell(X, Y: integer; var ACol, ARow: Integer);
var
   Coord: TGridCoord;
begin
  Coord := GridMaterias.MouseCoord(X,Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

{ TMinhaJanelaHint }

procedure TMinhaJanelaHint.doActivateHint(Sender: TObject);
var
   r : TRect;
   wdth_hint, hght_hint : integer;
begin
   if (Sender is TDbGrid) then
   begin
      // Calculo as dimensões necessárias à janela de Hint sendo o limite igual à 1/3 da tela
      r := CalcHintRect((Screen.Width div 3), (Sender as TDbGrid).Hint, nil);
      wdth_hint := r.Right - r.Left;
      hght_hint := r.Bottom - r.Top;
 
      // Reposiciono a janela do Hint para próximo da posição do mouse mantendo o tamanho
      // calculado pela rotina anterior
      r.Left := r.Left + mouse.CursorPos.X + 16;
      r.Top := r.Top + mouse.CursorPos.Y + 16;
      r.Right := r.Left + wdth_hint;
      r.Bottom := r.Top + hght_hint;
      // Executo o procedimento para exibição do Hint na tela

      ActivateHint(r,(Sender as TDbGrid).Hint);
   end;

end;

procedure TfrmEntradaNota.GridMateriasMouseLeave(Sender: TObject);
begin
  inherited;
  GridMaterias.Hint := '';
  MeuHint.ReleaseHandle;
end;

procedure TfrmEntradaNota.GridMateriasMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   MColumn, MRow: Longint;
   MsgHint :String;
begin
   if cdsMaterias.IsEmpty then
     exit;
     
   MsgHint := '';
   // A partir da posição do mouse obtemos a coordenada da célula do grid
   MouseToCell(X,Y,MColumn,MRow);
   // Se for uma célula válida ...
   if (MRow > 0) and (MColumn >3) and (Mcolumn <= GridMaterias.Columns.Count) then
   begin
      // Fazemos a coluna do Grid ser a coluna apontada pelo mouse, para isso usamos a classe amiga
      // definida no começo da unit
      TCellGrid(GridMaterias).Col := MColumn;

      // Movemos o DataSet para a linha apontada pelo mouse deslocando em relação à sua posição
      // anterior
      GridMaterias.DataSource.DataSet.MoveBy(MRow - TCellGrid(GridMaterias).Row);
 
      // Se o dado apontado não for do tipo String nem Variant não apresentamos o Hint
      if cdsMaterias.FieldByName('VALIDADO').AsString = 'S' then begin
         GridMaterias.Hint := '';
         MeuHint.ReleaseHandle;
         Exit;
      end;
      // Passamos o conteúdo do campo para o Hint do Grid e chamamos a função para exibi-lo

      if TClientDataSet(GridMaterias.DataSource.DataSet).FieldByName('CFOP').AsInteger = 0 then
        MsgHint := validacao_CFOP + AcbrNfe.NotasFiscais.Items[0].NFe.Det.Items[ cdsMaterias.RecNo-1 ].Prod.CFOP+#13#10;

      if TClientDataSet(GridMaterias.DataSource.DataSet).FieldByName('CODMAT_ERP').AsInteger = 0 then
        MsgHint := MsgHint + IfThen(MsgHint = '','',#13#10)+validacao_materia +#13#10+
                            TClientDataSet(GridMaterias.DataSource.DataSet).FieldByName('DESCRICAO_FORN').AsString;

      GridMaterias.Hint := MsgHint;

      MeuHint.doActivateHint(GridMaterias);
   end
  else
   begin
      // Se não for célula válida limpo o Hint
      GridMaterias.Hint := '';
      MeuHint.ReleaseHandle;
    end;

end;

procedure TfrmEntradaNota.edtCSTKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmEntradaNota.GridMateriasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F2 then
    altera_cfop;
end;

procedure TfrmEntradaNota.AlterarCFOP1Click(Sender: TObject);
begin
  inherited;
  altera_cfop;
end;

procedure TfrmEntradaNota.altera_cfop;
var CFOP :String;
begin
  frmCadastroNaturezaOperacao := TfrmCadastroNaturezaOperacao.CreateModoBusca(nil);

  try
    if (frmCadastroNaturezaOperacao.ShowModal = mrOK) then
      CFOP  := frmCadastroNaturezaOperacao.cdsCFOP.AsString
    else
      exit;

    cdsMaterias.Edit;
    cdsMateriasCFOP.AsString := CFOP;
    cdsMaterias.Post;

  finally
    frmCadastroNaturezaOperacao.Release;
    frmCadastroNaturezaOperacao := nil;
  end;
end;

end.
