unit ConfiguracoesSistema;

interface

uses SysUtils, Contnrs;

type
  TConfiguracoesSistema = class

  private
    Fcodigo              :Integer;
    Fpossui_boliche      :Boolean;
    Fpossui_dispensadora :Boolean;
    Fduas_vias_pedido    :Boolean;
    Fpreco_produto_alteravel :Boolean;
    FUtiliza_comandas :Boolean;
    Fpossui_delivery: Boolean;
    Fduas_vias_departamento  :Boolean;
    Fimp_dep_espacada         :Boolean;

  public
    property codigo                  :Integer read Fcodigo                  write Fcodigo;
    property possui_boliche          :Boolean read Fpossui_boliche          write Fpossui_boliche;
    property possui_dispensadora     :Boolean read Fpossui_dispensadora     write Fpossui_dispensadora;
    property duas_vias_pedido        :Boolean read Fduas_vias_pedido        write Fduas_vias_pedido;
    property preco_produto_alteravel :Boolean read Fpreco_produto_alteravel write Fpreco_produto_alteravel;
    property Utiliza_comandas        :Boolean read FUtiliza_comandas        write Futiliza_comandas;
    property possui_delivery         :Boolean read Fpossui_delivery         write Fpossui_delivery;
    property imp_dep_espacada        :Boolean read Fimp_dep_espacada        write Fimp_dep_espacada;
end;

implementation

{ TConfiguracoesSistema }

end.
