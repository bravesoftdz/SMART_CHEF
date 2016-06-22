unit ParametrosEmpresa;

interface

uses
  TipoRegime,
  EnderecoNFCe;

type
  TParametrosEmpresa = class
  
  private
    FCNPJ: String;
    FIE: String;
    FRazao: String;
    FFantasia: String;
    FEndereco: TEndereco;
    FRegime: TTipoRegime;

  private
    procedure SetCNPJ(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetRazao(const Value: String);
    procedure SetFantasia(const Value: String);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetRegime(const Value: TTipoRegime);

  public
    property CNPJ :String read FCNPJ write SetCNPJ;
    property IE :String read FIE write SetIE;
    property Razao :String read FRazao write SetRazao;
    property Fantasia :String read FFantasia write SetFantasia;
    property Endereco :TEndereco read FEndereco;
    property Regime :TTipoRegime read FRegime write SetRegime;

  public
    constructor Create;
    destructor Destroy; override; 
end;

implementation

uses
  SysUtils,
  ExcecaoCampoNaoInformado;

{ TParametrosEmpresa }

constructor TParametrosEmpresa.Create();
begin
   FCNPJ := '';
   FIE := '';
   FRazao := '';
   FFantasia := '';
   FEndereco := TEndereco.Create;
   FRegime := trRegimeNormal;
end;

destructor TParametrosEmpresa.Destroy;
begin
   FreeAndNil(FEndereco);
   
   inherited;
end;

procedure TParametrosEmpresa.SetCNPJ(const Value: String);
begin
  if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('CNPJ');

  FCNPJ := Value;
end;

procedure TParametrosEmpresa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TParametrosEmpresa.SetFantasia(const Value: String);
begin
   if ('' = Trim(Value)) then
    raise TExcecaoCampoNaoInformado.Create('Fantasia');

   FFantasia := Value;
end;

procedure TParametrosEmpresa.SetIE(const Value: String);
begin
  if (Trim(Value) = '') then
    raise TExcecaoCampoNaoInformado.Create('IE');
    
  FIE := Value;
end;

procedure TParametrosEmpresa.SetRazao(const Value: String);
begin
   if ('' = Trim(Value)) then
    raise TExcecaoCampoNaoInformado.Create('Razao');

   FRazao := Value;
end;

procedure TParametrosEmpresa.SetRegime(const Value: TTipoRegime);
begin
   if (Integer(Value) <= 0) then
    raise TExcecaoCampoNaoInformado.Create('Regime');
    
  FRegime := Value;
end;

end.
