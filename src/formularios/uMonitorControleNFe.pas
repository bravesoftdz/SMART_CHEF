unit uMonitorControleNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ClipBrd,
  Dialogs, uPadrao, StdCtrls, ComCtrls, Grids, DBGrids, DBGridCBN, Buttons, System.StrUtils,
  DB, DBClient, Contnrs, Menus, ExtCtrls, EspecificacaoNotaFiscalPorPeriodoEStatus,
  NotaFiscal, fileCtrl, ImgList, pngimage, ComObj, System.ImageList, Generics.Collections, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TfrmMonitorControleNFe = class(TfrmPadrao)
    gbAcoes: TGroupBox;
    grid: TDBGridCBN;
    btnEnviar: TBitBtn;
    btnCancelar: TBitBtn;
    cds: TClientDataSet;
    cdsCODIGO: TIntegerField;
    cdsSERIE: TStringField;
    cdsEMITENTE: TStringField;
    cdsDESTINATARIO: TStringField;
    cdsDATA_EMISSAO: TDateTimeField;

    cdsCHAVE_NFE: TStringField;
    ds: TDataSource;
    cdsSTATUS: TIntegerField;
    pmnuOpcoesNF: TPopupMenu;
    mnuAlterarNotaFiscal: TMenuItem;
    pnlTopo: TPanel;
    gbFiltros: TGroupBox;
    gbFiltroPeriodo: TGroupBox;
    lblFiltroDataFinal: TLabel;
    lblFiltroDataInicial: TLabel;
    dtpFiltroDataFinal: TDateTimePicker;
    dtpFiltroDataInicial: TDateTimePicker;
    btnAtualizar: TBitBtn;
    gbFiltroStatus: TGroupBox;
    gbQuantidadeSelecionada: TGroupBox;
    lblAjudaEspacoSelecionar: TLabel;
    cdsSTATUS_STR: TStringField;
    cdsMOTIVO: TStringField;
    btnImprimirDANFE: TBitBtn;
    btnEnviarEmails: TBitBtn;
    cdsXML: TStringField;
    btnGerarArqXML: TBitBtn;
    cdsPEDIDOS: TStringField;
    pmnuOpcoesNFEnviadas: TPopupMenu;
    mnuCopiarChaveParaAreaTransferencia: TMenuItem;
    mnuConsultarNFe: TMenuItem;
    cdsNUMERO: TStringField;
    cdsIMAGEM: TBCDField;
    ImageList1: TImageList;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    chkFiltroAguardandoEnvio: TCheckBox;
    chkFiltroRejeitada: TCheckBox;
    chkFiltroAutorizada: TCheckBox;
    chkFiltroCancelada: TCheckBox;
    chkMarcarOuDesmarcarTodas: TCheckBox;
    Label2: TLabel;
    lbQtdSelecionada: TLabel;
    Shape1: TShape;
    Label3: TLabel;
    lblQtdNotas: TLabel;
    btnConsultaStatus: TBitBtn;
    Label1: TLabel;
    btnCriaNota: TBitBtn;
    edtQtdeAguardandoEnvio: TCurrencyEdit;
    edtQtdeRejeitadas: TCurrencyEdit;
    edtQtdeAutorizadas: TCurrencyEdit;
    edtQtdeCanceladas: TCurrencyEdit;
    btnAlterarNota: TBitBtn;
    btnInutilizar: TBitBtn;
    cdsTOTAL_NOTA: TFloatField;


    // Eventos
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsAfterScroll(DataSet: TDataSet);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkMarcarOuDesmarcarTodasClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirDANFEClick(Sender: TObject);
    procedure btnEnviarEmailsClick(Sender: TObject);
    procedure btnGerarArqXMLClick(Sender: TObject);
    procedure mnuCopiarChaveParaAreaTransferenciaClick(Sender: TObject);
    procedure mnuConsultarNFeClick(Sender: TObject);
    procedure btnConsultaStatusClick(Sender: TObject);
    procedure btnCriaNotaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarNotaClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


  private
    FNotasSelecionadas :TObjectList;
    buscando :Boolean;
    FSelecionadasAguardandoEnvio :integer;
    FSelecionadasRejeitadas :integer;
    FSelecionadasCanceladas :integer;
    FSelecionadasAutorizadas :integer;

  private
    function ApenasAguardandoEnvioERejeitadasSelecionadas            :Boolean;
    function ApenasAguardandoEnvioEAutorizadasSelecionadas           :Boolean;
    function ApenasAguardandoEnvioRejeitadasEAutorizadasSelecionadas :Boolean;
    function ApenasAutorizadasERejeitadasSelecionadas                :Boolean;
    function ApenasAutorizadasSelecionadas                           :Boolean;
    function ApenasAutorizadasECanceladasSelecionadas                :Boolean;

    function EstaAdicionada(const CodigoNotaFiscal :Integer) :Boolean;
    function RetornaQuantidadeSelecionadaPorTipo(Especificacao :TEspecificacaoNotaFiscalPorPeriodoEStatus) :Integer;
    function RetornaQuantidadeSelecionada                :Integer;

  private
    property QuantidadeSelecionada                :Integer read RetornaQuantidadeSelecionada;

  private
    procedure AdicionarEventosDeBusca;
    procedure AdicionarNotasFiscaisNoCDS(NotasFiscais :TObjectList<TNotaFiscal>);
    procedure AdicionarNotaSelecionada(NotaFiscal :TNotaFiscal);
    procedure AtualizarTela;
    procedure AtualizarEstadoDaOperacao(Status :String);
    procedure Buscar(Sender :TObject); overload;
    procedure Buscar;                  overload;
    procedure DeselecionarNotaFiscal(const CodigoNotaFiscal :Integer);
    procedure DeselecionarTodas;
    procedure RemoverEventosDeBusca;
    procedure RemoverNotaSelecionada(NotaFiscal :TNotaFiscal);
    procedure RemoverTodasNotasSelecionadas;
    procedure SelecionarNotaFiscal(const CodigoNotaFiscal :Integer);
    procedure SelecionarTodas;
    procedure GerarXML;
    procedure alterarNF;
    procedure salvaInutilizacao(nIni, nFim :integer; justificativa :String);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy; override;
  end;

var
  frmMonitorControleNFe: TfrmMonitorControleNFe;

implementation

uses
  TipoStatusNotaFiscal,
  Especificacao, Math,
  Repositorio,
  FabricaRepositorio,
  TipoSerie,
  uModulo,
  GeradorNFe,
  StringUtilitario,
  //Fatura,
  TipoDado,
  NotaInutilizada,
  Pedido,
  Item, ItemAvulso,
  ShellApi,
  Pessoa, PermissoesAcesso,
  uNotaFiscal,
  uInutilizaNumeracao;

{$R *.dfm}

{ TfrmMonitorControleNFe }

procedure TfrmMonitorControleNFe.AdicionarEventosDeBusca;
begin
   self.btnAtualizar.OnClick := self.Buscar;
end;

procedure TfrmMonitorControleNFe.AdicionarNotasFiscaisNoCDS(NotasFiscais: TObjectList<TNotaFiscal>);
var
  nX                :Integer;
  NF                :TNotaFiscal;
  nY                :Integer;
  Pedido            :TPedido;
  RepositorioPedido :TRepositorio;
begin
   self.cds.EmptyDataSet;

   if not Assigned(NotasFiscais) or (NotasFiscais.Count <= 0) then exit;

   edtQtdeAguardandoEnvio.Clear;
   edtQtdeRejeitadas.Clear;
   edtQtdeCanceladas.Clear;
   edtQtdeAutorizadas.Clear;

   cds.DisableControls;
   for nX := 0 to (NotasFiscais.Count-1) do
   begin
     Application.ProcessMessages;

     NF := NotasFiscais[nX];

     self.cds.Append;
     self.cdsCODIGO.AsInteger        := NF.CodigoNotaFiscal;
     self.cdsNUMERO.AsString         := IntToStr(NF.NumeroNotaFiscal);
     self.cdsSERIE.AsString          := NF.Serie;
     self.cdsEMITENTE.AsString       := NF.Emitente.Razao;
     self.cdsDESTINATARIO.AsString   := NF.Destinatario.Razao;
     self.cdsDATA_EMISSAO.AsDateTime := NF.DataEmissao;
     self.cdsCHAVE_NFE.AsString      := NF.ChaveAcesso;
     self.cdsSTATUS.AsInteger        := TTipoStatusNotaFiscalUtilitario.DeEnumeradoParaInteiro(NF.Status);
     self.cdsTOTAL_NOTA.AsFloat      := NF.Totais.TotalNF;

     case NF.Status of
       snfAguardandoEnvio : edtQtdeAguardandoEnvio.Value := edtQtdeAguardandoEnvio.Value + 1;
       snfRejeitada       : edtQtdeRejeitadas.Value      := edtQtdeRejeitadas.Value + 1;
       snfCancelada       : edtQtdeCanceladas.Value      := edtQtdeCanceladas.Value + 1;
       snfAutorizada      : edtQtdeAutorizadas.Value     := edtQtdeAutorizadas.Value + 1;
     end;

     if assigned(NF.NFe) then
     begin
       self.cdsXML.AsString          := NF.NFe.XMLText;
       if assigned(NF.NFe.Retorno) then
       begin
         self.cdsSTATUS_STR.AsString   := NF.NFe.Retorno.Status;
         self.cdsMOTIVO.AsString       := NF.NFe.Retorno.Motivo;
       end;
     end
     else
     begin
          self.cdsSTATUS_STR.AsString := '';
          self.cdsXML.AsString        := '';
          self.cdsMOTIVO.AsString     := 'AGUARDANDO ENVIO';
     end;
     self.cds.Post;
   end;

   cds.EnableControls;
   self.cds.First;
end;

procedure TfrmMonitorControleNFe.alterarNF;
var
  FrmAlteracaoNotaFiscal :TfrmNotaFiscal;
  NotaFiscal             :TNotaFiscal;
  Repositorio            :TRepositorio;
begin
   Repositorio            := nil;
   FrmAlteracaoNotaFiscal := nil;

   try
     self.DeselecionarNotaFiscal(self.cdsCODIGO.AsInteger);

     Repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     NotaFiscal  := (Repositorio.Get(self.cdsCODIGO.AsInteger) as TNotaFiscal);

     FrmAlteracaoNotaFiscal := TfrmNotaFiscal.Create(nil, NotaFiscal);
     FrmAlteracaoNotaFiscal.ShowModal;

     self.Buscar;

   finally
     FreeAndNil(Repositorio);

     if Assigned(FrmAlteracaoNotaFiscal) then begin
       FrmAlteracaoNotaFiscal.Release;
       FrmAlteracaoNotaFiscal := nil;
     end;

     FreeAndNil(NotaFiscal);
   end;
end;

procedure TfrmMonitorControleNFe.Buscar;
var
  Esp          :TEspecificacao;
  NotasFiscais :TObjectList<TNotaFiscal>;
  Repositorio  :TRepositorio;
begin

   Esp          := nil;
   Repositorio  := nil;
   NotasFiscais := nil;

   try
     Aguarda('Buscando notas fiscais...');
     Esp := TEspecificacaoNotaFiscalPorPeriodoEStatus.Create(self.dtpFiltroDataInicial.DateTime,
                                                             self.dtpFiltroDataFinal.DateTime,
                                                             self.chkFiltroAguardandoEnvio.Checked,
                                                             self.chkFiltroAutorizada.Checked,
                                                             self.chkFiltroRejeitada.Checked,
                                                             self.chkFiltroCancelada.Checked,
                                                             '1');

     Repositorio  := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     NotasFiscais := Repositorio.GetListaPorEspecificacao<TNotaFiscal>(Esp, ''''+formatDateTime('dd.mm.yyyy hh:mm:ss',dtpFiltroDataInicial.DateTime)+ ''' and ''' +
                                                                            formatDateTime('dd.mm.yyyy hh:mm:ss',dtpFiltroDataFinal.DateTime)+'''');

     self.AdicionarNotasFiscaisNoCDS(NotasFiscais);

     lblQtdNotas.Caption := IntToStr( self.cds.RecordCount );

   finally
     FimAguarda('');
     FreeAndNil(Esp);
     FreeAndNil(Repositorio);
     FreeAndNil(NotasFiscais);
   end;
end;

procedure TfrmMonitorControleNFe.Buscar(Sender: TObject);
begin
   self.Buscar;
end;

constructor TfrmMonitorControleNFe.Create(AOwner: TComponent);
begin
  inherited;

  self.FNotasSelecionadas               := TObjectList.Create;
  self.dtpFiltroDataInicial.DateTime    := strToDateTime( formatDateTime('dd/mm/yyyy 00:00:00', date) );
  self.dtpFiltroDataFinal.DateTime      := strToDateTime( formatDateTime('dd/mm/yyyy 23:59:59', date) );
  self.cds.CreateDataSet;
  self.chkFiltroAguardandoEnvio.Checked := true;
  self.chkFiltroRejeitada.Checked       := true;
  self.chkFiltroAutorizada.Checked      := true;
  self.AdicionarEventosDeBusca;
  self.Buscar;
  self.AtualizarTela;
end;

procedure TfrmMonitorControleNFe.gridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   inherited;
  // if (Column.Field = cdsNUMERO) then begin

   if Column.Field = CdsIMAGEM then begin
       TDBGridCBN(Sender).Canvas.FillRect(Rect);

       if (TTipoStatusNotaFiscalUtilitario.DeInteiroParaEnumerado(self.cdsSTATUS.AsInteger) = snfRejeitada) then begin
         { TDBgridCBN(Sender).Canvas.Font.Color := self.chkFiltroRejeitada.Font.Color;
          TDBgridCBN(Sender).Canvas.Font.Style := self.chkFiltroRejeitada.Font.Style;}
          ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +5, Rect.Top , 0, true)
       end
       else if (TTipoStatusNotaFiscalUtilitario.DeInteiroParaEnumerado(self.cdsSTATUS.AsInteger) = snfAutorizada) then begin
         { TDBgridCBN(Sender).Canvas.Font.Color := self.chkFiltroAutorizada.Font.Color;
          TDBgridCBN(Sender).Canvas.Font.Style := self.chkFiltroAutorizada.Font.Style;}
         ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +5, Rect.Top , 1, true)
       end
       else if (TTipoStatusNotaFiscalUtilitario.DeInteiroParaEnumerado(self.cdsSTATUS.AsInteger) = snfCancelada) then begin
         { TDBgridCBN(Sender).Canvas.Font.Color := self.chkFiltroCancelada.Font.Color;
          TDBgridCBN(Sender).Canvas.Font.Style := self.chkFiltroCancelada.Font.Style;}
          ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +5, Rect.Top , 2, true)
       end
       else
          ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +5, Rect.Top , 3, true);
   end;


   if self.EstaAdicionada(self.cdsCODIGO.AsInteger) then begin
       TDBgridCBN(Sender).Canvas.Brush.Color := clSkyBlue;

     //TDBgridCBN(Sender).Canvas.FillRect(Rect);
     //TDBgridCBN(Sender).DefaultDrawDataCell(Rect, Column.Field, State);

     if not (Column.Field = CdsIMAGEM) then begin
       TDBgridCBN(Sender).Canvas.FillRect( rect );
       TDBgridCBN(Sender).DefaultDrawColumnCell( Rect, DataCol, Column, state);
     end;
   end;


end;

procedure TfrmMonitorControleNFe.RemoverEventosDeBusca;
begin
   self.btnAtualizar.OnClick             := nil;
   self.chkFiltroAguardandoEnvio.OnClick := nil;
   self.chkFiltroRejeitada.OnClick       := nil;
   self.chkFiltroAutorizada.OnClick      := nil;
   self.chkFiltroCancelada.OnClick       := nil;
end;

procedure TfrmMonitorControleNFe.cdsAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if      (DataSet.FieldByName(self.cdsSTATUS.FieldName).AsInteger = TTipoStatusNotaFiscalUtilitario.DeEnumeradoParaInteiro(snfAguardandoEnvio)) or
          (DataSet.FieldByName(self.cdsSTATUS.FieldName).AsInteger = TTipoStatusNotaFiscalUtilitario.DeEnumeradoParaInteiro(snfRejeitada))       then
    self.grid.PopupMenu := self.pmnuOpcoesNF
  else if (DataSet.FieldByName(self.cdsSTATUS.FieldName).AsInteger = TTipoStatusNotaFiscalUtilitario.DeEnumeradoParaInteiro(snfAutorizada)) then
    self.grid.PopupMenu := self.pmnuOpcoesNFEnviadas
  else
    self.grid.PopupMenu := nil;
end;

destructor TfrmMonitorControleNFe.Destroy;
begin
  self.cds.Close;
  FreeAndNil(self.FNotasSelecionadas);
  
  inherited;
end;

procedure TfrmMonitorControleNFe.AtualizarTela;
begin
   self.grid.Repaint;
   self.lbQtdSelecionada.Caption                        := IntToStr(self.QuantidadeSelecionada);

   self.btnEnviar.Enabled                 := self.ApenasAguardandoEnvioERejeitadasSelecionadas;
   self.btnCancelar.Enabled               := self.ApenasAutorizadasERejeitadasSelecionadas;
   self.btnImprimirDANFE.Enabled          := self.ApenasAguardandoEnvioRejeitadasEAutorizadasSelecionadas;
   self.btnEnviarEmails.Enabled           := self.ApenasAutorizadasSelecionadas;
   self.btnGerarArqXML.Enabled            := self.ApenasAutorizadasECanceladasSelecionadas;
   self.btnAlterarNota.Enabled            := self.ApenasAguardandoEnvioERejeitadasSelecionadas;
   self.btnConsultaStatus.Enabled         := self.ApenasAutorizadasERejeitadasSelecionadas;
end;

procedure TfrmMonitorControleNFe.btnAlterarNotaClick(Sender: TObject);
begin
  alterarNF;
end;

function TfrmMonitorControleNFe.RetornaQuantidadeSelecionadaPorTipo(
  Especificacao: TEspecificacaoNotaFiscalPorPeriodoEStatus): Integer;
var
  nX :Integer;
begin
   result := 0;

   for nX := 0 to (self.FNotasSelecionadas.Count-1) do begin
      if Especificacao.SatisfeitoPor(self.FNotasSelecionadas[nX]) then
        Inc(result);
   end;
end;

procedure TfrmMonitorControleNFe.salvaInutilizacao(nIni, nFim: integer; justificativa: String);
var repositorio :TRepositorio;
    NotaInutilizada :TNotaInutilizada;
begin
  try
    repositorio     := TFabricaRepositorio.GetRepositorio(TNotaInutilizada.ClassName);
    NotaInutilizada := TNotaInutilizada.Create;

    NotaInutilizada.modelo := '65';
    NotaInutilizada.serie  := '1';
    NotaInutilizada.inicio := nIni;
    NotaInutilizada.fim    := nFim;
    NotaInutilizada.justificativa := justificativa;

    repositorio.Salvar(NotaInutilizada);
  finally
    FreeAndNil(repositorio);
    FreeAndNil(NotaInutilizada);
  end;
end;

function TfrmMonitorControleNFe.RetornaQuantidadeSelecionada: Integer;
begin
   result := self.FNotasSelecionadas.Count;
end;

function TfrmMonitorControleNFe.ApenasAguardandoEnvioERejeitadasSelecionadas: Boolean;
begin
   result := (QuantidadeSelecionada = (FSelecionadasAguardandoEnvio + FSelecionadasRejeitadas)) and
             (QuantidadeSelecionada <> 0);
end;

function TfrmMonitorControleNFe.ApenasAutorizadasSelecionadas: Boolean;
begin
   result := (self.QuantidadeSelecionada = FSelecionadasAutorizadas) and
             (QuantidadeSelecionada <> 0);
end;

procedure TfrmMonitorControleNFe.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_SPACE) then begin

     // keybd_event(VK_BACK, 0, 0, 0);

      if not self.EstaAdicionada(self.cdsCODIGO.AsInteger) then
        self.SelecionarNotaFiscal(self.cdsCODIGO.AsInteger)
      else
        self.DeselecionarNotaFiscal(self.cdsCODIGO.AsInteger);
   end
   else if (Shift = [ssCtrl]) and (key = ord('C')) then
     Clipboard.asText := cdsCHAVE_NFE.AsString;

end;

function TfrmMonitorControleNFe.EstaAdicionada(const CodigoNotaFiscal :Integer): Boolean;
var
  nX          :Integer;
  NotaFiscal  :TNotaFiscal;
begin
   result := false;
   
   for nX := 0 to (self.FNotasSelecionadas.Count-1) do begin
      NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

      result := (NotaFiscal.CodigoNotaFiscal = CodigoNotaFiscal);

      if result then
        exit;
   end;
end;

procedure TfrmMonitorControleNFe.FormCreate(Sender: TObject);
begin
  inherited;
  FSelecionadasAguardandoEnvio := 0;
  FSelecionadasRejeitadas      := 0;
  FSelecionadasCanceladas      := 0;
  FSelecionadasAutorizadas     := 0;
end;

procedure TfrmMonitorControleNFe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_F1) and (btnCriaNota.Enabled) then
    btnCriaNota.Click
  else if (key = VK_F2) and (btnAlterarNota.Enabled) then
    btnAlterarNota.Click
  else if (key = VK_F3) and (btnEnviar.Enabled) then
    btnEnviar.Click
  else if (key = VK_F4) and (btnImprimirDANFE.Enabled) then
    btnImprimirDANFE.Click
  else if (key = VK_F5) and (btnCancelar.Enabled) then
    btnCancelar.Click;

  inherited;
end;

procedure TfrmMonitorControleNFe.DeselecionarNotaFiscal(
  const CodigoNotaFiscal: Integer);
var
  NotaFiscal :TNotaFiscal;
  nX :Integer;
begin
   for nX := 0 to (self.FNotasSelecionadas.Count-1) do begin
      NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

      if (NotaFiscal.CodigoNotaFiscal = CodigoNotaFiscal) then begin
         case NotaFiscal.Status of
           snfAguardandoEnvio : dec(FSelecionadasAguardandoEnvio);
           snfRejeitada       : dec(FSelecionadasRejeitadas);
           snfCancelada       : dec(FSelecionadasCanceladas);
           snfAutorizada      : dec(FSelecionadasAutorizadas);
         end;
         self.RemoverNotaSelecionada(NotaFiscal);
         exit;
      end;
   end;
end;

procedure TfrmMonitorControleNFe.SelecionarNotaFiscal(
  const CodigoNotaFiscal: Integer);
var
  Repositorio :TRepositorio;
  NotaFiscal  :TNotaFiscal;
begin
   Repositorio := nil;

   if self.EstaAdicionada(CodigoNotaFiscal) then
    exit;

   try
     Repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     NotaFiscal  := (Repositorio.Get(CodigoNotaFiscal) as TNotaFiscal);

     case NotaFiscal.Status of
       snfAguardandoEnvio : inc(FSelecionadasAguardandoEnvio);
       snfRejeitada       : inc(FSelecionadasRejeitadas);
       snfCancelada       : inc(FSelecionadasCanceladas);
       snfAutorizada      : inc(FSelecionadasAutorizadas);
     end;

     self.AdicionarNotaSelecionada(NotaFiscal);

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmMonitorControleNFe.AdicionarNotaSelecionada(
  NotaFiscal: TNotaFiscal);
begin
   self.FNotasSelecionadas.Add(NotaFiscal);
   self.AtualizarTela;
end;

procedure TfrmMonitorControleNFe.RemoverNotaSelecionada(
  NotaFiscal: TNotaFiscal);
begin
   self.FNotasSelecionadas.Remove(NotaFiscal);
   self.AtualizarTela;
end;

procedure TfrmMonitorControleNFe.chkMarcarOuDesmarcarTodasClick(
  Sender: TObject);
begin
   if TCheckBox(Sender).Checked then
    self.SelecionarTodas
   else
    self.DeselecionarTodas;
end;

procedure TfrmMonitorControleNFe.DeselecionarTodas;
begin
   if self.cds.IsEmpty then exit;

   self.cds.First;
   while not self.cds.Eof do begin
      self.DeselecionarNotaFiscal(self.cdsCODIGO.AsInteger);
      self.cds.Next;
   end;
end;

procedure TfrmMonitorControleNFe.SelecionarTodas;
begin
   if self.cds.IsEmpty then exit;

   self.cds.First;
   while not self.cds.Eof do begin
      self.SelecionarNotaFiscal(self.cdsCODIGO.AsInteger);
      self.cds.Next;
   end;
end;

procedure TfrmMonitorControleNFe.btnEnviarClick(Sender: TObject);
var
  RepositorioNotaFiscal      :TRepositorio;
  GeradorNFe                 :TGeradorNFe;
  NotaFiscal                 :TNotaFiscal;
  nX                         :Integer;
  HouveErros                 :Boolean;
  notasComRejeicao           :String;
begin
   dm.conexao.TxOptions.AutoCommit := false;

   if not inherited Confirma('Deseja emitir as notas selecionadas?') then
    exit;

   RepositorioNotaFiscal      := nil;
   GeradorNFe                 := nil;
   HouveErros                 := false;

   try
     RepositorioNotaFiscal      := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);

     GeradorNFe := TGeradorNFe.Create(FDM.Logo);
     for nX := 0 to (self.FNotasSelecionadas.Count-1) do
        try

          NotaFiscal := nil;
          NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

          self.AtualizarEstadoDaOperacao('Buscando certificado digital...');

          { Obtendo o número do certificado caso não esteja cadastrado }
          if TStringUtilitario.EstaVazia(NotaFiscal.Empresa.ConfiguracoesNF.num_certificado) then begin
            try
              NotaFiscal.Empresa.ConfiguracoesNF.num_certificado := GeradorNFe.ObterCertificado;
            except
              on E: Exception do
                raise Exception.Create('Certificado digital não selecionado!');
            end;
          end;

          { Gravo Lote com Status de Enviando }
          try
            self.AtualizarEstadoDaOperacao('Criando lote para nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            NotaFiscal.CriaLoteEnvio();
            RepositorioNotaFiscal.Salvar(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao gravar lote da nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Emitir para SEFAZ }
          try
            self.AtualizarEstadoDaOperacao('Emitindo nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            GeradorNFe.EmitirNFe(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao emitir para SEFAZ a nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Consultar no SEFAZ }
          try
            self.AtualizarEstadoDaOperacao('Consultando nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            sleep(1000);
            GeradorNFe.ConsultarNFe(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao consultar no SEFAZ a nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Persistir Nota Fiscal }
          try
            self.AtualizarEstadoDaOperacao('Gravando nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            NotaFiscal.DataSaida := now;
            RepositorioNotaFiscal.Salvar(NotaFiscal);

            if assigned(NotaFiscal.NFe) and (NotaFiscal.NFe.Retorno.Status <> '100') then
              notasComRejeicao := notasComRejeicao + ' ,' + intToStr(NotaFiscal.NumeroNotaFiscal);

          except
            on E: Exception do
              raise Exception.Create('Erro ao gravar nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Enviar E-mail }
          if assigned(NotaFiscal.NFe) and (NotaFiscal.NFe.Retorno.Status = '100') then
            begin
            try
              self.AtualizarEstadoDaOperacao('Enviando e-mail da nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal));
              GeradorNFe.EnviarEmail(NotaFiscal);
            except
              on E: Exception do
                avisar('Erro ao enviar e-mail da nota fiscal Nº '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                         NotaFiscal.Destinatario.Razao+'.'+#13+
                        'Erro: '+E.Message);
            end;
          end;

          GeradorNFe.Recarregar;
        except
          on E: Exception do begin
            dm.LogErros.AdicionaErro('uMonitorControleNFe', E.ClassName, E.Message);
            HouveErros := true;
            continue;
          end;
        end;

     if HouveErros then begin
       dm.conexao.Rollback;

        if inherited Confirma('Houve erros no processo. Consulte o log na pasta raiz do sistema para maiores detalhes.') then
          inherited AbrirArquivo(dm.LogErros.NomeArquivo);
     end
     else begin
       dm.conexao.Commit;
       notasComRejeicao := copy(trim(notasComRejeicao), 2, length(notasComRejeicao));
       if notasComRejeicao <> '' then
         notasComRejeicao := 'Nota(s) '+notasComRejeicao+' foi(ram) rejeitada(s)';

       avisar(IfThen(notasComRejeicao <> '', notasComRejeicao, 'Nota(s) enviada(s) com sucesso!'),2);
     end;

     { Mostrara todas as notas desse período. Assim o usuário poderá identificar o retorno do SEFAZ }
     self.RemoverEventosDeBusca;
     self.chkFiltroAguardandoEnvio.Checked := true;
     self.chkFiltroRejeitada.Checked       := true;
     self.chkFiltroAutorizada.Checked      := true;
     self.chkFiltroCancelada.Checked       := true;
     self.Buscar;
     self.AdicionarEventosDeBusca;
   finally
     dm.conexao.TxOptions.AutoCommit := true;
     self.RemoverTodasNotasSelecionadas;

     FreeAndNil(RepositorioNotaFiscal);
     FreeAndNil(GeradorNFe);
     FimAguarda('');
   end;
end;

procedure TfrmMonitorControleNFe.AtualizarEstadoDaOperacao(Status: String);
begin
   Aguarda(status);
   Application.ProcessMessages;
end;

procedure TfrmMonitorControleNFe.btnCancelarClick(Sender: TObject);
var
  RepositorioNotaFiscal      :TRepositorio;
  GeradorNFe                 :TGeradorNFe;
  NotaFiscal                 :TNotaFiscal;
  nX                         :Integer;
  HouveErros                 :Boolean;
  Justificativa              :String;
begin
   if not inherited Confirma('Deseja cancelar as notas selecionadas?') then
    exit;

   RepositorioNotaFiscal      := nil;
   GeradorNFe                 := nil;
   HouveErros                 := false;

   dm.conexao.TxOptions.AutoCommit := false;

   try
     Justificativa              := chamaInput(tpTexto,'Digite a justificativa. (Se não digitar a justificativa será: CANCELAMENTO DE NF-E)');
     RepositorioNotaFiscal      := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);

     GeradorNFe := TGeradorNFe.Create(FDM.Logo);
     for nX := 0 to (self.FNotasSelecionadas.Count-1) do
        try
          NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

          self.AtualizarEstadoDaOperacao('Buscando certificado digital...');

          { Obtendo o número do certificado caso não esteja cadastrado }
          if TStringUtilitario.EstaVazia(NotaFiscal.Empresa.ConfiguracoesNF.num_certificado) then begin
            try
              NotaFiscal.Empresa.ConfiguracoesNF.num_certificado := GeradorNFe.ObterCertificado;
            except
              on E: Exception do
                raise Exception.Create('Certificado digital não selecionado!');
            end;
          end;

          { Cancelar NF-e no SEFAZ }
          try
            self.AtualizarEstadoDaOperacao('Cancelando nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            GeradorNFe.CancelarNFe(NotaFiscal, Justificativa);
          except
            on E: Exception do
              raise Exception.Create('Erro ao cancelar nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Gerar XML de cancelamento da nota fiscal }
          try
            self.AtualizarEstadoDaOperacao('Gerando XML de cancelamento da nota fiscal'+IntToStr(NotaFiscal.NumeroNotaFiscal));
            GeradorNFe.GerarXML(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao gerar XML de cancelamento da nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          { Persistir Nota Fiscal }
          try
            self.AtualizarEstadoDaOperacao('Gravando nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal));

            NotaFiscal.LimparPedidosFaturados();
            RepositorioNotaFiscal.Salvar(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao gravar nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          GeradorNFe.Recarregar;

        except
          on E: Exception do begin
            dm.LogErros.AdicionaErro('uMonitorControleNFe', E.ClassName, E.Message);
            HouveErros := true;
            continue;
          end;
        end;

     if HouveErros then begin
       dm.conexao.Rollback;

        if inherited Confirma('Houve erros no processo. Consulte o log na pasta raiz do sistema para maiores detalhes.') then
          inherited AbrirArquivo(dm.LogErros.NomeArquivo);
     end
     else begin
       dm.conexao.Commit;
       avisar('Nota cancelada com sucesso!',2);
     end;

     { Mostrara todas as notas desse período. Assim o usuário poderá identificar o retorno do SEFAZ }
     self.RemoverEventosDeBusca;
     self.chkFiltroAguardandoEnvio.Checked := true;
     self.chkFiltroRejeitada.Checked       := true;
     self.chkFiltroAutorizada.Checked      := true;
     self.chkFiltroCancelada.Checked       := true;
     self.Buscar;
     self.AdicionarEventosDeBusca;
   finally
     FimAguarda('');   
     dm.conexao.TxOptions.AutoCommit := true;
     self.RemoverTodasNotasSelecionadas;

     FreeAndNil(RepositorioNotaFiscal);
     FreeAndNil(GeradorNFe);
   end;
end;

function TfrmMonitorControleNFe.ApenasAutorizadasERejeitadasSelecionadas: Boolean;
begin
   result := (QuantidadeSelecionada = (FSelecionadasAutorizadas + FSelecionadasRejeitadas)) and
             (QuantidadeSelecionada <> 0);
end;

procedure TfrmMonitorControleNFe.btnImprimirDANFEClick(Sender: TObject);
var
  RepositorioNotaFiscal      :TRepositorio;
  GeradorNFe                 :TGeradorNFe;
  NotaFiscal                 :TNotaFiscal;
  nX                         :Integer;
  HouveErros                 :Boolean;
begin
   if not inherited Confirma('Deseja imprimir as notas selecionadas?') then
    exit;

   RepositorioNotaFiscal      := nil;
   GeradorNFe                 := nil;
   HouveErros                 := false;

   try
     RepositorioNotaFiscal      := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);

     GeradorNFe := TGeradorNFe.Create(FDM.Logo);
     for nX := 0 to (self.FNotasSelecionadas.Count-1) do
        try
          NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

          { Imprimir DANFE }
          try
            self.AtualizarEstadoDaOperacao('Imprimindo DANFE da nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            GeradorNFe.ImprimirComVisualizacao(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao imprimir DANFE da nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          GeradorNFe.Recarregar;
        except
          on E: Exception do begin
            dm.LogErros.AdicionaErro('uMonitorControleNFe', E.ClassName, E.Message);
            HouveErros := true;
            continue;
          end;
        end;

     if HouveErros then begin
        if inherited Confirma('Houve erros no processo. Consulte o log na pasta raiz do sistema para maiores detalhes.') then
          inherited AbrirArquivo(dm.LogErros.NomeArquivo);
     end;

   finally
     self.RemoverTodasNotasSelecionadas;

     FreeAndNil(RepositorioNotaFiscal);
     FreeAndNil(GeradorNFe);
     FimAguarda('');
   end;
end;

procedure TfrmMonitorControleNFe.btnInutilizarClick(Sender: TObject);
var
  GeradorNFe                 :TGeradorNFe;
begin
  try
    frmInutilizaNumeracao := TFrmInutilizaNumeracao.Create(nil);

    if frmInutilizaNumeracao.ShowModal = mrOk then
    begin
      GeradorNFe := TGeradorNFe.Create(FDM.Logo);
      if GeradorNFe.inutilizarNumeracao(frmInutilizaNumeracao.edtInicial.AsInteger,
                                        frmInutilizaNumeracao.edtFinal.Value,
                                        frmInutilizaNumeracao.memoJustificativa.Text,
                                        dm.Empresa) then
      begin
        salvaInutilizacao(frmInutilizaNumeracao.edtInicial.AsInteger, frmInutilizaNumeracao.edtFinal.Value, frmInutilizaNumeracao.memoJustificativa.Text);
        avisar('Numeração ['+frmInutilizaNumeracao.edtInicial.Text+' ao '+frmInutilizaNumeracao.edtFinal.Text+'] inutilizada com sucesso.', 2);
      end;
    end;

    frmInutilizaNumeracao.Release;
    frmInutilizaNumeracao := nil;

  Except
    on e :Exception do
      avisar('Erro ao inutilizar numeração.'+#13#10+e.Message);
  end;
end;

procedure TfrmMonitorControleNFe.btnEnviarEmailsClick(Sender: TObject);
var
  RepositorioNotaFiscal      :TRepositorio;
  GeradorNFe                 :TGeradorNFe;
  NotaFiscal                 :TNotaFiscal;
  nX                         :Integer;
  HouveErros                 :Boolean;
begin
   if not inherited Confirma('Deseja enviar e-mail das notas selecionadas?') then
    exit;

   RepositorioNotaFiscal      := nil;
   GeradorNFe                 := nil;
   HouveErros                 := false;

   try
     RepositorioNotaFiscal      := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);

     GeradorNFe := TGeradorNFe.Create(FDM.Logo);
     for nX := 0 to (self.FNotasSelecionadas.Count-1) do
        try
          NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

          { Enviar E-mail }
          try
            self.AtualizarEstadoDaOperacao('Enviando e-mail da nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal));
            GeradorNFe.EnviarEmail(NotaFiscal);
          except
            on E: Exception do
              raise Exception.Create('Erro ao enviar e-mail da nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                     NotaFiscal.Destinatario.Razao+'.'+#13+
                                     'Erro: '+E.Message);
          end;

          GeradorNFe.Recarregar;
        except
          on E: Exception do begin
            dm.LogErros.AdicionaErro('uMonitorControleNFe', E.ClassName, E.Message);
            HouveErros := true;
            continue;
          end;
        end;

     if HouveErros then begin
        if inherited Confirma('Houve erros no processo. Consulte o log na pasta raiz do sistema para maiores detalhes.') then
          inherited AbrirArquivo(dm.LogErros.NomeArquivo);
     end
     else
       avisar('Operação realizada com sucesso');

   finally
     FimAguarda('');  

     self.RemoverTodasNotasSelecionadas;

     FreeAndNil(RepositorioNotaFiscal);
     FreeAndNil(GeradorNFe);
   end;
end;

procedure TfrmMonitorControleNFe.btnGerarArqXMLClick(Sender: TObject);
begin
  self.gerarXml;
end;

procedure TfrmMonitorControleNFe.GerarXML;
var   NotaFiscal :TNotaFiscal;
      caminho    :String;
      nX         :Integer;
begin

  SelectDirectory('Selecionar Pasta','', caminho);

  if caminho = '' then begin
    avisar('Operação cancelada',2);
    exit;
  end;

  try
       for nX := 0 to (self.FNotasSelecionadas.Count-1) do begin
           NotaFiscal := (self.FNotasSelecionadas[nX] as TNotaFiscal);

           NotaFiscal.NFe.XML.SaveToFile(caminho+'\NFe'+intToStr(NotaFiscal.NumeroNotaFiscal)+'.xml');
       end;
  finally
    self.RemoverTodasNotasSelecionadas;
  end;
end;

function TfrmMonitorControleNFe.ApenasAguardandoEnvioRejeitadasEAutorizadasSelecionadas: Boolean;
begin
   result := (QuantidadeSelecionada = (FSelecionadasAutorizadas     +
                                       FSelecionadasRejeitadas       +
                                       FSelecionadasAguardandoEnvio) )
          and
             (QuantidadeSelecionada <> 0);
end;

function TfrmMonitorControleNFe.ApenasAguardandoEnvioEAutorizadasSelecionadas: Boolean;
begin
   result := (QuantidadeSelecionada = (FSelecionadasAutorizadas + FSelecionadasAutorizadas)) and
             (QuantidadeSelecionada <> 0);
end;


function TfrmMonitorControleNFe.ApenasAutorizadasECanceladasSelecionadas: Boolean;
begin
   result := (QuantidadeSelecionada = (FSelecionadasAutorizadas +
                                       FSelecionadasCanceladas))
          and
             (QuantidadeSelecionada <> 0);
end;

procedure TfrmMonitorControleNFe.mnuCopiarChaveParaAreaTransferenciaClick(
  Sender: TObject);
begin
   Clipboard.AsText := self.cdsCHAVE_NFE.AsString;
end;

procedure TfrmMonitorControleNFe.mnuConsultarNFeClick(Sender: TObject);
begin
   self.mnuCopiarChaveParaAreaTransferencia.OnClick(mnuCopiarChaveParaAreaTransferencia);
   ShellExecute(Handle, 'open', 'iexplore', 'http://www.fazenda.pr.gov.br/', '', 1);
end;

procedure TfrmMonitorControleNFe.RemoverTodasNotasSelecionadas;
begin
   self.FNotasSelecionadas.Clear;
   FSelecionadasAguardandoEnvio := 0;
   FSelecionadasRejeitadas      := 0;
   FSelecionadasCanceladas      := 0;
   FSelecionadasAutorizadas     := 0;
   self.AtualizarTela;
end;

procedure TfrmMonitorControleNFe.btnConsultaStatusClick(Sender: TObject);
var
  RepositorioNotaFiscal      :TRepositorio;
  GeradorNFe                 :TGeradorNFe;
  NotaFiscal                 :TNotaFiscal;
  nX                         :Integer;
begin
 try
    RepositorioNotaFiscal  := nil;
    GeradorNFe             := nil;
    NotaFiscal             := nil;

    RepositorioNotaFiscal  := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
    GeradorNFe             := TGeradorNFe.Create(FDM.Logo);

    for nX := 0 to (self.FNotasSelecionadas.Count-1) do
    begin
       NotaFiscal             := (self.FNotasSelecionadas[nX] as TNotaFiscal);

       Aguarda('Consultando nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal));
       Application.ProcessMessages;

       { Obtendo o número do certificado caso não esteja cadastrado }
       if TStringUtilitario.EstaVazia(NotaFiscal.Empresa.ConfiguracoesNF.num_certificado) then begin
         try
           NotaFiscal.Empresa.ConfiguracoesNF.num_certificado := GeradorNFe.ObterCertificado;
         except
           on E: Exception do
             raise Exception.Create('Certificado digital não selecionado!');
         end;
       end;

       { Consultar no SEFAZ }
       try
         GeradorNFe.ConsultarNFe(NotaFiscal);
       except
         on E: Exception do
           raise Exception.Create('Erro ao consultar no SEFAZ a nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                  NotaFiscal.Destinatario.Razao+'.'+#13+
                                  'Erro: '+E.Message);
       end;

       { Persistir Nota Fiscal }
       try
         RepositorioNotaFiscal.Salvar(NotaFiscal);
       except
         on E: Exception do
           raise Exception.Create('Erro ao gravar nota fiscal '+IntToStr(NotaFiscal.NumeroNotaFiscal)+' destinada a '+
                                  NotaFiscal.Destinatario.Razao+'.'+#13+
                                  'Erro: '+E.Message);
       end;

    end;

    self.Buscar;

 Finally
    FimAguarda('');
    self.RemoverTodasNotasSelecionadas;
    FreeAndNil(RepositorioNotaFiscal);
    FreeAndNil(GeradorNFe);
 end;
end;

procedure TfrmMonitorControleNFe.btnCriaNotaClick(Sender: TObject);
begin
  self.AbreForm(TFrmNotaFiscal, paNotaFiscal);
  btnAtualizar.Click;
end;

end.
