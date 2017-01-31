unit ObservacaoNotaFiscal;

interface

type
  TObservacaoNotaFiscal = class

  private
    FCodigoNota  :integer;
    FCRT :integer;
    FAliqCredSN :Real;
    FValorCredSN :Real;
  //  FEnderecoEntrega :String;
    FObservacoes                           :String;
    FObservacoesGeradasPeloSistema         :String;
    FDadosAdicionais                       :String;

    procedure SetDadosAdicionais(const Value: String);

  private
    procedure SetObservacoes(const Value: String);

  private
    function GetDadosAdicionais               :String;
    function GetObservacoesGeradasPeloSistema :String;
    function GetObservacoes                   :String;

  public
    constructor CriaParaRepositorio(Observacoes, ObservacoesGeradasPeloSistema :String);

  public
    property CodigoNotaFiscal              :Integer read FCodigoNota  write FCodigoNota;
    property CRT                           :Integer write FCRT;
    property AliqCredSN                    :Real    write FAliqCredSN;
    property ValorCredSN                   :Real    write FValorCredSN;
   // property EnderecoEntrega               :String  write FEnderecoEntrega;
    property Observacoes                   :String  read GetObservacoes                   write SetObservacoes;
    property ObservacoesGeradasPeloSistema :String  read GetObservacoesGeradasPeloSistema;
    property DadosAdicionais               :String  read GetDadosAdicionais               write SetDadosAdicionais;

  public
    procedure LimparObservacoesGeradasPeloSistema;

  public
    constructor create(codigoNota, CRT :integer; aliqCredSN, valorCredSN :Real; enderecoEntrega :String);
end;

implementation

uses SysUtils, TipoRegimeTributario, uModulo;

{ TObservacaoNotaFiscal }

constructor TObservacaoNotaFiscal.create(codigoNota, CRT: integer; aliqCredSN, valorCredSN: Real; enderecoEntrega: String);
begin
  FCodigoNota      := codigoNota;
  FCRT             := CRT;
  FAliqCredSN      := aliqCredSN;
  FValorCredSN     := valorCredSN;
 // FEnderecoEntrega := enderecoEntrega;
end;

constructor TObservacaoNotaFiscal.CriaParaRepositorio(Observacoes,
  ObservacoesGeradasPeloSistema: String);
begin
   self.FObservacoes                    := Observacoes;
   self.FObservacoesGeradasPeloSistema  := ObservacoesGeradasPeloSistema;
end;

function TObservacaoNotaFiscal.GetDadosAdicionais: String;
begin
   result := UpperCase(Trim(self.Observacoes + #13 + self.ObservacoesGeradasPeloSistema)); 
end;

function TObservacaoNotaFiscal.GetObservacoes: String;
begin
   result := UpperCase(Trim(self.FObservacoes));
end;

function TObservacaoNotaFiscal.GetObservacoesGeradasPeloSistema: String;
const
  PREFIXO = 'Erro em: TObservacaoNotaFiscal.GetObservacoesGeradasPeloSistema: String;'+#13;
  SUFIXO  = ' não foi instânciado!';
begin
   if (Trim(self.FObservacoesGeradasPeloSistema) <> '') then begin
     result := self.FObservacoesGeradasPeloSistema;
     Exit;
   end;

  // result := self.FEnderecoEntrega;

   if (TTipoRegimeTributarioUtilitario.DeIntegerParaEnumerado(self.FCRT) = trtSimplesNacional) then begin

    result := (result+#13+ dm.Empresa.ConfiguracoesNF.ObsGeradaPeloSistema);
   end;


   result := Trim(result);
end;

procedure TObservacaoNotaFiscal.LimparObservacoesGeradasPeloSistema;
begin
   self.FObservacoesGeradasPeloSistema := '';
end;

procedure TObservacaoNotaFiscal.SetDadosAdicionais(const Value: String);
begin
  FDadosAdicionais := Value;
end;

procedure TObservacaoNotaFiscal.SetObservacoes(const Value: String);
begin
   FObservacoes := Value;
end;

end.
