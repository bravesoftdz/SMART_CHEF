unit uRelatorioNotasFiscaisEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, StringUtilitario,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, frameBuscaPessoa, frameBuscaFornecedor, frameBuscaNotaFiscal,
  RLFilters, RLPDFFilter;

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
    RLBand4: TRLBand;
    rlbTotalGeral: TRLLabel;
    qryNotas: TFDQuery;
    qryNotasNUMERO_NOTA_FISCAL: TIntegerField;
    qryNotasFORNECEDOR: TStringField;
    qryNotasCODIGO_EMITENTE: TIntegerField;
    dsNotas: TDataSource;
    qryNotasVALOR: TBCDField;
    qryNotasDATA_EMISSAO: TDateField;
    qryNotasCFOPS: TStringField;
    GroupBox2: TGroupBox;
    BuscaNotaFiscal1: TBuscaNotaFiscal;
    GroupBox3: TGroupBox;
    buscaFornecedor1: TBuscaFornecedor;
    RLSubDetail1: TRLSubDetail;
    qryNotas2: TFDQuery;
    dsNotas2: TDataSource;
    qryNotas2NUM_DOCUMENTO: TIntegerField;
    qryNotas2DATA: TDateField;
    qryNotas2CODIGO_FORNECEDOR: TIntegerField;
    qryNotas2FORNECEDOR: TStringField;
    qryNotas2VALOR_TOTAL: TSingleField;
    RLSubDetail2: TRLSubDetail;
    RLPDFFilter1: TRLPDFFilter;
    RLGroup1: TRLGroup;
    RLBand7: TRLBand;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLBand9: TRLBand;
    RLDraw3: TRLDraw;
    RLDBText10: TRLDBText;
    RLBand2: TRLBand;
    RLLabel7: TRLLabel;
    RLBand8: TRLBand;
    RLLabel14: TRLLabel;
    RLGroup2: TRLGroup;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand5: TRLBand;
    RLDraw2: TRLDraw;
    RLDBText5: TRLDBText;
    RLBand6: TRLBand;
    RLLabel8: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel9: TRLLabel;
    RLBand12: TRLBand;
    RLLabel15: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLBand10: TRLBand;
    RLDBResult3: TRLDBResult;
    RLBand11: TRLBand;
    RLDBResult2: TRLDBResult;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure rlbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    procedure buscaEntradasSemXML;
    procedure buscaEntradasComXML;

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

procedure TfrmRelatorioNotasFiscaisEntrada.buscaEntradasComXML;
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
end;

procedure TfrmRelatorioNotasFiscaisEntrada.buscaEntradasSemXML;
var condicao_periodo, condicao_fornecedor, condicao_nota :String;
begin
  if not chkPeriodoGeral.Checked then
    condicao_periodo := ' and es.data between :dti and :dtf ';

  if buscaFornecedor1.edtNome.Text <> '' then
    condicao_fornecedor := ' and es.codigo_fornecedor = :codforn ';

  if BuscaNotaFiscal1.edtNrNota.AsInteger > 0 then
    condicao_nota := ' and es.num_documento = :nrnota ';

  qryNotas2.Close;
  qryNotas2.SQL.Text := 'select            es.num_documento, es.data, es.codigo_fornecedor, '+
                        ' fn.razao fornecedor, es.valor_total from entrada_saida es         '+
                        ' left join pessoas fn on fn.codigo = es.codigo_fornecedor          '+
                        ' where not(es.codigo_fornecedor is null)                           '+
                         condicao_periodo + condicao_fornecedor + condicao_nota +
                        ' group by es.num_documento, es.data, es.codigo_fornecedor, fn.razao, es.valor_total '+
                        ' order by es.codigo_fornecedor, es.num_documento';

  if not chkPeriodoGeral.Checked then
  begin
    qryNotas2.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qryNotas2.ParamByName('dtf').AsDateTime := dtpFim.DateTime;
  end;

  if buscaFornecedor1.edtNome.Text <> '' then
    qryNotas2.ParamByName('codforn').AsInteger := buscaFornecedor1.Pessoa.Codigo;

  if BuscaNotaFiscal1.edtNrNota.AsInteger > 0 then
    qryNotas2.ParamByName('nrnota').AsInteger  := BuscaNotaFiscal1.NotaFiscal.NumeroNotaFiscal;

  qryNotas2.Open;
end;

procedure TfrmRelatorioNotasFiscaisEntrada.FormShow(Sender: TObject);
begin
  inherited;
  qryNotas.Connection  := fdm.conexao;
  qryNotas2.Connection := fdm.conexao;
  dtpInicio.DateTime   := strToDateTime(DateToStr(Date)+' 00:00:00');
  dtpFim.DateTime      := strToDateTime(DateToStr(Date)+' 23:59:59');
end;

procedure TfrmRelatorioNotasFiscaisEntrada.imprimir;
begin
  buscaEntradasComXML;
  buscaEntradasSemXML;

  RLSubDetail1.Visible := not qryNotas2.IsEmpty;
  RLSubDetail2.Visible := not qryNotas.IsEmpty;

  if qryNotas.IsEmpty and qryNotas2.IsEmpty then
    avisar('Nenhum registro foi encontrado utilizando os filtros informados')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioNotasFiscaisEntrada.RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  PrintIt := not (qryNotas.IsEmpty or qryNotas2.IsEmpty);
end;

procedure TfrmRelatorioNotasFiscaisEntrada.rlbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := 'Total geral >          '+TStringUtilitario.FormataDinheiro(RLDBResult2.Value + RLDBResult3.Value);
end;

procedure TfrmRelatorioNotasFiscaisEntrada.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  if qryNotas2.IsEmpty then
    RLReport1.DataSource := dsNotas
  else
    RLReport1.DataSource := dsNotas2;
end;

end.
