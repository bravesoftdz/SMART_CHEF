unit ItemDeletado;

interface

uses SysUtils, Contnrs;

type
  TItemDeletado = class

  private
    Fcodigo         :Integer;
    Fcodigo_pedido  :Integer;
    Fcodigo_usuario :Integer;
    Fcodigo_produto :Integer;
    FQuantidade     :Real;
    Fhora_exclusao  :TDateTime;
    Fjustificativa  :String;

  public
    property codigo                :Integer   read Fcodigo                write Fcodigo;
    property codigo_pedido         :Integer   read Fcodigo_pedido         write Fcodigo_pedido;
    property codigo_usuario        :Integer   read Fcodigo_usuario        write Fcodigo_usuario;
    property codigo_produto        :Integer   read Fcodigo_produto        write Fcodigo_produto;
    property quantidade            :Real      read Fquantidade            write Fquantidade;    
    property hora_exclusao         :TDateTime read Fhora_exclusao         write Fhora_exclusao;
    property justificativa         :String    read Fjustificativa         write Fjustificativa;
end;

implementation

{ TItemDeletado }

end.
