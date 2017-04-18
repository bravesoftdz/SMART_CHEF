unit frameBuscaCFOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, CFOP, Especificacao,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaCFOP = class(TFrame)
    edtCodigo: TCurrencyEdit;
    StaticText1: TStaticText;
    edtCFOP: TEdit;
    btnBusca: TBitBtn;
    edtDescricao: TEdit;
    StaticText2: TStaticText;
    procedure edtCFOPChange(Sender: TObject);
    procedure edtCFOPEnter(Sender: TObject);
    procedure edtCFOPExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtDescricaoEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure edtCFOPKeyPress(Sender: TObject; var Key: Char);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FCFOP             :TCFOP;
    Fcodigo           :integer;
    FEspecificacao: TEspecificacao;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar    (const CodigoCFOP :Integer);
    procedure SetCFOP   (const Value        :TCFOP);

    function buscaPorEspecificacao(codigoCFOP :String) :Integer;
    procedure SetEspecificacao(const Value: TEspecificacao);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property CFOP             :TCFOP          read FCFOP           write SetCFOP;
    property codigo           :integer        read Fcodigo         write SetCodigo;
    property Especificacao    :TEspecificacao read FEspecificacao  write SetEspecificacao;
  end;

implementation

uses Repositorio, FabricaRepositorio, uCadastroCFOP, EspecificacaoCFOPporCodigoCFOP;

{$R *.dfm}

{ TBuscaCFOP }

procedure TBuscaCFOP.btnBuscaClick(Sender: TObject);
begin
  self.Buscar(0);
end;

function TBuscaCFOP.buscaPorEspecificacao(codigoCFOP: String): Integer;
var especificao :TEspecificacaoCFOPporCodigoCFOP;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
  especificao := TEspecificacaoCFOPporCodigoCFOP.Create(codigoCFOP);

  try
    result      := TCFOP(repositorio.GetPorEspecificacao(especificao)).codigo;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaCFOP.Buscar(const CodigoCFOP: Integer);
var
  Repositorio :TRepositorio;
  CFOP     :TCFOP;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TCFOP.ClassName);
     CFOP         := TCFOP(Repositorio.Get(CodigoCFOP));

     { Se tiver setado especificação pra esse frame então o objeto DEVE atender a especificação }
     if Assigned(CFOP)                               and
        Assigned(self.FEspecificacao)                    and
       (not self.FEspecificacao.SatisfeitoPor(CFOP)) then
      FreeAndNil(CFOP);

     if not Assigned(CFOP) then begin
       frmCadastroCFOP := nil;

       try
         frmCadastroCFOP := TfrmCadastroCFOP.CreateModoBusca(nil);
         frmCadastroCFOP.ShowModal;

         if (frmCadastroCFOP.ModalResult = mrOK) then begin
            CFOP          := TCFOP(Repositorio.Get(frmCadastroCFOP.cdsCODIGO.AsInteger));

            if Assigned(CFOP) then begin
              self.CFOP := CFOP;
              self.FCriou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtDescricao.Text = '' then
             self.Limpa;
           edtCFOP.SetFocus;
         end;
       finally
         frmCadastroCFOP.Release;
         frmCadastroCFOP := nil;
       end;
     end
     else begin
       self.CFOP := CFOP;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaCFOP.Create(AOwner: TComponent);
begin
  inherited;
  self.FCFOP  := nil;
  self.FCriou    := false;
  self.FEspecificacao    := nil;
end;

destructor TBuscaCFOP.Destroy;
begin
  if self.FCriou and Assigned(self.FCFOP) then
    FreeAndNil(self.FCFOP);
  FreeAndNil(self.FEspecificacao);

  inherited;
end;

procedure TBuscaCFOP.edtCFOPChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaCFOP.edtCFOPEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaCFOP.edtCFOPExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaCFOP.edtCFOPKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TBuscaCFOP.edtDescricaoEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaCFOP.edtDescricaoExit(Sender: TObject);
begin
   self.Buscar( buscaPorEspecificacao(edtCFOP.Text) );
end;

procedure TBuscaCFOP.Limpa;
begin
   if Self.FCriou and Assigned(self.FCFOP) then
      FreeAndNil(self.FCFOP);

   self.edtCodigo.Clear;
   if not FBuscando then
   begin
     edtCFOP.OnChange := nil;
     self.edtCFOP.Clear;
     edtCFOP.OnChange := edtCFOPChange;
   end;

   self.edtDescricao.Clear;
end;

procedure TBuscaCFOP.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaCFOP.SetEspecificacao(const Value: TEspecificacao);
begin
  if Assigned(self.FEspecificacao) and Assigned(Value) then
    FreeAndNil(self.FEspecificacao);

  FEspecificacao := Value;
end;

procedure TBuscaCFOP.SetCFOP(const Value: TCFOP);
begin
   try
     if (Value = self.FCFOP) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FCFOP) then begin
      FreeAndNil(self.FCFOP);
      self.FCriou := false;
   end;

   FCFOP := Value;

  if Assigned(self.FCFOP) then begin
    self.edtCFOP.OnChange    := nil;
    self.edtCodigo.AsInteger := self.FCFOP.codigo;
    self.edtCFOP.Text        := self.FCFOP.cfop;
    self.edtDescricao.Text   := self.FCFOP.descricao;
    self.edtCFOP.OnChange    := edtCFOPChange;
  end;
end;

end.
