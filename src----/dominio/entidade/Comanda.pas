unit Comanda;

interface

uses
  SysUtils,
  Contnrs;

type
  TComanda = class

  private
    Fnumero_comanda: integer;
    Fcodigo :integer;
    FAtiva  :Boolean;
    FMotivo :String;

  public
    property codigo         :integer read Fcodigo         write Fcodigo;
    property numero_comanda :integer read Fnumero_comanda write Fnumero_comanda;
    property ativa          :boolean read FAtiva          write FAtiva;
    property motivo         :String  read FMotivo         write FMotivo;
end;

implementation

{ TComanda }

end.
