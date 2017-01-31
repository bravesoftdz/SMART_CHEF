unit uLancaSangriaReforco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmLancaSangriaReforco = class(TfrmPadrao)
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmbTipo: TComboBox;
    edtValor: TCurrencyEdit;
    lblCodBar: TLabel;
    Label1: TLabel;
    mmoDescricao: TMemo;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure lancaMovimento;
    procedure limparCampos;

    function  verificaObrigatorios :Boolean;
  public
    { Public declarations }
  end;

var
  frmLancaSangriaReforco: TfrmLancaSangriaReforco;

implementation

uses SangriaReforco, Repositorio, FabricaRepositorio;

{$R *.dfm}

procedure TfrmLancaSangriaReforco.BitBtn1Click(Sender: TObject);
begin
  if verificaObrigatorios then
    LancaMovimento;
end;

procedure TfrmLancaSangriaReforco.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmLancaSangriaReforco.lancaMovimento;
var repositorio :TRepositorio;
    sangriaReforco :TSangriaReforco;
begin
 try
 try
   repositorio    := TFabricaRepositorio.GetRepositorio(TSangriaReforco.ClassName);
   sangriaReforco := TSangriaReforco.Create;

   sangriaReforco.codigo_usuario := fdm.UsuarioLogado.Codigo;
   sangriaReforco.tipo           := IfThen(cmbTipo.ItemIndex = 1, 'S', 'R');
   sangriaReforco.valor          := edtValor.Value;
   sangriaReforco.descricao      := mmoDescricao.Text;
   repositorio.Salvar(sangriaReforco);

   self.limparCampos;
   avisar('Lançamento realizado com sucesso',3);
 Except
   on e :Exception do
     avisar('Erro o lançar movimento'+#13#10+'"'+e.Message+'"');
 end;
 finally
   FreeAndNil(repositorio);
   FreeAndNil(sangriaReforco);
 end;
end;

procedure TfrmLancaSangriaReforco.limparCampos;
begin
  cmbTipo.ItemIndex := 0;
  edtValor.Clear;
  mmoDescricao.Clear;
end;

function TfrmLancaSangriaReforco.verificaObrigatorios: Boolean;
begin
  result := false;

  if cmbTipo.ItemIndex = 0 then
  begin
    avisar('Favor, selecione o tipo do movimento',2);
    cmbTipo.SetFocus;
  end
  else if edtValor.Value <= 0 then
  begin
    avisar('Favor, informe o valor do movimento',2);
    edtValor.SetFocus;
  end
  else if length(mmoDescricao.Text) < 5 then
  begin
    avisar('Favor, Informe uma descrição para o movimento',2);
    mmoDescricao.SetFocus;
  end
  else
    result := true;
end;

end.
