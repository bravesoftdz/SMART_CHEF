unit frameBuscaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameBuscaPessoa, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaCliente = class(TBuscaPessoa)
  private
    FSemConsumidor: Boolean;

  protected
    procedure Buscar    (const codigoPessoa :Integer); override;
  public
    property semConsumidor :Boolean read FSemConsumidor write FSemConsumidor;
  end;

var
  BuscaCliente: TBuscaCliente;

implementation

uses repositorio, Cliente, fabricaRepositorio, uCadastroCliente;

{$R *.dfm}

{ TBuscaCliente }

procedure TBuscaCliente.Buscar(const codigoPessoa: Integer);
var
  Repositorio :TRepositorio;
  Cliente     :TCliente;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
     Cliente         := TCliente(Repositorio.Get(codigoPessoa));

     if not Assigned(Cliente) then begin
       frmCadastroCliente := nil;

       try
         frmCadastroCliente := TfrmCadastroCliente.CreateModoBusca(nil);
         frmCadastroCliente.ShowModal;

         if (frmCadastroCliente.ModalResult = mrOK) then begin
            Cliente  := TCliente(Repositorio.Get(frmCadastroCliente.cdsCODIGO.AsInteger));

            if Assigned(Cliente) then begin
              self.Pessoa := Cliente;
              //self.Criou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtNome.Text = '' then
             self.Limpa;
           edtCodigo.SetFocus;
         end;
       finally
         frmCadastroCliente.Release;
         frmCadastroCliente := nil;
       end;
     end
     else begin
       self.Pessoa  := Cliente;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
