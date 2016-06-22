unit MateriaPrima;

interface

uses
  SysUtils,
  Contnrs;

type
  TMateriaPrima = class

  private
    Fcodigo: integer;
    Fvalor: Real;
    Fdescricao: String;
    procedure Setcodigo(const Value: integer);
    procedure Setdescricao(const Value: String);
    procedure Setvalor(const Value: Real);

  public
    property codigo    :integer read Fcodigo    write Setcodigo;
    property descricao :String  read Fdescricao write Setdescricao;
    property valor     :Real    read Fvalor     write Setvalor;
    
end;

implementation

{ TMateriaPrima }

procedure TMateriaPrima.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TMateriaPrima.Setdescricao(const Value: String);
begin
  Fdescricao := Value;
end;

procedure TMateriaPrima.Setvalor(const Value: Real);
begin
  Fvalor := Value;
end;

end.
