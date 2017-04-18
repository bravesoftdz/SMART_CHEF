unit uPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Printers,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  Datasnap.DBClient, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, System.StrUtils, uPadrao;

type
  TfrmPedidos = class(TFrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    gridItens: TDBGridCBN;
    pnlRodape: TPanel;
    Shape12: TShape;
    btnCancelaPedido: TSpeedButton;
    btnImprimir: TBitBtn;
    btnVoltar: TBitBtn;
    edtQtdePedidos: TCurrencyEdit;
    DBEdit1: TDBEdit;
    dsPedidos: TDataSource;
    qryPedidos: TFDQuery;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    rgpTipo: TRadioGroup;
    qryPedidosDATA: TDateField;
    qryPedidosCODIGO_COMANDA: TIntegerField;
    qryPedidosCODIGO_MESA: TIntegerField;
    qryPedidosVALOR_TOTAL: TBCDField;
    qryPedidosNOME_CLIENTE: TStringField;
    qryPedidosTELEFONE: TStringField;
    qryPedidosNFCE: TStringField;
    qryPedidosCODIGO: TIntegerField;
    qryPedidosTOTAL_GERAL: TAggregateField;
    btnBuscar: TBitBtn;
    qryPedidosSTATUS: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure rgpTipoClick(Sender: TObject);
    procedure btnCancelaPedidoClick(Sender: TObject);
    procedure qryPedidosAfterScroll(DataSet: TDataSet);
    procedure chkPeriodoGeralClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    procedure imprime_pedidos;
    procedure buscaPedidos;
    procedure cancelarPedido;
  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

uses uModulo, UtilitarioEstoque, Pedido, repositorio, fabricaRepositorio, uSupervisor, Usuario;

{$R *.dfm}

procedure TfrmPedidos.btnBuscarClick(Sender: TObject);
begin
  buscaPedidos;
end;

procedure TfrmPedidos.btnCancelaPedidoClick(Sender: TObject);
var usuario :TUsuario;
begin
  usuario := dm.UsuarioLogado;

  try
    frmSupervisor := TfrmSupervisor.Create(self);

    frmSupervisor.Label1.Caption := 'Login';
    frmSupervisor.Label4.Caption := 'Para efetuar o cancelamento do pedido';
    frmSupervisor.Label5.Caption := 'informe seu login e senha:';

    if frmSupervisor.ShowModal = mrOk then begin
      dm.UsuarioLogado := frmSupervisor.usu;
      if confirma('Confirma cancelamento do pedido selecionado?') then
        cancelarPedido;
    end;

  finally
    dm.UsuarioLogado := usuario;
    frmSupervisor.Release;
    frmSupervisor := nil;
  end;
end;

procedure TfrmPedidos.btnImprimirClick(Sender: TObject);
begin
  if not qryPedidos.IsEmpty then
    self.imprime_pedidos;
end;

procedure TfrmPedidos.btnVoltarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmPedidos.buscaPedidos;
var condicao_periodo :String;
begin
  condicao_periodo := '';
  if not chkPeriodoGeral.Checked then
    condicao_periodo := ' and (ped.data between :dti and :dtf) ';

  qryPedidos.Close;
  qryPedidos.SQL.Text := 'select ped.data, ped.codigo_comanda, ped.codigo_mesa, ped.valor_total, ped.codigo, '+
                         ' ped.nome_cliente, ped.telefone, iif(nfce.codigo is null, ''N'', ''S'') "NFCE", nfce.status '+
                         ' from pedidos ped                                                                  '+
                         ' left join nfce on nfce.codigo_pedido = ped.codigo                                 '+
                         ' where ped.situacao = '+IfThen(rgpTipo.ItemIndex = 0, '''A''', '''F''')+ condicao_periodo;

  if not chkPeriodoGeral.Checked then
  begin
    qryPedidos.ParamByName('dti').AsDate := dtpInicio.DateTime;
    qryPedidos.ParamByName('dtf').AsDate := dtpFim.DateTime;
  end;
  qryPedidos.Open;

  edtQtdePedidos.AsInteger := qryPedidos.RecordCount;
end;

procedure TfrmPedidos.cancelarPedido;
var Pedido :TPedido;
    repositorio :TRepositorio;
begin
  repositorio := nil;
  Pedido      := nil;
  try
    repositorio     := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
    Pedido          := TPedido(repositorio.Get(qryPedidosCODIGO.asInteger));
    TUtilitarioEstoque.atualizaEstoque(Pedido,-1);
    Pedido.situacao := 'C';
    repositorio.Salvar(Pedido);
    buscaPedidos;
  finally
    FreeAndNil(Pedido);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmPedidos.chkPeriodoGeralClick(Sender: TObject);
begin
  buscaPedidos;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  self.qryPedidos.Connection := fdm.conexao;
  dtpInicio.DateTime         := strToDateTime(DateToStr(Date)+' 00:01:00');
  dtpFim.DateTime            := strToDateTime(DateToStr(Date)+' 23:59:59');
  buscaPedidos;

  if not qryPedidos.Active then
    qryPedidos.CreateDataSet;
end;

procedure TfrmPedidos.imprime_pedidos;
var Arq   :TextFile;
    data, comanda, mesa, valor_total, cliente, telefone, impressora_padrao :String;
begin

  if(Printer.PrinterIndex >= 0)then begin
    impressora_padrao := IfThen(pos('\\',Printer.Printers[Printer.PrinterIndex]) > 0,'','\\localhost\' )+ Printer.Printers[Printer.PrinterIndex];
    AssignFile(Arq, impressora_padrao);
    ReWrite(Arq);
  end
  else
    avisar('Nenhuma impressora Padrão foi detectada');

  Writeln(Arq, StringOfChar(' ', 48- (length(DateTimeToStr(now))+1) ) + DateTimeToStr(now));
  Writeln(Arq, '    DATA    COMANDA   MESA        VALOR TOTAL');
  Writeln(Arq, StringOfChar('-',48));

  {
  123456789012345678901234567890123456789012345678
      DATA    COMANDA   MESA        VALOR TOTAL
  ------------------------------------------------
   13/04/2015}

  qryPedidos.First;
  while not qryPedidos.Eof do begin
    data        := ' '+qryPedidosDATA.AsString+' ';
    comanda     := StringOfChar(' ', 7 - length(qryPedidosCODIGO_COMANDA.AsString))+qryPedidosCODIGO_COMANDA.AsString;
    mesa        := StringOfChar(' ', 7 - length(qryPedidosCODIGO_MESA.AsString))+qryPedidosCODIGO_MESA.AsString;;
    valor_total := StringOfChar(' ', 20 - length(qryPedidosVALOR_TOTAL.AsString))+qryPedidosVALOR_TOTAL.AsString;
    cliente     := StringOfChar(' ', 34 - length(qryPedidosNOME_CLIENTE.AsString))+qryPedidosNOME_CLIENTE.AsString;
    telefone    := StringOfChar(' ', 14 - length(qryPedidosTELEFONE.AsString))+qryPedidosTELEFONE.AsString;


    Writeln(Arq, data + comanda + mesa + valor_total);
    Writeln(Arq, cliente + telefone);


    qryPedidos.Next;
  end;

  writeLn(Arq, '');
  writeLn(Arq, '');
  writeLn(Arq, '');
  WriteLn(Arq, #27 + #109);

  CloseFile(Arq);
end;

procedure TfrmPedidos.qryPedidosAfterScroll(DataSet: TDataSet);
begin
  btnCancelaPedido.Enabled := ((qryPedidosNFCE.AsString = 'N') or (qryPedidosSTATUS.AsString = '101')) and (rgpTipo.ItemIndex = 1);
end;

procedure TfrmPedidos.rgpTipoClick(Sender: TObject);
begin
  chkPeriodoGeral.Checked := rgpTipo.ItemIndex = 0;
  buscaPedidos;
end;

end.
