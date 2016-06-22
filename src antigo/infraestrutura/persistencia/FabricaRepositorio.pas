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
  RepositorioProdutoDependenciaEst;


{ TFabricaRepositorio }

class function TFabricaRepositorio.GetRepositorio(NomeDaEntidade: String) :TRepositorio;
begin
   result           := nil;
   NomeDaEntidade   := Trim(NomeDaEntidade);

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
   else if (NomeDaEntidade  = 'TProdutoDependenciaEst')     then result := TRepositorioProdutoDependenciaEst.Create   

   else begin
     dm.LogErros.AdicionaErro('FabricaRepositorio', 'TExcecaoRepositorioNaoEncontrado', 'Repositório para a '+ NomeDaEntidade + ' não foi encontrado!');
     raise TExcecaoRepositorioNaoEncontrado.Create(NomeDaEntidade);
   end;
end;

end.
