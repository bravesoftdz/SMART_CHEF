unit uDadosPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Pessoa,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameMaskCpfCnpj, RxToolEdit, RxCurrEdit, Vcl.Mask, frameBuscaCidade, Vcl.StdCtrls, frameFone;

type
  TfrmDadosPessoa = class(TForm)
    gpbEndereco: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    BuscaCidade1: TBuscaCidade;
    edtComplento: TEdit;
    edtCEP: TMaskEdit;
    edtCodigoEndereco: TCurrencyEdit;
    GroupBox1: TGroupBox;
    lbRgIe: TLabel;
    edtIe: TEdit;
    edtFantasia: TEdit;
    Label2: TLabel;
    CpfCnpj: TMaskCpfCnpj;
    Fone1: TFone;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure carregaDados(pessoa :TPessoa);
  public
    constructor Create(Aowner :TComponent; pessoa :TPessoa; titulo :String);overload;
  end;

var
  frmDadosPessoa: TfrmDadosPessoa;

implementation

{$R *.dfm}

uses Endereco;

{ TfrmDadosPessoa }

procedure TfrmDadosPessoa.carregaDados(pessoa: TPessoa);
begin
  edtFantasia.Text    := pessoa.NomeFantasia;
  CpfCnpj.pessoa      := pessoa.pessoa;
  CpfCnpj.edtCpf.Text := pessoa.cpf_cnpj;
  edtIe.Text          := pessoa.rg_ie;
  Fone1.Fone          := pessoa.fone1;
  edtLogradouro.Text  := pessoa.Enderecos[0].logradouro;
  edtNumero.Text      := pessoa.Enderecos[0].numero;
  edtBairro.Text      := pessoa.Enderecos[0].bairro;
  edtCEP.Text         := pessoa.Enderecos[0].cep;
  BuscaCidade1.codCid := intToStr(pessoa.Enderecos[0].Cidade.codibge);
  edtComplento.Text   := pessoa.Enderecos[0].referencia;
end;

constructor TfrmDadosPessoa.Create(Aowner: TComponent; pessoa: TPessoa; titulo :String);
begin
  inherited Create(Aowner);
  self.Caption := '  '+titulo;
  carregaDados(pessoa);
end;

procedure TfrmDadosPessoa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Escape then
    self.Close;
end;

end.
