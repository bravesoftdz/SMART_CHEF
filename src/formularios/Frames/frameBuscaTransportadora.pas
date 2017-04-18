unit frameBuscaTransportadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameBuscaPessoa, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaTransportadora = class(TBuscaPessoa)
  protected
    procedure Buscar    (const codigoPessoa :Integer); override;
  public
    { Public declarations }
  end;

var
  BuscaTransportadora: TBuscaTransportadora;

implementation

uses repositorio, Transportadora, fabricaRepositorio, uCadastroTransportadora;

{$R *.dfm}

{ TBuscaTransportadora }

procedure TBuscaTransportadora.Buscar(const codigoPessoa: Integer);
var
  Repositorio    :TRepositorio;
  Transportadora :TTransportadora;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TTransportadora.ClassName);
     Transportadora         := TTransportadora(Repositorio.Get(codigoPessoa));

     if not Assigned(Transportadora) then begin
       frmCadastroTransportadora := nil;

       try
         frmCadastroTransportadora := TfrmCadastroTransportadora.CreateModoBusca(nil);
         frmCadastroTransportadora.ShowModal;

         if (frmCadastroTransportadora.ModalResult = mrOK) then begin
            Transportadora  := TTransportadora(Repositorio.Get(frmCadastroTransportadora.cdsCODIGO.AsInteger));

            if Assigned(Transportadora) then begin
              self.Pessoa := Transportadora;
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
         frmCadastroTransportadora.Release;
         frmCadastroTransportadora := nil;
       end;
     end
     else begin
       self.Pessoa  := Transportadora;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
