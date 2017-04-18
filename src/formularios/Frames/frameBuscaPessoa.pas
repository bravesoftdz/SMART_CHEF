unit frameBuscaPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Pessoa,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaPessoa = class(TFrame)
    StaticText1: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtNome: TEdit;
    StaticText2: TStaticText;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtNomeEnter(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);

  protected
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FPessoa           :TPessoa;
    Fcodigo           :integer;


  private
    FAposEncontrarObjeto: TNotifyEvent;
    procedure SetCodigo         (const Value: integer);
    procedure SetAposEncontrarObjeto(const Value: TNotifyEvent);

  protected
    procedure Buscar    (const codigoPessoa :Integer); virtual;
    procedure SetPessoa (const Value      :TPessoa);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property Pessoa  :TPessoa      read FPessoa           write SetPessoa;
    property codigo  :integer      read Fcodigo           write SetCodigo;
    property AposEncontrarObjeto :TNotifyEvent read FAposEncontrarObjeto write SetAposEncontrarObjeto;
  end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TBuscaPessoa }

procedure TBuscaPessoa.btnBuscaClick(Sender: TObject);
begin
    self.Buscar(0);
    keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TBuscaPessoa.Buscar(const codigoPessoa: Integer);
begin

end;

constructor TBuscaPessoa.Create(AOwner: TComponent);
begin
  inherited;
  self.FPessoa   := nil;
  self.FCriou    := false;
end;

destructor TBuscaPessoa.Destroy;
begin
  if self.FCriou and Assigned(self.FPessoa) then
    FreeAndNil(self.FPessoa);
  inherited;
end;

procedure TBuscaPessoa.edtCodigoChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaPessoa.edtCodigoEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaPessoa.edtCodigoExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaPessoa.edtNomeEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaPessoa.edtNomeExit(Sender: TObject);
begin
   self.Buscar( edtCodigo.AsInteger );
end;

procedure TBuscaPessoa.Limpa;
begin
   if Self.FCriou and Assigned(self.FPessoa) then
      FreeAndNil(self.FPessoa);

   if not FBuscando then
   begin
     edtCodigo.OnChange := nil;
     self.edtCodigo.Clear;
     edtCodigo.OnChange := edtCodigoChange;
   end;

   self.edtNome.Clear;
end;

procedure TBuscaPessoa.SetAposEncontrarObjeto(const Value: TNotifyEvent);
begin
  FAposEncontrarObjeto := Value;
end;

procedure TBuscaPessoa.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaPessoa.SetPessoa(const Value: TPessoa);
begin
   try
     if (Value = self.FPessoa) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FPessoa) then begin
      FreeAndNil(self.FPessoa);
      self.FCriou := false;
   end;

   FPessoa := Value;

  if Assigned(self.FPessoa) then begin
    self.edtCodigo.OnChange    := nil;
    self.edtCodigo.AsInteger   := self.FPessoa.codigo;
    self.edtNome.Text          := self.FPessoa.razao;
    self.edtCodigo.OnChange    := edtCodigoChange;

    if Assigned(self.FAposEncontrarObjeto) then
      self.FAposEncontrarObjeto(self.FPessoa);
  end;
end;

end.
