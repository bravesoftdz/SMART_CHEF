unit uImpressaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, ContNrs, Generics.collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Pedido, System.StrUtils, Data.DB, Datasnap.DBClient, Item, RLPrinters, uPadrao, Departamento;

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
    RLReport2: TRLReport;
    RLBand7: TRLBand;
    RLLabel5: TRLLabel;
    rlbEmpresa: TRLLabel;
    rlbCidadeUF: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLGroup2: TRLGroup;
    RLBand8: TRLBand;
    RLDraw3: TRLDraw;
    RLDBText2: TRLDBText;
    RLDBMemo2: TRLDBMemo;
    RLBand9: TRLBand;
    RLDBText4: TRLDBText;
    RLBand10: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel11: TRLLabel;
    rlbTelefone: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel15: TRLLabel;
    rlbPedido: TRLLabel;
    rlbMesa: TRLLabel;
    rlbComanda: TRLLabel;
    RLDBMemo3: TRLDBMemo;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    cdsItensVLR_ITEM: TFloatField;
    cdsItensVLR_ADCIONAL: TFloatField;
    cdsItensQTD_ADICIONAL: TIntegerField;
    cdsItensADD_REM: TStringField;
    cdsTotais: TClientDataSet;
    dsTotais: TDataSource;
    cdsTotaisDESCRICAO: TStringField;
    cdsTotaisVALOR: TFloatField;
    RLSubDetail1: TRLSubDetail;
    RLBand12: TRLBand;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLSubDetail2: TRLSubDetail;
    RLBand13: TRLBand;
    RLBand14: TRLBand;
    RLLabel7: TRLLabel;
    RLDBText11: TRLDBText;
    dsPago: TDataSource;
    cdsPago: TClientDataSet;
    RLDBText10: TRLDBText;
    cdsPagoDESCRICAO: TStringField;
    cdsPagoVALOR: TFloatField;
    RLSubDetail3: TRLSubDetail;
    RLBand15: TRLBand;
    memoEndereco: TRLMemo;
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLBand8BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBMemo5BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText5BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText11BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLSubDetail3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    FTotalProdutos :Real;
    FCdsParcial    :TClientDataSet;

  private
    procedure incluiProduto(Item: TItem);
  public
     procedure imprimeDepartamento(Pedido :TPedido);
     procedure imprimePedido(Pedido :TPedido; Departamento :TDepartamento; comandas :String; const cdsParcial :TClientDataSet = nil);
     procedure adicionaTotal(descricao :String; valor :Real);
     procedure adicionaPgto(descricao :String; valor :Real);
     procedure zerarCampos;
  end;

var
  frmImpressaoPedido: TfrmImpressaoPedido;

implementation

uses uModulo, Funcoes, RepositorioItem, Produto, AdicionalItem, StringUtilitario, Movimento, TipoMoeda, Math;

{$R *.dfm}

{ TfrmImpressaoPedido }

procedure TfrmImpressaoPedido.adicionaPgto(descricao: String; valor: Real);
begin
  cdsPago.Append;
  cdsPagoDESCRICAO.AsString := descricao;
  cdsPagoVALOR.AsFloat      := valor;
  cdsPago.Post;
end;

procedure TfrmImpressaoPedido.adicionaTotal(descricao: String; valor: Real);
begin
  cdsTotais.Append;
  cdsTotaisDESCRICAO.AsString := descricao;
  cdsTotaisVALOR.AsFloat      := valor;
  cdsTotais.Post;
end;

procedure TfrmImpressaoPedido.FormCreate(Sender: TObject);
begin
  cdsItens.CreateDataSet;
  cdsTotais.CreateDataSet;
  cdsPago.CreateDataSet;
end;

procedure TfrmImpressaoPedido.imprimeDepartamento(Pedido: TPedido);
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

procedure TfrmImpressaoPedido.imprimePedido(Pedido :TPedido; Departamento :TDepartamento; comandas :String; const cdsParcial :TClientDataSet);
var i, x :integer;
    totalItens, totalPago :Real;
    Movimentos :TObjectList<TMovimento>;
begin
  FCdsParcial          := cdsParcial;
  rlbEmpresa.Caption   := dm.Empresa.NomeFantasia;
  rlbCidadeUF.Caption  := dm.Empresa.Enderecos[0].Cidade.nome+' / '+dm.Empresa.Enderecos[0].Cidade.Estado.sigla;
  rlbTelefone.Caption  := TStringUtilitario.MascaraFone(dm.Empresa.Fone1);
  rlbPedido.Caption    := intToStr(Pedido.codigo);

  if Pedido.paraEntrega then
  begin
    rlbMesa.Caption    := 'P/ ENTREGA';
    RLLabel13.Visible  := false;
    RLLabel15.Visible  := false;
    rlbComanda.Caption := '';
  end
  else if Pedido.paraRetiradaLocal then
  begin
    rlbMesa.Caption    := 'P/ RETIRADA';
    RLLabel13.Visible  := false;
    RLLabel15.Visible  := false;
    rlbComanda.Caption := '';
  end
  else
  begin
    rlbMesa.Caption      := intToStr(Pedido.codigo_mesa);
    rlbComanda.Caption   := IfThen(comandas <> '', comandas, intToStr(Pedido.codigo_comanda));
  end;

  for i := 0 to Pedido.Itens.Count-1 do
    incluiProduto(Pedido.Itens[i]);

  if assigned(cdsparcial) then
     adicionaTotal('     TOTAL           >', FTotalProdutos)
  else
  begin
      adicionaTotal('     Total itens     >', FTotalProdutos);
      if Pedido.couvert > 0 then
        adicionaTotal('     Couvert artistico >', Pedido.couvert);

      if Pedido.taxa_servico > 0 then
        adicionaTotal('     Taxa de serviço >', Pedido.taxa_servico);

      if Pedido.desconto > 0 then
        adicionaTotal('     Valor desconto  >', Pedido.desconto);

      if Pedido.taxa_entrega > 0 then
        adicionaTotal('     Taxa de entrega >', Pedido.taxa_entrega);

      adicionaTotal('     TOTAL DO PEDIDO >', Pedido.valor_total);

      Movimentos := TMovimento.MovimentosDoPedido(Pedido.codigo);
      totalPago  := 0;
      for x := 0 to Movimentos.Count-1 do
      begin
        case TTipoMoedaUtilitario.DeInteiroParaEnumerado(Movimentos[x].tipo_moeda) of
          tmDinheiro      : adicionaPgto('      Dinheiro            >', Movimentos[x].valor_pago);
          tmCheque        : adicionaPgto('      Cheque                >', Movimentos[x].valor_pago);
          tmCartaoCredito : adicionaPgto('      Cart. Crédito   >', Movimentos[x].valor_pago);
          tmCartaoDebito  : adicionaPgto('      Cart. Débito     >', Movimentos[x].valor_pago);
          tmDeposito      : adicionaPgto('      Depósito            >', Movimentos[x].valor_pago);
        end;

        totalPago := totalPago + Movimentos[x].valor_pago;
      end;

      if totalPago > 0 then
        adicionaPgto('- -  TOTAL PAGO  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ', totalPago);

      if (Pedido.valor_total - totalPago) > 0then
        adicionaPgto('      TOTAL RESTANTE  >', Pedido.valor_total - totalPago);

      adicionaPgto('',0);

      if assigned(Pedido.Endereco) then begin
        memoEndereco.Lines.Add('P/ '+Pedido.nome_cliente);
        memoEndereco.Lines.Add('RUA: '+Pedido.Endereco.logradouro+', '+Pedido.Endereco.numero);
        memoEndereco.Lines.Add(Pedido.Endereco.bairro+' FONE: '+'('+copy(Pedido.Endereco.fone,1,2)+')'+ copy(Pedido.Endereco.fone,3,10));

        if Pedido.Endereco.referencia <> '' then begin
          memoEndereco.Lines.Add('Referência: '+Pedido.Endereco.referencia);
        end;

        memoEndereco.Lines.Add('');
        memoEndereco.Lines.Add(Copy(Pedido.observacoes,1,
                                                      IfThen(pos('|',Pedido.observacoes) = 0, 48,  (pos('|',Pedido.observacoes)-1))
                                   ));

       if pos('|',Pedido.observacoes) > 0 then
         memoEndereco.Lines.Add(copy(Pedido.observacoes, pos('|',Pedido.observacoes)+1, 48 ));

      end;
   end;

   if not cdsItens.IsEmpty then
     begin
       try
         RLReport2.Clear;
         RLPrinter.PrinterName := impressoraPadrao;
         RLReport2.Print;
       Except
        on e:Exception do
         begin
           avisar('Erro ao imprimir pedido no departamento.'+#13#10+'Favor verifique se a impressora desejada está como padrão.');
         end;
       end;
     end;

   zerarCampos;
end;

procedure TfrmImpressaoPedido.incluiProduto(Item: TItem);
var i, y :integer;
    qtdAdicional :integer;
    qtdItem      :Real;
begin
  if assigned(FCdsparcial) then
  begin
    if not FCdsparcial.Locate('CODIGO_ITEM', Item.codigo, []) then
      Exit;

    qtdItem := FCdsparcial.FieldByName('quantidade').AsFloat;
  end
  else
    qtdItem := Item.quantidade;

  FTotalProdutos := FTotalProdutos + (qtdItem * Item.valor_Unitario);

  if assigned(Item.Adicionais) then
  begin
    for i := 0 to Item.Adicionais.Count -1 do
    begin
      qtdAdicional := TAdicionalItem(Item.Adicionais.Items[i]).quantidade;
      cdsItens.Append;
      cdsItensCODIGO_ITEM.AsInteger   := Item.codigo;
      cdsItensPRODUTO.AsString        := intToStr(Item.Produto.codigo) + ' ' + Item.Produto.descricao;
      cdsItensQUANTIDADE.AsFloat      := qtdItem;
      cdsItensADICIONAL.AsString      := IfThen(qtdAdicional > 0,IntToStr(qtdAdicional),'')+' '+
                                         Item.Adicionais.Items[i].Materia.descricao;
      cdsItensVLR_ITEM.AsFloat        := qtdItem * Item.valor_Unitario;
      cdsItensQTD_ADICIONAL.AsInteger := qtdAdicional;
      cdsItensVLR_ADCIONAL.AsFloat    := qtdItem * (qtdAdicional * Item.Adicionais.Items[i].valor_unitario);
      cdsItensADD_REM.AsString        := IfThen(Item.Adicionais.Items[i].flag = 'A', '> adicionar', '> remover');
      cdsItens.Post;

      FTotalProdutos := FTotalProdutos + (qtdItem * (qtdAdicional * Item.Adicionais.Items[i].valor_unitario));
    end;
  end
  else
  begin
    cdsItens.Append;
    cdsItensCODIGO_ITEM.AsInteger   := Item.codigo;
    cdsItensPRODUTO.AsString        := intToStr(Item.Produto.codigo) + ' ' + Item.Produto.descricao;
    cdsItensQUANTIDADE.AsFloat      := qtdItem;
    cdsItensADICIONAL.AsString      := '';
    cdsItensVLR_ITEM.AsFloat        := qtdItem * Item.valor_Unitario;
    cdsItensQTD_ADICIONAL.AsInteger := 0;
    cdsItensADD_REM.AsString        := '';
    cdsItens.Post;
  end;
end;

procedure TfrmImpressaoPedido.RLBand8BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLBand8.Borders.DrawBottom := cdsItensQTD_ADICIONAL.AsInteger > 0;
end;

procedure TfrmImpressaoPedido.RLDBMemo5BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  PrintIt := trim(text) <> '0,00';
end;

procedure TfrmImpressaoPedido.RLDBText11BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  PrintIt := trim(text) <> '0,00';
end;

procedure TfrmImpressaoPedido.RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  if Text = '' then
    RLBand4.Height := 0
  else
    RLBand4.Height := 19;
end;

procedure TfrmImpressaoPedido.RLDBText5BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  if trim(Text) = '' then
    RlBand9.Height := 0
  else
    RlBand9.Height := 20;
end;

procedure TfrmImpressaoPedido.RLDBText7BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  PrintIt := trim(text) <> '0,00';
end;

procedure TfrmImpressaoPedido.RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  if cdsTotais.RecNo = cdsTotais.RecordCount then
    TRLDBText(sender).Font.Style := [fsBold];

  PrintIt := trim(text) <> '0,00';
end;

procedure TfrmImpressaoPedido.RLSubDetail3BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  printIt := trim(memoEndereco.Lines.Text) <> '';
end;

procedure TfrmImpressaoPedido.zerarCampos;
begin
  if cdsitens.Active then
    cdsItens.EmptyDataSet;
  if cdsTotais.Active then
    cdsTotais.EmptyDataSet;
  if cdsPago.Active then
    cdsPago.EmptyDataSet;

  FTotalProdutos := 0;
end;

end.
