unit uAdicionaItemProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ExtCtrls, Mask, RXToolEdit, RXCurrEdit,
  frameBuscaMateriaPrima, Produto, pngimage, Spin, ComCtrls, ImgList, CriaBalaoInformacao;

type
  TfrmAdicionaItemProduto = class(TfrmPadrao)
    BuscaMateriaPrima1: TBuscaMateriaPrima;
    edtQuantidade: TCurrencyEdit;
    Label4: TLabel;
    Panel1: TPanel;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    Label1: TLabel;
    lblProduto: TLabel;
    imgAdiciona: TImage;
    imgRemove: TImage;
    udQuantidade: TUpDown;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Image1: TImage;
    Shape3: TShape;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FProduto :TProduto;
    FAdicionaRemove :String;

    function verifica_dados :Boolean;

  public
    constructor Create(AOwner: TComponent; Produto :TProduto; adiciona_remove :String);
  end;

var
  frmAdicionaItemProduto: TfrmAdicionaItemProduto;

implementation

uses uPedido, StrUtils;

constructor TfrmAdicionaItemProduto.Create(AOwner: TComponent; Produto :TProduto; adiciona_remove :String);
begin 
  inherited Create(AOwner);

  self.FProduto            := Produto;
  self.FAdicionaRemove     := adiciona_remove;
  self.imgAdiciona.Visible := (adiciona_remove = 'A');
  self.imgRemove.Visible   := (adiciona_remove = 'R');  
  self.Caption             := IfThen(adiciona_remove = 'A', 'Adicione os itens desejados, ao produto selecionado.',
                                                        'Remova os itens desejados, do produto selecionado.');

  self.BuscaMateriaPrima1.AdicionaRemove := adiciona_remove;
  self.BuscaMateriaPrima1.Produto        := self.FProduto;

end;

{$R *.dfm}

procedure TfrmAdicionaItemProduto.FormShow(Sender: TObject);
begin
  inherited;
  lblProduto.Caption := self.FProduto.descricao;
end;

procedure TfrmAdicionaItemProduto.btnSalvarClick(Sender: TObject);
begin
  if not verifica_dados then
    exit;

  try
    TfrmPedido(self.Owner).adiciona_no_produto(self.BuscaMateriaPrima1.MateriaPrima,
                                               self.edtQuantidade.AsInteger,
                                               self.FProduto.codigo,
                                               self.FAdicionaRemove);
    BuscaMateriaPrima1.limpa;
    edtQuantidade.Clear;
    BuscaMateriaPrima1.edtCodigo.SetFocus;

    TCriaBalaoInformacao.ShowBalloonTip(BuscaMateriaPrima1.edtCodigo.Handle, 'Item adicionado!', 'Informação', 1);

  Except
    On E: Exception do
      avisar('Erro: '+e.Message);
  end;
end;

function TfrmAdicionaItemProduto.verifica_dados: Boolean;
begin
  result := false;

  if not assigned(BuscaMateriaPrima1.MateriaPrima) then begin
    avisar('Favor informar o item a ser adicionado ao produto.');
    BuscaMateriaPrima1.edtCodigo.SetFocus;
  end
  else if edtQuantidade.AsInteger <= 0 then begin
    avisar('Favor informar a quantidade do item selecionado que será adicionada ao produto.');
    edtQuantidade.SetFocus;
  end
  else
    result := true;
end;

procedure TfrmAdicionaItemProduto.btnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmAdicionaItemProduto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_UP then
    udQuantidade.Increment := 1
  else if key = VK_UP then
    udQuantidade.Increment := -1;
end;

end.
