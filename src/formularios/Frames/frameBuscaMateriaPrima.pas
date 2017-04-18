unit frameBuscaMateriaPrima;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MateriaPrima, StdCtrls, Buttons, Mask, RXToolEdit, RXCurrEdit, Produto,
  ProdutoHasMAteria, Contnrs, generics.Collections;

type
  TBuscaMateriaPrima = class(TFrame)
    StaticText1: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtMateria: TEdit;
    StaticText2: TStaticText;
    procedure edtMateriaEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
  private
    FMateriaPrima :TMateriaPrima;
    Fcodigo: Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;
    FSQL_DO_GRUPO :String;
    FSQL_DO_PRODUTO :String;

    FProduto        :TProduto;
    FAdicionaRemove :String;

    procedure buscaMateriaPrima;
    function selecionaMateriaPrima :String;
    procedure setaMateriaPrima;
    procedure SetAdicionaRemove(const Value: String);
    procedure SetProduto(const Value: TProduto);

  private
    procedure SetMateriaPrima          (const Value: TMateriaPrima);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

    function produto_valido(codigo_materia :integer):Boolean;

  public
    procedure limpa;

    property MateriaPrima    :TMateriaPrima read FMateriaPrima   write SetMateriaPrima;
    property codigo          :Integer       read Fcodigo         write Setcodigo;
    property Produto         :TProduto      read FProduto        write SetProduto;
    property AdicionaRemove  :String        read FAdicionaRemove write SetAdicionaRemove;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio, EspecificacaoProdutosQueContemMateria;

{$R *.dfm}

{ TFrame1 }

procedure TBuscaMateriaPrima.buscaMateriaPrima;
begin
  setaMateriaPrima;

  if not assigned( FMateriaPrima ) then
    selecionaMateriaPrima;
end;

procedure TBuscaMateriaPrima.limpa;
begin
  Fcodigo := 0;
  edtMateria.Clear;
  edtCodigo.Clear;

  if assigned(FMateriaPrima) then
    FreeAndNil(FMateriaPrima);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaMateriaPrima.selecionaMateriaPrima: String;
var SQL, nome :String;
begin
  Result := '';

  if FAdicionaRemove = 'A' then
  begin
    SQL := FSQL_DO_GRUPO;
    nome := 'grupo';
  end
  else
  begin
    SQL := FSQL_DO_PRODUTO;
    nome := 'produto';
  end;

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select mp.codigo, mp.descricao from materias_primas mp ' + SQL
                                                        ,'CODIGO', 'Selecione a Matéria-prima desejada...');

  if frmPesquisaSimples.cds.IsEmpty then
    frmPesquisaSimples.avisar('Não existem adicionais cadastrados para o '+nome+' selecionado.', 3)
  else if (frmPesquisaSimples.ShowModal = mrOk) then begin
    Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaMateriaPrima;
  end;
  frmPesquisaSimples.Release;
end;

procedure TBuscaMateriaPrima.setaMateriaPrima;
var
    RepMateriaPrima :TRepositorio;
begin

  RepMateriaPrima := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
  FMateriaPrima   := TMateriaPrima(RepMateriaPrima.Get(edtCodigo.AsInteger));

  if ((self.FAdicionaRemove = 'A')or(self.FAdicionaRemove = 'R')) and not produto_valido(FMateriaPrima.codigo) then
    FreeAndNil(FMateriaPrima);

  if Assigned(FMateriaPrima) then begin

    edtCodigo.Value  := FMateriaPrima.Codigo;
    edtMateria.Text  := FMateriaPrima.descricao;
    self.Fcodigo     := FMateriaPrima.codigo;

    edtMateria.SetFocus;
    if Assigned(FMateriaPrima) and Assigned(FExecutarAposBuscar) then
     self.FExecutarAposBuscar(FMateriaPrima);
  end
  else limpa;
end;

procedure TBuscaMateriaPrima.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaMateriaPrima;
end;

procedure TBuscaMateriaPrima.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaMateriaPrima.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaMateriaPrima.SetMateriaPrima(const Value: TMateriaPrima);
begin
  FMateriaPrima := Value;
end;

procedure TBuscaMateriaPrima.edtMateriaEnter(Sender: TObject);
begin
  if not Assigned(FMateriaPrima) then
  begin
    if edtCodigo.AsInteger > 0 then
      buscaMateriaPrima
    else
      btnBusca.Click;
  end;

  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaMateriaPrima.btnBuscaClick(Sender: TObject);
begin
  selecionaMateriaPrima;
end;

procedure TBuscaMateriaPrima.edtCodigoChange(Sender: TObject);
begin
  edtMateria.Clear;

  if (self.edtCodigo.AsInteger <= 0) then
    self.limpa;
end;

procedure TBuscaMateriaPrima.SetAdicionaRemove(const Value: String);
begin
  FAdicionaRemove := Value;
end;

procedure TBuscaMateriaPrima.SetProduto(const Value: TProduto);
begin
  FProduto := Value;

  FSQL_DO_GRUPO := 'left join produtos_has_materias phm on (phm.codigo_materia = mp.codigo) '+
                   'left join produtos p                on (p.codigo = phm.codigo_produto)  '+
                   'where p.codigo_grupo = '+IntToStr(FProduto.codigo_grupo)+' AND PHM.ADICIONAL = ''S'' '+
                   'group by mp.codigo, mp.descricao';

  FSQL_DO_PRODUTO := 'left join produtos_has_materias phm on (phm.codigo_materia = mp.codigo) '+
                     'where phm.codigo_produto = '+IntToStr(FProduto.codigo)+' AND PHM.ADICIONAL = ''S'' ';
end;

function TBuscaMateriaPrima.produto_valido(codigo_materia :integer): Boolean;
var repositorio    :TRepositorio;
    codigo_produto :integer;
    Especificacao  :TEspecificacaoProdutosQueContemMateria;
    ProdutosHasMaterias :TObjectList<TProdutoHasMateria>;
    i              :integer;
begin
 try
   result              := false;
   repositorio         := nil;
   Especificacao       := nil;

   repositorio         := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
   Especificacao       := TEspecificacaoProdutosQueContemMateria.Create(codigo_materia);
   ProdutosHasMaterias := repositorio.GetListaPorEspecificacao<TProdutoHasMateria>(Especificacao);

   for i := 0 to ProdutosHasMaterias.Count - 1 do begin
     if (ProdutosHasMaterias.Items[i] as TProdutoHasMateria).produto.codigo_grupo = self.FProduto.codigo_grupo then begin
       result := true;
       break;
     end;
   end;

 finally
   FreeAndNil(repositorio);
   FreeAndNil(Especificacao);
   ProdutosHasMaterias.Free;
 end;
end;

end.
