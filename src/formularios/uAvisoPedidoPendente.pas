unit uAvisoPedidoPendente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, ImgList, pngimage, ExtCtrls, ContNrs, StdCtrls,
  Buttons, Grids, DBGrids, DBGridCBN, DB, DBClient;

type
  TfrmAvisoPedidoPendente = class(TfrmPadrao)
    gridItens: TDBGridCBN;
    Shape9: TShape;
    Label2: TLabel;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cdsItensMESA: TIntegerField;
    cdsItensPRODUTO: TStringField;
    cdsItensQUANTIDADE: TFloatField;
    cdsItensHORA: TStringField;
    gridAdicionais: TDBGridCBN;
    cdsAdicionais: TClientDataSet;
    dsAdicionais: TDataSource;
    cdsAdicionaisACAO: TStringField;
    cdsAdicionaisMATERIA: TStringField;
    cdsAdicionaisQUANTIDADE: TIntegerField;
    cdsItensCODIGO: TIntegerField;
    cdsAdicionaisCODIGO_ITEM: TIntegerField;
    cdsSelecionados: TClientDataSet;
    cdsItensCODIGO_PEDIDO: TIntegerField;
    rgAcoes: TRadioGroup;
    btnExecutar: TBitBtn;
    cdsSelecionadosCODIGO: TIntegerField;
    Shape1: TShape;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure gridItensDblClick(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExecutarClick(Sender: TObject);
    procedure rgAcoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure busca_pendentes;
    procedure imprimir_pendentes;
    procedure marcar_como_impresso;
  public
    { Public declarations }
  end;

var
  frmAvisoPedidoPendente: TfrmAvisoPedidoPendente;

implementation

uses EspecificacaoPedidosComItemNaoImpresso, Repositorio, FabricaRepositorio, Pedido, Item, AdicionalItem, Produto,
  StrUtils, MateriaPrima, RepositorioPedido, uInicial;

{$R *.dfm}

procedure TfrmAvisoPedidoPendente.FormShow(Sender: TObject);
begin
  busca_pendentes;
  gridItens.SetFocus;
end;

procedure TfrmAvisoPedidoPendente.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cdsAdicionais.Filtered := false;
  cdsAdicionais.Filter   := 'CODIGO_ITEM = '+intToStr(cdsItensCODIGO.AsInteger);
  cdsAdicionais.Filtered := true;
end;

procedure TfrmAvisoPedidoPendente.busca_pendentes;
var Especificacao :TEspecificacaoPedidosComItemNaoImpresso;
    repositorio   :TRepositorio;
    Pedidos       :TObjectList;
    i, j, k       :integer;
begin
  repositorio   := nil;
  Especificacao := nil;
  cdsItens.AfterScroll := nil;

  if cdsSelecionados.Active then
    cdsSelecionados.EmptyDataSet;
  if cdsItens.Active then
    cdsItens.EmptyDataSet;
  if cdsAdicionais.Active then
    cdsAdicionais.EmptyDataSet;

  try

    repositorio   := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
    Especificacao := TEspecificacaoPedidosComItemNaoImpresso.Create;
    Pedidos       := repositorio.GetListaPorEspecificacao(Especificacao, 'SITUACAO = ''A'' ');

    for i := 0 to Pedidos.Count - 1 do
      for j := 0 to (Pedidos.Items[i] as TPedido).Itens.Count - 1 do begin
        if (((Pedidos.Items[i] as TPedido).Itens[j] as TItem).impresso = 'S') or
           (((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Produto.codigo_departamento <> fdm.UsuarioLogado.Codigo_departamento) then
             Continue;

        if not cdsItens.Active then
          cdsItens.CreateDataSet;
               
        cdsItens.Append;
        cdsItensCODIGO_PEDIDO.AsInteger := (Pedidos.Items[i] as TPedido).codigo;
        cdsItensCODIGO.AsInteger        := ((Pedidos.Items[i] as TPedido).Itens[j] as TItem).codigo;
        cdsItensMESA.AsInteger          := (Pedidos.Items[i] as TPedido).codigo_mesa;
        cdsItensPRODUTO.AsString        := ((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Produto.descricao;
        cdsItensQUANTIDADE.AsFloat      := ((Pedidos.Items[i] as TPedido).Itens[j] as TItem).quantidade;
        cdsItensHORA.AsString           := TimeToStr(((Pedidos.Items[i] as TPedido).Itens[j] as TItem).hora);
        cdsItens.Post;

        if not cdsAdicionais.Active then
          cdsAdicionais.CreateDataSet;

        if assigned(((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Adicionais)then
          for k := 0 to ((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Adicionais.Count - 1 do begin
            cdsAdicionais.Append;
            cdsAdicionaisCODIGO_ITEM.AsInteger := ((Pedidos.Items[i] as TPedido).Itens[j] as TItem).codigo;
            cdsAdicionaisACAO.AsString         := IfThen((((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Adicionais[k] as TAdicionalItem).flag = 'A', 'Adicionar','Remover');
            cdsAdicionaisMATERIA.AsString      := (((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Adicionais[k] as TAdicionalItem).Materia.descricao;
            cdsAdicionaisQUANTIDADE.AsInteger  := (((Pedidos.Items[i] as TPedido).Itens[j] as TItem).Adicionais[k] as TAdicionalItem).quantidade;
            cdsAdicionais.Post;
          end;

      end;

  Finally
    cdsItens.AfterScroll := cdsItensAfterScroll;
    FreeAndNil(repositorio);
    FreeAndNil(Especificacao);
    Pedidos.Free;
  end;
end;

procedure TfrmAvisoPedidoPendente.gridItensDblClick(Sender: TObject);
begin
  if not cdsSelecionados.Active then
    cdsSelecionados.CreateDataSet;

  if rgAcoes.ItemIndex = 0 then begin
    if cdsSelecionados.Locate('CODIGO',cdsItensCODIGO_PEDIDO.AsInteger, []) then
      cdsSelecionados.Delete
    else begin
      cdsSelecionados.Append;
      cdsSelecionadosCODIGO.AsInteger := cdsItensCODIGO_PEDIDO.AsInteger;
      cdsSelecionados.Post;
    end;
  end
  else begin
    if cdsSelecionados.Locate('CODIGO',cdsItensCODIGO.AsInteger,[]) then
      cdsSelecionados.Delete
    else begin
      cdsSelecionados.Append;
      cdsSelecionadosCODIGO.AsInteger := cdsItensCODIGO.AsInteger;
      cdsSelecionados.Post;
    end;
  end;

  gridItens.Repaint;
end;

procedure TfrmAvisoPedidoPendente.gridItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if not cdsSelecionados.Active then
    exit;

  if rgAcoes.ItemIndex = 0 then begin
    if cdsSelecionados.Locate('CODIGO', cdsItensCODIGO_PEDIDO.AsInteger, []) then begin
      TDBgridCBN(Sender).Canvas.Brush.Color := clSkyBlue;
      TDBgridCBN(Sender).Canvas.FillRect(Rect);
      TDBgridCBN(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
    end;
  end
  else begin
    if cdsSelecionados.Locate('CODIGO', cdsItensCODIGO.AsInteger, []) then begin
      TDBgridCBN(Sender).Canvas.Brush.Color := clSkyBlue;
      TDBgridCBN(Sender).Canvas.FillRect(Rect);
      TDBgridCBN(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
    end;
  end;

  inherited;
end;

procedure TfrmAvisoPedidoPendente.imprimir_pendentes;
var repositorio :TRepositorio;
    Pedido      :TPedido;
begin
  repositorio := nil;
  Pedido      := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

    cdsSelecionados.First;
    while not cdsSelecionados.Eof do begin
      Pedido := TPedido(repositorio.Get(cdsSelecionadosCODIGO.AsInteger));

      (repositorio as TRepositorioPedido).imprime(Pedido);
      //repositorio.Salvar(Pedido);

      cdsSelecionados.Next;
    end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Pedido);
  end;
end;

procedure TfrmAvisoPedidoPendente.btnExecutarClick(Sender: TObject);
begin
  if cdsSelecionados.IsEmpty then begin
    avisar('Nenhum registro foi selecionado');
    exit;
  end;

  if rgAcoes.ItemIndex = 0 then
    imprimir_pendentes
  else
    marcar_como_impresso;

  busca_pendentes;
  if cdsItens.IsEmpty then
    self.Close;
end;

procedure TfrmAvisoPedidoPendente.marcar_como_impresso;
var repositorio :TRepositorio;
    Item        :TItem;
begin
  repositorio := nil;
  Item        := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

    cdsSelecionados.First;
    while not cdsSelecionados.Eof do begin
      Item := TItem(repositorio.Get(cdsSelecionadosCODIGO.AsInteger));

      Item.impresso := 'S';

      repositorio.Salvar(Item);
      
      cdsSelecionados.Next;
    end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Item);
  end;
end;

procedure TfrmAvisoPedidoPendente.rgAcoesClick(Sender: TObject);
begin
  inherited;
  if cdsSelecionados.Active then
    cdsSelecionados.EmptyDataSet;
    
  gridItens.Repaint;
end;

procedure TfrmAvisoPedidoPendente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_escape then
    key := 0;

  inherited;
end;

procedure TfrmAvisoPedidoPendente.FormActivate(Sender: TObject);
begin
  if cdsItens.IsEmpty then
    Timer1.Enabled := true;
end;

procedure TfrmAvisoPedidoPendente.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled := false;
  self.Close;
end;

procedure TfrmAvisoPedidoPendente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  self.Visible := false;
  frmInicial.OnActivate(nil);
end;

end.
