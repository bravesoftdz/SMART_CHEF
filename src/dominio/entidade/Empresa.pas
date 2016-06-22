unit Empresa;

interface

uses SysUtils, TipoRegime, Contnrs;

type
  TEmpresa = class

  private
    Fcodigo :Integer;
    Frazao_social :String;
    Fnome_fantasia :String;
    Fcnpj :String;
    Fie :String;
    Ftelefone :String;
    Fsite :String;
    Fquantidade_mesas :Integer;
    Fcouvert :Boolean;
    Fvalor_couvert :Real;
    Fcidade :String;
    Ftaxa_servico :Real;
    Faliquota_couvert :Real;
    Faliquota_txservico :Real;
    Ftributacao_couvert :String;
    Ftributacao_txservico :String;
    Fdiretorio_boliche :String;
    Fdiretorio_dispensadora :String;
    Festado :String;
    Fcep :Integer;
    Frua :String;
    Fnumero :String;
    Fbairro :String;
    Fcomplemento :String;
    Fcod_municipio :Integer;
    FRegime: TTipoRegime;
    FTaxa_entrega :Real;
    
    function GetAliqCouvertParaECF: String;
    function GetAliqTxServicoParaECF: String;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property razao_social          :String read Frazao_social          write Frazao_social;
    property nome_fantasia         :String read Fnome_fantasia         write Fnome_fantasia;
    property cnpj                  :String read Fcnpj                  write Fcnpj;
    property ie                    :String read Fie                    write Fie;
    property telefone              :String read Ftelefone              write Ftelefone;
    property site                  :String read Fsite                  write Fsite;
    property quantidade_mesas      :Integer read Fquantidade_mesas      write Fquantidade_mesas;
    property couvert               :Boolean read Fcouvert               write Fcouvert;
    property valor_couvert         :Real read Fvalor_couvert         write Fvalor_couvert;
    property cidade                :String read Fcidade                write Fcidade;
    property taxa_servico          :Real read Ftaxa_servico          write Ftaxa_servico;
    property aliquota_couvert      :Real read Faliquota_couvert      write Faliquota_couvert;
    property aliquota_txservico    :Real read Faliquota_txservico    write Faliquota_txservico;
    property tributacao_couvert    :String read Ftributacao_couvert    write Ftributacao_couvert;
    property tributacao_txservico  :String read Ftributacao_txservico  write Ftributacao_txservico;
    property diretorio_boliche     :String read Fdiretorio_boliche     write Fdiretorio_boliche;
    property diretorio_dispensadora :String read Fdiretorio_dispensadora write Fdiretorio_dispensadora;
    property estado                :String read Festado                write Festado;
    property cep                   :Integer read Fcep                   write Fcep;
    property rua                   :String read Frua                   write Frua;
    property numero                :String read Fnumero                write Fnumero;
    property bairro                :String read Fbairro                write Fbairro;
    property complemento           :String read Fcomplemento           write Fcomplemento;
    property cod_municipio         :Integer read Fcod_municipio         write Fcod_municipio;
    property Regime                :TTipoRegime read FRegime            write FRegime;
    property taxa_entrega          :Real    read Ftaxa_entrega          write Ftaxa_entrega;        

  public
    property aliqCouvertParaECF     :String  read GetAliqCouvertParaECF;
    property aliqTxServicoParaECF   :String  read GetAliqTxServicoParaECF;

  public
    constructor Create;

end;

implementation

{ TEmpresa }

constructor TEmpresa.Create;
begin
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

end.
