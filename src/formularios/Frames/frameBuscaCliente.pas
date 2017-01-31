unit frameBuscaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, RXToolEdit, RXCurrEdit, Cliente, Endereco;

type
  TBuscaCliente = class(TFrame)
    Label28: TLabel;
    edtTelefone: TMaskEdit;
    edtCodigo: TCurrencyEdit;
    private
    Fcodigo :Integer;
    FCliente: TCliente;
    FCodigoEndereco :Integer;

    procedure buscaCliente;
    function selecionaCliente :String;
    procedure setaCliente;

  private
    procedure SetCliente           (const Value: TCliente);
    procedure Setcodigo            (const Value: Integer);

  public
    procedure limpa;

    property Cliente  :TCliente read FCliente  write SetCliente;
    property codigo   :Integer  read Fcodigo   write Setcodigo;
  end;

implementation

uses uPesquisaSimples, repositorio, fabricarepositorio, EspecificacaoEnderecoPorTelefone, EspecificacaoClientePorCpfCnpj;

{$R *.dfm}

{ TBuscaCliente }

procedure TBuscaCliente.buscaCliente;
begin
  setaCliente;

  if not assigned( FCliente ) then
    selecionaCliente;
end;

procedure TBuscaCliente.limpa;
begin
  Fcodigo := 0;
  FCodigoEndereco := 0;
  edtCodigo.Clear;
  edtTelefone.Clear;

  if assigned(FCliente) then
    FreeAndNil(FCliente);
end;

function TBuscaCliente.selecionaCliente: String;
begin
  Result := '';

  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'select cli.codigo, cli.razao cliente, cli.cpf_cnpj, en.logradouro, en.numero, en.bairro from Pessoas cli '+
                                                        ' left join enderecos en on en.codigo_pessoa = cli.codigo                                        '+
                                                        ' where cli.tipo = ''C'' ' ,
                                                        'CODIGO', 'Selecione o Produto desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then begin
    Result         := frmPesquisaSimples.cds_retorno.Fields[0].AsString;
    edtCodigo.Text := Result;
    setaCliente;
  end;
  frmPesquisaSimples.Release;
end;

procedure TBuscaCliente.setaCliente;
var
   RepCliente    :TRepositorio;
   RepEndereco   :TRepositorio;
   Endereco      :TEndereco;
   Especificacao :TEspecificacaoEnderecoPorTelefone;
begin
  RepCliente := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);

  if trim(edtTelefone.Text) <> '' then
  begin
    RepEndereco    := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
    Especificacao  := TEspecificacaoEnderecoPorTelefone.Create(edtTelefone.Text);
    Endereco       := TEndereco( RepEndereco.GetPorEspecificacao(Especificacao) );

    if assigned(Endereco) then
    begin
      FCliente        := TCliente(RepCliente.Get(Endereco.codigo_pessoa));
      FCodigoEndereco := Endereco.codigo;
    end;

  end
  else
    FCliente   := TCliente(RepCliente.Get(edtCodigo.AsInteger));

  if Assigned(FCliente) and (FCliente.codigo > 0) then begin

    edtCodigo.Value  := FCliente.Codigo;

    if assigned(Endereco) then
      edtTelefone.Text := Endereco.fone;

    self.Fcodigo     := FCliente.codigo;

  end
  else limpa;
end;

procedure TBuscaCliente.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TBuscaCliente.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaCliente;
end;

end.
