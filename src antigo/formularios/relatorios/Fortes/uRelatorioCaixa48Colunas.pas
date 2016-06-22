unit uRelatorioCaixa48Colunas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TfrmRelatorioCaixa48Colunas = class(TForm)
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioCaixa48Colunas: TfrmRelatorioCaixa48Colunas;

implementation

uses Caixa, Repositorio, FabricaRepositorio, EspecificacaoCaixaPorData;

{$R *.dfm}

procedure TfrmRelatorioCaixa48Colunas.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date := Date;
end;

procedure TfrmRelatorioCaixa48Colunas.BitBtn1Click(Sender: TObject);
var Caixa         :TCaixa;
    repositorio   :TRepositorio;
    especificacao :TEspecificacaoCaixaPorData;
begin
  Caixa       := nil;
  repositorio := nil;
  try
    especificacao := TEspecificacaoCaixaPorData.Create(DateTimePicker1.Date);
    repositorio   := TFabricaRepositorio.GetRepositorio(TCaixa.ClassName);
    Caixa         := TCaixa( repositorio.GetPorEspecificacao( especificacao ) );

    Caixa.imprime_48Colunas;

  finally
    FreeAndNil(Caixa);
    FreeAndNil(repositorio);
  end;
end;

end.
