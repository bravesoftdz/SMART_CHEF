unit uConfiguracoesSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, ContNrs;

type
  TfrmconfiguracoesSistema = class(TfrmCadastroPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cbxUsaBoliche: TComboBox;
    cbxUsaDispensadora: TComboBox;
    cbxViasImpressao: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cdsCODIGO: TIntegerField;
    cdsPOSSUI_BOLICHE: TStringField;
    cdsPOSSUI_DISPENSADORA: TStringField;
    cdsDUAS_VIAS_PEDIDO: TStringField;
    edtCodigo: TEdit;
    Label4: TLabel;
    cbxEditaPrecoPedido: TComboBox;
    cbxUtilizaComandas: TComboBox;
    Label5: TLabel;
    cdsUTILIZA_COMANDAS: TStringField;
    Label6: TLabel;
    cbxPossuiDelivery: TComboBox;
    cdsPOSSUI_DELIVERY: TStringField;
    Label7: TLabel;
    cbxImpDepEspacada: TComboBox;
    Label8: TLabel;
    cbxDescontoPedido: TComboBox;
    cdsDESCONTO_PEDIDO: TStringField;
    Label9: TLabel;
    cbxImpressoesParciais: TComboBox;
    Label10: TLabel;
    cbxPerguntaImprimir: TComboBox;
    Label11: TLabel;
    cbxControlaValidade: TComboBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;

  private
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;
  end;

var
  frmconfiguracoesSistema: TfrmconfiguracoesSistema;

implementation

uses ConfiguracoesSistema, repositorio, fabricarepositorio, StrUtils,
  uModulo, Math;

{$R *.dfm}

procedure TfrmconfiguracoesSistema.AlterarRegistroNoCDS(Registro: TObject);
var
  ConfiguracoesSistema :TConfiguracoesSistema;
begin
  inherited;

  ConfiguracoesSistema := (Registro as TConfiguracoesSistema);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger             := ConfiguracoesSistema.codigo;
  self.cdsPOSSUI_BOLICHE.AsString      := IfThen(ConfiguracoesSistema.possuiBoliche, 'SIM', 'NÃO');
  self.cdsPOSSUI_DISPENSADORA.AsString := IfThen(ConfiguracoesSistema.possuiDispensadora, 'SIM', 'NÃO');
  self.cdsDUAS_VIAS_PEDIDO.AsString    := IfThen(ConfiguracoesSistema.duasViasPedido, 'SIM', 'NÃO');
  self.cdsUTILIZA_COMANDAS.AsString    := IfThen(ConfiguracoesSistema.utilizaComandas, 'SIM', 'NÃO');
  self.cdsPOSSUI_DELIVERY.AsString     := IfThen(ConfiguracoesSistema.possuiDelivery, 'SIM', 'NÃO');
  self.cdsDESCONTO_PEDIDO.AsString     := IfThen(ConfiguracoesSistema.descontoPedido, 'SIM', 'NÃO');
  self.cds.Post;
end;

procedure TfrmconfiguracoesSistema.CarregarDados;
var
  Configuracoes :TObjectList;
  Repositorio   :TRepositorio;
  nX            :Integer;
begin
  inherited;

  Repositorio   := nil;
  Configuracoes := nil;

  try
    Repositorio   := TFabricaRepositorio.GetRepositorio(TConfiguracoesSistema.ClassName);
    Configuracoes := Repositorio.GetAll;

    if Assigned(Configuracoes) and (Configuracoes.Count > 0) then begin

       for nX := 0 to (Configuracoes.Count-1) do
         self.IncluirRegistroNoCDS(Configuracoes.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Configuracoes);
  end;
end;

procedure TfrmconfiguracoesSistema.ExecutarDepoisAlterar;
begin
  inherited;
  PageControl1.ActivePageIndex := 0;
  cbxUsaBoliche.SetFocus;
end;

procedure TfrmconfiguracoesSistema.ExecutarDepoisIncluir;
begin
  inherited;
  PageControl1.ActivePageIndex := 0;  
  cbxUsaBoliche.SetFocus;
end;

procedure TfrmconfiguracoesSistema.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F3) and not(btnIncluir.Visible) then
    Key := 0;

  inherited;
end;

procedure TfrmconfiguracoesSistema.FormShow(Sender: TObject);
begin
  inherited;
  if not cds.IsEmpty then
    btnIncluir.Visible := false;
end;

function TfrmconfiguracoesSistema.GravarDados: TObject;
var
  Configuracoes             :TConfiguracoesSistema;
  RepositorioConfiguracoes  :TRepositorio;
begin
   Configuracoes             := nil;
   RepositorioConfiguracoes  := nil;

   try
     RepositorioConfiguracoes  := TFabricaRepositorio.GetRepositorio(TConfiguracoesSistema.ClassName);
     Configuracoes             := TConfiguracoesSistema(RepositorioConfiguracoes.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Configuracoes) then
      Configuracoes := TConfiguracoesSistema.Create;

     Configuracoes.possuiBoliche          := self.cbxUsaBoliche.ItemIndex = 0;
     Configuracoes.possuiDispensadora     := self.cbxUsaDispensadora.ItemIndex = 0;
     Configuracoes.duasViasPedido         := self.cbxViasImpressao.ItemIndex = 0;
     Configuracoes.precoProdutoAlteravel  := self.cbxEditaPrecoPedido.ItemIndex = 0;
     Configuracoes.utilizaComandas        := self.cbxUtilizaComandas.ItemIndex = 0;
     Configuracoes.possuiDelivery         := self.cbxPossuiDelivery.ItemIndex = 0;
     Configuracoes.impDepEspacada         := self.cbxImpDepEspacada.ItemIndex = 0;
     Configuracoes.descontoPedido         := self.cbxDescontoPedido.ItemIndex = 0;
     Configuracoes.impressoesParciais     := self.cbxImpressoesParciais.ItemIndex = 0;
     Configuracoes.perguntaImprimirPedido := self.cbxPerguntaImprimir.ItemIndex = 0;
     Configuracoes.controlaValidade       := self.cbxControlaValidade.ItemIndex = 0;

     RepositorioConfiguracoes.Salvar(Configuracoes);

     if self.EstadoTela = tetIncluir then
       Configuracoes.codigo := 0;

  //   if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
  //     RepositorioConfiguracoes.Salvar_2(Configuracoes);

     result := Configuracoes;

     dm.Configuracoes.Free;
     dm.Configuracoes := nil;

   finally
     FreeAndNil(RepositorioConfiguracoes);
   end;
end;

procedure TfrmconfiguracoesSistema.IncluirRegistroNoCDS(Registro: TObject);
var
  Configuracoes :TConfiguracoesSistema;
begin
  inherited;

  Configuracoes := (Registro as TConfiguracoesSistema);

  self.cds.Append;
  self.cdsCODIGO.AsInteger             := Configuracoes.codigo;
  self.cdsPOSSUI_BOLICHE.AsString      := IfThen(Configuracoes.possuiBoliche, 'SIM', 'NÃO');
  self.cdsPOSSUI_DISPENSADORA.AsString := IfThen(Configuracoes.possuiDispensadora, 'SIM', 'NÃO');
  self.cdsDUAS_VIAS_PEDIDO.AsString    := IfThen(Configuracoes.duasViasPedido, 'SIM', 'NÃO');
  self.cdsUTILIZA_COMANDAS.AsString    := IfThen(Configuracoes.utilizaComandas, 'SIM', 'NÃO');
  self.cdsPOSSUI_DELIVERY.AsString     := IfThen(Configuracoes.possuiDelivery, 'SIM', 'NÃO');
  self.cdsDESCONTO_PEDIDO.AsString     := IfThen(Configuracoes.descontoPedido, 'SIM', 'NÃO');
  self.cds.Post;
end;

procedure TfrmconfiguracoesSistema.LimparDados;
begin
  inherited;

end;

procedure TfrmconfiguracoesSistema.MostrarDados;
var
  Configuracoes              :TConfiguracoesSistema;
  RepositorioConfiguracoes   :TRepositorio;
begin
  inherited;

  Configuracoes                              := nil;
  RepositorioConfiguracoes                   := nil;

  try
    RepositorioConfiguracoes  := TFabricaRepositorio.GetRepositorio(TConfiguracoesSistema.ClassName);
    Configuracoes             := TConfiguracoesSistema(RepositorioConfiguracoes.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Configuracoes) then exit;

    self.edtCodigo.Text                  := IntToStr(Configuracoes.codigo);
    self.cbxUsaBoliche.ItemIndex         := IfThen(Configuracoes.possuiBoliche,0,1);
    self.cbxUsaDispensadora.ItemIndex    := IfThen(Configuracoes.possuiDispensadora,0,1);
    self.cbxViasImpressao.ItemIndex      := IfThen(Configuracoes.duasViasPedido,0,1);
    self.cbxEditaPrecoPedido.ItemIndex   := IfThen(Configuracoes.precoProdutoAlteravel,0,1);
    self.cbxUtilizaComandas.ItemIndex    := IfThen(Configuracoes.utilizaComandas,0,1);
    self.cbxPossuiDelivery.ItemIndex     := IfThen(Configuracoes.possuiDelivery,0,1);
    self.cbxImpDepEspacada.ItemIndex     := IfThen(Configuracoes.impDepEspacada,0,1);
    self.cbxDescontoPedido.ItemIndex     := IfThen(Configuracoes.descontoPedido,0,1);
    self.cbxImpressoesParciais.ItemIndex := IfThen(Configuracoes.impressoesParciais,0,1);
    self.cbxPerguntaImprimir.ItemIndex   := IfThen(Configuracoes.perguntaImprimirPedido,0,1);
    self.cbxControlaValidade.ItemIndex   := IfThen(Configuracoes.controlaValidade,0,1);
  finally
    FreeAndNil(RepositorioConfiguracoes);
    FreeAndNil(Configuracoes);
  end;
end;

function TfrmconfiguracoesSistema.VerificaDados: Boolean;
begin
  result := true;
end;

end.
