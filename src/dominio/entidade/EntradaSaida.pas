unit EntradaSaida;

interface

uses SysUtils, Contnrs;

type
  TEntradaSaida = class

  private
    Fcodigo :Integer;
    Fnum_documento :Integer;
    Fdata :TDateTime;
    Fentrada_saida :String;
    Ftipo :String;
    Fobservacao :String;
    Fcodigo_item :Integer;
    Fquantidade :Real;
    Fcodigo_usuario :Integer;
    FPreco_custo :Real;
    FCodigo_fornecedor: integer;
    FValor_total: Real;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property num_documento         :Integer read Fnum_documento         write Fnum_documento;
    property data                  :TDateTime read Fdata                  write Fdata;
    property entrada_saida         :String read Fentrada_saida         write Fentrada_saida;
    property tipo                  :String read Ftipo                  write Ftipo;
    property observacao            :String read Fobservacao            write Fobservacao;
    property codigo_item           :Integer read Fcodigo_item           write Fcodigo_item;
    property quantidade            :Real read Fquantidade            write Fquantidade;
    property codigo_usuario        :Integer read Fcodigo_usuario        write Fcodigo_usuario;
    property preco_custo           :Real    read Fpreco_custo          write Fpreco_custo;
    property codigo_fornecedor     :integer read FCodigo_fornecedor   write FCodigo_fornecedor;
    property valor_total           :Real    read FValor_total          write FValor_total;
end;

implementation

{ TEntradaSaida }

end.
