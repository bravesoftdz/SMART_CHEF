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
  self.cdsPOSSUI_BOLICHE.AsString      := IfThen(ConfiguracoesSistema.possui_boliche, 'SIM', 'NÃO');
  self.cdsPOSSUI_DISPENSADORA.AsString := IfThen(ConfiguracoesSistema.possui_dispensadora, 'SIM', 'NÃO');
  self.cdsDUAS_VIAS_PEDIDO.AsString    := IfThen(ConfiguracoesSistema.duas_vias_pedido, 'SIM', 'NÃO');
  self.cdsUTILIZA_COMANDAS.AsString    := IfThen(ConfiguracoesSistema.Utiliza_comandas, 'SIM', 'NÃO');
  self.cdsPOSSUI_DELIVERY.AsString     := IfThen(ConfiguracoesSistema.possui_delivery, 'SIM', 'NÃO');
  self.cdsDESCONTO_PEDIDO.AsString     := IfThen(ConfiguracoesSistema.desconto_pedido, 'SIM', 'NÃO');

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

     Configuracoes.possui_boliche          := self.cbxUsaBoliche.ItemIndex = 0;
     Configuracoes.possui_dispensadora     := self.cbxUsaDispensadora.ItemIndex = 0;
     Configuracoes.duas_vias_pedido        := self.cbxViasImpressao.ItemIndex = 0;
     Configuracoes.preco_produto_alteravel := self.cbxEditaPrecoPedido.ItemIndex = 0;
     Configuracoes.Utiliza_comandas        := self.cbxUtilizaComandas.ItemIndex = 0;
     Configuracoes.possui_delivery         := self.cbxPossuiDelivery.ItemIndex = 0;
     Configuracoes.imp_dep_espacada        := self.cbxImpDepEspacada.ItemIndex = 0;
     Configuracoes.desconto_pedido         := self.cbxDescontoPedido.ItemIndex = 0;

     RepositorioConfiguracoes.Salvar(Configuracoes);

     if self.EstadoTela = tetIncluir then
       Configuracoes.codigo := 0;

     if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       RepositorioConfiguracoes.Salvar_2(Configuracoes);

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
  self.cdsPOSSUI_BOLICHE.AsString      := IfThen(Configuracoes.possui_boliche, 'SIM', 'NÃO');
  self.cdsPOSSUI_DISPENSADORA.AsString := IfThen(Configuracoes.possui_dispensadora, 'SIM', 'NÃO');
  self.cdsDUAS_VIAS_PEDIDO.AsString    := IfThen(Configuracoes.duas_vias_pedido, 'SIM', 'NÃO');
  self.cdsUTILIZA_COMANDAS.AsString    := IfThen(Configuracoes.Utiliza_comandas, 'SIM', 'NÃO');
  self.cdsPOSSUI_DELIVERY.AsString     := IfThen(Configuracoes.possui_delivery, 'SIM', 'NÃO');
  self.cdsDESCONTO_PEDIDO.AsString     := IfThen(Configuracoes.desconto_pedido, 'SIM', 'NÃO');
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

    self.edtCodigo.Text                := IntToStr(Configuracoes.codigo);
    self.cbxUsaBoliche.ItemIndex       := IfThen(Configuracoes.possui_boliche,0,1);
    self.cbxUsaDispensadora.ItemIndex  := IfThen(Configuracoes.possui_dispensadora,0,1);
    self.cbxViasImpressao.ItemIndex    := IfThen(Configuracoes.duas_vias_pedido,0,1);
    self.cbxEditaPrecoPedido.ItemIndex := IfThen(Configuracoes.preco_produto_alteravel,0,1);
    self.cbxUtilizaComandas.ItemIndex  := IfThen(Configuracoes.Utiliza_comandas,0,1);
    self.cbxPossuiDelivery.ItemIndex   := IfThen(Configuracoes.possui_delivery,0,1);
    self.cbxImpDepEspacada.ItemIndex   := IfThen(Configuracoes.imp_dep_espacada,0,1);
    self.cbxDescontoPedido.ItemIndex   := IfThen(Configuracoes.desconto_pedido,0,1);

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
