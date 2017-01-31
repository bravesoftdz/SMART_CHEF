unit RepositorioNFe;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioNFe = class(TRepositorio)

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

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
    function IsComponente                :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;
end;


implementation

uses
   NFe,
   Classes,
   SysUtils,
   FabricaRepositorio,
   RetornoNFe;

{ TRepositorioNFe }

procedure TRepositorioNFe.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  RepRet :TRepositorio;
  NFe    :TNFe;
begin
   NFe    := (Objeto as TNFe);
   RepRet := nil;

   if Assigned(NFe.Retorno) then begin
     try
       RepRet := TFabricaRepositorio.GetRepositorio(TRetornoNFe.ClassName);
       RepRet.Remover(NFe.Retorno);
       RepRet.Salvar(NFe.Retorno);
     finally
       FreeAndNil(RepRet);
     end;
   end;
end;

function TRepositorioNFe.Get(Dataset: TDataSet): TObject;
var
  XMLBlob   :TBlobField;
  XMLStream :TMemoryStream;
begin
   result := TNFe.Create(Dataset.FieldByName('codigo_nota_fiscal').AsInteger,
                         Dataset.FieldByName('chave_acesso').AsString);

   if not Dataset.FieldByName('XML').IsNull then begin
     XMLStream := nil;
     try
       XMLBlob := TBlobField(Dataset.FieldByName('XML'));
       XMLStream := TMemoryStream.Create;
       XMLBlob.SaveToStream(XMLStream);
       TNFe(result).AdicionarXML(XMLStream);
     finally
       FreeAndNil(XMLStream);
     end;
   end;
end;

function TRepositorioNFe.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TNFe(Objeto).CodigoNotaFiscal;
end;

function TRepositorioNFe.GetNomeDaTabela: String;
begin
   result := 'notas_fiscais_nfe';
end;

function TRepositorioNFe.GetRepositorio: TRepositorio;
begin
   result := TRepositorioNFe.Create;
end;

function TRepositorioNFe.IsComponente: Boolean;
begin
   result := true;
end;

function TRepositorioNFe.IsInsercao(Objeto: TObject): Boolean;
begin
   result := true;
end;

procedure TRepositorioNFe.SetParametros(Objeto: TObject);
var
  NFe :TNFe;
begin
   NFe := (Objeto as TNFe);

   inherited SetParametro('codigo_nota_fiscal', NFe.CodigoNotaFiscal);
   inherited SetParametro('chave_acesso',       NFe.ChaveAcesso);

  inherited SetParametroBlob('xml',            NFe.XML);
end;

function TRepositorioNFe.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_Fiscal ';
end;

function TRepositorioNFe.SQLGetAll: String;
begin
   result := ' select * from '+self.GetNomeDaTabela+' order by codigo_nota_fiscal ';
end;

function TRepositorioNFe.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo_nota_fiscal = :codigo_nota_fiscal ';
end;

function TRepositorioNFe.SQLSalvar: String;
begin
   result := 'update or insert into '+self.GetNomeDaTabela+'  (codigo_nota_fiscal,    chave_acesso,  XML) '+
                                                      'values (:codigo_nota_fiscal,  :chave_acesso, :XML) ';
end;

end.
