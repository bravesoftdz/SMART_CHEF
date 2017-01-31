unit EspecificacaoAliqInternaPorCodigoEstado;

interface

uses
  Especificacao;

type
  TEspecificacaoAliqInternaPorCodigoEstado = class(TEspecificacao)

  private
    FCodigo_estado :integer;

  public
    constructor Create(Codigo_estado :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses AliqInternaIcms;

{ TEspecificacaoAliqInternaPorCodigoEstado }

constructor TEspecificacaoAliqInternaPorCodigoEstado.Create(Codigo_estado: integer);
begin
  FCodigo_estado := Codigo_estado;
end;

function TEspecificacaoAliqInternaPorCodigoEstado.SatisfeitoPor(Objeto: TObject): Boolean;
var AliqInterna :TAliqInternaIcms;
begin
  AliqInterna := (Objeto as TAliqInternaIcms);

  result := (AliqInterna.codigo_estado = self.FCodigo_estado);
end;

end.
