unit uRelatorioEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, RLReport, StdCtrls, Buttons, Mask, ToolEdit,
  CurrEdit, RLFilters, RLPDFFilter;

type
  TfrmRelatorioEstoque = class(TfrmPadrao)
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
    dsEstoque: TDataSource;
    qryEstoque: TZQuery;
    RLBand3: TRLBand;
    RLBand2: TRLBand;
    RLDBText2: TRLDBText;
    RLLabel1: TRLLabel;
    qryEstoqueCODIGO: TIntegerField;
    qryEstoqueCODIGO_ITEM: TIntegerField;
    qryEstoqueUNIDADE_MEDIDA: TStringField;
    qryEstoqueQUANTIDADE: TFloatField;
    qryEstoqueDESCRICAO_ITEM: TStringField;
    qryEstoqueTIPO: TStringField;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    qryEstoquePRECO_CUSTO: TFloatField;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    qryEstoqueTOTAL: TFloatField;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel7: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText7: TRLDBText;
    qryEstoqueQUANTIDADE_MIN: TFloatField;
    GroupBox1: TGroupBox;
    chkAbaixo: TCheckBox;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel12: TRLLabel;
    GroupBox2: TGroupBox;
    edtPercentAcima: TCurrencyEdit;
    Label1: TLabel;
    qryEstoquePER_ACIMA: TFloatField;
    RLPDFFilter1: TRLPDFFilter;
    procedure BitBtn1Click(Sender: TObject);
    procedure qryEstoqueCalcFields(DataSet: TDataSet);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure edtPercentAcimaEnter(Sender: TObject);
  private
    procedure monta_sql;
  public
    { Public declarations }
  end;

var
  frmRelatorioEstoque: TfrmRelatorioEstoque;

implementation

uses uModulo, StrUtils;

{$R *.dfm}

procedure TfrmRelatorioEstoque.monta_sql;
begin

  qryEstoque.SQL.Text := ' select e.codigo, iif(e.codigo_produto is null, e.codigo_dispensa, e.codigo_produto) codigo_item, e.unidade_medida, e.quantidade, e.quantidade_min, '+
                         ' iif(pro.descricao is null, dis.descricao_item, pro.descricao) descricao_item, iif(pro.descricao is null, ''DISPENSA'', ''PRODUTO'') tipo, '+
                         ' iif(pro.descricao is null, dis.preco_custo, pro.preco_custo) preco_custo                                                                  '+
                         ' from estoque e                                                                                                                           '+
                         '  left join produtos pro  on pro.codigo = e.codigo_produto                                                                                '+
                         '  left join dispensa dis  on dis.codigo = e.codigo_dispensa                                                                               ';

  if rgpTipo.ItemIndex = 0 then
    qryEstoque.SQL.add(' where not(pro.descricao is null) ')
  else if rgpTipo.ItemIndex = 1 then
    qryEstoque.SQL.add(' where not(dis.descricao_item is null) ');

  if chkAbaixo.Checked then begin
    qryEstoque.SQL.add( IfThen(rgpTipo.ItemIndex in [0,1],' and',' where')+
                        ' iif(e.quantidade_min > 0, (100 - ((e.quantidade_min * 100)/ e.quantidade)), 100) <= :marg_percent');

    qryEstoque.ParamByName('marg_percent').AsFloat := edtPercentAcima.Value;
  end;

end;

procedure TfrmRelatorioEstoque.BitBtn1Click(Sender: TObject);
begin
  qryEstoque.Connection    := dm.conexao;
  qryEstoque.Close;
  monta_sql;
  qryEstoque.Open;

  if qryEstoque.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioEstoque.qryEstoqueCalcFields(DataSet: TDataSet);
begin
  qryEstoqueTOTAL.AsFloat     := qryEstoqueQUANTIDADE.AsFloat * qryEstoquePRECO_CUSTO.AsFloat;

  if qryEstoqueQUANTIDADE_MIN.AsFloat > 0 then
    qryEstoquePER_ACIMA.AsFloat := 100 - ((qryEstoqueQUANTIDADE_MIN.AsFloat * 100)/ qryEstoqueQUANTIDADE.AsFloat)
  else
    qryEstoquePER_ACIMA.AsFloat := 100;

end;

procedure TfrmRelatorioEstoque.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if rlband2.Color = clwhite then
    rlband2.Color := $00EEEEEE
  else
    rlband2.Color := clwhite;
end;

procedure TfrmRelatorioEstoque.RLDBText4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  //RLDraw2.Visible := (StrToFloat(Text) < qryEstoqueQUANTIDADE_MIN.Value);
  RLDraw2.Visible := qryEstoquePER_ACIMA.AsFloat < edtPercentAcima.Value;

  if qryEstoquePER_ACIMA.AsFloat < 0 then
    RLDraw2.Brush.Color := $005353FF
  else
    RLDraw2.Brush.Color := $0000ECEC;
end;

procedure TfrmRelatorioEstoque.edtPercentAcimaEnter(Sender: TObject);
begin
  edtPercentAcima.SelectAll;
end;

end.
