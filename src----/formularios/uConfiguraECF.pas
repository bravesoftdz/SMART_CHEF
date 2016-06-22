unit uConfiguraECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids,
  DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, ContNrs, Spin;

type
  TfrmConfiguraECF = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsMODELO: TStringField;
    edtCodigo: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label22: TLabel;
    Label2: TLabel;
    cbxModelo: TComboBox;
    cbxPorta: TComboBox;
    spnTimeOut: TSpinEdit;
    spnIntervaloAposComando: TSpinEdit;
    spnLinhasBuffer: TSpinEdit;
    SpnTamanhoFonte: TSpinEdit;
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
  frmConfiguraECF: TfrmConfiguraECF;

implementation

uses ConfiguracaoECF, repositorio, fabricarepositorio, Math, uPadrao;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmConfiguraECF.AlterarRegistroNoCDS(Registro: TObject);
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
  inherited;

  ConfiguracaoECF := (Registro as TConfiguracaoECF);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger   := ConfiguracaoECF.codigo;
  self.cdsMODELO.AsString    := ConfiguracaoECF.modelo;
  self.cds.Post;
end;

procedure TfrmConfiguraECF.CarregarDados;
var
  Configuracoes :TObjectList;
  Repositorio   :TRepositorio;
  nX            :Integer;
begin
  inherited;

  Repositorio := nil;
  Configuracoes    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TConfiguracaoECF.ClassName);
    Configuracoes    := Repositorio.GetAll;

    if Assigned(Configuracoes) and (Configuracoes.Count > 0) then begin

       for nX := 0 to (Configuracoes.Count-1) do
         self.IncluirRegistroNoCDS(Configuracoes.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Configuracoes);
  end;
end;

procedure TfrmConfiguraECF.ExecutarDepoisAlterar;
begin
  inherited;
  cbxModelo.SetFocus;
end;

procedure TfrmConfiguraECF.ExecutarDepoisIncluir;
begin
  inherited;
  cbxModelo.SetFocus;
end;

function TfrmConfiguraECF.GravarDados: TObject;
var
  ConfiguracaoECF :TConfiguracaoECF;
  Repositorio     :TRepositorio;
begin
   ConfiguracaoECF := nil;
   Repositorio     := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TConfiguracaoECF.ClassName);
     ConfiguracaoECF := TConfiguracaoECF(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(ConfiguracaoECF) then
      ConfiguracaoECF := TConfiguracaoECF.Create;

     ConfiguracaoECF.modelo        := self.cbxModelo.Items[self.cbxModelo.itemIndex];
     ConfiguracaoECF.porta         := self.cbxPorta.Items[self.cbxPorta.itemIndex];
     ConfiguracaoECF.timeout       := spnTimeOut.Value;
     ConfiguracaoECF.intervalo     := spnIntervaloAposComando.Value;
     ConfiguracaoECF.linhas_buffer := spnLinhasBuffer.Value;
     ConfiguracaoECF.tamanho_fonte := SpnTamanhoFonte.Value;

     Repositorio.Salvar(ConfiguracaoECF);
     
     result := ConfiguracaoECF;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmConfiguraECF.IncluirRegistroNoCDS(Registro: TObject);
var
  ConfiguracaoECF :TConfiguracaoECF;
begin
  inherited;

  ConfiguracaoECF := (Registro as TConfiguracaoECF);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := ConfiguracaoECF.codigo;
  self.cdsMODELO.AsString    := ConfiguracaoECF.modelo;
  self.cds.Post;
end;

procedure TfrmConfiguraECF.LimparDados;
begin
  inherited;
  cbxModelo.ItemIndex     := -1;
  cbxPorta.ItemIndex      := -1;
  spnTimeOut.Value        := 10;
  spnIntervaloAposComando.Value := 100;
  spnLinhasBuffer.Value   := 0;
  SpnTamanhoFonte.Value   := 10;
end;

procedure TfrmConfiguraECF.MostrarDados;
var
  ConfiguracaoECF :TConfiguracaoECF;
  Repositorio     :TRepositorio;
begin
  inherited;

  ConfiguracaoECF      := nil;
  Repositorio  := nil;

  try
    Repositorio      := TFabricaRepositorio.GetRepositorio(TConfiguracaoECF.ClassName);
    ConfiguracaoECF  := TConfiguracaoECF(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(ConfiguracaoECF) then exit;

    edtCodigo.Text                := IntToStr(ConfiguracaoECF.codigo);
    cbxModelo.ItemIndex           := cbxModelo.Items.IndexOf( ConfiguracaoECF.modelo );
    cbxPorta.ItemIndex            := cbxPorta.Items.IndexOf( ConfiguracaoECF.Porta );
    spnTimeOut.Value              := ConfiguracaoECF.timeout;
    spnIntervaloAposComando.Value := ConfiguracaoECF.Intervalo;
    spnLinhasBuffer.Value         := ConfiguracaoECF.linhas_buffer;
    SpnTamanhoFonte.Value         := ConfiguracaoECF.tamanho_fonte;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(ConfiguracaoECF);
  end;
end;

function TfrmConfiguraECF.VerificaDados: Boolean;
begin
  result := false;

  if cbxModelo.ItemIndex < 0 then begin
    avisar('O modelo da impressora deve ser selecionado');
    cbxModelo.SetFocus;
  end
  else if cbxPorta.ItemIndex < 0 then begin
    avisar('A porta da impressora deve ser selecionada');
    cbxPorta.SetFocus;
  end
  else
    result := true;
end;

end.
 