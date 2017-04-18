unit uCadastroCfopCorrespondente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, frameListaCampo, StdCtrls, DB, DBClient, Grids,
  DBGrids, DBGridCBN, ComCtrls, Buttons, ExtCtrls, Contnrs, Vcl.Imaging.pngimage;

type
  TfrmCadastroCfopCorrespondente = class(TfrmCadastroPadrao)
    GroupBox1: TGroupBox;
    ListaCFOPSaida: TListaCampo;
    ListaCFOPEntrada: TListaCampo;
    cdsCFOP_SAIDA: TStringField;
    cdsCFOP_ENTRADA: TStringField;
    edtCodigo: TEdit;
    cdsCODIGO: TIntegerField;
    procedure FormShow(Sender: TObject);
  private

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
  frmCadastroCfopCorrespondente: TfrmCadastroCfopCorrespondente;

implementation

uses CFOPCorrespondente, Repositorio, FabricaRepositorio;

{$R *.dfm}

procedure TfrmCadastroCfopCorrespondente.AlterarRegistroNoCDS(
  Registro: TObject);
var
  CFOPCorrespondente :TCFOPCorrespondente;
begin
  inherited;

  CFOPCorrespondente := (Registro as TCFOPCorrespondente);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger       := CFOPCorrespondente.codigo;
  self.cdsCFOP_SAIDA.AsString    := ListaCFOPSaida.comListaCampo.Text;
  self.cdsCFOP_ENTRADA.AsString  := ListaCFOPEntrada.comListaCampo.Text;
  self.cds.Post;
end;

procedure TfrmCadastroCfopCorrespondente.CarregarDados;
var
  CFOPs       :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;
  Repositorio := nil;
  CFOPs    := nil;
  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TCFOPCorrespondente.ClassName);
    CFOPs       := Repositorio.GetAll;

    if Assigned(CFOPs) and (CFOPs.Count > 0) then begin
       for nX := 0 to (CFOPs.Count-1) do
         self.IncluirRegistroNoCDS(CFOPs.Items[nX]);
    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(CFOPs);
  end;
end;

procedure TfrmCadastroCfopCorrespondente.ExecutarDepoisAlterar;
begin
  inherited;
  ListaCFOPSaida.comListaCampo.SetFocus;
end;

procedure TfrmCadastroCfopCorrespondente.ExecutarDepoisIncluir;
begin
  inherited;
  ListaCFOPSaida.comListaCampo.SetFocus;
end;

procedure TfrmCadastroCfopCorrespondente.FormShow(Sender: TObject);
begin
  inherited;
  ListaCFOPSaida.setValores('select nat.* from naturezas_operacao nat ' +
                            'where substring(nat.cfop from 1 for 1) in (''5'',''6'')', 'CFOP', 'CFOP de saída');
  ListaCFOPSaida.executa;

  ListaCFOPEntrada.setValores('select nat.* from naturezas_operacao nat '+
                            'where substring(nat.cfop from 1 for 1) not in (''5'',''6'')', 'CFOP', 'CFOP de entrada');
  ListaCFOPEntrada.executa;
end;

function TfrmCadastroCfopCorrespondente.GravarDados: TObject;
var
  CFOPCorrespondente     :TCFOPCorrespondente;

  RepositorioCFOPCorrespondente  :TRepositorio;
begin
   CFOPCorrespondente             := nil;
   RepositorioCFOPCorrespondente  := nil;

   try
     RepositorioCFOPCorrespondente  := TFabricaRepositorio.GetRepositorio(TCFOPCorrespondente.ClassName);
     CFOPCorrespondente             := TCFOPCorrespondente(RepositorioCFOPCorrespondente.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(CFOPCorrespondente) then
      CFOPCorrespondente := TCFOPCorrespondente.Create;

     CFOPCorrespondente.cod_CFOP_Saida           := self.ListaCFOPSaida.CodCampo;
     CFOPCorrespondente.cod_CFOP_Entrada         := self.ListaCFOPEntrada.CodCampo;

     RepositorioCFOPCorrespondente.Salvar(CFOPCorrespondente);

     result := CFOPCorrespondente;

   finally
     FreeAndNil(RepositorioCFOPCorrespondente);

   end;
end;

procedure TfrmCadastroCfopCorrespondente.IncluirRegistroNoCDS(
  Registro: TObject);
var
  CFOPCorrespondente :TCFOPCorrespondente;
begin
  inherited;

  CFOPCorrespondente := (Registro as TCFOPCorrespondente);

  self.cds.Append;
  self.cdsCODIGO.AsInteger        := CFOPCorrespondente.codigo;
  self.cdsCFOP_SAIDA.AsString     := CFOPCorrespondente.cfop_saida;
  self.cdsCFOP_ENTRADA.AsString   := CFOPCorrespondente.cfop_entrada;
  self.cds.Post;
end;

procedure TfrmCadastroCfopCorrespondente.LimparDados;
begin
  inherited;
  ListaCFOPSaida.comListaCampo.ItemIndex   := -1;
  ListaCFOPEntrada.comListaCampo.ItemIndex := -1;
end;

procedure TfrmCadastroCfopCorrespondente.MostrarDados;
var
  CFOPCorrespondente                              :TCFOPCorrespondente;
  RepositorioCFOPCorrespondente                   :TRepositorio;
begin
  inherited;

  CFOPCorrespondente                              := nil;
  RepositorioCFOPCorrespondente                   := nil;

  try
    RepositorioCFOPCorrespondente  := TFabricaRepositorio.GetRepositorio(TCFOPCorrespondente.ClassName);

    CFOPCorrespondente             := TCFOPCorrespondente(RepositorioCFOPCorrespondente.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(CFOPCorrespondente) then exit;

    self.edtCodigo.Text            := intToStr(CFOPCorrespondente.codigo);
    self.ListaCFOPSaida.CodCampo   := CFOPCorrespondente.cod_CFOP_Saida;
    self.ListaCFOPEntrada.CodCampo := CFOPCorrespondente.cod_CFOP_Entrada;

  finally
    FreeAndNil(RepositorioCFOPCorrespondente);
    FreeAndNil(CFOPCorrespondente);
  end;
end;

function TfrmCadastroCfopCorrespondente.VerificaDados: Boolean;
begin
  result := true;

  if ListaCFOPSaida.comListaCampo.ItemIndex <= 0 then begin
    avisar('Favor informar o CFOP de Saída');
    ListaCFOPSaida.comListaCampo.SetFocus;
    result := false;
  end
  else if ListaCFOPEntrada.comListaCampo.ItemIndex <= 0 then begin
    avisar('Favor informar o CFOP de Entrada');
    ListaCFOPEntrada.comListaCampo.SetFocus;
    result := false;
  end;
end;

end.
