unit VolumesNotaFiscal;

interface

//uses
//  MetodoDelegadoObtemCampoInteger;

type
  TVolumesNotaFiscal = class

  private
    FCodigoNotaFiscal         :Integer;
    FEspecie                  :String;
    FQuantidadeVolumes        :Integer;
    FPesoLiquido              :Real;
    FPesoBruto                :Real;

  private
    procedure SetEspecie          (const Especie :String           );
    procedure SetQuantidadeVolumes(const QuantidadeVolumes :Integer);
    procedure SetPesoLiquido      (const PesoLiquido :Real         );
    procedure SetPesoBruto        (const PesoBruto :Real           );

  private
    function GetCodigoNotaFiscal: Integer;

  private
    procedure ValidarQuantidadeVolumes(QuantidadeVolume :Integer);
    procedure ValidarPesoLiquido(PesoLiquido :Real);
    procedure ValidarPesoBruto(PesoBruto :Real);

  public
    constructor Create(Especie :String; QuantidadeVolumes :Integer; PesoLiquido, PesoBruto :Real);

  public

    procedure SomarQuantidadeAoTotal (QuantidadeParaSomar   :Integer);
    procedure SomarPesoLiquidoAoTotal(PesoLiquidoParaSomar :Real);
    procedure SomarPesoBrutoAoTotal  (PesoBrutoParaSomar     :Real);

    procedure SubtrairQuantidadeDoTotal (QuantidadeParaSubtrair  :Integer);
    procedure SubtrairPesoLiquidoDoTotal(PesoLiquidoParaSubtrair :Real);
    procedure SubtrairPesoBrutoDoTotal  (PesoBrutoParaSubtrair   :Real);

  public
    property CodigoNotaFiscal  :Integer   read FCodigoNotaFiscal    write FCodigoNotaFiscal;
    property Especie           :String    read FEspecie             write SetEspecie;
    property QuantidadeVolumes :Integer   read FQuantidadeVolumes   write SetQuantidadeVolumes;
    property PesoLiquido       :Real      read FPesoLiquido         write SetPesoLiquido;
    property PesoBruto         :Real      read FPesoBruto           write SetPesoBruto;
end;

implementation

uses
  ExcecaoParametroInvalido, SysUtils;

{ TVolumesNotaFiscal }

{procedure TVolumesNotaFiscal.AdicionarBuscadorDeCodigoNotaFiscal(
  Buscador: TMetodoDelegadoObtemCampoInteger);
begin
   self.FBuscadorCodigoNotaFiscal := Buscador;
end;                }

procedure TVolumesNotaFiscal.SetEspecie(const Especie: String);
begin
   {if (cEsp = '') then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'SetEspecie(Especie: String)', 'Especie');}
    
   self.FEspecie := UpperCase(Trim(Especie));
end;

procedure TVolumesNotaFiscal.SetPesoBruto(const PesoBruto: Real);
begin
   self.ValidarPesoBruto(PesoBruto);
   
   self.FPesoBruto := PesoBruto;
end;

procedure TVolumesNotaFiscal.SetPesoLiquido(const PesoLiquido: Real);
begin
   self.ValidarPesoLiquido(PesoLiquido);
   
   self.FPesoLiquido := PesoLiquido;
end;

procedure TVolumesNotaFiscal.SetQuantidadeVolumes(const QuantidadeVolumes: Integer);
begin
   self.ValidarQuantidadeVolumes(QuantidadeVolumes);   
   self.FQuantidadeVolumes := QuantidadeVolumes;
end;

constructor TVolumesNotaFiscal.Create(Especie: String;
  QuantidadeVolumes: Integer; PesoLiquido, PesoBruto: Real);
begin
   self.SetEspecie(Especie);
   self.SetQuantidadeVolumes(QuantidadeVolumes);
   self.SetPesoLiquido(PesoLiquido);
   self.SetPesoBruto(PesoBruto);
end;

function TVolumesNotaFiscal.GetCodigoNotaFiscal: Integer;
begin
   try
     // result := self.FBuscadorCodigoNotaFiscal;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TVolumesNotaFiscal.GetCodigoNotaFiscal: Integer'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscadorCodigoNotaFiscal!');
   end;
end;

procedure TVolumesNotaFiscal.SomarPesoBrutoAoTotal(
  PesoBrutoParaSomar: Real);
begin
   self.ValidarPesoBruto(PesoBruto);

   self.FPesoBruto := (self.FPesoBruto + PesoBrutoParaSomar);
end;

procedure TVolumesNotaFiscal.SomarPesoLiquidoAoTotal(
  PesoLiquidoParaSomar: Real);
begin
   self.ValidarPesoLiquido(PesoLiquidoParaSomar);

   self.FPesoLiquido := (self.FPesoLiquido + PesoLiquidoParaSomar);
end;

procedure TVolumesNotaFiscal.SomarQuantidadeAoTotal(
  QuantidadeParaSomar: Integer);
begin
   self.ValidarQuantidadeVolumes(QuantidadeVolumes);

   self.FQuantidadeVolumes := (self.FQuantidadeVolumes + QuantidadeParaSomar);
end;

procedure TVolumesNotaFiscal.SubtrairPesoBrutoDoTotal(PesoBrutoParaSubtrair: Real);
begin
   self.ValidarPesoBruto(PesoBrutoParaSubtrair);
   self.FPesoBruto := (self.FPesoBruto - PesoBrutoParaSubtrair);

   if (self.FPesoBruto < 0) then
    self.FPesoBruto := 0;
end;

procedure TVolumesNotaFiscal.SubtrairPesoLiquidoDoTotal(PesoLiquidoParaSubtrair: Real);
begin
   self.ValidarPesoLiquido(PesoLiquidoParaSubtrair);
   self.FPesoLiquido := (self.FPesoLiquido - PesoLiquidoParaSubtrair);

   if (self.FPesoLiquido < 0) then
    self.FPesoLiquido := 0;
end;

procedure TVolumesNotaFiscal.SubtrairQuantidadeDoTotal(QuantidadeParaSubtrair: Integer);
begin
   self.ValidarQuantidadeVolumes(QuantidadeParaSubtrair);
   self.FQuantidadeVolumes := (self.FQuantidadeVolumes - QuantidadeParaSubtrair);

   if (self.FQuantidadeVolumes < 0) then
    self.FQuantidadeVolumes := 0;
end;

procedure TVolumesNotaFiscal.ValidarPesoBruto(PesoBruto: Real);
begin
   if (PesoBruto < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                           'ValidarPesoBruto(PesoBruto: Real)',
                                           'PesoBruto');
end;

procedure TVolumesNotaFiscal.ValidarPesoLiquido(PesoLiquido: Real);
begin
   if (PesoLiquido < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                           'ValidarPesoLiquido(PesoLiquido: Real)',
                                           'PesoLiquido');
end;

procedure TVolumesNotaFiscal.ValidarQuantidadeVolumes(
  QuantidadeVolume: Integer);
begin
   if (QuantidadeVolume < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName,
                                           'ValidarQuandidadeVolumes(QuantidadeVolume: Integer)',
                                           'QuantidadeVolume');
end;

end.
