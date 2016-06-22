unit uCadastroPerfilAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids,
  DBGrids, DBGridCBN, ComCtrls, ExtCtrls, StdCtrls, Buttons, Perfil, Repositorio, StrUtils,
  ImgList, pngimage;

type
  TfrmCadastroPerfilAcesso = class(TfrmPadrao)
    pagPerfis: TPageControl;
    TabSheet1: TTabSheet;
    cds: TClientDataSet;
    ds: TDataSource;
    dsp: TDataSetProvider;
    TabSheet4: TTabSheet;
    cdsCODIGO: TIntegerField;
    cdsNOME: TStringField;
    cdsACESSO: TStringField;
    panBusca: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    edtBusca: TEdit;
    edtEncontrados: TEdit;
    btProximo: TBitBtn;
    gridPerfis: TDBGridCBN;
    panNomePerfil: TPanel;
    Label3: TLabel;
    edtNomePerfil: TEdit;
    pagFuncionalidades: TPageControl;
    TabSheet3: TTabSheet;
    chk1: TCheckBox;
    panBotoes: TPanel;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    chk4: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk5: TCheckBox;
    chk6: TCheckBox;
    chk7: TCheckBox;
    TabSheet2: TTabSheet;
    chk8: TCheckBox;
    chk9: TCheckBox;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    chk10: TCheckBox;
    chk11: TCheckBox;
    chk12: TCheckBox;
    chk13: TCheckBox;
    chk15: TCheckBox;
    chk16: TCheckBox;
    chk17: TCheckBox;
    chk18: TCheckBox;
    TabSheet5: TTabSheet;
    chk19: TCheckBox;
    chk20: TCheckBox;
    chk21: TCheckBox;
    chk22: TCheckBox;
    chk23: TCheckBox;
    chk24: TCheckBox;
    chk25: TCheckBox;
    chk26: TCheckBox;
    chk14: TCheckBox;
    chk27: TCheckBox;
    chk28: TCheckBox;
    chk29: TCheckBox;
    chk30: TCheckBox;
    chk31: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btProximoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure TabSheet4Enter(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtBuscaClick(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabSheet1Exit(Sender: TObject);
  private
    Perfil :TPerfil;
    rep :TRepositorio;
    qtdPermissoes : Integer;
    chkSelecionado :String;

    procedure buscaFuncionalidade;
    procedure mostraFuncionalidades;
    procedure habilitaTabs(yn :Boolean);
    procedure incluir;
    procedure alterar;
    procedure salvar;
    procedure habilitar(SN:Boolean);

    function concatenaAcesso :String;
  public
    { Public declarations }
  end;

var
  frmCadastroPerfilAcesso: TfrmCadastroPerfilAcesso;

implementation

uses
  FabricaRepositorio, uModulo;

{$R *.dfm}

procedure TfrmCadastroPerfilAcesso.FormShow(Sender: TObject);
var nx :integer;
begin
  inherited;
  pagPerfis.ActivePageIndex := 0;
  pagFuncionalidades.ActivePageIndex := 0;

  QtdPermissoes  := 0;
  chkSelecionado := '';

  for nx := 0 to ComponentCount-1 do begin

    if ( Components[nx] is TCheckBox ) then   inc(QtdPermissoes);

  end;

  cds.Close;                                          //escluindo o master usuario
  dsp.DataSet := FDM.GetConsulta('SELECT * FROM PERFIS WHERE CODIGO > 1');
  cds.Open;

  GridPerfis.SetFocus;
end;

procedure TfrmCadastroPerfilAcesso.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if      (key = VK_F1)                          then   pagPerfis.ActivePageIndex := 0
  else if (key = VK_F2)                          then   pagPerfis.ActivePageIndex := 1
  else if (key = VK_F3) and (btnIncluir.Enabled) then   btnIncluir.Click
  else if (key = VK_F4) and (btnAlterar.Enabled) then   btnAlterar.Click;
end;

procedure TfrmCadastroPerfilAcesso.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
    if (pagPerfis.ActivePageIndex = 1) and not (edtNomePerfil.Focused) then begin

      if ( key = #8 ) then   edtBusca.Text := copy(edtBusca.Text,1,length(edtBusca.Text)-1)
                      else   edtBusca.Text := uppercase(edtBusca.Text + key);

      if ( chkSelecionado <> '' ) then   TCheckBox(self.FindComponent(chkSelecionado)).Font.Style :=[];

      if trim(edtBusca.text) <> '' then   buscaFuncionalidade
      else
        if edtEncontrados.Text <> '0' then begin
          btProximo.Enabled := false;
          edtEncontrados.Text := '0';
        end;

    end;
end;

procedure TfrmCadastroPerfilAcesso.buscaFuncionalidade;
var nx, encontrados :integer;
    func :String;
begin
  encontrados := 0;
  func := trim(edtBusca.text);

  for nX := 1 to qtdPermissoes do
    begin
      if ( self.FindComponent('chk' + IntToStr(nX)) <> nil ) and
         ( pos(UpperCase(func), UpperCase(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Caption)) <> 0 ) then   Inc(encontrados);

    end;

    edtEncontrados.Text := intToStr(encontrados);

  if ( encontrados > 1 ) then begin
    edtEncontrados.Text := '1/'+intToStr(encontrados);
    btProximo.enabled := true;
  end
  else if ( encontrados <= 1 ) then
    btProximo.Enabled := false;

  for nX := 1 to qtdPermissoes do
    begin

      if ( self.FindComponent('chk' + IntToStr(nX)) <> nil ) and
         ( pos(UpperCase(func), UpperCase(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Caption)) <> 0 ) then
         begin
            pagFuncionalidades.ActivePage := TTabSheet(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Parent);

            if ( TTabSheet(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Parent).Enabled ) then
              TCheckBox(self.FindComponent('chk' + IntToStr(nX))).SetFocus;

            TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Color := clBlue;
            TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Color      := clYellow;
            TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Style := [fsBold];

            chkSelecionado := 'chk'+intToStr(nx);
            break;
         end;

    end;
end;

procedure TfrmCadastroPerfilAcesso.alterar;
begin
  Rep := TFabricaRepositorio.GetRepositorio(TPerfil.ClassName);

  if ( cds.fieldByName('CODIGO').AsInteger > 0 ) then    Perfil   := TPerfil(Rep.Get(cds.fieldByName('CODIGO').AsInteger));

  if ( assigned(Perfil) )                        then    mostraFuncionalidades;
end;

procedure TfrmCadastroPerfilAcesso.incluir;
begin
  Rep := TFabricaRepositorio.GetRepositorio(TPerfil.ClassName);
  Perfil   := TPerfil.Create;
end;

procedure TfrmCadastroPerfilAcesso.mostraFuncionalidades;
var nx :integer;
begin
  for nX := 1 to qtdPermissoes do
    begin
      if (self.FindComponent('chk' + IntToStr(nX)) <> nil) then
         TCheckBox(self.FindComponent('chk' + IntToStr(nX))).checked := (copy(self.Perfil.Acesso,nx,1) = 'S');
    end;
end;

procedure TfrmCadastroPerfilAcesso.btProximoClick(Sender: TObject);
var vez, nx :integer;
    func, itemDaVez, itensEncontrados :String;
begin
  inherited;
  vez              := 0;
  func             := trim(edtBusca.text);
  itemDaVez        := copy(edtEncontrados.Text,1,pos('/',edtEncontrados.Text)-1);
  itensEncontrados := copy(edtEncontrados.Text,pos('/',edtEncontrados.Text)+1,3);

  {  se for ultimo item volta para o primeiro  }
  if ( itemDaVez = itensEncontrados ) then   edtEncontrados.Text := '1/'+ copy(edtEncontrados.Text,pos('/',edtEncontrados.Text)+1,3)
  else
    edtEncontrados.Text := intToStr(strToInt(copy(edtEncontrados.Text,1,pos('/',edtEncontrados.Text)-1)) + 1)+'/'+
                           copy(edtEncontrados.Text,pos('/',edtEncontrados.Text)+1,3);

  for nX := 1 to qtdPermissoes do
    begin

      if ( self.FindComponent('chk' + IntToStr(nX)) <> nil ) and
         ( pos(UpperCase(func), UpperCase(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Caption)) <> 0 ) then
         begin

            inc(vez);

            {   Se é o item da vez   }
            if ( strToInt( copy( edtEncontrados.Text, 1, pos('/',edtEncontrados.Text)-1 ) ) = vez ) then
              begin

                 pagFuncionalidades.ActivePage := TTabSheet( TCheckBox( self.FindComponent('chk' + IntToStr(nX)) ).Parent );

                 if ( TTabSheet(TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Parent).Enabled ) then
                   TCheckBox(self.FindComponent('chk' + IntToStr(nX))).SetFocus;

                 TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Color := clBlue;
                 TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Color      := clYellow;
                 TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Style := [fsBold];
                 TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Size  := 10;

                 chkSelecionado := 'chk'+intToStr(nx);

                 continue;
              end;
         end;

       TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Style := [];
       TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Font.Size  := 8;
    end;

end;

procedure TfrmCadastroPerfilAcesso.btnIncluirClick(Sender: TObject);
begin
  inherited;

  self.Tag                  := 1;
  pagPerfis.ActivePageIndex := 0;
  gridPerfis.SetFocus;
  pagPerfis.ActivePageIndex := 1;
end;

procedure TfrmCadastroPerfilAcesso.btnAlterarClick(Sender: TObject);
begin
  inherited;
  self.Tag                  := 2;
  pagPerfis.ActivePageIndex := 0;
  gridPerfis.SetFocus;
  pagPerfis.ActivePageIndex := 1;
end;

procedure TfrmCadastroPerfilAcesso.TabSheet4Enter(Sender: TObject);
begin
  inherited;

  edtNomePerfil.Text := cdsNOME.AsString;

  if ( self.TAG = 1 ) then begin
    incluir;
    edtNomePerfil.Clear;
  end
  else if ( self.Tag = 2 ) then   alterar;

  if ( self.Tag = 0 ) then   habilitar(false)
                      else   habilitar(true);

end;

procedure TfrmCadastroPerfilAcesso.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if ( trim(edtNomePerfil.Text) = '' ) then begin
      self.avisar('É necessário informar um nome para o perfil!');
      edtNomePerfil.SetFocus;
      exit;
  end
  else   salvar;
end;

procedure TfrmCadastroPerfilAcesso.salvar;
var acesso :String;
begin
  try
    if ( trim(edtNomePerfil.Text) = '' ) then begin
      self.avisar('É necessário informar um nome para o perfil!');
      edtNomePerfil.SetFocus;
      exit;
    end;

    if (self.Tag = 1) and (Rep.GetExiste('nome',trim(edtNomePerfil.Text))) then begin
      self.avisar('Nome do perfil ja existe, favor alterar.');
      edtNomePerfil.SetFocus;
      exit;
    end;

    acesso        := concatenaAcesso;
    Perfil.Acesso := acesso + DupeString('N',1000-length(acesso));
    Perfil.Nome   := trim(edtNomePerfil.Text);

    {  Alterando  }
    if self.Tag = 2 then   Perfil.Codigo := cdsCODIGO.asInteger;

    Rep.Salvar(Perfil);

    if self.Tag = 1 then
       Perfil.codigo := 0;

    if (dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       Rep.Salvar_2(Perfil);

    cds.Close;
    cds.Open;

    btnCancelar.Click;
    FreeAndNil(Perfil);
    FreeAndNil(Rep);

    self.avisar('Operação realizada com sucesso!');

  Except
    self.avisar('Falha ao gravar perfil!');
  end;
end;

function TfrmCadastroPerfilAcesso.concatenaAcesso: String;
var nx:integer;
begin
  Result := '';

  for nX := 1 to qtdPermissoes do
    begin
      if  (self.FindComponent('chk' + IntToStr(nX)) <> nil) then

         if ( TCheckBox(self.FindComponent('chk' + IntToStr(nX))).Checked ) then   Result := Result + 'S'
         else   Result := Result + 'N';
    end;
end;

procedure TfrmCadastroPerfilAcesso.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pagPerfis.ActivePageIndex := 0;
  self.TAG                  := 0;
  edtNomePerfil.Clear;
  habilitar (false);
  FreeAndNil(Perfil);
  FreeAndNil(Rep);
end;

procedure TfrmCadastroPerfilAcesso.edtBuscaClick(Sender: TObject);
begin
  inherited;
  panNomePerfil.SetFocus;
end;

procedure TfrmCadastroPerfilAcesso.Shape1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  edtBuscaClick(nil);
end;

procedure TfrmCadastroPerfilAcesso.TabSheet1Exit(Sender: TObject);
begin
  inherited;
  TabSheet4Enter(nil);
  if ( self.Tag <> 1 ) then   alterar;
end;

procedure TfrmCadastroPerfilAcesso.habilitaTabs(yn: Boolean);
var i:integer;
begin
  for i:=0 to pagFuncionalidades.PageCount -1 do begin
    pagFuncionalidades.Pages[i].Enabled := yn;
  end;
end;

procedure TfrmCadastroPerfilAcesso.habilitar(SN: Boolean);
begin
  if SN then begin
    habilitaTabs(true);
    edtNomePerfil.Enabled := true;
    btnIncluir.Enabled    := false;
    btnAlterar.Enabled    := false;
    btnCancelar.Enabled   := true;
    btnSalvar.Enabled     := true;
  end
  else begin
    edtNomePerfil.Enabled := false;
    btnIncluir.Enabled    := true;
    btnAlterar.Enabled    := true;
    btnCancelar.Enabled   := false;
    btnSalvar.Enabled     := false;
    habilitaTabs(false);
  end;
end;

end.
