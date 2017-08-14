unit ItemVenda;

interface

uses
  Contnrs,
  Produto,
  CSOSNTributadoSNSemCredito, Funcoes;

type
  TItens = class;
  TItemVenda = class;
  TGetCodigoVenda = function :Integer of Object;

  TItens = class(TObjectList)

  private
    function GetItem(Index :Integer) :TItemVenda;
    procedure SetItem(Index :Integer; Value: TItemVenda);

  public
    constructor Create;

  public
    procedure Add(Item :TItemVenda);

  public
    function GetLast :TItemVenda;

  public
    property Items[Index: Integer]: TItemVenda read GetItem write SetItem; default;
    property Last :TItemVenda read GetLast;
end;

  TItemVenda = class

  private
    FCodigoProduto :Integer;
    FProduto: TProduto;
    FQuantidade :Real;
    FValorUnitario :Real;
    FCodigo: Integer;
    FCodigoVenda :Integer;
    FGetCodigoVenda :TGetCodigoVenda;
    FCSOSN02: TCSOSNTributadoSNSemCredito;
    function GetCSOSN02: TCSOSNTributadoSNSemCredito;

  private
    function GetTotal: Real;
    function GetProduto: TProduto;
    function GetValorImpostos: Real;
    function GetCodigoVenda: Integer;

  private
    procedure SetCodigo(const Value: Integer);
    procedure SetCSOSN02(const Value: TCSOSNTributadoSNSemCredito);

  public
    property Codigo :Integer read FCodigo write SetCodigo;
    property Produto :TProduto read GetProduto;
    property Quantidade :Real read FQuantidade;
    property ValorUnitario :Real read FValorUnitario;
    property ValorImpostos :Real read GetValorImpostos;
    property CSOSN02 :TCSOSNTributadoSNSemCredito read GetCSOSN02 write SetCSOSN02;
    property Total :Real read GetTotal;

  public
    constructor Create(CodigoProduto: Integer;
                       ValorUnitario :Real;
                       Quantidade :Real); overload;

    destructor Destroy; override;
  public
    procedure SomarQuantidade(QuantidadeParaSomar :Real);
end;

implementation

uses
  Classes, Repositorio, FabricaRepositorio,
  SysUtils, NcmIBPT;

{ TItens }

procedure TItens.Add(Item :TItemVenda);
begin
  inherited Add(Item);
end;

constructor TItens.Create;
begin
   inherited Create(true);
end;

function TItens.GetItem(Index: Integer): TItemVenda;
begin
  result := TItemVenda(inherited GetItem(Index));
end;

function TItens.GetLast: TItemVenda;
begin
   result := TItemVenda(inherited Last);
end;

procedure TItens.SetItem(Index: Integer; Value: TItemVenda);
begin
  inherited SetItem(Index, Value);
end;

{ TItem }

constructor TItemVenda.Create(CodigoProduto: Integer; ValorUnitario: Real; Quantidade: Real);
begin
   FCodigoProduto := CodigoProduto;
   FValorUnitario := ValorUnitario;
   FQuantidade    := Quantidade;

   FProduto       := nil;
 //  FCST00         := nil;
end;

destructor TItemVenda.Destroy;
begin
   FreeAndNil(FCSOSN02);
   
   inherited;
end;

function TItemVenda.GetCodigoVenda: Integer;
begin
   if (FCodigoVenda = 0) and Assigned(FGetCodigoVenda) then begin
    FCodigoVenda := FGetCodigoVenda;
   end;

   result := FCodigoVenda;
end;

function TItemVenda.GetCSOSN02: TCSOSNTributadoSNSemCredito;
begin
   if (Produto.tipo <> 'S') then
     FCSOSN02 := TCSOSNTributadoSNSemCredito.Create(Produto.icms, Total);

   result := FCSOSN02;
end;

function TItemVenda.GetProduto: TProduto;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
     if not Assigned(FProduto) then begin
       Repositorio    := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
       self.FProduto  := TProduto( Repositorio.Get(self.FCodigoProduto) );
     end;

      result := self.FProduto;

   finally
     FreeAndNil(Repositorio);
   end;

   result := FProduto;
end;

function TItemVenda.GetTotal: Real;
begin
   result := (Quantidade * ValorUnitario);
end;

function TItemVenda.GetValorImpostos: Real;
begin
  result := ( self.Produto.NcmIBPT.aliqnacional_ibpt * (self.FQuantidade * self.FValorUnitario) )/100;
  result := Arredonda(result);
end;

procedure TItemVenda.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TItemVenda.SetCSOSN02(const Value: TCSOSNTributadoSNSemCredito);
begin
  FCSOSN02 := Value;
end;

procedure TItemVenda.SomarQuantidade(QuantidadeParaSomar: Real);
begin
   FQuantidade := FQuantidade + QuantidadeParaSomar;
end;

end.
