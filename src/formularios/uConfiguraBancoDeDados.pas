unit uConfiguraBancoDeDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, TipoBanco, IBServices, ImgList,
  pngimage, ExtCtrls;

type
  TfrmConfiguraBancoDeDados = class(TfrmPadrao)
    gbxConfiguracoes: TGroupBox;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    lblNomeServidor: TLabel;
    lblSenha: TLabel;
    lblPorta: TLabel;
    lblProtocolo: TLabel;
    lblUsuario: TLabel;
    gbxCaminho: TGroupBox;
    edtCaminho: TEdit;
    btnBuscarBanco: TBitBtn;
    edtNomeServidor: TEdit;
    edtPorta: TEdit;
    edtProtocolo: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnBuscarBancoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FMostraDados       :Procedure of Object;
    FGravaDados        :Procedure of Object;
    FInicioDaAplicacao :Boolean;

  private

    procedure MostraDadosBancoDeDados;

    procedure GravaDadosBancoDeDados;

    procedure Show;
    procedure ShowModal;
    function GetIsBancoConfigurado: Boolean;

  private
    function ValidaConfiguracoes :Boolean;

  public
    constructor Create(TipoBanco :TTipoBanco; InicioDaAplicacao :Boolean = false);

  public
    procedure AbreConfiguracao;

  public
    property isBancoConfigurado :Boolean read GetIsBancoConfigurado;
  end;
var
  frmConfiguraBancoDeDados: TfrmConfiguraBancoDeDados;

implementation

uses
  uModulo,
  ArquivoConfiguracao;

{$R *.dfm}

{ TfrmConfiguraBancoDeDados }

constructor TfrmConfiguraBancoDeDados.Create(TipoBanco :TTipoBanco; InicioDaAplicacao :Boolean = false);
const
  CORPO = 'Configure o banco ';
begin
   inherited Create(nil);

   self.ModalResult         := mrCancel;
   self.FInicioDaAplicacao  := InicioDaAplicacao;

   self.Caption      := CORPO + ' de dados';
   self.FMostraDados := self.MostraDadosBancoDeDados;
   self.FGravaDados  := self.GravaDadosBancoDeDados;
end;

procedure TfrmConfiguraBancoDeDados.GravaDadosBancoDeDados;
begin
   self.Fdm.ArquivoConfiguracao.CaminhoBancoDeDados      := self.edtCaminho.Text;
   self.Fdm.ArquivoConfiguracao.NomeServidorBancoDeDados := self.edtNomeServidor.Text;
   self.Fdm.ArquivoConfiguracao.UsuarioBancoDeDados      := self.edtUsuario.Text;
   self.Fdm.ArquivoConfiguracao.SenhaBancoDeDados        := self.edtSenha.Text;
   self.Fdm.ArquivoConfiguracao.PortaBancoDeDados        := StrToIntDef(self.edtPorta.Text, 0);
   self.Fdm.ArquivoConfiguracao.ProtocoloBancoDeDados    := self.edtProtocolo.Text;
   self.Fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal := ExtractFilePath(Application.ExeName)+'Dados\Base.fdb'
end;

procedure TfrmConfiguraBancoDeDados.MostraDadosBancoDeDados;
begin
   self.edtCaminho.Text       := self.Fdm.ArquivoConfiguracao.CaminhoBancoDeDados;
   self.edtNomeServidor.Text  := self.Fdm.ArquivoConfiguracao.NomeServidorBancoDeDados;
   self.edtPorta.Text         := IntToStr(self.Fdm.ArquivoConfiguracao.PortaBancoDeDados);
   self.edtProtocolo.Text     := self.Fdm.ArquivoConfiguracao.ProtocoloBancoDeDados;
   self.edtUsuario.Text       := self.Fdm.ArquivoConfiguracao.UsuarioBancoDeDados;
   self.edtSenha.Text         := self.Fdm.ArquivoConfiguracao.SenhaBancoDeDados;
end;

procedure TfrmConfiguraBancoDeDados.btnCancelarClick(Sender: TObject);
begin
  inherited;

  self.Close;
end;

procedure TfrmConfiguraBancoDeDados.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  if not self.ValidaConfiguracoes then exit;

  self.FGravaDados;
  self.ModalResult := mrOk;
end;

procedure TfrmConfiguraBancoDeDados.Show;
begin
   inherited Show;
end;

procedure TfrmConfiguraBancoDeDados.ShowModal;
begin
   inherited ShowModal;
end;

procedure TfrmConfiguraBancoDeDados.AbreConfiguracao;
begin
   self.ShowModal;
end;

procedure TfrmConfiguraBancoDeDados.btnBuscarBancoClick(Sender: TObject);
var
  Dialog :TOpenDialog;
begin
  inherited;

  try
    Dialog            := TOpenDialog.Create(nil);
    Dialog.Title      := 'Selecione o banco';
    Dialog.DefaultExt := 'fdb';
    Dialog.Filter     := 'Banco de dados Firebird | *.fdb';

    if Dialog.Execute then
      self.edtCaminho.Text := Dialog.FileName;
  finally
    FreeAndNil(Dialog);
  end;
end;

function TfrmConfiguraBancoDeDados.ValidaConfiguracoes: Boolean;
begin
   result := false;
   
   if (Trim(self.edtCaminho.Text) = '') then begin
      inherited avisar('Informe o caminho do arquivo de banco Firebird!');
      exit;
   end;

   if (Trim(self.edtNomeServidor.Text) = '') then begin
      inherited Avisar('Informe o nome do servidor!');
      self.edtNomeServidor.SetFocus;
      exit;
   end;

   if (Trim(self.edtPorta.Text) = '') then begin
      inherited Avisar('Informe a porta!');
      self.edtPorta.SetFocus;
      exit;
   end;

   if (Trim(self.edtProtocolo.Text) = '') then begin
      inherited Avisar('Informe o protocolo!');
      self.edtProtocolo.SetFocus;
      exit;
   end;

   if (Trim(self.edtUsuario.Text) = '') then begin
      inherited Avisar('Informe o usuário!');
      self.edtUsuario.SetFocus;
      exit;
   end;

   if (Trim(self.edtSenha.Text) = '') then begin
      inherited Avisar('Informe a senha!');
      self.edtSenha.SetFocus;
      exit;
   end;

   result := true;
end;

function TfrmConfiguraBancoDeDados.GetIsBancoConfigurado: Boolean;
begin
   result := (self.ModalResult = mrOk);
end;

procedure TfrmConfiguraBancoDeDados.FormShow(Sender: TObject);
begin
  inherited;

  if self.FInicioDaAplicacao then
    inherited Avisar('Não foi possível conectar no banco de dados! Configure corretamente o banco!');
  
  self.FMostraDados;
end;

end.
