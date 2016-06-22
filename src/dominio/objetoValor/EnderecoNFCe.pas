unit EnderecoNFCe;

interface

uses
  CidadeNFCe;

type
  TEndereco = class

  private
    FCidade: TCidade;
    FFone: String;
    FCEP: String;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;

  private
    procedure SetCidade(const Value: TCidade);
    procedure SetFone(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetBairro(const Value: String);

  private
    function GetCodigoEnderecamentoPostal: Integer;

  public
    property Cidade :TCidade read FCidade;
    property Fone :String read FFone write SetFone;
    property CEP :String read FCEP write SetCEP;
    property CodigoEnderecamentoPostal :Integer read GetCodigoEnderecamentoPostal;
    property Logradouro :String read FLogradouro write SetLogradouro;
    property Numero :String read FNumero write SetNumero;
    property Complemento :String read FComplemento write SetComplemento;
    property Bairro :String read FBairro write SetBairro;
end;

implementation

uses
  SysUtils,
//  StringUtilitario, 
  ExcecaoCampoNaoInformado;

{ TEndereco }

function TEndereco.GetCodigoEnderecamentoPostal: Integer;
begin
   result := StrToInt(FCEP); //StrToInt(TStringUtilitario.ApenasNumeros(CEP));
end;

procedure TEndereco.SetBairro(const Value: String);
begin
   if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('Bairro');

  FBairro := Value;
end;

procedure TEndereco.SetCEP(const Value: String);
begin
   if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('Cep');

  FCEP := Value;
end;

procedure TEndereco.SetCidade(const Value: TCidade);
begin
   FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetFone(const Value: String);
begin
//   if (Trim(Value) = '(  )    -') then
//    raise TExcecaoCampoNaoInformado.Create('Fone');

   FFone := Value;
end;

procedure TEndereco.SetLogradouro(const Value: String);
begin
   if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('Logradouro');

  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: String);
begin
   if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('Numero');

   FNumero := Value;
end;

end.
