unit uImpressaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, ContNrs,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Pedido, System.StrUtils, Data.DB, Datasnap.DBClient, Item, RLPrinters, uPadrao;

type
  TfrmImpressaoPedido = class(TFrmPadrao)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel14: TRLLabel;
    RLLabel1: TRLLabel;
    lbUsuario: TRLLabel;
    lbPreparo: TRLLabel;
    memoInfoPedido: TRLMemo;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cdsItensPRODUTO: TStringField;
    cdsItensQUANTIDADE: TFloatField;
    cdsItensCODIGO_ITEM: TIntegerField;
    cdsItensADICIONAL: TStringField;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand3: TRLBand;
    RLLabel3: TRLLabel;
    RLDraw2: TRLDraw;
    RLDBMemo1: TRLDBMemo;
    RLBand5: TRLBand;
    RLDraw1: TRLDraw;
    RLBand6: TRLBand;
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure incluiProduto(Item: TItem);
  public
     procedure imprime(Pedido :TPedido);
  end;

var
  frmImpressaoPedido: TfrmImpressaoPedido;

implementation

uses uModulo, Funcoes, RepositorioItem, Produto, AdicionalItem;

{$R *.dfm}

{ TfrmImpressaoPedido }

procedure TfrmImpressaoPedido.FormCreate(Sender: TObject);
begin
  cdsItens.CreateDataSet;
end;

procedure TfrmImpressaoPedido.imprime(Pedido: TPedido);
var
    i ,j, x, codigo_produto  :integer;
    produto, produto2, quantidade, acao, materia :String;
    assinou :Boolean;
    impressora_padrao, mesaComanda :String;
    preparo, preparo_atual :String;
    repositorioItem :TRepositorioItem;
begin
  try
    produto  := '';

   if dm.conexao.InTransaction then
     dm.conexao.Commit;

   x := 1;
   repositorioItem := TRepositorioItem.Create;

   while x < 5 do begin
     assinou  := false;
     preparo  := '';
     cdsItens.EmptyDataSet;

     for i := 0 to Pedido.Itens.Count - 1 do begin

       preparo_atual := IfThen((Pedido.Itens[i] as TItem).Produto.preparo = '', '-', (Pedido.Itens[i] as TItem).Produto.preparo);

       if ((Pedido.Itens[i] as TItem).impresso = 'S') or ( dm.UsuarioLogado.Codigo_departamento <> (Pedido.Itens[i] as TItem).Produto.codigo_departamento)
          or ((preparo <> '') and (preparo <> preparo_atual) ) then
         continue;

       if not (assinou) then begin
         assinou := true;
         preparo := preparo_atual;

         lbUsuario.Caption := (Pedido.Itens[i] as TItem).Usuario.Nome;
         lbPreparo.Caption := preparo;

        // if dm.Configuracoes.imp_dep_espacada then

        memoInfoPedido.Lines.Clear;

         if Pedido.paraEntrega then begin
            memoInfoPedido.Lines.Add(' * PEDIDO PARA ENTREGA *');
            memoInfoPedido.Lines.Add(' PED: '+ IntToStr(Pedido.codigo));
            memoInfoPedido.Lines.Add(' CLIENTE: '+ Pedido.nome_cliente);
         end
         else if Pedido.paraRetiradaLocal then begin
            memoInfoPedido.Lines.Add(' * PEDIDO PARA RETIRADA NO LOCAL *');
            memoInfoPedido.Lines.Add(' PED: '+ IntToStr(Pedido.codigo));
            memoInfoPedido.Lines.Add(' '+Pedido.nome_cliente + ' - '+Pedido.telefone);
         end
         else begin
           mesaComanda := ' MESA: '+IfThen( Pedido.codigo_mesa = 99, 'BALCAO',IntToStr(Pedido.codigo_mesa))+ ' COMANDA: '+IntToStr(Pedido.codigo_comanda);

           if not dm.Configuracoes.Utiliza_comandas then
             mesaComanda := ' MESA: '+ IntToStr(Pedido.codigo_comanda);

           memoInfoPedido.Lines.Add(mesaComanda);
         end;
       end;

       (Pedido.Itens[i] as TItem).impresso := 'S';

       repositorioItem.Salvar(Pedido.Itens[i]);

       incluiProduto((Pedido.Itens[i] as TItem));

     end;

     if not cdsItens.IsEmpty then
     begin
       //RLReport1.PreviewModal;
       try
         RLReport1.Clear;
         RLPrinter.PrinterName := impressoraPadrao;
         RLReport1.Print;
       Except
        on e:Exception do
         begin
           avisar('Erro ao imprimir pedido no departamento.'+#13#10+'Favor verifique se a impressora desejada está como padrão.');
         end;
       end;
     end;

     inc(x);
   end;



  finally
    FreeAndNil(repositorioItem);
  end;
end;

procedure TfrmImpressaoPedido.incluiProduto(Item: TItem);
var i, y :integer;
    qtdAdicional :integer;
begin
  if assigned(Item.Adicionais) then
  begin  for i := 0 to Item.Adicionais.Count -1 do
    begin
      qtdAdicional := TAdicionalItem(Item.Adicionais.Items[i]).quantidade;
      cdsItens.Append;
      cdsItensCODIGO_ITEM.AsInteger := Item.codigo;
      cdsItensPRODUTO.AsString      := intToStr(Item.Produto.codigo) + ' ' + Item.Produto.descricao;
      cdsItensQUANTIDADE.AsFloat    := Item.quantidade;
      cdsItensADICIONAL.AsString    := IfThen(TAdicionalItem(Item.Adicionais.Items[i]).flag = 'A','+','-')+
                                       IfThen(qtdAdicional > 0,IntToStr(qtdAdicional),'')+' '+
                                       TAdicionalItem(Item.Adicionais.Items[i]).Materia.descricao;
      cdsItens.Post;
    end;
  end
  else
  begin
    cdsItens.Append;
    cdsItensCODIGO_ITEM.AsInteger := Item.codigo;
    cdsItensPRODUTO.AsString      := intToStr(Item.Produto.codigo) + ' ' + Item.Produto.descricao;
    cdsItensQUANTIDADE.AsFloat    := Item.quantidade;
    cdsItensADICIONAL.AsString    := '';
    cdsItens.Post;
  end;
end;

procedure TfrmImpressaoPedido.RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  if Text = '' then
    RLBand4.Height := 0
  else
    RLBand4.Height := 19;
end;

end.
