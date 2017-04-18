unit frameBuscaFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, frameBuscaPessoa, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaFornecedor = class(TBuscaPessoa)
  protected
    procedure Buscar    (const codigoPessoa :Integer); override;
  end;

var
  BuscaFornecedor: TBuscaFornecedor;

implementation

uses repositorio, Fornecedor, fabricaRepositorio, uCadastroFornecedor;

{$R *.dfm}

{ TBuscaPessoa1 }

procedure TBuscaFornecedor.Buscar(const codigoPessoa: Integer);
var
  Repositorio :TRepositorio;
  Fornecedor  :TFornecedor;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
     Fornecedor         := TFornecedor(Repositorio.Get(codigoPessoa));

     if not Assigned(Fornecedor) then begin
       frmCadastroFornecedor := nil;

       try
         frmCadastroFornecedor := TfrmCadastroFornecedor.CreateModoBusca(nil);
         frmCadastroFornecedor.ShowModal;

         if (frmCadastroFornecedor.ModalResult = mrOK) then begin
            Fornecedor  := TFornecedor(Repositorio.Get(frmCadastroFornecedor.cdsCODIGO.AsInteger));

            if Assigned(Fornecedor) then begin
              self.Pessoa := Fornecedor;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtNome.Text = '' then
             self.Limpa;
           edtCodigo.SetFocus;
         end;
       finally
         frmCadastroFornecedor.Release;
         frmCadastroFornecedor := nil;
       end;
     end
     else begin
       self.Pessoa  := Fornecedor;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
