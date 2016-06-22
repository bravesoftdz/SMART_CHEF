unit frameBuscaNCM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, NcmIBPT, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, Math;

type
  TBuscaNCM = class(TFrame)
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    StaticText1: TStaticText;
    edtNCM: TEdit;
    edtAliquota: TCurrencyEdit;
    StaticText2: TStaticText;
    Label7: TLabel;
    procedure btnBuscaClick(Sender: TObject);
    procedure edtNCMChange(Sender: TObject);
    procedure edtNCMExit(Sender: TObject);
  private
    FNCM :TNcmIBPT;
    Fcodigo: Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;

    procedure buscaNCM;
    function selecionaNCM :String;
    procedure setaNCM;

  private
    procedure SetNCM               (const Value: TNcmIBPT);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;

    property NCM :TNCMIBPT read FNCM write SetNCM;
    property codigo  :Integer  read Fcodigo  write Setcodigo;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses repositorio, fabricaRepositorio, Funcoes, uPesquisaSimples, StrUtils;

{$R *.dfm}

{ TBuscaNCM }

procedure TBuscaNCM.buscaNCM;
begin                                                            
  edtCodigo.Text := Campo_por_campo('COMANDAS','CODIGO','NUMERO_COMANDA', IfThen(edtNCM.Text = '','0',edtNCM.Text));

  setaNCM;

  if not assigned( FNCM ) then
    selecionaNCM;
end;

procedure TBuscaNCM.limpa;
begin
  Fcodigo := 0;
  edtCodigo.Clear;
  edtNCM.Clear;
  edtAliquota.Clear;

  if assigned(FNCM) then
    FreeAndNil(FNCM);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaNCM.selecionaNCM: String;
begin
  Result := '';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select codigo, ncm_ibpt, aliqnacional_ibpt from IBPT',
                                                        'CODIGO', 'Selecione o NCM desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaNCM;
  end;
  frmPesquisaSimples.Release;
end;

procedure TBuscaNCM.setaNCM;
var
    RepNcm :TRepositorio;
begin

  RepNcm := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
  FNCM   := TNcmIBPT(RepNcm.Get(edtCodigo.AsInteger));

  if Assigned(FNCM) then begin

    edtCodigo.Value   := FNCM.Codigo;
    edtNCM.Text       := FNCM.ncm_ibpt;
    edtAliquota.Value := FNCM.aliqnacional_ibpt;

    if Assigned(FNCM) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FNCM);

  end
  else limpa;
end;

procedure TBuscaNCM.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaNCM;
end;

procedure TBuscaNCM.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaNCM.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaNCM.SetNCM(const Value: TNCMIBPT);
begin
  FNCM := Value;
end;

procedure TBuscaNCM.btnBuscaClick(Sender: TObject);
begin
  selecionaNCM;
end;

procedure TBuscaNCM.edtNCMChange(Sender: TObject);
begin
  if (StrToIntDef(self.edtNCM.Text,0) <= 0) then
    self.limpa;
end;

procedure TBuscaNCM.edtNCMExit(Sender: TObject);
begin
  if not assigned( self.FNCM ) then
    buscaNCM;
end;

end.
 