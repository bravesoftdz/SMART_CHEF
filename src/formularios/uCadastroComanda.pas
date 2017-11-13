unit uCadastroComanda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, StdCtrls, DB, DBClient, Grids, DBGrids,
  DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, Mask, RXToolEdit,
  RXCurrEdit, ContNrs, ImgList, System.ImageList;

type
  TfrmCadastroComanda = class(TfrmCadastroPadrao)
    cmbAtivo: TComboBox;
    Label1: TLabel;
    edtCodigo: TEdit;
    memMotivo: TMemo;
    Label2: TLabel;
    lblMotivo: TLabel;
    cdsCODIGO: TIntegerField;
    edtNumComanda: TCurrencyEdit;
    ImageList1: TImageList;
    cdsATIVA: TStringField;
    procedure cmbAtivoClick(Sender: TObject);
    procedure gridConsultaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridConsultaColEnter(Sender: TObject);
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
  frmCadastroComanda: TfrmCadastroComanda;

implementation

uses Comanda, repositorio, fabricarepositorio, StrUtils, uPadrao;

{$R *.dfm}

{ TfrmCadastroComanda }

procedure TfrmCadastroComanda.AlterarRegistroNoCDS(Registro: TObject);
var
  Comanda :TComanda;
begin
  inherited;

  Comanda := (Registro as TComanda);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger   := Comanda.codigo;
  self.cdsATIVA.AsString     := IfThen(Comanda.ativa, 'S', 'N');
  self.cds.Post;
end;

procedure TfrmCadastroComanda.CarregarDados;
var
  Comandas    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Comandas    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TComanda.ClassName);
    Comandas    := Repositorio.GetAll;

    if Assigned(Comandas) and (Comandas.Count > 0) then begin

       for nX := 0 to (Comandas.Count-1) do
         self.IncluirRegistroNoCDS(Comandas.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Comandas);
  end;
end;

procedure TfrmCadastroComanda.ExecutarDepoisAlterar;
begin
  inherited;
  edtNumComanda.SetFocus;
end;

procedure TfrmCadastroComanda.ExecutarDepoisIncluir;
begin
  inherited;
  edtNumComanda.SetFocus;
end;

function TfrmCadastroComanda.GravarDados: TObject;
var
  Comanda             :TComanda;
  RepositorioComanda  :TRepositorio;
begin
   Comanda             := nil;
   RepositorioComanda  := nil;

   try
     RepositorioComanda  := TFabricaRepositorio.GetRepositorio(TComanda.ClassName);
     Comanda             := TComanda(RepositorioComanda.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Comanda) then
      Comanda := TComanda.Create;

     Comanda.numero_comanda := self.edtNumComanda.AsInteger;
     Comanda.ativa          := ( UPPERCASE(self.cmbAtivo.Items[ self.cmbAtivo.ItemIndex ]) = 'SIM');

     Comanda.motivo         := IfThen(Comanda.ativa, '', memMotivo.Text);



     RepositorioComanda.Salvar(Comanda);

     if self.EstadoTela = tetIncluir then
       Comanda.codigo := 0;

 //    if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
 //      RepositorioComanda.Salvar_2(Comanda);

     result := Comanda;

   finally
     FreeAndNil(RepositorioComanda);
   end;
end;

procedure TfrmCadastroComanda.IncluirRegistroNoCDS(Registro: TObject);
var
  Comanda :TComanda;
begin
  inherited;

  Comanda := (Registro as TComanda);

  self.cds.Append;
  self.cdsCODIGO.AsInteger  := Comanda.codigo;
  self.cdsATIVA.AsString    := IfThen(Comanda.ativa, 'S', 'N');
  self.cds.Post;
end;

procedure TfrmCadastroComanda.LimparDados;
begin
  edtCodigo.Clear;
  edtNumComanda.Clear;
  cmbAtivo.ItemIndex := -1;
  memMotivo.Clear;
end;

procedure TfrmCadastroComanda.MostrarDados;
var
  Comanda                              :TComanda;
  RepositorioComanda                   :TRepositorio;
begin
  inherited;

  Comanda                              := nil;
  RepositorioComanda                   := nil;

  try
    RepositorioComanda  := TFabricaRepositorio.GetRepositorio(TComanda.ClassName);
    Comanda             := Tcomanda(RepositorioComanda.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Comanda) then exit;

    self.edtCodigo.Text           := IntToStr(Comanda.codigo);
    self.edtNumComanda.AsInteger  := Comanda.numero_comanda;
    self.cmbAtivo.ItemIndex       := cmbAtivo.Items.IndexOf( IfThen(Comanda.ativa, 'SIM', 'NÃO') );
    self.memMotivo.Text           := Comanda.motivo;

    cmbAtivoClick(nil);

  finally
    FreeAndNil(RepositorioComanda);
    FreeAndNil(Comanda);
  end;
end;

function TfrmCadastroComanda.VerificaDados: Boolean;
begin
  result := false;

  if edtNumComanda.AsInteger <= 0 then begin
    avisar('Favor informar o número da comanda.');
    edtNumComanda.SetFocus;
  end
  else if cds.Locate('CODIGO',edtNumComanda.AsInteger,[]) and (self.EstadoTela <> tetAlterar) then begin
    avisar('Este número de comanda já existe.');
    edtNumComanda.SetFocus;
  end
  else if memMotivo.Enabled and ( length(memMotivo.text) < 5) then begin
    avisar('O motivo do bloqueio da comanda deve ser informado.');
    memMotivo.SetFocus;
  end
  else
    result := true;
end;

procedure TfrmCadastroComanda.cmbAtivoClick(Sender: TObject);
begin
  inherited;
  if ( UPPERCASE(self.cmbAtivo.Items[ self.cmbAtivo.ItemIndex ]) = 'NÃO') then begin
    memMotivo.Enabled    := true;
    lblMotivo.Font.Color := clBlack;
    memMotivo.SetFocus;
  end
  else begin
    memMotivo.Enabled    := false;
    lblMotivo.Font.Color := clGray;
  end;
end;

procedure TfrmCadastroComanda.gridConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsATIVA then begin
    TDBGridCBN(Sender).Canvas.FillRect(Rect);

    if cdsATIVA.asString = 'S' then
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +20, Rect.Top , 0, true)
    else
      ImageList1.Draw(TDBGridCBN(Sender).Canvas, Rect.Left +20, Rect.Top , 1, true);
  end;
end;

procedure TfrmCadastroComanda.gridConsultaColEnter(Sender: TObject);
begin
  inherited;
  TDBGridCBN(Sender).SelectedIndex := 1;
end;

end.
