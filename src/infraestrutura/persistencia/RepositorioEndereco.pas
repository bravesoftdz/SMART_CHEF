unit RepositorioEndereco;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioEndereco = class(TRepositorio)

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

uses SysUtils, Endereco;

{ TRepositorioEndereco }

function TRepositorioEndereco.Get(Dataset: TDataSet): TObject;
var
  Endereco :TEndereco;
begin
   Endereco:= TEndereco.Create;
   Endereco.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Endereco.codigo_pessoa  := self.FQuery.FieldByName('codigo_pessoa').AsInteger;
   Endereco.cep            := self.FQuery.FieldByName('cep').AsString;
   Endereco.logradouro     := self.FQuery.FieldByName('logradouro').AsString;
   Endereco.numero         := self.FQuery.FieldByName('numero').AsString;
   Endereco.referencia     := self.FQuery.FieldByName('referencia').AsString;
   Endereco.bairro         := self.FQuery.FieldByName('bairro').AsString;
   Endereco.codigo_cidade  := self.FQuery.FieldByName('codigo_cidade').AsInteger;
   Endereco.uf             := self.FQuery.FieldByName('uf').AsString;
   Endereco.fone           := self.FQuery.FieldByName('fone').AsString;

   result := Endereco;
end;

function TRepositorioEndereco.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEndereco(Objeto).Codigo;
end;

function TRepositorioEndereco.GetNomeDaTabela: String;
begin
  result := 'ENDERECOS';
end;

function TRepositorioEndereco.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEndereco.Create;
end;

function TRepositorioEndereco.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEndereco(Objeto).Codigo <= 0);
end;

procedure TRepositorioEndereco.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  EnderecoAntigo :TEndereco;
  EnderecoNovo :TEndereco;
begin
   EnderecoAntigo := (AntigoObjeto as TEndereco);
   EnderecoNovo   := (Objeto       as TEndereco);

   if (EnderecoAntigo.codigo_pessoa <> EnderecoNovo.codigo_pessoa) then
     Auditoria.AdicionaCampoAlterado('codigo_pessoa', IntToStr(EnderecoAntigo.codigo_pessoa), IntToStr(EnderecoNovo.codigo_pessoa));

   if (EnderecoAntigo.cep <> EnderecoNovo.cep) then
     Auditoria.AdicionaCampoAlterado('cep', EnderecoAntigo.cep, EnderecoNovo.cep);

   if (EnderecoAntigo.logradouro <> EnderecoNovo.logradouro) then
     Auditoria.AdicionaCampoAlterado('logradouro', EnderecoAntigo.logradouro, EnderecoNovo.logradouro);

   if (EnderecoAntigo.numero <> EnderecoNovo.numero) then
     Auditoria.AdicionaCampoAlterado('numero', EnderecoAntigo.numero, EnderecoNovo.numero);

   if (EnderecoAntigo.referencia <> EnderecoNovo.referencia) then
     Auditoria.AdicionaCampoAlterado('referencia', EnderecoAntigo.referencia, EnderecoNovo.referencia);

   if (EnderecoAntigo.bairro <> EnderecoNovo.bairro) then
     Auditoria.AdicionaCampoAlterado('bairro', EnderecoAntigo.bairro, EnderecoNovo.bairro);

   if (EnderecoAntigo.codigo_cidade <> EnderecoNovo.codigo_cidade) then
     Auditoria.AdicionaCampoAlterado('codigo_cidade', IntToStr(EnderecoAntigo.codigo_cidade), IntToStr(EnderecoNovo.codigo_cidade));

   if (EnderecoAntigo.uf <> EnderecoNovo.uf) then
     Auditoria.AdicionaCampoAlterado('uf', EnderecoAntigo.uf, EnderecoNovo.uf);

   if (EnderecoAntigo.fone <> EnderecoNovo.fone) then
     Auditoria.AdicionaCampoAlterado('fone', EnderecoAntigo.fone, EnderecoNovo.fone);

end;

procedure TRepositorioEndereco.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Endereco :TEndereco;
begin
  Endereco := (Objeto as TEndereco);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(Endereco.codigo));
  Auditoria.AdicionaCampoExcluido('codigo_pessoa' ,    IntToStr(Endereco.codigo_pessoa));
  Auditoria.AdicionaCampoExcluido('cep'           , Endereco.cep);
  Auditoria.AdicionaCampoExcluido('logradouro'    , Endereco.logradouro);
  Auditoria.AdicionaCampoExcluido('numero'        , Endereco.numero);
  Auditoria.AdicionaCampoExcluido('referencia'    , Endereco.referencia);
  Auditoria.AdicionaCampoExcluido('bairro'        , Endereco.bairro);
  Auditoria.AdicionaCampoExcluido('codigo_cidade' , IntToStr(Endereco.codigo_cidade));
  Auditoria.AdicionaCampoExcluido('uf'            , Endereco.uf);
  Auditoria.AdicionaCampoExcluido('fone'          , Endereco.fone);
end;

procedure TRepositorioEndereco.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Endereco :TEndereco;
begin
  Endereco := (Objeto as TEndereco);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(Endereco.codigo));
  Auditoria.AdicionaCampoIncluido('codigo_pessoa' ,    IntToStr(Endereco.codigo_pessoa));
  Auditoria.AdicionaCampoIncluido('cep'           ,    Endereco.cep);
  Auditoria.AdicionaCampoIncluido('logradouro'    ,    Endereco.logradouro);
  Auditoria.AdicionaCampoIncluido('numero'        ,    Endereco.numero);
  Auditoria.AdicionaCampoIncluido('referencia'    ,    Endereco.referencia);
  Auditoria.AdicionaCampoIncluido('bairro'        ,    Endereco.bairro);
  Auditoria.AdicionaCampoIncluido('codigo_cidade' ,    IntToStr(Endereco.codigo_cidade));
  Auditoria.AdicionaCampoIncluido('uf'            ,    Endereco.uf);
  Auditoria.AdicionaCampoIncluido('fone'          ,    Endereco.fone);
end;

procedure TRepositorioEndereco.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEndereco(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEndereco.SetParametros(Objeto: TObject);
var
  Endereco :TEndereco;
begin
  Endereco := (Objeto as TEndereco);

  self.FQuery.ParamByName('codigo').AsInteger         := Endereco.codigo;
  self.FQuery.ParamByName('codigo_pessoa').AsInteger  := Endereco.codigo_pessoa;
  self.FQuery.ParamByName('cep').AsString            := Endereco.cep;
  self.FQuery.ParamByName('logradouro').AsString     := Endereco.logradouro;
  self.FQuery.ParamByName('numero').AsString         := Endereco.numero;
  self.FQuery.ParamByName('referencia').AsString     := Endereco.referencia;
  self.FQuery.ParamByName('bairro').AsString         := Endereco.bairro;

  if Endereco.codigo_cidade > 0 then
    self.FQuery.ParamByName('codigo_cidade').AsInteger  := Endereco.codigo_cidade;
    
  self.FQuery.ParamByName('uf').AsString             := Endereco.uf;
  self.FQuery.ParamByName('fone').AsString           := Endereco.fone;
end;

function TRepositorioEndereco.SQLGet: String;
begin
  result := 'select * from ENDERECOS where codigo = :ncod';
end;

function TRepositorioEndereco.SQLGetAll: String;
begin
  result := 'select * from ENDERECOS';
end;

function TRepositorioEndereco.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ENDERECOS where '+ campo +' = :ncampo';
end;

function TRepositorioEndereco.SQLRemover: String;
begin
  result := ' delete from ENDERECOS where codigo = :codigo ';
end;

function TRepositorioEndereco.SQLSalvar: String;
begin
  result := 'update or insert into ENDERECOS ( CODIGO, CODIGO_PESSOA ,CEP ,LOGRADOURO ,NUMERO ,REFERENCIA ,BAIRRO ,CODIGO_CIDADE ,UF, FONE) '+
           '                      values ( :CODIGO, :CODIGO_PESSOA , :CEP , :LOGRADOURO , :NUMERO , :REFERENCIA , :BAIRRO , :CODIGO_CIDADE , :UF, :FONE) ';
end;

end.

