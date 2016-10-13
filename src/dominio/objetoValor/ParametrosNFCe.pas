unit ParametrosNFCe;

interface

uses
  TipoFormaEmissao,
  TipoVersaoDF,
  Token,
  CertificadoNFCE,
  ParametrosDANFE;

type
  TParametrosNFCe = class

  private
    FFormaEmissao: Integer;
    FIntervaloTentativas: Integer;
    FTentativas: Integer;
    FVersaoDF: Integer;
    FID_Token: String;
    FToken: String;
    FCertificado :String;
    FSenha :String;
    FDANFE: TParametrosDANFE;
    Fcodigo :Integer;
    FAmbiente :String;
    FJustContingencia: String;
    FInicioContingencia: TDateTime;

  private
    procedure SetFormaEmissao(const Value: Integer);
    procedure SetIntervaloTentativas(const Value: Integer);
    procedure SetTentativas(const Value: Integer);
    procedure SetVersaoDF(const Value: Integer);

  public
    property Codigo              :Integer           read FCOdigo              write Fcodigo;
    property FormaEmissao        :Integer           read FFormaEmissao        write SetFormaEmissao;
    property IntervaloTentativas :Integer           read FIntervaloTentativas write SetIntervaloTentativas;
    property VersaoDF            :Integer           read FVersaoDF            write SetVersaoDF;
    property Tentativas          :Integer           read FTentativas          write SetTentativas;
    property ID_TOKEN            :String            read FID_Token            write FID_Token;
    property TOKEN               :String            read FToken               write FToken;
    property Certificado         :String            read FCertificado         write FCertificado;
    property Senha               :String            read FSenha               write FSenha;
    property Ambiente            :String            read FAmbiente            write FAmbiente;
    property justContingencia    :String            read FJustContingencia    write FJustContingencia;
    property inicioContingencia  :TDateTime         read FInicioContingencia  write FInicioContingencia;

  public
    property DANFE :TParametrosDANFE read FDANFE write FDANFE;

  public
    constructor  Create;
end;

implementation

uses
  ExcecaoCampoNaoInformado,
  SysUtils;

{ TParametrosNFCe }

constructor TParametrosNFCe.Create();
begin
   FDANFE  := TParametrosDANFE.Create;
   FCodigo := 1;
end;

procedure TParametrosNFCe.SetFormaEmissao(const Value: Integer);
begin
  try
    if (Integer(Value) < 0) or (Integer(Value) > 9) then
      raise TExcecaoCampoNaoInformado.Create('FormaEmissao');
  except
    raise TExcecaoCampoNaoInformado.Create('FormaEmissao');
  end;
  
  FFormaEmissao := Value;
end;

procedure TParametrosNFCe.SetIntervaloTentativas(const Value: Integer);
begin
   if (Value <= 0) then
    raise TExcecaoCampoNaoInformado.Create('IntervaloTentativas');

   FIntervaloTentativas := Value;
end;

procedure TParametrosNFCe.SetTentativas(const Value: Integer);
begin
   if (Value <= 0) then
    raise TExcecaoCampoNaoInformado.Create('Tentativas');

  FTentativas := Value;
end;

procedure TParametrosNFCe.SetVersaoDF(const Value: Integer);
begin
  try
    if (Integer(Value) <= 0) or (Integer(Value) > 2) then
      raise TExcecaoCampoNaoInformado.Create('VersaoDF');
  except
    raise TExcecaoCampoNaoInformado.Create('VersaoDF');
  end;

  FVersaoDF := Value;
end;

end.
