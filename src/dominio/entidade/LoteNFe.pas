unit LoteNFe;

interface

uses
  RetornoLoteNFe;

type
  TLoteNFe = class

  private
    FCodigo           :Integer;
    FCodigoNotaFiscal :Integer;
    FData             :TDateTime;
    FRetorno          :TRetornoLoteNFe;
    procedure SetCodigo(const Value: Integer);

  private
    function GetCodigo           :Integer;
    function GetCodigoNotaFiscal :Integer;
    function GetData             :TDateTime;
    function GetRetornoLoteNFe   :TRetornoLoteNFe;

  public
    constructor CriaLoteEmProcessamento(CodigoNotaFiscal :Integer);
    constructor CriaParaRepositorio(Codigo           :Integer;
                                    CodigoNotaFiscal :Integer;
                                    Data             :TDateTime);
    destructor  Destroy; override;

  public
    property Codigo           :Integer          read GetCodigo            write SetCodigo;
    property CodigoNotaFiscal :Integer          read GetCodigoNotaFiscal  write FCodigoNotaFiscal;
    property Data             :TDateTime        read GetData;
    property Retorno          :TRetornoLoteNFe  read GetRetornoLoteNFe;

  public
    procedure AdicionarRetornoLote(Status :String; Motivo :String; Recibo :String);
end;

implementation

uses
  ExcecaoParametroInvalido,
  SysUtils,
  Repositorio,
  FabricaRepositorio;

{ TLoteNFe }

procedure TLoteNFe.AdicionarRetornoLote(Status, Motivo, Recibo: String);
begin
   FreeAndNil(self.FRetorno);
   self.FRetorno := TRetornoLoteNFe.Create(self.FCodigo, Status, Motivo, Recibo);
end;

constructor TLoteNFe.CriaLoteEmProcessamento(CodigoNotaFiscal :Integer);
begin
   if (CodigoNotaFiscal <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'CriaLoteEmProcessamento(CodigoNotaFiscal :Integer)', 'CodigoNotaFiscal');
    
   self.FCodigo           := 0;
   self.FCodigoNotaFiscal := CodigoNotaFiscal;
   self.FData             := Now;
   self.FRetorno          := nil;
end;

constructor TLoteNFe.CriaParaRepositorio(Codigo, CodigoNotaFiscal: Integer;
  Data: TDateTime);
begin
   self.FCodigo           := Codigo;
   self.FCodigoNotaFiscal := CodigoNotaFiscal;
   self.FData             := Data;
   self.FRetorno          := nil;   
end;

destructor TLoteNFe.Destroy;
begin
   FreeAndNil(self.FRetorno);
   
  inherited;
end;

function TLoteNFe.GetCodigo: Integer;
begin
   result := self.FCodigo;
end;

function TLoteNFe.GetCodigoNotaFiscal: Integer;
begin
   result := self.FCodigoNotaFiscal;
end;

function TLoteNFe.GetData: TDateTime;
begin
   result := self.FData;
end;

function TLoteNFe.GetRetornoLoteNFe: TRetornoLoteNFe;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FRetorno) then begin
      Repositorio := nil;

      try
         Repositorio     := TFabricaRepositorio.GetRepositorio(TRetornoLoteNFe.ClassName);
         self.FRetorno   := (Repositorio.Get(self.FCodigo) as TRetornoLoteNFe);
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   result := self.FRetorno;
end;

procedure TLoteNFe.SetCodigo(const Value: Integer);
begin
   self.FCodigo := Value;
end;

end.
