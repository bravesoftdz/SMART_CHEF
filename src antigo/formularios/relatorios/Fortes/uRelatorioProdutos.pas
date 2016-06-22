unit uRelatorioProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, RLFilters, RLPDFFilter, DB, DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls, Buttons,
  RLReport, pngimage, ExtCtrls, frameListaCampo;

type
  TfrmRelatorioProdutos = class(TfrmPadrao)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel8: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLBand4: TRLBand;
    RLDraw7: TRLDraw;
    RLDBResult1: TRLDBResult;
    RLLabel4: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDraw3: TRLDraw;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText7: TRLDBText;
    RLBand5: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel3: TRLLabel;
    RLDBResult4: TRLDBResult;
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dsProdutos: TDataSource;
    qryProdutos: TZQuery;
    RLPDFFilter1: TRLPDFFilter;
    qryProdutosCODIGO: TIntegerField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosVALOR: TFloatField;
    qryProdutosCODGRUPO: TIntegerField;
    qryProdutosGRUPO: TStringField;
    RLDBText2: TRLDBText;
    RLLabel2: TRLLabel;
    rgpOrdem: TRadioGroup;
    GroupBox1: TGroupBox;
    ListaGrupo: TListaCampo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure monta_sql;
  public
    { Public declarations }
  end;

var
  frmRelatorioProdutos: TfrmRelatorioProdutos;

implementation

uses uModulo;

{$R *.dfm}

{ TfrmPadrao1 }

procedure TfrmRelatorioProdutos.monta_sql;
var ordem :String;
begin
  ordem := '';

  qryProdutos.SQL.Text := 'select p.codigo, p.descricao, p.valor,                     '+
                          ' iif(p.codigo_grupo is null, 0, p.codigo_grupo) codgrupo,  '+
                          ' iif(g.descricao is null,  ''SERVIÇO'', g.descricao) grupo '+
                          ' from produtos p                                           '+
                          ' left join grupos g on g.codigo = p.codigo_grupo           ';

  if ListaGrupo.CodCampo > 0 then begin
    qryProdutos.SQL.Add(' where g.codigo = :cod_grupo ');

    qryProdutos.ParamByName('cod_grupo').AsInteger := ListaGrupo.CodCampo;
  end;

  if rgpOrdem.ItemIndex = 0 then
    ordem := ', p.descricao'
  else
    ordem := ', p.valor';  

  qryProdutos.SQL.Add(' order by g.descricao, g.codigo '+ordem);

end;

procedure TfrmRelatorioProdutos.BitBtn1Click(Sender: TObject);
begin
  qryProdutos.Connection     := dm.conexao;

  qryProdutos.Close;
  monta_sql;
  qryProdutos.Open;

  if qryProdutos.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioProdutos.FormShow(Sender: TObject);
begin
  ListaGrupo.setValores('select * from grupos', 'Descricao', 'Grupo');
  ListaGrupo.executa;
end;

end.
