unit uCadastroDispensa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, StdCtrls, DB, DBClient, Grids, DBGrids,
  DBGridCBN, ComCtrls, pngimage, ExtCtrls, Buttons, ContNrs, Mask,
  ToolEdit, CurrEdit;

type
  TfrmCadastroDispensa = class(TfrmCadastroPadrao)
    edtCodigo: TEdit;
    lblRazao: TLabel;
    edtDescricao: TEdit;
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    edtEstoque: TCurrencyEdit;
    lbEstoque: TStaticText;
    Label1: TLabel;
    cmbUnidadeMedida: TComboBox;
    edtPecas: TCurrencyEdit;
    StaticText1: TStaticText;
    edtPrecoCusto: TCurrencyEdit;
    StaticText2: TStaticText;
    edtEstoqueMin: TCurrencyEdit;
    StaticText3: TStaticText;
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
  frmCadastroDispensa: TfrmCadastroDispensa;

implementation

uses repositorio, fabricaRepositorio, Dispensa, EspecificacaoEstoquePorItemDispensa, Estoque;

{$R *.dfm}

{ TfrmCadastroDispensa }

procedure TfrmCadastroDispensa.AlterarRegistroNoCDS(Registro: TObject);
var
  Dispensa :TDispensa;
begin
  inherited;

  Dispensa := (Registro as TDispensa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger    := Dispensa.codigo;
  self.cdsDESCRICAO.AsString  := Dispensa.descricao_item;
  self.cds.Post;
end;

procedure TfrmCadastroDispensa.CarregarDados;
var
  Dispensas     :TObjectList;
  Repositorio   :TRepositorio;
  nX            :Integer;
begin
  inherited;

  Repositorio   := nil;
  Dispensas     := nil;

  try
    Repositorio   := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);
    Dispensas     := Repositorio.GetAll;

    if Assigned(Dispensas) and (Dispensas.Count > 0) then begin

       for nX := 0 to (Dispensas.Count-1) do
         self.IncluirRegistroNoCDS(Dispensas.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Dispensas);
  end;
end;

procedure TfrmCadastroDispensa.ExecutarDepoisAlterar;
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadastroDispensa.ExecutarDepoisIncluir;
begin
  inherited;
  edtDescricao.SetFocus;
end;

function TfrmCadastroDispensa.GravarDados: TObject;
var
  Dispensa             :TDispensa;
  RepositorioDispensa  :TRepositorio;
  Especificacao        :TEspecificacaoEstoquePorItemDispensa;
  Estoque              :TEstoque;
begin
   Dispensa             := nil;
   RepositorioDispensa  := nil;
   Especificacao        := nil;
   Estoque              := nil;

   try
     RepositorioDispensa  := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);
     Dispensa             := TDispensa(RepositorioDispensa.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Dispensa) then
      Dispensa := TDispensa.Create;

     Dispensa.descricao_item       := self.edtDescricao.Text;
     Dispensa.preco_custo          := edtPrecoCusto.Value;

     RepositorioDispensa.Salvar(Dispensa);

     if self.EstadoTela = tetIncluir then
       Dispensa.codigo := 0;

     if (fdm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       RepositorioDispensa.Salvar_2(Dispensa);

     { * * * SALVA ESTOQUE DA DISPENSA * * * }

     if (edtEstoque.Value > 0) or (edtEstoqueMin.Value > 0) then begin

        Especificacao        := TEspecificacaoEstoquePorItemDispensa.Create(Dispensa);
        RepositorioDispensa  := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
        Estoque              := TEstoque( RepositorioDispensa.GetPorEspecificacao( Especificacao ) );

        if not assigned( Estoque ) then
          Estoque := TEstoque.Create;

        Estoque.codigo_dispensa := Dispensa.codigo;
        Estoque.quantidade      := edtEstoque.Value;
        Estoque.unidade_medida  := cmbUnidadeMedida.Items[ cmbUnidadeMedida.itemIndex ];
        Estoque.pecas           := edtPecas.AsInteger;
        Estoque.quantidade_min  := edtEstoqueMin.Value;

        RepositorioDispensa.Salvar(Estoque);

     end;

     result := Dispensa;

   finally
     FreeAndNil(RepositorioDispensa);
     if assigned(Estoque)           then  FreeAndNil(Estoque);
     if assigned(Especificacao)     then  FreeAndNil(Especificacao);
   end;
end;

procedure TfrmCadastroDispensa.IncluirRegistroNoCDS(Registro: TObject);
var
  Dispensa :TDispensa;
begin
  inherited;

  Dispensa := (Registro as TDispensa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := Dispensa.codigo;
  self.cdsDESCRICAO.AsString    := Dispensa.descricao_item;
  self.cds.Post;
end;

procedure TfrmCadastroDispensa.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtPrecoCusto.Clear;
  cmbUnidadeMedida.ItemIndex := -1;
  edtEstoque.Clear;
  edtEstoqueMin.Clear;
  edtPecas.AsInteger := 1;
end;

procedure TfrmCadastroDispensa.MostrarDados;
var
  Dispensa                              :TDispensa;
  RepositorioDispensa                   :TRepositorio;
  Especificacao                         :TEspecificacaoEstoquePorItemDispensa;
  Estoque                               :TEstoque;
begin
  inherited;

  Dispensa              := nil;
  RepositorioDispensa   := nil;
  Especificacao         := nil;
  Estoque               := nil;

  try
    RepositorioDispensa  := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);
    Dispensa             := TDispensa(RepositorioDispensa.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Dispensa) then exit;

    self.edtCodigo.Text      := IntToStr(Dispensa.codigo);
    self.edtDescricao.Text   := Dispensa.descricao_item;
    self.edtPrecoCusto.Value := Dispensa.preco_custo;

    Especificacao            := TEspecificacaoEstoquePorItemDispensa.Create(Dispensa);
    RepositorioDispensa      := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
    Estoque                  := TEstoque( RepositorioDispensa.GetPorEspecificacao( Especificacao ) );

    if not assigned( Estoque ) then
      Exit;

    edtEstoque.Value           := Estoque.quantidade;
    edtPecas.AsInteger         := Estoque.pecas;
    cmbUnidadeMedida.ItemIndex := cmbUnidadeMedida.Items.IndexOf( Estoque.unidade_medida );
    edtEstoqueMin.Value        := Estoque.quantidade_min; 

  finally
     FreeAndNil(RepositorioDispensa);
     FreeAndNil(Dispensa);
     if assigned(Estoque)           then  FreeAndNil(Estoque);
     if assigned(Especificacao)     then  FreeAndNil(Especificacao);
  end;
end;

function TfrmCadastroDispensa.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtDescricao.Text) = '' then begin
    avisar('Favor informar uma descrição para o item da dispensa');
    edtDescricao.SetFocus;
  end
  else
    result := true;
end;

end.
