unit UtilitarioEstoque;

interface

uses Generics.Collections, System.SysUtils, Math, Estoque, Pedido, Repositorio, FabricaRepositorio, Dialogs,
     ProdutoHasMateria, AdicionalItem, EspecificacaoEstoquePorProduto, Item, NotaFiscal, ItemNotaFiscal;

type TUtilitarioEstoque = class
  public                                    {1 ou -1}
    class procedure atualizaEstoque(Pedido :TPedido; baixaOuRecompoe :SmallInt);
    class procedure atualizaEstoquePorNFe(NF: TNotaFiscal; baixaOuRecompoe :SmallInt);
end;

implementation

{ TUtilitarioEstoque }
                                                           {1 ou -1}
class procedure TUtilitarioEstoque.atualizaEstoque(Pedido: TPedido; baixaOuRecompoe :SmallInt);
var Estoque           :TEstoque;
    Especificacao     :TEspecificacaoEstoquePorProduto;
    i                 :integer;
    repositorio       :TRepositorio;
    listaDeMaterias   :TObjectList<TProdutoHasMateria>;
    produtoMateria    :TProdutoHasMateria;
    adicional         :TAdicionalItem;
begin
  Estoque       := nil;
  Especificacao := nil;
 try
   repositorio  := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);

   for i := 0 to Pedido.Itens.Count - 1 do begin
     //apenas produto servico nao entra nessa condicao
     if pos((Pedido.Itens[i] as TItem).Produto.tipo, 'PCM') > 0 then
     begin
       //produto COMPOSTO nao tem estoque proprio pra ser baixado
       if pos(Pedido.Itens[i].Produto.tipo, 'PM') > 0 then
       begin
         Especificacao := TEspecificacaoEstoquePorProduto.Create( (Pedido.Itens[i] as TItem).Produto.codigo );
         Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

         if not assigned(Estoque) then
           continue;

         Estoque.quantidade := Estoque.quantidade - ((Pedido.Itens[i] as TItem).quantidade * baixaOuRecompoe);
         repositorio.Salvar(Estoque);
         FreeAndNil(Estoque);
         FreeAndNil(Especificacao);
       end;

       listaDeMaterias := TProdutoHasMateria.MateriasDoProduto(Pedido.Itens[i].Produto.codigo);
       if not assigned(listaDeMaterias) then Exit;
       //baixa estoque do produto-materia mediante o composto
       for produtoMateria in listaDeMaterias do
       begin
         Especificacao := TEspecificacaoEstoquePorProduto.Create( produtoMateria.materia_prima.codigoProduto );
         Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

         if assigned(Estoque) then
         begin
           Estoque.quantidade := Estoque.quantidade - ((produtoMateria.materia_prima.quantidade * Pedido.Itens[i].quantidade) * baixaOuRecompoe);
           repositorio.Salvar(Estoque);
           FreeAndNil(Estoque);
           FreeAndNil(Especificacao);
         end;
       end;

       if assigned(Pedido.Itens[i].Adicionais) then
         for adicional in Pedido.Itens[i].Adicionais do
         begin
           Especificacao := TEspecificacaoEstoquePorProduto.Create( adicional.Materia.codigoProduto );
           Estoque       := TEstoque( repositorio.GetPorEspecificacao( Especificacao ) );

           if assigned(Estoque) then
           begin
             Estoque.quantidade := Estoque.quantidade -
                                   ((((adicional.Materia.quantidade * IfThen(adicional.flag = 'A', 1, -1)) * adicional.quantidade) * Pedido.Itens[i].quantidade) * baixaOuRecompoe);
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


end.
