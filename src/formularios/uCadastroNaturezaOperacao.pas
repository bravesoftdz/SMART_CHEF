unit uCadastroNaturezaOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, DBClient, StdCtrls, Grids, DBGrids, generics.collections,
  DBGridCBN, ComCtrls, Buttons, ExtCtrls, Mask, Especificacao, Math, Vcl.Imaging.pngimage;

type
  TfrmCadastroNaturezaOperacao = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    cdsCFOP: TStringField;
    edtCodigo: TEdit;
    lblAsteriscoDescricao: TLabel;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    edtCFOP: TMaskEdit;
    lblCFOP: TLabel;
    lblAsteriscoCFOP: TLabel;
    rgSuspensaoICMS: TRadioGroup;
    cdsSUSPENSAO_ICMS: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    Fcadastro_correspondente: Boolean;
    Ffiltra_cfop_entrada: Boolean;
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                                overload; override;

   { Carrega os registros de acordo com uma especificação. É utilizado apenas no modo de busca. }
    procedure CarregarDados(Especificacao :TEspecificacao); overload; override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;
    procedure Setcadastro_correspondente(const Value: Boolean);
    procedure Setfiltra_cfop_entrada(const Value: Boolean);

  private
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;

  public

    property cadastro_correspondente :Boolean read Fcadastro_correspondente write Setcadastro_correspondente;
    property filtra_cfop_entrada     :Boolean read Ffiltra_cfop_entrada write Setfiltra_cfop_entrada;

end;

var
  frmCadastroNaturezaOperacao: TfrmCadastroNaturezaOperacao;

implementation

uses
   NaturezaOperacao,
   Contnrs,
   Repositorio,
   FabricaRepositorio,
   ValidadorNaturezaOperacao, EspecificacaoNaturezaComCFOPIgualA, StrUtils;

{$R *.dfm}

{ TfrmCadastroNaturezaOperacao }

procedure TfrmCadastroNaturezaOperacao.AlterarRegistroNoCDS(
  Registro: TObject);
var
  NaturezaOperacao :TNaturezaOperacao;
begin
  NaturezaOperacao := (Registro as TNaturezaOperacao);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger        := NaturezaOperacao.Codigo;
  self.cdsDESCRICAO.AsString      := NaturezaOperacao.Descricao;
  self.cdsCFOP.AsString           := NaturezaOperacao.CFOP;
  self.cdsSUSPENSAO_ICMS.AsString := NaturezaOperacao.suspensao_icms;
  self.cds.Post;
end;

procedure TfrmCadastroNaturezaOperacao.CarregarDados;
var
  Naturezas   :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  Repositorio := nil;
  Naturezas    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
    Naturezas    := Repositorio.GetAll;

    if Assigned(Naturezas) and (Naturezas.Count > 0) then begin

       for nX := 0 to (Naturezas.Count-1) do
         self.IncluirRegistroNoCDS(Naturezas.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Naturezas);
  end;
end;

procedure TfrmCadastroNaturezaOperacao.CarregarDados(
  Especificacao: TEspecificacao);
var
  Naturezas   :TObjectList<TNaturezaOperacao>;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  Repositorio := nil;
  Naturezas   := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
    Naturezas   := Repositorio.GetListaPorEspecificacao<TNaturezaOperacao>(self.FEspecificacaoDeBusca);

    if Assigned(Naturezas) and (Naturezas.Count > 0) then begin

       for nX := 0 to (Naturezas.Count-1) do
         self.IncluirRegistroNoCDS(Naturezas.Items[nX]);
    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Naturezas);
  end;
end;

procedure TfrmCadastroNaturezaOperacao.ExecutarDepoisAlterar;
begin
  inherited;

  self.edtDescricao.SetFocus;
end;

procedure TfrmCadastroNaturezaOperacao.ExecutarDepoisIncluir;
begin
  inherited;

  self.edtDescricao.SetFocus;
end;

function TfrmCadastroNaturezaOperacao.GravarDados: TObject;
var
  Natureza               :TNaturezaOperacao;
  NaturezaEncontradaNoBD :TNaturezaOperacao;
  Validador              :TValidadorNaturezaOperacao;
  Especificacao          :TEspecificacaoNaturezaComCFOPIgualA;
  Repositorio            :TRepositorio;
begin
   Natureza               := nil;
   NaturezaEncontradaNoBD := nil;
   Repositorio            := nil;
   Especificacao          := nil;
   Validador              := nil;

   try
     Repositorio            := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
     Natureza               := TNaturezaOperacao(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Natureza) then
      Natureza := TNaturezaOperacao.Create;

     Natureza.Descricao     := self.edtDescricao.Text;
     Natureza.CFOP          := self.edtCFOP.Text;
     Natureza.suspensao_icms:= copy(rgSuspensaoICMS.Items[rgSuspensaoICMS.ItemIndex] ,1,1);

     Especificacao          := TEspecificacaoNaturezaComCFOPIgualA.Create(Natureza.CFOP);
     NaturezaEncontradaNoBD := TNaturezaOperacao(Repositorio.GetPorEspecificacao(Especificacao));

     Validador              := TValidadorNaturezaOperacao.Create(Natureza, NaturezaEncontradaNoBD);
     Validador.ValidarCFOP;

     Repositorio.Salvar(Natureza);

     result := Natureza

   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Validador);
     FreeAndNil(Repositorio);
     FreeAndNil(NaturezaEncontradaNoBD);
   end;
end;

procedure TfrmCadastroNaturezaOperacao.IncluirRegistroNoCDS(
  Registro: TObject);
var
  Natureza :TNaturezaOperacao;
begin
  inherited;

  Natureza := (Registro as TNaturezaOperacao);

  self.cds.Append;
  self.cdsCODIGO.AsInteger        := Natureza.Codigo;
  self.cdsDESCRICAO.AsString      := Natureza.Descricao;
  self.cdsCFOP.AsString           := Natureza.CFOP;
  self.cdsSUSPENSAO_ICMS.AsString := Natureza.suspensao_icms;
  self.cds.Post;
end;

procedure TfrmCadastroNaturezaOperacao.LimparDados;
begin
  inherited;

  self.edtCodigo.Clear;
  self.edtDescricao.Clear;
  self.edtCFOP.Clear;
  self.rgSuspensaoICMS.ItemIndex := -1;
end;

procedure TfrmCadastroNaturezaOperacao.MostrarDados;
var
  Natureza    :TNaturezaOperacao;
  Repositorio :TRepositorio;
begin
  inherited;

  Natureza    := nil;
  Repositorio := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);

    Natureza    := TNaturezaOperacao(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Natureza) then exit;

    self.edtCodigo.Text                 := IntToStr(Natureza.Codigo);
    self.edtDescricao.Text              := Natureza.Descricao;
    self.edtCFOP.Text                   := Natureza.CFOP;
    self.rgSuspensaoICMS.ItemIndex      := self.rgSuspensaoICMS.Items.IndexOf( IfThen(Natureza.suspensao_icms = 'S','Sim','Não') );

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Natureza);
  end;
end;

function TfrmCadastroNaturezaOperacao.VerificaDados: Boolean;
begin
  result := true;
  
  if trim(edtDescricao.Text) = '' then begin
    avisar('Favor informar a descrição da natureza de operação');
    edtDescricao.SetFocus;
    result := false;
  end
  else if trim(edtCFOP.Text) = '' then begin
    avisar('Favor informar o CFOP da natureza de operação!');
    edtCFOP.SetFocus;
    result := false;
  end
  else if (cadastro_correspondente) and ((copy(edtCFOP.Text,1,1) = '5') or (copy(edtCFOP.Text,1,1) = '6'))then begin
    avisar('É necessário cadastrar um CFOP de entrada para corresponder a um de saída.');
    edtCFOP.SetFocus;
    result := false;
  end;
end;

procedure TfrmCadastroNaturezaOperacao.Setcadastro_correspondente(
  const Value: Boolean);
begin
  Fcadastro_correspondente := Value;
end;

procedure TfrmCadastroNaturezaOperacao.FormShow(Sender: TObject);
begin
  inherited;
  if cadastro_correspondente then
    btnIncluir.Click;

  if filtra_cfop_entrada then begin
    cds.Filtered := false;
    cds.Filter   := 'not cfop like ''5%'' and not cfop like ''6%'' ';
    cds.Filtered := true;
  end;
end;

procedure TfrmCadastroNaturezaOperacao.btnCancelarClick(Sender: TObject);
begin
  if cadastro_correspondente then
    self.ModalResult := MrCancel;
    
  inherited;
end;

procedure TfrmCadastroNaturezaOperacao.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if cadastro_correspondente then
    self.ModalResult := MrOk;
end;

procedure TfrmCadastroNaturezaOperacao.FormCreate(Sender: TObject);
begin
  inherited;
  filtra_cfop_entrada     := false;
  cadastro_correspondente := false;
end;

procedure TfrmCadastroNaturezaOperacao.Setfiltra_cfop_entrada(
  const Value: Boolean);
begin
  Ffiltra_cfop_entrada := Value;
end;

end.
