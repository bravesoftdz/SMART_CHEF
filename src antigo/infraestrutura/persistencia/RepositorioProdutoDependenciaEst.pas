unit RepositorioProdutoDependenciaEst;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioProdutoDependenciaEst = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses SysUtils, ProdutoDependenciaEst;

{ TRepositorioProdutoDependenciaEst }

function TRepositorioProdutoDependenciaEst.Get(Dataset: TDataSet): TObject;
var
  ProdutoDependenciaEst :TProdutoDependenciaEst;
begin
   ProdutoDependenciaEst:= TProdutoDependenciaEst.Create;
   ProdutoDependenciaEst.codigo           := self.FQuery.FieldByName('codigo').AsInteger;
   ProdutoDependenciaEst.codigo_produto   := self.FQuery.FieldByName('codigo_produto').AsInteger;
   ProdutoDependenciaEst.codigo_dispensa  := self.FQuery.FieldByName('codigo_dispensa').AsInteger;
   ProdutoDependenciaEst.quantidade_baixa := self.FQuery.FieldByName('quantidade_baixa').AsFloat;

   result := ProdutoDependenciaEst;
end;

function TRepositorioProdutoDependenciaEst.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TProdutoDependenciaEst(Objeto).Codigo;
end;

function TRepositorioProdutoDependenciaEst.GetNomeDaTabela: String;
begin
  result := 'PRODUTO_DEPENDENCIA_EST';
end;

function TRepositorioProdutoDependenciaEst.GetRepositorio: TRepositorio;
begin
  result := TRepositorioProdutoDependenciaEst.Create;
end;

function TRepositorioProdutoDependenciaEst.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TProdutoDependenciaEst(Objeto).Codigo <= 0);
end;

procedure TRepositorioProdutoDependenciaEst.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ProdutoDependenciaEstAntigo :TProdutoDependenciaEst;
  ProdutoDependenciaEstNovo :TProdutoDependenciaEst;
begin
   ProdutoDependenciaEstAntigo := (AntigoObjeto as TProdutoDependenciaEst);
   ProdutoDependenciaEstNovo   := (Objeto       as TProdutoDependenciaEst);

   if (ProdutoDependenciaEstAntigo.codigo_produto <> ProdutoDependenciaEstNovo.codigo_produto) then
     Auditoria.AdicionaCampoAlterado('codigo_produto', IntToStr(ProdutoDependenciaEstAntigo.codigo_produto), IntToStr(ProdutoDependenciaEstNovo.codigo_produto));

   if (ProdutoDependenciaEstAntigo.codigo_dispensa <> ProdutoDependenciaEstNovo.codigo_dispensa) then
     Auditoria.AdicionaCampoAlterado('codigo_dispensa', IntToStr(ProdutoDependenciaEstAntigo.codigo_dispensa), IntToStr(ProdutoDependenciaEstNovo.codigo_dispensa));

   if (ProdutoDependenciaEstAntigo.quantidade_baixa <> ProdutoDependenciaEstNovo.quantidade_baixa) then
     Auditoria.AdicionaCampoAlterado('quantidade_baixa', FloatToStr(ProdutoDependenciaEstAntigo.quantidade_baixa), FloatToStr(ProdutoDependenciaEstNovo.quantidade_baixa));

end;

procedure TRepositorioProdutoDependenciaEst.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ProdutoDependenciaEst :TProdutoDependenciaEst;
begin
  ProdutoDependenciaEst := (Objeto as TProdutoDependenciaEst);
  Auditoria.AdicionaCampoExcluido('codigo'          , IntToStr(ProdutoDependenciaEst.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_produto'  , IntToStr(ProdutoDependenciaEst.codigo_produto));
  Auditoria.AdicionaCampoExcluido('codigo_dispensa' , IntToStr(ProdutoDependenciaEst.codigo_dispensa));
  Auditoria.AdicionaCampoExcluido('quantidade_baixa', FloatToStr(ProdutoDependenciaEst.quantidade_baixa));
end;

procedure TRepositorioProdutoDependenciaEst.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  ProdutoDependenciaEst :TProdutoDependenciaEst;
begin
  ProdutoDependenciaEst := (Objeto as TProdutoDependenciaEst);
  Auditoria.AdicionaCampoIncluido('codigo'          ,    IntToStr(ProdutoDependenciaEst.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_produto'  ,    IntToStr(ProdutoDependenciaEst.codigo_produto));
  Auditoria.AdicionaCampoIncluido('codigo_dispensa' ,    IntToStr(ProdutoDependenciaEst.codigo_dispensa));
  Auditoria.AdicionaCampoIncluido('quantidade_baixa',    FloatToStr(ProdutoDependenciaEst.quantidade_baixa));
end;

procedure TRepositorioProdutoDependenciaEst.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TProdutoDependenciaEst(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioProdutoDependenciaEst.SetParametros(Objeto: TObject);
var
  ProdutoDependenciaEst :TProdutoDependenciaEst;
begin
  ProdutoDependenciaEst := (Objeto as TProdutoDependenciaEst);

  self.FQuery.ParamByName('codigo').AsInteger           := ProdutoDependenciaEst.codigo;
  self.FQuery.ParamByName('codigo_produto').AsInteger   := ProdutoDependenciaEst.codigo_produto;
  self.FQuery.ParamByName('codigo_dispensa').AsInteger  := ProdutoDependenciaEst.codigo_dispensa;
  self.FQuery.ParamByName('quantidade_baixa').AsFloat := ProdutoDependenciaEst.quantidade_baixa;
end;

function TRepositorioProdutoDependenciaEst.SQLGet: String;
begin
  result := 'select * from PRODUTO_DEPENDENCIA_EST where codigo = :ncod';
end;

function TRepositorioProdutoDependenciaEst.SQLGetAll: String;
begin
  result := 'select * from PRODUTO_DEPENDENCIA_EST';
end;

function TRepositorioProdutoDependenciaEst.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PRODUTO_DEPENDENCIA_EST where '+ campo +' = :ncampo';
end;

function TRepositorioProdutoDependenciaEst.SQLRemover: String;
begin
  result := ' delete from PRODUTO_DEPENDENCIA_EST where codigo = :codigo ';
end;

function TRepositorioProdutoDependenciaEst.SQLSalvar: String;
begin
  result := 'update or insert into PRODUTO_DEPENDENCIA_EST (CODIGO ,CODIGO_PRODUTO ,CODIGO_DISPENSA ,QUANTIDADE_BAIXA) '+
            '                               values ( :CODIGO , :CODIGO_PRODUTO , :CODIGO_DISPENSA , :QUANTIDADE_BAIXA) ';
end;

end.

