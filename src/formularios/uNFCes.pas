unit uNFCes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, pngimage, ExtCtrls, DB, DBClient, Grids, DBGrids,
  DBGridCBN, StdCtrls, ComCtrls, Buttons, ContNrs, FileCtrl;

type
  TfrmNFCes = class(TfrmPadrao)
    DBGridCBN1: TDBGridCBN;
    cdsNFCes: TClientDataSet;
    dsNFCes: TDataSource;
    dtpInicio: TDateTimePicker;
    Label1: TLabel;
    dtpFim: TDateTimePicker;
    btnBusca: TBitBtn;
    cdsNFCesNR_NOTA: TIntegerField;
    cdsNFCesCODIGO_PEDIDO: TIntegerField;
    cdsNFCesCHAVE: TStringField;
    cdsNFCesPROTOCOLO: TStringField;
    cdsNFCesDH_RECEBIMENTO: TDateTimeField;
    cdsNFCesSTATUS: TStringField;
    cdsNFCesMOTIVO: TStringField;
    cdsNFCesXML: TBlobField;
    pnlRodape: TPanel;
    Shape10: TShape;
    btnCancelar: TBitBtn;
    Shape12: TShape;
    btnGerarXml: TBitBtn;
    Label2: TLabel;
    chTodas: TCheckBox;
    cdsNFCesTAG: TIntegerField;
    Label3: TLabel;
    lbSelecionados: TLabel;
    BitBtn1: TBitBtn;
    cdsNFCesVALOR_PEDIDO: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGerarXmlClick(Sender: TObject);
    procedure cdsNFCesAfterScroll(DataSet: TDataSet);
    procedure DBGridCBN1Enter(Sender: TObject);
    procedure DBGridCBN1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure chTodasClick(Sender: TObject);
    procedure DBGridCBN1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure busca_NFCes;
    procedure marca_desmarca(marca, todas :Boolean);

  public
    { Public declarations }
  end;

var
  frmNFCes: TfrmNFCes;

implementation

uses Repositorio, FabricaRepositorio, NFCE, EspecificacaoFiltraNFCe, ServicoEmissorNFCe, Parametros,
  Math, StrUtils, Pedido;

{$R *.dfm}

procedure TfrmNFCes.busca_NFCes;
var NFCEs         :TObjectList;
    Repositorio   :TRepositorio;
    Especificacao :TEspecificacaoFiltraNFCe;
    i             :integer;
    Pedido        :TPedido;

begin
  Repositorio   := nil;
  Especificacao := nil;
  NFCes         := nil;
  Pedido        := nil;
 try
   Repositorio   := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
   Especificacao := TEspecificacaoFiltraNFCe.Create(dtpInicio.DateTime, dtpFim.DateTime);
   NFCes         := Repositorio.GetListaPorEspecificacao( Especificacao );

   if not cdsNFCes.IsEmpty then
     cdsNFCes.EmptyDataSet;

   FreeAndNil( Repositorio );

   Repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

   if assigned(NFCes) then
     for i := 0 to NFCes.Count - 1 do begin

       Pedido := TPedido( Repositorio.Get(TNFCe( NFCes.Items[i] ).codigo_pedido) );

       cdsNFCes.Append;
       cdsNFCesNR_NOTA.AsInteger       := TNFCe( NFCes.Items[i] ).nr_nota;
       cdsNFCesCODIGO_PEDIDO.AsInteger := TNFCe( NFCes.Items[i] ).codigo_pedido;
       cdsNFCesVALOR_PEDIDO.AsFloat    := Pedido.valor_total;
       cdsNFCesCHAVE.AsString          := TNFCe( NFCes.Items[i] ).chave;
       cdsNFCesPROTOCOLO.AsString      := TNFCe( NFCes.Items[i] ).protocolo;
       cdsNFCesDH_RECEBIMENTO.AsString := FormatDateTime('dd/mm/yyyy hh:mm:ss', TNFCe(NFCes.Items[i] ).dh_recebimento);
       cdsNFCesSTATUS.AsString         := TNFCe( NFCes.Items[i] ).status;
       cdsNFCesMOTIVO.AsString         := TNFCe( NFCes.Items[i] ).motivo;
       cdsNFCesXML.LoadFromStream( TNFCe( NFCes.Items[i] ).XML );
       cdsNFCes.Post;

       FreeAndNil(Pedido);
     end;

     lbSelecionados.Caption := '0';
     
 finally
   FreeAndNil(Repositorio);
   FreeAndNil(NFCEs);
 end;
end;

procedure TfrmNFCes.FormShow(Sender: TObject);
begin
  if not cdsNFCes.Active then
    cdsNFCes.CreateDataSet;

  dtpInicio.DateTime := StrToDateTime(DateToStr(Date)+' 00:00:00');
  dtpFim.DateTime    := StrToDateTime(DateToStr(Date)+' 23:59:59');  
  busca_NFCes;
end;

procedure TfrmNFCes.BitBtn1Click(Sender: TObject);
var
  Parametros  :TParametros;
  NFCe        :TServicoEmissorNFCe;
begin
  if cdsNFCes.IsEmpty then
    exit;

  try
    Parametros := TParametros.Create;
    NFCe       := TServicoEmissorNFCe.Create(Parametros);

    NFCe.reimprimir(cdsNFCesXML.AsString);

  finally
    FreeAndNil(Parametros);
    FreeAndNil(NFCe);
  end;
end;

procedure TfrmNFCes.btnBuscaClick(Sender: TObject);
begin
  busca_NFCes;
end;

procedure TfrmNFCes.btnCancelarClick(Sender: TObject);
var
  idLote,vAux : String;
  XML         : TStringStream;
  Servico     : TServicoEmissorNFCe;
  Parametro   :TParametros;
  Justificativa :String;
begin
 try
   if not confirma('Deseja realmente cancelar a NFC-e nº '+cdsNFCesNR_NOTA.AsString+'?') then
     Exit;

   Parametro  := TParametros.Create;
   Servico    := TServicoEmissorNFCe.Create(Parametro);

   XML := TStringStream.Create(cdsNFCesXML.AsString);

   Justificativa := chamaInput('STRING', 'Justificativa de cancelamento');

   Servico.CancelarNFCe( XML , Justificativa);

   avisar('Operação realizada com sucesso!');
      
   btnBusca.Click;
 Except
   On E: Exception do begin
     Avisar('Erro ao cancelar NFC-e.'+#13#10+e.Message);
   end;
 end;
end;

procedure TfrmNFCes.btnGerarXmlClick(Sender: TObject);
var
  Dir: string;
begin
 try
   Dir := '';
   cdsNFCes.Filtered := false;
   cdsNFCes.Filter   := 'TAG = 1';
   cdsNFCes.Filtered := true;

   if SelectDirectory('Selecione a pasta de destino','',Dir) then begin

     cdsNFCes.first;
     while not cdsNFCes.Eof do begin

         cdsNFCesXML.SaveToFile(Dir+'/'+cdsNFCesCHAVE.AsString+'.xml');

       cdsNFCes.Next;
     end;

     busca_NFCes;
     btnGerarXml.Enabled := false;

     Avisar('Operação realizada com sucesso!');
   end;

   cdsNFCes.Filtered   := false;

 Except
   On E: Exception do begin
     Avisar('Erro ao gerar arquivos.'+#13#10+e.Message);
   end;
 end;
end;

procedure TfrmNFCes.cdsNFCesAfterScroll(DataSet: TDataSet);
begin
  btnCancelar.Enabled := false;

  if (cdsNFCesSTATUS.AsString = '100') then
     if ((formatDateTime('dd/mm/yyyy',cdsNFCesDH_RECEBIMENTO.AsDateTime) = DateToStr(Date) ) and
         (StrToInt(FormatDateTime('nn', (Time - StrToTime( formatDateTime('hh:mm:ss',cdsNFCesDH_RECEBIMENTO.AsDateTime))) )) < 30))
      OR
       ( StrToTime(FormatDateTime('hh:mm:ss',cdsNFCesDH_RECEBIMENTO.AsDateTime)) > StrToTime('23:30:00')) and (time < StrToTime('00:30:00'))
     then
       btnCancelar.Enabled := true;

end;

procedure TfrmNFCes.DBGridCBN1Enter(Sender: TObject);
begin
  cdsNFCesAfterScroll(nil);
end;

procedure TfrmNFCes.DBGridCBN1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (Column.Field = cdsNFCesSTATUS)or(Column.Field = cdsNFCesNR_NOTA) then begin
     TDBGridCBN(Sender).Canvas.FillRect(Rect);
     TDBgridCBN(Sender).Canvas.Font.Style := [fsBold];

     if (Column.Field = cdsNFCesSTATUS)and(self.cdsNFCesSTATUS.AsString = '100') then begin
        TDBgridCBN(Sender).Canvas.Font.Color := clGreen;
     end
     else if (Column.Field = cdsNFCesSTATUS)and(self.cdsNFCesSTATUS.AsString = '101') then begin
        TDBgridCBN(Sender).Canvas.Font.Color := clRed;
     end
     else if (Column.Field = cdsNFCesSTATUS) and not( StrToIntDef(self.cdsNFCesSTATUS.AsString,0) in [100,101]) then
        TDBgridCBN(Sender).Canvas.Font.Color := clGray;

     TDBgridCBN(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if cdsNFCesTAG.AsInteger = 1 then
    begin
      TDBGridCBN(Sender).Canvas.Font.Color := $00FFFDF9;
      TDBGridCBN(Sender).Canvas.Brush.Color := $00AD8361;
      TDBGridCBN(Sender).DefaultDrawDataCell(Rect, TDBGridCBN(Sender).columns[datacol].field, State);

      if Column.Field = cdsNFCesSTATUS then begin

        if (self.cdsNFCesSTATUS.AsString = '100') then begin
          TDBGridCBN(Sender).Canvas.FillRect(Rect);
          TDBgridCBN(Sender).Canvas.Font.Color := clLime;
          TDBgridCBN(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
        end;
      end;
    end;
end;

procedure TfrmNFCes.chTodasClick(Sender: TObject);
begin
    marca_desmarca(chTodas.Checked, true);
end;

procedure TfrmNFCes.marca_desmarca(marca, todas: Boolean);
begin
  if cdsNFCes.IsEmpty then Exit;

  if not todas then begin
    cdsNFCes.Edit;
    cdsNFCesTAG.AsInteger := IfThen(Marca, 1, 0);
    cdsNFCes.Post;

    lbSelecionados.Caption := IntToStr(StrToInt(lbSelecionados.Caption)+ IfThen(Marca, 1,-1));

  end
  else begin
    cdsNFCes.First;
    while not cdsNFCes.Eof do begin
      cdsNFCes.Edit;
      cdsNFCesTAG.AsInteger := IfThen(Marca, 1, 0);
      cdsNFCes.Post;

      cdsNFCes.Next;

      lbSelecionados.Caption := IntToStr(StrToInt(lbSelecionados.Caption)+ IfThen(Marca, 1,-1));
    end;
  end;

  btnGerarXml.Enabled := not (lbSelecionados.Caption = '0');  
end;

procedure TfrmNFCes.DBGridCBN1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_space then
    marca_desmarca(cdsNFCesTAG.AsInteger = 0, false);
end;

end.
