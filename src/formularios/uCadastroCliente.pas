unit uCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, frameBuscaCidade, Mask, frameMaskCpfCnpj,
  StdCtrls, DB, DBClient, Grids, DBGrids, DBGridCBN, ComCtrls, pngimage,
  ExtCtrls, Buttons, contnrs;

type
  TStatusEndereco = (Inserindo, Alterando, Cancelando, Salvando, Padrao, SemEndereco);

type
  TfrmCadastroCliente = class(TfrmCadastroPadrao)
    edtCodigo: TEdit;
    edtNome: TEdit;
    lblRazao: TLabel;
    cpfCnpj: TMaskCpfCnpj;
    Label19: TLabel;
    cdsNOME: TStringField;
    cdsCPF: TStringField;
    gpbEndereco: TGroupBox;
    gridEnderecos: TDBGrid;
    Shape1: TShape;
    btnAlterarEnd: TSpeedButton;
    btnIncluirEnd: TSpeedButton;
    btnSalvarend: TSpeedButton;
    btnCancelarEnd: TSpeedButton;
    btnDeletarEnd: TSpeedButton;
    pnlEndereco: TPanel;
    BuscaCidade1: TBuscaCidade;
    edtComplemento: TEdit;
    Label5: TLabel;
    edtBairro: TEdit;
    Label6: TLabel;
    edtLogradouro: TEdit;
    Label3: TLabel;
    edtNumero: TEdit;
    Label4: TLabel;
    Label2: TLabel;
    edtcep: TMaskEdit;
    dsEndereco: TDataSource;
    cdsendereco: TClientDataSet;
    cdsenderecoCEP: TStringField;
    cdsenderecologradouro: TStringField;
    cdsenderecobairro: TStringField;
    cdsendereconumero: TStringField;
    cdsenderecoreferencia: TStringField;
    cdsenderecocod_cidade: TIntegerField;
    cdsenderecoCODIGO: TIntegerField;
    cdsenderecoUF: TStringField;
    Label1: TLabel;
    edtFone: TMaskEdit;
    cdsenderecofone: TStringField;
    edtEmail: TEdit;
    Label7: TLabel;
    cdsCODIGO: TIntegerField;
    cdsEndDeletado: TClientDataSet;
    cdsEndDeletadoCOD_END: TIntegerField;
    edtIe: TEdit;
    Label8: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirEndClick(Sender: TObject);
    procedure btnAlterarEndClick(Sender: TObject);
    procedure cdsenderecoAfterScroll(DataSet: TDataSet);
    procedure btnDeletarEndClick(Sender: TObject);
    procedure btnCancelarEndClick(Sender: TObject);
    procedure btnSalvarendClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridEnderecosEnter(Sender: TObject);

  private
    cpf_ao_alterar :String;
    FStatus_endereco :TStatusEndereco;

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
    function cpf_duplicado :Boolean;

    procedure limpa_endereco;
    procedure status_acoes_endereco;
    procedure seta_status(status :TStatusEndereco);
    function endereco_nao_utilizado(cod_endereco :Integer) :boolean;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses Cliente, repositorio, fabricarepositorio, StrUtils, RXCurrEdit, uModulo, funcoes,
  uPadrao, Endereco, Math;

{$R *.dfm}

{ TfrmCadastroPadrao1 }

procedure TfrmCadastroCliente.AlterarRegistroNoCDS(Registro: TObject);
var
  Cliente :TCliente;
begin
  inherited;

  Cliente := TCliente(Registro);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger := Cliente.codigo;
  self.cdsNOME.AsString    := Cliente.Razao;
  self.cdsCPF.AsString     := Cliente.cpf_cnpj;
  self.cds.Post;
end;

procedure TfrmCadastroCliente.CarregarDados;
var
  Clientes    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Clientes    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    Clientes    := Repositorio.GetAll;

    if Assigned(Clientes) and (Clientes.Count > 0) then begin

       for nX := 0 to (Clientes.Count-1) do
         self.IncluirRegistroNoCDS(Clientes.Items[nX]);

    end;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Clientes);
  end;
end;

procedure TfrmCadastroCliente.ExecutarDepoisAlterar;
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadastroCliente.ExecutarDepoisIncluir;
begin
  inherited;
  edtNome.SetFocus;
end;

function TfrmCadastroCliente.GravarDados: TObject;
var
  Cliente      :TCliente;
  Repositorio  :TRepositorio;
  Endereco     :TEndereco;
  Rependereco  :TRepositorio;
  codigo_cli1  :integer;
begin
   Cliente      := nil;
   Repositorio  := nil;
   Endereco     := nil;
   try
     cdsendereco.AfterScroll := nil;
     Repositorio   := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
     Cliente       := TCliente(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Cliente) then
      Cliente := TCliente.Create;

     Cliente.Razao         := self.edtNome.Text;
     Cliente.cpf_cnpj      := self.cpfCnpj.edtCpf.Text;
     Cliente.Pessoa        := self.cpfCnpj.pessoa;
     Cliente.Tipo          := 'C';
     Cliente.RG_IE         := edtIe.Text;
     Cliente.Email         := edtEmail.Text;

     cdsendereco.First;
     while not cdsendereco.Eof do begin
       if Assigned(Cliente.Enderecos) and (cdsenderecoCODIGO.AsInteger = 0) then
         Cliente.Enderecos.Add(TEndereco.Create);

       Cliente.Enderecos[cdsendereco.RecNo-1].codigo         := cdsenderecoCODIGO.AsInteger;
       Cliente.Enderecos[cdsendereco.RecNo-1].codigo_pessoa  := codigo_cli1;
       Cliente.Enderecos[cdsendereco.RecNo-1].cep            := cdsenderecoCEP.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].logradouro     := cdsenderecologradouro.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].numero         := cdsendereconumero.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].referencia     := cdsenderecoreferencia.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].bairro         := cdsenderecobairro.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].codigo_cidade  := cdsenderecocod_cidade.AsInteger;
       Cliente.Enderecos[cdsendereco.RecNo-1].uf             := cdsenderecoUF.AsString;
       Cliente.Enderecos[cdsendereco.RecNo-1].fone           := cdsenderecofone.AsString;
       cdsendereco.Next;
     end;

     Repositorio.Salvar(Cliente);

     codigo_cli1    := cliente.codigo;

     if self.EstadoTela = tetIncluir then begin
       Cliente.codigo := 0;
     end;

     if (dm.ArquivoConfiguracao.CaminhoBancoDeDadosLocal <> '') then
       Repositorio.Salvar_2(Cliente);

     if not cdsEndDeletado.IsEmpty then begin
       cdsEndDeletado.First;
       while not cdsEndDeletado.Eof do begin
         Rependereco.RemoverPorIdentificador(cdsEndDeletadoCOD_END.AsInteger);
         cdsEndDeletado.Next;
       end;
     end;

     result := Cliente;

   finally
     FreeAndNil(Repositorio);
     FreeAndNil(Rependereco);     
     FreeAndNil(Endereco);
     cdsendereco.AfterScroll := cdsenderecoAfterScroll;
   end;
end;

procedure TfrmCadastroCliente.IncluirRegistroNoCDS(Registro: TObject);
var
  Cliente :TCliente;
begin
  inherited;

  Cliente := TCliente(Registro);

  self.cds.Append;
  self.cdsCODIGO.AsInteger   := Cliente.codigo;
  self.cdsNOME.AsString      := Cliente.Razao;
  self.cdsCPF.AsString       := Cliente.cpf_cnpj; 
  self.cds.Post;
end;

procedure TfrmCadastroCliente.LimparDados;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  cpfCnpj.Limpa;
  edtIe.Clear;
  edtcep.Clear;
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtComplemento.Clear;
  edtBairro.Clear;
  edtEmail.Clear;
  BuscaCidade1.limpa;
  cdsendereco.EmptyDataSet;
  cdsEndDeletado.EmptyDataSet;
  limpa_endereco;
  seta_status( Padrao );
end;

procedure TfrmCadastroCliente.MostrarDados;
var
  Cliente      :TCliente;
  Repositorio  :TRepositorio;
  i :integer;
begin
  inherited;

  Cliente      := nil;
  Repositorio  := nil;

  try
    Repositorio  := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    Cliente      := TCliente(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Cliente) then exit;

    edtCodigo.Text              := IntToStr(Cliente.codigo);
    self.edtNome.Text           := Cliente.razao;
    self.cpfCnpj.cpfCnpj        := Cliente.cpf_cnpj;
    self.edtIe.Text             := Cliente.RG_IE;
    self.edtEmail.Text          := Cliente.Email;

    if assigned(Cliente.Enderecos) and (Cliente.Enderecos.count > 0) then begin

      for i := 0 to Cliente.Enderecos.Count - 1 do begin

        cdsendereco.Append;
        cdsenderecoCODIGO.AsInteger     := TEndereco(Cliente.Enderecos.Items[i]).codigo;
        cdsenderecoCEP.AsString         := TEndereco(Cliente.Enderecos.Items[i]).cep;
        cdsenderecologradouro.AsString  := TEndereco(Cliente.Enderecos.Items[i]).logradouro;
        cdsenderecobairro.AsString      := TEndereco(Cliente.Enderecos.Items[i]).bairro;
        cdsendereconumero.AsString      := TEndereco(Cliente.Enderecos.Items[i]).numero;
        cdsenderecoreferencia.AsString  := TEndereco(Cliente.Enderecos.Items[i]).referencia;
        cdsenderecocod_cidade.AsInteger := TEndereco(Cliente.Enderecos.Items[i]).codigo_cidade;
        cdsenderecoUF.AsString          := TEndereco(Cliente.Enderecos.Items[i]).uf;
        cdsenderecofone.AsString        := TEndereco(Cliente.Enderecos.Items[i]).fone;
        cdsendereco.Post;
      end;

      seta_status( Padrao );
    end;

    if cdsendereco.IsEmpty then
      seta_status( SemEndereco );

    status_acoes_endereco;

    cpf_ao_alterar := Cliente.cpf_cnpj;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Cliente);
  end;
end;

function TfrmCadastroCliente.VerificaDados: Boolean;
begin
  result := false;

  if edtNome.Text = '' then begin
    avisar('O nome deve ser informado');
    edtNome.SetFocus;
  end
 { else if cpfCnpj.edtCpf.Text = '' then begin
    avisar('O '+IfThen(cpfCnpj.comPessoa.ItemIndex = 0, 'CPF', 'CNPJ')+' deve ser informado');
    cpfCnpj.edtCpf.SetFocus;
  end}
  else
    result := true;
end;

procedure TfrmCadastroCliente.btnSalvarClick(Sender: TObject);
begin
  if cpf_duplicado then begin
    avisar('O '+cpfCnpj.StaticText2.Caption+' informado já foi cadastrado');
    cpfCnpj.edtCpf.SetFocus;
    abort;
  end;
  inherited;
end;

function TfrmCadastroCliente.cpf_duplicado: Boolean;
begin
  result := false;
  
  if (self.EstadoTela = tetIncluir) or ((self.EstadoTela = tetAlterar) and (cpf_ao_alterar <> cpfCnpj.edtCpf.Text)) then
    result := campo_por_campo('PESSOAS','CODIGO','CPF_CNPJ',cpfCnpj.edtCpf.Text) <> '';
end;

procedure TfrmCadastroCliente.btnIncluirEndClick(Sender: TObject);
begin
  seta_status(Inserindo);
  limpa_endereco;
  edtLogradouro.SetFocus;
end;

procedure TfrmCadastroCliente.btnAlterarEndClick(Sender: TObject);
begin
  if not (self.ActiveControl = gridEnderecos) then begin
    avisar('Primeiramente selecione o endereço desejado');
    exit;
  end;

  seta_status(Alterando);
  edtLogradouro.SetFocus;
end;

procedure TfrmCadastroCliente.cdsenderecoAfterScroll(DataSet: TDataSet);
begin
  if self.FStatus_endereco in [alterando, inserindo] then
    Exit;

  edtcep.Text                      := cdsenderecoCEP.AsString;
  edtLogradouro.Text               := cdsenderecologradouro.AsString;
  edtNumero.Text                   := cdsendereconumero.AsString;
  edtBairro.Text                   := cdsenderecobairro.AsString;
  edtFone.Text                     := cdsenderecofone.AsString;
  edtComplemento.Text              := cdsenderecoreferencia.AsString;
  BuscaCidade1.CodigoMunicipio     := cdsenderecocod_cidade.AsInteger;
end;

procedure TfrmCadastroCliente.limpa_endereco;
begin
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  edtcep.Clear;
  edtComplemento.Clear;
  edtFone.Clear;
  BuscaCidade1.limpa;
end;

procedure TfrmCadastroCliente.status_acoes_endereco;
begin
  pnlEndereco.Enabled    := (FStatus_endereco = inserindo) or (FStatus_endereco = alterando);
  btnIncluirEnd.Enabled  := not((FStatus_endereco = inserindo) or (FStatus_endereco = alterando));
  btnAlterarEnd.Enabled  := not((FStatus_endereco = inserindo) or (FStatus_endereco = alterando) or (FStatus_endereco = SemEndereco));
  btnDeletarEnd.Enabled  := not((FStatus_endereco = inserindo) or (FStatus_endereco = alterando) or (FStatus_endereco = SemEndereco));
  btnCancelarEnd.Enabled := (FStatus_endereco = inserindo) or (FStatus_endereco = alterando);
  btnSalvarend.Enabled   := (FStatus_endereco = inserindo) or (FStatus_endereco = alterando);

  edtLogradouro.color          := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);
  edtNumero.color              := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  edtBairro.color              := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  edtcep.color                 := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  edtComplemento.color         := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  edtFone.color                := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  BuscaCidade1.edtCidade.color := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  BuscaCidade1.edtCodCid.color := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
  BuscaCidade1.edtUF.color     := IfThen((self.FStatus_endereco in [Alterando, Inserindo]), clWhite, $00F7F7F7);;
end;

procedure TfrmCadastroCliente.btnDeletarEndClick(Sender: TObject);
begin
  if not (self.ActiveControl = gridEnderecos) then begin
    avisar('Primeiramente selecione o endereço desejado');
    exit;
  end;

  if not confirma('Deseja realmente deletar o endereço selecionado?') then
    exit;

  if (cdsenderecoCODIGO.AsInteger > 0) then begin

    if not endereco_nao_utilizado(cdsenderecoCODIGO.AsInteger) then begin
      avisar('Este endereço já foi utilizado em um pedido, e não pode ser deletado');
      Exit;
    end;
    
    cdsEndDeletado.Append;
    cdsEndDeletadoCOD_END.AsInteger := cdsenderecoCODIGO.AsInteger;
    cdsEndDeletado.Post;
  end;

  cdsendereco.Delete;

  if cdsendereco.IsEmpty then
    seta_status( SemEndereco );
end;

procedure TfrmCadastroCliente.seta_status(status: TStatusEndereco);
begin
  FStatus_endereco := status;
  status_acoes_endereco;
  
end;

procedure TfrmCadastroCliente.btnCancelarEndClick(Sender: TObject);
begin
  gridEnderecos.SetFocus;
  seta_status(Cancelando);
end;

procedure TfrmCadastroCliente.btnSalvarendClick(Sender: TObject);
begin
  if self.FStatus_endereco = Alterando then
    cdsendereco.Edit
  else
    cdsendereco.Append;

  cdsenderecoCEP.AsString         := edtcep.Text;
  cdsenderecologradouro.AsString  := edtLogradouro.Text;
  cdsenderecobairro.AsString      := edtBairro.Text;
  cdsendereconumero.AsString      := edtNumero.Text;
  cdsenderecoreferencia.AsString  := edtComplemento.Text;
  cdsenderecocod_cidade.AsInteger := BuscaCidade1.CodigoMunicipio;
  cdsenderecoUF.AsString          := BuscaCidade1.edtUF.Text;
  cdsenderecofone.AsString        := edtFone.Text;

  cdsendereco.Post;

  gridEnderecos.SetFocus;
  seta_status(Salvando);
end;

function TfrmCadastroCliente.endereco_nao_utilizado(cod_endereco :Integer): boolean;
begin
  result := (Campo_por_campo('PEDIDOS', 'CODIGO', 'CODIGO_ENDERECO', IntToStr(cod_endereco)) = '');
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  inherited;
  cdsendereco.CreateDataSet;
  cdsEndDeletado.CreateDataSet;
end;

procedure TfrmCadastroCliente.gridEnderecosEnter(Sender: TObject);
begin
  cdsenderecoAfterScroll(nil);
end;

end.
