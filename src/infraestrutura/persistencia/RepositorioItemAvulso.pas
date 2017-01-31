unit RepositorioItemAvulso;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioItemAvulso = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;      override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto          :TObject; Identificador :Variant); override;

end;

implementation

uses
  SysUtils,
  ItemAvulso, FabricaRepositorio;

{ TRepositorioItemAvulso }

function TRepositorioItemAvulso.Get(Dataset: TDataSet): TObject;
begin
   result := TItemAvulso.CriaParaRepositorio(Dataset.FieldByName('codigo').AsInteger,
                                             Dataset.FieldByName('codigo_nota_fiscal').AsInteger,
                                             Dataset.FieldByName('codigo_produto').AsInteger,
                                             Dataset.FieldByName('preco').AsFloat,
                                             Dataset.FieldByName('percentual_desconto').AsFloat,
                                             Dataset.FieldByName('quantidade').AsFloat);
end;

function TRepositorioItemAvulso.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TItemAvulso(Objeto).CodigoNotaFiscal;
end;

function TRepositorioItemAvulso.GetNomeDaTabela: String;
begin
   result := 'itens_avulsos';
end;

function TRepositorioItemAvulso.GetRepositorio: TRepositorio;
begin
   result := TRepositorioItemAvulso.Create;
end;

function TRepositorioItemAvulso.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioItemAvulso.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TItemAvulso(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioItemAvulso.SetParametros(Objeto: TObject);
var
   ItemAvulso :TItemAvulso;
begin
   ItemAvulso := (Objeto as TItemAvulso);

   inherited SetParametro('codigo',              ItemAvulso.Codigo);
   inherited SetParametro('codigo_nota_fiscal',  ItemAvulso.CodigoNotaFiscal);
   inherited SetParametro('codigo_produto',      ItemAvulso.Produto.Codigo);
   inherited SetParametro('preco',               ItemAvulso.Preco);
   inherited SetParametro('percentual_desconto', ItemAvulso.PercentualDesconto);
   inherited SetParametro('Quantidade',          ItemAvulso.Quantidade);
end;

function TRepositorioItemAvulso.SQLGet: String;
begin
   result := 'select * from '+ self.GetNomeDaTabela + ' where codigo_nota_fiscal = :codigo_nota_fiscal ';  
end;

function TRepositorioItemAvulso.SQLGetAll: String;
begin
   result := 'select * from '+ self.GetNomeDaTabela;
end;

function TRepositorioItemAvulso.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioItemAvulso.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela +' (codigo, codigo_nota_fiscal,  codigo_produto,    '+
                                                            '  preco, percentual_desconto, quantidade)         '+
                                    'values                   (:codigo, :codigo_nota_fiscal,  :codigo_produto, '+
                                                            '  :preco, :percentual_desconto, :quantidade)      ';
end;

end.
