unit TotaisNotaFiscal;

interface

uses
  MetodoDelegadoObtemCampoInteger,
  MetodoDelegadoObtemCampoReal,
  Classes;

type
  TAtualizadorItens = procedure of Object;

type
  TTotaisNotaFiscal = class

  private
    FFrete            :Real;
    FSeguro           :Real;
    FDescontos        :Real;
    FOutrasDespesas   :Real;
    FSubstTributaria  :Real;
    FBaseCalculoICMS  :Real;
    FICMS             :Real;
    FBaseCalculoST    :Real;
    FICMSST           :Real;
    FIPI              :Real;
    FPIS              :Real;
    FCOFINS           :Real;
    FTotalNF          :Real;
    FTotalProdutos    :Real;
    FICMSFCP          :Real;
    FICMSUFDest       :Real;
    FICMSUFRemet      :Real;

    // Métodos Delegados
    FBuscaCodigoNotaFiscal        :TMetodoDelegadoObtemCampoInteger;
    FBuscaBaseCalculoICMS         :TMetodoDelegadoObtemCampoReal;
    FBuscaICMS                    :TMetodoDelegadoObtemCampoReal;
    FBuscaBaseCalculoICMSST       :TMetodoDelegadoObtemCampoReal;
    FBuscaICMSST                  :TMetodoDelegadoObtemCampoReal;
    FBuscaTotalProdutos           :TMetodoDelegadoObtemCampoReal;
    FBuscaII                      :TMetodoDelegadoObtemCampoReal;
    FBuscaIPI                     :TMetodoDelegadoObtemCampoReal;
    FBuscaPIS                     :TMetodoDelegadoObtemCampoReal;
    FBuscaCOFINS                  :TMetodoDelegadoObtemCampoReal;
    FBuscaICMSFCP                 :TMetodoDelegadoObtemCampoReal;
    FBuscaICMSUFDest              :TMetodoDelegadoObtemCampoReal;
    FBuscaICMSUFRemet             :TMetodoDelegadoObtemCampoReal;
    FBuscaTipoFrete               :TMetodoDelegadoObtemCampoInteger;
    FAtualizarFreteItens          :TAtualizadorItens;
    FAtualizarSeguroItens         :TAtualizadorItens;
    FAtualizarDescontoItens       :TAtualizadorItens;
    FAtualizarOutrasDespesasItens :TAtualizadorItens;
    FAtualizarNotaFiscal          :TNotifyEvent;
    FPercentualDescontoFatura     :Real;
    procedure SetBaseCalculoICMS(const Value: Real);
    procedure SetBaseCalculoST(const Value: Real);
    procedure SetICMS(const Value: Real);
    procedure SetICMSST(const Value: Real);
    procedure SetCOFINS(const Value: Real);
    procedure SetIpi(const Value: Real);
    procedure SetPIS(const Value: Real);
    procedure SetTotalNF(const Value: Real);
    procedure SetTotalProdutos(const Value: Real);

  private
    procedure SetFrete                   (const Frete          :Real);
    procedure SetSeguro                  (const Seguro         :Real);
    procedure SetDesconto                (const Desconto       :Real);
    procedure SetOutrasDespesas          (const OutrasDespesas :Real);
    procedure SetPercentualDescontoFatura(const Value: Real);

    procedure AlterarFreteItens;
    procedure AlterarSeguroItens;
    procedure AlterarDescontoItens;
    procedure AlterarOutrasDespesasItens;

  private
    function GetBaseCalculoICMS   :Real;
    function GetBaseCalculoICMSST :Real;
    function GetCodigoNotaFiscal  :Integer;
    function GetCOFINS            :Real;
    function GetDescontos         :Real;
    function GetFrete             :Real;
    function GetFreteCalculado    :Real;
    function GetICMS              :Real;
    function GetICMSST            :Real;
    function GetII                :Real;
    function GetIPI               :Real;
    function GetOutrasDespesas    :Real;
    function GetPIS               :Real;
    function GetSeguro            :Real;
    function GetTotalNF           :Real;
    function GetTotalProdutos     :Real;
    function GetICMSFCP           :Real;
    function GetICMSUFDest        :Real;
    function GetICMSUFRemet       :Real;

  private
    procedure ValidarFrete          (Frete          :Real);
    procedure ValidarSeguro         (Seguro         :Real);
    procedure ValidarDesconto       (Desconto       :Real);
    procedure ValidarOutrasDespesas (OutrasDespesas :Real);

  public
    constructor Create(Frete, Seguro, Desconto, OutrasDespesas, substTributaria :Real);

  public
    property CodigoNotaFiscal         :Integer read GetCodigoNotaFiscal;
    property BaseCalculoICMS          :Real    read GetBaseCalculoICMS        write SetBaseCalculoICMS;
    property ICMS                     :Real    read GetICMS                   write SetICMS;
    property BaseCalculoST            :Real    read GetBaseCalculoICMSST      write SetBaseCalculoST;
    property ICMSST                   :Real    read GetICMSST                 write SetICMSST;
    property TotalProdutos            :Real    read GetTotalProdutos          write SetTotalProdutos;
    property Frete                    :Real    read GetFrete                  write SetFrete;
    property FreteCalculado           :Real    read GetFreteCalculado;
    property Seguro                   :Real    read GetSeguro                 write SetSeguro;
    property Descontos                :Real    read GetDescontos              write SetDesconto;
    property PercentualDescontoFatura :Real    read FPercentualDescontoFatura write SetPercentualDescontoFatura;
    property II                       :Real    read GetII;
    property IPI                      :Real    read GetIPI                    write SetIpi;
    property PIS                      :Real    read GetPIS                    write SetPIS;
    property COFINS                   :Real    read GetCOFINS                 write SetCOFINS;
    property OutrasDespesas           :Real    read GetOutrasDespesas         write SetOutrasDespesas;
    property SubstTributaria          :Real    read FSubstTributaria          write FSubstTributaria;
    property TotalNF                  :Real    read GetTotalNF                write SetTotalNF;
    property ICMSFCP                  :Real    read GetICMSFCP                write FICMSFCP;
    property ICMSUFDest               :Real    read GetICMSUFDest             write FICMSUFDest;
    property ICMSUFRemet              :Real    read GetICMSUFRemet            write FICMSUFRemet;

  public
    procedure AdicionarBuscadorCodigoNotaFiscal     (Buscador :TMetodoDelegadoObtemCampoInteger);
    procedure AdicionarBuscadorBaseCalculoICMS      (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorICMS                 (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorBaseCalculoICMSST    (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorICMSST               (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorTotalProdutos        (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorII                   (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorIPI                  (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorPIS                  (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorCOFINS               (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorTipoFrete            (Buscador :TMetodoDelegadoObtemCampoInteger);
    procedure AdicionarBuscadorICMSFCP              (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorICMSUFDest           (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarBuscadorICMSUFRemet          (Buscador :TMetodoDelegadoObtemCampoReal);
    procedure AdicionarAtualizarFreteItens          (Atualizador :TAtualizadorItens);
    procedure AdicionarAtualizarSeguroItens         (Atualizador :TAtualizadorItens);
    procedure AdicionarAtualizarDescontoItens       (Atualizador :TAtualizadorItens);
    procedure AdicionarAtualizarOutrasDespesasItens (Atualizador :TAtualizadorItens);
    procedure AdicionarAtualizarNotaFiscal          (Atualizador :TNotifyEvent);

    procedure SomarFreteAoTotal         (Frete          :Real);
    procedure SomarSeguroAoTotal        (Seguro         :Real);
    procedure SomarDescontoAoTotal      (Desconto       :Real);
    procedure SomarOutrasDespesasAoTotal(OutrasDespesas :Real);

    procedure SubtrairFreteDoTotal          (Frete          :Real);
    procedure SubtrairSeguroDoTotal         (Seguro         :Real);
    procedure SubtrairDescontoDoTotal       (Desconto       :Real);
    procedure SubtrairOutrasDespesasDoTotal (OutrasDespesas :Real);
end;

implementation

uses
  SysUtils,
  TipoFrete,
  ExcecaoParametroInvalido;

{ TTotaisNotaFiscal }

procedure TTotaisNotaFiscal.AdicionarBuscadorBaseCalculoICMS(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaBaseCalculoICMS := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorBaseCalculoICMSST(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaBaseCalculoICMSST := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorCodigoNotaFiscal(
  Buscador: TMetodoDelegadoObtemCampoInteger);
begin
   self.FBuscaCodigoNotaFiscal := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorCOFINS(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaCOFINS := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorICMS(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaICMS := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorICMSST(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaICMSST := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorII(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaII := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorIPI(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaIPI := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorPIS(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaPIS := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorTipoFrete(
  Buscador: TMetodoDelegadoObtemCampoInteger);
begin
   self.FBuscaTipoFrete := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorTotalProdutos(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaTotalProdutos := Buscador;
end;

procedure TTotaisNotaFiscal.SetDesconto(const Desconto: Real);
begin
   self.ValidarDesconto(Desconto);
   self.FDescontos := Desconto;
   self.AlterarDescontoItens;

   if Assigned(self.FAtualizarNotaFiscal) then
    self.FAtualizarNotaFiscal(self);
end;

procedure TTotaisNotaFiscal.SetFrete(const Frete: Real);
begin
   self.ValidarFrete(Frete);
   self.FFrete := Frete;
   self.AlterarFreteItens;

   if Assigned(self.FAtualizarNotaFiscal) then
    self.FAtualizarNotaFiscal(self);
end;

procedure TTotaisNotaFiscal.SetOutrasDespesas(const OutrasDespesas: Real);
begin
   self.ValidarOutrasDespesas(OutrasDespesas);
   self.FOutrasDespesas := OutrasDespesas;
   self.AlterarOutrasDespesasItens;

   if Assigned(self.FAtualizarNotaFiscal) then
    self.FAtualizarNotaFiscal(self);
end;

procedure TTotaisNotaFiscal.SetSeguro(const Seguro: Real);
begin
   self.ValidarSeguro(Seguro);
   self.FSeguro := Seguro;
   self.AlterarSeguroItens;

   if Assigned(self.FAtualizarNotaFiscal) then
    self.FAtualizarNotaFiscal(self);
end;

constructor TTotaisNotaFiscal.Create(Frete, Seguro, Desconto,
  OutrasDespesas, substTributaria: Real);
begin
   self.SetFrete(Frete);
   self.SetSeguro(Seguro);
   self.SetDesconto(Desconto);
   self.SetOutrasDespesas(OutrasDespesas);
   self.FSubstTributaria := substTributaria;
end;

function TTotaisNotaFiscal.GetBaseCalculoICMS: Real;
begin
   try
     result := self.FBuscaBaseCalculoICMS;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetBaseCalculoICMS: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaBaseCalculoICMS!');
   end;
end;

function TTotaisNotaFiscal.GetBaseCalculoICMSST: Real;
begin
   try
     result := self.FBuscaBaseCalculoICMSST;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetCodigoNotaFiscal: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaCodigoNotaFiscal!');
   end;
end;

function TTotaisNotaFiscal.GetCodigoNotaFiscal: Integer;
begin
   try
     result := self.FBuscaCodigoNotaFiscal;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetCodigoNotaFiscal: Integer'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaCodigoNotaFiscal!');
   end;
end;

function TTotaisNotaFiscal.GetCOFINS: Real;
begin
   try
     result := self.FBuscaCOFINS;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetCOFINS: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaCOFINS!');
   end;
end;

function TTotaisNotaFiscal.GetDescontos: Real;
begin
   result := self.FDescontos;
end;

function TTotaisNotaFiscal.GetFrete: Real;
var
  T :TTipoFrete;
begin
   try
     result := 0;
     T := TTipoFreteUtilitario.DeInteiroParaEnumerado(self.FBuscaTipoFrete);
     
     case T of
        tfCIF: result := self.FFrete;
        tfFOB: result := 0;
     end;      
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetFrete: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaTipoFrete!');
   end;
end;

function TTotaisNotaFiscal.GetICMS: Real;
begin
   try
     result := self.FBuscaICMS;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetICMS: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaICMS!');
   end;
end;

function TTotaisNotaFiscal.GetICMSST: Real;
begin
   try
     result := self.FBuscaICMSST;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetICMSST: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaICMSST!');
   end;
end;

function TTotaisNotaFiscal.GetII: Real;
begin
   try
     result := self.FBuscaII;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetII: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaII!');
   end;
end;

function TTotaisNotaFiscal.GetIPI: Real;
begin
   try
     result := self.FBuscaIPI;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetIPI: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaIPI!');
   end;
end;

function TTotaisNotaFiscal.GetOutrasDespesas: Real;
begin
   result := self.FOutrasDespesas;
end;

function TTotaisNotaFiscal.GetSeguro: Real;
begin
   result := self.FSeguro;
end;

function TTotaisNotaFiscal.GetTotalNF: Real;
//var
//  TipoFrete :TTipoFrete;
begin
//   try
//     TipoFrete := TTipoFreteUtilitario.DeInteiroParaEnumerado(self.FBuscaTipoFrete);
//   except
//     on E: EAccessViolation do
//      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetTotalNF: Real'+#13+
//                              'Não foi possível realizar a chamada do método self.FBuscaTipoFrete!');
//   end;

   result := 0;

//   case TipoFrete of
//    tfCIF :
//           begin
              result := (
                            self.TotalProdutos
                          - self.Descontos
                          + self.ICMSST
                          + self.Frete
                          + self.Seguro
                          + self.OutrasDespesas
                          + self.II
                          + self.IPI
                          + 0 // self.ISS
                          + self.SubstTributaria
                        );
//           end;
//    tfFOB :
//           begin
//              result := (
//                            self.TotalProdutos
//                          - self.Descontos
//                          + self.ICMSST
//                          + self.Seguro
//                          + self.OutrasDespesas
//                          + self.II
//                          + self.IPI
//                          + 0 // self.ISS
//                        );
//           end;
//    else raise TExcecaoParametroInvalido.Create(self.ClassName, 'GetTotalNF: Real;', 'GetTotalNF');
//    end;

   if (result < 0) then result := 0;
end;

function TTotaisNotaFiscal.GetTotalProdutos: Real;
begin
   try
     result := self.FBuscaTotalProdutos;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('TTotaisNotaFiscal.GetTotalProdutos: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaTotalProdutos!');
   end;
end;

procedure TTotaisNotaFiscal.SomarDescontoAoTotal(Desconto: Real);
begin
   self.ValidarDesconto(Desconto);
   self.FDescontos := (self.FDescontos + Desconto);
   self.AlterarDescontoItens;
end;

procedure TTotaisNotaFiscal.SomarFreteAoTotal(Frete: Real);
begin
   self.ValidarFrete(Frete);
   self.FFrete := (self.FFrete + Frete);
   self.AlterarFreteItens;
end;

procedure TTotaisNotaFiscal.SomarOutrasDespesasAoTotal(
  OutrasDespesas: Real);
begin
   self.ValidarOutrasDespesas(OutrasDespesas);
   self.FOutrasDespesas := (self.FOutrasDespesas + OutrasDespesas);
   self.AlterarOutrasDespesasItens;
end;

procedure TTotaisNotaFiscal.SubtrairDescontoDoTotal(Desconto: Real);
begin
   self.ValidarDesconto(Desconto);
   self.FDescontos := (self.FDescontos - Desconto);

   if (self.FDescontos < 0) then
    self.FDescontos := 0;

   self.AlterarDescontoItens;
end;

procedure TTotaisNotaFiscal.SubtrairFreteDoTotal(Frete: Real);
begin
   self.ValidarFrete(Frete);
   self.FFrete := (self.FFrete - Frete);

   if (self.FFrete < 0) then
    self.FFrete := 0;

   self.AlterarFreteItens;
end;

procedure TTotaisNotaFiscal.SubtrairOutrasDespesasDoTotal(
  OutrasDespesas: Real);
begin
   self.ValidarOutrasDespesas(OutrasDespesas);
   self.FOutrasDespesas := (self.FOutrasDespesas - OutrasDespesas);

   if (self.FOutrasDespesas < 0) then
    self.FOutrasDespesas := 0;

   self.AlterarOutrasDespesasItens;
end;

procedure TTotaisNotaFiscal.ValidarDesconto(Desconto: Real);
begin
   if (Desconto < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ValidarDesconto(Desconto: Real)', 'Desconto');
end;

procedure TTotaisNotaFiscal.ValidarFrete(Frete: Real);
begin
   if (Frete < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ValidarFrete(Frete: Real)', 'Frete');
end;

procedure TTotaisNotaFiscal.ValidarOutrasDespesas(OutrasDespesas: Real);
begin
   if (OutrasDespesas < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ValidarOutrasDespesas(OutrasDespesas: Real)', 'OutrasDespesas');
end;

procedure TTotaisNotaFiscal.ValidarSeguro(Seguro: Real);
begin
   if (Seguro < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'ValidarSeguro(Seguro: Real)', 'Seguro');
end;

function TTotaisNotaFiscal.GetPIS: Real;
begin
   try
     result := self.FBuscaPIS;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetPIS: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaPIS!');
   end;
end;

function TTotaisNotaFiscal.GetFreteCalculado: Real;
begin
   result := self.FFrete;
end;

procedure TTotaisNotaFiscal.AdicionarAtualizarDescontoItens(
  Atualizador: TAtualizadorItens);
begin
   self.FAtualizarDescontoItens := Atualizador;
end;

procedure TTotaisNotaFiscal.AdicionarAtualizarFreteItens(
  Atualizador: TAtualizadorItens);
begin
   self.FAtualizarFreteItens := Atualizador;
end;

procedure TTotaisNotaFiscal.AdicionarAtualizarOutrasDespesasItens(
  Atualizador: TAtualizadorItens);
begin
   self.FAtualizarOutrasDespesasItens := Atualizador;
end;

procedure TTotaisNotaFiscal.AdicionarAtualizarSeguroItens(
  Atualizador: TAtualizadorItens);
begin
   self.FAtualizarSeguroItens := Atualizador;
end;

procedure TTotaisNotaFiscal.AlterarDescontoItens;
begin
   if not Assigned(self.FAtualizarDescontoItens) then exit;

   self.FAtualizarDescontoItens;
end;

procedure TTotaisNotaFiscal.AlterarFreteItens;
begin
   if not Assigned(self.FAtualizarFreteItens) then Exit;

   self.FAtualizarFreteItens;
end;

procedure TTotaisNotaFiscal.AlterarOutrasDespesasItens;
begin
   if not Assigned(self.FAtualizarDescontoItens) then exit;

   self.FAtualizarDescontoItens;
end;

procedure TTotaisNotaFiscal.AlterarSeguroItens;
begin
   if not Assigned(self.FAtualizarSeguroItens) then exit;
   
   self.FAtualizarSeguroItens;
end;

procedure TTotaisNotaFiscal.SomarSeguroAoTotal(Seguro: Real);
begin
   self.ValidarSeguro(Seguro);
   self.FSeguro := (self.FSeguro + Seguro);
   self.AlterarSeguroItens;
end;

procedure TTotaisNotaFiscal.SubtrairSeguroDoTotal(Seguro: Real);
begin
   self.ValidarSeguro(Seguro);
   self.FSeguro := (self.FSeguro - Seguro);

   if (self.FSeguro < 0) then
    self.FSeguro := 0;

   self.AlterarSeguroItens;
end;

procedure TTotaisNotaFiscal.AdicionarAtualizarNotaFiscal(
  Atualizador: TNotifyEvent);
begin
   self.FAtualizarNotaFiscal := Atualizador;
end;

procedure TTotaisNotaFiscal.SetPercentualDescontoFatura(const Value: Real);
begin
  FPercentualDescontoFatura := Value;
end;

procedure TTotaisNotaFiscal.SetBaseCalculoICMS(const Value: Real);
begin
  FBaseCalculoICMS := Value;
end;

procedure TTotaisNotaFiscal.SetBaseCalculoST(const Value: Real);
begin
  FBaseCalculoST := Value;
end;

procedure TTotaisNotaFiscal.SetICMS(const Value: Real);
begin
  FICMS := Value;
end;

procedure TTotaisNotaFiscal.SetICMSST(const Value: Real);
begin
  FICMSST := Value;
end;

procedure TTotaisNotaFiscal.SetCOFINS(const Value: Real);
begin
  FCOFINS := Value;
end;

procedure TTotaisNotaFiscal.SetIpi(const Value: Real);
begin
  FIPI := Value;
end;

procedure TTotaisNotaFiscal.SetPIS(const Value: Real);
begin
  FPIS := Value;
end;

procedure TTotaisNotaFiscal.SetTotalNF(const Value: Real);
begin
  FTotalNF := Value;
end;

procedure TTotaisNotaFiscal.SetTotalProdutos(const Value: Real);
begin
  FTotalProdutos := Value;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorICMSFCP(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaICMSFCP := Buscador;
end;

function TTotaisNotaFiscal.GetICMSFCP: Real;
begin
   try
     result := self.FBuscaICMSFCP;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetICMSFCP: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaICMSFCP!');
   end;

end;

procedure TTotaisNotaFiscal.AdicionarBuscadorICMSUFDest(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaICMSUFDest := Buscador;
end;

procedure TTotaisNotaFiscal.AdicionarBuscadorICMSUFRemet(
  Buscador: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscaICMSUFRemet := Buscador;
end;

function TTotaisNotaFiscal.GetICMSUFDest: Real;
begin
   try
     result := self.FBuscaICMSUFDest;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetICMSUFDest: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaICMSUFDest!');
   end;

end;

function TTotaisNotaFiscal.GetICMSUFRemet: Real;
begin
   try
     result := self.FBuscaICMSUFRemet;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTotaisNotaFiscal.GetICMSUFRemet: Real'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscaICMSUFRemet!');
   end;
end;

end.
