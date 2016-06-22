unit uRelatorioCuponsFiscais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, pngimage, ExtCtrls, Grids, DBGrids,
  DB, DBClient, xmldom, Provider, Xmlxform, XMLIntf, msxmldom, XMLDoc,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ComCtrls, Contnrs,
  RLReport;

type
  TfrmRelatorioCuponsFiscais = class(TfrmPadrao)
    ds: TDataSource;
    XMLDocument1: TXMLDocument;
    cds: TClientDataSet;
    cdsCODIGO: TIntegerField;
    cdsDATA: TDateField;
    cdsVALOR: TFloatField;
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
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkPeriodoGeralClick(Sender: TObject);
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
    Nfces       :TObjectList;
    Corpo, No   :IXMLNode;
    T           :TFormatSettings;
    Especificacao :TEspecificacaoNFCe;
    dt_i, dt_f  :TDateTime;
    nx :integer;
begin

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
  NFCes         := repositorio.GetListaPorEspecificacao(Especificacao);

  for nx := 0 to Nfces.Count - 1 do begin

    Corpo := nil;
    No    := nil;

    XMLDocument1.LoadFromStream(TNfce(NFces.Items[nx]).XML);
    Corpo := XMLDocument1.DocumentElement.ChildNodes[0];
    Corpo := Corpo.ChildNodes[0];

    No := Corpo.ChildNodes.FindNode('ide');

    cds.Append;

    cdsCODIGO.AsInteger := StrToIntDef(No.ChildNodes['cNF'].Text, 0);

    T.ShortDateFormat := 'yyyy-mm-dd';
    T.DateSeparator   := '-';

    cdsDATA.AsDateTime  := StrToDate(copy(No.ChildNodes['dhEmi'].text, 1, 10), T);


    No := Corpo.ChildNodes.FindNode('total');
    No := No.ChildNodes[0];

    cdsVALOR.AsFloat    := StrToFloatDef(StringReplace(No.ChildNodes['vNF'].text,'.',',',[]), 0);

    cds.Post;
  end;

  if cds.IsEmpty then begin
    avisar('Não foram encontrados registros com os filtros informados.');
    exit;
  end;

  RLReport1.PreviewModal;
end;

procedure TfrmRelatorioCuponsFiscais.FormShow(Sender: TObject);
begin
  cds.CreateDataSet;
  dtpInicio.DateTime := strToDateTime(DateToStr(Date)+' 00:00:00');
  dtpFim.DateTime    := strToDateTime(DateToStr(Date)+' 23:59:59');
end;

procedure TfrmRelatorioCuponsFiscais.chkPeriodoGeralClick(Sender: TObject);
begin
  dtpInicio.Enabled := not chkPeriodoGeral.Checked;
  dtpFim.Enabled    := not chkPeriodoGeral.Checked;  
end;

end.
