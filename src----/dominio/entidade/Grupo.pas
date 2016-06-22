unit Grupo;

interface

uses
  SysUtils,
  Contnrs;

type
  TGrupo = class

  private
    Fcodigo: integer;
    Fdescricao: String;
    procedure Setcodigo(const Value: integer);
    procedure Setdescricao(const Value: String);

  public
    property codigo    :integer read Fcodigo write Setcodigo;
    property descricao :String read Fdescricao write Setdescricao;
end;

implementation

{ TGrupo }

procedure TGrupo.Setcodigo(const Value: integer);
begin
  Fcodigo := Value;
end;

procedure TGrupo.Setdescricao(const Value: String);
begin
  Fdescricao := Value;
end;

end.
 