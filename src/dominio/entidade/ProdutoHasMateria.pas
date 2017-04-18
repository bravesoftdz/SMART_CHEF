unit ProdutoHasMateria;

interface

uses
  SysUtils,
  Contnrs,
  MateriaPrima,
  Produto,
  Generics.Collections;

type
  TProdutoHasMateria = class

  private
    Fcodigo_materia: integer;
    Fcodigo_produto: integer;
    Fcodigo: integer;
    FMateriaPrima  :TMateriaPrima;
    FProduto: TProduto;
    FAdicional: Boolean;

    procedure Setcodigo(const Value: integer);
    procedure Setcodigo_materia(const Value: integer);
    procedure Setcodigo_produto(const Value: integer);
    procedure Setproduto(const Value: TProduto);

    function GetMateriaPrima :TMateriaPrima;
    function GetProduto      :TProduto;

  public
    property codigo         :integer read Fcodigo         write Setcodigo;
    property codigo_produto :integer read Fcodigo_produto write Setcodigo_produto;
    property codigo_materia :integer read Fcodigo_materia write Setcodigo_materia;
    property Adicional      :Boolean read FAdicional      write FAdicional;

    property materia_prima  :TMateriaPrima read GetMateriaPrima;
    property produto        :TProduto      read GetProduto write Setproduto;

    class function MateriasDoProduto(codigoProduto :integer) :TObjectList<TProdutoHasMateria>;

end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoMateriasDoProduto;
{ TProdutoHasMateria }

function TProdutoHasMateria.GetMateriaPrima: TMateriaPrima;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FMateriaPrima) then begin
        Repositorio         := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
        self.FMateriaPrima  := TMateriaPrima( Repositorio.Get(self.Fcodigo_materia) );
      end;

      result := self.FMateriaPrima;

   finally
     FreeAndNil(Repositorio);
   end;
end;

function TProdutoHasMateria.GetProduto: TProduto;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FProduto) then begin
        Repositorio    := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
        self.FProduto  := TProduto( Repositorio.Get(self.Fcodigo_produto) );
      end;

      result := self.FProduto;

   finally
     FreeAndNil(Repositorio);
   end;
end;

class function TProdutoHasMateria.MateriasDoProduto(codigoProduto: integer): TObjectList<TProdutoHasMateria>;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoMateriasDoProduto;
begin
   Repositorio    := nil;
   Especificacao  := nil;

   try
     Especificacao  := TEspecificacaoMateriasDoProduto.Create(codigoProduto);
     Repositorio    := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
     result         := Repositorio.GetListaPorEspecificacao<TProdutoHasMateria>(Especificacao);
   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Repositorio);
   end;
end;

procedure TProdutoHasMateria.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TProdutoHasMateria.Setcodigo_materia(const Value: integer);
begin
  Fcodigo_materia := Value;
end;

procedure TProdutoHasMateria.Setcodigo_produto(const Value: integer);
begin
  Fcodigo_produto := Value;
end;

procedure TProdutoHasMateria.Setproduto(const Value: TProduto);
begin
  Fproduto := Value;
end;

end.
