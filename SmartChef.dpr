program SmartChef;

uses
  Windows,
  Forms,
  Shellapi,
  SysUtils,
  midas,
  midasLib,
  uInicial in 'src\formularios\uInicial.pas' {frmInicial},
  uAguarde in 'src\formularios\uAguarde.pas' {frmAguarde},
  uAvisar in 'src\formularios\uAvisar.pas' {frmAvisar},
  uCadastroPerfilAcesso in 'src\formularios\uCadastroPerfilAcesso.pas',
  uCadastroUsuario in 'src\formularios\uCadastroUsuario.pas',
  uConfiguraBancoDeDados in 'src\formularios\uConfiguraBancoDeDados.pas',
  uInputBox in 'src\formularios\uInputBox.pas' {frmInputBox},
  uLogin in 'src\formularios\uLogin.pas',
  uManutencaoSistema in 'src\formularios\uManutencaoSistema.pas',
  uPadrao in 'src\formularios\uPadrao.pas' {frmPadrao},
  uPesquisaSimples in 'src\formularios\uPesquisaSimples.pas' {frmPesquisaSimples},
  uSupervisor in 'src\formularios\uSupervisor.pas' {frmSupervisor},
  frameBotaoImg in 'src\formularios\Frames\frameBotaoImg.pas' {BotaoImg: TFrame},
  frameHorario in 'src\formularios\Frames\frameHorario.pas' {Horario: TFrame},
  frameListaCampo in 'src\formularios\Frames\frameListaCampo.pas' {ListaCampo: TFrame},
  frameMaskCpfCnpj in 'src\formularios\Frames\frameMaskCpfCnpj.pas' {MaskCpfCnpj: TFrame},
  frameRealEdit in 'src\formularios\Frames\frameRealEdit.pas' {RealEdit: TFrame},
  Especificacao in 'src\dominio\objetoValor\especificacao\Especificacao.pas',
  CriaBalaoInformacao in 'src\dominio\utilitario\CriaBalaoInformacao.pas',
  DateTimeUtilitario in 'src\dominio\utilitario\DateTimeUtilitario.pas',
  Objeto in 'src\dominio\utilitario\Objeto.pas',
  StringUtilitario in 'src\dominio\utilitario\StringUtilitario.pas',
  Backup in 'src\infraestrutura\backup\Backup.pas',
  DiretorioBackup in 'src\infraestrutura\backup\DiretorioBackup.pas',
  ExcecaoBancoDeBackupInvalido in 'src\infraestrutura\excecao\ExcecaoBancoDeBackupInvalido.pas',
  ExcecaoBancoDeDadosInvalido in 'src\infraestrutura\excecao\ExcecaoBancoDeDadosInvalido.pas',
  ExcecaoBancoInvalido in 'src\infraestrutura\excecao\ExcecaoBancoInvalido.pas',
  ExcecaoScriptDeAtualizacaoInvalido in 'src\infraestrutura\excecao\ExcecaoScriptDeAtualizacaoInvalido.pas',
  ExcecaoSistemaEmManutencao in 'src\infraestrutura\excecao\ExcecaoSistemaEmManutencao.pas',
  FabricaRepositorio in 'src\infraestrutura\persistencia\FabricaRepositorio.pas',
  ObjetoGenerico in 'src\infraestrutura\persistencia\ObjetoGenerico.pas',
  Repositorio in 'src\infraestrutura\persistencia\Repositorio.pas',
  RepositorioAuditoria in 'src\infraestrutura\persistencia\RepositorioAuditoria.pas',
  RepositorioCampoAlteradoAuditoria in 'src\infraestrutura\persistencia\RepositorioCampoAlteradoAuditoria.pas',
  RepositorioCampoAuditoria in 'src\infraestrutura\persistencia\RepositorioCampoAuditoria.pas',
  RepositorioCampoExcluidoAuditoria in 'src\infraestrutura\persistencia\RepositorioCampoExcluidoAuditoria.pas',
  RepositorioCampoIncluidoAuditoria in 'src\infraestrutura\persistencia\RepositorioCampoIncluidoAuditoria.pas',
  RepositorioDiretorioBackup in 'src\infraestrutura\persistencia\RepositorioDiretorioBackup.pas',
  RepositorioManutencaoSistema in 'src\infraestrutura\persistencia\RepositorioManutencaoSistema.pas',
  RepositorioVersao in 'src\infraestrutura\persistencia\RepositorioVersao.pas',
  RepositorioPerfil in 'src\infraestrutura\persistencia\RepositorioPerfil.pas',
  RepositorioUsuario in 'src\infraestrutura\persistencia\RepositorioUsuario.pas',
  BuscadorDeAtualizacoesBD in 'src\infraestrutura\servico\BuscadorDeAtualizacoesBD.pas',
  ServicoBackup in 'src\infraestrutura\servico\ServicoBackup.pas',
  ServicoVerificadorSistemaEmManutencao in 'src\infraestrutura\servico\ServicoVerificadorSistemaEmManutencao.pas',
  ExcecaoRepositorioNaoEncontrado in 'src\infraestrutura\persistencia\excecao\ExcecaoRepositorioNaoEncontrado.pas',
  ServicoAtualizadorBD in 'src\infraestrutura\servico\atualizacao\ServicoAtualizadorBD.pas',
  TipoBanco in 'src\infraestrutura\tipo\TipoBanco.pas',
  ArquivoConfiguracao in 'src\infraestrutura\ArquivoConfiguracao.pas',
  Funcoes in 'src\infraestrutura\Funcoes.pas',
  LogErros in 'src\infraestrutura\LogErros.pas',
  uModulo in 'src\infraestrutura\uModulo.pas' {dm: TDataModule},
  Auditoria in 'src\dominio\entidade\auditoria\Auditoria.pas',
  CampoAlteracaoAuditoria in 'src\dominio\entidade\auditoria\CampoAlteracaoAuditoria.pas',
  CampoAuditoria in 'src\dominio\entidade\auditoria\CampoAuditoria.pas',
  CampoIncluidoAuditoria in 'src\dominio\entidade\auditoria\CampoIncluidoAuditoria.pas',
  ManutencaoSistema in 'src\dominio\entidade\ManutencaoSistema.pas',
  Versao in 'src\dominio\entidade\Versao.pas',
  Perfil in 'src\dominio\entidade\Perfil.pas',
  Usuario in 'src\dominio\entidade\Usuario.pas',
  ExcecaoMetodoNaoImplementado in 'src\dominio\excecao\ExcecaoMetodoNaoImplementado.pas',
  EventoExecutarOperacao in 'src\formularios\Eventos\EventoExecutarOperacao.pas',
  EspecificacaoDiretorioBackupComUsuarioIgualA in 'src\dominio\objetoValor\especificacao\EspecificacaoDiretorioBackupComUsuarioIgualA.pas',
  ExcecaoParametroInvalido in 'src\dominio\excecao\ExcecaoParametroInvalido.pas',
  ExcecaoAtributoDuplicado in 'src\dominio\excecao\ExcecaoAtributoDuplicado.pas',
  PermissoesAcesso in 'src\dominio\entidade\PermissoesAcesso.pas',
  EspecificacaoUsuarioComLoginIgualA in 'src\dominio\objetoValor\especificacao\EspecificacaoUsuarioComLoginIgualA.pas',
  Criptografia in 'src\dominio\objetoValor\Criptografia.pas',
  uConfirmacaoUsuario in 'src\formularios\uConfirmacaoUsuario.pas' {frmConfirmacaoUsuario},
  EventoExecutandoOperacao in 'src\formularios\Eventos\EventoExecutandoOperacao.pas',
  EventoAvisar in 'src\formularios\Eventos\EventoAvisar.pas',
  EventoFechar in 'src\formularios\Eventos\EventoFechar.pas',
  uCadastroPadrao in 'src\formularios\uCadastroPadrao.pas' {frmCadastroPadrao},
  uCadastroGrupo in 'src\formularios\uCadastroGrupo.pas' {frmCadastroGrupo},
  Grupo in 'src\dominio\entidade\Grupo.pas',
  RepositorioGrupo in 'src\infraestrutura\persistencia\RepositorioGrupo.pas',
  MateriaPrima in 'src\dominio\entidade\MateriaPrima.pas',
  RepositorioMateriaPrima in 'src\infraestrutura\persistencia\RepositorioMateriaPrima.pas',
  uCadastroMateriaPrima in 'src\formularios\uCadastroMateriaPrima.pas' {frmCadastroMateriaPrima},
  Produto in 'src\dominio\entidade\Produto.pas',
  RepositorioProduto in 'src\infraestrutura\persistencia\RepositorioProduto.pas',
  uCadastroProduto in 'src\formularios\uCadastroProduto.pas' {frmCadastroProduto},
  frameBuscaMateriaPrima in 'src\formularios\Frames\frameBuscaMateriaPrima.pas' {BuscaMateriaPrima: TFrame},
  ProdutoHasMateria in 'src\dominio\entidade\ProdutoHasMateria.pas',
  RepositorioProdutoHasMateria in 'src\infraestrutura\persistencia\RepositorioProdutoHasMateria.pas',
  EspecificacaoMateriasDoProduto in 'src\dominio\objetoValor\especificacao\EspecificacaoMateriasDoProduto.pas',
  uPedido in 'src\formularios\uPedido.pas' {frmPedido},
  Comanda in 'src\dominio\entidade\Comanda.pas',
  RepositorioComanda in 'src\infraestrutura\persistencia\RepositorioComanda.pas',
  frameBuscaComanda in 'src\formularios\Frames\frameBuscaComanda.pas' {BuscaComanda: TFrame},
  Pedido in 'src\dominio\entidade\Pedido.pas',
  RepositorioPedido in 'src\infraestrutura\persistencia\RepositorioPedido.pas',
  Item in 'src\dominio\entidade\Item.pas',
  RepositorioItem in 'src\infraestrutura\persistencia\RepositorioItem.pas',
  EspecificacaoItensDoPedido in 'src\dominio\objetoValor\especificacao\EspecificacaoItensDoPedido.pas',
  EspecificacaoPedidoAbertoDaComanda in 'src\dominio\objetoValor\especificacao\EspecificacaoPedidoAbertoDaComanda.pas',
  frameBuscaProduto in 'src\formularios\Frames\frameBuscaProduto.pas' {BuscaProduto: TFrame},
  uCadastroEmpresa in 'src\formularios\uCadastroEmpresa.pas' {frmCadastroEmpresa},
  Empresa in 'src\dominio\entidade\Empresa.pas',
  RepositorioEmpresa in 'src\infraestrutura\persistencia\RepositorioEmpresa.pas',
  uAdicionaItemProduto in 'src\formularios\uAdicionaItemProduto.pas' {frmAdicionaItemProduto},
  EspecificacaoProdutosQueContemMateria in 'src\dominio\objetoValor\especificacao\EspecificacaoProdutosQueContemMateria.pas',
  AdicionalItem in 'src\dominio\entidade\AdicionalItem.pas',
  RepositorioAdicionalItem in 'src\infraestrutura\persistencia\RepositorioAdicionalItem.pas',
  EspecificacaoAdicionalDoItem in 'src\dominio\objetoValor\especificacao\EspecificacaoAdicionalDoItem.pas',
  uFinalizaPedido in 'src\formularios\uFinalizaPedido.pas' {frmFinalizaPedido},
  Caixa in 'src\dominio\entidade\Caixa.pas',
  Movimento in 'src\dominio\entidade\Movimento.pas',
  RepositorioCaixa in 'src\infraestrutura\persistencia\RepositorioCaixa.pas',
  RepositorioMovimento in 'src\infraestrutura\persistencia\RepositorioMovimento.pas',
  uCaixa in 'src\formularios\uCaixa.pas' {frmCaixa},
  EspecificacaoMovimentosPorCodigoCaixa in 'src\dominio\objetoValor\especificacao\EspecificacaoMovimentosPorCodigoCaixa.pas',
  uScript in 'src\formularios\uScript.pas' {frmScript},
  uCadastroDepartamento in 'src\formularios\uCadastroDepartamento.pas' {frmCadastroDepartamento},
  Departamento in 'src\dominio\entidade\Departamento.pas',
  RepositorioDepartamento in 'src\infraestrutura\persistencia\RepositorioDepartamento.pas',
  uAvisoPedidoPendente in 'src\formularios\uAvisoPedidoPendente.pas' {frmAvisoPedidoPendente},
  EspecificacaoPedidosComItemNaoImpresso in 'src\dominio\objetoValor\especificacao\EspecificacaoPedidosComItemNaoImpresso.pas',
  NcmIBPT in 'src\dominio\entidade\NcmIBPT.pas',
  RepositorioNcmIBPT in 'src\infraestrutura\persistencia\RepositorioNcmIBPT.pas',
  frameBuscaNCM in 'src\formularios\Frames\frameBuscaNCM.pas' {BuscaNCM: TFrame},
  ConfiguracaoECF in 'src\dominio\entidade\ConfiguracaoECF.pas',
  RepositorioConfiguracaoECF in 'src\infraestrutura\persistencia\RepositorioConfiguracaoECF.pas',
  uConfiguraECF in 'src\formularios\uConfiguraECF.pas' {frmConfiguraECF},
  EspecificacaoCaixaPorData in 'src\dominio\objetoValor\especificacao\EspecificacaoCaixaPorData.pas',
  uRelatorioVendas in 'src\formularios\relatorios\Fortes\uRelatorioVendas.pas' {frmRelatorioVendas},
  uSuporteTecnico in 'src\formularios\uSuporteTecnico.pas' {frmSuporteTecnico},
  uPedidosEmAberto in 'src\formularios\uPedidosEmAberto.pas' {frmPedidosEmAberto},
  uCadastroComanda in 'src\formularios\uCadastroComanda.pas' {frmCadastroComanda},
  Dispensa in 'src\dominio\entidade\Dispensa.pas',
  RepositorioDispensa in 'src\infraestrutura\persistencia\RepositorioDispensa.pas',
  Estoque in 'src\dominio\entidade\Estoque.pas',
  RepositorioEstoque in 'src\infraestrutura\persistencia\RepositorioEstoque.pas',
  EspecificacaoEstoquePorProduto in 'src\dominio\objetoValor\especificacao\EspecificacaoEstoquePorProduto.pas',
  uCadastroDispensa in 'src\formularios\uCadastroDispensa.pas' {frmCadastroDispensa},
  EspecificacaoEstoquePorItemDispensa in 'src\dominio\objetoValor\especificacao\EspecificacaoEstoquePorItemDispensa.pas',
  uEntradaSaidaMercadoria in 'src\formularios\uEntradaSaidaMercadoria.pas' {frmEntradaSaidaMercadoria},
  frameBuscaDispensa in 'src\formularios\Frames\frameBuscaDispensa.pas' {BuscaDispensa: TFrame},
  uRelatorioAtendimentos in 'src\formularios\relatorios\Fortes\uRelatorioAtendimentos.pas' {frmRelatorioAtendimentos},
  uRelatorioPedidos in 'src\formularios\relatorios\Fortes\uRelatorioPedidos.pas' {frmRelatorioPedidos},
  EntradaSaida in 'src\dominio\entidade\EntradaSaida.pas',
  RepositorioEntradaSaida in 'src\infraestrutura\persistencia\RepositorioEntradaSaida.pas',
  uRelatorioEstoque in 'src\formularios\relatorios\Fortes\uRelatorioEstoque.pas' {frmRelatorioEstoque},
  uRelatorioEntradaSaida in 'src\formularios\relatorios\Fortes\uRelatorioEntradaSaida.pas' {frmRelatorioEntradaSaida},
  EspecificacaoMovimentosCaixa in 'src\dominio\objetoValor\especificacao\EspecificacaoMovimentosCaixa.pas',
  uRelatorioCaixa48Colunas in 'src\formularios\relatorios\Fortes\uRelatorioCaixa48Colunas.pas' {frmRelatorioCaixa48Colunas},
  ItemDeletado in 'src\dominio\entidade\ItemDeletado.pas',
  RepositorioItemDeletado in 'src\infraestrutura\persistencia\RepositorioItemDeletado.pas',
  uRelatorioItensDeletados in 'src\formularios\relatorios\Fortes\uRelatorioItensDeletados.pas' {frmRelatorioItensDeletados},
  frameBuscaUsuario in 'src\formularios\Frames\frameBuscaUsuario.pas' {BuscaUsuario: TFrame},
  ExcecaoCampoNaoInformado in 'src\dominio\excecao\ExcecaoCampoNaoInformado.pas',
  ExcecaoValorInvalido in 'src\dominio\excecao\ExcecaoValorInvalido.pas',
  CertificadoNFCE in 'src\dominio\objetoValor\CertificadoNFCE.pas',
  CidadeNFCe in 'src\dominio\objetoValor\CidadeNFCe.pas',
  CSTTributadoIntegralmente in 'src\dominio\objetoValor\CSTTributadoIntegralmente.pas',
  EnderecoNFCe in 'src\dominio\objetoValor\EnderecoNFCe.pas',
  FormaPagamento in 'src\dominio\objetoValor\FormaPagamento.pas',
  FormasPagamento in 'src\dominio\objetoValor\FormasPagamento.pas',
  ItemVenda in 'src\dominio\objetoValor\ItemVenda.pas',
  ParametrosDANFE in 'src\dominio\objetoValor\ParametrosDANFE.pas',
  ParametrosNFCe in 'src\dominio\objetoValor\ParametrosNFCe.pas',
  Token in 'src\dominio\objetoValor\Token.pas',
  Venda in 'src\dominio\objetoValor\Venda.pas',
  ServicoEmissorNFCe in 'src\dominio\servico\ServicoEmissorNFCe.pas',
  TipoAmbiente in 'src\dominio\tipo\TipoAmbiente.pas',
  TipoFormaEmissao in 'src\dominio\tipo\TipoFormaEmissao.pas',
  TipoRegime in 'src\dominio\tipo\TipoRegime.pas',
  TipoVersaoDF in 'src\dominio\tipo\TipoVersaoDF.pas',
  Parametros in 'src\dominio\objetoValor\Parametros.pas',
  RepositorioParametrosNFCe in 'src\infraestrutura\persistencia\RepositorioParametrosNFCe.pas',
  CSOSNTributadoSNSemCredito in 'src\dominio\objetoValor\CSOSNTributadoSNSemCredito.pas',
  NFCE in 'src\dominio\entidade\NFCE.pas',
  RepositorioNFCE in 'src\infraestrutura\persistencia\RepositorioNFCE.pas',
  uConfiguraNFCe in 'src\formularios\uConfiguraNFCe.pas' {frmConfiguraNFCe},
  EspecificacaoMovimentosPorCodigoPedido in 'src\dominio\objetoValor\especificacao\EspecificacaoMovimentosPorCodigoPedido.pas',
  uNFCes in 'src\formularios\uNFCes.pas' {frmNFCes},
  EspecificacaoFiltraNFCe in 'src\dominio\objetoValor\especificacao\EspecificacaoFiltraNFCe.pas',
  uConfiguracoesSistema in 'src\formularios\uConfiguracoesSistema.pas' {frmconfiguracoesSistema},
  ConfiguracoesSistema in 'src\dominio\entidade\ConfiguracoesSistema.pas',
  RepositorioConfiguracoesSistema in 'src\infraestrutura\persistencia\RepositorioConfiguracoesSistema.pas',
  ParametrosEmpresa in 'src\dominio\objetoValor\ParametrosEmpresa.pas',
  uCadastroCliente in 'src\formularios\uCadastroCliente.pas' {frmCadastroCliente},
  frameBuscaCidade in 'src\formularios\Frames\frameBuscaCidade.pas' {BuscaCidade: TFrame},
  Cliente in 'src\dominio\entidade\Cliente.pas',
  RepositorioCliente in 'src\infraestrutura\persistencia\RepositorioCliente.pas',
  EspecificacaoClientePorCpfCnpj in 'src\dominio\objetoValor\especificacao\EspecificacaoClientePorCpfCnpj.pas',
  uRelatorioProdutos in 'src\formularios\relatorios\Fortes\uRelatorioProdutos.pas' {frmRelatorioProdutos},
  RepositorioEndereco in 'src\infraestrutura\persistencia\RepositorioEndereco.pas',
  Endereco in 'src\dominio\entidade\Endereco.pas',
  EspecificacaoEnderecosDoCliente in 'src\dominio\objetoValor\especificacao\EspecificacaoEnderecosDoCliente.pas',
  uRelatorioCuponsFiscais in 'src\formularios\relatorios\Fortes\uRelatorioCuponsFiscais.pas' {frmRelatorioCuponsFiscais},
  EspecificacaoNFCe in 'src\dominio\objetoValor\especificacao\EspecificacaoNFCe.pas',
  ProdutoDependenciaEst in 'src\dominio\entidade\ProdutoDependenciaEst.pas',
  RepositorioProdutoDependenciaEst in 'src\infraestrutura\persistencia\RepositorioProdutoDependenciaEst.pas',
  EspecificacaoDependenciaEstoqueProduto in 'src\dominio\objetoValor\especificacao\EspecificacaoDependenciaEstoqueProduto.pas',
  frameBuscaCliente in 'src\formularios\Frames\frameBuscaCliente.pas' {BuscaCliente: TFrame},
  EspecificacaoEnderecoPorTelefone in 'src\dominio\objetoValor\especificacao\EspecificacaoEnderecoPorTelefone.pas',
  uReimpressaoPedido in 'src\formularios\uReimpressaoPedido.pas' {frmReimpressaoPedido},
  Vcl.Themes,
  Vcl.Styles,
  uNFCesContingencia in 'src\formularios\uNFCesContingencia.pas' {frmNFCesContingencia};

{$R *.res}

var
  ConfiguraBanco :TfrmConfiguraBancoDeDados;
  Instancia: THandle;
begin
  Instancia:= CreateMutex(nil, false, 'InstanciaIniciada');

  if WaitForSingleObject(Instancia, 0) = wait_Timeout then begin
    Exit;
  end;

  { FastMM4 }
//  FullDebugModeScanMemoryPoolBeforeEveryOperation := true;
//  SuppressMessageBoxes                            := false;
  { FastMM4 }
  ConfiguraBanco := nil;

  //ReportMemoryLeaksOnShutdown:=true;

  Application.Initialize;
  Application.Title := 'SMART CHEF';
  Application.CreateForm(Tdm, dm);
  if not dm.cancelaInicializacao then begin
    //------------------------------------------------------------------------------------------------//
    // Se não for encontrado o Banco de Dados, então é solicitado para o usário configurá-lo.         //
    //------------------------------------------------------------------------------------------------//
    while not dm.IsConectadoBancoDeDados do begin
       try
          ConfiguraBanco := TfrmConfiguraBancoDeDados.Create(tbBancoDeDados);
          ConfiguraBanco.AbreConfiguracao;

          if not ConfiguraBanco.isBancoConfigurado then Halt
          else                                          dm.AbreConexaoBancoDeDados;

       finally
          ConfiguraBanco.Release;
          ConfiguraBanco := nil
       end;
    end;

    Application.CreateForm(TfrmLogin, frmLogin);

    try
      if DirectoryExists(ExtractFilePath(Application.ExeName)+'\Pedidos') or (frmLogin.ShowModal = 1) then begin
        Application.CreateForm(TfrmInicial, frmInicial);
        frmInicial.ShowModal;
        frmInicial.Release;
        frmInicial := nil;

        ShellExecute(0, 'open', PChar('prjFinalizaProcessosSmart'), nil, nil, SW_SHOWNORMAL) ;
      end;
    finally
      frmLogin.Release;
      frmLogin := nil;
    end;

  end;  
  dm.FechaConexaoBancoDeDados;
end.
