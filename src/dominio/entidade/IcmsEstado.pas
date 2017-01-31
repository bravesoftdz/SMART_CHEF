unit IcmsEstado;

interface

uses SysUtils, Contnrs, Estado;

type
  TIcmsEstado = class

  private
    Fcodigo :Integer;
    Fcodigo_estado :Integer;
    Fperc_reducao_bc :Real;
    Faliquota_icms :Real;
    FEstado: TEstado;
    function GetEstado: TEstado;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_estado         :Integer read Fcodigo_estado         write Fcodigo_estado;
    property perc_reducao_bc       :Real    read Fperc_reducao_bc       write Fperc_reducao_bc;
    property aliquota_icms         :Real    read Faliquota_icms         write Faliquota_icms;
    property Estado :TEstado read GetEstado write FEstado;

  public
    constructor CreatePorEstado(codigo_estado: integer);    
end;

implementation

uses EspecificacaoIcmsEstadoPorCodigoEstado, repositorio, fabricaRepositorio, umodulo;

{ TIcmsEstado }

constructor TIcmsEstado.CreatePorEstado(codigo_estado: integer);
var especificacao :TEspecificacaoIcmsEstadoPorCodigoEstado;
    repositorio   :TRepositorio;
begin
  especificacao := nil;
  repositorio   := nil;
  try

    repositorio     := TFabricaRepositorio.GetRepositorio(self.ClassName);

    especificacao   := TEspecificacaoIcmsEstadoPorCodigoEstado.Create(codigo_estado);

    self            := TIcmsEstado( repositorio.GetPorEspecificacao(especificacao) );

  finally
    FreeAndNil(especificacao);
    FreeAndNil(repositorio);
  end;
end;

function TIcmsEstado.GetEstado: TEstado;
var repositorio :TRepositorio;
begin
  if not assigned(FEstado) then
  begin
    repositorio := TFabricaRepositorio.GetRepositorio(TEstado.ClassName);
    FEstado     := TEstado(repositorio.Get(self.Fcodigo_estado));
  end;
  Result := FEstado;
end;

end.
