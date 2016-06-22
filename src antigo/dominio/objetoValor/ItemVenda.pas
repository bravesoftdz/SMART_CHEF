unit ItemVenda;

interface

uses
  Contnrs,
  Produto,
  CSOSNTributadoSNSemCredito, Funcoes;

type
  TItens = class;
  TItem = class;
  TGetCodigoVenda = function :Integer of Object;

  TItens = class(TObjectList)

  private
    function GetItem(Index :Integer) :TItem;
    procedure SetItem(Index :Integer; Value: TItem);

  public
    constructor Create;

  public
    procedure Add(Item :TItem);

  public
    function GetLast :TItem;

  public
    property Items[Index: Integer]: TItem read GetItem write SetItem; default;
    property Last :TItem read GetLast;
end;

  TItem = class

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

procedure TItens.Add(Item :TItem);
begin
  inherited Add(Item);
end;

constructor TItens.Create;
begin
   inherited Create(true);
end;

function TItens.GetItem(Index: Integer): TItem;
begin
  result := TItem(inherited GetItem(Index));
end;

function TItens.GetLast: TItem;
begin
   result := TItem(inherited Last);
end;

procedure TItens.SetItem(Index: Integer; Value: TItem);
begin
  inherited SetItem(Index, Value);
end;

{ TItem }

constructor TItem.Create(CodigoProduto: Integer; ValorUnitario: Real; Quantidade: Real);
begin
   FCodigoProduto := CodigoProduto;
   FValorUnitario := ValorUnitario;
   FQuantidade    := Quantidade;

   FProduto       := nil;
 //  FCST00         := nil;
end;

destructor TItem.Destroy;
begin
   FreeAndNil(FCSOSN02);
   
   inherited;
end;

function TItem.GetCodigoVenda: Integer;
begin
   if (FCodigoVenda = 0) and Assigned(FGetCodigoVenda) then begin
    FCodigoVenda := FGetCodigoVenda;
   end;

   result := FCodigoVenda;
end;

function TItem.GetCSOSN02: TCSOSNTributadoSNSemCredito;
begin
   if (Produto.tipo = 'P') then
     FCSOSN02 := TCSOSNTributadoSNSemCredito.Create(Produto.icms, Total);

   result := FCSOSN02;
end;

function TItem.GetProduto: TProduto;
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

function TItem.GetTotal: Real;
begin
   result := (Quantidade * ValorUnitario);
end;

function TItem.GetValorImpostos: Real;
begin
  result := ( self.Produto.NcmIBPT.aliqnacional_ibpt * (self.FQuantidade * self.FValorUnitario) )/100;
  result := Arredonda(result);
end;

procedure TItem.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TItem.SetCSOSN02(const Value: TCSOSNTributadoSNSemCredito);
begin
  FCSOSN02 := Value;
end;

procedure TItem.SomarQuantidade(QuantidadeParaSomar: Real);
begin
   FQuantidade := FQuantidade + QuantidadeParaSomar;
end;

end.
