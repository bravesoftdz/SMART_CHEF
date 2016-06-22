unit AdicionalItem;

interface

uses
  SysUtils, Contnrs, MateriaPrima;

type
  TAdicionalItem = class

  private
    Fcodigo_item: integer;
    Fcodigo: integer;
    Fcodigo_materia: integer;
    Fflag: string;
    FMateria: TMateriaPrima;
    Fquantidade: integer;
    Fvalor_unitario :Real;
    
    function GetMateria: TMateriaPrima;

  public
    property codigo         :integer read Fcodigo         write Fcodigo;
    property codigo_item    :integer read Fcodigo_item    write Fcodigo_item;
    property codigo_materia :integer read Fcodigo_materia write Fcodigo_materia;
    property flag           :string  read Fflag           write Fflag;
    property quantidade     :integer read Fquantidade     write Fquantidade;
    property valor_unitario :Real    read Fvalor_unitario write Fvalor_unitario;

    property Materia        :TMateriaPrima read GetMateria write FMateria;
end;

implementation

uses Repositorio, FabricaRepositorio;

{ TAdicionalItem }

function TAdicionalItem.GetMateria: TMateriaPrima;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   try
      if not Assigned(self.FMateria) then begin
        Repositorio    := TFabricaRepositorio.GetRepositorio(TMateriaPrima.ClassName);
        self.FMateria  := TMateriaPrima(Repositorio.Get(self.Fcodigo_materia));
      end;

      result := self.FMateria;
   finally
     FreeAndNil(Repositorio);
   end;
end;

end.
