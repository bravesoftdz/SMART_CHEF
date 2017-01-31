unit Cidade;

interface

uses SysUtils, Contnrs, Estado;

type
  TCidade = class

  private
    Fcodigo :Integer;
    Fcodest :Integer;
    Fnome :String;
    Fcep :String;
    Fcodibge :Integer;
    FEstado :TEstado;

  private
    function GetEstado: TEstado;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codest                :Integer read Fcodest                write Fcodest;
    property nome                  :String  read Fnome                  write Fnome;
    property cep                   :String  read Fcep                   write Fcep;
    property codibge               :Integer read Fcodibge               write Fcodibge;

  public
    property Estado :TEstado       read GetEstado;

end;

implementation

uses repositorio, FabricaRepositorio;

{ TCidade }

function TCidade.GetEstado: TEstado;
var repositorio :TRepositorio;
begin
  if not assigned(self.FEstado) then
  begin
    repositorio  := TFabricaRepositorio.GetRepositorio(TEstado.ClassName);
    self.FEstado := TEstado(repositorio.Get(self.Fcodest));
  end;

  result := self.FEstado;
end;

end.
