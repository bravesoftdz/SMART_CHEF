unit frameBuscaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, Mask, RXToolEdit, RXCurrEdit, Produto, Estoque;

type
  TBuscaProduto = class(TFrame)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    btnBusca: TBitBtn;
    edtProduto: TEdit;
    edtCodigo: TEdit;
    procedure edtProdutoEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    Fcodigo :Integer;
    FProdutoMateria :Boolean;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FProduto: TProduto;
    FEstoque: TEstoque;
    FQuantidade :Real;

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
    FSelecionado: Boolean;
    procedure limpa;

    property Produto  :TProduto read FProduto    write SetProduto;
    property codigo   :Integer  read Fcodigo     write Setcodigo;
    property Estoque  :TEstoque read FEstoque    write SetEstoque;
    property ProdutoMateria :Boolean read FProdutoMateria write FProdutoMateria;
    property Quantidade :Real   read FQuantidade write FQuantidade;

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
  edtCodigo.Text:= '0';
  edtProduto.Clear;

  if assigned(FProduto) then
    FreeAndNil(FProduto);

  if assigned(FEstoque) then
    FreeAndNil(FEstoque);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaProduto.selecionaProduto: String;
var condicao_boliche, condicao_produtoMateria :String;
begin
  Result := '';
  FSelecionado:= False;
  if dm.Configuracoes.possui_boliche then
    condicao_boliche := 'where codigo > 1'
  else
    condicao_boliche := 'where ativo = ''S''';

  if FProdutoMateria then
    condicao_produtoMateria := ' and tipo = ''M'' ';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select ativo, codigo, descricao, referencia, valor from produtos '+condicao_boliche+condicao_produtoMateria+' order by codigo',
                                                        'CODIGO', 'Selecione o Produto desejado...',False,800,500);

  if frmPesquisaSimples.ShowModal = mrOk then begin
    FSelecionado:= True;
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
  RepProduto   := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
  FQuantidade  := 0;

  if Length(edtCodigo.Text) in [12,13] then
  begin
    with dm.qryGenerica do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CODIGO FROM PRODUTOS WHERE CODBAR = :ncod');
      ParamByName('ncod').AsString:= edtCodigo.Text;
      Open;
    end;

    if dm.qryGenerica.IsEmpty then
    begin
      with dm.qryGenerica do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CODIGO FROM PRODUTOS WHERE CODIGO_BALANCA = :ncod');
        ParamByName('ncod').AsString:= IntToStr(StrToInt(copy(edtCodigo.Text,2,5)));
        Open;

        if not IsEmpty then
          FQuantidade := StrToFloat(copy(edtCodigo.Text,8,2)+','+copy(edtCodigo.Text,10,3));
      end;
    end;

    FProduto   := TProduto(RepProduto.Get(dm.qryGenerica.Fields[0].AsInteger));
  end
  else
    FProduto   := TProduto(RepProduto.Get(edtCodigo.Text));

  if assigned(FProduto) and not FProduto.ativo then
    FreeAndNil(FProduto);

  codigo       := IfThen(dm.Configuracoes.possui_boliche,1,0);
  FSelecionado := False;
  if Assigned(FProduto) and (FProduto.codigo > codigo) then begin
    FSelecionado:= True;
    edtCodigo.Text   := IntToStr(FProduto.Codigo);
    edtProduto.Text  := FProduto.descricao;
    self.Fcodigo     := FProduto.codigo;

    Especificacao    := TEspecificacaoEstoquePorProduto.Create(FProduto.codigo);
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
  edtCodigo.Text := IntToStr(value);
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
  if (self.edtCodigo.Text = '0') then
    self.limpa;
end;

procedure TBuscaProduto.edtCodigoExit(Sender: TObject);
begin
  if ((self.edtCodigo.Text) <> '0') and ((self.edtCodigo.Text) <> '') then
    buscaProduto;
end;

procedure TBuscaProduto.SetEstoque(const Value: TEstoque);
begin
  FEstoque := Value;
end;

end.
