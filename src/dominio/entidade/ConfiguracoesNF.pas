unit ConfiguracoesNF;

interface

uses SysUtils, Contnrs, ParametrosNFCe, TipoRegimeTributario;

type
  TConfiguracoesNF = class

  private
    FRegimeTributario   :TTipoRegimeTributario;
    Fcodigo_empresa :Integer;
    Faliq_cred_sn :Real;
    Faliq_icms :Real;
    Faliq_pis :Real;
    Faliq_cofins :Real;
    Fnum_certificado :String;
    Fambiente_nfe :String;
    Fsenha_certificado :String;
    Ftipo_emissao :Integer;
    Fdt_contingencia :TDateTime;
    FCRT: SmallInt;
    FParametrosNFCe :TParametrosNFCe;
    FSequenciaNotaFiscal :integer;
    function GetParametrosNFCe: TParametrosNFCe;

  private
    FObsGeradaPeloSistema: String;
    procedure SetRegimeTributario       (const Value: TTipoRegimeTributario);
    function GetCRT: Integer;
    procedure SetCRT(const Value: Integer);
    procedure SetSequenciaNotaFiscal(const Value: Integer);

  public
    procedure AdicionarConfiguracoesNFCe(
                                         formaEmissao        :integer;
                                         intervaloTentativas :integer;
                                         tentativas          :integer;
                                         versaoDF            :integer;
                                         idToken             :String;
                                         token               :String;
                                         visualizaImpressao  :String;
                                         viaConsumidor       :String;
                                         imprimeItens        :String;
                                         modeloImpressao     :integer;
                                         impCompPedido :String
                                        );

  public
    property codigo_empresa        :Integer   read Fcodigo_empresa        write Fcodigo_empresa;
    property aliq_cred_sn          :Real      read Faliq_cred_sn          write Faliq_cred_sn;
    property aliq_icms             :Real      read Faliq_icms             write Faliq_icms;
    property aliq_pis              :Real      read Faliq_pis              write Faliq_pis;
    property aliq_cofins           :Real      read Faliq_cofins           write Faliq_cofins;
    property num_certificado       :String    read Fnum_certificado       write Fnum_certificado;
    property ambiente_nfe          :String    read Fambiente_nfe          write Fambiente_nfe;
    property SequenciaNotaFiscal  :Integer    read FSequenciaNotaFiscal   write SetSequenciaNotaFiscal;
    property senha_certificado     :String    read Fsenha_certificado     write Fsenha_certificado;
    property tipo_emissao          :Integer   read Ftipo_emissao          write Ftipo_emissao;
    property dt_contingencia       :TDateTime read Fdt_contingencia       write Fdt_contingencia;
    property CRT                   :Integer   read GetCRT                 write SetCRT;
    property ObsGeradaPeloSistema  :String    read FObsGeradaPeloSistema  write FObsGeradaPeloSistema;

    property RegimeTributario      :TTipoRegimeTributario read FRegimeTributario           write SetRegimeTributario;

    property ParametrosNFCe        :TParametrosNFCe read GetParametrosNFCe;

    function IncrementarSequencia: Integer;
end;

implementation

uses Funcoes, ExcecaoParametroInvalido, Repositorio, FabricaRepositorio, uModulo;

{ TConfiguracoesNF }

procedure TConfiguracoesNF.AdicionarConfiguracoesNFCe(formaEmissao, intervaloTentativas, tentativas, versaoDF: integer; idToken, token,
  visualizaImpressao, viaConsumidor, imprimeItens: String; modeloImpressao :Integer; impCompPedido :String);
begin
 {  if Fambiente_nfe.isEmpty then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'AdicionarConfiguracoes(AliquotaCreditoSN, AliquotaICMS, AliquotaPIS, '+
                                                           ' AliquotaCOFINS: Real; NumeroCertificado, AmbienteNFe, '+
                                                           '  SenhaCertificado: String)', 'AmbienteNFe' );

   self.FParametrosNFCe                      := TParametrosNFCe.Create;
   self.FParametrosNFCe.forma_emissao        := formaEmissao;
   self.FParametrosNFCe.codigo_empresa       := self.codigo_empresa;
   self.FParametrosNFCe.intervalo_tentativas := intervaloTentativas;
   self.FParametrosNFCe.tentativas           := tentativas;
   self.FParametrosNFCe.versao_df            := versaoDF;
   self.FParametrosNFCe.id_token             := idToken;
   self.FParametrosNFCe.token                := token;
   self.FParametrosNFCe.visualiza_impressao  := visualizaImpressao = 'S';
   self.FParametrosNFCe.via_consumidor       := viaConsumidor = 'S';
   self.FParametrosNFCe.imprime_itens        := imprimeItens = 'S';
   self.FParametrosNFCe.leiaute_impressao    := modeloImpressao;
   self.FParametrosNFCe.imp_comp_pedido      := impCompPedido = 'S';

  if self.FParametrosNFCe.forma_emissao = 8 then
    self.FParametrosNFCe.dt_contingencia := now;    }
end;

function TConfiguracoesNF.IncrementarSequencia: Integer;
begin
   self.FSequenciaNotaFiscal := (self.FSequenciaNotaFiscal + 1);
   result                    := self.FSequenciaNotaFiscal;
end;

function TConfiguracoesNF.GetParametrosNFCe: TParametrosNFCe;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FParametrosNFCe) then begin
     Repositorio := nil;

     try
       Repositorio           := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
       self.FParametrosNFCe  := (Repositorio.Get(self.Fcodigo_empresa) as TParametrosNFCe);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FParametrosNFCe;
end;

function TConfiguracoesNF.GetCRT: Integer;
begin
   Result := 0;

   if      (self.FRegimeTributario = trtSimplesNacional) then result := 0
   else if (self.FRegimeTributario = trtLucroPresumido)  then result := 1
   else if (self.FRegimeTributario = trtLucroReal)       then result := 2;
end;

procedure TConfiguracoesNF.SetRegimeTributario(const Value: TTipoRegimeTributario);
begin
  FRegimeTributario := Value;
end;

procedure TConfiguracoesNF.SetSequenciaNotaFiscal(const Value: Integer);
begin
  FSequenciaNotaFiscal := Value;
end;

procedure TConfiguracoesNF.SetCRT(const Value: Integer);
begin
   FCRT := Value;
   case FCRT of
     0: self.FRegimeTributario := trtSimplesNacional;
     1: self.FRegimeTributario := trtLucroPresumido;
     2: self.FRegimeTributario := trtLucroReal;
   end;
end;

end.
