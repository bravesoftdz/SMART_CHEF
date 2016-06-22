unit ProdutoDependenciaEst;

interface

uses SysUtils, Contnrs,
  Dispensa,
  Produto;

type
  TProdutoDependenciaEst = class

  private
    Fcodigo :Integer;
    Fcodigo_produto :Integer;
    Fcodigo_dispensa :Integer;
    Fquantidade_baixa :Real;
    FDispensa :TDispensa;
    FProduto: TProduto;

    function GetDispensa :TDispensa;
    function GetProduto  :TProduto;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_produto        :Integer read Fcodigo_produto        write Fcodigo_produto;
    property codigo_dispensa       :Integer read Fcodigo_dispensa       write Fcodigo_dispensa;
    property quantidade_baixa      :Real read Fquantidade_baixa      write Fquantidade_baixa;

    property dispensa  :TDispensa   read GetDispensa;
    property produto   :TProduto    read GetProduto write FProduto;
end;

implementation

{ TProdutoDependenciaEst }

uses Repositorio, FabricaRepositorio;


function TProdutoDependenciaEst.GetDispensa: TDispensa;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FDispensa) then begin
        Repositorio       := TFabricaRepositorio.GetRepositorio(TDispensa.ClassName);
        self.FDispensa    := TDispensa( Repositorio.Get(self.Fcodigo_dispensa) );
      end;

      result := self.FDispensa;

   finally
     FreeAndNil(Repositorio);
   end;
end;

function TProdutoDependenciaEst.GetProduto: TProduto;
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

end.
