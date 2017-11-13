unit uPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModulo, stdCtrls, DBCtrls, Mask, RXCurrEdit, PermissoesAcesso,
  ExtCtrls, ComCtrls, ImgList, pngimage, TipoDado;

type
  TfrmPadrao = class(TForm)
    pnlPropaganda: TPanel;
    imgPropaganda: TImage;
    Shape8: TShape;

    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    
  private
    FFecharComEsc: Boolean;
    FaguardaAtivo :Boolean;

  private
    procedure SetFecharComEsc(const Value: Boolean);
    procedure padraoConfiguraGrid;

  protected
    procedure KeyDownPadrao(Sender: TObject; var Key: Word; Shift: TShiftState);

  public
    function chamaInput(pTipoDado :TTipoDado; titulo: string):Variant;
    function confirma(mensagem:String) :Boolean;

  public
    procedure AbreForm(frm: TFormClass;
                       permissao :integer;
                       const msg_retorno :String = 'Usuário sem permissão para acessar esta funcionalidade!';
                       const pede_supervisor :boolean = false);
    procedure AbrirArquivo(const CaminhoCompletoDoArquivo :String);
    procedure avisar(mensagem:String; const tempoEspera :integer = 0; const semAtalho :String = ''; const tipo :Integer = 0);
    procedure Aguarda(mensagem :String);
    procedure FimAguarda(mensagem :String);

  public
    constructor Create(AOwner :TComponent); override;

  protected
    Fdm :Tdm;

    property FecharComEsc :Boolean read FFecharComEsc write SetFecharComEsc;
end;

var
  frmPadrao: TfrmPadrao;

implementation

uses
  uInputBox,
  uAvisar,
  uAguarde,
  uConfirmacaoUsuario,
  DBGridCBN,
  ConfigCores,
  Masks,
  ShellApi, SyncObjs;

{$R *.dfm}

{ TfrmPadrao }

procedure TfrmPadrao.avisar(mensagem: String; const tempoEspera: integer; const semAtalho :String; const tipo :Integer);
begin
  frmAvisar := TfrmAvisar.Create(self, TRIM(mensagem), tempoEspera, semAtalho, tipo);
  frmAvisar.ShowModal;
  frmAvisar.Release;
  frmAvisar := nil;
end;

function TfrmPadrao.chamaInput(pTipoDado :TTipoDado; titulo: string):Variant;
begin
  frmInputBox := TfrmInputBox.Create(Self, titulo, pTipoDado);
  if frmInputBox.ShowModal = mrOk then
    Result := frmInputBox.Retorno;
  frmInputBox.Release;
  frmInputBox := nil;
end;

procedure TfrmPadrao.AbreForm(frm: TFormClass; permissao :integer; const msg_retorno :String; const pede_supervisor :boolean);
var lFrm : TForm;
begin
   try

   TPermissoesAcesso.VerificaPermissao(permissao, msg_retorno, pede_supervisor);


      lFrm := frm.Create(nil);
      lFrm.ShowModal;

       if Assigned( lFrm ) then
        begin
           lFrm.Release;
           lFrm := nil;
        end;

   except
    on e : Exception do
        Avisar('* * * * * * * * * * A tela não pode ser exibida * * * * * * * * * *'+#13#10+#13#10+e.Message);
   end;
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  Fdm := dm;
  self.FaguardaAtivo := false;
  padraoConfiguraGrid;
end;

procedure TfrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if      (Key = VK_RETURN) then
    begin
       Shift := [];
       Key   := 0;
       keybd_event(VK_TAB, 0, 0, 0);
    end
   else if (Key = VK_ESCAPE) and self.FFecharComEsc then
    begin
       Shift := [];
       Key   := 0;
       TForm(Sender).Close();
    end;
end;

function TfrmPadrao.confirma(mensagem: String): Boolean;
begin
  Result := false;
  
  frmConfirmacaoUsuario := TfrmConfirmacaoUsuario.Create(self);
  frmConfirmacaoUsuario.memMsg.Text := mensagem;

  if frmConfirmacaoUsuario.ShowModal = mrOk then
    result := true;

  frmConfirmacaoUsuario.Release;
  frmConfirmacaoUsuario := nil;
end;

procedure TfrmPadrao.padraoConfiguraGrid;
var i :integer;
begin
  for i := 0 to ComponentCount-1 do begin
    if Components[I] is TDBGridCBN then begin
      TDBGridCBN(Components[i]).ConfCores.Destacado.CorFonte := clwhite;
      TDBGridCBN(Components[i]).ConfCores.Destacado.CorFundo := $00CB7834;//$00917E6F;
      TDBGridCBN(Components[i]).ConfCores.Selecao.CorFonte   := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Selecao.CorFundo   := $00F0E3D5;
      TDBGridCBN(Components[i]).ConfCores.Normal.CorFonte    := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Normal.CorFundo    := clWhite;
      TDBGridCBN(Components[i]).ConfCores.Zebrada.CorFonte   := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Zebrada.CorFundo   := $00F4F4F4;
      TDBGridCBN(Components[i]).ConfCores.Titulo.Tipo.Style  := [fsBold];
      TDBGridCBN(Components[i]).ConfCores.Titulo.CorFonte    := $003A3A3A;
    end;
  end;
end;

procedure TfrmPadrao.KeyDownPadrao(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   self.FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmPadrao.AbrirArquivo(const CaminhoCompletoDoArquivo:String);
begin
    ShellExecute(handle, 'open', PChar(CaminhoCompletoDoArquivo), '','',SW_SHOWNORMAL);
end;

procedure TfrmPadrao.SetFecharComEsc(const Value: Boolean);
begin
  FFecharComEsc := Value;
end;

constructor TfrmPadrao.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   self.FFecharComEsc := true;
end;

procedure TfrmPadrao.Aguarda(mensagem: String);
begin

  if frmAguarde = nil then begin
    frmAguarde := TfrmAguarde.Create(nil, mensagem);
    frmAguarde.Show;
  end
  else
    frmAguarde.memoAguarde.Text := mensagem;

  self.FaguardaAtivo := true;
end;

procedure TfrmPadrao.FimAguarda(mensagem :String);
begin
  if self.FaguardaAtivo then begin
    frmAguarde.memoAguarde.Text := mensagem;

    Application.ProcessMessages;

    if mensagem <> '' then
      sleep(3000);

    self.FaguardaAtivo := false;
    frmAguarde.Release;
    frmAguarde := nil;
  end;

end;

end.
