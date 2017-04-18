unit frameBuscaGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit, Grupo;

type
  TbuscaGrupo = class(TFrame)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtGrupo: TEdit;
    procedure edtGrupoEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    Fcodigo :Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FGrupo :TGrupo;

    procedure buscaGrupo;
    function selecionaGrupo :String;
    procedure setaGrupo;

  private
    procedure SetGrupo             (const Value: TGrupo);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;

    property Grupo      :TGrupo read FGrupo  write SetGrupo;
    property codigo     :Integer  read Fcodigo   write Setcodigo;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TbuscaGrupo }

procedure TbuscaGrupo.btnBuscaClick(Sender: TObject);
begin
  selecionaGrupo;
end;

procedure TbuscaGrupo.buscaGrupo;
begin
  setaGrupo;

  if not assigned( FGrupo ) then
    selecionaGrupo;
end;

procedure TbuscaGrupo.edtCodigoChange(Sender: TObject);
begin
  edtGrupo.Clear;

  if (self.edtCodigo.AsInteger <= 0) then
    self.limpa;
end;

procedure TbuscaGrupo.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.AsInteger > 0 then
    buscaGrupo;
end;

procedure TbuscaGrupo.edtGrupoEnter(Sender: TObject);
begin
  if not Assigned(FGrupo) or (FGrupo.Codigo <= 0) then
    btnBusca.Click;

  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TbuscaGrupo.limpa;
begin
  Fcodigo := 0;
  edtCodigo.Clear;
  edtGrupo.Clear;

  if assigned(FGrupo) then
    FreeAndNil(FGrupo);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TbuscaGrupo.selecionaGrupo: String;
begin
  Result := '';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, descricao grupo from grupos',
                                                        'CODIGO', 'Selecione o usuário desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaGrupo;
  end;
  frmPesquisaSimples.Release;

end;

procedure TbuscaGrupo.setaGrupo;
var
   RepUsuario    :TRepositorio;
begin

  RepUsuario  := TFabricaRepositorio.GetRepositorio(TGrupo.ClassName);
  FGrupo    := TGrupo(RepUsuario.Get(edtCodigo.AsInteger));

  if Assigned(FGrupo) then begin

    edtCodigo.Value  := FGrupo.Codigo;
    edtGrupo.Text    := FGrupo.descricao;
    self.Fcodigo     := FGrupo.codigo;

    edtGrupo.SetFocus;

    if Assigned(FGrupo) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FGrupo);
  end
  else limpa;
end;

procedure TbuscaGrupo.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaGrupo;
end;

procedure TbuscaGrupo.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TbuscaGrupo.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TbuscaGrupo.SetGrupo(const Value: TGrupo);
begin
  self.FGrupo := value;
end;

end.
