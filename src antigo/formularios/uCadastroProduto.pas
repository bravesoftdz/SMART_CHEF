unit uCadastroProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, Buttons, ExtCtrls, contnrs, frameListaCampo, Mask,
  ToolEdit, CurrEdit, Math, pngimage, frameBuscaMateriaPrima, ImgList,
  frameBuscaNCM, frameBuscaDispensa;

type
  TfrmCadastroProduto = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    cdsVALOR: TFloatField;
    cdsMaterias: TClientDataSet;
    dsMaterias: TDataSource;
    cdsMateriasCODIGO: TIntegerField;
    cdsMateriasDESCRICAO: TStringField;
    cdsMateriasCODIGO_MATERIA: TIntegerField;
    PGCinfo: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    lblRazao: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbPrecoCusto: TStaticText;
    lbEstoque: TStaticText;
    StaticText1: TStaticText;
    lbAliquota: TStaticText;
    edtProduto: TEdit;
    edtCodigo: TEdit;
    edtValor: TCurrencyEdit;
    ListaGrupo: TListaCampo;
    ListaDepartamento: TListaCampo;
    BuscaNCM1: TBuscaNCM;
    cbTipo: TComboBox;
    edtICMS: TCurrencyEdit;
    cbTributacao: TComboBox;
    StaticText2: TStaticText;
    lbEstoqueMin: TStaticText;
    cbPreparo: TComboBox;
    edtEstoque: TCurrencyEdit;
    edtEstoqueMin: TCurrencyEdit;
    cbAtivo: TComboBox;
    edtPrecoCusto: TCurrencyEdit;
    Image1: TImage;
    Label5: TLabel;
    gridItens: TDBGridCBN;
    BuscaMateriaPrima1: TBuscaMateriaPrima;
    btnAddMateria: TBitBtn;
    Image2: TImage;
    Label4: TLabel;
    BuscaDispensa1: TBuscaDispensa;
    edtQtdeBaixa: TCurrencyEdit;
    Label6: TLabel;
    btnAddDependencia: TBitBtn;
    cdsEstoqueDep: TClientDataSet;
    dsEstoqueDep: TDataSource;
    DBGridCBN1: TDBGridCBN;
    cdsEstoqueDepCODIGO: TIntegerField;
    cdsEstoqueDepCODIGO_DISPENSA: TIntegerField;
    cdsEstoqueDepDESCRICAO: TStringField;
    cdsEstoqueDepQTDE_BAIXA: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btnAddMateriaClick(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure DBGridCBN1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddDependenciaClick(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarAntesAlterar;                    override;
    procedure ExecutarAntesIncluir;                    override;
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
    procedure adicionaMateria(codigo, codigo_materia :Integer; descricao :String);
    procedure remove_materia;

    procedure adicionaDispensa(codigo, codigo_dispensa :Integer; descricao :String; qtde_baixa :Double);
    procedure remove_dependencia;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

uses Produto, repositorio, fabricarepositorio, StrUtils, uPadrao, ProdutoDependenciaEst,
  MateriaPrima, ProdutoHasMateria, NcmIBPT, Estoque, EspecificacaoEstoquePorProduto, Dispensa;

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.AlterarRegistroNoCDS(Registro: TObject);
var
  Produto :TProduto;
begin
  inherited;

  Produto := (Registro as TProduto);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger   := Produto.codigo;
  self.cdsDESCRICAO.AsString := Produto.descricao;
  self.cdsVALOR.AsFloat      := Produto.valor;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.CarregarDados;
var
  Produtos    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Produtos    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produtos    := Repositorio.GetAll;

    if Assigned(Produtos) and (Produtos.Count > 0) then begin

       for nX := 0 to (Produtos.Count-1) do
         self.IncluirRegistroNoCDS(Produtos.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Produtos);
  end;
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
  ProdutoDependencia :TProdutoDependenciaEst;
  Estoque            :TEstoque;
  Especificacao      :TEspecificacaoEstoquePorProduto;
begin
   Produto       := nil;
   Repositorio   := nil;
   Estoque       := nil;
   Especificacao := nil;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
     Produto     := TProduto(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Produto) then
      Produto := TProduto.Create;

     if ListaGrupo.CodCampo > 0 then
       Produto.codigo_grupo        := ListaGrupo.CodCampo;
       
     Produto.descricao           := self.edtProduto.Text;
     Produto.valor               := self.edtValor.Value;
     Produto.ativo               := copy(cbAtivo.Items[cbAtivo.ItemIndex],1,1);
     Produto.codigo_departamento := ListaDepartamento.CodCampo;
     Produto.icms                := edtICMS.Value;
     Produto.preco_custo         := edtPrecoCusto.Value; 

     if assigned(BuscaNCM1.NCM) then
       Produto.codigo_ibpt         := BuscaNCM1.NCM.codigo;

     Produto.tipo                := copy(cbTipo.Items[cbTipo.itemIndex],1,1);

     case cbTributacao.ItemIndex of
       0 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'T','S');
       1 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'II','SI');
       2 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'NN','SN');
       3 : Produto.tributacao := IfThen(cbTipo.ItemIndex = 0,'FF','SF');
     end;

     Produto.preparo := cbPreparo.Items[ cbPreparo.itemIndex ];

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

          Repositorio.Salvar( ProdutoHasMateria );

          if cdsMateriasCODIGO.AsInteger = 0 then
            ProdutoHasMateria.codigo := 0;

          if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
            Repositorio.Salvar_2( ProdutoHasMateria);

          cdsMaterias.Next;
        end;

     end;

     { * * * SALVA DEPENDÊNCIA DE ESTOQUE DO PRODUTO * * * }

     if not cdsEstoqueDep.IsEmpty then begin

        Repositorio          := TFabricaRepositorio.GetRepositorio(TProdutoDependenciaEst.ClassName);

        cdsMaterias.First;
        while not cdsEstoqueDep.Eof do begin
          ProdutoDependencia    := TProdutoDependenciaEst(repositorio.Get( cdsEstoqueDepCODIGO.AsInteger ));

          if not assigned(ProdutoDependencia) then
            ProdutoDependencia := TProdutoDependenciaEst.Create;

          ProdutoDependencia.codigo_produto   := Produto.codigo;
          ProdutoDependencia.codigo_dispensa  := cdsEstoqueDepCODIGO_DISPENSA.AsInteger;
          ProdutoDependencia.quantidade_baixa := cdsEstoqueDepQTDE_BAIXA.AsFloat;

          Repositorio.Salvar( ProdutoDependencia );

          if cdsEstoqueDepCODIGO.AsInteger = 0 then
            ProdutoDependencia.codigo := 0;

          if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
            Repositorio.Salvar_2( ProdutoDependencia);

          cdsEstoqueDep.Next;
        end;

     end;

     { * * * SALVA ESTOQUE DO PRODUTO * * * }

     if (edtEstoque.Value > 0) or (edtEstoqueMin.Value > 0) then begin

        Especificacao        := TEspecificacaoEstoquePorProduto.Create(Produto);
        Repositorio          := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
        Estoque              := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

        if not assigned( Estoque ) then
          Estoque := TEstoque.Create;

        Estoque.codigo_produto := Produto.codigo;
      //  Estoque.quantidade     := edtEstoque.Value;
        Estoque.unidade_medida := 'UN';
        Estoque.pecas          := 1;
        Estoque.quantidade_min := edtEstoqueMin.Value;

        Repositorio.Salvar(Estoque);  

     end;

     result := Produto;

   finally
     FreeAndNil(Repositorio);
     if assigned(ProdutoHasMateria) then  FreeAndNil(ProdutoHasMateria);
     if assigned(ProdutoDependencia) then  FreeAndNil(ProdutoDependencia);
     if assigned(Estoque)           then  FreeAndNil(Estoque);
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
  self.cdsCODIGO.AsInteger   := Produto.codigo;
  self.cdsDESCRICAO.AsString := Produto.descricao;
  self.cdsVALOR.AsFloat      := Produto.valor;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtProduto.Clear;
  edtValor.Clear;
  cbAtivo.ItemIndex := 0;
  ListaGrupo.comListaCampo.ItemIndex := -1;
  ListaDepartamento.comListaCampo.ItemIndex := -1;
  cdsMaterias.EmptyDataSet;
  BuscaMateriaPrima1.limpa;
  edtQtdeBaixa.Clear;
  cdsEstoqueDep.EmptyDataSet;
  BuscaDispensa1.limpa;
  BuscaNCM1.limpa;
  cbTipo.ItemIndex       := -1;
  edtICMS.Clear;
  cbTributacao.ItemIndex := -1;
  cbPreparo.ItemIndex    := -1;
  edtPrecoCusto.Clear;
  edtEstoque.Clear;
  edtEstoqueMin.Clear;
end;

procedure TfrmCadastroProduto.MostrarDados;
var
  Produto                              :TProduto;
  RepositorioProduto                   :TRepositorio;
  Especificacao                        :TEspecificacaoEstoquePorProduto;
  Estoque                              :TEstoque;
  i :integer;
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
    self.cbAtivo.ItemIndex          := cbAtivo.Items.IndexOf( IfThen(Produto.ativo = 'N','NÃO', 'SIM') );
    self.ListaDepartamento.CodCampo := Produto.codigo_departamento;
    self.BuscaNCM1.codigo           := Produto.codigo_ibpt;
    self.cbTipo.ItemIndex           := cbTipo.Items.IndexOf( IfThen(Produto.tipo = 'S', 'SERVIÇO', 'PRODUTO') );
    cbTipoChange(nil);
    self.edtICMS.Value              := Produto.icms;
    self.cbPreparo.ItemIndex        := cbPreparo.Items.IndexOf(Produto.preparo);
    self.edtPrecoCusto.Value        := Produto.preco_custo;

    case AnsiIndexStr(UpperCase(Produto.tributacao), ['T', 'II','NN','FF','S','SI','SN','SF']) of
     0,4 : cbTributacao.ItemIndex := 0;
     1,5 : cbTributacao.ItemIndex := 1;
     2,6 : cbTributacao.ItemIndex := 2;
     3,7 : cbTributacao.ItemIndex := 3;
    end;

    if assigned(Produto.ListaMaterias) then
      for i := 0 to Produto.ListaMaterias.Count - 1 do begin

        adicionaMateria(TProdutoHasMateria(Produto.ListaMaterias.Items[i]).codigo,
                        TMateriaPrima(TProdutoHasMateria(Produto.ListaMaterias.Items[i]).materia_prima).codigo,
                        TMateriaPrima(TProdutoHasMateria(Produto.ListaMaterias.Items[i]).materia_prima).descricao);
      end;

    if assigned(Produto.ListaDispensa) then
      for i := 0 to Produto.ListaDispensa.Count - 1 do begin

        adicionaDispensa(TProdutoDependenciaEst(Produto.ListaDispensa.Items[i]).codigo,
                         TDispensa(TProdutoDependenciaEst(Produto.ListaDispensa.Items[i]).dispensa).codigo,
                         TDispensa(TProdutoDependenciaEst(Produto.ListaDispensa.Items[i]).dispensa).descricao_item,
                         TProdutoDependenciaEst(Produto.ListaDispensa.Items[i]).quantidade_baixa);
      end;

    Especificacao      := TEspecificacaoEstoquePorProduto.Create(Produto);
    RepositorioProduto := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
    Estoque            := TEstoque( RepositorioProduto.GetPorEspecificacao( Especificacao ) );

    if not assigned( Estoque ) then
      Exit;

    edtEstoque.Value           := Estoque.quantidade;
    edtEstoqueMin.Value        := Estoque.quantidade_min;

  finally
     FreeAndNil(RepositorioProduto);
     FreeAndNil(Produto);
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
  else
    result := true;
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  inherited;
  ListaGrupo.setValores('select * from grupos', 'Descricao', 'Grupo');
  ListaGrupo.executa;

  ListaDepartamento.setValores('select * from departamentos', 'Nome', 'Departamento');
  ListaDepartamento.executa;

  cdsMaterias.CreateDataSet;
  cdsEstoqueDep.CreateDataSet;
end;

procedure TfrmCadastroProduto.btnAddMateriaClick(Sender: TObject);
begin
  if BuscaMateriaPrima1.edtCodigo.Value > 0 then
    adicionaMateria(0, BuscaMateriaPrima1.MateriaPrima.codigo, BuscaMateriaPrima1.MateriaPrima.descricao);

  BuscaMateriaPrima1.limpa;
  BuscaMateriaPrima1.edtCodigo.SetFocus;
end;

procedure TfrmCadastroProduto.adicionaMateria(codigo, codigo_materia :Integer; descricao :String);
begin
  if not cdsMaterias.Locate('CODIGO_MATERIA',BuscaMateriaPrima1.edtCodigo.AsInteger,[]) then begin
    cdsMaterias.Append;
    cdsMateriasCODIGO.AsInteger         := codigo;
    cdsMateriasCODIGO_MATERIA.AsInteger := codigo_materia;
    cdsMateriasDESCRICAO.AsString       := descricao;
    cdsMaterias.Post;
  end
  else begin
    avisar('Esta matéria-prima já foi adicionada');
    BuscaMateriaPrima1.limpa;
    BuscaMateriaPrima1.edtCodigo.SetFocus;
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
    fdm.conexao.AutoCommit := false;

    repositorio := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
    repositorio.RemoverPorIdentificador( cdsMateriasCODIGO.AsInteger );
  end;

  cdsMaterias.Delete;
end;

procedure TfrmCadastroProduto.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if not fdm.conexao.AutoCommit then
    fdm.conexao.Commit;
end;

procedure TfrmCadastroProduto.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if not fdm.conexao.AutoCommit then
    fdm.conexao.Rollback;
end;

procedure TfrmCadastroProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  if not fdm.conexao.AutoCommit then
    fdm.conexao.AutoCommit := true;
end;

procedure TfrmCadastroProduto.cbTipoChange(Sender: TObject);
begin
  ListaGrupo.Visible         := (cbTipo.ItemIndex <> 1);
 // BuscaNCM1.Visible          := (cbTipo.ItemIndex <> 1);
  Image1.Visible             := (cbTipo.ItemIndex <> 1);
  label5.Visible             := (cbTipo.ItemIndex <> 1);
  BuscaMateriaPrima1.Visible := (cbTipo.ItemIndex <> 1);
  gridItens.Visible          := (cbTipo.ItemIndex <> 1);
  btnAddMateria.Visible      := (cbTipo.ItemIndex <> 1);
  cbPreparo.Visible          := (cbTipo.ItemIndex <> 1);
  StaticText2.Visible        := (cbTipo.ItemIndex <> 1);
  lbAliquota.Caption         := IfThen((cbTipo.ItemIndex <> 1), 'Alíquota ICMS', 'Alíquota ISS');
  lbEstoque.Visible          := (cbTipo.ItemIndex <> 1);
  edtEstoque.Visible         := (cbTipo.ItemIndex <> 1);
  lbEstoqueMin.Visible       := (cbTipo.ItemIndex <> 1);
  edtEstoqueMin.Visible      := (cbTipo.ItemIndex <> 1);
  lbPrecoCusto.Visible       := (cbTipo.ItemIndex <> 1);
  edtPrecoCusto.Visible      := (cbTipo.ItemIndex <> 1);
end;

procedure TfrmCadastroProduto.DBGridCBN1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_DELETE) and not(cdsMaterias.IsEmpty)then
    if confirma('Deseja remover o item "'+cdsEstoqueDepDESCRICAO.AsString+'" da dependência de estoque desse produto?') then
      remove_dependencia;
end;

procedure TfrmCadastroProduto.remove_dependencia;
var repositorio :TRepositorio;
begin
  if cdsEstoqueDepCODIGO.AsInteger > 0 then begin
    fdm.conexao.AutoCommit := false;

    repositorio := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
    repositorio.RemoverPorIdentificador( cdsMateriasCODIGO.AsInteger );
  end;

  cdsMaterias.Delete;
end;

procedure TfrmCadastroProduto.adicionaDispensa(codigo, codigo_dispensa: Integer; descricao: String; qtde_baixa: Double);
begin
  if not cdsEstoqueDep.Locate('CODIGO_DISPENSA',BuscaDispensa1.edtCodigo.AsInteger,[]) then begin
    cdsEstoqueDep.Append;
    cdsEstoqueDepCODIGO.AsInteger          := codigo;
    cdsEstoqueDepCODIGO_DISPENSA.AsInteger := codigo_dispensa;
    cdsEstoqueDepDESCRICAO.AsString        := descricao;
    cdsEstoqueDepQTDE_BAIXA.AsFloat        := qtde_baixa;
    cdsEstoqueDep.Post;
  end
  else begin
    avisar('Este item da dispensa já foi adicionado');
    BuscaDispensa1.limpa;
    BuscaDispensa1.edtCodigo.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.btnAddDependenciaClick(Sender: TObject);
begin
  if BuscaDispensa1.edtCodigo.Value > 0 then
    adicionaDispensa(0, BuscaDispensa1.Dispensa.codigo, BuscaDispensa1.Dispensa.descricao_item, edtQtdeBaixa.Value);

  BuscaDispensa1.limpa;
  BuscaDispensa1.edtCodigo.SetFocus;
end;

procedure TfrmCadastroProduto.ExecutarAntesAlterar;
begin
  inherited;
  PGCinfo.ActivePageIndex := 0;
end;

procedure TfrmCadastroProduto.ExecutarAntesIncluir;
begin
  inherited;
  PGCinfo.ActivePageIndex := 0;
end;

end.


