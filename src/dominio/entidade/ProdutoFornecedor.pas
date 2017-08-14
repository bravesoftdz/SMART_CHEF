unit ProdutoFornecedor;

interface

uses
  SysUtils,
  Perfil,
  Contnrs;

type
  TProdutoFornecedor = class

  private
    Fcodigo_fornecedor: integer;
    Fcodigo: integer;
    Fcodigo_Produto: integer;
    Fcodigo_Produto_fornecedor: String;

    procedure Setcodigo(const Value: integer);
    procedure Setcodigo_fornecedor(const Value: integer);
    procedure Setcodigo_Produto(const Value: integer);
    procedure Setcodigo_Produto_fornecedor(const Value: String);

  public
    property codigo                    :integer read Fcodigo                    write Setcodigo;
    property codigo_Produto            :integer read Fcodigo_Produto            write Setcodigo_Produto;
    property codigo_fornecedor         :integer read Fcodigo_fornecedor         write Setcodigo_fornecedor;
    property codigo_Produto_fornecedor :String  read Fcodigo_Produto_fornecedor write Setcodigo_Produto_fornecedor;
  public
    constructor create(pCodigoProduto, pCodigoFornecedor :integer; pCodigoProdutoFornecedor :String);overload;
    constructor create;overload;

end;

implementation

{ TProdutoFornecedor }

constructor TProdutoFornecedor.create(pCodigoProduto, pCodigoFornecedor: integer; pCodigoProdutoFornecedor: String);
begin
  self.Fcodigo                    := 0;
  self.Fcodigo_Produto            := pCodigoProduto;
  self.Fcodigo_fornecedor         := pCodigoFornecedor;
  self.Fcodigo_Produto_fornecedor := pCodigoProdutoFornecedor;
end;

constructor TProdutoFornecedor.create;
begin

end;

procedure TProdutoFornecedor.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TProdutoFornecedor.Setcodigo_fornecedor(const Value: integer);
begin
  Fcodigo_fornecedor := Value;
end;

procedure TProdutoFornecedor.Setcodigo_Produto(const Value: integer);
begin
  Fcodigo_Produto := Value;
end;

procedure TProdutoFornecedor.Setcodigo_Produto_fornecedor(
  const Value: String);
begin
  Fcodigo_Produto_fornecedor := Value;
end;

end.
