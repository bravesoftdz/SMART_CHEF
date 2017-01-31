unit RetornoLoteNFe;

interface

type
  TRetornoLoteNFe = class

  private
    FCodigoLote :Integer;
    FStatus     :String;
    FMotivo     :String;
    FRecibo     :String;

  private
    function GetCodigoLote: Integer;
    function GetMotivo: String;
    function GetRecibo: String;
    function GetStatus: String;

  public
    constructor Create(const CodigoLote :Integer;
                             Status     :String;
                             Motivo     :String;
                             Recibo     :String);

  public
    property CodigoLote :Integer read GetCodigoLote;
    property Status     :String  read GetStatus;
    property Motivo     :String  read GetMotivo;
    property Recibo     :String  read GetRecibo;
end;

implementation

uses
  ExcecaoParametroInvalido, StringUtilitario;

{ TRetornoLoteNFe }

constructor TRetornoLoteNFe.Create(const CodigoLote: Integer; Status, Motivo, Recibo: String);
const
  NOME_DO_METODO = 'Create(const CodigoLote: Integer; Status, Motivo, Recibo: String)';
begin
   if (CodigoLote <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'CodigoLote');

   if (TStringUtilitario.EstaVazia(Status) or (Length(Status) <> 3)) then
     raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'Status');

   if (TStringUtilitario.EstaVazia(Motivo)) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'Motivo');

   if (TStringUtilitario.EstaVazia(Recibo)) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_DO_METODO, 'Recibo');

   self.FCodigoLote := CodigoLote;
   self.FStatus     := Status;
   self.FMotivo     := Motivo;
   self.FRecibo     := Recibo;
end;

function TRetornoLoteNFe.GetCodigoLote: Integer;
begin
   result := self.FCodigoLote;
end;

function TRetornoLoteNFe.GetMotivo: String;
begin
   result := self.FMotivo;
end;

function TRetornoLoteNFe.GetRecibo: String;
begin
   result := self.FRecibo;
end;

function TRetornoLoteNFe.GetStatus: String;
begin
   result := self.FStatus;
end;

end.
