unit uCadastroPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, frameListaCampo, StdCtrls, Mask,
  Grids, DBGrids, DBGridCBN, ComCtrls, Buttons, ExtCtrls, DB, DBClient, Especificacao,
  ImgList, pngimage;

{ Enumerado que identifica o estado que a tela está }
type TTipoEstadoTela = (tetConsultar, tetVisualizar, tetIncluir, tetAlterar, tetSalvar, tetPesquisar);

type
  TfrmCadastroPadrao = class(TfrmPadrao)

    pnlBotoes     :TPanel;
    cds: TClientDataSet;
    ds: TDataSource;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnCancelar: TBitBtn;
    btnSalvar: TBitBtn;
    Splitter1: TSplitter;
    pgGeral: TPageControl;
    tsConsulta: TTabSheet;
    gridConsulta: TDBGridCBN;
    lblAjudaSelecionar: TStaticText;
    tsDados: TTabSheet;
    pnlDados: TPanel;
    lblCamposObrigatorios: TLabel;
    lblAsterisco: TLabel;
    Shape2: TShape;
    procedure pgGeralChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FEstadoTela           :TTipoEstadoTela;

  private
    procedure SetEstadoTela(const Value: TTipoEstadoTela);

    procedure AtalhosNormais  (Sender :TObject; var Key :Word; Shift :TShiftState);
    procedure AtalhosPesquisar(Sender :TObject; var Key :Word; Shift :TShiftState);

  protected
    FEspecificacaoDeBusca :TEspecificacao;
    
  protected
    { Quando essa propriedade é alterada, também é alterado o comportamento da tela }
    property EstadoTela :TTipoEstadoTela read FEstadoTela write SetEstadoTela;

  protected
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); virtual;

    procedure ExecutarAntesAlterar;     virtual;
    procedure ExecutarAntesConsultar;   virtual;
    procedure ExecutarAntesIncluir;     virtual;
    procedure ExecutarAntesPesquisar;   virtual;
    procedure ExecutarAntesSalvar;      virtual;
    procedure ExecutarAntesVisualizar;  virtual;

    procedure ExecutarDepoisAlterar;    virtual;
    procedure ExecutarDepoisConsultar;  virtual;
    procedure ExecutarDepoisIncluir;    virtual;
    procedure ExecutarDepoisPesquisar;  virtual;
    procedure ExecutarDepoisSalvar;     virtual;
    procedure ExecutarDepoisVisualizar; virtual;

    { Carrega todos os registros pra aba de consulta }
    procedure CarregarDados(); overload; virtual; 

    { Carrega os registros de acordo com uma especificação. É utilizado apenas no modo de busca. }
    procedure CarregarDados(Especificacao :TEspecificacao); overload; virtual; 

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); virtual;

    { Limpa as informações da aba Dados }
    procedure LimparDados;              virtual;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;             virtual;

  protected
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;    virtual;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;    virtual;

  public
    constructor Create         (AOwner :TComponent); override;
    constructor CreateModoBusca(AOwner :TComponent); overload;
    constructor CreateModoBusca(AOwner :TComponent; Especificacao :TEspecificacao); overload;

    destructor Destroy; override; 
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

//uses
//  ExcecaoMetodoNaoImplementado;

{$R *.dfm}

{ TfrmCadastroPadrao }

procedure TfrmCadastroPadrao.AtalhosNormais(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   // Consultar
   if      (Key = VK_F1) and (Shift = [])                                                           then self.EstadoTela := tetConsultar
   // Visualizar
   else if (Key = VK_F2) and (Shift = [])                                                           then self.EstadoTela := tetVisualizar
   // Incluir
   else if (Key = VK_F3) and (self.btnIncluir.Enabled and self.btnIncluir.Visible) and (Shift = []) then self.EstadoTela := tetIncluir
   // Alterar
   else if (Key = VK_F4) and (self.btnAlterar.Enabled and self.btnAlterar.Visible) and (Shift = []) then self.EstadoTela := tetAlterar

   else
     inherited FormKeyDown(Sender, Key, Shift);

end;

procedure TfrmCadastroPadrao.AtalhosPesquisar(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if ((not self.cds.IsEmpty) and (self.gridConsulta.Focused) and (Key = VK_RETURN)) then
      self.ModalResult := mrOK
  else
      inherited FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmCadastroPadrao.CarregarDados(Especificacao :TEspecificacao);
begin
   { Método a ser implementado na sub-classe }
//   raise TExcecaoMetodoNaoImplementado.Create('TfrmCadastroPadrao', 'CarregarDados(Especificacao :TEspecificacao)');
end;

constructor TfrmCadastroPadrao.Create(AOwner: TComponent);
begin
   inherited;

   self.cds.CreateDataSet;

   if Assigned(self.FEspecificacaoDeBusca) then self.CarregarDados(self.FEspecificacaoDeBusca)
   else                                         self.CarregarDados();
   
   self.EstadoTela := tetConsultar;
end;

constructor TfrmCadastroPadrao.CreateModoBusca(AOwner :TComponent; Especificacao :TEspecificacao);
begin
   self.FEspecificacaoDeBusca   := Especificacao;
   
   self.Create(AOwner);

   self.EstadoTela              := tetPesquisar;
end;

destructor TfrmCadastroPadrao.Destroy;
begin
  self.cds.Close;
  self.FEspecificacaoDeBusca := nil;
  
  inherited;
end;

procedure TfrmCadastroPadrao.ExecutarAntesAlterar;
begin
   self.pnlBotoes.Visible          := true;
   self.btnIncluir.Enabled         := false;
   self.btnAlterar.Enabled         := false;
   self.btnCancelar.Enabled        := true;
   self.btnSalvar.Enabled          := true;
   self.lblAjudaSelecionar.Visible := false;
   self.pgGeral.ActivePage         := tsDados;
end;

procedure TfrmCadastroPadrao.ExecutarAntesConsultar;
begin
   self.pnlBotoes.Visible          := true;
   self.pgGeral.ActivePage         := tsConsulta;
   self.btnIncluir.Enabled         := true;
   self.btnAlterar.Enabled         := true;
   self.btnCancelar.Enabled        := false;
   self.btnSalvar.Enabled          := false;
   self.lblAjudaSelecionar.Visible := false;
end;

procedure TfrmCadastroPadrao.ExecutarAntesIncluir;
begin
   self.pnlBotoes.Visible           := true;
   self.lblAjudaSelecionar.Visible  := false;
   self.btnIncluir.Enabled          := false;
   self.btnAlterar.Enabled          := false;
   self.btnCancelar.Enabled         := true;
   self.btnSalvar.Enabled           := true;
   self.pgGeral.ActivePage          := tsDados;
end;

procedure TfrmCadastroPadrao.ExecutarAntesPesquisar;
begin
   self.pnlBotoes.Visible           := false;
   self.pgGeral.ActivePage          := tsConsulta;
   self.lblAjudaSelecionar.Visible  := true;
   self.tsDados.TabVisible          := false;
end;

procedure TfrmCadastroPadrao.ExecutarAntesSalvar;
var
  Registro :TObject;
begin
   if (not inherited Confirma('Confirma operação?')) or (not VerificaDados) then
    abort;

   try
     Registro := self.GravarDados;
   except
     on E: Exception do begin
       Avisar(E.Message);
       Abort;
     end;
   end;

   if (self.FEstadoTela = tetIncluir) then self.IncluirRegistroNoCDS(Registro)
   else                                    self.AlterarRegistroNoCDS(Registro);

   FreeAndNil(Registro);
end;

procedure TfrmCadastroPadrao.ExecutarAntesVisualizar;
begin
   self.pnlBotoes.Visible          := true;
   self.btnIncluir.Enabled         := false;
   self.btnAlterar.Enabled         := false;
   self.btnCancelar.Enabled        := false;
   self.btnSalvar.Enabled          := false;
   self.lblAjudaSelecionar.Visible := false;
   self.pgGeral.ActivePage         := tsDados;
end;

procedure TfrmCadastroPadrao.ExecutarDepoisAlterar;
begin
   self.OnKeyDown        := self.AtalhosNormais;
   self.pnlDados.Enabled := true;
   self.MostrarDados;
end;

procedure TfrmCadastroPadrao.ExecutarDepoisConsultar;
begin
   self.OnKeyDown        := self.AtalhosNormais;

   if self.Visible and self.gridConsulta.Visible and self.gridConsulta.Enabled then
     self.gridConsulta.SetFocus;
end;

procedure TfrmCadastroPadrao.ExecutarDepoisIncluir;
begin
   self.OnKeyDown        := self.AtalhosNormais;
   self.pnlDados.Enabled := true;
   self.LimparDados;
end;

procedure TfrmCadastroPadrao.ExecutarDepoisPesquisar;
begin
   self.OnKeyDown        := self.AtalhosPesquisar;

   if self.Visible and self.gridConsulta.Visible and self.gridConsulta.Enabled then
    self.gridConsulta.SetFocus;
end;

procedure TfrmCadastroPadrao.ExecutarDepoisSalvar;
begin
   self.OnKeyDown        := self.AtalhosNormais;

   self.pnlBotoes.Visible          := true;
   self.lblAjudaSelecionar.Visible := false;
   self.btnIncluir.Enabled         := true;
   self.btnAlterar.Enabled         := true;
   self.btnCancelar.Enabled        := false;
   self.btnSalvar.Enabled          := false;
   self.pgGeral.ActivePage         := tsConsulta;

  inherited avisar('Operação realizada com sucesso!');
end;

procedure TfrmCadastroPadrao.ExecutarDepoisVisualizar;
begin
   self.OnKeyDown        := self.AtalhosNormais;
   self.pnlDados.Enabled := false;
   self.MostrarDados;
end;

procedure TfrmCadastroPadrao.LimparDados;
begin
   { Método a ser implementado na sub-classe }
//   raise TExcecaoMetodoNaoImplementado.Create('TfrmCadastroPadrao', 'LimparDados');
end;

procedure TfrmCadastroPadrao.MostrarDados;
begin
   self.LimparDados;
end;

procedure TfrmCadastroPadrao.SetEstadoTela(const Value: TTipoEstadoTela);
begin
// type TTipoEstadoTela = (tetConsultar, tetVisualizar, tetIncluir, tetAlterar, tetSalvar, tetPesquisar);

  try
    if      (Value = tetConsultar)  then self.ExecutarAntesConsultar
    else if (Value = tetVisualizar) then self.ExecutarAntesVisualizar
    else if (Value = tetIncluir)    then self.ExecutarAntesIncluir
    else if (Value = tetAlterar)    then self.ExecutarAntesAlterar
    else if (Value = tetSalvar)     then self.ExecutarAntesSalvar
    else if (Value = tetPesquisar)  then self.ExecutarAntesPesquisar;

    FEstadoTela := Value;

    if      (Value = tetConsultar)  then self.ExecutarDepoisConsultar
    else if (Value = tetVisualizar) then self.ExecutarDepoisVisualizar
    else if (Value = tetIncluir)    then self.ExecutarDepoisIncluir
    else if (Value = tetAlterar)    then self.ExecutarDepoisAlterar
    else if (Value = tetSalvar)     then self.ExecutarDepoisSalvar
    else if (Value = tetPesquisar)  then self.ExecutarDepoisPesquisar;
  except
    on E: Exception do begin
      if not (E is EAbort) then
        inherited Avisar(E.Message);

      Fdm.LogErros.AdicionaErro('uCadastroPadrao', E.ClassName, E.Message);
    end;
  end;
end;

procedure TfrmCadastroPadrao.pgGeralChange(Sender: TObject);
var
  pg :TPageControl;
begin
   pg := (Sender as TPageControl);

   if       (pg.ActivePage = tsConsulta) then self.EstadoTela := tetConsultar
   else if  (pg.ActivePage = tsDados) and not(self.EstadoTela in [tetIncluir, tetAlterar]) then self.EstadoTela := tetVisualizar; 
end;

function TfrmCadastroPadrao.VerificaDados: Boolean;
begin

end;

function TfrmCadastroPadrao.GravarDados :TObject;
begin
   result := nil;
end;

procedure TfrmCadastroPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  { teste }
end;

procedure TfrmCadastroPadrao.AlterarRegistroNoCDS(Registro: TObject);
begin

end;

procedure TfrmCadastroPadrao.IncluirRegistroNoCDS(Registro: TObject);
begin
   { Método a ser implementado na sub-classe }
//   raise TExcecaoMetodoNaoImplementado.Create('TfrmCadastroPadrao', 'IncluirRegistroNoCDS(Registro: TObject)');
end;

procedure TfrmCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  self.EstadoTela := tetIncluir;
end;

procedure TfrmCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if (cds.active)and not(cds.isEmpty) then
    self.EstadoTela := tetAlterar;
end;

procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  inherited;

  self.EstadoTela := tetConsultar;
end;

procedure TfrmCadastroPadrao.btnSalvarClick(Sender: TObject);
begin
  inherited;

  self.EstadoTela := tetSalvar;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  inherited;

  self.cds.First;
  self.gridConsulta.SetFocus;
end;

procedure TfrmCadastroPadrao.CarregarDados;
begin
   { Método a ser implementado na sub-classe }
//   raise TExcecaoMetodoNaoImplementado.Create('TfrmCadastroPadrao', 'CarregarDados');
end;

constructor TfrmCadastroPadrao.CreateModoBusca(AOwner: TComponent);
begin
   self.CreateModoBusca(AOwner, nil);
end;

end.
