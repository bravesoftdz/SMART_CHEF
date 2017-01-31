unit CFOPCorrespondente;

interface

uses
  SysUtils,
  Contnrs;

type
  TCFOPCorrespondente = class

  private
    Fcod_CFOP_Saida: integer;
    Fcod_CFOP_Entrada: integer;
    Fcodigo: integer;
    Fcfop_saida: String;
    Fcfop_entrada: String;
    procedure Setcod_CFOP_Entrada(const Value: integer);
    procedure Setcod_CFOP_Saida(const Value: integer);
    procedure Setcodigo(const Value: integer);
    procedure Setcfop_entrada(const Value: String);
    procedure Setcfop_saida(const Value: String);

  public
    property codigo           :integer read Fcodigo write Setcodigo;
    property cod_CFOP_Saida   :integer read Fcod_CFOP_Saida write Setcod_CFOP_Saida;
    property cfop_saida       :String read Fcfop_saida write Setcfop_saida;
    property cod_CFOP_Entrada :integer read Fcod_CFOP_Entrada write Setcod_CFOP_Entrada;
    property cfop_entrada     :String read Fcfop_entrada write Setcfop_entrada;
end;

implementation

{ TCFOPCorrespondente }

procedure TCFOPCorrespondente.Setcod_CFOP_Entrada(const Value: integer);
begin
  Fcod_CFOP_Entrada := Value;
end;

procedure TCFOPCorrespondente.Setcod_CFOP_Saida(const Value: integer);
begin
  Fcod_CFOP_Saida := Value;
end;

procedure TCFOPCorrespondente.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TCFOPCorrespondente.Setcfop_entrada(const Value: String);
begin
  Fcfop_entrada := Value;
end;

procedure TCFOPCorrespondente.Setcfop_saida(const Value: String);
begin
  Fcfop_saida := Value;
end;

end.
