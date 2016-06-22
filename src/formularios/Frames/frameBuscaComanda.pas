unit frameBuscaComanda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Comanda, StdCtrls, Buttons, Mask, RXToolEdit, RXCurrEdit, Pedido;

type
  TBuscaComanda = class(TFrame)
    StaticText1: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtNumeroComanda: TEdit;
    btnFormaBusca: TBitBtn;
    procedure btnBuscaClick(Sender: TObject);
    procedure edtNumeroComandaChange(Sender: TObject);
    procedure edtNumeroComandaExit(Sender: TObject);
    procedure btnFormaBuscaClick(Sender: TObject);
  private
    FComanda :TComanda;
    Fcodigo: Integer;
    FExecutarAposBuscar: TNotifyEvent;
    FExecutarAposLimpar: TNotifyEvent;

    FPedido :TPedido;
    FCodigo_pedido :integer;
    FBuscaPedidosExternos :Boolean;

    procedure buscaComanda;
    function selecionaComanda :String;
    procedure setaComanda;
    procedure carregaPedido(codigo_pedido :integer);


    function GetPedido : TPedido;

  private
    procedure SetComanda          (const Value: TComanda);
    procedure Setcodigo            (const Value: Integer);
    procedure SetExecutarAposBuscar(const Value: TNotifyEvent);
    procedure SetExecutarAposLimpar(const Value: TNotifyEvent);

  public
    procedure limpa;
    procedure efetua_busca;
    function pedido_pela_comanda(codigo_comanda :integer): TPedido;

    property Comanda :TComanda read FComanda write SetComanda;
    property codigo  :Integer  read Fcodigo  write Setcodigo;

    property Pedido  :TPedido  read GetPedido write FPedido;
    property CodigoPedido :integer write FCodigo_pedido;
    property BuscaPedidosExternos :boolean read FBuscaPedidosExternos write FBuscaPedidosExternos;

  public
    property ExecutarAposBuscar :TNotifyEvent read FExecutarAposBuscar write SetExecutarAposBuscar;
    property ExecutarAposLimpar :TNotifyEvent read FExecutarAposLimpar write SetExecutarAposLimpar;
end;

implementation

uses repositorio, fabricaRepositorio, Funcoes, uPesquisaSimples, EspecificacaoPedidoAbertoDaComanda, uPadrao, Item, Math,
  StrUtils, RepositorioPedido;

{$R *.dfm}

{ TbuscaComanda }

procedure TBuscaComanda.buscaComanda;
begin
  edtCodigo.Text := Campo_por_campo('COMANDAS','CODIGO','NUMERO_COMANDA', edtNumeroComanda.text);

  setaComanda;

  if not assigned( FComanda ) then begin
    Fcodigo_pedido := StrToIntDef(selecionaComanda,0);
    carregaPedido( Fcodigo_pedido);
  end;
end;

procedure TBuscaComanda.limpa;
begin

  Fcodigo := 0;
  Fcodigo_pedido := 0;
  edtCodigo.Clear;

  if btnFormaBusca.TAG = 0 then
    edtNumeroComanda.Clear;

  if assigned(FComanda) then
    FreeAndNil(FComanda);

  if assigned(FPedido) then
    FreeAndNil(FPedido);

  if Assigned(FExecutarAposLimpar) then
     self.FExecutarAposLimpar(self);
end;

function TBuscaComanda.selecionaComanda: String;
begin
 try
   Result := '';

   if btnFormaBusca.TAG = 1 then begin
     frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select CAST(ped.codigo as VARCHAR(5)) codigo, ped.valor_total, '+
                                                           ' ''(''||SUBSTRING(ped.telefone from 1 for 2) || '')'' || SUBSTRING(ped.telefone from 3 for 4) || ''-'' || SUBSTRING(ped.telefone from 7 for 4) telefone, '+
                                                           ' ped.nome_cliente, en.logradouro Rua, en.numero, en.bairro '+
                                                           ' from pedidos ped '+
                                                           ' left join enderecos en on en.codigo = ped.codigo_endereco '+
                                                           ' where ped.codigo_comanda is null and ped.situacao = ''A'' ',
                                                           'CODIGO', 'Selecione o pedido desejado...',
                                                           FAlse, 1000, 400 );
   end
   else begin

     frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select CAST(c.codigo as VARCHAR(5)) codigo, c.numero_comanda "N° Comanda", '+
                                                           ' iif(ped.codigo is null, ''LIVRE'', ped.codigo) "N° Pedido",'+
                                                           ' ped.nome_cliente "Cliente" from comandas c '+
                                                           ' left join pedidos ped on ((ped.codigo_comanda = c.codigo) and (ped.situacao = ''A''))',
                                                           'CODIGO', 'Selecione a comanda desejada...',
                                                           FAlse );
   end;

   if not frmPesquisaSimples.cds.IsEmpty then
   begin
     if frmPesquisaSimples.ShowModal = mrOk then begin
        Result := frmPesquisaSimples.cds_retorno.Fields[0].AsString;

       if btnFormaBusca.TAG = 0 then begin
         edtCodigo.Text := Result;
         setaComanda;
       end;

       keybd_event(VK_TAB,0,0,0);
     end
     else
       edtNumeroComanda.SetFocus;

   end
   else
     raise Exception.Create('Nenhum dado foi encontrado');

   frmPesquisaSimples.Release;
   frmPesquisaSimples := nil;

 except
   on e: Exception do
     raise Exception.Create(e.Message);
 end;
end;

procedure TBuscaComanda.setaComanda;
var
    RepComanda :TRepositorio;
begin

  if btnFormaBusca.TAG = 0 then begin
    RepComanda := TFabricaRepositorio.GetRepositorio(TComanda.ClassName);
    FComanda   := TComanda(RepComanda.Get(edtCodigo.AsInteger));

    if Assigned(FComanda) then begin

      edtCodigo.Value        := FComanda.Codigo;
      edtNumeroComanda.Text  := IntToStr(FComanda.numero_comanda);

      if assigned(FPedido) then
        FPedido := nil;

      if Assigned(FComanda) and Assigned(FExecutarAposBuscar) then
       self.FExecutarAposBuscar(FComanda);
    end
    else limpa;

  end
  else begin
    if assigned(FPedido) then
        FPedido := nil;
  end;
end;

procedure TBuscaComanda.Setcodigo(const Value: Integer);
begin
  Fcodigo := value;
  edtCodigo.AsInteger := value;
  setaComanda;
end;

procedure TBuscaComanda.SetComanda(const Value: TComanda);
begin
  FComanda := Value;
end;

procedure TBuscaComanda.SetExecutarAposBuscar(const Value: TNotifyEvent);
begin
  FExecutarAposBuscar := Value;
end;

procedure TBuscaComanda.SetExecutarAposLimpar(const Value: TNotifyEvent);
begin
  FExecutarAposLimpar := Value;
end;

procedure TBuscaComanda.btnBuscaClick(Sender: TObject);
var pedido :String;
begin
 try
  pedido := selecionaComanda;

  if not assigned(self.FComanda) then
    carregaPedido( strToIntDef(pedido, 0));

  keybd_event(VK_RETURN,0,0,0);

 except
   on e: Exception do
     raise Exception.Create(e.Message);

 end;
end;


procedure TBuscaComanda.edtNumeroComandaChange(Sender: TObject);
begin
  if ( strToIntDef(self.edtNumeroComanda.Text,0) < 0) then
    self.limpa;
end;

procedure TBuscaComanda.edtNumeroComandaExit(Sender: TObject);
begin
  efetua_busca;
end;

function TBuscaComanda.GetPedido: TPedido;
begin
  if Assigned(self.FComanda) and not assigned(FPedido) then
    self.FPedido          := Pedido_pela_comanda(self.FComanda.codigo)
  else if (Fcodigo_pedido > 0) and not assigned(FPedido) then
    carregaPedido( Fcodigo_pedido);

  result := self.FPedido;
end;

function TBuscaComanda.pedido_pela_comanda(codigo_comanda :integer): TPedido;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoPedidoAbertoDaComanda;
begin
   Repositorio    := nil;
   Especificacao  := nil;
 try

   Especificacao   := TEspecificacaoPedidoAbertoDaComanda.Create(codigo_comanda);
   Repositorio     := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   result          := TPedido( Repositorio.GetPorEspecificacao( Especificacao, 'CODIGO_COMANDA = '+IntToStr(codigo_comanda) ) );

 finally
   FreeAndNil(Repositorio);
   FreeAndNil(Especificacao);
 end;
end;

procedure TBuscaComanda.efetua_busca;
begin
  if (strToIntDef(edtNumeroComanda.text,0) > 0) and (self.Enabled) and not assigned( self.FComanda ) and not assigned(FPedido) then
    buscaComanda;
end;

procedure TBuscaComanda.carregaPedido(codigo_pedido: integer);
var repositorio :TRepositorio;
begin
  repositorio := nil;
  try
    repositorio  := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
    self.FPedido := TPedido( repositorio.Get(codigo_pedido) );

    if not assigned(FPedido) then begin
      self.edtCodigo.Clear;
    end;

  finally
    FreeAndNil(repositorio);
  end;
end;

procedure TBuscaComanda.btnFormaBuscaClick(Sender: TObject);
begin
    btnFormaBusca.Caption := IfThen(btnFormaBusca.TAG = 0,'Pedidos externos','Pedidos normais');
    btnFormaBusca.TAG     := IfThen(btnFormaBusca.TAG = 0,1,0);

    edtNumeroComanda.SetFocus;

    edtnumeroComanda.Text     := IfThen(btnFormaBusca.TAG = 1, 'PED.EXT.', '');
    edtNumeroComanda.ReadOnly := btnFormaBusca.TAG = 1;
end;

end.
