unit Movimento;

interface

uses
  SysUtils,
  Contnrs, Pedido, Generics.Collections;

type
  TMovimento = class

  private
    Fcodigo_caixa: integer;
    Fcodigo: integer;
    Ftipo_moeda: integer;
    Fcodigo_pedido: integer;
    Fdata: TDateTime;
    FPedido :TPedido;
    FValor_PAgo :Real;

    function GetPedido: TPedido;

  public
    property codigo        :integer   read Fcodigo        write Fcodigo;
    property codigo_caixa  :integer   read Fcodigo_caixa  write Fcodigo_caixa;
    property tipo_moeda    :integer   read Ftipo_moeda    write Ftipo_moeda;
    property codigo_pedido :integer   read Fcodigo_pedido write Fcodigo_pedido;
    property data          :TDateTime read Fdata          write Fdata;
    property valor_pago    :Real      read FValor_pago    write FValor_pago;

  public
    class function MovimentosDoPedido(codigo_pedido :integer):TObjectList<TMovimento>;

  private
    destructor Destroy;override;
  public
    property Pedido        :TPedido   read GetPedido;
end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoMovimentosPorCodigoPedido;

{ TMovimento }

destructor TMovimento.Destroy;
begin
  if assigned(self.FPedido) then
    FreeAndNil(FPedido);
  inherited;
end;

function TMovimento.GetPedido: TPedido;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FPedido) then begin
        Repositorio    := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
        self.FPedido   := TPedido( Repositorio.Get(self.Fcodigo_pedido) );
      end;

      result := self.FPedido;

   finally
     FreeAndNil(Repositorio);
   end;
end;

class function TMovimento.MovimentosDoPedido(codigo_pedido :integer): TObjectList<TMovimento>;
var repositorio :TRepositorio;
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
begin
  try
    repositorio   := nil;
    Especificacao := nil;
    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create( codigo_pedido );

    result        := repositorio.GetListaPorEspecificacao<TMovimento>( Especificacao );
  finally
    FreeAndNil(repositorio);
    FreeAndNil(Especificacao);
  end;
end;

end.
 