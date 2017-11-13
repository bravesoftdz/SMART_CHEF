unit uCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, uPadrao, StdCtrls, Mask, RXToolEdit, RXCurrEdit, ExtCtrls, ComCtrls, AcbrDevice,
  ImgList, pngimage, Buttons, Contnrs, Caixa, AcbrEcf, ConfiguracaoECF, StringUtilitario,
  generics.collections;

type
  TfrmCaixa = class(TfrmPadrao)
    edtValorAbertura: TCurrencyEdit;
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
    btnAlterarCouvert: TBitBtn;
    btnAlterarTxServ: TBitBtn;
    btnAlterarEntrega: TBitBtn;
    edtVlrDinheiro: TCurrencyEdit;
    Label12: TLabel;
    edtVlrCartDebito: TCurrencyEdit;
    Label13: TLabel;
    edtVlrCheque: TCurrencyEdit;
    Label14: TLabel;
    Label15: TLabel;
    edtVlrCartCredito: TCurrencyEdit;
    procedure btnAbreCaixaClick(Sender: TObject);
    procedure btnFechaCaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAlterarCouvertClick(Sender: TObject);
    procedure btnAlterarTxServClick(Sender: TObject);
    procedure btnAlterarEntregaClick(Sender: TObject);
    procedure edtCouvertExit(Sender: TObject);
    procedure edtPercTxServExit(Sender: TObject);
    procedure edtTaxaEntregaExit(Sender: TObject);
    procedure edtTaxaEntregaChange(Sender: TObject);

  private

    procedure Carrega_dados_caixa;
    function AbreCaixa :Boolean;
    procedure FechaCaixa;
    procedure ConfiguraTela(estadoTela:String);

    procedure alterarTaxas;
  end;

var
  frmCaixa: TfrmCaixa;

implementation

uses Repositorio, FabricaRepositorio, Funcoes, EspecificacaoMovimentosPorCodigoCaixa, Movimento,
  Pedido, uModulo, EspecificacaoCaixaPorData, Empresa, Math, SangriaReforco,
  ConfiguracoesSistema;

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
      Caixa.valor_abertura := edtValorAbertura.Value;

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
    Caixa.valor_fechamento := Caixa.TotalEmCaixa;

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
    if edtValorAbertura.Value <= 0 then begin
      avisar('Favor informar o valor com que o caixa será iniciado.');
      edtValorAbertura.SetFocus;
    end
    else begin

      if dm.Configuracoes.possuiDelivery then
        taxa_entrega := TStringUtilitario.CaracterAEsquerda(' ','% Taxa de serviço '+FormatFloat('%  ,0.00; -,0.00;',edtTaxaEntrega.Value), 65);

      if not confirma('ATENÇÃO! As opções de couvert artístico e taxa de serviço não poderão ser alteradas após a abertura do caixa.'+#13#10+
                      'Confirma abertura do caixa com os seguintes valores:'+#13#10
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','Valor abertura '+FormatFloat('R$  ,0.00; -,0.00;',edtValorAbertura.Value),60)
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','Couvert artístico '+FormatFloat('R$  ,0.00; -,0.00;',edtCouvert.Value),65)
                      +#13#10+ TStringUtilitario.CaracterAEsquerda(' ','% Taxa de serviço '+FormatFloat('%  ,0.00; -,0.00;',edtPercTxServ.Value), 65)
                      +IfThen(dm.Configuracoes.possuiDelivery, #13#10+taxa_entrega, '')) then
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

  edtValorAbertura.Clear;
  ConfiguraTela('FECHADO');

  try
    repositorio := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);
    Caixa       := TCaixa( repositorio.Get( StrToIntDef( Maior_Valor_Cadastrado('Caixa', 'Codigo') ,0) ) );

    if not assigned(Caixa) then
      exit;

    if (Caixa.data_fechamento > 0) then
      edtValorAbertura.Value := Caixa.valor_fechamento
    else
      edtValorAbertura.Value := Caixa.valor_abertura;

    repositorioEmpresa   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa              := TEmpresa( repositorioEmpresa.Get(1) );

    edtCouvert.Value     := Empresa.Valor_couvert;
    edtPercTxServ.Value  := Empresa.Taxa_servico;
    edtTaxaEntrega.Value := Empresa.taxa_entrega;

    btnAlterarCouvert.Enabled := not (Caixa.data_fechamento > 0);
    btnAlterarTxServ.Enabled  := not (Caixa.data_fechamento > 0);
    btnAlterarEntrega.Enabled := not (Caixa.data_fechamento > 0);

    if (Caixa.data_fechamento > 0) then
      Exit;


    Caixa.atualizaValores;
    edtCodigo.AsInteger       := Caixa.codigo;
    lblAbertura.Caption       := FormatDateTime('dd/mm/yyyy  -  hh:mm:ss', Caixa.data_abertura);
    edtValorAbertura.Value    := Caixa.valor_abertura;
    lblValorAbertura.Caption  := FormatFloat('R$  ,0.00; -,0.00;', Caixa.valor_abertura);

    edtVlrDinheiro.Value      := Caixa.Total_dinheiro - Caixa.Total_sangria_dinheiro + Caixa.Total_reforco_dinheiro;
    edtVlrCheque.Value        := Caixa.Total_cheque - Caixa.Total_sangria_cheque  + Caixa.Total_reforco_cheque;
    edtVlrCartDebito.Value    := Caixa.Total_cartaoD;
    edtVlrCartCredito.Value   := Caixa.Total_cartaoC;

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
  label11.visible           := dm.Configuracoes.possuiDelivery;
  edtTaxaEntrega.Visible    := dm.Configuracoes.possuiDelivery;
  btnAlterarEntrega.Visible := dm.Configuracoes.possuiDelivery;

  edtDataCorrente.Text := FormatDateTime('dd/mm/yyyy', now);
  edtHoraCorrente.Text := FormatDateTime('hh:mm:ss', now);
  Carrega_dados_caixa;

  if not pnlAberto.Visible then
    edtValorAbertura.SetFocus;
end;

procedure TfrmCaixa.BitBtn1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmCaixa.ConfiguraTela(estadoTela: String);
begin
  pnlAberto.Visible      := (estadoTela = 'ABERTO');
  edtValorAbertura.ReadOnly      := (estadoTela = 'ABERTO');
  lblStatus.Caption      := estadoTela;
  edtValorAbertura.ReadOnly      := (estadoTela = 'ABERTO');
  pnlAberto.Visible      := (estadoTela = 'ABERTO');
  btnFechaCaixa.Enabled  := (estadoTela = 'ABERTO');
  btnAbreCaixa.Enabled   := not (estadoTela = 'ABERTO');
  imgCxAberto.Visible    := (estadoTela = 'ABERTO');
  imgCxFechado.Visible   := not (estadoTela = 'ABERTO');
  edtCouvert.Enabled     := not (estadoTela = 'ABERTO');
  edtTaxaEntrega.Enabled := not (estadoTela = 'ABERTO');


  if (estadoTela = 'ABERTO') then
    lblStatus.Font.Color      := clGreen
  else
    lblStatus.Font.Color := $000000BB;

end;

procedure TfrmCaixa.edtCouvertExit(Sender: TObject);
begin
  edtCouvert.Enabled := false;
end;

procedure TfrmCaixa.edtPercTxServExit(Sender: TObject);
begin
  edtPercTxServ.Enabled := false;
end;

procedure TfrmCaixa.edtTaxaEntregaChange(Sender: TObject);
begin
  alterarTaxas;
end;

procedure TfrmCaixa.edtTaxaEntregaExit(Sender: TObject);
begin
  edtTaxaEntrega.Enabled := false;
end;

procedure TfrmCaixa.btnAlterarCouvertClick(Sender: TObject);
begin
  edtCouvert.Enabled := true;
  edtCouvert.SetFocus;
  edtCouvert.SelectAll;

//  alterarTaxas('COUVERT');
end;

procedure TfrmCaixa.alterarTaxas;
var
  repositorioEmpresa :TRepositorio;
  Empresa :TEmpresa;
begin

  try
    repositorioEmpresa   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa              := TEmpresa( repositorioEmpresa.Get(1) );

    Empresa.Valor_couvert := edtCouvert.Value;
    Empresa.Taxa_servico  := edtPercTxServ.Value;
    Empresa.taxa_entrega  := edtTaxaEntrega.Value;

    repositorioEmpresa.Salvar(Empresa);

  finally
    FreeAndNil(Empresa);
    FreeAndNil(repositorioEmpresa);
  end;
end;

procedure TfrmCaixa.btnAlterarTxServClick(Sender: TObject);
begin
  edtPercTxServ.Enabled := true;
  edtPercTxServ.SetFocus;
  edtPercTxServ.SelectAll;
//  alterarTaxas('SERVICO');
end;

procedure TfrmCaixa.btnAlterarEntregaClick(Sender: TObject);
begin
  edtTaxaEntrega.Enabled := true;
  edtTaxaEntrega.SetFocus;
  edtTaxaEntrega.SelectAll;
  //alterarTaxas('ENTREGA');
end;

end.


