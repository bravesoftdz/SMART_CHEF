unit frameListaCampo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, FireDAC.Comp.Client, Funcoes;

type
  TListaCampo = class(TFrame)
    comListaCampo: TComboBox;
    Label4: TLabel;
    staTitulo: TStaticText;
  private
    FSql :String;
    FCampo :String;
    FTitulo :String;
    FCodCampo :integer;
    qry     :TFDQuery;

    function getCodCampo:Integer;
    procedure setCodCampo(const value:Integer);
  public
    property CodCampo :Integer read getCodCampo write setCodCampo;

    procedure setValores(sql,campo,titulo:String);
    procedure executa;
  end;

implementation

uses
  uModulo;

{$R *.dfm}

{ TFrame1 }

procedure TListaCampo.executa;
begin
  staTitulo.Caption := FTitulo;

  qry := TFDQuery.Create(nil);
  qry.Close;
  qry := dm.GetConsulta(FSql);
  qry.Open;

  comListaCampo.Items.Add('');
  if not qry.IsEmpty then
    while not qry.Eof do begin
      comListaCampo.Items.Add(qry.fieldByName(FCampo).AsString);
      qry.Next;
    end;
end;

function TListaCampo.getCodCampo: Integer;
begin
  Result := 0;

  if not qry.IsEmpty then
    if qry.Locate(FCampo, CastField(qry.FieldByName(Fcampo).DataType ,self.comListaCampo.Text), []) then
      Result := qry.fieldByName('CODIGO').AsInteger;
end;

procedure TListaCampo.setCodCampo(const value: Integer);
begin
  if qry.Locate('CODIGO',value,[]) then
    comListaCampo.ItemIndex := comListaCampo.Items.IndexOf(qry.fieldByName(FCampo).AsString)
  else
    comListaCampo.ItemIndex := 0;  
end;

procedure TListaCampo.setValores(sql, campo, titulo: String);
begin
  self.FSql := sql;
  self.FCampo := campo;
  self.FTitulo := titulo;
end;

end.
