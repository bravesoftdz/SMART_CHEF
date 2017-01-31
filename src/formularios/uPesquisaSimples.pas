unit uPesquisaSimples;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DBGridCBN,
  Provider, DB, DBClient, ImgList, pngimage;

type
  TfrmPesquisaSimples = class(TfrmPadrao)
    Panel1: TPanel;
    btnSeleciona: TBitBtn;
    btnCancela: TBitBtn;
    ds: TDataSource;
    DBGrid1: TDBGridCBN;
    Label1: TLabel;
    cds: TClientDataSet;
    dsp: TDataSetProvider;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    Campo :String;
    Fcds_retorno :TClientDataSet;

    procedure adiciona_remove(valor :String);

  private
    FPermite_multiselecao  :Boolean;

  public
    constructor Create(AOwner: TComponent; SQL, campoRetorno :String; const titulo :String = ''; const permite_multiselecao :Boolean = true;
                       const largura_form :Integer = 670; const altura_form :Integer = 330); overload; virtual;
    destructor Destroy; override;

    property cds_retorno :TClientDataSet read Fcds_retorno;

  end;

var
  frmPesquisaSimples: TfrmPesquisaSimples;

implementation

{$R *.dfm}

{ TfrmPadrao1 }

constructor TfrmPesquisaSimples.Create(AOwner: TComponent; SQL, campoRetorno :String; const titulo :String;
             const permite_multiselecao :Boolean; const largura_form :Integer; const altura_form :Integer);
var nX :integer;
begin
  self.Create(AOwner);
  Campo := CampoRetorno;

  if titulo <> '' then   self.Caption := titulo;

  self.Width  := largura_form;
  self.Height := altura_form;

  Fcds_retorno := TClientDataSet.Create(nil);

  Fcds_retorno.Close;
  Fcds_retorno.FieldDefs.Clear;
  Fcds_retorno.FieldDefs.add(Campo, ftString, 100, false);
  Fcds_retorno.CreateDataSet;
  Fcds_retorno.Open;

  dsp.DataSet  := FDM.GetConsulta(SQL);
  cds.Open;

  if cds.IsEmpty then
    exit;

  for nx := 0 to cds.Fields.Count - 1 do
    if (cds.Fields[nx].DataType = ftFloat) or (cds.Fields[nx].DataType = ftBCD) then
      TNumericField( cds.Fields[nX] ).DisplayFormat := ',0.00; ,0.00';

  cds.RecNo       := 1;
  DBGrid1.SelectedIndex  := 0;
  FPermite_multiselecao  := permite_multiselecao;

  for nX := 0 to DBGrid1.Columns.Count - 1 do begin

       DBGrid1.Columns[nx].Width := 300;

    if (cds.Fields[nx].DataType = ftFloat) or (cds.Fields[nx].DataType = ftBCD) then
       DBGrid1.Columns[nx].Width := 90;

    if pos('CODIGO', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 50
    else if pos('NOME', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 200
    else if pos('FONE', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 80
    else if pos('NUM', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 80
    else if pos('BAIRR', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 150
    else if pos('DESC', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 450
    else if pos('REFER', cds.Fields[nX].FieldName) > 0 then
       DBGrid1.Columns[nx].Width := 134;

  end;

  cds.Fields[0].Visible   := false;
end;

procedure TfrmPesquisaSimples.btnCancelaClick(Sender: TObject);
begin
  inherited;
  self.ModalResult := mrCancel;
end;

procedure TfrmPesquisaSimples.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  if Fcds_retorno.IsEmpty then
     adiciona_remove( cds.FieldByName(campo).AsString );

  Fcds_retorno.First;   

  self.ModalResult := mrOk;
end;

procedure TfrmPesquisaSimples.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then begin
    key := 0;
    btnSeleciona.Click;
  end
  else if key = vk_escape then begin
    key := 0;
    if self.ds.DataSet.Filtered then
      self.ds.DataSet.Filtered:= False
    else
      btnCancela.Click;
  end;  

  inherited;

end;

procedure TfrmPesquisaSimples.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (Column.FieldName = 'N° Comanda') then begin
    // TDBGridCBN(Sender).Canvas.FillRect(Rect);
     TDBgridCBN(Sender).Canvas.Font.Style := [fsBold];
     TDBgridCBN(Sender).Canvas.FillRect(Rect);
     TDBgridCBN(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
  end
  else if (Column.FieldName = 'N° Pedido') then begin

     if cds.Fields[2].AsString = 'LIVRE' then begin
     //  TDBGridCBN(Sender).Canvas.FillRect(Rect);
       TDBgridCBN(Sender).Canvas.Font.Color := clGreen;
       TDBgridCBN(Sender).Canvas.Font.Style := [fsBold];
       TDBgridCBN(Sender).Canvas.FillRect(Rect);
       TDBgridCBN(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
     end;
  end;

  if Fcds_retorno.Locate(campo, cds.FieldByName(campo).AsString, []) then begin
    TDBgridCBN(Sender).Canvas.Brush.Color := clSkyBlue;
  end;

  inherited;
end;

destructor TfrmPesquisaSimples.Destroy;
var
  Dataset :TDataset;
begin
  Dataset := dsp.DataSet;

  if Assigned(Dataset) then
    FreeAndNil(Dataset);

  inherited;
end;

procedure TfrmPesquisaSimples.adiciona_remove(valor: String);
begin
  if Fcds_retorno.Locate(campo, valor, []) then
    Fcds_retorno.Delete
  else begin
    Fcds_retorno.Append;
    Fcds_retorno.FieldByName(campo).AsString := valor;
    Fcds_retorno.Post;
  end;
end;

procedure TfrmPesquisaSimples.DBGrid1DblClick(Sender: TObject);
begin
  if not self.FPermite_multiselecao then Exit;
  
  adiciona_remove( cds.FieldByName(campo).AsString );
  dbgrid1.Repaint;
end;

end.
