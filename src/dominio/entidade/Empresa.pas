unit Empresa;

interface

uses SysUtils, TipoRegimeTributario, Contnrs, ConfiguracoesNF, Pessoa, ConfiguracoesNFEmail;

type
  TEmpresa = class(TPessoa)

  private
    Fnome_fantasia :String;
    Fquantidade_mesas :Integer;
    Fcouvert :Boolean;
    Fvalor_couvert :Real;
    Ftaxa_servico :Real;
    Faliquota_couvert :Real;
    Faliquota_txservico :Real;
    Ftributacao_couvert :String;
    Ftributacao_txservico :String;
    Fdiretorio_boliche :String;
    Fdiretorio_dispensadora :String;
    Fcod_municipio :Integer;
    FRegime: TTipoRegimeTributario;
    FTaxa_entrega :Real;
    FConfiguracoesNF: TConfiguracoesNF;
    FCodigoEmpresa: integer;
    FConfiguracoesEmail :TConfiguracoesNFEmail;
    
    function GetAliqCouvertParaECF: String;
    function GetAliqTxServicoParaECF: String;
    function GetConfiguracoesNF: TConfiguracoesNF;
    function GetConfiguracoesEmail      :TConfiguracoesNFEmail;

  public
    property codigoEmpresa         :integer read FCodigoEmpresa         write FCodigoEmpresa;
    property quantidade_mesas      :Integer read Fquantidade_mesas      write Fquantidade_mesas;
    property couvert               :Boolean read Fcouvert               write Fcouvert;
    property valor_couvert         :Real    read Fvalor_couvert         write Fvalor_couvert;
    property taxa_servico          :Real    read Ftaxa_servico          write Ftaxa_servico;
    property aliquota_couvert      :Real    read Faliquota_couvert      write Faliquota_couvert;
    property aliquota_txservico    :Real    read Faliquota_txservico    write Faliquota_txservico;
    property tributacao_couvert    :String  read Ftributacao_couvert    write Ftributacao_couvert;
    property tributacao_txservico  :String  read Ftributacao_txservico  write Ftributacao_txservico;
    property diretorio_boliche     :String  read Fdiretorio_boliche     write Fdiretorio_boliche;
    property diretorio_dispensadora :String read Fdiretorio_dispensadora write Fdiretorio_dispensadora;
    property Regime                :TTipoRegimeTributario read FRegime            write FRegime;
    property taxa_entrega          :Real    read Ftaxa_entrega          write Ftaxa_entrega;        

  public
    property aliqCouvertParaECF     :String  read GetAliqCouvertParaECF;
    property aliqTxServicoParaECF   :String  read GetAliqTxServicoParaECF;
    property ConfiguracoesNF        :TConfiguracoesNF      read GetConfiguracoesNF          write FConfiguracoesNF;
    property ConfiguracoesEmail     :TConfiguracoesNFEmail read GetConfiguracoesEmail;

  public
    procedure AdicionarConfiguracoesNFe(
                                     AliquotaCreditoSN :Real;
                                     AliquotaICMS      :Real;
                                     AliquotaPIS       :Real;
                                     AliquotaCOFINS    :Real;
                                     NumeroCertificado :String;
                                     AmbienteNFe       :String;
                                     SenhaCertificado  :String;
                                     TipoEmissao       :integer;
                                     CRT               :integer;
                                     obsGeradaSistema  :string;
                                     SequenciaNF       :integer
                                    );

    procedure AdicionarConfiguracoesEmail(SMTPHost,
                                          SMTPPort,
                                          SMTPUser,
                                          SMTPPassword,
                                          Assunto,
                                          Mensagem :String);
  public
    constructor Create;

end;

implementation

uses Repositorio, FabricaRepositorio;

{ TEmpresa }

procedure TEmpresa.AdicionarConfiguracoesNFe(AliquotaCreditoSN, AliquotaICMS, AliquotaPIS, AliquotaCOFINS: Real; NumeroCertificado, AmbienteNFe,
  SenhaCertificado: String; TipoEmissao, CRT: integer; obsGeradaSistema: string; SequenciaNF: integer);
begin
   self.FConfiguracoesNF                      := TConfiguracoesNF.Create;
   self.FConfiguracoesNF.codigo_empresa       := self.CodigoEmpresa;
   self.FConfiguracoesNF.aliq_cred_sn         := AliquotaCreditoSN;
   self.FConfiguracoesNF.aliq_icms            := AliquotaICMS;
   self.FConfiguracoesNF.aliq_pis             := AliquotaPIS;
   self.FConfiguracoesNF.aliq_cofins          := AliquotaCOFINS;
   self.FConfiguracoesNF.num_certificado      := NumeroCertificado;
   self.FConfiguracoesNF.senha_certificado    := SenhaCertificado;
   self.FConfiguracoesNF.ambiente_nfe         := AmbienteNFe;
   self.FConfiguracoesNF.CRT                  := CRT;
   self.FConfiguracoesNF.ObsGeradaPeloSistema := obsGeradaSistema;
   self.FConfiguracoesNF.SequenciaNotaFiscal  := SequenciaNF;

   {7 = SVCRS}
   if (tipoEmissao = 7) then
     self.FConfiguracoesNF.Dt_contingencia := now;

   self.FConfiguracoesNF.Tipo_emissao        := TipoEmissao;
end;

constructor TEmpresa.Create;
begin
  inherited Create;
  inherited tipo := 'E';
end;

function TEmpresa.GetAliqCouvertParaECF: String;
begin
  result := self.TRIBUTACAO_COUVERT;

  if Result[1] in ['S'] then
    Result := FloatToStr(self.Aliquota_couvert) + Result;
end;

function TEmpresa.GetAliqTxServicoParaECF: String;
begin
  result := self.TRIBUTACAO_TXSERVICO;

  if Result[1] in ['S'] then
    Result := FloatToStr(self.Aliquota_TxServico) + Result;
end;

function TEmpresa.GetConfiguracoesEmail: TConfiguracoesNFEmail;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FConfiguracoesEmail) then begin
     Repositorio := nil;
     try
       Repositorio              := TFabricaRepositorio.GetRepositorio(TConfiguracoesNFEmail.ClassName);
       self.FConfiguracoesEmail := (Repositorio.Get(self.FCodigoEmpresa) as TConfiguracoesNFEmail);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FConfiguracoesEmail;
end;

function TEmpresa.GetConfiguracoesNF: TConfiguracoesNF;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FConfiguracoesNF) then begin
     Repositorio := nil;
     try
       Repositorio              := TFabricaRepositorio.GetRepositorio(TConfiguracoesNF.ClassName);
       self.FConfiguracoesNF := (Repositorio.Get(self.codigo) as TConfiguracoesNF);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FConfiguracoesNF;
end;

procedure TEmpresa.AdicionarConfiguracoesEmail(SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String);
const
  NOME_METODO = ' AdicionarConfiguracoesEmail(SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String; UsaSSL: Boolean) ';
begin
   if SMTPHost.IsEmpty and SMTPPort.IsEmpty  and SMTPUser.IsEmpty  and SMTPPassword.IsEmpty  and
      Assunto.IsEmpty  and Mensagem.IsEmpty  then
   begin
     exit;
   end;

   self.FConfiguracoesEmail := TConfiguracoesNFEmail.Create(self.CodigoEmpresa,
                                                            SMTPHost,
                                                            SMTPPort,
                                                            SMTPUser,
                                                            SMTPPassword,
                                                            Assunto,
                                                            Mensagem);
end;

end.
