unit uNFCesContingencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Parametros,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, System.StrUtils,
  Vcl.DBGrids, DBGridCBN, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmNFCesContingencia = class(TfrmPadrao)
    pnlBotoes: TPanel;
    Shape12: TShape;
    btnCancelar: TBitBtn;
    btnEnviarNFCes: TBitBtn;
    DBGridCBN1: TDBGridCBN;
    Label1: TLabel;
    chkSelecionar: TCheckBox;
    qryPedidos: TFDQuery;
    dsPedidos: TDataSource;
    Label2: TLabel;
    qryPedidosCODIGO: TIntegerField;
    qryPedidosDATA: TDateField;
    qryPedidosVALOR_TOTAL: TBCDField;
    qryPedidosCLIENTE: TStringField;
    qryPedidosCPF_CLIENTE: TStringField;
    qryPedidosTAG: TStringField;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DBGridCBN1DblClick(Sender: TObject);
    procedure DBGridCBN1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure chkSelecionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEnviarNFCesClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FParametros :TParametros;

    procedure enviarNFCe(codigoPedido :integer);
  public
    { Public declarations }
  end;

var
  frmNFCesContingencia: TfrmNFCesContingencia;

implementation

{$R *.dfm}

uses Pedido, uModulo, ServicoEmissorNFCe, FabricaRepositorio, repositorio, NFCE, uConfiguraNFCe, PermissoesAcesso;

procedure TfrmNFCesContingencia.BitBtn1Click(Sender: TObject);
begin
  AbreForm(TfrmConfiguraNFCe, paConfiguraECF);

  FreeAndNil(FParametros);
  FParametros := TParametros.Create;
end;

procedure TfrmNFCesContingencia.btnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmNFCesContingencia.btnEnviarNFCesClick(Sender: TObject);
begin
  try
    if FParametros.NFCe.FormaEmissao <> 0 then
    begin
      avisar('Forma de emissão deve ser setada para "0-Normal" antes do envio.');
      exit;
    end;

    Aguarda('Aguarde, enviando...');
    qryPedidos.Filtered := false;
    qryPedidos.Filter   := 'TAG = ''X''';
    qryPedidos.Filtered := true;

    if qryPedidos.IsEmpty then
    begin
      avisar('Nenhum registro foi selecionado');
      exit;
    end;

    qryPedidos.First;
    while not qryPedidos.Eof do
    begin
      enviarNFCe(qryPedidosCODIGO.AsInteger);
      qryPedidos.Next;
    end;

  finally
    FimAguarda('');
    qryPedidos.Filtered := false;
    qryPedidos.Close;
    qryPedidos.Open;
  end;
end;

procedure TfrmNFCesContingencia.chkSelecionarClick(Sender: TObject);
var TAG :String;
begin
  chkSelecionar.Caption := IfThen(chkSelecionar.Checked,'Deselecionar todas','Selecionar todas');

  TAG := IfThen(chkSelecionar.Checked,'X','');
  qryPedidos.First;
  while not qryPedidos.Eof do
  begin
    qryPedidos.Edit;
    qryPedidosTAG.AsString := TAG;
    qryPedidos.Post;
    qryPedidos.Next;
  end;
end;

procedure TfrmNFCesContingencia.DBGridCBN1DblClick(Sender: TObject);
begin
  qryPedidos.Edit;
  qryPedidosTAG.AsString := IfThen(qryPedidosTAG.AsString = 'X','','X');
  qryPedidos.Post;
end;

procedure TfrmNFCesContingencia.DBGridCBN1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (qryPedidosTAG.AsString = 'X') then begin
     TDBgridCBN(Sender).Canvas.Brush.Color := $00F1D7B1;
     TDBgridCBN(Sender).Canvas.FillRect(Rect);
     TDBGridCBN(Sender).DefaultDrawDataCell(Rect, TDBGridCBN(Sender).columns[datacol].field, State);
  end;
end;

procedure TfrmNFCesContingencia.FormCreate(Sender: TObject);
begin
  inherited;
  FParametros  := TParametros.Create;
  qryPedidos.Connection := dm.conexao;
  qryPedidos.Close;
  qryPedidos.Open;
end;

procedure TfrmNFCesContingencia.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FParametros);
end;

procedure TfrmNFCesContingencia.enviarNFCe(codigoPedido :integer);
var repositorio :TRepositorio;
    NFCe        :TServicoEmissorNFCe;
    Pedido      :TPedido;
begin
   repositorio    := nil;
   NFCe           := nil;
   Pedido         := nil;
 try
 try
   NFCe        := TServicoEmissorNFCe.Create(FParametros);

   repositorio  := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   Pedido       := TPedido(repositorio.Get(qryPedidosCODIGO.AsInteger));

   NFCe.Emitir(Pedido);
 finally
   FreeAndNil(NFCe);
   FreeAndNil(Pedido);
 end;
 Except
   on e :Exception do
     avisar('Erro ao tentar enviar NFC-e pendente.'+#13#10+e.Message);
 end;

end;

end.
