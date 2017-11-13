unit UtilitarioEstoque;

interface

uses Generics.Collections, System.SysUtils, Math, Estoque, Pedido, Dialogs,
     ProdutoHasMateria, AdicionalItem, EspecificacaoEstoquePorProduto, Item, NotaFiscal, ItemNotaFiscal, ProdutoValidade;

type TUtilitarioEstoque = class
  private
    class procedure atualizaEstoquePorValidade(Item :TItem; baixaOuRecompoe :SmallInt);

  public                                    {1 ou -1}
    class procedure atualizaEstoque(Pedido :TPedido; baixaOuRecompoe :SmallInt);
    class procedure atualizaEstoquePorNFe(NF: TNotaFiscal; baixaOuRecompoe :SmallInt);
end;

implementation

uses MateriaDoProduto, Repositorio, FabricaRepositorio, QuantidadePorValidade;

{ TUtilitarioEstoque }
                                                           {1 ou -1}
class procedure TUtilitarioEstoque.atualizaEstoque(Pedido: TPedido; baixaOuRecompoe :SmallInt);
var Estoque           :TEstoque;
    Especificacao     :TEspecificacaoEstoquePorProduto;
    i                 :integer;
    repositorio       :TRepositorio;
    Materia           :TMateriaDoProduto;
    adicional         :TAdicionalItem;
    item              :TItem;
begin
  Estoque       := nil;
  Especificacao := nil;
 try
   repositorio  := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);

   for item in Pedido.Itens do begin
     //apenas produto tipo servico nao entra nessa condicao
     if pos(item.Produto.tipo, 'PCM') > 0 then
     begin
       //produto tipo COMPOSTO nao tem estoque proprio pra ser baixado
       if pos(item.Produto.tipo, 'PM') > 0 then
       begin
         Especificacao := TEspecificacaoEstoquePorProduto.Create( item.Produto.codigo );
         Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

         if not assigned(Estoque) then
           continue;

         Estoque.quantidade := Estoque.quantidade - (item.quantidade * baixaOuRecompoe);
         repositorio.Salvar(Estoque);
         FreeAndNil(Estoque);
         FreeAndNil(Especificacao);

         if assigned(item.quantidadesPorValidade) then
           atualizaEstoquePorValidade(item, baixaOuRecompoe);
       end;

       if assigned(item.MateriasDoProduto) then
       begin
         //baixa estoque do produto-materia mediante o composto
         for Materia in item.MateriasDoProduto do
         begin
           Especificacao := TEspecificacaoEstoquePorProduto.Create( Materia.materia.codigoProduto );
           Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

           if assigned(Estoque) then
           begin
             Estoque.quantidade := Estoque.quantidade - ((Materia.quantidade * item.quantidade) * baixaOuRecompoe);
             repositorio.Salvar(Estoque);
             FreeAndNil(Estoque);
             FreeAndNil(Especificacao);
           end;
         end;
       end;

       if assigned(item.Adicionais) then
         for adicional in item.Adicionais do
         begin
           Especificacao := TEspecificacaoEstoquePorProduto.Create( adicional.Materia.codigoProduto );
           Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

           if assigned(Estoque) then
           begin
             Estoque.quantidade := Estoque.quantidade -
                                   ((((adicional.Materia.quantidade * IfThen(adicional.flag = 'A', 1, -1)) * adicional.quantidade) * item.quantidade) * baixaOuRecompoe);
             repositorio.Salvar(Estoque);
             FreeAndNil(Estoque);
             FreeAndNil(Especificacao);
           end;
         end;
     end;
   end;

 Finally
   FreeAndNil(repositorio);
 end;
end;

class procedure TUtilitarioEstoque.atualizaEstoquePorNFe(NF: TNotaFiscal; baixaOuRecompoe :SmallInt);
var Estoque           :TEstoque;
    Especificacao     :TEspecificacaoEstoquePorProduto;
    i                 :integer;
    repositorio       :TRepositorio;
    listaDeMaterias   :TObjectList<TProdutoHasMateria>;
    produtoMateria    :TProdutoHasMateria;
    adicional         :TAdicionalItem;
    item              :TItemNotaFiscal;
begin
  Estoque       := nil;
  Especificacao := nil;
 try
   repositorio  := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);

   for item in NF.Itens do begin
     //apenas produto servico nao entra nessa condicao
     if pos(item.Produto.tipo, 'PCM') > 0 then
     begin
       //produto COMPOSTO nao tem estoque proprio pra ser baixado
       if pos(item.Produto.tipo, 'PM') > 0 then
       begin
         Especificacao := TEspecificacaoEstoquePorProduto.Create( item.Produto.codigo );
         Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

         if not assigned(Estoque) then
           continue;

         Estoque.quantidade := Estoque.quantidade - (item.Quantidade * baixaOuRecompoe);
         repositorio.Salvar(Estoque);
         FreeAndNil(Estoque);
         FreeAndNil(Especificacao);
       end;

       listaDeMaterias := TProdutoHasMateria.MateriasDoProduto(item.Produto.codigo);
       if not assigned(listaDeMaterias) then Exit;
       //baixa estoque do produto-materia mediante o composto
       for produtoMateria in listaDeMaterias do
       begin
         Especificacao := TEspecificacaoEstoquePorProduto.Create( produtoMateria.materia_prima.codigoProduto );
         Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

         if assigned(Estoque) then
         begin
           Estoque.quantidade := Estoque.quantidade - ((produtoMateria.materia_prima.quantidade * item.quantidade) * baixaOuRecompoe);
           repositorio.Salvar(Estoque);
           FreeAndNil(Estoque);
           FreeAndNil(Especificacao);
         end;
       end;

       listaDeMaterias.Free;
     end;
   end;

 Finally
   FreeAndNil(repositorio);
 end;
end;


class procedure TUtilitarioEstoque.atualizaEstoquePorValidade(Item: TItem; baixaOuRecompoe :SmallInt);
var  repositorio :TRepositorio;
     ProdutoValidade :TProdutoValidade;
     Quantidade :TQuantidadePorValidade;
begin
  try
    repositorio     := TFabricaRepositorio.GetRepositorio(TProdutoValidade.ClassName);
    for Quantidade in item.quantidadesPorValidade do
    begin
      ProdutoValidade            := TProdutoValidade(repositorio.Get(Quantidade.codigo_validade));
      ProdutoValidade.quantidade := ProdutoValidade.quantidade - (Quantidade.quantidade * baixaOuRecompoe);
      repositorio.Salvar(ProdutoValidade);
      FreeAndNil(ProdutoValidade);
    end;
  finally
    FreeAndNil(repositorio);
  end;
end;

end.
