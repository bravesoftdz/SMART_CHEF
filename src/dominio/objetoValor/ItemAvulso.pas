unit ItemAvulso;

interface

uses
  Cor,
  Produto,
  Contnrs;

type
  TItemAvulso = class

  private
    FCodigo                     :Integer;
    FCodigoNotaFiscal           :Integer;
    FCodigoProduto              :Integer;
    FPreco                      :Real;
    FPercentualDesconto         :Real;
    FProduto                    :TProduto;
    FQuantidade                 :Real;

    procedure SetCodigo (const Value: Integer);
    procedure SetProduto(const Value: TProduto);

  private
    function GetCodigo           :Integer;
    function GetProduto          :TProduto;
    function GetValorBruto       :Real;
    function GetValorDesconto    :Real;
    function GetValorTotal       :Real;

  private
    procedure SetPercentualDesconto(const Value: Real);
    procedure SetPreco             (const Value: Real);

  public
    constructor Create;
    constructor CriaParaRepositorio(Codigo             :Integer;
                                    CodigoNotaFiscal   :Integer;
                                    CodigoProduto      :Integer;
                                    Preco              :Real;
                                    PercentualDesconto :Real;
                                    Quantidade         :Real);

  public
    destructor  Destroy; override;

  public
    property Codigo             :Integer      read GetCodigo           write SetCodigo;
    property CodigoNotaFiscal   :Integer      read FCodigoNotaFiscal   write FCodigoNotaFiscal;
    property Produto            :TProduto     read GetProduto          write SetProduto;
    property Preco              :Real         read FPreco              write SetPreco;
    property PercentualDesconto :Real         read FPercentualDesconto write SetPercentualDesconto;
    property Quantidade         :Real         read FQuantidade         write FQuantidade;
    property ValorBruto         :Real         read GetValorBruto;
    property ValorDesconto      :Real         read GetValorDesconto;
    property ValorTotal         :Real         read GetValorTotal;

end;

implementation

uses
  SysUtils,
  FabricaRepositorio,
  Repositorio;

{ TItemAvulso }

constructor TItemAvulso.Create;
begin
   self.FProduto      := nil;
end;

constructor TItemAvulso.CriaParaRepositorio(Codigo, CodigoNotaFiscal,
  CodigoProduto: Integer; Preco, PercentualDesconto, Quantidade :Real);
begin
   self.FCodigo               := Codigo;
   self.FCodigoNotaFiscal     := CodigoNotaFiscal;
   self.FCodigoProduto        := CodigoProduto;
   self.FPreco                := Preco;
   self.FPercentualDesconto   := PercentualDesconto;
   self.FQuantidade           := Quantidade;
end;

destructor TItemAvulso.Destroy;
begin
  FreeAndNil(self.FProduto);
  
  inherited;
end;

function TItemAvulso.GetCodigo: Integer;
begin
   result := self.FCodigo;
end;

function TItemAvulso.GetProduto: TProduto;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FProduto) then begin
     Repositorio := nil;

     try
       Repositorio   := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
       self.FProduto := (Repositorio.Get(self.FCodigoProduto) as TProduto);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FProduto;
end;

function TItemAvulso.GetValorBruto: Real;
begin
   result := (self.FPreco * self.Quantidade);
end;

function TItemAvulso.GetValorDesconto: Real;
begin
   result := ((self.ValorBruto * self.PercentualDesconto) / 100);
end;

function TItemAvulso.GetValorTotal: Real;
begin
   result := (self.ValorBruto - self.ValorDesconto);
end;

procedure TItemAvulso.SetCodigo(const Value: Integer);
begin
   self.FCodigo := Value;
end;

procedure TItemAvulso.SetPercentualDesconto(const Value: Real);
begin
  FPercentualDesconto := Value;
end;

procedure TItemAvulso.SetPreco(const Value: Real);
begin
  FPreco := Value;
end;

procedure TItemAvulso.SetProduto(const Value: TProduto);
begin
   FreeAndNil(self.FProduto);

   if Assigned(Value) then
    self.FCodigoProduto := Value.Codigo;
end;

end.
