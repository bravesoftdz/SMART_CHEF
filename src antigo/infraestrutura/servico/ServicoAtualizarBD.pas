unit ServicoAtualizarBD;

interface

uses
  Parametro;

type
  TServicoAtualizadorBD = class

  private
    FBuscadorDeAtualizacoes  :IBuscadorDeAtualizacoesBD;
    FParametros              :TParametros;

  public
    constructor Create(Parametros :TParametros; BuscadorDeAtualizacoesBD :IBuscadorDeAtualizacoesBD);
    destructor Destroy; override;
end;

implementation

const
  VERSAO_SISTEMA = 1;

end.
