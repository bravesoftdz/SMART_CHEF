unit RepositorioTransportadora;

interface

uses
  DB,
  Repositorio,
  RepositorioPessoa;

type
  TRepositorioTransportadora = class(TRepositorioPessoa)

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
    function SQLGetExiste(campo: String) :String;            override;

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

{ TRepositorioTransportadora }

function TRepositorioTransportadora.Get(Dataset: TDataSet): TObject;
begin
   result := inherited Get(DataSet);
end;

function TRepositorioTransportadora.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TPessoa(Objeto).codigo;
end;

function TRepositorioTransportadora.GetNomeDaTabela: String;
begin
   result := inherited GetNomeDaTabela;
end;

function TRepositorioTransportadora.GetRepositorio: TRepositorio;
begin
   result := TRepositorioTransportadora.Create;
end;

function TRepositorioTransportadora.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TPessoa(Objeto).codigo <= 0);
end;

function TRepositorioTransportadora.Remover(Objeto: TObject): Boolean;
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

function TRepositorioTransportadora.Salvar(Objeto: TObject): Boolean;
begin
   Result := inherited Salvar(Objeto);
end;

procedure TRepositorioTransportadora.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  inherited SetIdentificador(Objeto, Identificador);
end;

procedure TRepositorioTransportadora.SetParametros(Objeto: TObject);
begin
   inherited SetParametros(Objeto);
end;

function TRepositorioTransportadora.SQLGet: String;
begin
   result := inherited SQLGet;
end;

function TRepositorioTransportadora.SQLGetAll: String;
begin
   result := inherited SQLGetAll+ ' WHERE TIPO = ''T''  order by 1';
end;

function TRepositorioTransportadora.SQLGetExiste(campo: String): String;
begin
  result := inherited SQLGetExiste(campo);
end;

function TRepositorioTransportadora.SQLRemover: String;
begin
   result := inherited SQLRemover;
end;

function TRepositorioTransportadora.SQLSalvar: String;
begin
   result := inherited SQLSalvar;
end;

end.
