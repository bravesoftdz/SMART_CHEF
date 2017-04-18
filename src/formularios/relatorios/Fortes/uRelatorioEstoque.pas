unit uRelatorioEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, DB, RLReport, StdCtrls, Buttons, Mask, RXToolEdit,
  RXCurrEdit, RLFilters, RLPDFFilter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, frameBuscaGrupo, frameBuscaFornecedor, frameBuscaPessoa;

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
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel9: TRLLabel;
    GroupBox1: TGroupBox;
    chkAbaixo: TCheckBox;
    GroupBox2: TGroupBox;
    edtPercentAcima: TCurrencyEdit;
    Label1: TLabel;
    RLPDFFilter1: TRLPDFFilter;
    qryEstoque: TFDQuery;
    qryEstoquePER_ACIMA: TFloatField;
    qryEstoqueTOTAL: TFloatField;
    rgpAgrupamento: TRadioGroup;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDraw2: TRLDraw;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLBand5: TRLBand;
    rldbGrupo: TRLDBText;
    rlGrupo: TRLLabel;
    qryEstoqueCODFORN: TIntegerField;
    qryEstoqueFORNECEDOR: TStringField;
    qryEstoqueCODIGO: TIntegerField;
    qryEstoqueCODIGO_ITEM: TIntegerField;
    qryEstoqueUNIDADE_MEDIDA: TStringField;
    qryEstoqueQUANTIDADE_MIN: TBCDField;
    qryEstoqueDESCRICAO_ITEM: TStringField;
    qryEstoqueTIPO: TStringField;
    qryEstoquePRECO_CUSTO: TSingleField;
    qryEstoqueCODIGO_GRUPO: TIntegerField;
    qryEstoqueGRUPO: TStringField;
    RLBand6: TRLBand;
    RLDBResult3: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel7: TRLLabel;
    RLDraw3: TRLDraw;
    RLLabel12: TRLLabel;
    RLDraw5: TRLDraw;
    RLLabel13: TRLLabel;
    GroupBox3: TGroupBox;
    buscaFornecedor1: TbuscaFornecedor;
    GroupBox4: TGroupBox;
    buscaGrupo1: TbuscaGrupo;
    qryEstoqueQUANTIDADE: TBCDField;
    procedure BitBtn1Click(Sender: TObject);
    procedure qryEstoqueCalcFields(DataSet: TDataSet);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure edtPercentAcimaEnter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
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
var ordem :String;
begin

  qryEstoque.SQL.Text := ' select iif(fr.codigo is null, 0, fr.codigo) codforn, iif(pf.codigo is null, ''SEM REPRESENTANTE ASSOCIADO'', fr.RAZAO) Fornecedor,                 '+
                         ' e.codigo, iif(e.codigo_produto is null, e.codigo_dispensa, e.codigo_produto) codigo_item, e.unidade_medida, e.quantidade, e.quantidade_min,        '+
                         ' iif(pro.descricao is null, dis.descricao_item, pro.descricao) descricao_item, iif(pro.descricao is null, ''DISPENSA'', ''PRODUTO'') tipo,          '+
                         ' iif(pro.descricao is null, dis.preco_custo, pro.preco_custo) preco_custo, pro.codigo_grupo, gr.descricao grupo                                     '+
                         ' from estoque e                                                                                                                                     '+
                         '  left join produtos pro  on pro.codigo = e.codigo_produto                                                                                          '+
                         '  left join dispensa dis  on dis.codigo = e.codigo_dispensa                                                                                         '+
                         '  left join produto_fornecedor pf on pf.codigo_produto = e.codigo_produto                                                                           '+
                         '  left join pessoas  fr  on fr.codigo = pf.codigo_fornecedor                                                                                        '+
                         '  left join grupos   gr on gr.codigo = pro.codigo_grupo                                                                                             '+
                         '  where (1=1) ';

  if rgpTipo.ItemIndex = 0 then
    qryEstoque.SQL.add(' and not(pro.descricao is null) ')
  else if rgpTipo.ItemIndex = 1 then
    qryEstoque.SQL.add(' and not(dis.descricao_item is null) ');

  if chkAbaixo.Checked then begin
    qryEstoque.SQL.add( ' and iif(e.quantidade_min > 0, (100 - ((e.quantidade_min * 100)/ e.quantidade)), 100) <= :marg_percent');

    qryEstoque.ParamByName('marg_percent').AsFloat := edtPercentAcima.Value;
  end;

  if buscaFornecedor1.edtCodigo.AsInteger > 0 then
  begin
    qryEstoque.SQL.add('and (fr.codigo = :cod_forn) ');
    qryEstoque.ParamByName('cod_forn').AsInteger := buscaFornecedor1.edtCodigo.AsInteger;
  end;

  if buscaGrupo1.edtCodigo.AsInteger > 0 then
  begin
    qryEstoque.SQL.add('and (pro.codigo_grupo = :cod_grupo) ');
    qryEstoque.ParamByName('cod_grupo').AsInteger := buscaGrupo1.edtCodigo.AsInteger;
  end;

  ordem := IfThen(rgpAgrupamento.ItemIndex = 0, '', IfThen(rgpAgrupamento.ItemIndex = 1,'codforn desc, ', ' grupo, '));
  qryEstoque.SQL.Add(' order by '+ordem+' descricao_item');
end;

procedure TfrmRelatorioEstoque.BitBtn1Click(Sender: TObject);
begin
  qryEstoque.Connection    := dm.FDConnection;
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
  if qryEstoqueQUANTIDADE.AsFloat < 0 then
    qryEstoqueTOTAL.AsFloat := 0
  else
    qryEstoqueTOTAL.AsFloat := qryEstoqueQUANTIDADE.AsFloat * qryEstoquePRECO_CUSTO.AsFloat;

  if (qryEstoqueQUANTIDADE_MIN.AsFloat > 0) and (qryEstoqueQUANTIDADE.AsFloat > qryEstoqueQUANTIDADE_MIN.AsFloat) then
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
  RLDraw2.Visible := (qryEstoquePER_ACIMA.AsFloat < edtPercentAcima.Value) or (qryEstoqueQUANTIDADE.AsFloat < 0) or (qryEstoqueQUANTIDADE.AsFloat < qryEstoqueQUANTIDADE_MIN.AsFloat);

  if qryEstoqueQUANTIDADE.AsFloat < 0 then
    RLDraw2.Brush.Color := $005353FF
  else if qryEstoqueQUANTIDADE.AsFloat < qryEstoqueQUANTIDADE_MIN.AsFloat then
    RLDraw2.Brush.Color := $0000ECEC
  else
    RLDraw2.Brush.Color := $00FAE4BE;

  RLDraw2.Color := RLBand2.Color;
end;

procedure TfrmRelatorioEstoque.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  inherited;
  rlGrupo.Caption     := IfThen(rgpAgrupamento.ItemIndex = 0, '', IfThen(rgpAgrupamento.ItemIndex = 1,'Fornecedor >', ' Grupo > '));
  rldbGrupo.DataField := IfThen(rgpAgrupamento.ItemIndex = 1, 'FORNECEDOR', 'GRUPO');
  RLBand5.Visible     := rgpAgrupamento.ItemIndex > 0;
  RLGroup1.DataFields := IfThen(rgpAgrupamento.ItemIndex = 0, '', IfThen(rgpAgrupamento.ItemIndex = 1,'CODFORN', 'CODIGO_GRUPO'));
  rllabel13.Caption   := edtPercentAcima.Text + '% Acima do estoque mínimo';

  rllabel13.Visible   := edtPercentAcima.Value > 0;
  RLDraw5.Visible     := edtPercentAcima.Value > 0;
end;

procedure TfrmRelatorioEstoque.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioEstoque.edtPercentAcimaEnter(Sender: TObject);
begin
  edtPercentAcima.SelectAll;
end;

procedure TfrmRelatorioEstoque.FormShow(Sender: TObject);
begin
  inherited;
  qryEstoque.Connection := dm.conexao;
end;

end.
