unit uCadastroTransportadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, contnrs, frameFone, RxToolEdit, RxCurrEdit, Vcl.Mask, frameBuscaCidade, frameMaskCpfCnpj,
  Vcl.Imaging.pngimage;

type
  TfrmCadastroTransportadora = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsRAZAO: TStringField;
    cdsFANTASIA: TStringField;
    cdsCPF_CNPJ: TStringField;
    cdsENDERECO: TStringField;
    cdsCIDADE: TStringField;
    cdsFONE: TStringField;
    cdsCELULAR: TStringField;
    gpbDados: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lbRgIe: TLabel;
    Label33: TLabel;
    lbIE: TLabel;
    Label17: TLabel;
    edtRazao: TEdit;
    edtFantasia: TEdit;
    CpfCnpj: TMaskCpfCnpj;
    edtDataCadastro: TEdit;
    edtIe: TEdit;
    gpbEndereco: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    BuscaCidade1: TBuscaCidade;
    edtComplento: TEdit;
    edtCEP: TMaskEdit;
    edtCodigoEndereco: TCurrencyEdit;
    gpbContato: TGroupBox;
    Fone1: TFone;
    Fone2: TFone;
    gpbEmail: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    DBGrid1: TDBGrid;
    btnCancela: TBitBtn;
    edtEmail: TEdit;
    btnConfirma: TBitBtn;
    edtCodigo: TCurrencyEdit;
    dsEmails: TDataSource;
    cdsEmails: TClientDataSet;
    cdsEmailsEMAIL: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;

  private
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;
  private
    function concatenaEmails :String;
    procedure carregaEmails(emails :String);
  end;

var
  frmCadastroTransportadora: TfrmCadastroTransportadora;

implementation

uses Pessoa, Transportadora, repositorio, fabricaRepositorio, funcoes, Endereco, Cidade;

{$R *.dfm}

{ TfrmCadastroTransportadora }

procedure TfrmCadastroTransportadora.AlterarRegistroNoCDS(Registro: TObject);
var
  Transportadora :TPessoa;
begin
  inherited;

  Transportadora := (Registro as TPessoa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Transportadora.codigo;
  self.cdsRAZAO.AsString        := Transportadora.razao;
  self.cdsFANTASIA.AsString     := Transportadora.NomeFantasia;
  self.cdsCPF_CNPJ.AsString     := Transportadora.cpf_cnpj;
  self.cdsENDERECO.AsString     := Transportadora.Enderecos[0].logradouro + ', '+ Transportadora.Enderecos[0].numero;
  self.cdsCIDADE.AsString       := Transportadora.Enderecos[0].Cidade.nome + ' / '+Transportadora.Enderecos[0].Cidade.Estado.sigla;
  self.cdsFONE.AsString         := Transportadora.fone1;
  self.cdsCELULAR.AsString      := Transportadora.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroTransportadora.carregaEmails(emails: String);
begin
  while emails <> '' do begin
    cdsEmails.Append;
    cdsEmailsEMAIL.AsString := copy( emails, 1, ( pos( ';', emails ) -1 ) );
    cdsEmails.Post;

    emails := trim( copy( emails, (pos(';',emails) +1), length(emails) ) );
  end;
end;

procedure TfrmCadastroTransportadora.CarregarDados;
var
  Transportadoras :TObjectList;
  Repositorio  :TRepositorio;
  nX           :Integer;
begin
  inherited;

  Repositorio := nil;
  Transportadoras    := nil;

  try
    Repositorio     := TFabricaRepositorio.GetRepositorio(TTransportadora.ClassName);
    Transportadoras    := Repositorio.GetAll;

    if Assigned(Transportadoras) and (Transportadoras.Count > 0) then begin

       for nX := 0 to (Transportadoras.Count-1) do
         self.IncluirRegistroNoCDS(Transportadoras.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Transportadoras);
  end;
end;

function TfrmCadastroTransportadora.concatenaEmails: String;
begin
  Result := '';

  if not (cdsEmails.Active) or (cdsEmails.IsEmpty) then
    exit;

  cdsEmails.First;
  while not cdsEmails.Eof do begin
    Result := Result + cdsEmailsEMAIL.AsString + ';';

    cdsemails.Next;
  end;
end;

procedure TfrmCadastroTransportadora.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroTransportadora.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroTransportadora.FormCreate(Sender: TObject);
begin
  inherited;
  CpfCnpj.pessoa := 'J';
  cdsEmails.CreateDataSet;
end;

function TfrmCadastroTransportadora.GravarDados: TObject;
var
  Transportadora :TTransportadora;
  Repositorio    :TRepositorio;
begin
   Transportadora := nil;
   Repositorio    := nil;

   try
     Repositorio    := TFabricaRepositorio.GetRepositorio(TTransportadora.ClassName);
     Transportadora := TTransportadora(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Transportadora) then
      Transportadora := TTransportadora.Create;

     Transportadora.razao                  := self.edtRazao.Text;
     Transportadora.NomeFantasia           := edtFantasia.Text;
     Transportadora.pessoa                 := CpfCnpj.pessoa;
     Transportadora.cpf_cnpj               := CpfCnpj.edtCpf.Text;
     Transportadora.rg_ie                  := edtIe.Text;
     Transportadora.dtcadastro             := StrToDate(edtDataCadastro.Text);
     Transportadora.fone1                  := Fone1.Fone;
     Transportadora.fone2                  := Fone2.Fone;
     Transportadora.email                  := concatenaEmails;

     { Endereço }
     Transportadora.Enderecos.Add(TEndereco.Create);

     Transportadora.Enderecos[0].codigo         := edtCodigoEndereco.AsInteger;
     Transportadora.Enderecos[0].codigo_pessoa  := edtCodigo.AsInteger;
     Transportadora.Enderecos[0].cep            := edtCEP.Text;
     Transportadora.Enderecos[0].logradouro     := edtLogradouro.Text;
     Transportadora.Enderecos[0].numero         := edtNumero.Text;
     Transportadora.Enderecos[0].referencia     := edtComplento.Text;
     Transportadora.Enderecos[0].bairro         := edtBairro.Text;
     Transportadora.Enderecos[0].codigo_cidade  := BuscaCidade1.CodigoMunicipio;
     Transportadora.Enderecos[0].uf             := BuscaCidade1.edtUF.Text;

     Repositorio.Salvar(Transportadora);

     result := Transportadora;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroTransportadora.IncluirRegistroNoCDS(Registro: TObject);
var
  Transportadora :TPessoa;
begin
  inherited;

  Transportadora := (Registro as TPessoa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := Transportadora.codigo;
  self.cdsRAZAO.AsString        := Transportadora.razao;
  self.cdsFANTASIA.AsString     := Transportadora.NomeFantasia;
  self.cdsCPF_CNPJ.AsString     := Transportadora.cpf_cnpj;

  if assigned(Transportadora.Enderecos[0]) then
  begin
    self.cdsENDERECO.AsString     := Transportadora.Enderecos[0].logradouro + ', '+ Transportadora.Enderecos[0].numero;
    self.cdsCIDADE.AsString       := Transportadora.Enderecos[0].Cidade.nome + ' / '+Transportadora.Enderecos[0].Cidade.Estado.sigla;
  end;
  self.cdsFONE.AsString         := Transportadora.fone1;
  self.cdsCELULAR.AsString      := Transportadora.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroTransportadora.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtRazao.Clear;
  edtFantasia.Clear;
  CpfCnpj.edtCpf.Clear;
  edtIe.Clear;
  edtDataCadastro.Text := DateToStr(Date);
  Fone1.limpa;
  Fone2.limpa;
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  BuscaCidade1.limpa;
  edtCEP.Clear;
  edtComplento.Clear;
  btnCancela.Click;
  cdsEmails.EmptyDataSet;
end;

procedure TfrmCadastroTransportadora.MostrarDados;
var
  Transportadora                      :TPessoa;
  RepositorioPessoa                   :TRepositorio;
begin
  inherited;

  Transportadora                      := nil;
  RepositorioPessoa                   := nil;

  try
    RepositorioPessoa  := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);
    Transportadora     := TPessoa(RepositorioPessoa.Get(self.ds.DataSet.FieldByName('CODIGO').AsInteger));//*f Transportadora     := TPessoa(RepositorioPessoa.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Transportadora) then exit;

    edtCodigo.AsInteger         := Transportadora.codigo;
    edtRazao.Text               := Transportadora.razao;
    edtFantasia.Text            := Transportadora.NomeFantasia;
    CpfCnpj.pessoa              := Transportadora.pessoa;
    CpfCnpj.edtCpf.Text         := Transportadora.cpf_cnpj;
    edtIe.Text                  := Transportadora.rg_ie;
    edtDataCadastro.Text        := DateToStr(Transportadora.dtcadastro);
    Fone1.Fone                  := Transportadora.fone1;
    Fone2.Fone                  := Transportadora.fone2;
    carregaEmails(Transportadora.email);

    {Endereco}
    if Assigned(Transportadora.Enderecos[0]) then
    begin
      edtCodigoEndereco.AsInteger  := Transportadora.Enderecos[0].codigo;
      edtLogradouro.Text           := Transportadora.Enderecos[0].logradouro;
      edtNumero.Text               := Transportadora.Enderecos[0].numero;
      edtBairro.Text               := Transportadora.Enderecos[0].bairro;
      edtCEP.Text                  := Transportadora.Enderecos[0].cep;
      BuscaCidade1.codCid          := intToStr(Transportadora.Enderecos[0].codigo_cidade);
      edtComplento.Text            := Transportadora.Enderecos[0].referencia;
    end;

  finally
    FreeAndNil(RepositorioPessoa);
    FreeAndNil(Transportadora);
  end;
end;

procedure TfrmCadastroTransportadora.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.TabIndex = 1 then //*f
    MostrarDados;
end;

function TfrmCadastroTransportadora.VerificaDados: Boolean;
begin
  if trim(edtRazao.Text) = '' then begin
    avisar('Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10);
    edtRazao.SetFocus;
  end
  else if apenasNumeros(CpfCnpj.edtCpf.Text) = '' then begin
    avisar('Favor informar a razão social da empresa.');
    CpfCnpj.edtCpf.SetFocus;
  end
  else if (CpfCnpj.pessoa = 'J') and (apenasNumeros(edtIe.Text) = '') then begin
    avisar('Favor informar a inscrição estadual.');
    edtIe.SetFocus;
  end
  else if edtLogradouro.Text = '' then begin
    avisar('Favor informar a Rua/Logradouro.');
    edtLogradouro.SetFocus;
  end
  else if edtNumero.Text = '' then begin
    avisar('Favor informar o Número.');
    edtNumero.SetFocus;
  end
  else if edtBairro.Text = '' then begin
    avisar('Favor informar o Bairro.');
    edtBairro.SetFocus;
  end
  else if BuscaCidade1.edtCidade.Text = '' then begin
    avisar('Favor informar a Cidade.');
    BuscaCidade1.edtCodCid.SetFocus;
  end
  else
    result := true;

end;

end.
