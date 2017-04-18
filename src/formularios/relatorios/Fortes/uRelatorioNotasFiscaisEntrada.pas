unit uRelatorioNotasFiscaisEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, frameBuscaPessoa, frameBuscaFornecedor, frameBuscaNotaFiscal;

type
  TfrmRelatorioNotasFiscaisEntrada = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel4: TRLLabel;
    RLDraw1: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel7: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand5: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText4: TRLDBText;
    qryNotas: TFDQuery;
    qryNotasNUMERO_NOTA_FISCAL: TIntegerField;
    qryNotasFORNECEDOR: TStringField;
    qryNotasCODIGO_EMITENTE: TIntegerField;
    dsNotas: TDataSource;
    RLDBText5: TRLDBText;
    qryNotasVALOR: TBCDField;
    RLLabel8: TRLLabel;
    RLDraw2: TRLDraw;
    qryNotasDATA_EMISSAO: TDateField;
    qryNotasCFOPS: TStringField;
    GroupBox2: TGroupBox;
    BuscaNotaFiscal1: TBuscaNotaFiscal;
    GroupBox3: TGroupBox;
    buscaFornecedor1: TBuscaFornecedor;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    procedure imprimir;
  public
    { Public declarations }
  end;

var
  frmRelatorioNotasFiscaisEntrada: TfrmRelatorioNotasFiscaisEntrada;

implementation

{$R *.dfm}

procedure TfrmRelatorioNotasFiscaisEntrada.BitBtn2Click(Sender: TObject);
begin
  imprimir;
end;

procedure TfrmRelatorioNotasFiscaisEntrada.BitBtn3Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmRelatorioNotasFiscaisEntrada.FormShow(Sender: TObject);
begin
  inherited;
  qryNotas.Connection := fdm.conexao;
  dtpInicio.DateTime := strToDateTime(DateToStr(Date)+' 00:00:00');
  dtpFim.DateTime    := strToDateTime(DateToStr(Date)+' 23:59:59');
end;

procedure TfrmRelatorioNotasFiscaisEntrada.imprimir;
var condicao_periodo, condicao_fornecedor, condicao_nota :String;
begin
  if not chkPeriodoGeral.Checked then
    condicao_periodo := ' and nf.data_emissao between :dti and :dtf ';

  if buscaFornecedor1.edtNome.Text <> '' then
    condicao_fornecedor := ' and nf.codigo_emitente = :codforn ';

  if BuscaNotaFiscal1.edtNrNota.AsInteger > 0 then
    condicao_nota := ' and nf.numero_nota_fiscal = :nrnota ';

  qryNotas.close;
  qryNotas.SQL.Text := 'select nf.numero_nota_fiscal, CAST(nf.data_emissao as Date) data_emissao, cnn.cfops, '+
                       ' nf.codigo_emitente, forn.razao fornecedor, tnf.total - tnf.subst_tributaria valor   '+
                       ' from notas_fiscais nf                                                               '+
                       ' left join naturezas_operacao n on n.codigo = nf.codigo_natureza                     '+
                       ' left join pessoas forn on forn.codigo = nf.codigo_emitente                          '+
                       ' left join totais_notas_fiscais tnf on tnf.codigo_nota_fiscal = nf.codigo            '+
                       ' left join CFOPS_NA_NOTA(nf.codigo) cnn on (1=1)                                     '+
                       ' where nf.entrada_saida = ''E'' '+condicao_periodo + condicao_fornecedor + condicao_nota +
                       ' order by nf.codigo_emitente ';

  if not chkPeriodoGeral.Checked then
  begin
    qryNotas.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qryNotas.ParamByName('dtf').AsDateTime := dtpFim.DateTime;
  end;

  if buscaFornecedor1.edtNome.Text <> '' then
    qryNotas.ParamByName('codforn').AsInteger := buscaFornecedor1.Pessoa.Codigo;

  if BuscaNotaFiscal1.edtNrNota.AsInteger > 0 then
    qryNotas.ParamByName('nrnota').AsInteger  := BuscaNotaFiscal1.NotaFiscal.NumeroNotaFiscal;

  qryNotas.Open;

  if qryNotas.IsEmpty then
    avisar('Nenhum registro foi encontrado utilizando os filtros informados')
  else
    RLReport1.PreviewModal;
end;

end.
