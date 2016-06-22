unit frameBuscaUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Usuario, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TBuscaUsuario = class(TFrame)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtUsuario: TEdit;
    procedure edtUsuarioEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    Fcodigo :Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FUsuario :TUsuario;

    procedure buscaUsuario;
    function selecionaUsuario :String;
    procedure setaUsuario;

  private
    procedure SetUsuario           (const Value: TUsuario);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;

    property Usuario  :TUsuario read FUsuario  write SetUsuario;
    property codigo   :Integer  read Fcodigo   write Setcodigo;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TFrame1 }

procedure TBuscaUsuario.buscaUsuario;
begin
  setaUsuario;

  if not assigned( FUsuario ) then
    selecionaUsuario;
end;

procedure TBuscaUsuario.limpa;
begin
  Fcodigo := 0;
  edtCodigo.Clear;
  edtUsuario.Clear;

  if assigned(FUsuario) then
    FreeAndNil(FUsuario);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaUsuario.selecionaUsuario: String;
begin
  Result := '';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, nome from usuarios',
                                                        'CODIGO', 'Selecione o usuário desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaUsuario;
  end;
  frmPesquisaSimples.Release;

end;

procedure TBuscaUsuario.setaUsuario;
var
   RepUsuario    :TRepositorio;
begin

  RepUsuario  := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
  FUsuario    := TUsuario(RepUsuario.Get(edtCodigo.AsInteger));

  if Assigned(FUsuario) then begin

    edtCodigo.Value  := FUsuario.Codigo;
    edtUsuario.Text  := FUsuario.Nome;
    self.Fcodigo     := FUsuario.codigo;

    edtUsuario.SetFocus;

    if Assigned(FUsuario) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FUsuario);
  end
  else limpa;
end;

procedure TBuscaUsuario.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaUsuario;
end;

procedure TBuscaUsuario.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaUsuario.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaUsuario.SetUsuario(const Value: TUsuario);
begin
  self.FUsuario := value;
end;

procedure TBuscaUsuario.edtUsuarioEnter(Sender: TObject);
begin
  if not Assigned(FUsuario) or (FUsuario.Codigo <= 0) then
    btnBusca.Click;

  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaUsuario.btnBuscaClick(Sender: TObject);
begin
  selecionaUsuario;
end;

procedure TBuscaUsuario.edtCodigoChange(Sender: TObject);
begin
  edtUsuario.Clear;

  if (self.edtCodigo.AsInteger <= 0) then
    self.limpa;
end;

procedure TBuscaUsuario.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.AsInteger > 0 then
    buscaUsuario;
end;

end.
