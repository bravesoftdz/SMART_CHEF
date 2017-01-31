unit TributacaoItemNotaFiscal;

interface

//uses
//  MetodoDelegadoObtemCampoReal,
//  MetodoDelegadoObtemCampoInteger;

type
  TTributacaoItemNotaFiscal = class

  private
    FBaseCalculo :Real;

//    FBuscadorCodigoItem  :TMetodoDelegadoObtemCampoInteger;
//    FBuscadorBaseCalculo :TMetodoDelegadoObtemCampoReal;
    procedure SetBaseCalculo(const Value: Real);

  private
    function GetCodigoItem  :Integer;
    function GetBaseCalculo :Real;

  public
    property CodigoItem   :Integer read GetCodigoItem;
    property BaseCalculo  :Real read GetBaseCalculo    write SetBaseCalculo;

  public
//    procedure SetMetodoDelegadoParaBuscarCodigoItem (Metodo :TMetodoDelegadoObtemCampoInteger);
//    procedure SetMetodoDelegadoParaBuscarBaseCalculo(Metodo :TMetodoDelegadoObtemCampoReal);
end;

implementation

uses
  SysUtils;

{ TTributacaoItemNotaFiscal }

function TTributacaoItemNotaFiscal.GetBaseCalculo: Real;
begin
   try
   //   result := self.FBuscadorBaseCalculo;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTributacaoItemNotaFiscal.GetBaseCalculo: Real;'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscadorBaseCalculo!');
   end;
end;

function TTributacaoItemNotaFiscal.GetCodigoItem: Integer;
begin
   try
   //   result := self.FBuscadorCodigoItem;
   except
     on E: EAccessViolation do
      raise EInvalidOp.Create('Erro em TTributacaoItemNotaFiscal.GetCodigoItem: Integer;'+#13+
                              'Não foi possível realizar a chamada do método self.FBuscadorCodigoItem!');
   end;
end;

procedure TTributacaoItemNotaFiscal.SetBaseCalculo(const Value: Real);
begin
  FBaseCalculo := Value;
end;
  {
procedure TTributacaoItemNotaFiscal.SetMetodoDelegadoParaBuscarBaseCalculo(
  Metodo: TMetodoDelegadoObtemCampoReal);
begin
   self.FBuscadorBaseCalculo := Metodo;
end;

procedure TTributacaoItemNotaFiscal.SetMetodoDelegadoParaBuscarCodigoItem(
  Metodo: TMetodoDelegadoObtemCampoInteger);
begin
     self.FBuscadorCodigoItem := Metodo;
end;
            }
end.
