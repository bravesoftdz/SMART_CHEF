unit Venda;

interface

uses
  Produto,
  ItemVenda,
  FormaPagamento, Funcoes, Cliente;

type
  TVenda = class
  
  private
    FItens: TItens;
    FNumeroNFe: Integer;
    FData: TDateTime;
    FFormaPagamento: TFormaPagamento;
    FDesconto :Real;
    FAcrescimo: Real;
    FCodigo_pedido :integer;
    FCouvert :Real;
    FTx_servico :Real;
    FTotal_em_servicos :Real;
    FCpf_cliente :String;
    Fnome_cliente :String;
    FCliente :TCliente;
    FCodigo_endereco :Integer;
    FTaxa_entrega :Real;

  private
    procedure SetNumeroNFe(const Value: Integer);
    procedure SetData(const Value: TDateTime);
    procedure SetDesconto(const Value: Real);
    procedure SetAcrescimo(const Value: Real);

  private
    function GetTotal: Real;
    function GetIsEmpty: Boolean;
    function GetBaseIcms: Real;
    function GetIcms: Real;
    function GetBaseSt: Real;
    function GetSt: Real;
    function GetTotalBruto: Real;
    function GetFrete: Real;
    function GetSeguro: Real;
    function GetDesconto: Real;
    function GetCofins: Real;
    function GetPis: Real;
    function GetAcrescimo: Real;
    function GetTotalTributos :Real;
    function GetBaseISSQN: Real;
    function GetISSQN: Real;
    function GetTotalBrutoISSQN: Real;
    function GetCliente: TCliente;    

  public
    procedure AdicionarItem(CodigoProduto :Integer;
                            ValorUnitario :Real;
                            Quantidade :Real);
    procedure RemoverItem(Indice :Integer);
    procedure ValidarPreco;

  public
    function ObterItem(CodigoProduto: Integer) :TItemVenda;

  public
    property Data :TDateTime read FData write SetData;
    property NumeroNFe :Integer read FNumeroNFe write SetNumeroNFe;
    property Codigo_pedido :integer read FCodigo_pedido write FCodigo_pedido;
    property Itens :TItens read FItens;
    property IsEmpty :Boolean read GetIsEmpty;
    property BaseIcms :Real read GetBaseIcms;
    property Icms :Real read GetIcms;
    property BaseSt :Real read GetBaseSt;
    property St :Real read GetSt;
    property TotalBruto :Real read GetTotalBruto;
    property Frete :Real read GetFrete;
    property Seguro :Real read GetSeguro;
    property Desconto :Real read GetDesconto write SetDesconto;
    property Pis :Real read GetPis;
    property Cofins :Real read GetCofins;
    property Total :Real read GetTotal;
    property FormaPagamento :TFormaPagamento read FFormaPagamento;
    property Acrescimo :Real read GetAcrescimo write SetAcrescimo;
    property TotalTributos :Real read GetTotalTributos;
    property TotalBrutoISSQN :Real read GetTotalBrutoISSQN;
    property BaseISSQN :Real read GetBaseISSQN;
    property ISSQN :Real read GetISSQN;
    property Tx_servico :Real read FTx_servico write FTx_servico;
    property Couvert :REal read FCouvert write FCouvert;
    property Total_em_servicos :Real read FTotal_em_servicos write FTotal_em_servicos;
    property Taxa_entrega :Real read FTaxa_entrega write FTaxa_entrega;    

    property Cpf_cliente :String read FCpf_cliente write FCpf_cliente;
    property nome_cliente :String read Fnome_cliente write Fnome_cliente;
    property Cliente :TCliente read GetCliente;
    property Codigo_endereco :integer read FCodigo_endereco write FCodigo_endereco;

  public
    constructor Create;
    destructor Destroy; override;

end;

implementation

uses
  Classes,
  ExcecaoValorInvalido,
  SysUtils,
  Contnrs, math,
  CSTTributadoIntegralmente, NcmIBPT, CSOSNTributadoSNSemCredito,
  EspecificacaoClientePorCpfCnpj, FabricaRepositorio, Repositorio;

{ TVenda }

procedure TVenda.AdicionarItem(CodigoProduto: Integer; ValorUnitario: Real;
  Quantidade: Real);
var
  Item :TItemVenda;
begin
   if not Assigned(Itens) then
    FItens := TItens.Create;

   Item := ObterItem(CodigoProduto);

   if not Assigned(Item) or ( assigned(Item) and (Item.ValorUnitario <> ValorUnitario)) then begin
     Item := TItemVenda.Create(
      CodigoProduto,
      ValorUnitario,
      Quantidade);

     Itens.Add(Item);
   end
   else begin
     Item.SomarQuantidade(Quantidade);
   end;
end;

constructor TVenda.Create;
begin
   FItens := TItens.Create;
   FFormaPagamento := TFormaPagamento.Create;
   FData := Date;
   FNumeroNFe := 0;
   FTotal_em_servicos := 0;
end;

destructor TVenda.Destroy;
begin
   FreeAndNil(FItens);
   FreeAndNil(FFormaPagamento);

   inherited;
end;

function TVenda.GetAcrescimo: Real;
begin
   result := 0;
end;

function TVenda.GetBaseIcms: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        try
          if Itens.Items[nX].Produto.tipo <> 'S' then
            result := result + Itens.Items[nX].CSOSN02.Base;
        except
          continue;
        end;
      end;
   except
     result := 0;
   end;
end;

function TVenda.GetBaseISSQN: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        try
          if Itens.Items[nX].Produto.tipo = 'S' then
            result := result + Itens.Items[nX].CSOSN02.Base;
        except
          continue;
        end;
      end;
   except
     result := 0;
   end;

end;

function TVenda.GetBaseSt: Real;
begin
   result := 0;
end;

function TVenda.GetCliente: TCliente;
var Especificacao :TEspecificacaoClientePorCpfCnpj;
    repositorio :TRepositorio;
begin
  if not assigned(FCliente) then begin
    repositorio := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    Especificacao := TEspecificacaoClientePorCpfCnpj.Create(self.Cpf_cliente);
    FCliente      := TCliente(repositorio.GetPorEspecificacao(Especificacao));
  end;

  result := FCliente;
end;

function TVenda.GetCofins: Real;
begin
   result := 0;
end;

function TVenda.GetDesconto: Real;
begin
   result := FDesconto;
end;

function TVenda.GetFrete: Real;
begin
   result := 0;
end;

function TVenda.GetIcms: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        try
          if Itens.Items[nX].Produto.tipo <> 'S' then
            result := result + Itens.Items[nX].CSOSN02.Valor;
        except
          continue;
        end;
      end;
   except
     result := 0;
   end;
end;

function TVenda.GetIsEmpty: Boolean;
begin
   try
     result := (Itens.Count <= 0);
   except
     result := true;
   end;
end;

function TVenda.GetISSQN: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        try
          if Itens.Items[nX].Produto.tipo = 'S' then
            result := result + Itens.Items[nX].CSOSN02.Valor;
        except
          continue;
        end;
      end;
   except
     result := 0;
   end;

end;

function TVenda.GetPis: Real;
begin
   result := 0;
end;

function TVenda.GetSeguro: Real;
begin
   result := 0;
end;

function TVenda.GetSt: Real;
begin
   result := 0;
end;

function TVenda.GetTotal: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        result := result + Itens.Items[nX].Total;
      end;
   except
     result := 0;
   end;
end;

function TVenda.GetTotalBruto: Real;
var
  nX :Integer;
  total :real;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        if Itens.Items[nX].Produto.tipo <> 'S' then
          result := result + roundTo(Itens.Items[nX].Total,-2);
      end;
   except
     result := 0;
   end;
end;

function TVenda.GetTotalBrutoISSQN: Real;
var
  nX :Integer;
begin
   try
      result := 0;

      for nX := 0 to (Itens.Count-1) do begin
        if Itens.Items[nX].Produto.tipo = 'S' then
          result := result + Itens.Items[nX].Total;
      end;
   except
     result := 0;
   end;
end;

function TVenda.GetTotalTributos: Real;
var
  nX :Integer;
  imposto_item :Real;
begin
   try
      result        := 0;
      imposto_item  := 0;

      for nX := 0 to (Itens.Count-1) do begin
        if Itens.Items[nX].Produto.tipo <> 'S' then begin
          imposto_item := ((Itens.Items[nX].Produto.NcmIBPT.aliqnacional_ibpt * (Itens.Items[nX].Quantidade * Itens.Items[nX].ValorUnitario))/100);
          result := result + Arredonda( imposto_item );

        end;
      end;

   except
     result := 0;
   end;
end;

function TVenda.ObterItem(CodigoProduto: Integer): TItemVenda;
var
  nX :Integer;
begin
   result := nil;
   
   if not Assigned(Itens) then
    exit;

   for nX := 0 to (Itens.Count-1) do begin
    if (Itens.Items[nX].Produto.codigo = CodigoProduto) then begin
      result := Itens.Items[nX];
      exit;
    end;
   end;
end;

procedure TVenda.RemoverItem(Indice: Integer);
begin
   Itens.Delete(Indice-1);
end;

procedure TVenda.SetAcrescimo(const Value: Real);
begin
  FAcrescimo := Value;
end;

procedure TVenda.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TVenda.SetDesconto(const Value: Real);
begin
   FDesconto := Value;
end;

procedure TVenda.SetNumeroNFe(const Value: Integer);
begin
  FNumeroNFe := Value;
end;

procedure TVenda.ValidarPreco;
begin
   if (Total <= 0) then
    raise TExcecaoValorInvalido.Create('Realize a venda!');
end;

end.
