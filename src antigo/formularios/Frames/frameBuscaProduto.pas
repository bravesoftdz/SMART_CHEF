unit frameBuscaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, Produto, Estoque;

type
  TBuscaProduto = class(TFrame)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtProduto: TEdit;
    procedure edtProdutoEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    Fcodigo :Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FProduto: TProduto;
    FEstoque: TEstoque;

    procedure buscaProduto;
    function selecionaProduto :String;
    procedure setaProduto;
    procedure SetEstoque(const Value: TEstoque);

  private
    procedure SetProduto           (const Value: TProduto);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;

    property Produto  :TProduto read FProduto  write SetProduto;
    property codigo   :Integer  read Fcodigo   write Setcodigo;
    property Estoque  :TEstoque read FEstoque  write SetEstoque;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses Repositorio, FabricaRepositorio, uPesquisaSimples, EspecificacaoEstoquePorProduto, uModulo,
  Math;

{$R *.dfm}

{ TBuscaProduto }

procedure TBuscaProduto.buscaProduto;
begin
  setaProduto;

  if not assigned( FProduto ) then
    selecionaProduto;
end;

procedure TBuscaProduto.limpa;
begin
  Fcodigo := 0;
  edtCodigo.Clear;
  edtProduto.Clear;

  if assigned(FProduto) then
    FreeAndNil(FProduto);

  if assigned(FEstoque) then
    FreeAndNil(FEstoque);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaProduto.selecionaProduto: String;
var condicao_boliche :String;
begin
  Result := '';

  if dm.Configuracoes.possui_boliche then
    condicao_boliche := 'where codigo > 1';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, descricao, valor from produtos '+condicao_boliche+' order by codigo',
                                                        'CODIGO', 'Selecione o Produto desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaProduto;
  end;
  frmPesquisaSimples.Release;
end;

procedure TBuscaProduto.setaProduto;
var
   RepProduto    :TRepositorio;
   codigo        :integer;
   Especificacao :TEspecificacaoEstoquePorProduto;
begin

  RepProduto := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
  FProduto   := TProduto(RepProduto.Get(edtCodigo.AsInteger));

  codigo := IfThen(dm.Configuracoes.possui_boliche,1,0);
  
  if Assigned(FProduto) and (FProduto.codigo > codigo) then begin

    edtCodigo.Value  := FProduto.Codigo;
    edtProduto.Text  := FProduto.descricao;
    self.Fcodigo     := FProduto.codigo;

    Especificacao    := TEspecificacaoEstoquePorProduto.Create(FProduto);
    RepProduto       := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
    FEstoque         := TEstoque( RepProduto.GetPorEspecificacao( Especificacao ) );

    edtProduto.SetFocus;
    if Assigned(FProduto) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FProduto);
  end
  else limpa;
end;

procedure TBuscaProduto.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaProduto;
end;

procedure TBuscaProduto.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaProduto.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaProduto.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TBuscaProduto.edtProdutoEnter(Sender: TObject);
begin
  if not Assigned(FProduto) or (FProduto.Codigo <= 0) then
    btnBusca.Click;

  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaProduto.btnBuscaClick(Sender: TObject);
begin
  selecionaProduto;
end;

procedure TBuscaProduto.edtCodigoChange(Sender: TObject);
begin
  edtProduto.Clear;

  if (self.edtCodigo.AsInteger <= 0) then
    self.limpa;
end;

procedure TBuscaProduto.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.AsInteger > 0 then
    buscaProduto;
end;

procedure TBuscaProduto.SetEstoque(const Value: TEstoque);
begin
  FEstoque := Value;
end;

end.
