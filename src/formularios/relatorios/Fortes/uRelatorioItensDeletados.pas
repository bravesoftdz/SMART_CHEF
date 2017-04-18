unit uRelatorioItensDeletados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, DB, DBClient, StdCtrls, ComCtrls, Buttons, RLReport, pngimage, ExtCtrls,
  frameBuscaUsuario, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLFilters, RLPDFFilter;

type
  TfrmRelatorioItensDeletados = class(TfrmPadrao)
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
    RLDBResult1: TRLDBResult;
    RLLabel4: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel5: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText7: TRLDBText;
    RLBand5: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel3: TRLLabel;
    RLDBResult4: TRLDBResult;
    pnlBotoes: TPanel;
    Shape12: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    chkPeriodoGeral: TCheckBox;
    BuscaUsuario1: TBuscaUsuario;
    dsItensDel: TDataSource;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLLabel6: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel9: TRLLabel;
    RLDraw2: TRLDraw;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    qryItensDel: TFDQuery;
    qryItensDelCODIGO: TIntegerField;
    qryItensDelCODIGO_USUARIO: TIntegerField;
    qryItensDelQUANTIDADE: TIntegerField;
    qryItensDelHORA_EXCLUSAO: TTimeField;
    qryItensDelJUSTIFICATIVA: TStringField;
    qryItensDelDATA: TDateField;
    qryItensDelDESCRICAO: TStringField;
    qryItensDelNOME: TStringField;
    RLPDFFilter1: TRLPDFFilter;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure monta_sql;
  public
    { Public declarations }
  end;

var
  frmRelatorioItensDeletados: TfrmRelatorioItensDeletados;

implementation

uses RXCurrEdit, uModulo;

{$R *.dfm}

{ TfrmRelatorioItensDeletados }

procedure TfrmRelatorioItensDeletados.monta_sql;
var where, condicao_periodo, condicao_usuario :String;
begin
  if assigned(BuscaUsuario1.Usuario) then
    condicao_usuario     := 'id.codigo_usuario = '+BuscaUsuario1.edtCodigo.Text
  else
    condicao_usuario     := '0 = 0';

  qryItensDel.SQL.Text := 'select id.codigo, id.codigo_usuario, cast(id.quantidade as integer) quantidade, id.hora_exclusao, '+
                          '       id.justificativa, p.data, pro.descricao, usu.nome                        '+

                          'from itens_deletados id                                  '+

                          'left join produtos pro on pro.codigo = id.codigo_produto '+

                          'left join pedidos p  on p.codigo = id.codigo_pedido      '+

                          'left join usuarios usu on usu.codigo = id.codigo_usuario '+

                          'where '+condicao_usuario;



  if not chkPeriodoGeral.Checked then begin

      qryItensDel.SQL.Add(' and (p.data between :dti and :dtf)                                                    ');
      qryItensDel.SQL.Add(' and (iif( (p.data <> :dti) or ((p.data = :dti)and(id.hora_exclusao > ''07:00:00'')) ,1,0) = 1) ');
      qryItensDel.SQL.Add(' and (iif( (p.data <> :dtf) or ((p.data = :dtf)and(id.hora_exclusao < ''07:00:00'')) ,1,0) = 1) ');

      qryItensDel.ParamByName('dti').AsDateTime := dtpInicio.DateTime;
      qryItensDel.ParamByName('dtf').AsDateTime := dtpFim.DateTime + 1;
    end;

  qryItensDel.SQL.Add(' order by 1,3 ');
end;

procedure TfrmRelatorioItensDeletados.FormShow(Sender: TObject);
begin
  dtpInicio.DateTime := Date;
  dtpFim.DateTime    := date;
  qryItensDel.Connection := dm.conexao;
end;

procedure TfrmRelatorioItensDeletados.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioItensDeletados.BitBtn1Click(Sender: TObject);
begin
  qryItensDel.Connection     := dm.conexao;

  qryItensDel.Close;
  monta_sql;
  qryItensDel.Open;

  if chkPeriodoGeral.Checked then
    rlbPeriodo.Caption := '< Período Geral >'
  else
    rlbPeriodo.Caption := DateToStr( dtpInicio.Date ) + ' a ' + DateToStr( dtpFim.Date );



  if qryItensDel.IsEmpty then
    avisar('Nenhum registro foi encontrado com os filtros fornecidos.')
  else
    RLReport1.PreviewModal;
end;

end.
