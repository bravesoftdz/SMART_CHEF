unit frameBuscaDispensa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dispensa, StdCtrls, Buttons, Mask, RXToolEdit, RXCurrEdit, Estoque;

type
  TBuscaDispensa = class(TFrame)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtItem: TEdit;
    cmbUnidadeMedida: TComboBox;
    StaticText3: TStaticText;
    procedure edtItemEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    private
    Fcodigo :Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FDispensa: TDispensa;
    FEstoque: TEstoque;

    procedure buscaDispensa;
    function selecionaDispensa :String;
    procedure setaDispensa;
    procedure SetEstoque(const Value: TEstoque);

  private
    procedure SetDispensa           (const Value: TDispensa);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;

    property Dispensa  :TDispensa read FDispensa  write SetDispensa;
    property codigo    :Integer   read Fcodigo    write Setcodigo;
    property Estoque   :TEstoque  read FEstoque   write SetEstoque;    

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses Repositorio, FabricaRepositorio, uPesquisaSimples, EspecificacaoEstoquePorItemDispensa;

{$R *.dfm}

{ TFrame1 }

procedure TBuscaDispensa.buscaDispensa;
begin
  setaDispensa;

  if not assigned( FDispensa ) then
    selecionaDispensa;
end;

procedure TBuscaDispensa.limpa;
begin
  Fcodigo := 0;
  edtCodigo.Clear;
  edtItem.Clear;
  cmbUnidadeMedida.ItemIndex := -1;

  if assigned(FDispensa) then
    FreeAndNil(FDispensa);

  if assigned(FEstoque) then
    FreeAndNil(FEstoque);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaDispensa.selecionaDispensa: String;
begin
  Result := '';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, descricao_item from dispensa',
                                                        'CODIGO', 'Selecione o Item desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaDispensa;
  end;
  frmPesquisaSimples.Release;
end;

procedure TBuscaDispensa.setaDispensa;
var
   RepDispensa :TRepositorio;
   Especificacao :TEspecificacaoEstoquePorItemDispensa;
begin

  RepDispensa := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);
  FDispensa   := TDispensa(RepDispensa.Get(edtCodigo.AsInteger));

  if Assigned(FDispensa) then begin

    edtCodigo.Value  := FDispensa.Codigo;
    edtItem.Text     := FDispensa.descricao_item;
    self.Fcodigo     := FDispensa.codigo;

    Especificacao    := TEspecificacaoEstoquePorItemDispensa.Create(FDispensa);
    RepDispensa      := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
    FEstoque         := TEstoque( RepDispensa.GetPorEspecificacao( Especificacao ) );

    if assigned(FEstoque) then
      cmbUnidadeMedida.ItemIndex := cmbUnidadeMedida.Items.IndexOf( FEstoque.unidade_medida );

    edtItem.SetFocus;
    if Assigned(FDispensa) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FDispensa);
  end
  else limpa;
end;

procedure TBuscaDispensa.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaDispensa;
end;

procedure TBuscaDispensa.SetDispensa(const Value: TDispensa);
begin
  self.FDispensa := value;
end;

procedure TBuscaDispensa.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaDispensa.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaDispensa.edtItemEnter(Sender: TObject);
begin
  if not Assigned(FDispensa) or (FDispensa.Codigo <= 0) then
    btnBusca.Click;

  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaDispensa.btnBuscaClick(Sender: TObject);
begin
  selecionaDispensa;
end;

procedure TBuscaDispensa.edtCodigoChange(Sender: TObject);
begin
  edtItem.Clear;

  if (self.edtCodigo.AsInteger <= 0) then
    self.limpa;
end;

procedure TBuscaDispensa.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.AsInteger > 0 then
    buscaDispensa;
end;

procedure TBuscaDispensa.SetEstoque(const Value: TEstoque);
begin
  FEstoque := Value;
end;

end.
