unit uRelatorioCuponsFiscais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, pngimage, ExtCtrls, Grids, DBGrids,
  DB, DBClient, xmldom, Provider, Xmlxform, XMLIntf, msxmldom, XMLDoc,
  ComCtrls, Contnrs, RLReport, generics.collections, AcbrNFe, RLFilters, RLPDFFilter, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, pcnConversao;

type
  TfrmRelatorioCuponsFiscais = class(TfrmPadrao)
    ds: TDataSource;
    XMLDocument1: TXMLDocument;
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
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLBand4: TRLBand;
    RLLabel4: TRLLabel;
    RLDraw1: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLLabel7: TRLLabel;
    cds: TClientDataSet;
    cdsCODIGO: TIntegerField;
    cdsDATA: TDateField;
    cdsVALOR: TFloatField;
    RLPDFFilter1: TRLPDFFilter;
    RLDraw7: TRLDraw;
    RLLabel9: TRLLabel;
    cdsDINHEIRO: TFloatField;
    cdsCHEQUE: TFloatField;
    cdsCARTCRED: TFloatField;
    cdsCARTDEB: TFloatField;
    RLLabel8: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkPeriodoGeralClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    procedure imprimir;
  public
    { Public declarations }
  end;

var
  frmRelatorioCuponsFiscais: TfrmRelatorioCuponsFiscais;

implementation

uses Repositorio, FabricaRepositorio, NFce, EspecificacaoNFCe;

{$R *.dfm}

procedure TfrmRelatorioCuponsFiscais.BitBtn2Click(Sender: TObject);
begin
  cds.EmptyDataSet;
  imprimir;
end;

procedure TfrmRelatorioCuponsFiscais.imprimir;
var repositorio :TRepositorio;
    Nfces       :TObjectList<TNFCe>;
    Especificacao :TEspecificacaoNFCe;
    dt_i, dt_f  :TDateTime;
    nx, i :integer;
    FAcbrNfe: TACBrNFe;
    FXMLStringList    :TStringList;
    total :real;
begin
  try
    total := 0;
    FAcbrNfe        := TACBrNFe.Create(nil);
    FXMLStringList  := TStringList.Create;

    if chkPeriodoGeral.Checked then begin
      dt_i := 0;
      dt_f := 0;
    end
    else begin
      dt_i := dtpInicio.DateTime;
      dt_f := dtpFim.DateTime;
    end;

    repositorio   := TFabricaRepositorio.GetRepositorio(TNfce.ClassName);
    Especificacao := TEspecificacaoNFCe.Create(dt_i, dt_f);
    NFCes         := repositorio.GetListaPorEspecificacao<TNFCe>(Especificacao);

    for nx := 0 to Nfces.Count - 1 do begin
      FXMLStringList.LoadFromStream(NFces.Items[nx].XML);
      FAcbrNfe.NotasFiscais.LoadFromString(FXMLStringList.Text);

      cds.Append;
      cdsCODIGO.AsInteger := FAcbrNfe.NotasFiscais.Items[nx].NFe.Ide.cNF;
      cdsDATA.AsDateTime  := FAcbrNfe.NotasFiscais.Items[nx].NFe.Ide.dEmi;
      cdsVALOR.AsFloat    := FAcbrNfe.NotasFiscais.Items[nx].NFe.Total.ICMSTot.vNF;

          total := total + cdsVALOR.AsFloat;

      for i := 0 to  FAcbrNfe.NotasFiscais.Items[nx].NFe.pag.Count -1 do
      begin
        case FAcbrNfe.NotasFiscais.Items[nx].NFe.pag[i].tPag of
          fpDinheiro      : cdsDINHEIRO.AsFloat := cdsDINHEIRO.AsFloat + FAcbrNfe.NotasFiscais.Items[nx].NFe.pag[i].vPag;
          fpCheque        : cdsCHEQUE.AsFloat   := cdsCHEQUE.AsFloat + FAcbrNfe.NotasFiscais.Items[nx].NFe.pag[i].vPag;
          fpCartaoCredito : cdsCARTCRED.AsFloat := cdsCARTCRED.AsFloat + FAcbrNfe.NotasFiscais.Items[nx].NFe.pag[i].vPag;
          fpCartaoDebito  : cdsCARTDEB.AsFloat  := cdsCARTDEB.AsFloat + FAcbrNfe.NotasFiscais.Items[nx].NFe.pag[i].vPag;
        end;
      end;

      cds.Post;
    end;

      avisar(floattostr(total));

    if cds.IsEmpty then begin
      avisar('Não foram encontrados registros com os filtros informados.');
      exit;
    end;

    RLReport1.PreviewModal;
  finally
    FreeAndNil(FAcbrNfe);
    FreeAndNil(FXMLStringList);
  end;
end;

procedure TfrmRelatorioCuponsFiscais.FormShow(Sender: TObject);
begin
  cds.CreateDataSet;
  dtpInicio.DateTime := strToDateTime(DateToStr(Date)+' 00:00:00');
  dtpFim.DateTime    := strToDateTime(DateToStr(Date)+' 23:59:59');
end;

procedure TfrmRelatorioCuponsFiscais.BitBtn3Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmRelatorioCuponsFiscais.chkPeriodoGeralClick(Sender: TObject);
begin
  dtpInicio.Enabled := not chkPeriodoGeral.Checked;
  dtpFim.Enabled    := not chkPeriodoGeral.Checked;  
end;

end.
