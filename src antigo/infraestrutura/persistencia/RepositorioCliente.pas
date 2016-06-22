unit RepositorioCliente;

interface

uses DB, Auditoria, Repositorio;

type
  TRepositorioCliente = class(TRepositorio)

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

uses SysUtils, Cliente;

{ TRepositorioCliente }

function TRepositorioCliente.Get(Dataset: TDataSet): TObject;
var
  Cliente :TCliente;
begin
   Cliente:= TCliente.Create;
   Cliente.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   Cliente.nome          := self.FQuery.FieldByName('nome').AsString;
   Cliente.cpf_cnpj      := self.FQuery.FieldByName('cpf_cnpj').AsString;

   result := Cliente;
end;

function TRepositorioCliente.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TCliente(Objeto).Codigo;
end;

function TRepositorioCliente.GetNomeDaTabela: String;
begin
  result := 'CLIENTES';
end;

function TRepositorioCliente.GetRepositorio: TRepositorio;
begin
  result := TRepositorioCliente.Create;
end;

function TRepositorioCliente.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TCliente(Objeto).Codigo <= 0);
end;

procedure TRepositorioCliente.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ClienteAntigo :TCliente;
  ClienteNovo :TCliente;
begin
   ClienteAntigo := (AntigoObjeto as TCliente);
   ClienteNovo   := (Objeto       as TCliente);

   if (ClienteAntigo.nome <> ClienteNovo.nome) then
     Auditoria.AdicionaCampoAlterado('nome', ClienteAntigo.nome, ClienteNovo.nome);

   if (ClienteAntigo.cpf_cnpj <> ClienteNovo.cpf_cnpj) then
     Auditoria.AdicionaCampoAlterado('cpf_cnpj', ClienteAntigo.cpf_cnpj, ClienteNovo.cpf_cnpj);

end;

procedure TRepositorioCliente.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Cliente :TCliente;
begin
  Cliente := (Objeto as TCliente);
  Auditoria.AdicionaCampoExcluido('codigo'       , IntToStr(Cliente.codigo));
  Auditoria.AdicionaCampoExcluido('nome'         , Cliente.nome);
  Auditoria.AdicionaCampoExcluido('cpf_cnpj'     , Cliente.cpf_cnpj);
end;

procedure TRepositorioCliente.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Cliente :TCliente;
begin
  Cliente := (Objeto as TCliente);
  Auditoria.AdicionaCampoIncluido('codigo'       ,    IntToStr(Cliente.codigo));
  Auditoria.AdicionaCampoIncluido('nome'         ,    Cliente.nome);
  Auditoria.AdicionaCampoIncluido('cpf_cnpj'     ,    Cliente.cpf_cnpj);
end;

procedure TRepositorioCliente.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TCliente(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioCliente.SetParametros(Objeto: TObject);
var
  Cliente :TCliente;
begin
  Cliente := (Objeto as TCliente);

  self.FQuery.ParamByName('codigo').AsInteger        := Cliente.codigo;
  self.FQuery.ParamByName('nome').AsString          := Cliente.nome;
  self.FQuery.ParamByName('cpf_cnpj').AsString      := Cliente.cpf_cnpj;
end;

function TRepositorioCliente.SQLGet: String;
begin
  result := 'select * from CLIENTES where codigo = :ncod';
end;

function TRepositorioCliente.SQLGetAll: String;
begin
  result := 'select * from CLIENTES order by 1';
end;

function TRepositorioCliente.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CLIENTES where '+ campo +' = :ncampo';
end;

function TRepositorioCliente.SQLRemover: String;
begin
  result := ' delete from CLIENTES where codigo = :codigo ';
end;

function TRepositorioCliente.SQLSalvar: String;
begin
  result := 'update or insert into CLIENTES (CODIGO ,NOME ,CPF_CNPJ ) '+
           '                      values ( :CODIGO , :NOME , :CPF_CNPJ) ';
end;

end.

