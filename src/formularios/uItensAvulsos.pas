unit uItensAvulsos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, DBGridCBN, Buttons, Grids, DBGrids, Mask,
  RxToolEdit, RxCurrEdit, frameBuscaProduto, NotaFiscal, DB,
  DBClient, Contnrs, ItemAvulso, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmItensAvulsos = class(TfrmPadrao)
    gbDadosItem: TGroupBox;
    gbItensAdicionados: TGroupBox;
    gridItens: TDBGridCBN;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    edtQuantidade: TCurrencyEdit;
    edtPreco: TCurrencyEdit;
    btnAddItem: TBitBtn;
    BuscaProduto: TBuscaProduto;
    Panel1: TPanel;
    btnConfirmar: TSpeedButton;
    cdsItensCODIGO: TIntegerField;
    cdsItensCOD_PRODUTO: TIntegerField;
    cdsItensPRODUTO: TStringField;
    cdsItensPRECO: TFloatField;
    cdsItensVALOR_ITEM: TFloatField;
    cdsItensQUANTIDADE: TFloatField;
    btnCencelar: TSpeedButton;
    procedure btnAddItemClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCencelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FNotaFiscal           :TNotaFiscal;

  private
    procedure adicionaItemNoGrid;
    function adicionarItensNaNota :Boolean;
    procedure AdicionarItensAvulsosNoGrid(ItensAvulsos :TObjectList);
    procedure LimparTela                 ();

  public
    constructor Create(NotaFiscal :TNotaFiscal);
end;

var
  frmItensAvulsos: TfrmItensAvulsos;

implementation

uses
  ExcecaoParametroInvalido,
  Cor,
  FabricaRepositorio,
  Repositorio,
  Produto,
  Especificacao,
  StringUtilitario,
  Cliente;

{$R *.dfm}

{ TfrmItensAvulsos }

procedure TfrmItensAvulsos.adicionaItemNoGrid;
begin
  if cdsItens.Locate('COD_PRODUTO',BuscaProduto.Produto.codigo,[]) then
    cdsItens.Edit
  else
    self.cdsItens.Append;

  self.cdsItensProduto.AsString          := BuscaProduto.Produto.Descricao;
  self.cdsItensCOD_PRODUTO.AsInteger     := BuscaProduto.Produto.codigo;
  self.cdsItensQUANTIDADE.AsFloat        := edtQuantidade.Value;
  self.cdsItensPRECO.AsFloat             := edtPreco.Value;
  self.cdsItensVALOR_ITEM.AsFloat        := edtPreco.Value * edtQuantidade.Value;
  self.cdsItens.Post;
end;

function TfrmItensAvulsos.adicionarItensNaNota :Boolean;
var
  ItemAvulso          :TItemAvulso;
  RepositorioProduto  :TRepositorio;
  Produto             :TProduto;
begin
  try
     while not cdsItens.Eof do
     begin
        ItemAvulso                    := TItemAvulso.Create;
        ItemAvulso.Preco              := cdsItensPRECO.AsFloat;
        ItemAvulso.PercentualDesconto := 0;
        ItemAvulso.quantidade         := cdsItensQUANTIDADE.AsFloat;

        { Adicionar o produto }
        RepositorioProduto := nil;

        try
          RepositorioProduto := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
          Produto            := (RepositorioProduto.Get(cdsItensCOD_PRODUTO.AsInteger) as TProduto);
          ItemAvulso.Produto := Produto;

        finally
          FreeAndNil(RepositorioProduto);
          FreeAndNil(Produto);
        end;

        { Adicionar na Nota Fiscal }
        try
          self.FNotaFiscal.AdicionarItemAvulso(ItemAvulso);

        except
          on E: Exception do
           inherited Avisar(E.Message);
        end;

        cdsItens.Next;
     end;

    result := true;
  Except
    result := false;
  end;
end;

procedure TfrmItensAvulsos.AdicionarItensAvulsosNoGrid(
  ItensAvulsos: TObjectList);
var
  nX, nY     :Integer;
  ItemAvulso :TItemAvulso;
begin
   if self.cdsItens.Active then
    self.cdsItens.Close();
    
   self.cdsItens.CreateDataSet;

   for nX := 0 to (ItensAvulsos.Count-1) do begin
     ItemAvulso := (ItensAvulsos[nX] as TItemAvulso);

     self.cdsItens.Append;
     self.cdsItensProduto.AsString          := ItemAvulso.Produto.Descricao;
     self.cdsItensCOD_PRODUTO.AsInteger     := ItemAvulso.Produto.codigo;
     self.cdsItensQUANTIDADE.AsFloat        := ItemAvulso.Quantidade;
     self.cdsItensPRECO.AsFloat             := ItemAvulso.Preco;
     self.cdsItensVALOR_ITEM.AsFloat        := ItemAvulso.ValorTotal;

     self.cdsItens.Post;
   end;
end;

constructor TfrmItensAvulsos.Create(NotaFiscal: TNotaFiscal);
begin
   if not Assigned(NotaFiscal) then
    raise TExcecaoParametroInvalido.Create('TfrmItensAvulsos', 'Create(NotaFiscal: TNotaFiscal);', 'NotaFiscal');

   inherited Create(nil);

   inherited FecharComEsc     := false;
   self.FNotaFiscal           := NotaFiscal;

   // Se a nota fiscal já ter itens avulsos então eles são adicionados no grid
   if Assigned(self.FNotaFiscal.ItensAvulsos) then
     self.AdicionarItensAvulsosNoGrid(self.FNotaFiscal.ItensAvulsos);
end;

procedure TfrmItensAvulsos.btnAddItemClick(Sender: TObject);
begin
   if not Assigned(self.BuscaProduto.Produto) then begin
     inherited Avisar('Selecione o produto!');
     exit;
   end;


   if self.edtQuantidade.Value <= 0 then begin
     inherited Avisar('Nenhuma quantidade adicionada!');
     exit;
   end;

   adicionaItemNoGrid;
   self.LimparTela();
   self.BuscaProduto.edtCodigo.SetFocus;
end;

procedure TfrmItensAvulsos.btnConfirmarClick(Sender: TObject);
begin
   if adicionarItensNaNota then
     self.ModalResult := mrOk;
end;

procedure TfrmItensAvulsos.LimparTela;
begin
   self.BuscaProduto.limpa;
   self.edtPreco.Clear;
   self.edtQuantidade.Clear;
end;

procedure TfrmItensAvulsos.btnCencelarClick(Sender: TObject);
begin
   self.ModalResult := mrCancel;
end;

procedure TfrmItensAvulsos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F6) then
    self.btnConfirmar.Click
  else if (Key = VK_Escape) then
    self.btnCencelar.Click;
end;

procedure TfrmItensAvulsos.FormShow(Sender: TObject);
begin
  inherited;
  if not cdsItens.Active then
    cdsItens.CreateDataSet;
end;

end.
