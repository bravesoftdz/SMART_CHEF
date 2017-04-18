unit frameBuscaNotaFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, NotaFiscal,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaNotaFiscal = class(TFrame)
    StaticText1: TStaticText;
    edtNrNota: TCurrencyEdit;
    btnBusca: TBitBtn;
    StaticText2: TStaticText;
    edtID: TEdit;
    procedure edtNrNotaChange(Sender: TObject);
    procedure edtNrNotaEnter(Sender: TObject);
    procedure edtNrNotaExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtIDEnter(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FNotaFiscal       :TNotaFiscal;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar;
    procedure SetNotaFiscal(const Value     :TNotaFiscal);

    function buscaPorEspecificacao(NrNota: Integer) :Integer;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;
    procedure mostrar(codigoNF :integer);

  public
    property NotaFiscal   :TNotaFiscal  read FNotaFiscal  write SetNotaFiscal;
    property codigo       :integer      read Fcodigo      write SetCodigo;
  end;

implementation

uses Repositorio, FabricaRepositorio, EspecificacaoNFePorNrNota, uPesquisaSimples;

{$R *.dfm}

{ TBuscaNotaFiscal }

procedure TBuscaNotaFiscal.btnBuscaClick(Sender: TObject);
begin
    self.mostrar(buscaPorEspecificacao(StrToIntDef(self.edtNrNota.Text, 0)));
    if not assigned(FNotaFiscal) then
      Buscar;
end;

function TBuscaNotaFiscal.buscaPorEspecificacao(NrNota: Integer): Integer;
var especificao :TEspecificacaoNFePorNrNota;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
  especificao := TEspecificacaoNFePorNrNota.Create(NrNota);

  try
    result      := TNotaFiscal(repositorio.GetPorEspecificacao(especificao)).CodigoNotaFiscal;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaNotaFiscal.Buscar;
begin
  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select nf.codigo, nf.numero_nota_fiscal, forn.razao Fornecedor, tnf.total - tnf.subst_tributaria total from notas_fiscais nf '+
                                                        ' left join pessoas forn on forn.codigo = nf.codigo_emitente '+
                                                        ' left join totais_notas_fiscais tnf on tnf.codigo_nota_fiscal = nf.codigo '+
                                                        ' where nf.entrada_saida = ''E'' ',
                                                        'numero_nota_fiscal', 'Selecione a NF desejada...');

  if frmPesquisaSimples.ShowModal = mrOk then
    mostrar(buscaPorEspecificacao(frmPesquisaSimples.cds_retorno.Fields[0].AsInteger) );

  frmPesquisaSimples.Release;
end;

constructor TBuscaNotaFiscal.Create(AOwner: TComponent);
begin
  inherited;
  self.FNotaFiscal := nil;
  self.FCriou      := false;
end;

destructor TBuscaNotaFiscal.Destroy;
begin
  if self.FCriou and Assigned(self.FNotaFiscal) then
    FreeAndNil(self.FNotaFiscal);

  inherited;
end;

procedure TBuscaNotaFiscal.edtIDEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaNotaFiscal.edtIDExit(Sender: TObject);
begin
   self.mostrar( buscaPorEspecificacao(edtNrNota.AsInteger) );
end;

procedure TBuscaNotaFiscal.edtNrNotaChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaNotaFiscal.edtNrNotaEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaNotaFiscal.edtNrNotaExit(Sender: TObject);
begin
  self.FBuscando := false;
  if edtNrNota.Text <> '' then
    self.mostrar( buscaPorEspecificacao(edtNrNota.AsInteger) )
  else
    Buscar;
end;

procedure TBuscaNotaFiscal.Limpa;
begin
   if Self.FCriou and Assigned(self.FNotaFiscal) then
      FreeAndNil(self.FNotaFiscal);

   if not FBuscando then
   begin
     edtNrNota.OnChange := nil;
     self.edtNrNota.Clear;
     edtNrNota.OnChange := edtNrNotaChange;
   end;

   self.edtID.Clear;
end;

procedure TBuscaNotaFiscal.mostrar(codigoNF: integer);
var repositorio :TRepositorio;
begin
  if codigoNF = 0 then
    Limpa;
  repositorio := nil;
  if assigned(FNotaFiscal) then
    FreeAndNil(FNotaFiscal);

  try
    repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
    NotaFiscal  := TNotaFiscal(repositorio.Get(codigoNF));
  finally
    FreeAndNil(repositorio);
  end;
end;

procedure TBuscaNotaFiscal.SetCodigo(const Value: integer);
begin
  if value > 0 then
    mostrar( self.buscaPorEspecificacao(Value) )
  else
    self.Limpa;
end;

procedure TBuscaNotaFiscal.SetNotaFiscal(const Value: TNotaFiscal);
begin
   try
     if (Value = self.FNotaFiscal) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FNotaFiscal) then begin
      FreeAndNil(self.FNotaFiscal);
      self.FCriou := false;
   end;

   FNotaFiscal := Value;

  if Assigned(self.FNotaFiscal) then begin
    self.edtNrNota.OnChange  := nil;
    self.edtNrNota.AsInteger := self.FNotaFiscal.NumeroNotaFiscal;
    self.edtID.Text          := self.FNotaFiscal.ChaveAcesso;
    self.edtNrNota.OnChange  := edtNrNotaChange;
  end;
end;

end.
