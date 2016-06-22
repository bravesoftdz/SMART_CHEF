unit uRelatorioPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, ComCtrls, RLReport, DateTimeUtilitario,
  frameListaCampo, RLFilters, RLPDFFilter;

type
  TfrmRelatorioPedidos = class(TfrmPadrao)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw9: TRLDraw;
    RLDraw1: TRLDraw;
    RLLabel8: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLLabel23: TRLLabel;
    rlbPeriodo: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel24: TRLLabel;
    rlbUsuario: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel5: TRLLabel;
    pnlBotoes: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RLDBText2: TRLDBText;
    RLLabel25: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel26: TRLLabel;
    RLLabel4: TRLLabel;
    qryPedidos: TZQuery;
    dsPedidos: TDataSource;
    qryPedidosDATA: TDateField;
    qryPedidosCODPED: TIntegerField;
    qryPedidosCODCOMANDA: TIntegerField;
    qryPedidosMESA: TIntegerField;
    qryPedidosDESCRICAO: TStringField;
    qryPedidosQTD_ITEM: TFloatField;
    qryPedidosTOT_ITEM: TFloatField;
    qryPedidosMAT_PRIMA: TStringField;
    qryPedidosQTD_ADICIONAL: TSmallintField;
    qryPedidosTOT_ADICIONAL: TFloatField;
    qryPedidosHORA: TTimeField;
    RLGroup2: TRLGroup;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand4: TRLBand;
    RLDBText5: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    qryPedidosCODITEM: TIntegerField;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    qryPedidosFLAG: TStringField;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    qryPedidosNOME: TStringField;
    RLLabel3: TRLLabel;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    qryPedidosCOUVERT: TFloatField;
    qryPedidosTAXA_SERVICO: TFloatField;
    qryPedidosVALOR_TOTAL: TFloatField;
    RLLabel9: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    qryPedidosDESCONTO: TFloatField;
    RLBand5: TRLBand;
    RLLabel15: TRLLabel;
    rlbTotal: TRLLabel;
    rgpSituacao: TRadioGroup;
    grpComanda: TGroupBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    Label1: TLabel;
    ListaComanda: TListaCampo;
    Shape12: TShape;
    grpLeiaute: TRadioGroup;
    RLBand6: TRLBand;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLDraw7: TRLDraw;
    RLDraw2: TRLDraw;
    rlbTxServico: TRLLabel;
    rlbCouvert: TRLLabel;
    rlbDesconto: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLDraw10: TRLDraw;
    RLLabel20: TRLLabel;
    rlbTotItens: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLDBText17: TRLDBText;
    qryPedidosAGRUPADAS: TStringField;
    GroupBox2: TGroupBox;
    chkAgrupadas: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure RLDBText9BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormShow(Sender: TObject);
    procedure RLDBText6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText16BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    
  private
    FPedidos     :String;

    procedure monta_sql;

    procedure calcula_totais;
  public
    { Public declarations }
  end;

var
  frmRelatorioPedidos: TfrmRelatorioPedidos;

implementation

uses uModulo, MAth, StrUtils;

{$R *.dfm}

procedure TfrmRelatorioPedidos.BitBtn1Click(Sender: TObject);
begin
  FPedidos                 := '';
  qryPedidos.Connection    := dm.conexao;
  qryPedidos.Close;
  monta_sql;
  qryPedidos.Open;

  calcula_totais;

  rlbPeriodo.Caption := DateToStr( dtpInicio.Date ) + ' a ' + DateToStr( dtpFim.Date );
  rlbUsuario.Caption := dm.UsuarioLogado.Nome;

  if qryPedidos.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;

end;

procedure TfrmRelatorioPedidos.monta_sql;
begin
   qryPedidos.SQL.Text := 'select ped.data, ped.codigo CODPED, ped.codigo_comanda CODCOMANDA, ped.codigo_mesa MESA, ped.couvert, ped.taxa_servico, '+
                          '       ped.valor_total, ped.desconto, i.hora, i.quantidade qtd_item, (iif(i.quantidade > 599, 1, i.quantidade ) * i.valor_unitario) tot_item,        '+
                          '       iif(ait.flag = ''A'', ''Adiciona'', ''Remove'') flag, usu.nome,  map.descricao mat_prima, i.codigo CODITEM, ped.agrupadas,      '+
                          '       pro.descricao, ait.quantidade qtd_Adicional, (iif(i.quantidade > 599, 1, i.quantidade ) * (ait.quantidade * ait.valor_unitario)) tot_Adicional                 '+
                          'from itens i                                                                                                            '+
                          'left join produtos         pro on pro.codigo = i.codigo_produto                                                         '+
                          'left join adicionais_item  ait on (ait.codigo_item = i.codigo and ((ait.valor_unitario > 0) or (ait.valor_unitario is null))) '+
                          'left join materias_primas  map on map.codigo = ait.codigo_materia                                                       '+
                          'left join pedidos          ped on ped.codigo = i.codigo_pedido                                                          '+
                          ' left join verifica_hora_item(ped.codigo)  vant on 1=1   '+
                          'left join usuarios         usu on usu.codigo = i.codigo_usuario                                                         '+
                          ' where (ped.situacao = '''+IfThen(rgpSituacao.ItemIndex = 0, 'F', 'A')+''')                                             ';

  if ListaComanda.CodCampo > 0 then begin
    qryPedidos.SQL.Add(' and ped.codigo_comanda = :cod_comanda ');

    qryPedidos.ParamByName('cod_comanda').AsInteger := ListaComanda.CodCampo;
  end;

  if not chkPeriodoGeral.Checked then begin
    qryPedidos.SQL.Add('and ((  (ped.data > :dti) and (ped.data < :dtf) )  ');
    qryPedidos.SQL.Add('or ( (iif( ((ped.data = :dti) and ( ((vant.item_valida_horario = 1) and (i.hora < ''07:00:00'')) or (i.hora > ''07:00:00'') )) ,1,0) = 1) ');
    qryPedidos.SQL.Add('  or (  iif( (ped.data = :dtf) and ((vant.item_valida_horario = 0)and (i.hora < ''07:00:00'')) ,1,0) = 1)))');

    qryPedidos.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
    qryPedidos.ParamByName('dtf').AsDateTime := dtpFim.DateTime +1;
  end;

  if chkAgrupadas.Checked then begin
    qryPedidos.SQL.Add(' and (ped.agrupadas <> '''')');
  end;

  qryPedidos.SQL.Add(' order by ped.codigo ');

end;

procedure TfrmRelatorioPedidos.RLDBText9BeforePrint(Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  if (Text = '') or (grpLeiaute.ItemIndex = 1) then begin
    RLBand4.Height             := 0;
    RLBand4.Borders.DrawBottom := false;
  end
  else begin
    RLBand4.Height             := 24;
    RLBand4.Borders.DrawBottom := true;
  end;
end;

procedure TfrmRelatorioPedidos.FormShow(Sender: TObject);
begin
  inherited;
  dtpInicio.DateTime := Date;
  dtpFim.DateTime    := date;

  ListaComanda.setValores('select * from comandas', 'numero_comanda', 'Comanda');
  ListaComanda.executa;
end;

procedure TfrmRelatorioPedidos.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  if qryPedidosDESCRICAO.AsString = 'PISTA DE BOLICHE' then
    Text := TDateTimeUtilitario.SegundosParaTime( StrToInt(Text) );

  inherited;
end;

procedure TfrmRelatorioPedidos.RLDBText16BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  {if Pos(qryPedidosVALOR_TOTAL.AsString, Fpedidos) = 0 then begin
    FPedidos     := FPedidos + qryPedidosVALOR_TOTAL.AsString;
    FValor_Total := FValor_Total + StrToFloat( text );
  end;  }

  inherited;
end;

procedure TfrmRelatorioPedidos.calcula_totais;
var FValor_Total     :Real;
    FTotal_desconto  :Real;
    FTotal_txServico :Real;
    FTotal_couvert   :Real;
    FTotal_Itens     :Real;
begin
  FPedidos         := '';
  FValor_Total     := 0;
  FTotal_desconto  := 0;
  FTotal_couvert   := 0;
  FTotal_txServico := 0;
  FTotal_Itens     := 0;

  qryPedidos.First;
  while not qryPedidos.Eof do begin

    if pos(qryPedidosCODPED.AsString, FPedidos) = 0 then begin
      FPedidos         := FPedidos + ',' +qryPedidosCODPED.AsString;
      FValor_Total     := FValor_Total + qryPedidosVALOR_TOTAL.AsFloat;
      FTotal_desconto  := FTotal_desconto  + qryPedidosDESCONTO.AsFloat;
      FTotal_txServico := FTotal_txServico + qryPedidosTAXA_SERVICO.AsFloat;
      FTotal_couvert   := FTotal_couvert   + qryPedidosCOUVERT.AsFloat;
    end;

    qryPedidos.Next;
  end;

  FTotal_Itens     := FValor_Total + FTotal_desconto - (FTotal_txServico + FTotal_couvert);

  rlbTotItens.Caption  := FormatFloat(' ,0.00; -,0.00;', FTotal_Itens);
  rlbTxServico.Caption := FormatFloat(' ,0.00; -,0.00;', FTotal_txServico);
  rlbCouvert.Caption   := FormatFloat(' ,0.00; -,0.00;', FTotal_couvert);
  rlbDesconto.Caption  := FormatFloat(' ,0.00; -,0.00;', FTotal_desconto);

  rlbTotal.Caption     := FormatFloat(' ,0.00; -,0.00;', FValor_Total);

  qryPedidos.First;
end;

procedure TfrmRelatorioPedidos.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if (grpLeiaute.ItemIndex = 0) then begin
    RLBand2.Height := 66;
    RLDBText14.Top := 23;
    RLDBText15.Top := 23;
    RLDBText16.Top := 23;

    RLDBText3.Top  := 4;
    RLDBText2.Top  := 4;
    RLDBText8.Top  := 4;
    RLLabel25.Top  := 4;
    RLLabel26.Top  := 4;
    RLLabel5.Top   := 4;

  end
  else begin
    RLBand2.Height := 30;
    RLDBText14.Top := 2;
    RLDBText15.Top := 2;
    RLDBText16.Top := 2;

    RLDBText3.Top  := 2;
    RLDBText2.Top  := 2;
    RLDBText8.Top  := 2;
    RLLabel25.Top  := 2;
    RLLabel26.Top  := 2;
    RLLabel5.Top   := 2;
    RLDBText17.Top := 16;
  end;

  RLband3.Visible   := (grpLeiaute.ItemIndex = 0);
  RLBand6.Visible   := (grpLeiaute.ItemIndex = 1);

  RLLabel9.Visible  := (grpLeiaute.ItemIndex = 0);
  RLLabel13.Visible := (grpLeiaute.ItemIndex = 0);
  RLLabel14.Visible := (grpLeiaute.ItemIndex = 0);

end;

procedure TfrmRelatorioPedidos.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  inherited;
  if (grpLeiaute.ItemIndex = 1) and (qryPedidosAGRUPADAS.AsString <> '') then
    RLBand2.Height := 32
  else if (grpLeiaute.ItemIndex = 1) and (qryPedidosAGRUPADAS.AsString = '') then
    RLBand2.Height := 25;
end;

end.
