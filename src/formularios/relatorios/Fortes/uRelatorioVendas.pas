unit uRelatorioVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, StdCtrls, Buttons, RLReport,
  frameListaCampo, DB, ComCtrls, DBClient, RLFilters, RLPDFFilter,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelatorioVendas = class(TfrmPadrao)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    pnlBotoes: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RLLabel8: TRLLabel;
    RLDraw1: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLBand4: TRLBand;
    dsVendas: TDataSource;
    listaGrupos: TListaCampo;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chkPeriodoGeral: TCheckBox;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    rlbPeriodo: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult6: TRLDBResult;
    RLLabel3: TRLLabel;
    RLDBResult3: TRLDBResult;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLLabel5: TRLLabel;
    dsPedidos: TDataSource;
    rlbTxServico: TRLLabel;
    rlbCouvert: TRLLabel;
    rlbDesconto: TRLLabel;
    rlbSaldo: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw7: TRLDraw;
    RLDraw8: TRLDraw;
    RLLabel23: TRLLabel;
    RLDBResult4: TRLDBResult;
    RLLabel11: TRLLabel;
    RLLabel24: TRLLabel;
    rlbUsuario: TRLLabel;
    RLDraw9: TRLDraw;
    RLDBText2: TRLDBText;
    RLLabel25: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBText3: TRLDBText;
    RLLabel15: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel26: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLLabel27: TRLLabel;
    Shape12: TShape;
    cdsVendas: TClientDataSet;
    cdsVendasCODGRUPO: TIntegerField;
    cdsVendasGRUPO: TStringField;
    cdsVendasPRODUTO: TStringField;
    cdsVendasQTDE: TFloatField;
    cdsVendasVLR_UNI: TFloatField;
    cdsVendasVLR_TOTAL_IT: TFloatField;
    cdsVendasVLR_TOTAL_AD: TFloatField;
    RLPDFFilter1: TRLPDFFilter;
    qryPedidos: TFDQuery;
    qryVendas: TFDQuery;
    qryVendasCODGRUPO: TIntegerField;
    qryVendasGRUPO: TStringField;
    qryVendasPRODUTO: TStringField;
    qryVendasQTDE: TBCDField;
    qryVendasVLR_UNI: TBCDField;
    qryVendasQTD_FRACIONADO: TIntegerField;
    qryVendasVLR_TOTAL_IT: TFMTBCDField;
    qryVendasVLR_TOTAL_AD: TFMTBCDField;
    rgpC: TRadioGroup;
    qryPedidosCODIGO: TStringField;
    qryPedidosDESCONTO: TBCDField;
    qryPedidosTAXA_SERVICO: TBCDField;
    qryPedidosCOUVERT: TBCDField;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure chkPeriodoGeralClick(Sender: TObject);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBResult3AfterPrint(Sender: TObject);
    procedure RLDBText5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure qryVendasCalcFields(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
  private

    procedure monta_sql;
    procedure monta_sql_vendas;
    procedure monta_sql_pedidos;

    function sql_vendas_nfce :String;
    function sql_vendas_nfe :String;

    function sql_pedidos_nfce :String;
    function sql_pedidos_nfe :String;

    procedure calcula_totais;
    procedure agrupa_produtos_iguais;
  public
    { Public declarations }
  end;

var
  frmRelatorioVendas: TfrmRelatorioVendas;

implementation

uses uModulo, DateTimeUtilitario, Math, StrUtils, Usuario, StringUtilitario;

{$R *.dfm}

procedure TfrmRelatorioVendas.FormShow(Sender: TObject);
begin
  dtpInicio.DateTime := Date;
  dtpFim.DateTime    := date;
  qryPedidos.Connection := dm.conexao;
  qryVendas.Connection := dm.conexao;

  listaGrupos.setValores('select 0 CODIGO, ''GRUPO'' DESCRICAO from grupos '+
                         'union ' +
                         'select * from grupos', 'Descricao', 'Grupo');
  listaGrupos.executa;
end;

procedure TfrmRelatorioVendas.BitBtn1Click(Sender: TObject);
begin
  qryVendas.Connection     := dm.conexao;
  qryPedidos.Connection    := dm.conexao;
  qryVendas.Close;
  qryPedidos.Close;
  monta_sql;
  qryVendas.Open;
  qryPedidos.Open;

  calcula_totais;
  agrupa_produtos_iguais;

  rlbPeriodo.Caption := DateToStr( dtpInicio.Date ) + ' a ' + DateToStr( dtpFim.Date );
  rlbUsuario.Caption := dm.UsuarioLogado.Nome;

  if qryVendas.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioVendas.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioVendas.monta_sql;
begin
  monta_sql_vendas;
  monta_sql_pedidos;
end;

procedure TfrmRelatorioVendas.monta_sql_pedidos;
begin
  qryPedidos.SQL.Text := sql_pedidos_nfce +
                         //so add notas se selecionar filtro Todos ou COM Cpf
                         ifThen(rgpC.ItemIndex in [0,1],
                                ' UNION ALL '+
                                sql_pedidos_nfe, '')+
                                ' order by 1 ';

  if not chkPeriodoGeral.Checked then
  begin
    qryPedidos.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qryPedidos.ParamByName('dtf').AsDateTime := dtpFim.DateTime +1;
  end;

  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
    if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> 'SERVIÇO' then
      qryPedidos.ParamByName('cod_grupo').AsInteger := listaGrupos.CodCampo;
end;

procedure TfrmRelatorioVendas.monta_sql_vendas;
begin
  qryVendas.SQL.text :=  sql_vendas_nfce +
                         //so add notas se selecionar filtro Todos ou COM Cpf
                         ifThen(rgpC.ItemIndex in [0,1],
                                ' UNION ALL '+
                                sql_vendas_nfe, '')+
                                ' order by 1, 3 ';

  if not chkPeriodoGeral.Checked then
  begin
    qryVendas.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qryVendas.ParamByName('dtf').AsDateTime := dtpFim.DateTime +1;
  end;

  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
  begin
    if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> 'SERVIÇO' then
      qryVendas.ParamByName('cod_grupo').AsInteger := listaGrupos.CodCampo;
  end;
end;

procedure TfrmRelatorioVendas.chkPeriodoGeralClick(Sender: TObject);
begin
  dtpInicio.Enabled       := (chkPeriodoGeral.Checked);
  dtpFim.Enabled          := (chkPeriodoGeral.Checked);
end;

procedure TfrmRelatorioVendas.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if RLBand3.Color = clwhite then
    RLBand3.Color := $00EEEEEE
  else
    RLBand3.Color := clwhite;
end;

procedure TfrmRelatorioVendas.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  if cdsVendasPRODUTO.AsString = 'PISTA DE BOLICHE' then begin

    Text := TDateTimeUtilitario.SegundosParaTime( StrToInt(Text) );

    RLDBResult6.Visible := false;
  end
  else
    RLDBResult6.Visible := true;

  inherited;
end;

function TfrmRelatorioVendas.sql_pedidos_nfce: String;
begin
   result := 'select ''P''||CAST(ped.codigo as VARCHAR(15)) codigo, ped.couvert, '+
             ' ped.taxa_servico, ped.desconto                                    '+

             ' from pedidos ped                                                  '+

             ' left join nfce    on nfce.codigo_pedido = ped.codigo              '+
             ' left join itens i on i.codigo_pedido = ped.codigo                 '+
             ' left join produtos p on p.codigo = i.codigo_produto               '+
             ' left join grupos gr on gr.codigo = p.codigo_grupo                 '+
             ' left join verifica_hora_item(ped.codigo)  vant on 1=1             '+
             ' where ped.situacao = ''F''                                        ';

  if rgpC.ItemIndex > 0 then
    result := result +' and '+IfThen(rgpC.ItemIndex = 1,'not','')+'(nfce.codigo is null) ';

  if not chkPeriodoGeral.Checked then
    result := result + 'and ((  (iif(nfce.codigo is null , ped.data, Cast(nfce.dh_recebimento as Date)) >= :dti) and (iif(nfce.codigo is null , ped.data, Cast(nfce.dh_recebimento as Date)) < :dtf) ) ) ';


  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
    result := result + IfThen(listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] = 'SERVIÇO',
                              ' and gr.codigo is null ' ,
                              ' and gr.codigo = :cod_grupo ');

  result := result + ' group by 1, 2, 3, 4';
end;

function TfrmRelatorioVendas.sql_pedidos_nfe: String;
begin
  result := 'select ''NF''||CAST(nf.codigo as VARCHAR(15)) codigo, 0, 0, tnf.desconto       '+
            ' from notas_fiscais nf                                                         '+
            ' left join notas_fiscais_nfe_retorno nfr on nfr.codigo_nota_fiscal = nf.codigo '+
            ' left join totais_notas_fiscais tnf on tnf.codigo_nota_fiscal = nf.codigo      '+
            ' where nfr.status = ''100'' and nf.entrada_saida = ''S''                       ';

  if not chkPeriodoGeral.Checked then
    result := result + ' and ( nf.data_saida between :dti and :dtf ) ';


  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
    result := result + IfThen(listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] = 'SERVIÇO',
                              ' and gr.codigo is null ' ,
                              ' and gr.codigo = :cod_grupo ');

  result := result + ' group by 1, 2, 3, 4';
end;

function TfrmRelatorioVendas.sql_vendas_nfce: String;
begin
  result := 'select iif( gr.codigo is null, 0, gr.codigo) codgrupo ,        '+
         ' iif( gr.descricao is null, ''SERVIÇO'', gr.descricao) grupo , '+
         ' p.descricao produto,                                          '+
         ' sum( i.quantidade ) qtde,                                     '+
         ' sum(i.valor_unitario) vlr_uni, i.qtd_fracionado,              '+
         ' sum(i.valor_unitario * iif(((i.quantidade > 198)and(i.fracionado = ''S''))or(i.quantidade > 599), 1, i.quantidade )) vlr_total_it,            '+
         ' ( select sum(i.quantidade * ait.quantidade * ait.valor_unitario ) from adicionais_item ait '+
         '   where ait.codigo_item = i.codigo ) vlr_total_ad, i.codigo, i.quantidade '+
         ' from pedidos ped                                              '+

         ' left join nfce    on nfce.codigo_pedido = ped.codigo          '+
         ' left join itens i on i.codigo_pedido = ped.codigo             '+
         ' left join produtos p on p.codigo = i.codigo_produto           '+
         ' left join grupos gr on gr.codigo = p.codigo_grupo             '+
         ' left join verifica_hora_item(ped.codigo)  vant on 1=1         '+
         ' where ped.situacao = ''F'' ';

  if rgpC.ItemIndex > 0 then
    result := result + ' and '+IfThen(rgpC.ItemIndex = 1,'not','')+'(nfce.codigo is null) ';

  if not chkPeriodoGeral.Checked then
    result := result+ ' and ((  (iif(nfce.codigo is null , ped.data, Cast(nfce.dh_recebimento as Date)) >= :dti) and (iif(nfce.codigo is null , ped.data, Cast(nfce.dh_recebimento as Date)) < :dtf) ) ) ';

  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
    result := result + IfThen(listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] = 'SERVIÇO',
                              ' and gr.codigo is null ' ,
                              ' and gr.codigo = :cod_grupo ');

  result := result +' group by 1, 2, 3, 6, 9, 10 ';
end;

function TfrmRelatorioVendas.sql_vendas_nfe: String;
begin
  result := 'select iif( gr.codigo is null, 0, gr.codigo) codgrupo ,                               '+
            ' iif( gr.descricao is null, ''SERVIÇO'', gr.descricao) grupo ,  p.descricao produto,  '+
            ' sum( inf.quantidade ) qtde, sum(inf.valor_unitario) vlr_uni, 0,                      '+
            ' sum(inf.valor_unitario * inf.quantidade) vlr_total_it, 0, inf.codigo, inf.quantidade '+
            ' from notas_fiscais nf                                                                '+
            ' left join notas_fiscais_nfe_retorno nfr on nfr.codigo_nota_fiscal = nf.codigo        '+
            ' left join itens_notas_fiscais inf on inf.codigo_nota_fiscal = nf.codigo              '+
            ' left join produtos p on p.codigo = inf.codigo_produto                                '+
            ' left join grupos gr on gr.codigo = p.codigo_grupo                                    '+

            ' where (nfr.status = ''100'') and (nf.entrada_saida = ''S'')                          ';

  if not chkPeriodoGeral.Checked then
    result := result+ ' and ( nf.data_saida between :dti and :dtf ) ';

  if listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] <> '' then
    result := result + IfThen(listaGrupos.comListaCampo.items[ listaGrupos.comListaCampo.itemIndex ] = 'SERVIÇO',
                              ' and gr.codigo is null ' ,
                              ' and gr.codigo = :cod_grupo ');

  result := result +' group by 1, 2, 3, 6, 9, 10 ';
end;

procedure TfrmRelatorioVendas.calcula_totais;
var total_tx_servico, total_couvert, total_desconto :REal;
begin
  total_tx_servico := 0;
  total_couvert    := 0;
  total_desconto   := 0;



  qryPedidos.First;
  while not qryPedidos.Eof do begin

    total_tx_servico := total_tx_servico + qryPedidosTAXA_SERVICO.AsFloat;
    total_couvert    := total_couvert + qryPedidosCOUVERT.AsFloat;
    total_desconto   := total_desconto + qryPedidosDESCONTO.AsFloat;

    qryPedidos.Next;
  end;

  rlbTxServico.Caption := FormatFloat(' ,0.00; -,0.00;', total_tx_servico);
  rlbCouvert.Caption   := FormatFloat(' ,0.00; -,0.00;', total_couvert);
  rlbDesconto.Caption  := FormatFloat(' ,0.00; -,0.00;', total_desconto);
end;

procedure TfrmRelatorioVendas.RLDBResult3AfterPrint(Sender: TObject);
begin
  rlbSaldo.Caption  := FormatFloat(' ,0.00; -,0.00;', (RLDBResult3.Value + RLDBResult2.Value +
                                                       StrToFloat( TStringUtilitario.RemoveCaracter(rlbTxServico.caption,'.') )
                                                       + StrToFloat( TStringUtilitario.RemoveCaracter(rlbCouvert.Caption,'.') ))
                                                       - StrToFloat( TStringUtilitario.RemoveCaracter(rlbDesconto.Caption,'.') ));
  inherited;
end;

procedure TfrmRelatorioVendas.RLDBText5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  if cdsVendasPRODUTO.AsString = 'PISTA DE BOLICHE' then
    Text := '--';
end;

procedure TfrmRelatorioVendas.qryVendasCalcFields(DataSet: TDataSet);
begin
  TZQuery(DataSet).FieldByName('VLR_ITEM').AsFloat := TZQuery(DataSet).FieldByName('VLR_TOTAL_IT').AsFloat +
                                                      TZQuery(DataSet).FieldByName('VLR_TOTAL_AD').AsFloat;
end;

procedure TfrmRelatorioVendas.agrupa_produtos_iguais;
var total :real;
begin
  if not cdsVendas.Active then
    cdsVendas.CreateDataSet;

  cdsVendas.EmptyDataSet;  
  total := 0;
  qryVendas.First;
  while not qryVendas.Eof do begin
    if cdsVendas.Locate('CODGRUPO;PRODUTO', VarArrayOf([qryVendasCODGRUPO.AsInteger, TRIM(qryVendasPRODUTO.AsString)]), []) then
      cdsVendas.Edit
    else
      cdsVendas.Append;

    cdsVendasCODGRUPO.AsInteger   := qryVendasCODGRUPO.AsInteger;
    cdsVendasGRUPO.AsString       := qryVendasGRUPO.AsString;
    cdsVendasPRODUTO.AsString     := TRIM( qryVendasPRODUTO.AsString );
    cdsVendasVLR_UNI.AsFloat      := qryVendasVLR_UNI.AsFloat;
    cdsVendasQTDE.AsFloat         := cdsVendasQTDE.AsFloat + qryVendasQTDE.AsFloat;

    {if qryVendasQTD_FRACIONADO.AsInteger > 0 then
      cdsVendasVLR_TOTAL_IT.AsFloat := qryVendasVLR_TOTAL_IT.AsFloat
    else}
      cdsVendasVLR_TOTAL_IT.AsFloat := roundTo(cdsVendasVLR_TOTAL_IT.AsFloat + qryVendasVLR_TOTAL_IT.AsFloat,-2);

    cdsVendasVLR_TOTAL_AD.AsFloat := cdsVendasVLR_TOTAL_AD.AsFloat + qryVendasVLR_TOTAL_AD.AsFloat;

    cdsVendas.Post;

    total := total + cdsVendasVLR_TOTAL_IT.AsFloat;

    qryVendas.Next;
  end;

  cdsVendas.First;
  while not cdsVendas.Eof do begin

    total := total + cdsVendasVLR_TOTAL_IT.AsFloat;

    cdsVendas.Next;
  end;
end;

end.
