unit EspecificacaoIcmsEstadoPorCodigoEstado;

interface

uses
  Especificacao;

type
  TEspecificacaoIcmsEstadoPorCodigoEstado = class(TEspecificacao)

  private
    FCodigo_estado :Integer;

  public
    constructor Create(codigo_estado :Integer);

  public
    function SatisfeitoPor(IcmsEstado :TObject) :Boolean; override;
end;

implementation

uses IcmsEstado;

{ TEspecificacaoIcmsEstadoPorCodigoEstado }

constructor TEspecificacaoIcmsEstadoPorCodigoEstado.Create(codigo_estado: Integer);
begin
  self.FCodigo_estado := codigo_estado;
end;

function TEspecificacaoIcmsEstadoPorCodigoEstado.SatisfeitoPor(IcmsEstado: TObject): Boolean;
begin
   result := (TIcmsEstado(IcmsEstado).codigo_estado = self.FCodigo_estado);
end;

end.
