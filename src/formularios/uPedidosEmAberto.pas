unit uPedidosEmAberto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, Grids, DBGrids, DBGridCBN, pngimage, ExtCtrls, DB,
  StdCtrls, Mask, RXToolEdit,
  RXCurrEdit, Buttons, DBCtrls, Provider, DBClient, Printers, Math,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPedidosEmAberto = class(TfrmPadrao)
    gridItens: TDBGridCBN;
    dsPedidos: TDataSource;
    pnlRodape: TPanel;
    Shape12: TShape;
    btnCancelaCupom: TSpeedButton;
    btnImprimir: TBitBtn;
    btnVoltar: TBitBtn;
    Label5: TLabel;
    edtQtdePedidos: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    cdsPedidos: TClientDataSet;
    dspPedidos: TDataSetProvider;
    DBEdit1: TDBEdit;
    cdsPedidosTOTAL_GERAL: TAggregateField;
    qryPedidos: TFDQuery;
    cdsPedidosDATA: TDateField;
    cdsPedidosCODIGO_COMANDA: TIntegerField;
    cdsPedidosCODIGO_MESA: TIntegerField;
    cdsPedidosVALOR_TOTAL: TBCDField;
    cdsPedidosNOME_CLIENTE: TStringField;
    cdsPedidosTELEFONE: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    procedure imprime_pedidos;
  public
    { Public declarations }
  end;

var
  frmPedidosEmAberto: TfrmPedidosEmAberto;

implementation

uses StrUtils;

{$R *.dfm}

procedure TfrmPedidosEmAberto.FormShow(Sender: TObject);
begin
  self.qryPedidos.Connection := fdm.conexao;
  cdsPedidos.Close;
  cdsPedidos.Open;

  edtQtdePedidos.AsInteger := cdsPedidos.RecordCount;

  if not cdsPedidos.Active then
    cdsPedidos.CreateDataSet;
end;

procedure TfrmPedidosEmAberto.btnVoltarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmPedidosEmAberto.imprime_pedidos;
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

  cdsPedidos.First;
  while not cdsPedidos.Eof do begin
    data        := ' '+cdsPedidosDATA.AsString+' ';
    comanda     := StringOfChar(' ', 7 - length(cdsPedidosCODIGO_COMANDA.AsString))+cdsPedidosCODIGO_COMANDA.AsString;
    mesa        := StringOfChar(' ', 7 - length(cdsPedidosCODIGO_MESA.AsString))+cdsPedidosCODIGO_MESA.AsString;;
    valor_total := StringOfChar(' ', 20 - length(cdsPedidosVALOR_TOTAL.AsString))+cdsPedidosVALOR_TOTAL.AsString;
    cliente     := StringOfChar(' ', 34 - length(cdsPedidosNOME_CLIENTE.AsString))+cdsPedidosNOME_CLIENTE.AsString;
    telefone    := StringOfChar(' ', 14 - length(cdsPedidosTELEFONE.AsString))+cdsPedidosTELEFONE.AsString;


    Writeln(Arq, data + comanda + mesa + valor_total);
    Writeln(Arq, cliente + telefone);


    cdsPedidos.Next;
  end;

  writeLn(Arq, '');
  writeLn(Arq, '');
  writeLn(Arq, '');
  WriteLn(Arq, #27 + #109);

  CloseFile(Arq);

end;

procedure TfrmPedidosEmAberto.btnImprimirClick(Sender: TObject);
begin
  if not cdsPedidos.IsEmpty then
    self.imprime_pedidos;
end;

end.
