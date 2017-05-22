unit uInicial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, Menus, StdCtrls, AppEvnts, Buttons, TLHelp32,
  jpeg, ExtCtrls, pngimage, RxNotify, xmldom, XMLIntf, msxmldom, XMLDoc, Contnrs, CriaBalaoInformacao,
  frameBotaoImg, ScktComp, ACBrBase, ACBrDevice, StringUtilitario, Shellapi,
  DB, Grids, DBGrids, DBClient, Printers,
  ZDataset, DBCtrls, XPMan, uReimpressaoPedido, generics.collections;

type
  TfrmInicial = class(TfrmPadrao)
    Menu: TMainMenu;
    Cadastros1: TMenuItem;
    Perfisdeacesso1: TMenuItem;
    Usurios1: TMenuItem;
    Grupos1: TMenuItem;
    Matriasprimas1: TMenuItem;
    Produto1: TMenuItem;
    Vendas1: TMenuItem;
    CriarPedido1: TMenuItem;
    Empresa1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Image1: TImage;
    Caixa1: TMenuItem;
    AbrirFechar1: TMenuItem;
    Image2: TImage;
    RxFolderMonitor1: TRxFolderMonitor;
    vXMLDoc: TXMLDocument;
    edtinforma: TEdit;
    Departamentos1: TMenuItem;
    Label1: TLabel;
    Image4: TImage;
    Servidor: TServerSocket;
    Cliente: TClientSocket;
    ConfigurarNFCE1: TMenuItem;
    Label2: TLabel;
    lbUsuario: TLabel;
    Label3: TLabel;
    lbDepartamento: TLabel;
    RxFolderMonitor2: TRxFolderMonitor;
    Timer1: TTimer;
    imgReinicia: TImage;
    Reinicia: TLabel;
    Relatrios1: TMenuItem;
    Vendas2: TMenuItem;
    SuporteTcnico1: TMenuItem;
    timerdesliga: TTimer;
    Visualizarpedidosemaberto1: TMenuItem;
    Comandas1: TMenuItem;
    cdsConexoes: TClientDataSet;
    dsConexoes: TDataSource;
    gridConexoes: TDBGrid;
    cdsConexoesHANDLE: TIntegerField;
    cdsConexoesIP: TStringField;
    ItensDispensa1: TMenuItem;
    Movimento1: TMenuItem;
    EntradaSada1: TMenuItem;
    Atendimentos1: TMenuItem;
    Utilitrios1: TMenuItem;
    Verificaarqbolichependente1: TMenuItem;
    Pedidos1: TMenuItem;
    Estoque1: TMenuItem;
    EntradaeSada1: TMenuItem;
    Caixa48colunas1: TMenuItem;
    ItensDeletados1: TMenuItem;
    NFCE1: TMenuItem;
    btnTeste: TButton;
    Visualizaremitidas1: TMenuItem;
    Configuraoes1: TMenuItem;
    Label4: TLabel;
    lbVersaoSistema: TLabel;
    Label5: TLabel;
    lbVersaoBd: TLabel;
    Button1: TButton;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    XPManifest1: TXPManifest;
    CuponsFiscais1: TMenuItem;
    SuporteTcnico2: TMenuItem;
    Reimpressodopedido1: TMenuItem;
    BotaoImgPedidos: TBotaoImg;
    BotaoImgCaixa: TBotaoImg;
    Fornecedores1: TMenuItem;
    CFOPscorrespondentes1: TMenuItem;
    SangriaeReforo1: TMenuItem;
    NotasFiscaisEntrada1: TMenuItem;
    NFe1: TMenuItem;
    ransportadora1: TMenuItem;
    Entradadenotasfiscais1: TMenuItem;
    EntradaporXML1: TMenuItem;
    ConfirmaoEntradaEstoque1: TMenuItem;
    Extorno1: TMenuItem;
    NCM1: TMenuItem;
    procedure Perfisdeacesso1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Grupos1Click(Sender: TObject);
    procedure Matriasprimas1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure CriarPedido1Click(Sender: TObject);
    procedure Empresa1Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure AbrirFechar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxFolderMonitor1Change(Sender: TObject);
    procedure Departamentos1Click(Sender: TObject);
    procedure ClienteRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure pedidosMouseEnter(Sender: TObject);
    procedure pedidosMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ConfigurarNFCE1Click(Sender: TObject);
    procedure ServidorClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure RxFolderMonitor2Change(Sender: TObject);
    procedure ClienteError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure ReiniciaClick(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure timerdesligaTimer(Sender: TObject);
    procedure Visualizarpedidosemaberto1Click(Sender: TObject);
    procedure Comandas1Click(Sender: TObject);
    procedure ServidorClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ClienteDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServidorClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServidorClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ItensDispensa1Click(Sender: TObject);
    procedure EntradaSada1Click(Sender: TObject);
    procedure Atendimentos1Click(Sender: TObject);
    procedure Verificaarqbolichependente1Click(Sender: TObject);
    procedure Pedidos1Click(Sender: TObject);
    procedure Estoque1Click(Sender: TObject);
    procedure EntradaeSada1Click(Sender: TObject);
    procedure Caixa48colunas1Click(Sender: TObject);
    procedure ItensDeletados1Click(Sender: TObject);
    procedure Visualizaremitidas1Click(Sender: TObject);
    procedure Configuraoes1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure CuponsFiscais1Click(Sender: TObject);
    procedure SuporteTcnico2Click(Sender: TObject);
    procedure Reimpressodopedido1Click(Sender: TObject);
    procedure BotaoImg1Label1Click(Sender: TObject);
    procedure BotaoImgCaixaLabel1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure CFOPscorrespondentes1Click(Sender: TObject);
    procedure SangriaeReforo1Click(Sender: TObject);
    procedure NotasFiscaisEntrada1Click(Sender: TObject);
    procedure NFe1Click(Sender: TObject);
    procedure ransportadora1Click(Sender: TObject);
    procedure EntradaporXML1Click(Sender: TObject);
    procedure ConfirmaoEntradaEstoque1Click(Sender: TObject);
    procedure Extorno1Click(Sender: TObject);
    procedure NCM1Click(Sender: TObject);

  private
    procedure SalvaPedido;
    procedure SalvaBoliche;

    function comanda_bloqueada(codigo_comanda, codigo_mesa :String) :Boolean;
    function GetFileListForExt(const Path, extensao: string): TStringList;

    procedure DeletaInseridos(Lista :TStringList; Diretorio, arquivos_com_erro :String);
    procedure imprime(codigo_pedido :integer);
    procedure Mostra_pendentes;
    procedure verifica_pendencia;
    procedure avisa_clientes;
    procedure avisa_caixa(mesa, comanda, motivo :String);
    procedure EncerraTerminal;
    procedure informar_erro(msg_erro :String);
    procedure nack_para_txt(nome_arquivo :String);
    procedure salva_lancamento_invalido(arquivo :String; codigo_comanda: integer);
    Procedure SetDefaultPrinter(PrinterName: String);

  public
    procedure imprime_no_departamento(codigo_pedido :Integer);
    procedure verificaNFCesContingencia;
    
  end;

var
  frmInicial: TfrmInicial;

implementation

uses uCadastroPerfilAcesso, PermissoesAcesso, uCadastroUsuario, uCadastroGrupo, uCadastroMateriaPrima,
     uCadastroProduto, uPedido, Math, uCadastroEmpresa, uCaixa, Repositorio, FabricaRepositorio, uMonitorControleNFe,
     EspecificacaoPedidoAbertoDaComanda, Pedido, Item, AdicionalItem, Empresa, uCadastroDepartamento,
     RepositorioPedido, uAvisoPedidoPendente, EspecificacaoPedidosComItemNaoImpresso, uNFCesContingencia,
     ParametrosNFCe, uModulo, StrUtils, MateriaPrima, EspecificacaoCaixaPorData, Caixa, uCadastroComanda,
     Usuario, Departamento, DateTimeUtilitario, uRelatorioVendas, uSuporteTecnico, uPedidos, Comanda,
     uCadastroDispensa, uEntradaSaidaMercadoria, Produto, uRelatorioAtendimentos, uRelatorioPedidos, uRelatorioEstoque,
     uRelatorioEntradaSaida, uRelatorioCaixa48Colunas, uRelatorioItensDeletados, uConfiguraNFCe, uNFCes, uCadastroFornecedor,
     uConfiguracoesSistema, uCadastroCliente, uRelatorioProdutos, funcoes, uRelatorioCuponsFiscais, uImpressaoPedido,
     uEntradaNota, uCadastroCfopCorrespondente, uLancaSangriaReforco, uConfirmaEntrada, uSupervisor, uRelatorioNotasFiscaisEntrada,
     uCadastroTransportadora, uEstornoEntrada, uCadastroNCMIBPT;

{$R *.dfm}

procedure TfrmInicial.Perfisdeacesso1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroPerfilAcesso, paCadastroPerfil);
end;

procedure TfrmInicial.Usurios1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroUsuario, paCadastroUsuario);
end;

procedure TfrmInicial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned(frmAvisoPedidoPendente) then
    FreeAndNil( frmAvisoPedidoPendente );

  if not confirma('Deseja realmente sair do sistema?') then
    abort;
end;

procedure TfrmInicial.Grupos1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroGrupo, paCadastroUsuario);
end;

procedure TfrmInicial.Matriasprimas1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroMateriaPrima, paCadastroMateriaPrima);
end;

procedure TfrmInicial.Produto1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroProduto, paCadastroProduto);
end;

procedure TfrmInicial.CriarPedido1Click(Sender: TObject);
var
  ConfiguracaoNFCe :TParametrosNFCe;
  Repositorio      :TRepositorio;
begin
  inherited;
  verificaNFCesContingencia;
  ConfiguracaoNFCe  := nil;
  Repositorio       := nil;

  if not (dm.Caixa_esta_aberto) and (Time > StrToTime('04:00:00')) then begin
    avisar('ATENÇÃO! Para ter acesso a tela de vendas, é necessário abrir o caixa.');
    Exit;
  end;

  try
    Repositorio       := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
    ConfiguracaoNFCe  := TParametrosNFCe(Repositorio.Get(1));

    if Assigned(ConfiguracaoNFCe) then
       AbreForm(TfrmPedido, paCriaPedido)
    else
      avisar('Antes de acessar a tela de venda, favor configurar os dados da NFC-e.'+#13#10+
             '[ Menu: Vendas > Configurar NFC-e ]');

  finally
    FreeAndNil(ConfiguracaoNFCe);
    FreeAndNil(Repositorio);
  end;
end;

procedure TfrmInicial.Empresa1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroEmpresa, paDadosEmpresa);
end;

procedure TfrmInicial.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  i: SmallInt;
begin
     if Msg.message = WM_MOUSEWHEEL then
     begin
          Msg.message := WM_KEYDOWN;
          Msg.lParam := 0;
          i := HiWord(Msg.wParam) ;
          if i > 0 then
             Msg.wParam := VK_UP
          else
              Msg.wParam := VK_DOWN;
          Handled := False;
     end;
end;

procedure TfrmInicial.AbrirFechar1Click(Sender: TObject);
begin
   AbreForm(TfrmCaixa, paOperaCaixa);
end;

procedure TfrmInicial.FormShow(Sender: TObject);
begin
  lbUsuario.Caption       := dm.UsuarioLogado.Nome;
  lbDepartamento.Caption  := dm.UsuarioLogado.Departamento.nome;
  lbDepartamento.Left     := lbUsuario.Left;
  Utilitrios1.Visible     := dm.Configuracoes.possui_boliche;
  lbVersaoSistema.Caption := IntToStr(dm.Versao_Sistema);
  lbVersaoBd.Caption      := IntToStr(dm.Versao_BD);  

  pnlPropaganda.Visible       := false;

//  if not dm.Configuracoes.possui_boliche then
 //   Exit;

  if not DirectoryExists(ExtractFilePath(Application.ExeName)+'\Pedidos') then begin
    Cliente.Open;

    verifica_pendencia;
    Cliente.Socket.SendText('SALVABOLICHE');
  end
  else begin
    Servidor.Active             := true;
//    gridConexoes.Visible        := true;
    RxFolderMonitor1.FolderName := ExtractFilePath(Application.ExeName)+'Pedidos\';
    RxFolderMonitor1.Active     := true;

    RxFolderMonitor2.FolderName := dm.Empresa.diretorio_boliche;

    RxFolderMonitor2.Active     := true;
  end;
end;

procedure TfrmInicial.Fornecedores1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroFornecedor, paCadastroFornecedor);
end;

procedure TfrmInicial.RxFolderMonitor1Change(Sender: TObject);
begin
  SalvaPedido;
end;

procedure TfrmInicial.SalvaPedido;

  function GetFileList(const Path, arquivos_com_erro: string): TStringList;
  var
    I: Integer;
    SearchRec: TSearchRec;
  begin
    Result := TStringList.Create;
    try
      I := FindFirst(Path+'*.xml', 0, SearchRec);
      while I = 0 do
      begin
        if pos(SearchRec.Name , arquivos_com_erro) = 0 then
          Result.Add(SearchRec.Name);

        I := FindNext(SearchRec);
      end;

      if Result.Count <= 0 then begin
        Result.Free;
        Result := nil;
      end;

    except
      Result.Free;
      raise;
    end;
  end;

var
  ListaArquivos : TStringList;
  Corpo, NoItem, NoAdicional : IXMLNode;
  i, x, j       : integer;
  Repositorio   : TRepositorio;
  Especificacao : TEspecificacaoPedidoAbertoDaComanda;
  Pedido        : TPedido;
  Item          : TItem;
  Adicional     : TAdicionalItem;
  hora          : TTime;
  arquivos_com_erro :String;
  codigo_cliente :String;
begin
  if fdm.conexao.InTransaction then
    fdm.conexao.Commit;

  fdm.conexao.TxOptions.AutoCommit := false;
  try
  try
    RxFolderMonitor1.Active := false;

    Repositorio       := nil;
    Especificacao     := nil;
    Pedido            := nil;
    arquivos_com_erro := '';

    ListaArquivos := GetFileList( RxFolderMonitor1.FolderName, '');

    if not assigned(ListaArquivos) or (ListaArquivos.Count <= 0) then
      Exit;

    for i := 0 to ListaArquivos.Count - 1 do begin

      try
         if TStringUtilitario.TamanhoArquivo(ExtractFilePath(Application.ExeName)+'Pedidos\' + ListaArquivos[i]) = 0 then
           continue;

         vXMLDoc.LoadFromFile( ExtractFilePath(Application.ExeName)+'Pedidos\' + ListaArquivos[i] );

         if (StrToIntDef(vXMLDoc.DocumentElement.ChildNodes['codigo_comanda'].Text, 0) > 0)
          and comanda_bloqueada( vXMLDoc.DocumentElement.ChildNodes['codigo_comanda'].Text,
                                 vXMLDoc.DocumentElement.ChildNodes['codigo_mesa'].text    ) then
           continue;

         Especificacao     := TEspecificacaoPedidoAbertoDaComanda.Create( StrToInt(vXMLDoc.DocumentElement.ChildNodes['codigo_comanda'].Text) );
         Repositorio       := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
         Pedido            := TPedido( Repositorio.GetPorEspecificacao( Especificacao, 'CODIGO_COMANDA = '+vXMLDoc.DocumentElement.ChildNodes['codigo_comanda'].Text) );

         if not assigned(Pedido) then begin
           Pedido       := TPedido.Create;
           Pedido.Itens := TObjectList<TItem>.Create;
           Pedido.data  := StrToDateTime(vXMLDoc.DocumentElement.ChildNodes['data'].text);
         end;

         {remove o couvert e a taxa de serviço para voltar ao val
         or dos itens}
         Pedido.valor_total    := Pedido.valor_total - Pedido.couvert - Pedido.taxa_servico;
         {soma o valor dos novos itens para chegar ao novo valor total}
         Pedido.valor_total    := Pedido.valor_total + StrToFloat(StringReplace(vXMLDoc.DocumentElement.ChildNodes['valor_total'].text,'.',',',[]));
         {calcula o valor do couvert e da taxa de serviço, a partir do novo valor total}
         Pedido.couvert        := dm.Empresa.Valor_couvert;

         Pedido.codigo_comanda  := StrToIntDef(vXMLDoc.DocumentElement.ChildNodes['codigo_comanda'].Text, 0);
         Pedido.codigo_mesa     := StrToInt(vXMLDoc.DocumentElement.ChildNodes['codigo_mesa'].text);
         Pedido.desconto        := StrToFloat(StringReplace(vXMLDoc.DocumentElement.ChildNodes['desconto'].text,'.',',',[]));
         Pedido.acrescimo       := StrToFloat(StringReplace(vXMLDoc.DocumentElement.ChildNodes['acrescimo'].text,'.',',',[]));
         Pedido.situacao        := 'A';
         Pedido.observacoes     := vXMLDoc.DocumentElement.ChildNodes['observacoes'].text;

         Pedido.Codigo_endereco := StrToIntDef(vXMLDoc.DocumentElement.ChildNodes['codigo_endereco'].Text,0);

         {se tiver endereço, tem cliente}
         if Pedido.Codigo_endereco > 0 then begin
           codigo_cliente         := Campo_por_campo('ENDERECOS', 'CODIGO_CLIENTE', 'CODIGO', IntToStr(Pedido.Codigo_endereco));
           Pedido.cpf_cliente     := Campo_por_campo('PESSOAS', 'CPF_CNPJ', 'CODIGO', codigo_cliente);

           if Pedido.codigo_comanda = 0 then
             PEdido.taxa_entrega := dm.Empresa.taxa_entrega;
         end;

         Pedido.valor_pago      := StrToFloatDef(StringReplace(vXMLDoc.DocumentElement.ChildNodes['valor_pago'].text,'.',',',[]),0);

         if vXMLDoc.DocumentElement.ChildNodes['nome_cliente'].Text <> '' then
           Pedido.nome_cliente   := vXMLDoc.DocumentElement.ChildNodes['nome_cliente'].Text;

         if vXMLDoc.DocumentElement.ChildNodes['telefone_cliente'].Text <> '' then
           Pedido.telefone       := vXMLDoc.DocumentElement.ChildNodes['telefone_cliente'].Text;

         Pedido.Itens;        
         Corpo := vXMLDoc.DocumentElement.ChildNodes.FindNode('itens');

         hora := time;

         for x := 0 to Corpo.ChildNodes.Count - 1 do begin

             NoItem := Corpo.ChildNodes[x];
             Item   := TItem.Create;

             Item.codigo_produto := StrToInt(NoItem.ChildNodes['codigo_produto'].text);
             Item.quantidade     := StrToFloat(StringReplace(NoItem.ChildNodes['quantidade'].text,'.',',',[]));
             Item.valor_Unitario := StrToFloat(StringReplace(NoItem.ChildNodes['valor'].text,'.',',',[]));
             Item.hora           := hora;
             Item.codigo_usuario := StrToInt(NoItem.ChildNodes['codigo_usuario'].text);
             //Item.impresso       := IfThen(Item.Produto.tipo = 'S', 'S', '');

             NoItem := NoItem.ChildNodes.FindNode('adicionais');

             if assigned(NoItem) then begin
               Item.Adicionais := TObjectList<TAdicionalItem>.Create;

               for j := 0 to NoItem.ChildNodes.Count - 1 do begin

                  NoAdicional := NoItem.ChildNodes[j];
                  Adicional   := TAdicionalItem.Create;

                  Adicional.codigo_materia := StrToInt(NoAdicional.ChildNodes['codigo_materia'].text);
                  Adicional.quantidade     := StrToInt(NoAdicional.ChildNodes['quantidade'].text);
                  Adicional.flag           := NoAdicional.ChildNodes['flag'].text;
                  Adicional.valor_unitario := StrToFloat(StringReplace(NoAdicional.ChildNodes['valor'].text,'.',',',[]));

                  Item.Adicionais.Add( Adicional );
               end;
             end;

             if not assigned(Pedido.Itens) then
               Pedido.Itens := TObjectList<TItem>.create;

             Pedido.Itens.Add( Item );

         end; //fim FOR itens

         Pedido.taxa_servico   := (Pedido.Total_produtos * dm.empresa.Taxa_servico)/100;
         Pedido.valor_total    := Pedido.valor_total + pedido.couvert + pedido.taxa_servico;

         Repositorio.Salvar(Pedido);

         {Salva os itens enviados, que foram inseridos no BD}
         if not fdm.conexao.TxOptions.AutoCommit then
           fdm.conexao.Commit;                           

         { envia comando de impressão, via socket, para os clientes(departamentos) }
         imprime_no_departamento(Pedido.codigo);

      Except
        On E: Exception do begin
          arquivos_com_erro := arquivos_com_erro + ListaArquivos[i]+', ';
          fdm.LogErros.AdicionaErro('uInicial','',e.Message);
        end;
      end;

    end; //fim FOR arquivos


    { Deleta xml's da pasta }
    DeletaInseridos(ListaArquivos, ExtractFilePath(Application.ExeName)+'Pedidos\', arquivos_com_erro);

    fdm.conexao.TxOptions.AutoCommit := true;

    { Se durante a execução, um novo item for pedido, o procedimento é novamente executado }
    if assigned( GetFileList( RxFolderMonitor1.FolderName, arquivos_com_erro ) ) then
      self.SalvaPedido;

    if (ListaArquivos.Count = 1) and (arquivos_com_erro = '') then
      TCriaBalaoInformacao.ShowBalloonTip(edtinforma.Handle, 'Novo pedido foi inserido...', 'Informação', 1)
    else if ListaArquivos.Count > 1 then
      TCriaBalaoInformacao.ShowBalloonTip(edtinforma.Handle, 'Novos pedidos foram inseridos...', 'Informação', 1);

    if arquivos_com_erro <> '' then
      informar_erro('ATENÇÃO! Ocorreu um erro ao salvar os seguintes pedidos'+#13#10+'Arquivos: '+arquivos_com_erro);

  Except
    On E: Exception do begin
      informar_erro('ATENÇÃO! Ocorreu um erro ao salvar os itens recebidos'+#13#10+'Erro ocorrido: '+e.Message);

      if not fdm.conexao.TxOptions.AutoCommit then fdm.conexao.Rollback;
    end;
  end;

  Finally
    if fdm.conexao.InTransaction then
      fdm.conexao.Commit;

    if not fdm.conexao.TxOptions.AutoCommit then
      fdm.conexao.TxOptions.AutoCommit := true;

    RxFolderMonitor1.Active := true;
    FreeAndNil(Repositorio);
    FreeAndNil(Especificacao);
    FreeAndNil(Pedido);
    FreeAndNil(ListaArquivos);
  end;
end;

procedure TfrmInicial.DeletaInseridos(Lista: TStringList; Diretorio, arquivos_com_erro :String);
var
  i :integer;
begin
  for i := 0 to Lista.Count -1 do begin

    if pos(Lista[i] , arquivos_com_erro) = 0 then
      DeleteFile(Diretorio+Lista[i]);

  end;
end;

procedure TfrmInicial.Departamentos1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroDepartamento, paCadastroDepartamento);
end;

procedure TfrmInicial.Mostra_pendentes;
begin
  self.Enabled       := false;

  if not assigned(frmAvisoPedidoPendente) then begin
    frmAvisoPedidoPendente := TfrmAvisoPedidoPendente.Create(nil);
    frmAvisoPedidoPendente.Show;
  end
  else
    frmAvisoPedidoPendente.OnShow(nil);
end;

procedure TfrmInicial.verificaNFCesContingencia;
begin
  frmNFCesContingencia := TfrmNFCesContingencia.Create(nil);
  if not frmNFCesContingencia.qryPedidos.IsEmpty then
    if confirma('Atenção! Existem NFC-es em contingência, aguardando envio.'+#13#10+
                'Deseja envia-las agora?') then
      frmNFCesContingencia.ShowModal;

  frmNFCesContingencia.Release;
  frmNFCesContingencia := nil;
end;

procedure TfrmInicial.verifica_pendencia;
var Especificacao :TEspecificacaoPedidosComItemNaoImpresso;
    repositorio   :TRepositorio;
    Pedidos       :TObjectList<TPedido>;
begin
  repositorio   := nil;
  Especificacao := nil;
  Pedidos       := nil;
  try
    repositorio   := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
    Especificacao := TEspecificacaoPedidosComItemNaoImpresso.Create;
    Pedidos       := repositorio.GetListaPorEspecificacao<TPedido>(Especificacao, 'SITUACAO = ''A'' ');

    if assigned(Pedidos) and (Pedidos.Count > 0) then
      Mostra_pendentes;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Especificacao);
    Pedidos.Free;
  end;
end;

procedure TfrmInicial.avisa_clientes;
var i :integer;
begin
  for i :=0 to Servidor.Socket.ActiveConnections-1 do begin
    Servidor.Socket.Connections[i].SendText('Mostra pendentes');
  end;
end;

procedure TfrmInicial.ClienteRead(Sender: TObject;
  Socket: TCustomWinSocket);
var codigo_comanda :String;
    codigo_mesa    :string;
    codigo_item    :String;
    quantidade     :String;
    Texto          :String;
    motivo         :String;
    Item           :TItem;
    repositorio    :TRepositorio;
    i              :integer;
    adicionais     :String;
    impressora_padrao :String;
    Arq            :TextFile;
begin
  Texto := Socket.ReceiveText;

  if Texto = 'Encerrar' then
    EncerraTerminal
  else if Pos('imprime', Texto) > 0 then
    imprime( StrToInt( copy(Texto, pos('=',Texto)+1, length(Texto)-7 ) ) )
  else if (Pos('ERRO=', Texto) > 0) and (dm.UsuarioLogado.Departamento.nome = 'CAIXA') then
    Avisar(Copy(Texto, 6, length(Texto)), 6)
  else if (Pos('BLOQUEADA', Texto) > 0) then begin

    if not (dm.UsuarioLogado.Departamento.nome = 'CAIXA') then
      Exit;

    codigo_comanda := copy(Texto, pos('=',Texto)+1, pos(';',Texto)-(pos('=',Texto)+1));

    Texto          := copy(Texto, pos(';',Texto)+1 , length(Texto));

    codigo_mesa    := copy(Texto, 1 , pos(';',Texto)-1);

    Texto          := copy(Texto, pos(';',Texto)+1 , length(Texto));

    motivo         := copy(Texto, 1 , pos(';',Texto)-1);

    Timer1.Enabled := true;

    avisar('ATENÇÃO!!!'+#13#10+'Mesa Nº '+codigo_mesa+', está tentando utilizar uma comanda bloqueada (Comanda Nº'+codigo_comanda+').'+
           #13#10+'Motivo bloqueio: '+motivo);

    if(Printer.PrinterIndex >= 0)then begin
      impressora_padrao := IfThen(pos('\\',Printer.Printers[Printer.PrinterIndex]) > 0,'','\\localhost\' )+ Printer.Printers[Printer.PrinterIndex];
      AssignFile(Arq, impressora_padrao);
      ReWrite(Arq);
    end
    else
      raise Exception.Create('Nenhuma impressora Padrão foi detectada');

    ReWrite(Arq);

    writeLn(Arq, 'Comanda Nº'+codigo_comanda+', bloqueada, foi utilizada.');
    writeLn(Arq, 'Utilizada em :'+IfThen(codigo_mesa = 'BOLICHE', 'Pista de boliche', 'Mesa '+codigo_mesa));
    writeLn(Arq, '* * * * * * * * Motivo bloqueio * * * * * * * *');
    writeLn(Arq, ' '+motivo);
    writeLn(Arq, '');
    writeLn(Arq, '');
    writeLn(Arq, '');
    WriteLn(Arq, ACIONA_GUILHOTINA);

    CloseFile(Arq);

    Timer1.Enabled := false;

  end
  else if (pos(';',Texto) > 0) then begin

    codigo_mesa    := copy(Texto, 1 , pos(';',Texto)-1);

    Texto          := copy(Texto, pos(';',Texto)+1 , length(Texto));

    codigo_item    := copy(Texto, 1 , pos(';',Texto)-1);

    Texto          := copy(Texto, pos(';',Texto)+1 , length(Texto));

    quantidade     := copy(Texto, 1 , pos(';',Texto)-1);

    repositorio    := nil;
    Item           := nil;

    try
      repositorio    := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
      Item           := TItem( repositorio.Get( StrToInt(codigo_item) ) );

      if not assigned(Item) then
        Exit;

      if Item.Produto.codigo_departamento = dm.UsuarioLogado.Codigo_departamento then begin

        if assigned(Item.Adicionais) then begin
          for i:= 0 to Item.Adicionais.Count - 1 do
            adicionais := adicionais + IfThen( (Item.Adicionais[i] as TAdicionalItem).flag = 'A','+','-') + (Item.Adicionais[i] as TAdicionalItem).Materia.descricao;

          adicionais:= ' ['+adicionais+']';
        end;

        Timer1.Enabled := true;
        if Application.MessageBox(PChar('ATENÇÃO! SOLICITAÇÃO DE CANCELAMENTO DE ITEM...'+#13#10+#13#10+
                    ' Permitir cancelamento de: '+quantidade+' '+Item.Produto.descricao+adicionais+','+#13#10+
                    'referente a mesa '+codigo_mesa+'?'),
                    'Confirmação', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
           Socket.SendText('sim='+codigo_item)
        else
           Socket.SendText('nao='+codigo_item);

        Timer1.Enabled := false;
      end;

    Finally
      FreeAndNil(repositorio);
      FreeAndNil(Item);
    end;

  end;
end;

procedure TfrmInicial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if assigned(frmAvisoPedidoPendente) then exit;

  if Key = VK_F3 then
    CriarPedido1.Click
  else if (Key = 82) and (Shift = [ssCtrl]) then
    ReiniciaClick(nil);
     
  inherited;
end;

procedure TfrmInicial.FormActivate(Sender: TObject);
begin
  inherited;

  if assigned(frmAvisoPedidoPendente) and not(frmAvisoPedidoPendente.Visible) then begin
    self.Enabled := true;
    FreeAndNil( frmAvisoPedidoPendente );
  end;
end;

procedure TfrmInicial.pedidosMouseEnter(Sender: TObject);
var img :TImage;
begin
  img := TImage( self.FindComponent('img'+TLabel(Sender).Name) );

  if not assigned(img) then begin
    avisar('Imagem com o nome img'+TLabel(Sender).Name+', não encontrada!');
    exit;
  end;

  img.Height                := img.Height + 10;
  img.Width                 := img.Width + 10;
  img.Left                  := img.Left - 5 ;
  img.Top                   := img.Top - 5;
  Tlabel(Sender).Font.Color := clBlack;
end;

procedure TfrmInicial.pedidosMouseLeave(Sender: TObject);
var img :TImage;
begin
  img := TImage( self.FindComponent('img'+TLabel(Sender).Name) );

  if not assigned(img) then begin
    avisar('Imagem com o nome img'+TLabel(Sender).Name+', não encontrada!');
    exit;
  end;
    
  img.Height                := img.Height - 10;
  img.Width                 := img.Width - 10;
  img.Left                  := img.Left + 5;
  img.Top                   := img.Top + 5;
  Tlabel(Sender).font.Color := $00515151;
end;

procedure TfrmInicial.FormCreate(Sender: TObject);
begin
  inherited;
  self.DoubleBuffered := true;
end;

procedure TfrmInicial.ConfigurarNFCE1Click(Sender: TObject);
begin
  AbreForm(TfrmConfiguraNFCe, paConfiguraECF);
end;

procedure TfrmInicial.ConfirmaoEntradaEstoque1Click(Sender: TObject);
begin
  AbreForm(TfrmConfirmaEntrada, paConfirmaEntradaEstoque);
end;

procedure TfrmInicial.ServidorClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
   Texto  :String;
   i      :integer;
begin
  Texto := Socket.ReceiveText;

  if Texto = 'SALVABOLICHE' then
    self.SalvaBoliche
  else if AnsiMatchText(UpperCase(copy(Texto,1,3)), ['sim','nao']) then begin

    for i :=0 to Servidor.Socket.ActiveConnections-1 do begin
       Servidor.Socket.Connections[i].SendText(Texto);
    end;

  end
  else if copy(Texto, 1, 7) = 'imprime' then begin

    for i :=0 to Servidor.Socket.ActiveConnections - 1 do
      Servidor.Socket.Connections[i].SendText(Texto);

  end
  else begin

    for i :=0 to Servidor.Socket.ActiveConnections - 2 do begin
      Servidor.Socket.Connections[i].SendText(Texto);
    end;

  end;
end;

procedure TfrmInicial.RxFolderMonitor2Change(Sender: TObject);
var i              :integer;
    ListaArquivos  :TStringList;
begin
  i := 1;

  repeat
     SalvaBoliche;

     ListaArquivos := GetFileListForExt( RxFolderMonitor2.FolderName, '.nack');

     if assigned(ListaArquivos) and (ListaArquivos.Count > 0) then begin
       inc(i);
       nack_para_txt(ListaArquivos[0]);
     end;

     Dec(i);

  until (i = 0);

end;

procedure TfrmInicial.nack_para_txt(nome_arquivo: String);
var novo_nome :String;
begin
  novo_nome := copy(nome_arquivo,1, pos('_',nome_arquivo)-1 )+'.txt';

  RxFolderMonitor2.Active := false;
  RenameFile(RxFolderMonitor2.FolderName+ '\' +nome_arquivo, RxFolderMonitor2.FolderName+ '\' +novo_nome);
  RxFolderMonitor2.Active := true;
end;

procedure TfrmInicial.NCM1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroNCMIBPT, paCadastroNCM);
end;

procedure TfrmInicial.NFe1Click(Sender: TObject);
begin
  AbreForm(TfrmMonitorControleNFe, paMonitorNFe);
end;

procedure TfrmInicial.NotasFiscaisEntrada1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioNotasFiscaisEntrada, paRelatorioNotasFiscaisEntrada);
end;

procedure TfrmInicial.SalvaBoliche;
var
  ListaArquivos  : TStringList;
  i              : integer;
  Repositorio    : TRepositorio;
  Especificacao  : TEspecificacaoPedidoAbertoDaComanda;
  Pedido         : TPedido;
  Item           : TItem;
  arq            : TextFile;
  linha, arquivo : String;
 // arquivos_com_erro :String;
begin

  if not DirectoryExists(dm.Empresa.diretorio_boliche) then
    Exit;

  if fdm.conexao.InTransaction then
    fdm.conexao.Commit;

  fdm.conexao.TxOptions.AutoCommit := false;
  try
  try
    RxFolderMonitor2.Active := false;

    Repositorio       := nil;
    Especificacao     := nil;
    Pedido            := nil;
  //  arquivos_com_erro := '';

    ListaArquivos := GetFileListForExt( RxFolderMonitor2.FolderName, '.txt');

    if not assigned(ListaArquivos) or (ListaArquivos.Count <= 0) then
      Exit;

    for i := 0 to ListaArquivos.Count - 1 do begin

     try
   //   try
         arquivo := '';
         arquivo := TStringUtilitario.RemoveCaracter( ListaArquivos[i] );

         if TStringUtilitario.TamanhoArquivo(dm.empresa.diretorio_boliche+'\' + ListaArquivos[i]) = 0 then
           Continue;

         AssignFile(arq, dm.empresa.diretorio_boliche+'\' + ListaArquivos[i]);
         Reset(arq);

         { O arquivo por padrão só tem uma linha }
         readln(arq, linha);

         if comanda_bloqueada( arquivo, 'BOLICHE') then
           continue;

         Especificacao     := TEspecificacaoPedidoAbertoDaComanda.Create( StrToInt( arquivo ) );
         Repositorio       := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
         Pedido            := TPedido( Repositorio.GetPorEspecificacao( Especificacao, 'CODIGO_COMANDA = '+ arquivo ) );

         if not assigned(Pedido) then begin
           Pedido       := TPedido.Create;
           Pedido.Itens := TObjectList<TItem>.Create;
           Pedido.data  := Date;
         end;

         {remove o couvert e a taxa de serviço para voltar ao valor dos itens}
         Pedido.valor_total    := Pedido.valor_total - Pedido.couvert - Pedido.taxa_servico;
         {soma o valor dos novos itens para chegar ao novo valor total}
         Pedido.valor_total    := Pedido.valor_total + StrToFloat( trim(copy(linha,16,10)) );
         {calcula o valor do couvert e da taxa de serviço, a partir do novo valor total}
         Pedido.couvert        := dm.empresa.Valor_couvert;
         //Pedido.taxa_servico   := (Pedido.valor_total * dm.empresa.Taxa_servico)/100;

         Pedido.codigo_comanda := StrToInt(arquivo);
         //Pedido.codigo_mesa    := 0;
         Pedido.situacao       := 'A';

         Pedido.valor_total    := Pedido.valor_total + pedido.couvert + pedido.taxa_servico;

         Pedido.Itens;

         Item   := TItem.Create;

         Item.codigo_produto := 1;//padrao para produto pista de boliche
         Item.quantidade     := TDateTimeUtilitario.TimeParaSegundos( StrToDateTime( TRIM(copy(linha,6,10)) ) );

         Item.valor_Unitario := StrToFloat( trim(copy(linha,16,10)) );
         Item.hora           := time;
         Item.impresso       := 'S';
         Item.codigo_usuario := 1;//padrao 1 para usuario CBN root

         if Item.quantidade > 599 then begin
           Pedido.Itens.Add( Item );

           Repositorio.Salvar(Pedido);
         end;

    {   Except
         On E: Exception do
           arquivos_com_erro := arquivos_com_erro + ListaArquivos[i] + ', ';
       end; }

     finally
       CloseFile(arq);

       if Assigned(Item) then
         if Item.quantidade < 599 then
           salva_lancamento_invalido(ListaArquivos[i], Pedido.codigo_comanda);
     end;
    end; //fim FOR

    { Deleta txt's da pasta }
    DeletaInseridos(ListaArquivos, dm.empresa.diretorio_boliche+'\',''{, arquivos_com_erro });

    {Salva os itens enviados, que foram inseridos no BD}
    fdm.conexao.Commit;
    fdm.conexao.TxOptions.AutoCommit := true;

    { Se durante a execução, um novo jogo for finalizado, o procedimento é novamente executado }
    if assigned( GetFileListForExt( RxFolderMonitor2.FolderName, '.txt' ) ) then
      self.SalvaBoliche;

   { if arquivos_com_erro <> '' then
      informar_erro('ATENÇÃO! Ocorreu um erro ao salvar os seguintes jogos de boliche'+#13#10+'Arquivos: '+arquivos_com_erro);  }

  Except
    On E: Exception do begin
      informar_erro('ATENÇÃO! Ocorreu um erro ao salvar um jogo de boliche. Contate o suporte técnico.'+#13#10+'Erro ocorrido: '+e.Message);
      if not fdm.conexao.TxOptions.AutoCommit then fdm.conexao.Rollback;
    end;
  end;

  Finally

    if fdm.conexao.InTransaction then
      fdm.conexao.Commit;

    if not fdm.conexao.TxOptions.AutoCommit then
      fdm.conexao.TxOptions.AutoCommit := true;

    RxFolderMonitor2.Active := true;
    FreeAndNil(Repositorio);
    FreeAndNil(Especificacao);
    FreeAndNil(Pedido);
    FreeAndNil(ListaArquivos);
  end;
end;

function TfrmInicial.GetFileListForExt(const Path, extensao: string): TStringList;
var
  I: Integer;
  SearchRec: TSearchRec;
begin
  Result := TStringList.Create;
  try
    I := FindFirst(Path+'\*'+ extensao, 0, SearchRec);
    while I = 0 do
    begin
     // if pos(SearchRec.Name , arquivos_com_erro) = 0 then
        Result.Add(SearchRec.Name);

      I := FindNext(SearchRec);
    end;

    if Result.Count <= 0 then begin
      Result.Free;
      Result := nil;
    end;

  except
    Result.Free;
    raise;
  end;
end;

procedure TfrmInicial.ClienteError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  avisar('Uma conexão não pode ser estabelecida.');
  abort;
end;

procedure TfrmInicial.imprime_no_departamento(codigo_pedido :Integer);
var i :integer;
begin
  for i :=0 to Servidor.Socket.ActiveConnections-1 do begin
    Servidor.Socket.Connections[i].SendText('imprime='+inttostr(codigo_pedido));
  end;
end;

procedure TfrmInicial.imprime(codigo_pedido: integer);
var repositorioPedido :TRepositorioPedido;
    Pedido            :TPedido;
begin
  try
  try
    Pedido            := nil;
    repositorioPedido := nil;

    repositorioPedido := TRepositorioPedido.Create;
    Pedido            := TPedido(repositorioPedido.Get(codigo_pedido));

    frmImpressaoPedido := TFrmImpressaoPedido.Create(nil);
    frmImpressaoPedido.imprimeDepartamento(Pedido);
    frmImpressaoPedido.Release;
    frmImpressaoPedido := nil;
    //repositorioPedido.imprime( Pedido );

  Except
    Mostra_pendentes;
  end;

  Finally
    FreeAndNil(Pedido);
    FreeAndNil(repositorioPedido);
  end;
end;

procedure TfrmInicial.Timer1Timer(Sender: TObject);
begin
  Application.ProcessMessages;
  Beep;
end;

procedure TfrmInicial.ReiniciaClick(Sender: TObject);
var AppName : PChar; 
begin
  if not confirma('Deseja realmente reiniciar o sistema?') then
    Exit;
    
  AppName := PChar(Application.ExeName) ;
  ShellExecute(0, 'open', AppName, nil, nil, SW_SHOWNORMAL) ;
  Application.Terminate;
end;

procedure TfrmInicial.Vendas2Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioVendas, paRelatorioVendas);
end;

procedure TfrmInicial.FormDestroy(Sender: TObject);
var
    i :integer;
begin

  if self.Servidor.Active then begin

    for i :=0 to Servidor.Socket.ActiveConnections-1 do begin
       Servidor.Socket.Connections[i].SendText('Encerrar');
    end;

    self.Servidor.Active := false;

  end;

  if self.Cliente.Active then
    self.Cliente.Close;

  inherited;
end;

procedure TfrmInicial.EncerraTerminal;
begin
  Avisar('ATENÇÃO! A conexão com o servidor foi perdida, caso estiver inserindo ou alterando dados, terá'+#13#10+
         '30 segundos para salvar a operação, após este tempo o sistema sera fechado.');

  timerDesliga.Enabled := true;     

end;

procedure TfrmInicial.timerdesligaTimer(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmInicial.Visualizarpedidosemaberto1Click(Sender: TObject);
begin
  AbreForm(TfrmPedidos, paTelaPedidosEmAberto);
end;

procedure TfrmInicial.Comandas1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroComanda, paCadastroComanda);
end;

function TfrmInicial.comanda_bloqueada(codigo_comanda, codigo_mesa :String): Boolean;
var repositorio : TREpositorio;
    Comanda     : TComanda;
begin
  result := false;
  
  Comanda     := nil;
  repositorio := nil;
  try
    repositorio  := TFabricaRepositorio.GetRepositorio(TComanda.ClassName);
    Comanda      := TComanda( repositorio.get( StrToInt(codigo_comanda) ) );

    result := not Comanda.ativa;

    if result then
      avisa_caixa(codigo_mesa, IntToStr(Comanda.codigo), Comanda.motivo)

  Finally
    FreeAndNil(Comanda);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmInicial.avisa_caixa(mesa, comanda, motivo: String);
var i :integer;
begin
  for i :=0 to Servidor.Socket.ActiveConnections-1 do begin
    Servidor.Socket.Connections[i].SendText('BLOQUEADA='+comanda+';'+mesa+';'+motivo+';');
  end;
end;

procedure TfrmInicial.ServidorClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  inherited;
end;

procedure TfrmInicial.ClienteDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  try

    Cliente.Open;

  Except
    On E: Exception do
      Avisar(e.message);
  end;

    inherited;
end;

procedure TfrmInicial.SangriaeReforo1Click(Sender: TObject);
var usuario :TUsuario;
begin
  usuario := dm.UsuarioLogado;

  try
    frmSupervisor := TfrmSupervisor.Create(self);

    frmSupervisor.Label1.Caption := 'Login';
    frmSupervisor.Label4.Caption := 'Para acessar a tela de Sangria e Reforço';
    frmSupervisor.Label5.Caption := 'informe seu login e senha:';

    if frmSupervisor.ShowModal = mrOk then begin
      dm.UsuarioLogado := frmSupervisor.usu;

      AbreForm(TfrmLancaSangriaReforco, paLancaSangriaReforco);
    end;

  finally
    dm.UsuarioLogado := usuario;
    frmSupervisor.Release;
    frmSupervisor := nil;
  end;
end;

procedure TfrmInicial.ServidorClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if not cdsConexoes.Active then
    cdsConexoes.CreateDataSet;

  if cdsConexoes.IsEmpty then
    Exit;

  if cdsConexoes.Locate('IP', Socket.RemoteAddress, []) then
    cdsConexoes.Delete;

  cdsConexoes.Append;
  cdsConexoesHANDLE.AsInteger := Socket.SocketHandle;
  cdsConexoesIP.AsString      := Socket.RemoteAddress;
  cdsConexoes.Post;    
end;

procedure TfrmInicial.ServidorClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  if cdsConexoes.IsEmpty then
    Exit;

  cdsConexoes.Locate('IP', Socket.RemoteAddress, []);

  cdsConexoes.Delete;
end;

procedure TfrmInicial.ItensDispensa1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroDispensa, paCadastroDispensa);
end;

procedure TfrmInicial.EntradaSada1Click(Sender: TObject);
begin
  AbreForm(TfrmEntradaSaidaMercadoria, paEntradaSaidaMercadoria);
end;

procedure TfrmInicial.informar_erro(msg_erro: String);
var i :integer;
begin
  for i :=0 to Servidor.Socket.ActiveConnections - 1 do begin
      Servidor.Socket.Connections[i].SendText('ERRO='+msg_erro);
  end;
end;

procedure TfrmInicial.Atendimentos1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioAtendimentos, paRelatorioAtendimentos);
end;

procedure TfrmInicial.Verificaarqbolichependente1Click(Sender: TObject);
begin
  if Servidor.Active then
    RxFolderMonitor2Change(nil)
  else
    Cliente.Socket.SendText('SALVABOLICHE');
end;

procedure TfrmInicial.Pedidos1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioPedidos, paRelatorioPedidos);
end;

procedure TfrmInicial.salva_lancamento_invalido(arquivo: String; codigo_comanda :integer);
var origem, destino :String;
begin
  origem  := RxFolderMonitor2.FolderName + '\' + arquivo;

  if not DirectoryExists(RxFolderMonitor2.FolderName+'\LANCAMENTO_INVALIDO') then
    CreateDir(RxFolderMonitor2.FolderName+'\LANCAMENTO_INVALIDO');

    destino := RxFolderMonitor2.FolderName+'\LANCAMENTO_INVALIDO\' + 'C' +IntToStr(codigo_comanda)+ '_'
                                                                   + StringReplace(DateToStr(Date),'/','.',[rfReplaceAll])+ '_'
                                                                   + StringReplace(TimeToStr(Time),':','.',[rfReplaceAll])+'.txt';

  CopyFile(PChar(origem),PChar(destino),true);

end;

procedure TfrmInicial.Estoque1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioEstoque, paRelatorioEstoque);
end;

procedure TfrmInicial.Extorno1Click(Sender: TObject);
var usuario :TUsuario;
begin
  usuario := dm.UsuarioLogado;

  try
    frmSupervisor := TfrmSupervisor.Create(self);

    frmSupervisor.Label1.Caption := 'Login';
    frmSupervisor.Label4.Caption := 'Para acessar a tela de Extorno de Nota Fiscal de Entrada';
    frmSupervisor.Label5.Caption := 'informe seu login e senha:';

    if frmSupervisor.ShowModal = mrOk then begin
      dm.UsuarioLogado := frmSupervisor.usu;

      AbreForm(TfrmEstornoEntrada, paEstornoEntradaNF);
    end;

  finally
    dm.UsuarioLogado := usuario;
    frmSupervisor.Release;
    frmSupervisor := nil;
  end;
end;

procedure TfrmInicial.EntradaeSada1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioEntradaSaida, paRelatorioEntradaSaida);
end;

procedure TfrmInicial.EntradaporXML1Click(Sender: TObject);
begin
  AbreForm(TfrmEntradaNota, paEntradaNotaPorXml);
end;

procedure TfrmInicial.Caixa48colunas1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioCaixa48Colunas, paRelatorioCaixa48Colunas);
end;

procedure TfrmInicial.CFOPscorrespondentes1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroCfopCorrespondente, paCadastroCFOPsCorrespondentes);
end;

procedure TfrmInicial.ItensDeletados1Click(Sender: TObject);
begin
  AbreForm(TfrmRelatorioItensDeletados, paRelatorioItensDeletados);
end;

procedure TfrmInicial.Visualizaremitidas1Click(Sender: TObject);
begin
   AbreForm(TfrmNFCes, paTelaNFce);
end;

procedure TfrmInicial.Configuraoes1Click(Sender: TObject);
begin
  AbreForm(TfrmConfiguracoesSistema, paConfigurarSistema);
end;

procedure TfrmInicial.BotaoImg1Label1Click(Sender: TObject);
begin
  CriarPedido1Click(nil);
end;

procedure TfrmInicial.BotaoImgCaixaLabel1Click(Sender: TObject);
begin
  AbrirFechar1Click(nil);
end;

procedure TfrmInicial.Button1Click(Sender: TObject);
begin
  SetDefaultPrinter('merda');
end;

Procedure TfrmInicial.SetDefaultPrinter(PrinterName: String);
var
I: Integer;
Device : PChar;
Driver : Pchar;
Port : Pchar; 
HdeviceMode: Thandle; 
aPrinter : TPrinter;
begin
Printer.PrinterIndex := -1;
getmem(Device, 255);
getmem(Driver, 255);
getmem(Port, 255); 
aPrinter := TPrinter.create;

for I := 0 to Printer.printers.Count-1 do 
begin 
if Printer.printers[i] = PrinterName then
begin 
aprinter.printerindex := i; 
aPrinter.getprinter 
(device, driver, port, HdeviceMode); 
StrCat(Device, ','); 
StrCat(Device, Driver ); 
StrCat(Device, Port ); 
WriteProfileString('windows', 'device', Device); 
StrCopy( Device, 'windows' ); 
SendMessage(HWND_BROADCAST, WM_WININICHANGE, 
0, Longint(@Device)); 
end; 
end; 
Freemem(Device, 255); 
Freemem(Driver, 255); 
Freemem(Port, 255); 
aPrinter.Free;
end;
   {
Initialization
  RLConsts.SetVersion(3,72,'B');}

procedure TfrmInicial.Clientes1Click(Sender: TObject);
begin
  AbreForm(TfrmCadastroCliente, paCadastroCliente);
end;

procedure TfrmInicial.Produtos1Click(Sender: TObject);
begin
   AbreForm(TfrmRelatorioProdutos, paRelatorioProdutos);
end;

procedure TfrmInicial.ransportadora1Click(Sender: TObject);
begin
   AbreForm(TfrmCadastroTransportadora, paCadastroTransportadora);
end;

procedure TfrmInicial.CuponsFiscais1Click(Sender: TObject);
begin
   AbreForm(TfrmRelatorioCuponsFiscais, paRelatorioCuponsFiscais);
end;

procedure TfrmInicial.SuporteTcnico2Click(Sender: TObject);
begin
  frmSuporteTecnico := TfrmSuporteTecnico.Create(self);
  frmSuporteTecnico.ShowModal;
  frmSuporteTecnico.Release;
  frmSuporteTecnico := nil;
end;

procedure TfrmInicial.Reimpressodopedido1Click(Sender: TObject);
begin
   AbreForm(TfrmReimpressaoPedido, paReimpressaoPedido);
end;

end.



