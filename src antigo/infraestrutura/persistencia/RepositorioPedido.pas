unit RepositorioPedido;

interface

uses
  DB,
  Auditoria,
  Repositorio,
  fabricaRepositorio, StringUtilitario, DateTimeUtilitario,
  Item, Contnrs, Pedido, Departamento, StdCtrls, Dialogs, Empresa, Printers, RepositorioItem;

type
  TRepositorioPedido = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String) :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;

  public
    procedure Gera_xml_para_dispensadora(Pedido :TPedido; primeira :Boolean);

  public
    procedure imprime_por_departamento(Pedido :TPedido);
    procedure imprime_pedido(Pedido :TPedido; Departamento :TDepartamento; comandas :String);
    procedure imprime(var Pedido :TPedido; const obs :String = '');

end;

const
  I_NEGRITO         = #27 + #69;
  F_NEGRITO         = #27 + #70 + #10;
  I_ITALICO         = #27 + #52;
  F_ITALICO         = #27 + #53 + #10;
  ACIONA_GUILHOTINA = #27 + #109;

implementation

uses
  SysUtils,
  StrUtils, Classes, AdicionalItem, MateriaPrima, Math, uModulo, Produto;

{ TRepositorioPedido }

function TRepositorioPedido.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FCondicao;
end;

procedure TRepositorioPedido.ExecutaDepoisDeSalvar(Objeto: TObject);
var Pedido      :TPedido;
    repositorio :TRepositorio;
    i           :integer;
    primeira_venda :Boolean;
begin
 try
   repositorio    := nil;
   primeira_venda := false;
   Pedido         := (Objeto as TPedido);
   repositorio    := TFabricaRepositorio.GetRepositorio(TItem.ClassName);

   if assigned(Pedido.Itens) then begin
     primeira_venda := ((Pedido.Itens[0] as TItem).codigo = 0);

     for i := 0 to Pedido.Itens.Count -1 do begin

       {Se a conexao atual for externa, eh sempre insercao}
       if self.FQuery.Connection.Database = fdm.ZConnection1.Database then
         (Pedido.Itens[i] as TItem).codigo := 0;

        (Pedido.Itens[i] as TItem).codigo_pedido := Pedido.codigo;
        repositorio.Salvar( (Pedido.Itens[i] as TItem) );
     end;
   end;

   if primeira_venda or ((UpperCase(Pedido.situacao) = 'F') and (self.FQuery.Connection.Database <> fdm.ZConnection1.Database))
   or (UpperCase(Pedido.situacao) = 'C')then
      Gera_xml_para_dispensadora(Pedido, (primeira_venda) and (Pedido.situacao <> 'F') );

  { if Pedido.imprime_apos_salvar then
     self.imprime(Pedido);   }

 finally
   FreeAndNil(repositorio);
 end;
end;

function TRepositorioPedido.Get(Dataset: TDataSet): TObject;
var
  Pedido :TPedido;
begin
   Pedido                 := TPedido.Create;
   Pedido.Codigo          := self.FQuery.FieldByName('codigo').AsInteger;
   Pedido.codigo_comanda  := self.FQuery.FieldByName('codigo_comanda').AsInteger;
   Pedido.codigo_mesa     := self.FQuery.FieldByName('codigo_mesa').AsInteger;
   Pedido.data            := self.FQuery.FieldByName('data').AsDateTime;
   Pedido.observacoes     := self.FQuery.FieldByName('observacoes').AsString;
   Pedido.situacao        := self.FQuery.FieldByName('situacao').AsString;
   Pedido.couvert         := self.FQuery.FieldByName('couvert').AsFloat;
   Pedido.desconto        := self.FQuery.FieldByName('desconto').AsFloat;
   Pedido.acrescimo       := self.FQuery.FieldByName('acrescimo').AsFloat;
   Pedido.valor_total     := self.FQuery.FieldByName('valor_total').AsFloat;
   Pedido.taxa_servico    := self.FQuery.FieldByName('taxa_servico').AsFloat;
   Pedido.tipo_moeda      := self.FQuery.FieldByName('tipo_moeda').AsString;
   Pedido.nome_cliente    := self.FQuery.FieldByName('nome_cliente').AsString;
   Pedido.telefone        := self.FQuery.FieldByName('telefone').AsString;
   Pedido.cpf_cliente     := self.FQuery.FieldByName('cpf_cliente').AsString;
   Pedido.Codigo_endereco := self.FQuery.FieldByName('codigo_endereco').AsInteger;
   Pedido.valor_pago      := self.FQuery.FieldByName('valor_pago').AsInteger;
   Pedido.Agrupadas       := self.FQuery.FieldByName('agrupadas').AsString;
   Pedido.taxa_entrega    := self.FQuery.FieldByName('taxa_entrega').AsFloat;

   result := Pedido;
end;

function TRepositorioPedido.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPedido(Objeto).Codigo;
end;

function TRepositorioPedido.GetNomeDaTabela: String;
begin
   result := 'Pedidos';
end;

function TRepositorioPedido.GetRepositorio: TRepositorio;
begin
   result := TRepositorioPedido.Create;
end;

procedure TRepositorioPedido.imprime_pedido(Pedido: TPedido; Departamento :TDepartamento; comandas :String);
var Arq   :TextFile;
    i ,j  :integer;
    produto, produto2, valor, acao, materia, quantidade, mesa, comanda :String;
    assinou :Boolean;
    total_itens, valor_adicional :Real;
    repositorio  :TREpositorio;
    impressora_padrao :String;
begin
   assinou     := false;
   total_itens := 0;
   mesa        := '';
   comandas    := IfThen(comandas = '0', '', comandas);

   for i := 0 to Pedido.Itens.Count - 1 do begin

     valor_adicional := 0;
     quantidade      := '';
     total_itens     := total_itens + IfThen(TItem(Pedido.Itens[i]).Produto.codigo = 1, TItem(Pedido.Itens[i]).valor_Unitario * 1,
                                                                                        TItem(Pedido.Itens[i]).valor_Unitario * TItem(Pedido.Itens[i]).quantidade);

     if not (assinou) then begin
       assinou := true;

         if(Printer.PrinterIndex >= 0)then begin
           impressora_padrao := IfThen(pos('\\',Printer.Printers[Printer.PrinterIndex]) > 0,'','\\localhost\' )+ Printer.Printers[Printer.PrinterIndex];
           AssignFile(Arq, impressora_padrao);
           ReWrite(Arq);
         end
         else
           raise Exception.Create('Nenhuma impressora Padrão foi detectada');

       if not (Pedido.paraEntrega) and not (Pedido.paraRetiradaLocal) and (comandas = '') then
         comandas := IntToStr(Pedido.codigo_comanda);

       Writeln(Arq, StringOfChar(' ', 48- (length(DateTimeToStr(now))+1) ) + DateTimeToStr(now));
       Writeln(Arq, StringOfChar('-',48));
       Writeln(Arq, '  '+I_NEGRITO+StringOfChar(' ',TRUNC((46-length(dm.Empresa.Nome_Fantasia)) /2))+dm.Empresa.Nome_Fantasia+ F_NEGRITO);
       Writeln(Arq, '  '+dm.Empresa.Cidade+' / '+dm.Empresa.Estado);
       Writeln(Arq, '  '+'FONE: '+  TStringUtilitario.MascaraFone(dm.Empresa.Telefone));

       if dm.Empresa.site <> '' then
         Writeln(Arq, '  '+dm.Empresa.site);

       Writeln(Arq, StringOfChar('-',48));

       if not (Pedido.paraEntrega) and not (Pedido.paraRetiradaLocal) then begin
         mesa     := IfThen(Pedido.codigo_mesa > 0, '  MESA: '+IntToStr(Pedido.codigo_mesa), '');
         comandas := IfThen(comandas <> '','COMANDA: '+comandas, '');
       end;

       Writeln(Arq,'  '+'PEDIDO: '+IntToStr(Pedido.codigo)+mesa+comandas);
       //           12   3456789012345678901234567890123456789012345678
       WriteLn(Arq,'  '+'QTDE/ITEM                              VALORES');
       WriteLn(Arq, StringOfChar('-',48));
     end;

     produto    := '';
     produto2   := '';

     produto    := Copy(TItem(Pedido.Itens[i]).Produto.descricao,1,36);
     produto2   := Copy(TItem(Pedido.Itens[i]).Produto.descricao,37,42);

     quantidade := IfThen(TItem(Pedido.Itens[i]).quantidade < 599 ,FloatToStr(TItem(Pedido.Itens[i]).quantidade),
                                                                    TDateTimeUtilitario.SegundosParaTime(trunc(TItem(Pedido.Itens[i]).quantidade)));

     produto    := quantidade +' '+ produto;

     valor := FormatFloat(' ,0.00; -,0.00;', IfThen(TItem(Pedido.Itens[i]).Produto.codigo = 1, TItem(Pedido.Itens[i]).valor_Unitario * 1,
                                                                                               TItem(Pedido.Itens[i]).valor_Unitario * TItem(Pedido.Itens[i]).quantidade));

     if length(produto2) > 0 then begin
       WriteLn(Arq, '  '+produto);
       WriteLn(Arq, '    '+produto2 + StringOfChar(' ',44-length(produto2+valor)) +valor);
     end
     else
       WriteLn(Arq, '  '+produto + StringOfChar(' ',46-length(produto+valor)) +valor);

     quantidade := '';
     
     if assigned(TItem(Pedido.Itens[i]).Adicionais) then
       for j := 0 to TItem(Pedido.Itens[i]).Adicionais.Count - 1 do begin

         acao       := IfThen(TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).flag = 'A','Adicionar', 'Remover');

         valor_adicional := IfThen(TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).flag = 'A',
                                                  TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).valor_unitario,
                                                  0);
         valor_adicional := (valor_adicional * TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).quantidade);
         valor_adicional := valor_adicional * TItem(Pedido.Itens[i]).quantidade;

         total_itens     := total_itens + valor_adicional;

         quantidade := IntToStr(TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).quantidade);
         quantidade := IfThen(quantidade='0', '', quantidade);

         materia    := TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).Materia.descricao;

         WriteLn(Arq, '   >'+acao+' ' + quantidade + ' ' + materia +
                 StringOfChar(' ',46-length(' >'+acao+' ' + quantidade + ' ' + materia + FormatFloat(' ,0.00; -,0.00;',valor_adicional)))
                 + IfThen(valor_adicional >0, FormatFloat(' ,0.00; -,0.00;',valor_adicional), '') );
       end;

   end;

   WriteLn(Arq, StringOfChar('-',48));
   WriteLn(Arq, '     Total itens >'+StringOfChar(' ', 30-length( FormatFloat(' ,0.00; -,0.00;',total_itens) ))+FormatFloat(' ,0.00; -,0.00;',total_itens) );

   if Pedido.couvert > 0 then
     WriteLn(Arq, '     Couvert artistico >'+StringOfChar(' ', 24-length( FormatFloat(' ,0.00; -,0.00;',Pedido.couvert) ))+FormatFloat(' ,0.00; -,0.00;',Pedido.couvert) );

   if Pedido.taxa_servico > 0 then
     WriteLn(Arq, '     Taxa de serviço >'+StringOfChar(' ', 26-length( FormatFloat(' ,0.00; -,0.00;',Pedido.taxa_servico) ))+FormatFloat(' ,0.00; -,0.00;',Pedido.taxa_servico) );

   if Pedido.desconto > 0 then
     WriteLn(Arq, '     Valor desconto >'+StringOfChar(' ', 27-length( FormatFloat(' ,0.00; -,0.00;',Pedido.desconto) ))+FormatFloat(' ,0.00; -,0.00;',Pedido.desconto) );

   if Pedido.taxa_entrega > 0 then
     WriteLn(Arq, '     Taxa de entrega >'+StringOfChar(' ', 26-length( FormatFloat(' ,0.00; -,0.00;',Pedido.taxa_entrega) ))+FormatFloat(' ,0.00; -,0.00;',Pedido.taxa_entrega) );

   WriteLn(Arq, '     TOTAL DO PEDIDO >'+StringOfChar(' ', 26-length( FormatFloat(' ,0.00; -,0.00;',Pedido.valor_total) ))+FormatFloat(' ,0.00; -,0.00;',Pedido.valor_total) );

   if assigned(Pedido.Endereco) then begin
     writeLn(Arq, '');
     writeLn(Arq, 'P/ '+Pedido.nome_cliente);
     writeLn(Arq, 'RUA: '+Pedido.Endereco.logradouro+', '+Pedido.Endereco.numero);
     writeLn(Arq, Pedido.Endereco.bairro+' FONE: '+Pedido.Endereco.fone);

     if Pedido.Endereco.referencia <> '' then begin
       writeLn(Arq, 'Referência: '+copy(Pedido.Endereco.referencia,1,36));
       writeLn(Arq, copy(Pedido.Endereco.referencia,37,48));
     end;

     writeLn(Arq, Copy(Pedido.observacoes,1,

                        IfThen(
                                pos('|',Pedido.observacoes) = 0, 48,  (pos('|',Pedido.observacoes)-1)
                               )
                       )
             );

     if pos('|',Pedido.observacoes) > 0 then
       writeLn(Arq, copy(Pedido.observacoes, pos('|',Pedido.observacoes)+1, 48 ));

   end;

   writeLn(Arq, '');
   writeLn(Arq, '  '+StringOfChar(' ',TRUNC((46-length('OBRIGADO, VOLTE SEMPRE!!!')) /2))+'OBRIGADO, VOLTE SEMPRE!!!');

   if assinou then begin
     writeLn(Arq, '');
     writeLn(Arq, '');
     writeLn(Arq, '');
     WriteLn(Arq, ACIONA_GUILHOTINA);
     CloseFile(Arq);
   end;
end;

procedure TRepositorioPedido.imprime(var Pedido: TPedido; const obs :String);
var Arq   :TextFile;
    i ,j, x, codigo_produto  :integer;
    produto, produto2, quantidade, acao, materia :String;
    assinou :Boolean;
    impressora_padrao :String;
    preparo, preparo_atual :String;
    repositorioItem :TRepositorioItem;
begin
 try

   produto  := '';

   if fdm.conexao.InTransaction then
     fdm.conexao.Commit;

   x := 1;
   repositorioItem := TRepositorioItem.Create;

   while x < 5 do begin
     assinou  := false;
     preparo  := '';

     for i := 0 to Pedido.Itens.Count - 1 do begin

       preparo_atual := IfThen(TItem(Pedido.Itens[i]).Produto.preparo = '', '-', TItem(Pedido.Itens[i]).Produto.preparo);

       if (TItem(Pedido.Itens[i]).impresso = 'S') or ( dm.UsuarioLogado.Codigo_departamento <> TItem(Pedido.Itens[i]).Produto.codigo_departamento)
          or ((preparo <> '') and (preparo <> preparo_atual) ) then
         continue;

       if not (assinou) then begin
         assinou := true;
         preparo := preparo_atual;

         if(Printer.PrinterIndex >= 0)then begin
            impressora_padrao := IfThen( pos('\\',Printer.Printers[Printer.PrinterIndex]) > 0,'','\\localhost\' )+ Printer.Printers[Printer.PrinterIndex];
            AssignFile(Arq, impressora_padrao);
            ReWrite(Arq);
          end
          else
            raise Exception.Create('Nenhuma impressora Padrão foi detectada');

         ReWrite(Arq);

         if dm.Configuracoes.imp_dep_espacada then begin
            Writeln(Arq, '');
            Writeln(Arq, '');
         end;

         Writeln(Arq, ' USUÁRIO: '+TItem(Pedido.Itens[i]).Usuario.Nome);

         if dm.Configuracoes.imp_dep_espacada then
            Writeln(Arq, '');

         Writeln(Arq, ' '+preparo+StringOfChar(' ', 48- (length(DateTimeToStr(now)+preparo)+1) ) + DateTimeToStr(now));

         if dm.Configuracoes.imp_dep_espacada then
            Writeln(Arq, '');

         if Pedido.paraEntrega then begin
            Writeln(Arq, ' * PEDIDO PARA ENTREGA *');
            Writeln(Arq, ' PED: '+ IntToStr(Pedido.codigo));
            Writeln(Arq, ' CLIENTE: '+ Pedido.nome_cliente);
         end
         else if Pedido.paraRetiradaLocal then begin
            Writeln(Arq, ' * PEDIDO PARA RETIRADA NO LOCAL *');
            Writeln(Arq, ' PED: '+ IntToStr(Pedido.codigo));
            Writeln(Arq, ' '+Pedido.nome_cliente + ' - '+TStringUtilitario.MascaraFone(Pedido.telefone));
         end
         else
           Writeln(Arq, I_NEGRITO+ '  MESA: '+IfThen( Pedido.codigo_mesa = 99, 'BALCÃO',IntToStr(Pedido.codigo_mesa))+ ' COMANDA: '+IntToStr(Pedido.codigo_comanda)+ F_NEGRITO);
         //           123456789012345678901234567890123456789012345678

         if dm.Configuracoes.imp_dep_espacada then
            Writeln(Arq, '');

         WriteLn(Arq, I_ITALICO+' ITEM                                       QTDE'+F_ITALICO);

       end;

       produto    := '';
       produto2   := '';
       codigo_produto := TItem(Pedido.Itens[i]).Produto.codigo;

       produto    := intToStr(codigo_produto) +' '+ Copy(TItem(Pedido.Itens[i]).Produto.descricao,1,38);
       produto2   := Copy(TItem(Pedido.Itens[i]).Produto.descricao,39,42);

       if produto2 <> '' then
         produto2   := produto2 + StringOfChar(' ',42-length(produto2))
       else
         produto    := produto + StringOfChar(' ',42-length(produto));


       quantidade := FloatToStr(TItem(Pedido.Itens[i]).quantidade);
       quantidade := quantidade + StringOfChar(' ',4-length(quantidade));

       if dm.Configuracoes.imp_dep_espacada then
          Writeln(Arq, '');


       if produto2 <> '' then begin
         WriteLn(Arq, '  '+ produto);
         WriteLn(Arq, '  '+ produto2 + quantidade);
       end
       else begin
         WriteLn(Arq, '  '+ produto + quantidade);
       end;

       if assigned(TItem(Pedido.Itens[i]).Adicionais) then
         for j := 0 to TItem(Pedido.Itens[i]).Adicionais.Count - 1 do begin
           acao       := IfThen(TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).flag = 'A','Adicionar', 'Remover');

           quantidade := IntToStr(TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).quantidade);
           quantidade := IfThen(quantidade='0', '', quantidade + StringOfChar(' ',4-length(quantidade)) );

           materia    := TAdicionalItem(TItem(Pedido.Itens[i]).Adicionais[j]).Materia.descricao;

           WriteLn(Arq, '   > '+acao+' ' + quantidade + materia);
         end;

       if dm.Configuracoes.imp_dep_espacada then begin
          Writeln(Arq, '');
          Writeln(Arq, '');
       end;

       TItem(Pedido.Itens[i]).impresso := 'S';

       repositorioItem.Salvar(TItem(Pedido.Itens[i]));

     end;

     if assinou then begin
       writeLn(Arq, '');
       writeLn(Arq, '');
       writeLn(Arq, '');
       WriteLn(Arq, ACIONA_GUILHOTINA);

       CloseFile(Arq);
     end;

     inc(x);
   end;

 Finally
   FreeAndNil(repositorioItem);
 end;
end;

procedure TRepositorioPedido.imprime_por_departamento(Pedido :TPedido);
var i     :integer;
    repositorio   :TRepositorio;
    Departamentos :TObjectList;
begin
  repositorio   := nil;
  try

    repositorio   := TFabricaRepositorio.GetRepositorio(TDepartamento.ClassName);
    Departamentos := repositorio.GetAll;

    if not assigned(Departamentos) then
      Exit;

    try
      repositorio := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);

      for i := 0 to Departamentos.Count - 1 do begin

         imprime( Pedido);
           
         repositorio.Salvar(Pedido);
      end;

    Except
      on e: Exception do
      raise Exception.Create(e.Message);
    end;

  Finally
    FreeAndNil(repositorio);
    FreeAndNil(Departamentos);
  end;
end;

function TRepositorioPedido.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TPedido(Objeto).Codigo <= 0);
end;

procedure TRepositorioPedido.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  PedidoAntigo :TPedido;
  PedidoNovo   :TPedido;
begin
   PedidoAntigo := (AntigoObjeto as TPedido);
   PedidoNovo   := (Objeto       as TPedido);

   if (PedidoAntigo.codigo_comanda <> PedidoNovo.codigo_comanda) then
    Auditoria.AdicionaCampoAlterado('codigo_comanda', IntToStr(PedidoAntigo.codigo_comanda), IntToStr(PedidoNovo.codigo_comanda) );

   if (PedidoAntigo.codigo_mesa <> PedidoNovo.codigo_mesa) then
    Auditoria.AdicionaCampoAlterado('codigo_mesa', IntToStr(PedidoAntigo.codigo_mesa), IntToStr(PedidoNovo.codigo_mesa) );

   if (PedidoAntigo.data <> PedidoNovo.data) then
    Auditoria.AdicionaCampoAlterado('data', DateToStr(PedidoAntigo.data), DateToStr(PedidoNovo.data));

   if (PedidoAntigo.observacoes <> PedidoNovo.observacoes) then
    Auditoria.AdicionaCampoAlterado('observacoes', PedidoAntigo.observacoes, PedidoNovo.observacoes);

   if (PedidoAntigo.situacao <> PedidoNovo.situacao) then
    Auditoria.AdicionaCampoAlterado('situacao', PedidoAntigo.situacao, PedidoNovo.situacao);

   if (PedidoAntigo.couvert <> PedidoNovo.couvert) then
    Auditoria.AdicionaCampoAlterado('couvert', FloatToStr(PedidoAntigo.couvert), FloatToStr(PedidoNovo.couvert) );

   if (PedidoAntigo.desconto <> PedidoNovo.desconto) then
    Auditoria.AdicionaCampoAlterado('desconto', FloatToStr(PedidoAntigo.desconto), FloatToStr(PedidoNovo.desconto) );

   if (PedidoAntigo.acrescimo <> PedidoNovo.acrescimo) then
    Auditoria.AdicionaCampoAlterado('acrescimo', FloatToStr(PedidoAntigo.acrescimo), FloatToStr(PedidoNovo.acrescimo) );

   if (PedidoAntigo.valor_total <> PedidoNovo.valor_total) then
    Auditoria.AdicionaCampoAlterado('valor_total', FloatToStr(PedidoAntigo.valor_total), FloatToStr(PedidoNovo.valor_total) );

   if (PedidoAntigo.taxa_servico <> PedidoNovo.taxa_servico) then
    Auditoria.AdicionaCampoAlterado('taxa_servico', FloatToStr(PedidoAntigo.taxa_servico), FloatToStr(PedidoNovo.taxa_servico) );

   if (PedidoAntigo.tipo_moeda <> PedidoNovo.tipo_moeda) then
    Auditoria.AdicionaCampoAlterado('tipo_moeda', PedidoAntigo.tipo_moeda, PedidoNovo.tipo_moeda);

   if (PedidoAntigo.nome_cliente <> PedidoNovo.nome_cliente) then
    Auditoria.AdicionaCampoAlterado('nome_cliente', PedidoAntigo.nome_cliente, PedidoNovo.nome_cliente);

   if (PedidoAntigo.telefone <> PedidoNovo.telefone) then
    Auditoria.AdicionaCampoAlterado('telefone', PedidoAntigo.telefone, PedidoNovo.telefone);

   if (PedidoAntigo.cpf_cliente <> PedidoNovo.cpf_cliente) then
    Auditoria.AdicionaCampoAlterado('cpf_cliente', PedidoAntigo.cpf_cliente, PedidoNovo.cpf_cliente);

   if (PedidoAntigo.Codigo_endereco <> PedidoNovo.Codigo_endereco) then
    Auditoria.AdicionaCampoAlterado('Codigo_endereco', IntToStr(PedidoAntigo.Codigo_endereco), IntToStr(PedidoNovo.Codigo_endereco) );

   if (PedidoAntigo.valor_pago <> PedidoNovo.valor_pago) then
    Auditoria.AdicionaCampoAlterado('valor_pago', FloatToStr(PedidoAntigo.valor_pago), FloatToStr(PedidoNovo.valor_pago) );

   if (PedidoAntigo.Agrupadas <> PedidoNovo.Agrupadas) then
    Auditoria.AdicionaCampoAlterado('Agrupadas', PedidoAntigo.Agrupadas, PedidoNovo.Agrupadas);

   if (PedidoAntigo.taxa_entrega <> PedidoNovo.taxa_entrega) then
    Auditoria.AdicionaCampoAlterado('taxa_entrega', FloatToStr(PedidoAntigo.taxa_entrega), FloatToStr(PedidoNovo.taxa_entrega) );
end;

procedure TRepositorioPedido.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Pedido :TPedido;
begin
   Pedido := (Objeto as TPedido);

   Auditoria.AdicionaCampoExcluido('codigo',          IntToStr(Pedido.codigo));
   Auditoria.AdicionaCampoExcluido('codigo_comanda',  IntToStr(Pedido.codigo_comanda));
   Auditoria.AdicionaCampoExcluido('codigo_mesa',     IntToStr(Pedido.codigo_mesa));
   Auditoria.AdicionaCampoExcluido('data',            DateTimeToStr(Pedido.data));
   Auditoria.AdicionaCampoExcluido('observacoes',     Pedido.observacoes);
   Auditoria.AdicionaCampoExcluido('situacao',        Pedido.situacao);
   Auditoria.AdicionaCampoExcluido('couvert',         FloatToStr(Pedido.couvert));
   Auditoria.AdicionaCampoExcluido('desconto',        FloatToStr(Pedido.desconto));
   Auditoria.AdicionaCampoExcluido('acrescimo',       FloatToStr(Pedido.acrescimo));
   Auditoria.AdicionaCampoExcluido('valor_total',     FloatToStr(Pedido.valor_total));
   Auditoria.AdicionaCampoExcluido('taxa_servico',    FloatToStr(Pedido.taxa_servico));
   Auditoria.AdicionaCampoExcluido('tipo_moeda',      Pedido.tipo_moeda);
   Auditoria.AdicionaCampoExcluido('nome_cliente',    Pedido.nome_cliente);
   Auditoria.AdicionaCampoExcluido('telefone',        Pedido.telefone);
   Auditoria.AdicionaCampoExcluido('cpf_cliente',     Pedido.cpf_cliente);
   Auditoria.AdicionaCampoExcluido('Codigo_endereco', IntToStr(Pedido.Codigo_endereco));
   Auditoria.AdicionaCampoExcluido('valor_pago',      FloatToStr(Pedido.valor_pago));
   Auditoria.AdicionaCampoExcluido('Agrupadas',       Pedido.Agrupadas);
   Auditoria.AdicionaCampoExcluido('taxa_entrega',    FloatToStr(Pedido.taxa_entrega));
end;

procedure TRepositorioPedido.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Pedido :TPedido;
begin
   Pedido := (Objeto as TPedido);

   Auditoria.AdicionaCampoIncluido('codigo',          IntToStr(Pedido.codigo));
   Auditoria.AdicionaCampoIncluido('codigo_comanda',  IntToStr(Pedido.codigo_comanda));
   Auditoria.AdicionaCampoIncluido('codigo_mesa',     IntToStr(Pedido.codigo_mesa));
   Auditoria.AdicionaCampoIncluido('data',            DateTimeToStr(Pedido.data));
   Auditoria.AdicionaCampoIncluido('observacoes',     Pedido.observacoes);
   Auditoria.AdicionaCampoIncluido('situacao',        Pedido.situacao);
   Auditoria.AdicionaCampoIncluido('couvert',         FloatToStr(Pedido.couvert));
   Auditoria.AdicionaCampoIncluido('desconto',        FloatToStr(Pedido.desconto));
   Auditoria.AdicionaCampoIncluido('taxa_servico',    FloatToStr(Pedido.taxa_servico));
   Auditoria.AdicionaCampoIncluido('tipo_moeda',      Pedido.tipo_moeda);
   Auditoria.AdicionaCampoIncluido('nome_cliente',    Pedido.nome_cliente);
   Auditoria.AdicionaCampoIncluido('telefone',        Pedido.telefone);
   Auditoria.AdicionaCampoIncluido('cpf_cliente',     Pedido.cpf_cliente);
   Auditoria.AdicionaCampoIncluido('Codigo_endereco', IntToStr(Pedido.Codigo_endereco));
   Auditoria.AdicionaCampoIncluido('valor_pago',      FloatToStr(Pedido.valor_pago));
   Auditoria.AdicionaCampoIncluido('Agrupadas',       Pedido.Agrupadas);
   Auditoria.AdicionaCampoIncluido('taxa_entrega',    FloatToStr(Pedido.taxa_entrega));
end;

procedure TRepositorioPedido.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TPedido(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioPedido.SetParametros(Objeto: TObject);
var
  Pedido :TPedido;
begin
   Pedido := (Objeto as TPedido);

   self.FQuery.ParamByName('codigo').AsInteger          := Pedido.Codigo;

   if Pedido.codigo_comanda > 0 then
     self.FQuery.ParamByName('codigo_comanda').AsInteger  := Pedido.codigo_comanda;
     
   self.FQuery.ParamByName('codigo_mesa').AsInteger     := Pedido.codigo_mesa;
   self.FQuery.ParamByName('data').AsDateTime           := Pedido.data;
   self.FQuery.ParamByName('observacoes').AsString      := Pedido.observacoes;
   self.FQuery.ParamByName('situacao').AsString         := Pedido.situacao;
   self.FQuery.ParamByName('couvert').AsFloat           := Pedido.couvert;
   self.FQuery.ParamByName('desconto').AsFloat          := Pedido.desconto;
   self.FQuery.ParamByName('acrescimo').AsFloat         := Pedido.acrescimo;
   self.FQuery.ParamByName('valor_total').AsFloat       := Pedido.valor_total;
   self.FQuery.ParamByName('taxa_servico').AsFloat      := Pedido.taxa_servico;
   self.FQuery.ParamByName('tipo_moeda').AsString       := Pedido.tipo_moeda;
   self.FQuery.ParamByName('nome_cliente').AsString     := Pedido.nome_cliente;
   self.FQuery.ParamByName('telefone').AsString         := Pedido.telefone;
   self.FQuery.ParamByName('cpf_cliente').AsString      := Pedido.cpf_cliente;
   self.FQuery.ParamByName('Codigo_endereco').AsInteger := Pedido.Codigo_endereco;
   self.FQuery.ParamByName('valor_pago').AsFloat        := Pedido.valor_pago;
   self.FQuery.ParamByName('Agrupadas').AsString        := Pedido.Agrupadas;
   self.FQuery.ParamByName('taxa_entrega').AsFloat      := Pedido.taxa_entrega;
end;

function TRepositorioPedido.SQLGet: String;
begin
  result := 'select * from Pedidos where codigo = :ncod';
end;

function TRepositorioPedido.SQLGetAll: String;
begin
  result := 'select * from Pedidos '+ IfThen(FCondicao = '','', CondicaoSQLGetAll) +' order by data desc';
end;

function TRepositorioPedido.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Pedidos where '+ campo +' = :ncampo';
end;

function TRepositorioPedido.SQLRemover: String;
begin
   result := ' delete from Pedidos where codigo = :codigo ';
end;

function TRepositorioPedido.SQLSalvar: String;
begin
   result := 'update or insert into Pedidos (codigo, codigo_comanda, codigo_mesa, data, observacoes, situacao, desconto, acrescimo,         '+
             '                               couvert, valor_total, taxa_servico, tipo_moeda, nome_cliente, telefone, cpf_cliente,           '+
             '                               codigo_endereco, valor_pago, agrupadas, taxa_entrega)                                          '+
             '                       values (:codigo, :codigo_comanda, :codigo_mesa, :data, :observacoes, :situacao, :desconto, :acrescimo, '+
             '                               :couvert, :valor_total, :taxa_servico, :tipo_moeda, :nome_cliente, :telefone, :cpf_cliente,    '+
             '                               :codigo_endereco, :valor_pago, :agrupadas, :taxa_entrega)                                      ';
end;

procedure TRepositorioPedido.Gera_xml_para_dispensadora(Pedido :TPedido; primeira :Boolean);
var Lista        :TStringList;
    repositorio  :TREpositorio;
begin
 try
   if not dm.Configuracoes.possui_dispensadora then
     Exit;

   Lista        := TStringList.Create;

   Lista.Add('<?xml version="1.0" standalone="yes"?>');
   Lista.Add('<DATAPACKET Version="2.0">');
   Lista.Add('  <METADATA>');
   Lista.Add('    <FIELDS>');
   Lista.Add('      <FIELD attrname="ID_COMANDA" fieldtype="string" WIDTH="20" />');
   Lista.Add('      <FIELD attrname="EVENTO" fieldtype="string" WIDTH="1" />');
   Lista.Add('    </FIELDS>');
   Lista.Add('    <PARAMS />');
   Lista.Add('  </METADATA>');
   Lista.Add('  <ROWDATA>');
   Lista.Add('    <ROW RowState="4" ID_COMANDA="'+TStringUtilitario.CaracterAEsquerda('0', IntToStr(Pedido.codigo_comanda), 3)+'" EVENTO="'+IfThen(primeira, 'C', 'L')+'" />');
   Lista.Add('  </ROWDATA>');
   Lista.Add('</DATAPACKET>');

   Lista.SaveToFile(dm.Empresa.diretorio_dispensadora+'\'+IntToStr(Pedido.codigo)+'_'+TStringUtilitario.CaracterAEsquerda('0', IntToStr(Pedido.codigo_comanda), 3)+'_'+IfThen(primeira, 'C', 'L')+'.xml');

 finally
   FreeAndNil(Lista);
 end;
end;

end.
