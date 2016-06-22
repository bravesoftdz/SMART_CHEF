unit PermissoesAcesso;

interface

uses Usuario;

type
  TPermissoesAcesso = class
  public
    class function VerificaPermissao(nPermissao: Integer): Boolean; overload;
    class function VerificaPermissao(nPermissao: Integer; lPedeSupervisor: Boolean): Boolean; overload;
    class function VerificaPermissao(nPermissao: Integer; cMens: String; lPedeSupervisor: Boolean): Boolean; overload;
    class function VerificaPermissao(nPermissao: Integer; cMens: String; lMensagem: Boolean; lPedeSupervisor: Boolean): Boolean; overload;
  end;

const
  paLogarSistema                 = 1;
  paCadastroPerfil               = 2;
  paCadastroUsuario              = 3;
  paAlterarUsuario               = 4;
  paCadastroGrupo                = 5;
  paCadastroMateriaPrima         = 6;
  paCadastroProduto              = 7;
  paCriaPedido                   = 8;
  paDadosEmpresa                 = 9;
  paOperaCaixa                   = 10;
  paCadastroDepartamento         = 11;
  paTelaImpressoesPendentes      = 12;
  paConfiguraECF                 = 13;
  paTelaNFce                     = 14;
  paRelatorioVendas              = 15;
  paTelaPedidosEmAberto          = 16;
  paCadastroComanda              = 17;
  paCadastroDispensa             = 18;
  paEntradaSaidaMercadoria       = 19;
  paLiberarComanda               = 20;
  paRelatorioAtendimentos        = 21;
  paRelatorioPedidos             = 22;
  paRelatorioEstoque             = 23;
  paRelatorioEntradaSaida        = 24;
  paRelatorioCaixa48Colunas      = 25;
  paRelatorioItensDeletados      = 26;
  paConfigurarSistema            = 27;
  paCadastroCliente              = 28;
  paRelatorioProdutos            = 29;

implementation

uses SysUtils, USupervisor, uModulo, uPadrao;

class function TPermissoesAcesso.VerificaPermissao(nPermissao: Integer; lPedeSupervisor: Boolean): Boolean;
var cMens: String;
begin
  if dm.UsuarioLogado = nil then
    cMens  := 'Você não tem permissão para acessar esta rotina!'
  else
    cMens  := Trim(dm.UsuarioLogado.Nome) + #13 + ' Você não tem permissão para acessar esta rotina!';

  Result := VerificaPermissao(nPermissao, cMens, lPedeSupervisor);
end;

class function TPermissoesAcesso.VerificaPermissao(nPermissao: Integer; cMens: String; lPedeSupervisor: Boolean): Boolean;
begin
  try
    Result := self.VerificaPermissao(nPermissao, cMens, True, lPedeSupervisor);
  Except
    On E: Exception Do begin
        raise Exception.Create(e.Message);
    end;
  end;
end;

class function TPermissoesAcesso.VerificaPermissao(nPermissao: Integer; cMens: String; lMensagem: Boolean; lPedeSupervisor: Boolean): Boolean;
var cMenSup, msgRetorno: String;
begin

  Result := false;

  if dm.UsuarioLogado = nil then
    begin
      if lMensagem then
        raise Exception.Create('Não há usuário logado no sistema!');
      exit;
    end
  else if dm.UsuarioLogado.Perfil = nil then
    begin
      if lMensagem then
        raise Exception.Create('O usuário logado não tem um perfil definido!');
      exit;
    end;

  if (Copy(dm.UsuarioLogado.Perfil.Acesso, nPermissao, 1) <> 'S') then
    begin
      cMenSup := '';

      if lPedeSupervisor then
        cMenSup := #13#13 + ' Contate o seu supervisor para liberar o acesso!';

      if (lMensagem) then
        begin
          if (Length(Trim(cMenSup)) > 0) then
            msgRetorno := cMens + cMenSup
          else
            msgRetorno := Trim(cMens);
        end
      else if lPedeSupervisor then
        msgRetorno := cMenSup;


      if (lPedeSupervisor) and (TfrmSupervisor.LiberaFuncao(nPermissao)) then
        Result := true
      else
         //TfrmPadrao.Create(nil).avisar(msgRetorno);
        raise Exception.Create(msgRetorno);

      exit;
    end
  else
    Result := true;
end;

class function TPermissoesAcesso.VerificaPermissao(nPermissao: Integer): Boolean;
begin
  Result := TPermissoesAcesso.VerificaPermissao(nPermissao, true);
end;

end.
