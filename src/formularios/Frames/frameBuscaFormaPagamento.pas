unit frameBuscaFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormaPagamento, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaFormaPagamento = class(TFrame)
    edtCodigo: TCurrencyEdit;
    edtDescricao: TEdit;
    StaticText2: TStaticText;
    btnBusca: TBitBtn;
    StaticText1: TStaticText;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtDescricaoEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FFormaPagamento   :TFormaPagamento;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    FAposEncontrarObjeto: TNotifyEvent;
    procedure Buscar           (const CodigoFPgto :Integer);
    procedure SetFormaPagamento(const Value        :TFormaPagamento);
    procedure SetAposEncontrarObjeto(const Value: TNotifyEvent);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property FormaPagamento   :TFormaPagamento  read FFormaPagamento   write SetFormaPagamento;
    property codigo           :integer          read Fcodigo           write SetCodigo;
    property AposEncontrarObjeto :TNotifyEvent read FAposEncontrarObjeto write SetAposEncontrarObjeto;
  end;

implementation

uses Repositorio, FabricaRepositorio, uCadastroFormaPagamento;

{$R *.dfm}

{ TFrame1 }

procedure TBuscaFormaPagamento.btnBuscaClick(Sender: TObject);
begin
  self.Buscar(0);
end;

procedure TBuscaFormaPagamento.Buscar(const CodigoFPgto: Integer);
var
  Repositorio :TRepositorio;
  FormaPgto :TFormaPagamento;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TFormaPagamento.ClassName);
     FormaPgto         := TFormaPagamento(Repositorio.Get(CodigoFPgto));

     if not Assigned(FormaPgto) then begin
       frmCadastroFormaPagamento := nil;

       try
         frmCadastroFormaPagamento := TfrmCadastroFormaPagamento.CreateModoBusca(nil);
         frmCadastroFormaPagamento.ShowModal;

         if (frmCadastroFormaPagamento.ModalResult = mrOK) then begin
            FormaPgto          := TFormaPagamento(Repositorio.Get(frmCadastroFormaPagamento.cdsCODIGO.AsInteger));

            if Assigned(FormaPgto) then begin
              self.FormaPagamento := FormaPgto;
              self.FCriou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtDescricao.Text = '' then
             self.Limpa;
           edtCodigo.SetFocus;
         end;
       finally
         frmCadastroFormaPagamento.Release;
         frmCadastroFormaPagamento := nil;
       end;
     end
     else begin
       self.FormaPagamento := FormaPgto;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaFormaPagamento.Create(AOwner: TComponent);
begin
  inherited;
  self.FFormaPagamento  := nil;
  self.FCriou    := false;
end;

destructor TBuscaFormaPagamento.Destroy;
begin
  if self.FCriou and Assigned(self.FFormaPagamento) then
    FreeAndNil(self.FFormaPagamento);

  inherited;
end;

procedure TBuscaFormaPagamento.edtCodigoChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaFormaPagamento.edtCodigoEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaFormaPagamento.edtCodigoExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaFormaPagamento.edtDescricaoEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaFormaPagamento.edtDescricaoExit(Sender: TObject);
begin
  self.Buscar( edtCodigo.AsInteger );
end;

procedure TBuscaFormaPagamento.Limpa;
begin
   if Self.FCriou and Assigned(self.FFormaPagamento) then
      FreeAndNil(self.FFormaPagamento);

   self.edtCodigo.Clear;
   if not FBuscando then
   begin
     edtCodigo.OnChange := nil;
     edtcodigo.OnChange := edtCodigoChange;
   end;

   self.edtDescricao.Clear;
end;

procedure TBuscaFormaPagamento.SetAposEncontrarObjeto(const Value: TNotifyEvent);
begin
  FAposEncontrarObjeto := Value;
end;

procedure TBuscaFormaPagamento.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaFormaPagamento.SetFormaPagamento(const Value: TFormaPagamento);
begin
   try
     if (Value = self.FFormaPagamento) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FFormaPagamento) then begin
      FreeAndNil(self.FFormaPagamento);
      self.FCriou := false;
   end;

   FFormaPagamento := Value;

  if Assigned(self.FFormaPagamento) then begin
    self.edtCodigo.OnChange    := nil;
    self.edtCodigo.AsInteger   := self.FFormaPagamento.codigo;
    self.edtDescricao.Text     := self.FFormaPagamento.descricao;
    self.edtCodigo.OnChange    := edtCodigoChange;

    if Assigned(self.FAposEncontrarObjeto) then
      self.FAposEncontrarObjeto(self.FFormaPagamento);
  end;
end;

end.
