unit NFe;

interface

uses
  RetornoNFe,
  Classes;

type
  TNFe = class

  private
    FCodigoNotaFiscal :Integer;
    FChaveAcesso      :String;
    FRetorno          :TRetornoNFe;
    FXML              :TMemoryStream;
    FXMLStringList    :TStringList;
    procedure SetXML(const Value: TMemoryStream);

  private
    function GetChaveAcesso      :String;
    function GetCodigoNotaFiscal :Integer;
    function GetRetorno          :TRetornoNFe;
    function GetXML              :TMemoryStream;
    function GetXMLStringList    :TStringList;
    function GetXMLText          :String;

  private
    property XMLStringList    :TStringList   read GetXMLStringList write FXMLStringList;

  public
    constructor Create(const CodigoNotaFiscal :Integer;
                             ChaveAcesso      :String;
                             const XML :String = '');
    destructor Destroy; override;

  public
    property CodigoNotaFiscal :Integer       read GetCodigoNotaFiscal   write FCodigoNotaFiscal;
    property ChaveAcesso      :String        read GetChaveAcesso;
    property Retorno          :TRetornoNFe   read GetRetorno;
    property XML              :TMemoryStream read GetXML                write SetXML;
    property XMLText          :String        read GetXMLText;

  public
    procedure AdicionarRetorno(Status, Motivo :String);
    procedure AdicionarXML    (XMLStream :TStringStream); overload;
    procedure AdicionarXML    (XMLStream :TMemoryStream); overload;

  public
    function ObtemValorPorTag(const NomeDaTag :String) :String;
end;

implementation

uses
  ExcecaoParametroInvalido,
  Funcoes,
  Repositorio,
  FabricaRepositorio,
  SysUtils;

{ TNFe }

procedure TNFe.AdicionarRetorno(Status, Motivo :String);
begin
   self.FRetorno := TRetornoNFe.Create(self.FCodigoNotaFiscal,
                                       Status,
                                       Motivo);
end;

procedure TNFe.AdicionarXML(XMLStream: TStringStream);
begin
   FreeAndNil(self.FXML);

   self.FXML := TMemoryStream.Create;
   self.FXML.LoadFromStream(XMLStream);
   self.FXMLStringList.LoadFromStream(XMLStream);
end;

procedure TNFe.AdicionarXML(XMLStream: TMemoryStream);
begin
   FreeAndNil(self.FXML);

   self.FXML := TMemoryStream.Create;
   self.FXML.LoadFromStream(XMLStream);
   self.FXMLStringList.LoadFromStream(XMLStream);   
end;

constructor TNFe.Create(const CodigoNotaFiscal: Integer; ChaveAcesso: String; const XML :String);
const
  NOME_METODO = 'Create(const CodigoNotaFiscal: Integer; ChaveAcesso: String)';
var
  Chave :String;
begin
   if (CodigoNotaFiscal <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'CodigoNotaFiscal');

   Chave := ApenasNumeros(ChaveAcesso);

   if Chave.IsEmpty or (Length(Chave) <> 44) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'ChaveAcesso');

   self.FCodigoNotaFiscal := CodigoNotaFiscal;
   self.FChaveAcesso      := Chave;
   self.FRetorno          := nil;
   self.FXML              := TMemoryStream.Create;
   self.FXMLStringList    := TStringList.Create;
   self.FXMLStringList.Add(XML);
end;

destructor TNFe.Destroy;
begin
  FreeAndNil(FRetorno);
  FreeAndNil(FXML);
  FreeAndNil(FXMLStringList);
  
  inherited;
end;

function TNFe.GetChaveAcesso: String;
begin
   result := Trim(self.FChaveAcesso);
end;

function TNFe.GetCodigoNotaFiscal: Integer;
begin
   result := self.FCodigoNotaFiscal;
end;

function TNFe.GetRetorno: TRetornoNFe;
var
  Repositorio :TRepositorio;
begin
   Repositorio := nil;

   try
     if not Assigned(self.FRetorno) then begin
       Repositorio   := TFabricaRepositorio.GetRepositorio(TRetornoNFe.ClassName);
       self.FRetorno := (Repositorio.Get(self.FCodigoNotaFiscal) as TRetornoNFe);
     end;
   finally
     FreeAndNil(Repositorio);
   end;

   result := self.FRetorno;
end;

function TNFe.GetXML: TMemoryStream;
begin
   result := self.FXML;
end;

function TNFe.GetXMLStringList: TStringList;
begin
  if (FXMLStringList.Count <= 0) then
    FXMLStringList.LoadFromStream(self.XML);

  Result := FXMLStringList;
end;

function TNFe.GetXMLText: String;
begin
   result := self.XMLStringList.Text;
end;

function TNFe.ObtemValorPorTag(const NomeDaTag: String): String;
var
  nX                :Integer;
  PosicaoInicial    :Integer;
  PosicaoFinal      :Integer;
  QuantidadeDeCorte :Integer;
begin
   result := '';

   for nX := 0 to (XMLStringList.Count-1) do begin
     PosicaoInicial    := Pos('<'+NomeDaTag+'>', XMLStringList[nX]);
     QuantidadeDeCorte := Length('<'+NomeDaTag+'>');


     if (PosicaoInicial > 0) then begin
       PosicaoFinal := Pos('</'+NomeDaTag+'>', XMLStringList[nX]);

       result := Copy(XMLStringList[nX], (PosicaoInicial + QuantidadeDeCorte), (PosicaoFinal - (PosicaoInicial + QuantidadeDeCorte)));
       exit;
     end;
   end;
end;

procedure TNFe.SetXML(const Value: TMemoryStream);
begin
  self.FXML := Value;
end;

end.
