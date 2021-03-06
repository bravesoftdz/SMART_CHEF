unit Estoque;

interface

uses SysUtils, Contnrs;

type
  TEstoque = class

  private
    Fcodigo          :Integer;
    Fcodigo_produto  :Integer;
    Fcodigo_dispensa :Integer;
    Fquantidade      :Real;
    Funidade_medida  :String;
    Fpecas           :Integer;
    Fquantidade_min  :REal;
    
  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_produto        :Integer read Fcodigo_produto        write Fcodigo_produto;
    property codigo_dispensa       :Integer read Fcodigo_dispensa       write Fcodigo_dispensa;
    property quantidade            :Real    read Fquantidade            write Fquantidade;
    property unidade_medida        :String  read Funidade_medida        write Funidade_medida;
    property pecas                 :Integer read Fpecas                 write Fpecas;
    property quantidade_min        :Real    read Fquantidade_min        write Fquantidade_min;
end;

implementation

{ TEstoque }

end.
