unit uRelatorioEntradaSaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  RLReport, StdCtrls, Buttons, ExtCtrls, pngimage, ComCtrls,
  frameBuscaProduto, frameBuscaDispensa, RLFilters, RLPDFFilter;

type
  TfrmRelatorioEntradaSaida = class(TfrmPadrao)
    rgpTipo: TRadioGroup;
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel8: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel9: TRLLabel;
    RLBand2: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel7: TRLLabel;
    qry: TZQuery;
    ds: TDataSource;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    qryE_S: TStringField;
    qryDATA: TDateField;
    qryNUM_DOCUMENTO: TIntegerField;
    qryP_D: TStringField;
    qryOBSERVACAO: TStringField;
    qryITEM: TStringField;
    qryQUANTIDADE: TFloatField;
    qryPRECO_CUSTO: TFloatField;
    qryNOME: TStringField;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    qryTOTAL: TFloatField;
    rgpItem: TRadioGroup;
    Panel1: TPanel;
    BuscaDispensa1: TBuscaDispensa;
    BuscaProduto1: TBuscaProduto;
    RLPDFFilter1: TRLPDFFilter;
    procedure BitBtn1Click(Sender: TObject);
    procedure rgpItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure monta_sql;
  end;

var
  frmRelatorioEntradaSaida: TfrmRelatorioEntradaSaida;

implementation

uses uModulo;

{$R *.dfm}

procedure TfrmRelatorioEntradaSaida.BitBtn1Click(Sender: TObject);
begin
  qry.Connection    := dm.conexao;
  qry.Close;
  monta_sql;
  qry.Open;

  if qry.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioEntradaSaida.monta_sql;
var condicao_periodo, condicao_tipo :String;
begin
  qry.SQL.Text := 'select iif(es.entrada_saida = ''E'', ''ENTRADA'', ''SAÍDA'') E_S, es.data, es.num_documento, '+
                  ' iif(es.tipo = ''D'',''DISPENSA'',''PRODUTO'') P_D, es.observacao,                           '+
                  ' iif(es.tipo = ''D'',dis.descricao_item, pro.descricao) ITEM,                                '+
                  ' es.quantidade, es.preco_custo, usu.nome, ( es.quantidade * es.preco_custo) TOTAL            '+
                  ' from entrada_saida es                                                                       '+
                  ' left join PRODUTOS pro on pro.codigo = es.codigo_item                                       '+
                  ' left join DISPENSA dis on dis.codigo = es.codigo_item                                       '+
                  ' left join usuarios usu on usu.codigo = es.codigo_usuario                                    ';

  if rgpTipo.itemIndex = 0 then
    qry.SQL.add(' where es.entrada_saida = ''E'' ')
  else if rgpTipo.itemIndex = 1 then
    qry.SQL.add(' where es.entrada_saida = ''S'' ')
  else if rgpTipo.itemIndex = 2 then
    qry.SQL.add(' where es.entrada_saida in (''E'',''S'') ');

  if rgpItem.itemIndex = 0 then
    qry.SQL.add(' and es.tipo = ''P'' ')
  else if rgpItem.itemIndex = 1 then
    qry.SQL.add(' and es.tipo = ''D'' ')
  else if rgpItem.itemIndex = 2 then
    qry.SQL.add(' and es.tipo in (''D'',''P'') ');

  if BuscaDispensa1.edtCodigo.AsInteger > 0 then
    qry.SQL.Add(' and dis.codigo = '+intToStr(BuscaDispensa1.edtCodigo.AsInteger));

  if BuscaProduto1.edtCodigo.AsInteger > 0 then
    qry.SQL.Add(' and pro.codigo = '+intToStr(BuscaProduto1.edtCodigo.AsInteger));

  if not chkPeriodoGeral.Checked then begin
    qry.SQL.Add(' and ( es.data between :dti and :dtf )  ');

    qry.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qry.ParamByName('dtf').AsDateTime := dtpFim.DateTime;
  end;

  qry.SQL.Add(' order by 1,2                                                                                ');

end;

procedure TfrmRelatorioEntradaSaida.rgpItemClick(Sender: TObject);
begin
  BuscaDispensa1.limpa;
  BuscaProduto1.limpa;
  BuscaProduto1.Visible  := (rgpItem.ItemIndex = 0);
  BuscaDispensa1.Visible := (rgpItem.ItemIndex = 1);
end;

end.
