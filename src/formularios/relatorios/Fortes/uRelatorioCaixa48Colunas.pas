unit uRelatorioCaixa48Colunas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.StrUtils,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, RLReport, Caixa, uPadrao, RLFilters, RLPDFFilter, Data.DB, Datasnap.DBClient;

type
  TfrmRelatorioCaixa48Colunas = class(TfrmPadrao)
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dtpDiaMovimento: TDateTimePicker;
    Label1: TLabel;
    chk48: TCheckBox;
    RLReport1: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
    cds: TClientDataSet;
    ds: TDataSource;
    cdsTIPO: TStringField;
    cdsVALOR: TFloatField;
    cdsDESCRICAO: TStringField;
    cdsMOEDA: TStringField;
    RLSubDetail1: TRLSubDetail;
    cdsMovimentos: TClientDataSet;
    dsMovimentos: TDataSource;
    RLBand4: TRLBand;
    RLDBText5: TRLDBText;
    cdsMovimentosCODPEDIDO: TIntegerField;
    RLBand3: TRLBand;
    RLDraw6: TRLDraw;
    RLLabel23: TRLLabel;
    RLBand1: TRLBand;
    RLDraw5: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw1: TRLDraw;
    RLLabel11: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    rlbDia: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    rlCartDebito: TRLLabel;
    rlCartCredito: TRLLabel;
    rlDinheiro: TRLLabel;
    rlCheque: TRLLabel;
    rlDinheiroSan: TRLLabel;
    rlChequeSan: TRLLabel;
    rlDinheiroRef: TRLLabel;
    rlChequeRef: TRLLabel;
    RLLabel19: TRLLabel;
    rlTotVenda: TRLLabel;
    rlTotSan: TRLLabel;
    rlTotRef: TRLLabel;
    rlTotalGeral: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    rlTotDinheiro: TRLLabel;
    rlTotCheque: TRLLabel;
    rlMontante: TRLLabel;
    RLLabel15: TRLLabel;
    rlAbertura: TRLLabel;
    rlMontanteTotal: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLSubDetail2: TRLSubDetail;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel24: TRLLabel;
    RLDBText10: TRLDBText;
    cdsUSUARIO: TStringField;
    cdsMovimentosDINHEIRO: TStringField;
    cdsMovimentosCRTCREDITO: TStringField;
    cdsMovimentosCRTDEBITO: TStringField;
    cdsMovimentosCHEQUE: TStringField;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    cdsMovimentosDEPOSITO: TStringField;
    RLLabel14: TRLLabel;
    rlDeposito: TRLLabel;
    RLDBText11: TRLDBText;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
     Caixa         :TCaixa;

     procedure insereSangriaReforco;
     procedure inserePedidosDia;
  public
    { Public declarations }
  end;

var
  frmRelatorioCaixa48Colunas: TfrmRelatorioCaixa48Colunas;
  pedidos :String;

implementation

uses Repositorio, FabricaRepositorio, EspecificacaoCaixaPorData, StringUtilitario, SangriaReforco, Movimento, Math;

{$R *.dfm}

procedure TfrmRelatorioCaixa48Colunas.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioCaixa48Colunas.FormShow(Sender: TObject);
begin
  dtpDiaMovimento.Date  := Date;
  pnlPropaganda.Visible := false;
end;

procedure TfrmRelatorioCaixa48Colunas.inserePedidosDia;
var Mov :TMovimento;
begin
  if cdsMovimentos.Active then
    cdsMovimentos.EmptyDataSet
  else
    cdsMovimentos.CreateDataSet;

  if assigned(Caixa.movimentos) and (caixa.movimentos.Count > 0) then
  begin
    for Mov in Caixa.movimentos do
    begin
      if cdsMovimentos.Locate('CODPEDIDO',Mov.codigo_pedido,[]) then
        cdsMovimentos.Edit
      else
        cdsMovimentos.Append;

      cdsMovimentosCODPEDIDO.AsInteger     := Mov.codigo_pedido;
      case Mov.tipo_moeda of
        1 : cdsMovimentosDINHEIRO.AsString   := cdsMovimentosDINHEIRO.AsString+IfThen(cdsMovimentosDINHEIRO.AsString = '', '', ' - ')+
                                                TStringUtilitario.FormataDinheiro(Mov.valor_pago);

        2 : cdsMovimentosCHEQUE.AsString     := cdsMovimentosCHEQUE.AsString+IfThen(cdsMovimentosCHEQUE.AsString = '', '', ' - ')+
                                                TStringUtilitario.FormataDinheiro(Mov.valor_pago);

        3 : cdsMovimentosCRTCREDITO.AsString := cdsMovimentosCRTCREDITO.AsString+IfThen(cdsMovimentosCRTCREDITO.AsString = '', '', ' - ')+
                                                TStringUtilitario.FormataDinheiro(Mov.valor_pago);

        4 : cdsMovimentosCRTDEBITO.AsString  := cdsMovimentosCRTDEBITO.AsString+IfThen(cdsMovimentosCRTDEBITO.AsString = '', '', ' - ')+
                                                TStringUtilitario.FormataDinheiro(Mov.valor_pago);

        5 : cdsMovimentosDEPOSITO.AsString   := cdsMovimentosDEPOSITO.AsString+IfThen(cdsMovimentosDEPOSITO.AsString = '', '', ' - ')+
                                                TStringUtilitario.FormataDinheiro(Mov.valor_pago);
      end;
      cdsMovimentos.Post;

      if not pos(cdsMovimentosCODPEDIDO.AsString+';', pedidos) > 0 then
        pedidos := cdsMovimentosCODPEDIDO.AsString+';';

    end;
  end;
end;

procedure TfrmRelatorioCaixa48Colunas.insereSangriaReforco;
var SR :TSangriaReforco;
begin
  if cds.Active then
    cds.EmptyDataSet
  else
    cds.CreateDataSet;

  if assigned(Caixa.SangriasReforcos) and (caixa.SangriasReforcos.Count > 0) then
  begin
    for SR in Caixa.SangriasReforcos do
    begin
      cds.Append;
      cdsTIPO.AsString      := IfThen(SR.tipo = 'S', 'SANGRIA', 'REFORÇO');
      cdsVALOR.AsFloat      := SR.valor;
      cdsDESCRICAO.AsString := SR.descricao;
      case SR.tipo_moeda of
        1 : cdsMOEDA.AsString  := 'DINHEIRO';
        2 : cdsMOEDA.AsString  := 'CHEQUE';
      end;
      cdsUSUARIO.AsString   := SR.Usuario.Nome;
      cds.Post;
    end;
  end;
end;

procedure TfrmRelatorioCaixa48Colunas.RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  if RLBand4.Color = $00F4F4F4 then
    RLBand4.Color := clWhite
  else
    RLband4.Color := $00F4F4F4;
end;

procedure TfrmRelatorioCaixa48Colunas.RLLabel16BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  PrintIt := not cds.IsEmpty;
end;

procedure TfrmRelatorioCaixa48Colunas.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
var totVenda, totSangria, totReforco, totDinheiro, totCheque :Real;
begin
  rlbDia.Caption        := DateToStr(dtpDiaMovimento.DateTime);
  rlCartDebito.Caption  := TStringUtilitario.FormataDinheiro( Caixa.Total_cartaoD );
  rlCartCredito.Caption := TStringUtilitario.FormataDinheiro( Caixa.Total_cartaoC );
  rlDinheiro.Caption    := TStringUtilitario.FormataDinheiro( Caixa.Total_dinheiro );
  rlCheque.Caption      := TStringUtilitario.FormataDinheiro( Caixa.Total_cheque );
  rlDeposito.Caption    := TStringUtilitario.FormataDinheiro( Caixa.Total_deposito );
  rlDinheiroSan.Caption := TStringUtilitario.FormataDinheiro( Caixa.Total_sangria_dinheiro );
  rlChequeSan.Caption   := TStringUtilitario.FormataDinheiro( Caixa.Total_sangria_cheque );
  rlDinheiroRef.Caption := TStringUtilitario.FormataDinheiro( Caixa.Total_reforco_dinheiro );
  rlChequeRef.Caption   := TStringUtilitario.FormataDinheiro( Caixa.Total_reforco_cheque );

  totDinheiro           := Caixa.Total_dinheiro - Caixa.Total_sangria_dinheiro + Caixa.Total_reforco_dinheiro;
  totCheque             := Caixa.Total_cheque - Caixa.Total_sangria_cheque + Caixa.Total_reforco_cheque;

  rlTotDinheiro.Caption := TStringUtilitario.FormataDinheiro( totDinheiro );
  rlTotCheque.Caption   := TStringUtilitario.FormataDinheiro( totCheque );
  rlMontante.Caption    := TStringUtilitario.FormataDinheiro( totDinheiro + totCheque );
  rlAbertura.Caption    := TStringUtilitario.FormataDinheiro( Caixa.valor_abertura );
  rlMontanteTotal.Caption := TStringUtilitario.FormataDinheiro( Caixa.valor_abertura + totDinheiro + totCheque );

  totVenda              := Caixa.Total_cartaoD + Caixa.Total_cartaoC + Caixa.Total_deposito + Caixa.Total_dinheiro + Caixa.Total_cheque;
  totSangria            := Caixa.Total_sangria_dinheiro + Caixa.Total_sangria_cheque;
  totReforco            := Caixa.Total_reforco_dinheiro + Caixa.Total_reforco_cheque;

  rlTotVenda.Caption    := TStringUtilitario.FormataDinheiro(totVenda);
  rlTotSan.Caption      := TStringUtilitario.FormataDinheiro(totSangria);
  rlTotRef.Caption      := TStringUtilitario.FormataDinheiro(totReforco);

  rlTotalGeral.Caption  := TStringUtilitario.FormataDinheiro(totVenda + totReforco - totSangria);
  RLBand1.Height        := IfThen(cds.IsEmpty, 300, 317);
end;

procedure TfrmRelatorioCaixa48Colunas.BitBtn1Click(Sender: TObject);
var
    repositorio   :TRepositorio;
    especificacao :TEspecificacaoCaixaPorData;
begin
  Caixa       := nil;
  repositorio := nil;
  try
    especificacao := TEspecificacaoCaixaPorData.Create(dtpDiaMovimento.Date);
    repositorio   := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);
    Caixa         := TCaixa( repositorio.GetPorEspecificacao( especificacao ) );
    Caixa.atualizaValores;

    if assigned(Caixa) then
    begin
      if chk48.Checked then
        Caixa.imprime_48Colunas
      else
      begin
        insereSangriaReforco;
        inserePedidosDia;

        if cdsMovimentos.IsEmpty then
          RLReport1.DataSource := ds
        else
          RLReport1.DataSource := dsMovimentos;
        RLReport1.PreviewModal;
      end;
    end
    else
      avisar('Não existem movimentos referente a data selecionada');

  finally
    FreeAndNil(Caixa);
    //FreeAndNil(repositorio);
  end;
end;

end.
