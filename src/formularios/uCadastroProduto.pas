unit uCadastroProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, ExtCtrls, contnrs, frameListaCampo, Mask,
  RXToolEdit, RXCurrEdit, Math, pngimage, frameBuscaMateriaPrima, ImgList,
  frameBuscaNCM, Generics.Collections, ProdutoHasMateria, pcnNFe, System.ImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider;

type
  TfrmCadastroProduto = class(TfrmCadastroPadrao)
    lblRazao: TLabel;
    Label12: TLabel;
    edtProduto: TEdit;
    edtCodigo: TEdit;
    edtValor: TCurrencyEdit;
    cbAtivo: TComboBox;
    lbAtivo: TLabel;
    ListaGrupo: TListaCampo;
    gridItens: TDBGridCBN;
    cdsMaterias: TClientDataSet;
    dsMaterias: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    BuscaMateriaPrima1: TBuscaMateriaPrima;
    btnAddMateria: TBitBtn;
    Label5: TLabel;
    Image1: TImage;
    cdsMateriasCODIGO: TIntegerField;
    cdsMateriasDESCRICAO: TStringField;
    cdsMateriasCODIGO_MATERIA: TIntegerField;
    ListaDepartamento: TListaCampo;
    BuscaNCM1: TBuscaNCM;
    cbTipo: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    edtICMS: TCurrencyEdit;
    lbAliquota: TStaticText;
    cbTributacao: TComboBox;
    lbTributacao: TStaticText;
    StaticText2: TStaticText;
    cbPreparo: TComboBox;
    edtEstoque: TCurrencyEdit;
    lbEstoque: TStaticText;
    edtPrecoCusto: TCurrencyEdit;
    lbPrecoCusto: TStaticText;
    lbEstoqueMin: TStaticText;
    edtEstoqueMin: TCurrencyEdit;
    cbAlteraPreco: TComboBox;
    lbAlteraPreco: TStaticText;
    edtCodBar: TEdit;
    lblCodBar: TLabel;
    edtCodigoBalanca: TEdit;
    lblReferencia: TLabel;
    lblUnEnt: TLabel;
    edtUNEntrada: TEdit;
    edtUNSaida: TEdit;
    lblUnSaida: TLabel;
    lblMultiplicador: TLabel;
    edtMultiplicador: TCurrencyEdit;
    cbAdicional: TComboBox;
    lbAdicional: TLabel;
    cdsMateriasADICIONAL: TStringField;
    ImageList1: TImageList;
    edtReferencia: TEdit;
    Label1: TLabel;
    qry1: TFDQuery;
    DataSetProvider1: TDataSetProvider;
    cdsESTOQUE: TBCDField;
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    cdsVALOR: TBCDField;
    cdsATIVO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnAddMateriaClick(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridItensCellClick(Column: TColumn);
  private
    FProdutoNfe :TProd;

    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;

  private
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;

  private
    procedure adicionaMateria(codigo, codigo_materia :Integer; descricao :String; adicional :Boolean);
    procedure remove_materia;
    procedure SetprodutoNfe(const Value: TProd);

  public
    property produtoNfe :TProd read FprodutoNfe write SetprodutoNfe;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

uses Produto, repositorio, fabricarepositorio, StrUtils, uPadrao,
  MateriaPrima, NcmIBPT, Estoque, EspecificacaoEstoquePorProduto;

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.AlterarRegistroNoCDS(Registro: TObject);
var
  Produto :TProduto;
begin
  inherited;

  Produto := (Registro as TProduto);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger    := Produto.codigo;
  self.cdsDESCRICAO.AsString := Produto.descricao;
  self.cdsVALOR.AsFloat      := Produto.valor;
  self.cdsATIVO.AsString     := IfThen(Produto.ativo, 'S', 'N');
  if assigned(Produto.Estoque) then
    self.cdsESTOQUE.AsFloat := Produto.Estoque.quantidade;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.CarregarDados;
begin
  qry1.Connection := fdm.conexao;
  cds.Close;
  qry1.SQL.Text   := 'select est.quantidade estoque, pro.codigo, pro.descricao, pro.valor, pro.ativo from produtos pro '+
                     ' left join estoque est on est.codigo_produto = pro.codigo                                        ';
  cds.Open();
end;

procedure TfrmCadastroProduto.ExecutarDepoisAlterar;
begin
  inherited;
  edtProduto.SetFocus;
end;

procedure TfrmCadastroProduto.ExecutarDepoisIncluir;
begin
  inherited;
  edtProduto.SetFocus;
end;

function TfrmCadastroProduto.GravarDados: TObject;
var
  Produto            :TProduto;
  Repositorio        :TRepositorio;
  ProdutoHasMateria  :TProdutoHasMateria;
  Estoque            :TEstoque;
  Especificacao      :TEspecificacaoEstoquePorProduto;
begin
   Produto       := nil;
   Repositorio   := nil;
   Estoque       := nil;
   Especificacao := nil;

   try
   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
     Produto     := TProduto(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Produto) then
      Produto := TProduto.Create;

     if ListaGrupo.CodCampo > 0 then
       Produto.codigo_grupo        := ListaGrupo.CodCampo;
       
     Produto.descricao           := self.edtProduto.Text;
     Produto.valor               := self.edtValor.Value;
     Produto.ativo               := cbAtivo.ItemIndex = 0;
     Produto.codigo_departamento := ListaDepartamento.CodCampo;
     Produto.icms                := edtICMS.Value;
     Produto.preco_custo         := edtPrecoCusto.Value;
     Produto.codbar              := self.edtCodBar.Text;
     Produto.referencia          := self.edtReferencia.Text;
     Produto.codigo_balanca      := self.edtCodigoBalanca.Text;

     if assigned(BuscaNCM1.NCM) then
       Produto.codigo_ibpt         := BuscaNCM1.NCM.codigo;

     case cbTipo.itemIndex of
       0 : Produto.tipo := 'P';
       1 : Produto.tipo := 'S';
       2 : Produto.tipo := 'M';
       3 : Produto.tipo := 'C';
     end;

     case cbTributacao.ItemIndex of
       0 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'T','S');
       1 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'II','SI');
       2 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'NN','SN');
       3 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'FF','SF');
     end;

     Produto.preparo      := cbPreparo.Items[ cbPreparo.itemIndex ];
     Produto.altera_preco := IfThen(cbAlteraPreco.ItemIndex = 0, 'S', 'N');

     //se for produto ou produto-materia, controla estoque próprio
     if pos(Produto.tipo, 'PM') > 0 then
     begin
       { * * * SALVA ESTOQUE DO PRODUTO * * * }
       if not assigned( Produto.Estoque ) then
         Produto.Estoque := TEstoque.Create;

       Produto.Estoque.unidade_medida := edtUNSaida.Text;
       Produto.Estoque.unidade_entrada:= edtUNEntrada.Text;
       Produto.Estoque.multiplicador  := edtMultiplicador.Value;
       Produto.Estoque.pecas          := 1;
       Produto.Estoque.quantidade_min := edtEstoqueMin.Value;
     end;

     Repositorio.Salvar(Produto);

     if self.EstadoTela = tetIncluir then
       Produto.codigo := 0;

     if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       Repositorio.Salvar_2(Produto);


     { * * * SALVA MATÉRIAS-PRIMAS DO PRODUTO * * * }
     if not cdsMaterias.IsEmpty then begin

        Repositorio          := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);

        cdsMaterias.First;
        while not cdsMaterias.Eof do begin
          ProdutoHasMateria    := TProdutoHasMateria(repositorio.Get( cdsMateriasCODIGO.AsInteger ));

          if not assigned(ProdutoHasMateria) then
            ProdutoHasMateria := TProdutoHasMateria.Create;

          ProdutoHasMateria.codigo_produto := Produto.codigo;
          ProdutoHasMateria.codigo_materia := cdsMateriasCODIGO_MATERIA.AsInteger;
          ProdutoHasMateria.Adicional      := cdsMateriasADICIONAL.AsString = 'SIM';

          Repositorio.Salvar( ProdutoHasMateria );

          if cdsMateriasCODIGO.AsInteger = 0 then
            ProdutoHasMateria.codigo := 0;

          if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
            Repositorio.Salvar_2( ProdutoHasMateria);

          cdsMaterias.Next;
        end;

     end;

     result := Produto;

   if assigned(FProdutoNfe) then
      self.ModalResult := MrOk;

   Except
    on e : Exception do
      begin
        if assigned(FProdutoNfe) then
           self.ModalResult := MrCancel;

      end;
   end;

   finally
     FreeAndNil(Repositorio);
     if assigned(ProdutoHasMateria) then  FreeAndNil(ProdutoHasMateria);
     if assigned(Especificacao)     then  FreeAndNil(Especificacao);
   end;
end;

procedure TfrmCadastroProduto.IncluirRegistroNoCDS(Registro: TObject);
var
  Produto :TProduto;
begin
  inherited;

  Produto := (Registro as TProduto);

  self.cds.Append;
  self.cdsCODIGO.AsFloat    := Produto.codigo;
  self.cdsDESCRICAO.AsString := Produto.descricao;
  self.cdsVALOR.AsFloat     := Produto.valor;
  self.cdsATIVO.AsString     := IfThen(Produto.ativo, 'S', 'N');
  if assigned(Produto.Estoque) then
    self.cdsESTOQUE.AsFloat := Produto.Estoque.quantidade;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtProduto.Clear;
  edtValor.Clear;
  cbAtivo.ItemIndex := 0;
  ListaGrupo.comListaCampo.ItemIndex        := -1;
  ListaDepartamento.comListaCampo.ItemIndex := -1;
  cdsMaterias.EmptyDataSet;
  BuscaMateriaPrima1.limpa;
  BuscaNCM1.limpa;
  cbTipo.ItemIndex        := -1;
  edtICMS.Clear;
  cbTributacao.ItemIndex  := -1;
  cbPreparo.ItemIndex     := -1;
  cbAlteraPreco.ItemIndex := -1;
  edtPrecoCusto.Clear;
  edtEstoque.Clear;
  edtEstoqueMin.Clear;
  edtCodBar.Clear;
  edtReferencia.Clear;
  edtCodigoBalanca.Clear;
  edtUNSaida.Clear;
  edtUNEntrada.Clear;
  edtMultiplicador.Clear;
  cbAdicional.ItemIndex := 0;
end;

procedure TfrmCadastroProduto.MostrarDados;
var
  Produto               :TProduto;
  RepositorioProduto    :TRepositorio;
  Especificacao         :TEspecificacaoEstoquePorProduto;
  Estoque               :TEstoque;
  i :integer;
  listaDeMaterias       :TObjectList<TProdutoHasMateria>;
begin
  inherited;
  Produto              := nil;
  RepositorioProduto   := nil;
  Especificacao        := nil;
  Estoque              := nil;
  try
    RepositorioProduto  := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produto             := TProduto(RepositorioProduto.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Produto) then exit;

    self.edtCodigo.Text             := IntToStr(Produto.codigo);
    self.ListaGrupo.CodCampo        := Produto.codigo_grupo;
    self.edtProduto.Text            := Produto.descricao;
    self.edtValor.Value             := Produto.valor;
    self.cbAtivo.ItemIndex          := IfThen(Produto.ativo, 0, 1);
    self.ListaDepartamento.CodCampo := Produto.codigo_departamento;
    self.BuscaNCM1.codigo           := Produto.codigo_ibpt;

    case AnsiIndexStr(UpperCase(Produto.tipo), ['P', 'S', 'M', 'C']) of
      0 : self.cbTipo.ItemIndex := 0;
      1 : self.cbTipo.ItemIndex := 1;
      2 : self.cbTipo.ItemIndex := 2;
      3 : self.cbTipo.ItemIndex := 3;
    end;

    cbTipoChange(nil);
    self.edtICMS.Value              := Produto.icms;
    self.cbPreparo.ItemIndex        := cbPreparo.Items.IndexOf(Produto.preparo);
    self.cbAlteraPreco.ItemIndex    := IfThen(Produto.altera_preco = 'S', 0, 1);
    self.edtPrecoCusto.Value        := Produto.preco_custo;
    self.edtCodBar.Text             := Produto.codbar;
    self.edtReferencia.Text         := Produto.referencia;
    self.edtCodigoBalanca.Text      := Produto.codigo_balanca;

    case AnsiIndexStr(UpperCase(Produto.tributacao), ['T', 'II','NN','FF','S','SI','SN','SF']) of
     0,4 : cbTributacao.ItemIndex := 0;
     1,5 : cbTributacao.ItemIndex := 1;
     2,6 : cbTributacao.ItemIndex := 2;
     3,7 : cbTributacao.ItemIndex := 3;
    end;

    listaDeMaterias := TProdutoHasMateria.MateriasDoProduto(Produto.codigo);

    if not assigned(listaDeMaterias) then Exit;

    for i := 0 to listaDeMaterias.Count - 1 do
      adicionaMateria(TProdutoHasMateria(listaDeMaterias.Items[i]).codigo,
                      TMateriaPrima(TProdutoHasMateria(listaDeMaterias.Items[i]).materia_prima).codigo,
                      TMateriaPrima(TProdutoHasMateria(listaDeMaterias.Items[i]).materia_prima).descricao,
                      TProdutoHasMateria(listaDeMaterias.Items[i]).Adicional);



    if not assigned( Produto.Estoque ) then
      Exit;

    edtEstoque.Value           := Produto.Estoque.quantidade;
    edtEstoqueMin.Value        := Produto.Estoque.quantidade_min;
    edtUNSaida.Text            := Produto.Estoque.unidade_medida;
    edtUNEntrada.Text          := Produto.Estoque.unidade_entrada;
    edtMultiplicador.Value     := Produto.Estoque.multiplicador;
  finally
     FreeAndNil(RepositorioProduto);
     FreeAndNil(Produto);
     FreeAndNil(listaDeMaterias);
     if assigned(Estoque)           then  FreeAndNil(Estoque);
     if assigned(Especificacao)     then  FreeAndNil(Especificacao);
  end;
end;

function TfrmCadastroProduto.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtProduto.Text) = '' then begin
    avisar('Favor informar a descrição da matéria');
    edtProduto.SetFocus;
  end
  else if edtValor.Value <= 0 then begin
    avisar('Favor informar o valor do produto');
    edtValor.SetFocus;
  end
  else if (ListaGrupo.Visible) and (ListaGrupo.CodCampo <= 0) then begin
      avisar('É necessário vincular o produto a um grupo');
      ListaGrupo.comListaCampo.setFocus;
  end
  else if ListaDepartamento.CodCampo <= 0 then begin
      avisar('É necessário vincular o produto a um departamento');
      ListaDepartamento.comListaCampo.setFocus;
  end
  else if (BuscaNCM1.Visible) and not assigned(BuscaNCM1.NCM) then begin
      avisar('É necessário informar o NCM do produto');
      BuscaNCM1.edtNCM.setFocus;
  end
  else if cbTipo.ItemIndex < 0 then begin
      avisar('É necessário informar o Tipo correspondente');
      cbTipo.setFocus;
  end
  else if cbTributacao.ItemIndex < 0 then begin
      avisar('É necessário informar a tributação correspondente');
      cbTipo.setFocus;
  end
  else if (ListaDepartamento.comListaCampo.Items[ListaDepartamento.comListaCampo.ItemIndex] = 'COZINHA') and
          (cbPreparo.ItemIndex < 0) then begin
      avisar('É necessário informar o preparo');
      cbPreparo.setFocus;
  end
  else if (edtUNSaida.Text = '') and (cbTipo.ItemIndex in [0,2]) then begin
      avisar('É necessário informar a unidade de saída do produto');
      edtUNSaida.setFocus;
  end
  else if (edtMultiplicador.Value = 0) and edtMultiplicador.visible then
  begin
      avisar('É necessário informar a quantidade equivalente do produto referente a unidade de entrada');
      edtMultiplicador.setFocus;
  end
  else
    result := true;
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  inherited;
  cdsMaterias.CreateDataSet;
  ListaGrupo.setValores('select * from grupos', 'Descricao', 'Grupo');
  ListaGrupo.executa;

  ListaDepartamento.setValores('select * from departamentos', 'Nome', 'Departamento');
  ListaDepartamento.executa;

  if assigned(FProdutoNfe) then begin
    btnIncluir.Click;
    cbTributacao.ItemIndex := IfThen(pos(copy(FProdutoNfe.CFOP,1,2), '54,64') > 0, 3, 1);
    edtPrecoCusto.Value    := FProdutoNfe.vUnCom;
    edtProduto.Text        := FProdutoNfe.xProd;
    BuscaNCM1.codigoNCM    := FProdutoNfe.NCM;
    edtUNEntrada.Text      := UPPERCASE(copy(FProdutoNfe.uCom,1,3));
    edtPrecoCusto.Value    := FProdutoNfe.vUnCom;
  end;
end;

procedure TfrmCadastroProduto.btnAddMateriaClick(Sender: TObject);
begin
  if BuscaMateriaPrima1.edtCodigo.Value > 0 then
    adicionaMateria(0, BuscaMateriaPrima1.MateriaPrima.codigo, BuscaMateriaPrima1.MateriaPrima.descricao, cbAdicional.ItemIndex = 0);

  BuscaMateriaPrima1.limpa;  
  BuscaMateriaPrima1.edtCodigo.SetFocus;  
end;

procedure TfrmCadastroProduto.adicionaMateria(codigo, codigo_materia :Integer; descricao :String; adicional :Boolean);
begin
  if not cdsMaterias.Locate('CODIGO_MATERIA',BuscaMateriaPrima1.edtCodigo.AsInteger,[]) then begin
    cdsMaterias.Append;
    cdsMateriasCODIGO.AsInteger         := codigo;
    cdsMateriasCODIGO_MATERIA.AsInteger := codigo_materia;
    cdsMateriasDESCRICAO.AsString       := descricao;
    cdsMateriasADICIONAL.AsString       := IfThen(adicional, 'SIM', 'NÃO');
    cdsMaterias.Post;
  end
  else begin
    avisar('Esta matéria-prima já foi adicionada');
    BuscaMateriaPrima1.limpa;
    BuscaMateriaPrima1.edtCodigo.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.gridConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsATIVO then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsATIVO.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +20, Rect.Top , 0, true)
    else
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +20, Rect.Top , 1, true);
  end;
end;

procedure TfrmCadastroProduto.gridItensCellClick(Column: TColumn);
begin
  if Column.FieldName = 'ADICIONAL' then
  begin
    cdsMaterias.Edit;
    if cdsMaterias.FieldByName('ADICIONAL').AsString = 'SIM' then
      cdsMaterias.FieldByName('ADICIONAL').AsString := 'NÃO'
    else
      cdsMaterias.FieldByName('ADICIONAL').AsString := 'SIM' ;
    cdsMaterias.Post;
  end;
end;

procedure TfrmCadastroProduto.gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Check1: Integer;
  R1: TRect;
begin
  inherited;
  {if Column.Field = cdsMateriasADICIONAL then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsMateriasADICIONAL.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +20, Rect.Top , 0, true);
  end;}

  if Column.FieldName = 'ADICIONAL' then
  begin
    gridItens.Canvas.FillRect(Rect);
    Check1 := 0;
    if cdsMaterias.FieldByName('ADICIONAL').AsString = 'SIM' then
      Check1 := DFCS_CHECKED
    else
      Check1 := 0;
    R1 := Rect;
    InflateRect(R1,-2,-2);
    DrawFrameControl(gridItens.Canvas.Handle,R1,DFC_BUTTON, DFCS_BUTTONCHECK or Check1);
  end;
end;

procedure TfrmCadastroProduto.gridItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_DELETE) and not(cdsMaterias.IsEmpty)then
    if confirma('Deseja remover a matéria prima "'+cdsMateriasDESCRICAO.AsString+'" desse produto?') then
      remove_materia;
end;

procedure TfrmCadastroProduto.remove_materia;
var repositorio :TRepositorio;
begin
  if cdsMateriasCODIGO.AsInteger > 0 then begin
    fdm.conexao.TxOptions.AutoCommit := false;

    repositorio := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
    repositorio.RemoverPorIdentificador( cdsMateriasCODIGO.AsInteger );
  end;

  cdsMaterias.Delete;
end;

procedure TfrmCadastroProduto.SetprodutoNfe(const Value: TProd);
begin
  FprodutoNfe := Value;
end;

procedure TfrmCadastroProduto.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if not fdm.conexao.TxOptions.AutoCommit then
    fdm.conexao.Commit;
end;

procedure TfrmCadastroProduto.btnCancelarClick(Sender: TObject);
begin
  if assigned(FProdutoNfe) then
    self.ModalResult := MrCancel;

  inherited;
  if not fdm.conexao.TxOptions.AutoCommit then
    fdm.conexao.Rollback;
end;

procedure TfrmCadastroProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  if not fdm.conexao.TxOptions.AutoCommit then
    fdm.conexao.TxOptions.AutoCommit := true;
end;

procedure TfrmCadastroProduto.cbTipoChange(Sender: TObject);
begin
  ListaGrupo.Visible         := (cbTipo.ItemIndex <> 1);
  BuscaNCM1.Visible          := (cbTipo.ItemIndex <> 1);
  Image1.Visible             := (cbTipo.ItemIndex <> 1);
  label5.Visible             := (cbTipo.ItemIndex <> 1);
  BuscaMateriaPrima1.Visible := (cbTipo.ItemIndex <> 1);
  gridItens.Visible          := (cbTipo.ItemIndex <> 1);
  btnAddMateria.Visible      := (cbTipo.ItemIndex <> 1);
  cbPreparo.Visible          := (cbTipo.ItemIndex <> 1);
  StaticText2.Visible        := (cbTipo.ItemIndex <> 1);
  lbAliquota.Caption         := IfThen((cbTipo.ItemIndex <> 1), 'Alíquota ICMS', 'Alíquota ISS');
  lbEstoque.Visible          := not(cbTipo.ItemIndex in [1,3]);
  edtEstoque.Visible         := not(cbTipo.ItemIndex in [1,3]);
  lbEstoqueMin.Visible       := not(cbTipo.ItemIndex in [1,3]);
  edtEstoqueMin.Visible      := not(cbTipo.ItemIndex in [1,3]);
  lbPrecoCusto.Visible       := (cbTipo.ItemIndex <> 1);
  edtPrecoCusto.Visible      := (cbTipo.ItemIndex <> 1);
  lblCodBar.Visible          := (cbTipo.ItemIndex <> 1);
  edtCodBar.Visible          := (cbTipo.ItemIndex <> 1);
  lblReferencia.Visible      := (cbTipo.ItemIndex <> 1);
  edtReferencia.Visible      := (cbTipo.ItemIndex <> 1);
  edtCodigoBalanca.Visible   := (cbTipo.ItemIndex <> 1);
  lblUnSaida.Visible         := not(cbTipo.ItemIndex in [1,3]);
  edtUNSaida.Visible         := not(cbTipo.ItemIndex in [1,3]);
  lblUnEnt.Visible           := not(cbTipo.ItemIndex in [1,3]);
  edtUNEntrada.Visible       := not(cbTipo.ItemIndex in [1,3]);
  lblMultiplicador.Visible   := not(cbTipo.ItemIndex in [1,3]);
  edtMultiplicador.Visible   := not(cbTipo.ItemIndex in [1,3]);
  cbAdicional.Visible        := (cbTipo.ItemIndex <> 1);
  lbAdicional.Visible        := (cbTipo.ItemIndex <> 1);

  lbAlteraPreco.Left         := IfThen(cbTipo.ItemIndex = 1, 224,  39);
  lbAlteraPreco.Top          := IfThen(cbTipo.ItemIndex = 1, 65,  110);
  cbAlteraPreco.Left         := IfThen(cbTipo.ItemIndex = 1, 224,  39);
  cbAlteraPreco.Top          := IfThen(cbTipo.ItemIndex = 1, 83,  128);
  listaDepartamento.Left     := IfThen(cbTipo.ItemIndex = 1, 338, 153);
  ListaDepartamento.Top      := IfThen(cbTipo.ItemIndex = 1, 62,  107);
  lbTributacao.Left          := IfThen(cbTipo.ItemIndex = 1, 225, 300);
  lbTributacao.Top           := IfThen(cbTipo.ItemIndex = 1, 117, 164);
  cbTributacao.Left          := IfThen(cbTipo.ItemIndex = 1, 224, 299);
  cbTributacao.Top           := IfThen(cbTipo.ItemIndex = 1, 135, 182);
  lbAliquota.Left            := IfThen(cbTipo.ItemIndex = 1, 357, 432);
  lbAliquota.Top             := IfThen(cbTipo.ItemIndex = 1, 117, 164);
  edtIcms.Left               := IfThen(cbTipo.ItemIndex = 1, 357, 432);
  edtICMS.Top                := IfThen(cbTipo.ItemIndex = 1, 135, 182);
  lbAtivo.Left               := IfThen(cbTipo.ItemIndex = 1, 457, 356);
  lbativo.Top                := IfThen(cbTipo.ItemIndex = 1, 117, 210);
  cbAtivo.Left               := IfThen(cbTipo.ItemIndex = 1, 457, 356);
  cbAtivo.Top                := IfThen(cbTipo.ItemIndex = 1, 135, 228);
end;

end.
