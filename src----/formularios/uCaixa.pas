unit uCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, ToolEdit, CurrEdit, ExtCtrls, ComCtrls, AcbrDevice,
  ImgList, pngimage, Buttons, Contnrs, Caixa, AcbrEcf, ConfiguracaoECF, StringUtilitario;

type
  TfrmCaixa = class(TfrmPadrao)
    edtValor: TCurrencyEdit;
    Label1: TLabel;
    edtDataCorrente: TEdit;
    Label2: TLabel;
    edtHoraCorrente: TEdit;
    Label3: TLabel;
    Panel1: TPanel;
    btnAbreCaixa: TBitBtn;
    btnFechaCaixa: TBitBtn;
    Shape1: TShape;
    Label4: TLabel;
    lblStatus: TLabel;
    imgCxAberto: TImage;
    Shape2: TShape;
    imgCxFechado: TImage;
    edtCodigo: TCurrencyEdit;
    pnlAberto: TPanel;
    Label5: TLabel;
    lblAbertura: TLabel;
    Label6: TLabel;
    lblValorAbertura: TLabel;
    Shape3: TShape;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    Shape4: TShape;
    Label8: TLabel;
    Label9: TLabel;
    edtPercTxServ: TCurrencyEdit;
    Label10: TLabel;
    edtCouvert: TCurrencyEdit;
    edtTaxaEntrega: TCurrencyEdit;
    Label11: TLabel;
    procedure btnAbreCaixaClick(Sender: TObject);
    procedure btnFechaCaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    
  private

    procedure Carrega_dados_caixa;
    function AbreCaixa :Boolean;
    procedure FechaCaixa;
    function CalculaValorCaixa(Caixa :TCaixa) :Real;
    procedure ConfiguraTela(estadoTela:String);
    
  end;

var
  frmCaixa: TfrmCaixa;

implementation

uses Repositorio, FabricaRepositorio, Funcoes, EspecificacaoMovimentosPorCodigoCaixa, Movimento,
  Pedido, uModulo, EspecificacaoCaixaPorData, Empresa, Math,
  ConfiguracoesSistema, StrUtils;

{$R *.dfm}

function TfrmCaixa.AbreCaixa :Boolean;
var
  repositorio   :TRepositorio;
  repositorioEmpresa :TRepositorio;
  Especificacao :TEspecificacaoCaixaPorData;
  Caixa         :TCaixa;
  Empresa      :TEmpresa;
begin
  Empresa       := nil;
  repositorio   := nil;
  repositorioEmpresa := nil;
  Caixa         := nil;
  Especificacao := nil;
  result        := false;
  try
    Especificacao := TEspecificacaoCaixaPorData.Create(Date);
    repositorio   := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);

    Caixa               := TCaixa(repositorio.GetPorEspecificacao(Especificacao));

    repositorioEmpresa := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa            := TEmpresa(repositorioEmpresa.Get(1));

    if not assigned(Empresa) then begin
      avisar('Antes de abrir o caixa, os dados da empresa devem ser cadastrados.');
      Exit;
    end;

    if assigned(Caixa) then
      avisar('O movimento de hoje já foi finalizado.')
    else begin
      Caixa := TCaixa.Create;
      Caixa.data_abertura  := now;
      Caixa.valor_abertura := edtValor.Value;

      repositorio.Salvar( Caixa );

      Empresa.Couvert         := (edtCouvert.Value > 0);
      Empresa.Valor_couvert   := edtCouvert.Value;
      Empresa.Taxa_servico    := edtPercTxServ.Value;
      Empresa.taxa_entrega    := edtTaxaEntrega.Value;

      repositorioEmpresa.Salvar(Empresa);

      dm.Caixa_esta_aberto := true;

      result := true;
    end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Caixa);
    FreeAndNil(Empresa);
    FreeAndNil(repositorioEmpresa);    
  end;
end;

procedure TfrmCaixa.FechaCaixa;
var
  repositorio :TRepositorio;
  Caixa       :TCaixa;
begin
  repositorio := nil;
  Caixa       := nil;
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);

    Caixa               := TCaixa(repositorio.Get(edtCodigo.AsInteger));

    Caixa.data_fechamento  := now;
    Caixa.valor_fechamento := edtValor.Value;

    repositorio.Salvar( Caixa );

    dm.Caixa_esta_aberto := false;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Caixa);
  end;
end;

procedure TfrmCaixa.btnAbreCaixaClick(Sender: TObject);
var taxa_entrega :String;
begin
  try
    if edtValor.Value <= 0 then begin
      avisar('Favor informar o valor com que o caixa será iniciado.');
      edtValor.SetFocus;
    end
    else begin

      if dm.Configuracoes.possui_delivery then
        taxa_entrega := TStringUtilitario.CaracterAEsquerda(' ','% Taxa de serviço '+FormatFloat('%  ,0.00; -,0.00;',edtTaxaEntrega.Value), 65);

      if not confirma('ATENÇÃO! As opções de couvert artístico e taxa de serviço não poderão ser alteradas após a abertura do caixa.'+#13#10+
                      'Confirma abertura do caixa com os seguintes valores:'+#13#10
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','Valor do caixa '+FormatFloat('R$  ,0.00; -,0.00;',edtValor.Value),60)
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','Couvert artístico '+FormatFloat('R$  ,0.00; -,0.00;',edtCouvert.Value),65)
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','% Taxa de serviço '+FormatFloat('%  ,0.00; -,0.00;',edtPercTxServ.Value), 65)
                      +IfThen(dm.Configuracoes.possui_delivery, #13#10+taxa_entrega, '')) then
        Exit;

      if AbreCaixa then
        Carrega_dados_caixa;

    end;

  Except
    on E: Exception do
       Avisar(E.Message);
  end;
end;

procedure TfrmCaixa.btnFechaCaixaClick(Sender: TObject);
begin
  try
    if not confirma('Uma nova abertura de caixa só poderá ser feita no dia seguinte a última abertura.'+#13#10+
                    'Confirma fechamento de caixa?') then
      Exit;
                    
    FechaCaixa;

    Carrega_dados_caixa;

  Except
    on E: Exception do
       Avisar(E.Message);
  end;
end;

procedure TfrmCaixa.Carrega_dados_caixa;
var
  repositorio        :TRepositorio;
  Caixa              :TCaixa;
  Empresa            :TEmpresa;
  repositorioEmpresa :TRepositorio;
begin
  repositorio          := nil;
  Caixa                := nil;
  Empresa              := nil;
  repositorioEmpresa   := nil;

  edtValor.Clear;
  ConfiguraTela('FECHADO');

  try
    repositorio := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);
    Caixa       := TCaixa( repositorio.Get( StrToIntDef( Maior_Valor_Cadastrado('Caixa', 'Codigo') ,0) ) );

    if not assigned(Caixa) then
      exit;

    edtValor.Value            := Caixa.valor_abertura + CalculaValorCaixa(Caixa);

    if (Caixa.data_fechamento > 0) then
      Exit;

    edtCodigo.AsInteger       := Caixa.codigo;
    lblAbertura.Caption       := FormatDateTime('dd/mm/yyyy  -  hh:mm:ss', Caixa.data_abertura);
    edtValor.Value            := Caixa.valor_abertura + CalculaValorCaixa(Caixa);
    lblValorAbertura.Caption  := FormatFloat('R$  ,0.00; -,0.00;', Caixa.valor_abertura);

    repositorioEmpresa   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa              := TEmpresa( repositorioEmpresa.Get(1) );

    edtCouvert.Value     := Empresa.Valor_couvert;
    edtPercTxServ.Value  := Empresa.Taxa_servico;
    edtTaxaEntrega.Value := Empresa.taxa_entrega;

    ConfiguraTela('ABERTO');    

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Caixa);
    FreeAndNil(repositorioEmpresa);
    FreeAndNil(Empresa);
  end;
end;

procedure TfrmCaixa.FormShow(Sender: TObject);
begin
  label11.visible        := dm.Configuracoes.possui_delivery;
  edtTaxaEntrega.Visible := dm.Configuracoes.possui_delivery;

  edtDataCorrente.Text := FormatDateTime('dd/mm/yyyy', now);
  edtHoraCorrente.Text := FormatDateTime('hh:mm:ss', now);
  Carrega_dados_caixa;

  if not pnlAberto.Visible then
    edtValor.SetFocus;
end;

function TfrmCaixa.CalculaValorCaixa(Caixa :TCaixa): Real;
var
  Especificacao : TEspecificacaoMovimentosPorCodigoCaixa;
  Movimentos    : TObjectList;
  repositorio   : TRepositorio;
  i             : integer;
begin
  result        := 0;
  Especificacao := nil;
  repositorio   := nil;

  try
    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoCaixa.Create(Caixa);
    Movimentos    := repositorio.GetListaPorEspecificacao(Especificacao, 'DATA >= '''+DateTimeToStr(Caixa.data_abertura)+'''');

    if not assigned(Movimentos) then
      Exit;
      
    for i := 0 to Movimentos.Count - 1 do
      result := result + TMovimento(Movimentos.Items[i]).valor_pago;
      
  Finally
    FreeAndNil(Especificacao);
    FreeAndNil(repositorio);
    Movimentos.Free;    
  end;
end;

procedure TfrmCaixa.BitBtn1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmCaixa.ConfiguraTela(estadoTela: String);
begin
  pnlAberto.Visible      := (estadoTela = 'ABERTO');
  edtValor.ReadOnly      := (estadoTela = 'ABERTO');
  lblStatus.Caption      := estadoTela;
  edtValor.ReadOnly      := (estadoTela = 'ABERTO');
  pnlAberto.Visible      := (estadoTela = 'ABERTO');
  btnFechaCaixa.Enabled  := (estadoTela = 'ABERTO');
  btnAbreCaixa.Enabled   := not (estadoTela = 'ABERTO');
  imgCxAberto.Visible    := (estadoTela = 'ABERTO');
  imgCxFechado.Visible   := not (estadoTela = 'ABERTO');
  edtCouvert.Enabled     := not (estadoTela = 'ABERTO');
  edtPercTxServ.Enabled  := not (estadoTela = 'ABERTO');
  edtTaxaEntrega.Enabled := not (estadoTela = 'ABERTO');


  if (estadoTela = 'ABERTO') then
    lblStatus.Font.Color      := clGreen
  else
    lblStatus.Font.Color := $000000BB;

end;

end.
