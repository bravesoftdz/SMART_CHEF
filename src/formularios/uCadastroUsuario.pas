unit uCadastroUsuario;

interface
                                                                                                    
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, Provider, DB, DBClient, Grids, DBGrids, DBGridCBN,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, frameListaCampo,
  Criptografia, Repositorio, Usuario, FireDAC.Comp.Client, ImgList, pngimage,
  System.ImageList;

type
  TfrmCadastroUsuario = class(TfrmPadrao)
    panBotoes: TPanel;
    pagUsuarios: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ds: TDataSource;
    cds: TClientDataSet;
    dsp: TDataSetProvider;
    GridUsuarios: TDBGridCBN;
    cdsCODIGO: TIntegerField;
    cdsNOME: TStringField;
    cdsLOGIN: TStringField;
    cdsSENHA: TStringField;
    cdsCOD_PERFIL: TIntegerField;
    cdsPERFIL: TStringField;
    groDados: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListaCampo1: TListaCampo;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    panSenha: TPanel;
    Label5: TLabel;
    edtConfirmaSenha: TEdit;
    Shape1: TShape;
    Shape2: TShape;
    Label6: TLabel;
    Label7: TLabel;
    cdsBLOQUEADO: TStringField;
    Image2: TImage;
    Label18: TLabel;
    Image1: TImage;
    Label17: TLabel;
    ImageList1: TImageList;
    lblCamposObrigatorios: TLabel;
    btnSalvar: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnBloquear: TBitBtn;
    btnCancelar: TSpeedButton;
    ListaCampo2: TListaCampo;
    cdsCODIGO_DEPARTAMENTO: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtConfirmaSenhaChange(Sender: TObject);
    procedure btnBloquearClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pagUsuariosChange(Sender: TObject);
    procedure GridUsuariosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure cdsAfterScroll(DataSet: TDataSet);
    procedure GridUsuariosColEnter(Sender: TObject);
  private
    crip :TCriptografia;
    Usuario :TUsuario;
    rep :TRepositorio;

    procedure limpaCampos;
    procedure mostraCampos;
    procedure salvar;
    procedure habilita(SN:Boolean);
  public
    { Public declarations }
  end;

var
  frmCadastroUsuario: TfrmCadastroUsuario;

implementation

uses RepositorioUsuario, PermissoesAcesso;

{$R *.dfm}

procedure TfrmCadastroUsuario.FormShow(Sender: TObject);
begin
  inherited;
  pagUsuarios.ActivePageIndex := 0;

  cds.Close;
  dsp.DataSet := FDM.GetConsulta('SELECT U.CODIGO, U.NOME, U.LOGIN, U.SENHA, U.COD_PERFIL, P.NOME PERFIL, '+
                                 'IIF(U.BLOQUEADO = ''S'',''S'',''N'') BLOQUEADO, U.CODIGO_DEPARTAMENTO '+
                                 '       FROM USUARIOS U                                                '+
                                 'LEFT JOIN PERFIS P ON P.CODIGO = U.COD_PERFIL                         ');


  cds.Open;

  ListaCampo1.setValores('select * from perfis', 'nome', 'Perfis');
  Listacampo1.executa;

  ListaCampo2.setValores('select * from departamentos', 'nome', 'Departamento');
  Listacampo2.executa;

  GridUsuarios.SetFocus;
end;

procedure TfrmCadastroUsuario.btnIncluirClick(Sender: TObject);
begin
  inherited;
  self.Tag := 1;
  GridUsuarios.SetFocus;
  limpaCampos;
  pagUsuarios.ActivePageIndex := 1;
end;

procedure TfrmCadastroUsuario.TabSheet2Enter(Sender: TObject);
begin
  inherited;
  if not (self.Tag in [1,2]) then
    habilita(false)
  else begin
    if self.Tag = 2 then
      mostraCampos;

    habilita(true);
  end;

  Rep := TRepositorioUsuario.Create;
  Usuario   := TUsuario.Create;


end;

procedure TfrmCadastroUsuario.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if ( fdm.UsuarioLogado.Codigo = cdsCODIGO.AsInteger ) or
       TPermissoesAcesso.VerificaPermissao(paAlterarUsuario, 'Usuário sem permissão para alterar Usuários!', false)
  then begin
    self.Tag := 2;
    pagUsuarios.ActivePageIndex := 0;
    GridUsuarios.SetFocus;
    pagUsuarios.ActivePageIndex := 1;
  end;  
end;

procedure TfrmCadastroUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  crip := TCriptografia.Create;
end;

procedure TfrmCadastroUsuario.limpaCampos;
begin
  edtNome.Clear;
  edtLogin.Clear;
  edtSenha.Clear;
  edtConfirmaSenha.Clear;
  ListaCampo1.comListaCampo.ItemIndex := -1;
  ListaCampo2.comListaCampo.ItemIndex := -1;
end;

procedure TfrmCadastroUsuario.btnSalvarClick(Sender: TObject);
begin
  inherited;

  if edtNome.Text = '' then begin
    avisar('Informe o nome do Usuário!');
    edtNome.setFocus;
  end
  else
    if edtLogin.Text = '' then begin
      avisar('Informe o Login Usuário!');
      edtLogin.setFocus;
  end
  else
    if ListaCampo1.comListaCampo.ItemIndex < 0 then begin
      avisar('É necessário vincular o usuário a um perfil!');
      ListaCampo1.comListaCampo.setFocus;
  end
  else
    if ListaCampo2.comListaCampo.ItemIndex < 0 then begin
      avisar('É necessário vincular o usuário a um departamento!');
      ListaCampo2.comListaCampo.setFocus;
  end
  else
    if edtSenha.Text = '' then begin
      avisar('É necessário inserir uma senha para o usuário!');
      edtSenha.setFocus;
  end
  else if edtSenha.Text <> edtConfirmaSenha.Text then begin
    if panSenha.Visible then
      avisar('Senha de confirmação não bate, favor redigitar!');
    edtConfirmaSenha.Clear;
    panSenha.Visible := true;
    edtConfirmaSenha.SetFocus;
  end
  else
    salvar;
end;

procedure TfrmCadastroUsuario.salvar;
begin
  if self.Tag = 2 then //alterando
    Usuario.Codigo := cdsCODIGO.asInteger;

  Usuario.Nome      := edtNome.Text;
  Usuario.Login     := edtLogin.Text;
  Usuario.Senha     := crip.EncriptRC4(edtSenha.Text);
  Usuario.CodPerfil := ListaCampo1.CodCampo;
  Usuario.Codigo_departamento := ListaCampo2.CodCampo;

  Rep.Salvar(Usuario);

  if self.Tag = 1 then
    Usuario.codigo := 0;

//  if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
 //   Rep.Salvar_2(Usuario);

  cds.Close;
  cds.Open;

  btnCancelar.Click;

  self.avisar('Operação realizada com sucesso!');
end;

procedure TfrmCadastroUsuario.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pagUsuarios.ActivePageIndex := 0;
  self.TAG := 0;
  ListaCampo1.comListaCampo.ItemIndex := -1;
  ListaCampo2.comListaCampo.ItemIndex := -1;
 // panSenha.Visible := false;
  habilita(false);
  
  if not (Usuario = nil) then
    FreeAndNil(Usuario);
  if not (Rep = nil) then
    FreeAndNil(Rep);
end;

procedure TfrmCadastroUsuario.edtConfirmaSenhaChange(Sender: TObject);
begin
  inherited;

    if edtSenha.Text <> edtConfirmaSenha.Text then
      edtConfirmaSenha.Font.Color := clMaroon
    else
      edtConfirmaSenha.Font.Color := clGreen;

end;

procedure TfrmCadastroUsuario.btnBloquearClick(Sender: TObject);
var qry :TFDQuery;
    msg :String;
begin
  try
    inherited;

    qry := FDM.GetConsulta('update USUARIOS set bloqueado = iif((select bloqueado from USUARIOS where codigo = :cod) = ''S'',''N'',''S'') '+
                           'where codigo = :cod');
    qry.ParamByName('cod').AsInteger := cdsCODIGO.AsInteger;
    qry.ExecSQL;

    if cdsBLOQUEADO.AsString = 'S' then
      avisar('Usuário '+ cdsNOME.AsString +' foi desbloqueado!')
    else
      avisar('Usuário '+ cdsNOME.AsString +' foi bloqueado!');

    cds.Close;
    cds.Open;

  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmCadastroUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = vk_F1 then
    pagUsuarios.ActivePageIndex := 0
  else if key = vk_F2 then
    pagUsuarios.ActivePageIndex := 1
  else if (key = VK_F3)and(btnIncluir.Enabled) then
    btnIncluir.Click
  else if (key = VK_F4)and(btnAlterar.Enabled) then
    btnAlterar.Click;    
end;

procedure TfrmCadastroUsuario.habilita(SN: Boolean);
begin
  if SN then begin
    groDados.Enabled    := true;
    btnIncluir.Enabled  := false;
    btnAlterar.Enabled  := false;
    btnBloquear.Enabled := false;
    btnCancelar.Enabled := true;
    btnSalvar.Enabled   := true;
  end
  else begin
    groDados.Enabled    := false;
    btnIncluir.Enabled  := true;
    btnAlterar.Enabled  := true;
    btnBloquear.Enabled := true;
    btnCancelar.Enabled := false;
    btnSalvar.Enabled   := false;
  end;
end;

procedure TfrmCadastroUsuario.pagUsuariosChange(Sender: TObject);
begin
  if pagUsuarios.ActivePageIndex = 1 then
    TabSheet2Enter(nil);
end;

procedure TfrmCadastroUsuario.GridUsuariosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsBLOQUEADO then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsBLOQUEADO.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 1, true)
    else
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true);
  end;
end;

procedure TfrmCadastroUsuario.mostraCampos;
begin
  edtNome.Text          := cdsNOME.AsString;
  edtLogin.Text         := cdsLOGIN.AsString;
  ListaCampo1.CodCampo  := cdsCOD_PERFIL.AsInteger;
  ListaCampo2.CodCampo  := cdsCODIGO_DEPARTAMENTO.AsInteger;
  edtSenha.Text         := crip.DesencriptRC4(cdsSENHA.AsString);
  edtConfirmaSenha.Text := edtSenha.Text;
end;

procedure TfrmCadastroUsuario.cdsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if cdsBLOQUEADO.AsString = 'S' then
    btnBloquear.Caption := 'Desbloquear'
  else
    btnBloquear.Caption := 'Bloquear';
end;

procedure TfrmCadastroUsuario.GridUsuariosColEnter(Sender: TObject);
begin
  if TDBGridCBN(Sender).SelectedIndex = 0 then
    TDBGridCBN(Sender).SelectedIndex := 1;
end;

end.
