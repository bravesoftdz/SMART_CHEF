unit uReimpressaoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, DB, Grids, DBGrids, DBGridCBN, StdCtrls, Buttons,
  frameListaCampo, ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmReimpressaoPedido = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    grpComanda: TGroupBox;
    ListaComanda: TListaCampo;
    pnlBotoes: TPanel;
    Shape12: TShape;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    DBGridCBN1: TDBGridCBN;
    dsPedidos: TDataSource;
    btnFiltrar: TBitBtn;
    qryPedidos: TFDQuery;
    qryPedidosDATA: TDateField;
    qryPedidosSITUACAO: TStringField;
    qryPedidosVALOR_TOTAL: TBCDField;
    qryPedidosCLIENTE: TStringField;
    qryPedidosAGRUPADAS: TStringField;
    Shape1: TShape;
    Label1: TLabel;
    qryPedidosPEDIDO: TIntegerField;
    qryPedidosCODIGO_COMANDA: TIntegerField;
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmReimpressaoPedido: TfrmReimpressaoPedido;

implementation

uses repositorioPedido, fabricaRepositorio, Pedido, uModulo, ServicoEmissorNFCe, repositorio,
  Parametros, uImpressaoPedido;

{$R *.dfm}

procedure TfrmReimpressaoPedido.btnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmReimpressaoPedido.btnFiltrarClick(Sender: TObject);
begin
  qryPedidos.Close;
  qryPedidos.ParamByName('di').AsDateTime        := dtpInicio.DateTime;
  qryPedidos.ParamByName('df').AsDateTime        := dtpFim.DateTime;
  qryPedidos.ParamByName('codcomanda').AsInteger := ListaComanda.CodCampo;
  qryPedidos.open;
end;

procedure TfrmReimpressaoPedido.FormShow(Sender: TObject);
begin
  dtpInicio.DateTime    := Date;
  dtpFim.DateTime       := Date;

  qryPedidos.Connection := dm.conexao;

  ListaComanda.setValores('select * from comandas', 'numero_comanda', 'Comanda');
  ListaComanda.executa;
end;

procedure TfrmReimpressaoPedido.btnImprimirClick(Sender: TObject);
var repositorio :TRepositorioPedido;
begin
  if qryPedidos.IsEmpty then
    Exit;

 try
  repositorio := TRepositorioPedido(TFabricaRepositorio.GetRepositorio(TPedido.ClassName));

  frmImpressaoPedido := TFrmImpressaoPedido.Create(nil);
  frmImpressaoPedido.imprimePedido(TPedido(repositorio.Get(qryPedidosPEDIDO.AsInteger)), dm.UsuarioLogado.Departamento, '');
  frmImpressaoPedido.Release;
  frmImpressaoPedido := nil;
 finally
   FreeAndNil(repositorio);
 end;
end;

end.
