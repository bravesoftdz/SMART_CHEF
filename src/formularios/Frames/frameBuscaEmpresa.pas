unit frameBuscaEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameBuscaPessoa, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaEmpresa = class(TBuscaPessoa)
  protected
    procedure Buscar    (const codigoPessoa :Integer); override;
  public
    { Public declarations }
  end;

var
  BuscaEmpresa: TBuscaEmpresa;

implementation

uses repositorio, Empresa, fabricaRepositorio, uCadastroEmpresa;

{$R *.dfm}

{ TBuscaPessoa1 }

procedure TBuscaEmpresa.Buscar(const codigoPessoa: Integer);
var
  Repositorio :TRepositorio;
  Empresa     :TEmpresa;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
     Empresa         := TEmpresa(Repositorio.Get(codigoPessoa));

     if not Assigned(Empresa) then begin
       frmCadastroEmpresa := nil;

       try
         frmCadastroEmpresa := TfrmCadastroEmpresa.CreateModoBusca(nil);
         frmCadastroEmpresa.ShowModal;

         if (frmCadastroEmpresa.ModalResult = mrOK) then begin
            Empresa  := TEmpresa(Repositorio.Get(frmCadastroEmpresa.cdsCODIGO.AsInteger));

            if Assigned(Empresa) then begin
              self.Pessoa := Empresa;
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
         frmCadastroEmpresa.Release;
         frmCadastroEmpresa := nil;
       end;
     end
     else begin
       self.Pessoa  := Empresa;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
