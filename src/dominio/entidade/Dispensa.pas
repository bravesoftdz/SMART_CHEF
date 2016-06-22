unit Dispensa;

interface

uses SysUtils, Contnrs;

type
  TDispensa = class

  private
    Fcodigo :Integer;
    Fdescricao_item :String;
    FPreco_custo :Real;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property descricao_item        :String  read Fdescricao_item        write Fdescricao_item;
    property preco_custo           :Real    read FPreco_custo           write FPreco_custo;
end;

implementation

{ TDispensa }

end.
