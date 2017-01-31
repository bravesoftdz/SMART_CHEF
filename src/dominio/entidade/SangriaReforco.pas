unit SangriaReforco;

interface

uses SysUtils, Contnrs;

type
  TSangriaReforco = class

  private
    Fcodigo                :Integer;
    Fcodigo_caixa          :Integer;
    Fcodigo_usuario        :Integer;
    Ftipo                  :String;
    Fvalor                 :Real;
    Fdescricao             :String;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_caixa          :Integer read Fcodigo_caixa          write Fcodigo_caixa;
    property codigo_usuario        :Integer read Fcodigo_usuario        write Fcodigo_usuario;
    property tipo                  :String  read Ftipo                  write Ftipo;
    property valor                 :Real    read Fvalor                 write Fvalor;
    property descricao             :String  read Fdescricao             write Fdescricao;
end;

implementation

{ TSangriaReforco }

end.
