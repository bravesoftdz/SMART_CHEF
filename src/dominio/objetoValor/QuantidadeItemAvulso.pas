unit QuantidadeItemAvulso;

interface

uses
  Tamanho,
  MetodoDelegadoObtemCampoInteger;

type
  TQuantidadeItemAvulso = class

  private
    FCodigo               :Integer;
    FCodigoItemItemAvulso :Integer;
    FCodigoTamanho        :Integer;
    FQuantidade           :Integer;

    FBuscadorCodigoItemAvulso :TMetodoDelegadoObtemCampoInteger;
    FTamanho                  :TTamanho;

  private
    function GetCodigo           :Integer;
    function GetCodigoItemAvulso :Integer;
    function GetQuantidade       :Integer;
    function GetTamanho          :TTamanho;

  public
    constructor CriarParaRepositorio(Codigo           :Integer;
                                     CodigoItemAvulso :Integer;
                                     CodigoTamanho    :Integer;
                                     Quantidade       :Integer);

    constructor Create(BuscadorCodigoItemAvulso :TMetodoDelegadoObtemCampoInteger;
                       Tamanho                   :TTamanho;
                       Quantidade                :Integer);
    destructor  Destroy; override;

  public
    property Codigo           :Integer   read GetCodigo;
    property CodigoItemAvulso :Integer   read GetCodigoItemAvulso;
    property Tamanho          :TTamanho  read GetTamanho;
    property Quantidade       :Integer   read GetQuantidade;
end;

implementation

uses
  SysUtils,
  Repositorio,
  FabricaRepositorio;

{ TQuantidadeItemAvulso }

constructor TQuantidadeItemAvulso.Create(BuscadorCodigoItemAvulso :TMetodoDelegadoObtemCampoInteger;
                                         Tamanho                   :TTamanho;
                                         Quantidade                :Integer);
begin
   self.FBuscadorCodigoItemAvulso := BuscadorCodigoItemAvulso;
   self.FCodigoTamanho            := Tamanho.Codigo;
   self.FTamanho                  := nil;
   self.FQuantidade               := Quantidade;  
end;

constructor TQuantidadeItemAvulso.CriarParaRepositorio(Codigo,
  CodigoItemAvulso, CodigoTamanho, Quantidade: Integer);
begin
   self.FCodigo               := Codigo;
   self.FCodigoItemItemAvulso := CodigoItemAvulso;
   self.FCodigoTamanho        := CodigoTamanho;
   self.FQuantidade           := Quantidade;
   self.FTamanho              := nil;
end;

destructor TQuantidadeItemAvulso.Destroy;
begin
   FreeAndNil(self.FTamanho);

  inherited;
end;

function TQuantidadeItemAvulso.GetCodigo: Integer;
begin
   result := self.FCodigo;
end;

function TQuantidadeItemAvulso.GetCodigoItemAvulso: Integer;
begin
   if (self.FCodigoItemItemAvulso <= 0) then begin
     self.FCodigoItemItemAvulso := self.FBuscadorCodigoItemAvulso;
   end;

   result := self.FCodigoItemItemAvulso;
end;

function TQuantidadeItemAvulso.GetQuantidade: Integer;
begin
   result := self.FQuantidade;
end;

function TQuantidadeItemAvulso.GetTamanho: TTamanho;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FTamanho) then begin
     Repositorio := nil;

     try
        Repositorio   := TFabricaRepositorio.GetRepositorio(TTamanho.ClassName);
        self.FTamanho := (Repositorio.Get(self.FCodigoTamanho) as TTamanho);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FTamanho;
end;

end.
