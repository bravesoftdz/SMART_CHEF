unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, ExtCtrls, jpeg, ImgList, pngimage;

type
  TfrmLogin = class(TfrmPadrao)
    Panel2: TPanel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    panInformacao: TPanel;
    Image1: TImage;

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  uModulo,
  Repositorio,
  Usuario,
  criptografia,
  EspecificacaoUsuarioComLoginIgualA,
  FabricaRepositorio,
  PermissoesAcesso;

{$R *.dfm}

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var user                  :TUsuario;
    rep                   :TRepositorio;
    cripto                :TCriptografia;
    Especificacao         :TEspecificacaoUsuarioComLoginIgualA;
begin
    if (key = 13) and (self.edtSenha.Focused) then
    begin
      rep                   := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
      Especificacao         := TEspecificacaoUsuarioComLoginIgualA.Create(self.edtLogin.Text);
      user                  := TUsuario(Rep.GetPorEspecificacao(Especificacao));
      cripto                := nil;

      try
        key := 0;

        if user = nil then
          begin
            panInformacao.Caption := 'O usuário informado é inválido';
            edtLogin.SetFocus;
            edtLogin.SelectAll;
            exit;
          end
        else if Trim(cripto.DesencriptRC4(user.Senha)) <> Trim(self.edtSenha.Text) then
          begin
            panInformacao.Caption :=  'A senha informada é inválida';
            edtSenha.SetFocus;
            edtSenha.SelectAll;
            exit;
          end
        else
          begin

            if user.Bloqueado then begin
              avisar('O usuário informado está bloqueado!');
              exit;
            end;
            
            dm.UsuarioLogado := user;

              try
                if not TPermissoesAcesso.VerificaPermissao(paLogarSistema, 'Usuário sem permissão para entrar no sistema!', true) then
                  begin
                    dm.UsuarioLogado := nil;
                    self.edtLogin.SetFocus;
                    self.edtLogin.SelectAll;
                    exit;
                  end
                else
                  self.ModalResult := mrOk;

              Except
                On E: Exception Do begin
                  panInformacao.Caption := E.Message;
                end;
              end;

          end;
      finally
        FreeAndNil(rep);
        FreeAndNil(cripto);
        FreeAndNil(Especificacao);
      end;
    end;

    inherited;
  end;

end.
