unit Item;

interface

uses
  SysUtils,
  Contnrs,
  Produto, Usuario, AdicionalItem;

type
  TItem = class

  private
    Fcodigo_pedido: integer;
    Fcodigo: integer;
    Fcodigo_produto: integer;
    Fhora: TDateTime;
    Fvalor: Real;
    FProduto :TProduto;
    Fquantidade: Real;
    FAdicionais :TObjectList;
    Fimpresso :String;
    FvalorUnitario :Real;
    FCodigo_usuario :integer;
    FUsuario :TUsuario;
    FFracionado :String;
    FQuantidade_pg :Real;
    FQtd_fracionado: Integer;
    FCancelado :String;
    FMotivoCancelamento :String;

    function GetProduto: TProduto;
    function GetAdicionais: TObjectList;

    destructor Destroy;override;
    function GetUsuario: TUsuario;
    function GetTotalAdicionais: Real;
    function GetTotalBruto: Real;
    function GetTotalLiquido: Real;

  public
    property codigo         :integer     read Fcodigo         write Fcodigo;
    property codigo_pedido  :integer     read Fcodigo_pedido  write Fcodigo_pedido;
    property codigo_produto :integer     read Fcodigo_produto write Fcodigo_produto;
    property hora           :TDateTime   read Fhora           write Fhora;
    property quantidade     :Real        read Fquantidade     write Fquantidade;
    property Adicionais     :TObjectList read GetAdicionais   write FAdicionais;
    property impresso       :String      read Fimpresso       write Fimpresso;
    property valor_Unitario  :Real       read FvalorUnitario  write FvalorUnitario;
    property codigo_usuario :integer     read FCodigo_usuario write FCodigo_usuario;
    property Fracionado     :String      read FFracionado     write FFracionado;
    property quantidade_pg  :Real        read FQuantidade_pg  write FQuantidade_pg;
    property qtd_fracionado :Integer     read FQtd_fracionado write FQtd_fracionado;
    property Cancelado       :String     read FCancelado      write FCancelado;
    property MotivoCancelamento       :String     read FMotivoCancelamento      write FMotivoCancelamento;
    property totalAdicionais :Real       read GetTotalAdicionais;
    property totalBruto      :Real       read GetTotalBruto;
    property totalLiquido    :Real       read GetTotalLiquido;

  public
    property Produto        :TProduto    read GetProduto;
    property Usuario        :TUsuario    read GetUsuario;
end;

implementation

uses Repositorio, FabricaRepositorio, EspecificacaoAdicionalDoItem;

{ TItem }

destructor TItem.Destroy;
begin
  if assigned(FAdicionais) then  FreeAndNil(FAdicionais);
  inherited;
end;

function TItem.GetAdicionais: TObjectList;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoAdicionalDoItem;
begin
   Repositorio    := nil;
   Especificacao  := nil;

   try
      if not Assigned(self.FAdicionais) then begin
        Especificacao         := TEspecificacaoAdicionalDoItem.Create(self);
        Repositorio           := TFabricaRepositorio.GetRepositorio(TAdicionalItem.ClassName);
        self.FAdicionais      := Repositorio.GetListaPorEspecificacao(Especificacao, 'CODIGO_ITEM ='+IntToStr(self.Codigo));
      end;

      result := self.FAdicionais;
   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Repositorio);
   end;
end;

function TItem.GetProduto: TProduto;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FProduto) then begin
        Repositorio           := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
        self.FProduto         := TProduto(Repositorio.Get(self.Fcodigo_produto));
      end;

      result := self.FProduto;
   finally
     FreeAndNil(Repositorio);
   end;
end;


function TItem.GetTotalAdicionais: Real;
var i :integer;
begin
  result := 0;

  if assigned(Adicionais) and (Adicionais.Count > 0) then
  begin
    for i := 0 to Adicionais.Count do
      result := result + ((Adicionais.Items[i] as TAdicionalItem).quantidade * (Adicionais.Items[i] as TAdicionalItem).valor_unitario);

    result := quantidade * result;
  end;

end;

function TItem.GetTotalBruto: Real;
begin
  result := (self.quantidade * self.valor_Unitario) + self.totalAdicionais;
end;

function TItem.GetTotalLiquido: Real;
begin
  result := (self.quantidade * self.valor_Unitario) + self.totalAdicionais ;//- self.Desconto;
end;

function TItem.GetUsuario: TUsuario;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FUsuario) then begin
        Repositorio           := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
        self.FUsuario         := TUsuario(Repositorio.Get(self.FCodigo_usuario));
      end;

      result := self.FUsuario;
   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
