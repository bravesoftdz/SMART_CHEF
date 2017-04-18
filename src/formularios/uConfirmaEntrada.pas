unit uConfirmaEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN, ItemNotaFiscal, uPadrao;

type
  TfrmConfirmaEntrada = class(TfrmPadrao)
    DBGridCBN1: TDBGridCBN;
    pnlRodape: TPanel;
    Shape10: TShape;
    Shape12: TShape;
    btnCancelar: TBitBtn;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    qryNotas: TFDQuery;
    dsNotas: TDataSource;
    qryNotasEmissão: TSQLTimeStampField;
    qryNotasNºNota: TIntegerField;
    qryNotasEmitente: TStringField;
    qryNotasTOTAL: TBCDField;
    qryNotasCODIGO: TIntegerField;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure efetuaEntradaEstoque;
    procedure atualizaEstoque(ItemNF :TItemNotaFiscal);
  public
    { Public declarations }
  end;

var
  frmConfirmaEntrada: TfrmConfirmaEntrada;

implementation

uses Fabricarepositorio, Repositorio, NotaFiscal, Produto, uModulo;

{$R *.dfm}

procedure TfrmConfirmaEntrada.BitBtn1Click(Sender: TObject);
begin
  efetuaEntradaEstoque;
  qryNotas.Connection := dm.conexao;
  qryNotas.Close;
  qryNotas.Open;
end;

procedure TfrmConfirmaEntrada.btnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmConfirmaEntrada.efetuaEntradaEstoque;
var repositorio :TRepositorio;
    NF          :TNotaFiscal;
    i :integer;
begin
  repositorio := nil;
  NF          := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
    NF          := TNotaFiscal(repositorio.Get(qryNotas.fieldbyname('codigo').asInteger));

    for i := 0 to NF.Itens.Count -1 do
      atualizaEstoque(NF.Itens.Items[i]);

    NF.EntrouEstoque := 'S';
    repositorio.Salvar(NF);

    avisar('Operação realizada com sucesso',2);
  finally
    FreeAndNil(repositorio);
    FreeAndNil(NF);
  end;
end;

procedure TfrmConfirmaEntrada.FormShow(Sender: TObject);
begin
  qryNotas.Connection := dm.conexao;
  qryNotas.Close;
  qryNotas.Open;
end;

procedure TfrmConfirmaEntrada.atualizaEstoque(ItemNF :TItemNotaFiscal);
var Produto     :TProduto;
    repositorio :TRepositorio;
begin
  try
    repositorio                := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produto                    := TProduto(repositorio.Get(ItemNF.CodigoProduto));
    Produto.Estoque.quantidade := Produto.Estoque.quantidade + (ItemNF.Quantidade * Produto.Estoque.multiplicador);
    repositorio.Salvar(Produto);
  Finally
    FreeAndNil(Produto);
    FreeAndNil(repositorio);
  end;
end;

end.
