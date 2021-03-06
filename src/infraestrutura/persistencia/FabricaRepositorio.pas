unit FabricaRepositorio;

interface

uses
  Repositorio;

type
  TFabricaRepositorio = class

  public
    class function GetRepositorio(NomeDaEntidade :String) :TRepositorio;
end;

implementation

uses
  SysUtils,
  uModulo,
  ExcecaoRepositorioNaoEncontrado,
  RepositorioUsuario,
  RepositorioDiretorioBackup,
  RepositorioPerfil,
  RepositorioCampoExcluidoAuditoria,
  RepositorioCampoIncluidoAuditoria,
  RepositorioAuditoria,
  RepositorioCampoAlteradoAuditoria,
  RepositorioManutencaoSistema,
  RepositorioVersao,
  RepositorioGrupo,
  RepositorioMateriaPrima,
  RepositorioProduto,
  RepositorioProdutoHasMateria,
  RepositorioComanda,
  RepositorioPedido,
  RepositorioEmpresa,
  RepositorioItem,
  RepositorioAdicionalItem,
  RepositorioCaixa,
  RepositorioMovimento,
  RepositorioDepartamento,
  RepositorioNcmIBPT,
  RepositorioConfiguracaoECF,
  RepositorioDispensa,
  RepositorioEstoque,
  RepositorioEntradaSaida,
  RepositorioItemDeletado,
  RepositorioParametrosNFCe,
  RepositorioNFCe,
  RepositorioConfiguracoesSistema,
  RepositorioCliente,
  RepositorioEndereco,
  RepositorioFornecedor,
  CampoAlteracaoAuditoria,
  RepositorioCFOPCorrespondente,
  RepositorioProdutoFornecedor,
  RepositorioPessoa,
  RepositorioSangriaReforco,
  RepositorioNotaFiscal,
  RepositorioItemNotaFiscal,
  RepositorioNaturezaOperacao,
  RepositorioCidade,
  RepositorioEstado,
  RepositorioConfiguracoesNF,
  RepositorioFormaPagamento,
  RepositorioIcms00,
  RepositorioIpiTrib,
  RepositorioPisAliq,
  RepositorioCofinsAliq,
  RepositorioIcmsSn101,
  RepositorioIpiNt,
  RepositorioPisNt,
  RepositorioCofinsNt,
  RepositorioObservacoesNotaFiscal,
  RepositorioTotaisNotaFiscal,
  RepositorioItemAvulso,
  RepositorioLoteNfe,
  RepositorioNFe,
  RepositorioRetornoNFe,
  RepositorioRetornoLoteNFe,
  RepositorioVolumesNotaFiscal,
  RepositorioTransportadora,
  RepositorioCFOP,
  RepositorioConfiguracoesNFEmail,
  RepositorioMateriaDoProduto,
  RepositorioLoteValidade,
  RepositorioProdutoValidade,
  RepositorioQuantidadePorValidade;

{ TFabricaRepositorio }

class function TFabricaRepositorio.GetRepositorio(NomeDaEntidade :String) :TRepositorio;
begin
   result           := nil;

   if      (NomeDaEntidade  = 'TUsuario')                   then result := TRepositorioUsuario.Create
   else if (NomeDaEntidade  = 'TDiretorioBackup')           then result := TRepositorioDiretorioBackup.Create
   else if (NomeDaEntidade  = 'TPerfil')                    then result := TRepositorioPerfil.Create
   else if (NomeDaEntidade  = 'TAuditoria')                 then result := TRepositorioAuditoria.Create
   else if (NomeDaEntidade  = 'TCampoIncluidoAuditoria')    then result := TRepositorioCampoIncluidoAuditoria.Create
   else if (NomeDaEntidade  = 'TCampoExcluidoAuditoria')    then result := TRepositorioCampoExcluidoAuditoria.Create
   else if (NomeDaEntidade  = 'TCampoAlteradoAuditoria')    then result := TRepositorioCampoAlteradoAuditoria.Create
   else if (NomeDaEntidade  = 'TManutencaoSistema')         then result := TRepositorioManutencaoSistema.Create
   else if (NomeDaEntidade  = 'TVersao')                    then result := TRepositorioVersao.Create
   else if (NomeDaEntidade  = 'TGrupo')                     then result := TRepositorioGrupo.Create
   else if (NomeDaEntidade  = 'TMateriaPrima')              then result := TRepositorioMateriaPrima.Create
   else if (NomeDaEntidade  = 'TProduto')                   then result := TRepositorioProduto.Create
   else if (NomeDaEntidade  = 'TProdutoHasMateria')         then result := TRepositorioProdutoHasMateria.Create
   else if (NomeDaEntidade  = 'TComanda')                   then result := TRepositorioComanda.Create
   else if (NomeDaEntidade  = 'TPedido')                    then result := TRepositorioPedido.Create
   else if (NomeDaEntidade  = 'TEmpresa')                   then result := TRepositorioEmpresa.Create
   else if (NomeDaEntidade  = 'TItem')                      then result := TRepositorioItem.Create
   else if (NomeDaEntidade  = 'TAdicionalItem')             then result := TRepositorioAdicionalItem.Create
   else if (NomeDaEntidade  = 'TCaixa')                     then result := TRepositorioCaixa.Create
   else if (NomeDaEntidade  = 'TMovimento')                 then result := TRepositorioMovimento.Create
   else if (NomeDaEntidade  = 'TDepartamento')              then result := TRepositorioDepartamento.Create
   else if (NomeDaEntidade  = 'TNcmIBPT')                   then result := TRepositorioNcmIBPT.Create
   else if (NomeDaEntidade  = 'TConfiguracaoECF')           then result := TRepositorioConfiguracaoECF.Create
   else if (NomeDaEntidade  = 'TDispensa')                  then result := TRepositorioDispensa.Create
   else if (NomeDaEntidade  = 'TEstoque')                   then result := TRepositorioEstoque.Create
   else if (NomeDaEntidade  = 'TEntradaSaida')              then result := TRepositorioEntradaSaida.Create
   else if (NomeDaEntidade  = 'TItemDeletado')              then result := TRepositorioItemDeletado.Create
   else if (NomeDaEntidade  = 'TParametrosNFCe')            then result := TRepositorioParametrosNFCe.Create
   else if (NomeDaEntidade  = 'TNFCe')                      then result := TRepositorioNFCe.Create
   else if (NomeDaEntidade  = 'TConfiguracoesSistema')      then result := TRepositorioConfiguracoesSistema.Create
   else if (NomeDaEntidade  = 'TCliente')                   then result := TRepositorioCliente.Create
   else if (NomeDaEntidade  = 'TEndereco')                  then result := TRepositorioEndereco.Create
   else if (NomeDaEntidade  = 'TFornecedor')                then result := TRepositorioFornecedor.Create
   else if (NomeDaEntidade  = 'TCFOPCorrespondente')        then result := TRepositorioCFOPCorrespondente.Create
   else if (NomeDaEntidade  = 'TProdutoFornecedor')         then result := TRepositorioProdutoFornecedor.Create
   else if (NomeDaEntidade  = 'TPessoa')                    then result := TRepositorioPessoa.Create
   else if (NomeDaEntidade  = 'TSangriaReforco')            then result := TRepositorioSangriaReforco.Create
   else if (NomeDaEntidade  = 'TNotaFiscal')                then result := TRepositorioNotaFiscal.Create
   else if (NomeDaEntidade  = 'TItemNotaFiscal')            then result := TRepositorioItemNotaFiscal.Create
   else if (NomeDaEntidade  = 'TNaturezaOperacao')          then result := TRepositorioNaturezaOperacao.Create
   else if (NomeDaEntidade  = 'TCidade')                    then result := TRepositorioCidade.Create
   else if (NomeDaEntidade  = 'TEstado')                    then result := TRepositorioEstado.Create
   else if (NomeDaEntidade  = 'TConfiguracoesNF')           then result := TRepositorioConfiguracoesNF.Create
   else if (NomeDaEntidade  = 'TFormaPagamento')            then result := TRepositorioFormaPagamento.Create
   else if (NomeDaEntidade  = 'TIcms00')                    then result := TRepositorioIcms00.Create
   else if (NomeDaEntidade  = 'TIpiTrib')                   then result := TRepositorioIpiTrib.Create
   else if (NomeDaEntidade  = 'TPisAliq')                   then result := TRepositorioPisAliq.Create
   else if (NomeDaEntidade  = 'TCofinsAliq')                then result := TRepositorioCofinsAliq.Create
   else if (NomeDaEntidade  = 'TIcmsSn101')                 then result := TRepositorioIcmsSn101.Create
   else if (NomeDaEntidade  = 'TIpiNt')                     then result := TRepositorioIpiNt.Create
   else if (NomeDaEntidade  = 'TPisNt')                     then result := TRepositorioPisNt.Create
   else if (NomeDaEntidade  = 'TCofinsNt')                  then result := TRepositorioCofinsNt.Create
   else if (NomeDaEntidade  = 'TObservacaoNotaFiscal')      then result := TRepositorioObservacoesNotaFiscal.Create
   else if (NomeDaEntidade  = 'TTotaisNotaFiscal')          then result := TRepositorioTotaisNotaFiscal.Create
   else if (NomeDaEntidade  = 'TItemAvulso')                then result := TRepositorioItemAvulso.Create
   else if (NomeDaEntidade  = 'TLoteNFe')                   then result := TRepositorioLoteNfe.Create
   else if (NomeDaEntidade  = 'TNFe')                       then result := TRepositorioNFe.Create
   else if (NomeDaEntidade  = 'TRetornoLoteNFe')            then result := TRepositorioRetornoLoteNFe.Create
   else if (NomeDaEntidade  = 'TRetornoNFe')                then result := TRepositorioRetornoNFe.Create
   else if (NomeDaEntidade  = 'TVolumesNotaFiscal')         then result := TRepositorioVolumesNotaFiscal.Create
   else if (NomeDaEntidade  = 'TTransportadora')            then result := TRepositorioTransportadora.Create
   else if (NomeDaEntidade  = 'TCFOP')                      then result := TRepositorioCFOP.Create
   else if (NomeDaEntidade  = 'TConfiguracoesNFEmail')      then result := TRepositorioConfiguracoesNFEmail.Create
   else if (NomeDaEntidade  = 'TMateriaDoProduto')          then result := TRepositorioMateriaDoProduto.Create
   else if (NomeDaEntidade  = 'TLoteValidade')              then result := TRepositorioLoteValidade.Create
   else if (NomeDaEntidade  = 'TProdutoValidade')           then result := TRepositorioProdutoValidade.Create
   else if (NomeDaEntidade  = 'TQuantidadePorValidade')     then result := TRepositorioQuantidadePorValidade.Create

   else begin
     dm.LogErros.AdicionaErro('FabricaRepositorio', 'TExcecaoRepositorioNaoEncontrado', 'Reposit�rio para a '+ NomeDaEntidade + ' n�o foi encontrado!');
     raise TExcecaoRepositorioNaoEncontrado.Create(NomeDaEntidade);
   end;
end;

end.               
