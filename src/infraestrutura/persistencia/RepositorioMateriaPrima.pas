unit RepositorioMateriaPrima;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioMateriaPrima = class(TRepositorio)

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

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;

end;

implementation

uses
  SysUtils,
  MateriaPrima;

{ TRepositorioMateriaPrima }

function TRepositorioMateriaPrima.Get(Dataset: TDataSet): TObject;
var
  MateriaPrima :TMateriaPrima;
begin
   MateriaPrima               := TMateriaPrima.Create;
   MateriaPrima.Codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   MateriaPrima.descricao     := self.FQuery.FieldByName('descricao').AsString;
   MateriaPrima.valor         := self.FQuery.FieldByName('valor').AsFloat;
   MateriaPrima.descricao2    := self.FQuery.FieldByName('descricao2').AsString;
   MateriaPrima.codigoProduto := self.FQuery.FieldByName('codigo_produto').AsInteger;
   MateriaPrima.quantidade    := self.FQuery.FieldByName('quantidade').AsFloat;

   result := MateriaPrima;
end;

function TRepositorioMateriaPrima.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TMateriaPrima(Objeto).Codigo;
end;

function TRepositorioMateriaPrima.GetNomeDaTabela: String;
begin
   result := 'Materias_PrimaS';
end;

function TRepositorioMateriaPrima.GetRepositorio: TRepositorio;
begin
   result := TRepositorioMateriaPrima.Create;
end;

function TRepositorioMateriaPrima.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TMateriaPrima(Objeto).Codigo <= 0);
end;

procedure TRepositorioMateriaPrima.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  MateriaPrimaAntigo :TMateriaPrima;
  MateriaPrimaNovo   :TMateriaPrima;
begin
   MateriaPrimaAntigo := (AntigoObjeto as TMateriaPrima);
   MateriaPrimaNovo   := (Objeto       as TMateriaPrima);

   if (MateriaPrimaAntigo.descricao <> MateriaPrimaNovo.descricao) then
    Auditoria.AdicionaCampoAlterado('descricao', MateriaPrimaAntigo.descricao, MateriaPrimaNovo.descricao);

   if (MateriaPrimaAntigo.valor <> MateriaPrimaNovo.valor) then
    Auditoria.AdicionaCampoAlterado('valor', FloatToStr(MateriaPrimaAntigo.valor), FloatToStr(MateriaPrimaNovo.valor) );

   if (MateriaPrimaAntigo.descricao2 <> MateriaPrimaNovo.descricao2) then
    Auditoria.AdicionaCampoAlterado('descricao2', MateriaPrimaAntigo.descricao2, MateriaPrimaNovo.descricao2 );

   if (MateriaPrimaAntigo.codigoProduto <> MateriaPrimaNovo.codigoProduto) then
    Auditoria.AdicionaCampoAlterado('codigo_Produto', IntToStr(MateriaPrimaAntigo.codigoProduto), intToStr(MateriaPrimaNovo.codigoProduto) );

   if (MateriaPrimaAntigo.quantidade <> MateriaPrimaNovo.quantidade) then
    Auditoria.AdicionaCampoAlterado('quantidade', FloatToStr(MateriaPrimaAntigo.quantidade), FloatToStr(MateriaPrimaNovo.quantidade) );
end;

procedure TRepositorioMateriaPrima.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  MateriaPrima :TMateriaPrima;
begin
   MateriaPrima := (Objeto as TMateriaPrima);

   Auditoria.AdicionaCampoExcluido('codigo',    IntToStr(MateriaPrima.Codigo));
   Auditoria.AdicionaCampoExcluido('descricao', MateriaPrima.descricao);
   Auditoria.AdicionaCampoExcluido('valor',     FloatToStr(MateriaPrima.valor));
   Auditoria.AdicionaCampoExcluido('descricao2', MateriaPrima.descricao2);
   Auditoria.AdicionaCampoExcluido('codigo_produto', intToStr(MateriaPrima.codigoProduto));
   Auditoria.AdicionaCampoExcluido('quantidade',     FloatToStr(MateriaPrima.quantidade));
end;

procedure TRepositorioMateriaPrima.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  MateriaPrima :TMateriaPrima;
begin
   MateriaPrima := (Objeto as TMateriaPrima);

   Auditoria.AdicionaCampoIncluido('codigo',    IntToStr(MateriaPrima.codigo));
   Auditoria.AdicionaCampoIncluido('descricao', MateriaPrima.descricao);
   Auditoria.AdicionaCampoIncluido('valor',     FloatToStr(MateriaPrima.valor));
   Auditoria.AdicionaCampoIncluido('descricao2', MateriaPrima.descricao2);
   Auditoria.AdicionaCampoIncluido('codigo_produto', intToStr(MateriaPrima.codigoProduto));
   Auditoria.AdicionaCampoIncluido('quantidade',     FloatToStr(MateriaPrima.quantidade));
end;

procedure TRepositorioMateriaPrima.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TMateriaPrima(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioMateriaPrima.SetParametros(Objeto: TObject);
var
  MateriaPrima :TMateriaPrima;
begin
   MateriaPrima := (Objeto as TMateriaPrima);

   self.FQuery.ParamByName('codigo').AsInteger           := MateriaPrima.Codigo;
   self.FQuery.ParamByName('descricao').AsString         := MateriaPrima.descricao;
   self.FQuery.ParamByName('valor').AsFloat              := MateriaPrima.valor;
   self.FQuery.ParamByName('descricao2').AsString        := MateriaPrima.descricao2;
   self.FQuery.ParamByName('codigo_produto').AsInteger   := MateriaPrima.codigoProduto;
   self.FQuery.ParamByName('quantidade').AsFloat         := MateriaPrima.quantidade;
end;

function TRepositorioMateriaPrima.SQLGet: String;
begin
  result := 'select * from MateriaS_Primas where codigo = :ncod';
end;

function TRepositorioMateriaPrima.SQLGetAll: String;
begin
   result := 'select * from Materias_Primas';
end;

function TRepositorioMateriaPrima.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Materias_Primas where '+ campo +' = :ncampo';
end;

function TRepositorioMateriaPrima.SQLRemover: String;
begin
   result := ' delete from Materias_Primas where codigo = :codigo ';
end;

function TRepositorioMateriaPrima.SQLSalvar: String;
begin
   result := 'update or insert into Materias_Primas (codigo, descricao, valor, descricao2, codigo_produto, quantidade)    '+
             '                               values (:codigo, :descricao, :valor, :descricao2, :codigo_produto, :quantidade) ';
end;

end.
