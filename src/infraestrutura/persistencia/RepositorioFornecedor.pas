unit RepositorioFornecedor;

interface

uses
  DB,
  Repositorio,
  RepositorioPessoa;

type
  TRepositorioFornecedor = class(TRepositorioPessoa)

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
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  //==============================================================================
  // Métodos de persistência no banco dados.
  //==============================================================================
  public
    function Salvar (Objeto              :TObject) :Boolean; override;
    function Remover(Objeto              :TObject) :Boolean; override;
end;

implementation

uses
  Pessoa,
  TipoRegimeTributario,
  SysUtils, FabricaRepositorio, ConfiguracoesNF, ConfiguracoesNFEmail, ParametrosNFCe, Endereco;

{ TRepositorioFornecedor }

function TRepositorioFornecedor.Get(Dataset: TDataSet): TObject;
begin
   result := inherited Get(DataSet);
end;

function TRepositorioFornecedor.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPessoa(Objeto).codigo;
end;

function TRepositorioFornecedor.GetNomeDaTabela: String;
begin
   result := inherited GetNomeDaTabela;
end;

function TRepositorioFornecedor.GetRepositorio: TRepositorio;
begin
   result := TRepositorioFornecedor.Create;
end;

function TRepositorioFornecedor.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TPessoa(Objeto).codigo <= 0);
end;

function TRepositorioFornecedor.Remover(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     result := inherited Remover(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

function TRepositorioFornecedor.Salvar(Objeto: TObject): Boolean;
begin
   Result := inherited Salvar(Objeto);
end;

procedure TRepositorioFornecedor.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  inherited SetIdentificador(Objeto, Identificador);
end;

procedure TRepositorioFornecedor.SetParametros(Objeto: TObject);
begin
   inherited SetParametros(Objeto);
end;

function TRepositorioFornecedor.SQLGet: String;
begin
   result := inherited SQLGet;
end;

function TRepositorioFornecedor.SQLGetAll: String;
begin
   result := inherited SQLGetAll+ ' WHERE TIPO = ''F''  order by 1';
end;

function TRepositorioFornecedor.SQLGetExiste(campo: String): String;
begin
  result := inherited SQLGetExiste(campo);
end;

function TRepositorioFornecedor.SQLRemover: String;
begin
   result := inherited SQLRemover;
end;

function TRepositorioFornecedor.SQLSalvar: String;
begin
   result := inherited SQLSalvar;
end;
end.

