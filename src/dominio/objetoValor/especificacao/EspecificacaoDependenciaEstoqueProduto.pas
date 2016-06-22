unit EspecificacaoDependenciaEstoqueProduto;

interface

uses
  Especificacao;

type
  TEspecificacaoDependenciaEstoqueProduto = class(TEspecificacao)

  private
    Fcodigo_produto :Integer;

  public
    constructor Create(codigo_produto :Integer);

  public
    function SatisfeitoPor(ProdutoDependenciaEst :TObject) :Boolean; override;
end;

implementation

uses
  ProdutoDependenciaEst,
  SysUtils;
{ TEspecificacaoDependenciaEstoqueProduto }

constructor TEspecificacaoDependenciaEstoqueProduto.Create(codigo_produto: Integer);
begin
  self.Fcodigo_produto := codigo_produto;
end;

function TEspecificacaoDependenciaEstoqueProduto.SatisfeitoPor(ProdutoDependenciaEst: TObject): Boolean;
begin
  result := TProdutoDependenciaEst( ProdutoDependenciaEst ).codigo_produto = self.Fcodigo_produto;
end;

end.
