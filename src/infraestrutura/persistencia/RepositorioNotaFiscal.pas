unit RepositorioNotaFiscal;

interface

uses
  DB,
  NotaFiscal,
  Repositorio, Dialogs;

type
  TRepositorioNotaFiscal = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;    
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

  private
    procedure salva_itens_produtos(notaFiscal :TNotaFiscal);
end;


implementation

uses
  TipoSerie,
  TipoFrete,
  SysUtils, FabricaRepositorio, ItemNotaFiscal,
  LocalEntregaNotaFiscal, VolumesNotaFiscal, ObservacaoNotaFiscal, Funcoes,
  TotaisNotaFiscal, LoteNFe, NFe, RepositorioItemAvulso, ItemAvulso, Math,
  StrUtils;

{ TRepositorioNotaFiscal }

function TRepositorioNotaFiscal.CondicaoSQLGetAll: String;
begin
  result := ' WHERE data_saida between '+FIdentificador;
end;

procedure TRepositorioNotaFiscal.ExecutaDepoisDeSalvar(Objeto: TObject);
var NotaFiscal :TNotaFiscal;
begin
   NotaFiscal         := (Objeto as TNotaFiscal);

   salva_itens_produtos(NotaFiscal)
end;

function TRepositorioNotaFiscal.Get(Dataset: TDataSet): TObject;
begin
   result := TNotaFiscal.CriarParaRepositorio(Dataset.FieldByName('codigo').AsInteger,
                                              Dataset.FieldByName('numero_nota_fiscal').AsInteger,
                                              Dataset.FieldByName('codigo_natureza').AsInteger,
                                              Dataset.FieldByName('serie').AsString,
                                              Dataset.FieldByName('codigo_emitente').AsInteger,
                                              Dataset.FieldByName('codigo_destinatario').AsInteger,
                                              Dataset.FieldByName('codigo_fpagto').AsInteger,
                                              Dataset.FieldByName('data_emissao').AsDateTime,
                                              Dataset.FieldByName('data_saida').AsDateTime,
                                              Dataset.FieldByName('codigo_transportadora').AsInteger,
                                              Dataset.FieldByName('tipo_frete').AsInteger,
                                              Dataset.FieldByName('entrada_saida').AsString,
                                              Dataset.FieldByName('finalidade').AsString,
                                              Dataset.FieldByName('nfe_referenciada').AsString,
                                              Dataset.FieldByName('entrou_estoque').AsString,
                                              Dataset.FieldByName('nota_importacao').AsString = 'S');
end;

function TRepositorioNotaFiscal.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TNotaFiscal(Objeto).CodigoNotaFiscal;
end;

function TRepositorioNotaFiscal.GetNomeDaTabela: String;
begin
   result := 'notas_fiscais';
end;

function TRepositorioNotaFiscal.GetRepositorio: TRepositorio;
begin
   result := TRepositorioNotaFiscal.Create;
end;

function TRepositorioNotaFiscal.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TNotaFiscal(Objeto).CodigoNotaFiscal <= 0);
end;

procedure TRepositorioNotaFiscal.salva_itens_produtos(notaFiscal: TNotaFiscal);
var
  RepItens          :TRepositorio;
  RepPedFat         :TRepositorio;
  RepItensAvulsos   :TRepositorio;
  RepLocalEntrega   :TRepositorio;
  RepVolumes        :TRepositorio;
  RepObservacoes    :TRepositorio;
  RepTotais         :TRepositorio;
  RepLoteNFe        :TRepositorio;
  RepNFe            :TRepositorio;
  nX                :Integer;
  codigo_item       :Integer;
begin
   RepItens           := nil;
   RepPedFat          := nil;
   RepLocalEntrega    := nil;
   RepVolumes         := nil;
   RepObservacoes     := nil;
   RepTotais          := nil;
   RepLoteNFe         := nil;
   RepNFe             := nil;

   try
     { Itens }
     RepItens := TFabricaRepositorio.GetRepositorio(TItemNotaFiscal.ClassName);

     for nX := 0 to (NotaFiscal.Itens.Count-1) do begin
        if Assigned(self.FAtualizarTela) then
          self.FAtualizarTela;
        TItemNotaFiscal(NotaFiscal.Itens[nX]).CarregarImpostos;
     end;

     for nX := 0 to (NotaFiscal.Itens.Count-1) do begin
        if Assigned(self.FAtualizarTela) then
          self.FAtualizarTela;

        {codigo_item := StrToIntDef( Campo_por_campo('ITENS_NOTAS_FISCAIS','CODIGO','CODIGO_NOTA_FISCAL', IntToStr(notaFiscal.CodigoNotaFiscal),
                                                    'CODIGO_PRODUTO',IntToStr(TItemNotaFiscal(NotaFiscal.Itens[nX]).Produto.Codigo)), 0);
        TItemNotaFiscal(NotaFiscal.Itens[nX]).Codigo := codigo_item;    }
        TItemNotaFiscal(NotaFiscal.Itens[nX]).CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
        RepItens.Salvar(NotaFiscal.Itens[nX]);
     end;

     { Volumes }
     if Assigned(self.FAtualizarTela) then
       self.FAtualizarTela;

     if assigned(NotaFiscal.Volumes) and (NotaFiscal.Volumes.Especie <> '') then
     begin
       RepVolumes := TFabricaRepositorio.GetRepositorio(TVolumesNotaFiscal.ClassName);
       NotaFiscal.Volumes.CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
       RepVolumes.Remover(NotaFiscal.Volumes);
       RepVolumes.Salvar(NotaFiscal.Volumes);
     end;

     { Observações }
     if Assigned(self.FAtualizarTela) then
       self.FAtualizarTela;

     RepObservacoes := TFabricaRepositorio.GetRepositorio(TObservacaoNotaFiscal.ClassName);
     notaFiscal.Observacoes.CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
     RepObservacoes.Remover(NotaFiscal.Observacoes);
     RepObservacoes.Salvar(NotaFiscal.Observacoes);

     { Totais }
   //  if Assigned(self.FAtualizarTela) then
   //    self.FAtualizarTela;

     RepTotais := TFabricaRepositorio.GetRepositorio(TTotaisNotaFiscal.ClassName);
     //notaFiscal.Totais.CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
     RepTotais.Remover(NotaFiscal.Totais);
     RepTotais.Salvar(NotaFiscal.Totais);

     { Itens Avulsos }
     RepItensAvulsos := TFabricaRepositorio.GetRepositorio(TItemAvulso.ClassName);

     if Assigned(NotaFiscal.ItensAvulsos) and Assigned(self.FAtualizarTela) then
      self.FAtualizarTela;

     RepItensAvulsos.RemoverPorIdentificador(NotaFiscal.CodigoNotaFiscal);

     if Assigned(NotaFiscal.ItensAvulsos) then begin
       for nX := 0 to (NotaFiscal.ItensAvulsos.Count-1) do begin
        if Assigned(self.FAtualizarTela) then
          self.FAtualizarTela;

        TItemAvulso(NotaFiscal.ItensAvulsos[nX]).CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
        RepItensAvulsos.Salvar(NotaFiscal.ItensAvulsos[nX]);
       end;
     end;

     { LoteNFe }
     if Assigned(NotaFiscal.Lote) then begin
       if Assigned(self.FAtualizarTela) then
          self.FAtualizarTela;

       RepLoteNFe := TFabricaRepositorio.GetRepositorio(TLoteNFe.ClassName);
       NotaFiscal.Lote.CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
       RepLoteNFe.Salvar(NotaFiscal.Lote);
     end;

     { NFe }
     if Assigned(NotaFiscal.NFe) then begin
       if Assigned(self.FAtualizarTela) then
          self.FAtualizarTela;

       RepNFe := TFabricaRepositorio.GetRepositorio(TNFe.ClassName);
       NotaFiscal.NFe.CodigoNotaFiscal := notaFiscal.CodigoNotaFiscal;
       RepNFe.Remover(NotaFiscal.NFe);
       RepNFe.Salvar(NotaFiscal.NFe);
     end;

   finally
     FreeAndNil(RepPedFat);
     FreeAndNil(RepItens);
     FreeAndNil(RepLocalEntrega);
     FreeAndNil(RepVolumes);
     FreeAndNil(RepObservacoes);
     FreeAndNil(RepTotais);
     FreeAndNil(RepLoteNFe);
     FreeAndNil(RepNFe);
   end;
end;

procedure TRepositorioNotaFiscal.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TNotaFiscal(Objeto).CodigoNotaFiscal := Integer(Identificador);
end;

procedure TRepositorioNotaFiscal.SetParametros(Objeto: TObject);
var
  obj :TNotaFiscal;
begin
  obj := (Objeto as TNotaFiscal);

  if (obj.CodigoNotaFiscal > 0) then inherited SetParametro('codigo', obj.CodigoNotaFiscal)
  else                               inherited LimpaParametro('codigo');

  inherited SetParametro('numero_nota_fiscal',     Obj.NumeroNotaFiscal);
  inherited SetParametro('codigo_natureza',        obj.CFOP.Codigo);
  inherited SetParametro('serie',                  Obj.Serie);
  inherited SetParametro('codigo_emitente',        obj.Emitente.Codigo);
  inherited SetParametro('codigo_destinatario',    obj.Destinatario.Codigo);

  if assigned( obj.FormaPagamento ) then
    inherited SetParametro('codigo_fpagto',        obj.FormaPagamento.Codigo)
  else
    inherited SetParametro('codigo_fpagto',        1); //uma qualquer apenas para passar (impor. xml entrada)

  inherited SetParametro('data_emissao',           obj.DataEmissao);
  inherited SetParametro('data_saida',             obj.DataSaida);

  if assigned(obj.Transportadora) then
    inherited SetParametro('codigo_transportadora',  obj.Transportadora.Codigo);

  inherited SetParametro('tipo_frete',             TTipoFreteUtilitario.DeEnumeradoParaInteiro(obj.TipoFrete));
  inherited SetParametro('entrada_saida',          obj.Entrada_saida );
  inherited SetParametro('finalidade',             obj.Finalidade );
  inherited SetParametro('nfe_referenciada',       obj.NFe_referenciada );
  inherited SetParametro('entrou_estoque',         obj.EntrouEstoque );
  inherited SetParametro('nota_importacao',        IfThen(obj.notaDeImportacao, 'S', '') );
end;

function TRepositorioNotaFiscal.SQLGet: String;
begin
   result := ' select * from ' + self.GetNomeDaTabela + ' where codigo = :codigo ';
end;

function TRepositorioNotaFiscal.SQLGetAll: String;

begin
   result := ' select * from ' + self.GetNomeDaTabela + IfThen(FIdentificador = '','', CondicaoSQLGetAll) +' order by codigo';
end;

function TRepositorioNotaFiscal.SQLRemover: String;
begin
   result := 'delete from ' + self.GetNomeDaTabela + ' where codigo = :codigo ';
end;

function TRepositorioNotaFiscal.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo, numero_nota_fiscal, codigo_natureza, serie, codigo_emitente, codigo_destinatario, codigo_fpagto, data_emissao,         '+
             '         data_saida, codigo_transportadora, tipo_frete, entrada_saida, finalidade, nfe_referenciada, entrou_estoque, nota_importacao)                                    '+
             ' values (:codigo, :numero_nota_fiscal, :codigo_natureza, :serie, :codigo_emitente, :codigo_destinatario, :codigo_fpagto, :data_emissao, '+
             '         :data_saida, :codigo_transportadora, :tipo_frete, :entrada_saida, :finalidade, :nfe_referenciada, :entrou_estoque, :nota_importacao)                              ';
end;

end.
