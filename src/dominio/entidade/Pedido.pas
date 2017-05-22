unit Pedido;

interface

uses
  SysUtils,
  Contnrs,
  Usuario, Cliente, Item, Endereco, Generics.Collections, NFCe, Dialogs;

type
  TPedido = class

  private
    Fcodigo_comanda: integer;
    Fcodigo: integer;
    Fcodigo_mesa: integer;
    Fvalor_total: Real;
    Fobservacoes: String;
    Fcouvert: Real;
    Fdata: TDateTime;
    Fdesconto: Real;
    Facrescimo: Real;
    Fsituacao: String;
    FItens   :TObjectList<TItem>;
    FCriouListaItens :Boolean;
    FTaxa_servico :Real;
    FTipo_moeda  :String;
    FImprime_apos_salvar :Boolean;
    FNome_cliente :String;
    FTelefone     :String;
    FCpf_cliente  :String;
    FCLiente      :TCliente;
    FCodigo_endereco :integer;
    FEndereco  :TEndereco;
    FValor_pago: Real;
    FAgrupadas :String;
    FTaxa_entrega: Real;
    FSts_recebimento: String;
    FEmContingencia: String;
    FNFce  :TNFCe;

    function GetItens: TObjectList<TItem>;
    function GetTotal_produtos: Real;
    function GetTotal_servicos: Real;
    function GetCliente: TCliente;
    function GetEndereco: TEndereco;
    function GetPedidoEntrega :Boolean;
    function GetPedidoRetiradaLocal :Boolean;
    function GetNFCe: TNFCe;

  public
    property codigo          :integer   read Fcodigo          write Fcodigo;
    property codigo_comanda  :integer   read Fcodigo_comanda  write Fcodigo_comanda;
    property codigo_mesa     :integer   read Fcodigo_mesa     write Fcodigo_mesa;
    property data            :TDateTime read Fdata            write Fdata;
    property observacoes     :String    read Fobservacoes     write Fobservacoes;
    property situacao        :String    read Fsituacao        write Fsituacao;
    property couvert         :Real      read Fcouvert         write Fcouvert;
    property desconto        :Real      read Fdesconto        write Fdesconto;
    property acrescimo       :Real      read Facrescimo       write Facrescimo;
    property valor_total     :Real      read Fvalor_total     write Fvalor_total;
    property taxa_servico    :Real      read FTaxa_servico    write FTaxa_servico;
    property tipo_moeda      :String    read FTipo_moeda      write FTipo_moeda;
    property nome_cliente    :String    read FNome_cliente    write FNome_cliente;
    property telefone        :String    read FTelefone        write FTelefone;
    property cpf_cliente     :String    read FCpf_cliente     write FCpf_cliente;
    property Cliente         :TCliente  read GetCliente;
    property Codigo_endereco :Integer   read Fcodigo_endereco write FCodigo_endereco;
    property valor_pago      :Real      read FValor_pago      write FValor_pago;
    property Agrupadas       :String    read FAgrupadas       write FAgrupadas; 
    property taxa_entrega    :Real      read Ftaxa_entrega    write Ftaxa_entrega;
    property sts_recebimento :String    read FSts_recebimento write FSts_recebimento;
    property emContingencia  :String    read FEmContingencia  write FEmContingencia;

    property paraEntrega     :Boolean   read GetPedidoEntrega;
    property paraRetiradaLocal :Boolean   read GetPedidoRetiradaLocal;

  public
    property Itens           :TObjectList<TItem> read GetItens       write FItens;
    property Total_produtos  :Real      read GetTotal_produtos;
    property Total_servicos  :Real      read GetTotal_servicos;
    property Endereco        :TEndereco read GetEndereco;
    property NFCe            :TNFCe     read GetNFCe;

  public
    constructor Create;
    destructor  Destroy; override;

  public
    class function PedidoPorCodigo(codigo :integer) :TPedido;

end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoClientePorCpfCnpj, EspecificacaoItensDoPedido,
  Classes, Math, Funcoes;

{ TPedido }

constructor TPedido.Create;
begin
  inherited create;

  self.FCriouListaItens := false;
  self.FItens           := nil;
  FImprime_apos_salvar  := false;
end;

destructor TPedido.Destroy;
begin
  if self.FCriouListaItens and Assigned(self.FItens) then
    FreeAndNil(self.FItens);
  if assigned(FNFce) then
    FreeAndNil(FNFce);
  if assigned(FEndereco) then
    FreeAndNil(FEndereco);

  inherited;
end;

function TPedido.GetCliente: TCliente;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoClientePorCpfCnpj;
begin
   Repositorio    := nil;
   Especificacao  := nil;

   try
      if not Assigned(self.FCliente) then begin
        Especificacao         := TEspecificacaoClientePorCpfCnpj.Create(self.cpf_cliente);
        Repositorio           := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
        self.FCLiente         := TCliente(Repositorio.GetPorEspecificacao(Especificacao));
      end;

      result := self.FCLiente;
   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Repositorio);
   end;
end;

function TPedido.GetEndereco: TEndereco;
var repositorio :TRepositorio;
begin
  if not assigned(FEndereco) then begin
     repositorio := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
     FEndereco   := TEndereco( repositorio.Get( self.FCodigo_endereco ) );
  end;

  result := FEndereco;
end;

function TPedido.GetItens: TObjectList<TItem>;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoItensDoPedido;
begin
   Repositorio    := nil;
   Especificacao  := nil;

   try
      if not Assigned(self.FItens) then begin
        Especificacao         := TEspecificacaoItensDoPedido.Create(self);
        Repositorio           := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
        self.FItens           := Repositorio.GetListaPorEspecificacao<TItem>(Especificacao, 'CODIGO_PEDIDO ='+IntToStr(self.Codigo));
        FCriouListaItens      := true;
      end;

      result := self.FItens;
   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Repositorio);
   end;
end;

function TPedido.GetNFCe: TNFCe;
var repositorio :TRepositorio;
    codigoNfce  :integer;
begin
  repositorio := nil;
  codigoNfce  := StrToIntDef(Campo_por_campo('NFCE','CODIGO','CODIGO_PEDIDO', intToStr(Fcodigo)),0);
  try
    if not assigned(FNFce) and (codigoNfce > 0) then
    begin
      repositorio := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
      FNFce       := TNFCe(repositorio.Get(codigoNfce));
    end;

    result := FNFce;
  finally
    FreeAndNil(repositorio);
  end;
end;

function TPedido.GetPedidoEntrega: Boolean;
begin
  result := (self.Fcodigo_comanda = 0) and (self.FCodigo_endereco > 0);
end;

function TPedido.GetPedidoRetiradaLocal: Boolean;
begin
  result := (self.Fcodigo_comanda = 0) and (self.FCodigo_endereco = 0);
end;

function TPedido.GetTotal_produtos: Real;
var i :integer;
begin
  result := 0;

  for i := 0 to self.Itens.Count - 1 do
    if TItem(Itens.Items[i]).Produto.tipo = 'P' then
    begin
      result := result + (Itens.Items[i].valor_Unitario * Itens.Items[i].quantidade)
                       +  Itens.Items[i].quantidade * Itens.Items[i].totalAdicionais ;
    end;

end;

function TPedido.GetTotal_servicos: Real;
var i :integer;
begin
  result := 0;

  for i := 0 to self.Itens.Count - 1 do
    if TItem(Itens.Items[i]).Produto.tipo = 'S' then
      result := result + (TItem(Itens.Items[i]).valor_Unitario *
                         IfThen(((TItem(Itens.Items[i]).quantidade > 198)and(TItem(Itens.Items[i]).Fracionado = 'S')) or (TItem(Itens.Items[i]).quantidade > 599), 1, TItem(Itens.Items[i]).quantidade));
end;

class function TPedido.PedidoPorCodigo(codigo: integer): TPedido;
var repositorio :TRepositorio;
begin
  try
    repositorio := TFabricaRepositorio.GetRepositorio(self.ClassName);
    result      := TPedido(repositorio.Get(codigo));
  finally
    FreeAndNil(repositorio);
  end;
end;

end.
