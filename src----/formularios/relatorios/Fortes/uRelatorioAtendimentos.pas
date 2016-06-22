unit uRelatorioAtendimentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  StdCtrls, ComCtrls, frameListaCampo, Buttons, RLReport, pngimage,
  ExtCtrls, DBClient, DateTimeUtilitario, RLFilters, RLPDFFilter;

type
  TfrmRelatorioAtendimentos = class(TfrmPadrao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel8: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLDraw8: TRLDraw;
    RLLabel23: TRLLabel;
    rlbPeriodo: TRLLabel;
    RLLabel11: TRLLabel;
    RLBand4: TRLBand;
    RLDraw7: TRLDraw;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDraw3: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel5: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText7: TRLDBText;
    RLBand5: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel3: TRLLabel;
    RLDBResult4: TRLDBResult;
    pnlBotoes: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    dsUsuarios: TDataSource;
    qryUsuarios: TZQuery;
    ds: TDataSource;
    cds: TClientDataSet;
    qryUsuariosDATA: TDateField;
    qryUsuariosNOME: TStringField;
    cdsUSUARIO: TStringField;
    cdsDATA: TDateField;
    cdsNUM_ATENDIMENTOS: TIntegerField;
    RLDBResult1: TRLDBResult;
    qryUsuariosHORAS: TTimeField;
    RLLabel4: TRLLabel;
    rlbdiaSemana: TRLLabel;
    Shape12: TShape;
    RLPDFFilter1: TRLPDFFilter;
    listaUsuarios: TListaCampo;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure monta_sql;
    procedure totaliza_atendimentos;
  public
    { Public declarations }
  end;

var
  frmRelatorioAtendimentos: TfrmRelatorioAtendimentos;

implementation

uses uModulo;

{$R *.dfm}

procedure TfrmRelatorioAtendimentos.FormShow(Sender: TObject);
begin
  dtpInicio.DateTime := Date;
  dtpFim.DateTime    := date;

  listaUsuarios.setValores('select * from Usuarios', 'Nome', 'Usuário');
  listaUsuarios.executa;
end;

procedure TfrmRelatorioAtendimentos.BitBtn1Click(Sender: TObject);
begin
  qryUsuarios.Connection     := dm.conexao;

  qryUsuarios.Close;
  monta_sql;
  qryUsuarios.Open;

  totaliza_atendimentos;

  if chkPeriodoGeral.Checked then
    rlbPeriodo.Caption := '< Período Geral >'
  else
    rlbPeriodo.Caption := DateToStr( dtpInicio.Date ) + ' a ' + DateToStr( dtpFim.Date );



  if qryUsuarios.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioAtendimentos.monta_sql;
var where, condicao_periodo, condicao_usuario :String;
begin

  qryUsuarios.SQL.Text := 'select ped.data, u.nome,                                           '+
                          '  CAST( lpad(EXTRACT(HOUR FROM i.hora), 2, ''0'') || '':'' ||      '+
                          '        lpad(EXTRACT(minute FROM i.hora), 2, ''0'') || '':'' ||    '+
                          '        lpad(EXTRACT(second FROM i.hora), 2, ''0'') as Time) horas '+

                          'from itens i                                                       '+

                          'left join usuarios u   on u.codigo = i.codigo_usuario              '+
                          'left join pedidos  ped on ped.codigo = i.codigo_pedido             '+
                          ' where i.codigo_produto > 1                                        ';

  if not chkPeriodoGeral.Checked then begin

      qryUsuarios.SQL.Add('and (ped.data between :dti and :dtf) ');
      qryUsuarios.SQL.Add(' and (iif( (ped.data <> :dti) or ((ped.data = :dti)and(i.hora > ''07:00:00'')) ,1,0) = 1) ');
      qryUsuarios.SQL.Add(' and (iif( (ped.data <> :dtf) or ((ped.data = :dtf)and(i.hora < ''07:00:00'')) ,1,0) = 1) ');

      qryUsuarios.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
      qryUsuarios.ParamByName('dtf').AsDateTime := dtpFim.DateTime + 1;
    end;

  if listaUsuarios.CodCampo > 0 then begin
    qryUsuarios.SQL.Add(' and u.codigo = :cod_usuario ');

    qryUsuarios.ParamByName('cod_usuario').AsInteger := listaUsuarios.CodCampo;
  end;

  qryUsuarios.SQL.Add(' group by ped.data, u.nome, horas ');
  qryUsuarios.SQL.Add(' order by ped.data, u.nome, horas ');

end;

procedure TfrmRelatorioAtendimentos.totaliza_atendimentos;
begin
  if qryUsuarios.IsEmpty then
    Exit;

  if not cds.Active then
    cds.CreateDataSet
  else
    cds.EmptyDataSet;  

  qryUsuarios.First;
  while not qryUsuarios.Eof do begin

    if cds.Locate('DATA;USUARIO', varArrayOf([qryUsuariosDATA.AsDateTime, qryUsuariosNOME.AsString]), []) then
      cds.Edit
    else
      cds.Append;

    cdsUSUARIO.AsString           := qryUsuariosNOME.AsString;
    cdsDATA.AsDateTime            := qryUsuariosDATA.AsDateTime;
    cdsNUM_ATENDIMENTOS.AsInteger := cdsNUM_ATENDIMENTOS.AsInteger + 1;

    cds.Post;


    qryUsuarios.Next;
  end;
end;

procedure TfrmRelatorioAtendimentos.RLDBText8BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  rlbdiaSemana.Caption := '( '+TDateTimeUtilitario.DiaSemanaExtenso( StrToDateTime(Text) )+' )';
  inherited;
end;

procedure TfrmRelatorioAtendimentos.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

end.
