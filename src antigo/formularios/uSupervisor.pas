unit uSupervisor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Usuario;

type
  TfrmSupervisor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    panInformacao: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    FSupervisor: TUsuario;
    mensagem   : String;
    Fusu       : TUsuario;

    procedure SetSupervisor(const Value: TUsuario);
    procedure VerificaUsuario;
    { Private declarations }
  public
    property Supervisor: TUsuario read FSupervisor write SetSupervisor;

  public
    class function LiberaFuncao(nPermissao: Integer): Boolean;

    property usu :TUsuario read Fusu;
  end;

var
  frmSupervisor: TfrmSupervisor;

implementation

uses Repositorio, RepositorioUsuario, EspecificacaoUsuarioComLoginIgualA, FabricaRepositorio, Criptografia;

{$R *.dfm}

procedure TfrmSupervisor.FormCreate(Sender: TObject);
begin
  self.Supervisor := nil;
end;

class function TfrmSupervisor.LiberaFuncao(nPermissao: Integer): Boolean;
var usu :TUsuario;
begin
  Result := false;
  usu := nil;
  
  Application.CreateForm(TfrmSupervisor, frmSupervisor);
  if frmSupervisor.ShowModal = mrOk then
    usu := frmSupervisor.Supervisor;
  frmSupervisor.Release;

  if (usu <> nil) and (Copy(usu.Perfil.Acesso, nPermissao, 1) <> 'S') then
    raise Exception.Create('Supervisor sem permissão para tal rotina!')
  else if (usu <> nil) then
    Result := true;

end;

procedure TfrmSupervisor.SetSupervisor(const Value: TUsuario);
begin
  FSupervisor := value;
end;

procedure TfrmSupervisor.VerificaUsuario;
var
    Rep           : TRepositorio;
    lLogin, lSenha: Boolean;
    Especificacao :TEspecificacaoUsuarioComLoginIgualA;
    cripto        :TCriptografia;
begin
    Fusu             := nil;
    rep             := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
    Especificacao   := TEspecificacaoUsuarioComLoginIgualA.Create(self.edtLogin.Text);
    Fusu            := TUsuario(Rep.GetPorEspecificacao(Especificacao));
    cripto          := nil;

{    Rep := TRepositorioUsuario.Create;
    usu   := TUsuario(Rep.Get(self.edtLogin.Text));}

    lLogin := false;
    lSenha := false;

    if Fusu <> nil then
      lLogin := true;

    if (lLogin) and (cripto.DesencriptRC4(Fusu.Senha) = self.edtSenha.Text) then
      lSenha := true;

    if (not lLogin) or (not lSenha) then
      FreeAndNil(Fusu);

    self.Supervisor := Fusu;

    if not lLogin then
      self.panInformacao.Caption := 'Login inválido!'
    else if not lSenha then
      begin
        self.panInformacao.Caption := 'Senha Inválida!';
        self.edtSenha.SelectAll;
      end
    else
      ModalResult := mrOk;

end;

procedure TfrmSupervisor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if      (Key = VK_RETURN) then
    begin
      Shift := [];
      Key   := 0;
      if edtSenha.Focused then
        self.VerificaUsuario
      else
        keybd_event(VK_TAB, 0, 0, 0);
    end
   else if (Key = VK_ESCAPE) then
    begin
      Shift := [];
      Key   := 0;
      self.Close();
    end; 
  end;

procedure TfrmSupervisor.FormDestroy(Sender: TObject);
begin
  FreeAndNil( Fusu );
end;

end.
