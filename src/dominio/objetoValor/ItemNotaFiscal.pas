unit ItemNotaFiscal;

interface

uses
 // MetodoDelegadoObtemCampoInteger,
  Produto,
  NaturezaOperacao,
  TipoOrigemMercadoria,
  Icms00,
  IcmsSn101,
  IpiTrib,
  IpiNt,
  PisAliq,
  PisNt,
  CofinsAliq,
  CofinsNt,
  Objeto, Funcoes, pcnConversao;

type
  TItemNotaFiscal = class(TObjeto)

  private
    FCodigo                     :Integer;
    FCodigoNotaFiscal           :Integer;
    FCodigoProduto              :Integer;
    FCodigoNaturezaOperacao     :Integer;

    FPercentualFrete            :Real;
    FPercentualSeguro           :Real;
    FPercentualDesconto         :Real;
    FPercentualOutrasDespesas   :Real;

    FProduto                    :TProduto;
    FNaturezaOperacao           :TNaturezaOperacao;
    FQuantidade                 :Real;
    FUnidade                    :String;
    FValorUnitario              :Real;
    FValorBruto                 :Real;
    FValorDesconto              :Real;
    FValorFrete                 :Real;
    FValorOutrasDespesas        :Real;
    FValorSeguro                :Real;

    { Tributação }
      { Lucro Presumido }

    FIcms00       :TIcms00;
    FIpiTrib      :TIpiTrib;
    FPisAliq      :TPisAliq;
    FCofinsAliq   :TCofinsAliq;

    { Simples Nacional }
    FIcmsSn101    :TIcmsSn101;
    FIpiNt        :TIpiNt;
    FPisNt        :TPisNt;
    FCofinsNt     :TCofinsNt;

    procedure SetQuantidade(const Value: Real);
    procedure SetUnidade(const Value: String);
    procedure SetValorBruto(const Value: Real);
    procedure SetValorDesconto(const Value: Real);
    procedure SetValorFrete(const Value: Real);
    procedure SetValorOutrasDespesas(const Value: Real);
    procedure SetValorSeguro(const Value: Real);
    procedure SetValorUnitario(const Value: Real);
    procedure SetIcms00(const Value: TIcms00);
    procedure SetIcmsSn101(const Value: TIcmsSn101);
    procedure SetIpiTrib(const Value: TIpiTrib);
    procedure SetCofinsAliq(const Value: TCofinsAliq);
    procedure SetPisAliq(const Value: TPisAliq);

  private
    function GetCodigo                 :Integer;
    function GetNaturezaOperacao       :TNaturezaOperacao;
    function GetProduto                :TProduto;
    function GetUnidade                :String;
    function GetValorBruto             :Real;
    function GetValorLiquido           :Real;

    { Tributação }
      { Lucro Presumido }
      function GetIcms00     :TIcms00;
      function GetIpiTrib    :TIpiTrib;
      function GetPisAliq    :TPisAliq;
      function GetCofinsAliq :TCofinsAliq;

      { Simples Nacional }
      function GetIcmsSn101  :TIcmsSn101;
      function GetIpiNt      :TIpiNt;
      function GetPisNt      :TPisNt;
      function GetCofinsNt   :TCofinsNt;

    { Totais }
    function GetBaseCalculoICMS     :Real;
    function GetValorICMS           :Real;
    function GetValorIPI            :Real;
    function GetValorPIS            :Real;
    function GetValorCOFINS         :Real;
    function GetValorDesconto       :Real;
    function GetValorFrete          :Real;
    function GetValorOutrasDespesas :Real;
    function GetValorSeguro         :Real;
    function GetValorTotalItem      :Real;

  public
    function getCsosnEnumeradoToString(csosn: TpcnCSOSNIcms): String;
    function getCstEnumeradoToString(cst: TpcnCSTIcms): String;

  private
    procedure SetCodigo(const Value: Integer);

  private
    constructor Create(Produto           :TProduto;
                       NaturezaOperacao  :TNaturezaOperacao;
                       Quantidade,
                       ValorUnitario     :Real);

  public
    function Equals(Objeto :TObjeto) :Boolean;override;
    constructor CriaLucroPresumido(Produto                   :TProduto;
                                   NaturezaOperacao          :TNaturezaOperacao;
                                   Quantidade                :Real;
                                   ValorUnitario             :Real;
                                   OrigemMercadoria          :TTipoOrigemMercadoria;
                                   AliquotaICMS              :Real;
                                   AliquotaIPI               :Real;
                                   AliquotaPIS               :Real;
                                   AliquotaCOFINS            :Real;
                                   PercReducaoBC             :Real);

    constructor CriaSimplesNacional(Produto                :TProduto;
                                    NaturezaOperacao       :TNaturezaOperacao;
                                    Quantidade             :Real;
                                    ValorUnitario          :Real;
                                    OrigemMercadoria       :TTipoOrigemMercadoria;
                                    AliquotaCreditoSN      :Real);

    constructor CriaParaRepositorio(Codigo                 :Integer;
                                    CodigoNotaFiscal       :Integer;
                                    CodigoProduto          :Integer;
                                    CodigoNaturezaOperacao :Integer;
                                    Quantidade             :Real;
                                    ValorUnitario          :Real);

    destructor Destroy; override;

  public
    function IsMesmoProduto           (Item :TItemNotaFiscal) :Boolean;
    function IsMesmoProdutoEQuantidade(Item :TItemNotaFiscal) :Boolean;

  public
 //   procedure AdicionarBuscadorCodigoNotaFiscal     (Buscador :TMetodoDelegadoObtemCampoInteger);

    procedure CarregarImpostos;

    procedure SetPercentualFrete          (P :Real);
    procedure SetPercentualSeguro         (P :Real);
    procedure SetPercentualDesconto       (P :Real);
    procedure SetPercentualOutrasDespesas (P :Real);

    procedure SomarQuantidade   (QuantidadeASomar    :Real);
    procedure SubtrairQuantidade(QuantidadeASubtrair :Real);

  public
    property Codigo               :Integer           read GetCodigo                 write SetCodigo;
    property CodigoNotaFiscal     :Integer           read FCodigoNotaFiscal         write FCodigoNotaFiscal;
    property CodigoProduto        :integer           read FCodigoProduto            write FCodigoProduto;
    property Produto              :TProduto          read GetProduto;
    property NaturezaOperacao     :TNaturezaOperacao read GetNaturezaOperacao       write FNaturezaOperacao;
    property CodigoNaturezaOperacao :Integer         read FCodigoNaturezaOperacao   write FCodigoNaturezaOperacao;
    property Unidade              :String            read GetUnidade                write SetUnidade;
    property Quantidade           :Real              read FQuantidade               Write SetQuantidade;
    property ValorUnitario        :Real              read FValorUnitario            write SetValorUnitario;
    property ValorLiquido         :Real              read GetValorLiquido;
    
    { Tributação }
      { Lucro Presumido }
      property Icms00       :TIcms00      read GetIcms00      write SetIcms00;
      property IpiTrib      :TIpiTrib     read GetIpiTrib;
      property PisAliq      :TPisAliq     read GetPisAliq;
      property CofinsAliq   :TCofinsAliq  read GetCofinsAliq;

      { Simples Nacional }
      property IcmsSn101    :TIcmsSn101   read GetIcmsSn101;
      property IpiNt        :TIpiNt       read GetIpiNt;
      property PisNt        :TPisNt       read GetPisNt;
      property CofinsNt     :TCofinsNt    read GetCofinsNt;

    { Totais }
    property BaseCalculoICMS      :Real read GetBaseCalculoICMS;
    property ValorICMS            :Real read GetValorICMS;
    property ValorBruto           :Real read GetValorBruto             write SetValorBruto;
    property ValorFrete           :Real read GetValorFrete             write SetValorFrete;
    property ValorSeguro          :Real read GetValorSeguro            write SetValorSeguro;
    property ValorDesconto        :Real read GetValorDesconto          write SetValorDesconto;
    property ValorIPI             :Real read GetValorIPI;
    property ValorPIS             :Real read GetValorPIS;
    property ValorCOFINS          :Real read GetValorCOFINS;
    property ValorOutrasDespesas :Real read GetValorOutrasDespesas    write SetValorOutrasDespesas;
    property ValorTotalItem       :Real read GetValorTotalItem; { Compõe o total da NF-e }

end;

implementation

uses
  ExcecaoParametroInvalido,
  Repositorio,
  FabricaRepositorio,
  SysUtils, TributacaoItemNotaFiscal, Math;

{ TItemNotaFiscal }

procedure TItemNotaFiscal.CarregarImpostos;
begin
   self.Icms00;
   self.IpiTrib;
   self.PisAliq;
   self.CofinsAliq;
   self.IcmsSn101;
   self.IpiNt;
   self.PisNt;
   self.CofinsNt;
end;

constructor TItemNotaFiscal.Create(Produto           :TProduto;
                                   NaturezaOperacao  :TNaturezaOperacao;
                                   Quantidade,
                                   ValorUnitario     :Real);
const
  NOME_DO_METODO = 'Create(Produto                   :TProduto;             '+
                   '       NaturezaOperacao          :TNaturezaOperacao;    '+
                   '       Quantidade                :Real;                 '+
                   '       ValorUnitario             :Real)                 ';

begin
   self.FCodigo                   := 0;
   self.FPercentualFrete          := 0;
   self.FPercentualSeguro         := 0;
   self.FPercentualDesconto       := 0;
   self.FPercentualOutrasDespesas := 0;
   self.FProduto                  := nil;
   self.FNaturezaOperacao         := nil;
   self.FQuantidade               := 0;
   self.FValorUnitario            := 0;
   self.FUnidade                  := '';

   { Tributação }
      { Lucro Presumido }
      FIcms00       := nil;
      FIpiTrib      := nil;
      FPisAliq      := nil;
      FCofinsAliq   := nil;

      { Simples Nacional }
      FIcmsSn101    := nil;
      FIpiNt        := nil;
      FPisNt        := nil;
      FCofinsNt     := nil;

   if not Assigned(Produto)          then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'Produto');

   if not Assigned(NaturezaOperacao) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'NaturezaOperacao');

   if (Quantidade <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'Quantidade');

   if (ValorUnitario <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'ValorUnitario');

   self.FCodigoProduto          := Produto.Codigo;
 //  self.FUnidade                := Produto.UnidadeMedida;
   self.FCodigoNaturezaOperacao := NaturezaOperacao.Codigo;
   self.FQuantidade             := Quantidade;
   self.FValorUnitario          := ValorUnitario;
end;

constructor TItemNotaFiscal.CriaLucroPresumido(Produto: TProduto;
  NaturezaOperacao: TNaturezaOperacao; Quantidade, ValorUnitario :Real;
  OrigemMercadoria: TTipoOrigemMercadoria;
  AliquotaICMS, AliquotaIPI, AliquotaPIS, AliquotaCOFINS, PercReducaoBC: Real);
const
  NOME_DO_METODO = ' TItemNotaFiscal.CriaLucroPresumido(Produto: TProduto;                     '+
                   '  NaturezaOperacao: TNaturezaOperacao; Quantidade, ValorUnitario :Real;    '+
                   '  OrigemMercadoria: TTipoOrigemMercadoria;                                 '+
                   '  PercentualReducaoICMS, AliquotaICMS, AliquotaIPI, AliquotaCOFINS: Real); ';
begin
   self.Create(Produto, NaturezaOperacao, Quantidade, ValorUnitario);

   if (AliquotaICMS <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'AliquotaICMS');

   if (AliquotaIPI < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'AliquotaIPI');

   if (AliquotaPIS <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'AliquotaPIS');

   if (AliquotaCOFINS <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'AliquotaCOFINS');


   self.FIcms00           := TIcms00.Create(OrigemMercadoria,
                                            AliquotaICMS,
                                            PercReducaoBC,
                                            self.GetValorLiquido,
                                            self.GetCodigo);

   if NaturezaOperacao.suspensao_icms = 'S' then
     self.FIcms00.Aliquota  := 0;



   self.FIpiTrib          := TIpiTrib.Create(AliquotaIPI,
                                             self.GetValorLiquido,
                                             self.GetCodigo);


   self.FPisAliq          := TPisAliq.Create(AliquotaPIS,
                                             self.GetValorLiquido,
                                             self.GetCodigo);

   if NaturezaOperacao.suspensao_icms = 'S' then
     self.FPisAliq.Aliquota := 0;

   self.FCofinsAliq       := TCofinsAliq.Create(AliquotaCOFINS,
                                                self.GetValorLiquido,
                                                self.GetCodigo);

   if NaturezaOperacao.suspensao_icms = 'S' then
     self.FCofinsAliq.Aliquota :=0;

end;

constructor TItemNotaFiscal.CriaParaRepositorio(Codigo: Integer; CodigoNotaFiscal :Integer;
  CodigoProduto, CodigoNaturezaOperacao: Integer; Quantidade, ValorUnitario: Real);
begin
   self.FCodigo                 := Codigo;
   self.FCodigoNotaFiscal       := CodigoNotaFiscal;
   self.FCodigoProduto          := CodigoProduto;
   self.FCodigoNaturezaOperacao := CodigoNaturezaOperacao;
   self.FQuantidade             := Quantidade;
   self.FValorUnitario          := ValorUnitario;

   self.FIcms00     := nil;
   self.FIcmsSn101  := nil;
   self.FIpiTrib    := nil;
   self.FIpiNt      := nil;
   self.FPisAliq    := nil;
   self.FPisNt      := nil;
   self.FCofinsAliq := nil;
   self.FCofinsNt   := nil;
end;

function TItemNotaFiscal.getCsosnEnumeradoToString(
  csosn: TpcnCSOSNIcms): String;
begin
  result := EnumeradoToStr(csosn, ['', '101' ,'102', '103', '201', '202', '203', '300', '400', '500', '900'],
                                [csosnVazio, csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500,csosn900]);
end;

function TItemNotaFiscal.getCstEnumeradoToString(cst: TpcnCSTIcms): String;
begin
  result := EnumeradoToStr(cst, ['00' , '10' , '20' , '30' , '40' , '41' , '50' , '51' , '60' , '70' , '80' , '81', '90', '10', '90', '41', '90', 'SN'],
                                [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90, cstPart10 , cstPart90 , cstRep41, cstICMSOutraUF, cstICMSSN]);
end;

constructor TItemNotaFiscal.CriaSimplesNacional(Produto: TProduto;
  NaturezaOperacao: TNaturezaOperacao; Quantidade, ValorUnitario :real;
  OrigemMercadoria: TTipoOrigemMercadoria; AliquotaCreditoSN: Real);
const
  NOME_DO_METODO = 'CriaSimplesNacional(Produto: TProduto;                          '+
                   '                    NaturezaOperacao: TNaturezaOperacao;        '+
                   '                    Quantidade,                                 '+
                   '                    ValorUnitario :real;                        '+
                   '                    OrigemMercadoria: TTipoOrigemMercadoria;    '+
                   '                    AliquotaCreditoSN: Real);                   ' ;
begin
   self.Create(Produto, NaturezaOperacao, Quantidade, ValorUnitario);

  { if (AliquotaCreditoSN <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'AliquotaCreditoSN'); fabricio}

   self.FIcmsSn101 := TIcmsSn101.Create(OrigemMercadoria,
                                        AliquotaCreditoSN,
                                        self.GetValorLiquido,
                                        self.GetCodigo); // tirado a aliquota pq simples nao gera credito, e a aliq de credito somente nos dados adicionais da nota "AliquotaCreditoSN"

   self.FIpiNt     := TIpiNt.Create(self.GetValorLiquido, self.GetCodigo);
   self.FPisNt     := TPisNt.Create(self.GetValorLiquido, self.GetCodigo);
   self.FCofinsNt  := TCofinsNt.Create(self.GetValorLiquido, self.GetCodigo);
end;

destructor TItemNotaFiscal.Destroy;
begin
   FreeAndNil(FProduto);
   FreeAndNil(FNaturezaOperacao);
   FreeAndNil(FIcms00);
   FreeAndNil(FIpiTrib);
   FreeAndNil(FPisAliq);
   FreeAndNil(FCofinsAliq);
   FreeAndNil(FIcmsSn101);
   FreeAndNil(FIpiNt);
   FreeAndNil(FPisNt);
   FreeAndNil(FCofinsNt);
   
   inherited;
end;

function TItemNotaFiscal.Equals(Objeto: TObjeto): Boolean;
begin
 Result := ((Objeto as TItemNotaFiscal).Codigo = self.Codigo);
end;

function TItemNotaFiscal.GetBaseCalculoICMS: Real;
begin
   result := 0;
   if not (NaturezaOperacao.suspensao_icms = 'S') then
     if Assigned(self.Icms00) then
       result := self.Icms00.BaseDeCalculo;
end;

function TItemNotaFiscal.GetCodigo: Integer;
begin
   result := self.FCodigo;
end;

function TItemNotaFiscal.GetCofinsAliq: TCofinsAliq;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FCofinsAliq) then begin
      Repositorio := nil;

      try
        Repositorio      := TFabricaRepositorio.GetRepositorio(TCofinsAliq.ClassName);
        self.FCofinsAliq := (Repositorio.Get(self.FCodigo) as TCofinsAliq);

        if Assigned(self.FCofinsAliq) then begin
          self.FCofinsAliq.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FCofinsAliq;
end;

function TItemNotaFiscal.GetCofinsNt: TCofinsNt;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FCofinsNt) then begin
      Repositorio := nil;

      try
        Repositorio    := TFabricaRepositorio.GetRepositorio(TCofinsNt.ClassName);
        self.FCofinsNt := (Repositorio.Get(self.FCodigo) as TCofinsNt);

        if Assigned(self.FCofinsNt) then begin
           self.FCofinsNt.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FCofinsNt;
end;

function TItemNotaFiscal.GetIcms00: TIcms00;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FIcms00) then begin
      Repositorio := nil;

      try
        Repositorio   := TFabricaRepositorio.GetRepositorio(TIcms00.ClassName);
        self.FIcms00  := (Repositorio.Get(self.FCodigo) as TIcms00);

        if Assigned(self.FIcms00) then begin
          self.FIcms00.BaseDeCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FIcms00;
end;

function TItemNotaFiscal.GetIcmsSn101: TIcmsSn101;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FIcmsSn101) then begin
      Repositorio := nil;

      try
        Repositorio     := TFabricaRepositorio.GetRepositorio(TIcmsSn101.ClassName);
        self.FIcmsSn101 := (Repositorio.Get(self.FCodigo) as TIcmsSn101);

       if Assigned(self.FIcmsSn101) then begin
          self.FIcmsSn101.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FIcmsSn101;
end;

function TItemNotaFiscal.GetIpiNt: TIpiNt;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FIpiNt) then begin
      Repositorio := nil;

      try
        Repositorio := TFabricaRepositorio.GetRepositorio(TIpiNt.ClassName);
        self.FIpiNt := (Repositorio.Get(self.FCodigo) as TIpiNt);

        if Assigned(self.FIpiNt) then begin
           self.FIpiNt.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FIpiNt;
end;

function TItemNotaFiscal.GetIpiTrib: TIpiTrib;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FIpiTrib) then begin
      Repositorio := nil;

      try
        Repositorio   := TFabricaRepositorio.GetRepositorio(TIpiTrib.ClassName);
        self.FIpiTrib := (Repositorio.Get(self.FCodigo) as TIpiTrib);

        if Assigned(self.FIpiTrib) then begin
          self.FIpiTrib.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FIpiTrib;
end;

function TItemNotaFiscal.GetNaturezaOperacao: TNaturezaOperacao;
var
  Repositorio :TRepositorio;
begin
   Repositorio := nil;

   if not Assigned(self.FNaturezaOperacao) then begin
     try
       Repositorio            := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
       self.FNaturezaOperacao := (Repositorio.Get(self.FCodigoNaturezaOperacao) as TNaturezaOperacao);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FNaturezaOperacao;
end;

function TItemNotaFiscal.GetPisAliq: TPisAliq;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FPisAliq) then begin
      Repositorio := nil;

      try
        Repositorio   := TFabricaRepositorio.GetRepositorio(TPisAliq.ClassName);
        self.FPisAliq := (Repositorio.Get(self.FCodigo) as TPisAliq);

        if Assigned(self.FPisAliq) then begin
          self.FPisAliq.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FPisAliq;
end;

function TItemNotaFiscal.GetPisNt: TPisNt;
var
  Repositorio :TRepositorio;
begin

   if not Assigned(self.FPisNt) then begin
      Repositorio := nil;

      try
        Repositorio := TFabricaRepositorio.GetRepositorio(TPisNt.ClassName);
        self.FPisNt := (Repositorio.Get(self.FCodigo) as TPisNt);

        if Assigned(self.FPisNt) then begin
           self.FPisNt.BaseCalculo := self.GetValorLiquido;
        end;
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FPisNt;
end;

function TItemNotaFiscal.GetProduto: TProduto;
var
  Repositorio :TRepositorio;
begin
   Repositorio := nil;

   if not Assigned(self.FProduto) then begin
     try
       Repositorio   := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
       self.FProduto := (Repositorio.Get(self.FCodigoProduto) as TProduto);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FProduto;
end;

function TItemNotaFiscal.GetUnidade: String;
begin
   result := self.FUnidade;
end;

function TItemNotaFiscal.GetValorBruto: Real;
begin
   result := (self.FValorUnitario * self.FQuantidade);
end;

function TItemNotaFiscal.GetValorCOFINS: Real;
begin
   result := 0;

   if Assigned(self.CofinsAliq) then
    result := self.CofinsAliq.Valor;
end;

function TItemNotaFiscal.GetValorDesconto: Real;
begin
   result := FValorDesconto;//Arredonda(((self.ValorBruto * self.FPercentualDesconto) / 100),2);
end;

function TItemNotaFiscal.GetValorFrete: Real;
begin
   result := FValorFrete;//((self.ValorBruto * self.FPercentualFrete) / 100);
end;

function TItemNotaFiscal.GetValorICMS: Real;
begin
   result := 0;

   if not (NaturezaOperacao.suspensao_icms = 'S') then
     if Assigned(self.Icms00) then
       result := self.Icms00.Valor;
end;

function TItemNotaFiscal.GetValorIPI: Real;
begin
   result := 0;

   if Assigned(self.IpiTrib) then
    result := self.IpiTrib.Valor;
end;

function TItemNotaFiscal.GetValorLiquido: Real;
begin
   result := (self.ValorBruto           +
              self.ValorFrete           +
              self.ValorSeguro          +
              self.ValorOutrasDespesas -
              self.ValorDesconto);
end;

function TItemNotaFiscal.GetValorOutrasDespesas: Real;
begin
   result := FValorOutrasDespesas;// ((self.ValorBruto * self.FPercentualOutrasDespesas) / 100);
end;

function TItemNotaFiscal.GetValorPIS: Real;
begin
   result := 0;

   if Assigned(self.PisAliq) then
    result := self.PisAliq.Valor; 
end;

function TItemNotaFiscal.GetValorSeguro: Real;
begin
   result := FValorSeguro;// ((self.ValorBruto * self.FPercentualSeguro) / 100);
end;

function TItemNotaFiscal.GetValorTotalItem: Real;
begin
   result := (  self.ValorBruto
              - self.ValorDesconto
              + self.ValorFrete
              + self.ValorSeguro
              + self.ValorOutrasDespesas
              + self.ValorIPI);
end;

function TItemNotaFiscal.IsMesmoProduto(Item: TItemNotaFiscal): Boolean;
begin
   result := (self.Produto.Codigo = Item.Produto.Codigo);
end;

function TItemNotaFiscal.IsMesmoProdutoEQuantidade(
  Item: TItemNotaFiscal): Boolean;
begin
   result := (self.IsMesmoProduto(Item) and (self.Quantidade = Item.Quantidade));
end;

procedure TItemNotaFiscal.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TItemNotaFiscal.SetCofinsAliq(const Value: TCofinsAliq);
begin
  FCofinsAliq := Value;
end;

procedure TItemNotaFiscal.SetIcms00(const Value: TIcms00);
begin
  FIcms00 := Value;
end;

procedure TItemNotaFiscal.SetIcmsSn101(const Value: TIcmsSn101);
begin
  FIcmsSn101 := Value;
end;

procedure TItemNotaFiscal.SetIpiTrib(const Value: TIpiTrib);
begin
  FIpiTrib := Value;
end;

procedure TItemNotaFiscal.SetPercentualDesconto(P: Real);
begin
   if (P < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetPercentualDesconto(P: Real)', 'P');

   self.FPercentualDesconto := P;
end;

procedure TItemNotaFiscal.SetPercentualFrete(P: Real);
begin
   if (P < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetPercentualFrete(P: Real)', 'P');

   self.FPercentualFrete := P;
end;

procedure TItemNotaFiscal.SetPercentualOutrasDespesas(P: Real);
begin
   if (P < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetPercentualOutrasDespesas(P: Real)', 'P');

   self.FPercentualOutrasDespesas := P;
end;

procedure TItemNotaFiscal.SetPercentualSeguro(P: Real);
begin
   if (P < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetPercentualSeguro(P: Real)', 'P');

   self.FPercentualSeguro := P;
end;

procedure TItemNotaFiscal.SetPisAliq(const Value: TPisAliq);
begin
  FPisAliq := Value;
end;

procedure TItemNotaFiscal.SetQuantidade(const Value: Real);
begin
  FQuantidade := Value;
end;

procedure TItemNotaFiscal.SetUnidade(const Value: String);
begin
  FUnidade := Value;
end;

procedure TItemNotaFiscal.SetValorBruto(const Value: Real);
begin
  FValorBruto := Value;
end;

procedure TItemNotaFiscal.SetValorDesconto(const Value: Real);
begin
  FValorDesconto := Value;
end;

procedure TItemNotaFiscal.SetValorFrete(const Value: Real);
begin
  FValorFrete := Value;
end;

procedure TItemNotaFiscal.SetValorOutrasDespesas(const Value: Real);
begin
  FValorOutrasDespesas := Value;
end;

procedure TItemNotaFiscal.SetValorSeguro(const Value: Real);
begin
  FValorSeguro := Value;
end;

procedure TItemNotaFiscal.SetValorUnitario(const Value: Real);
begin
  FValorUnitario := Value;
end;

procedure TItemNotaFiscal.SomarQuantidade(QuantidadeASomar: Real);
begin
   self.FQuantidade := (self.FQuantidade + QuantidadeASomar);
end;

procedure TItemNotaFiscal.SubtrairQuantidade(QuantidadeASubtrair: Real);
begin
   if (QuantidadeASubtrair > self.FQuantidade) then
    raise EInvalidOp.Create('Erro em: TItemNotaFiscal.SubtrairQuantidade(QuantidadeASubtrair: Real)'+#13+
                            'Não é possível remover uma quantidade a mais do que já existe no item!');

   self.FQuantidade := (self.FQuantidade - QuantidadeASubtrair);
end;

end.
