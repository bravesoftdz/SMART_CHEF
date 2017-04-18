unit SangriaReforco;

interface

uses SysUtils, Contnrs, Usuario;

type
  TSangriaReforco = class

  private
    Fcodigo          :Integer;
    Fcodigo_caixa    :Integer;
    Fcodigo_usuario  :Integer;
    Ftipo            :String;
    Fvalor           :Real;
    Fdescricao       :String;
    FTipo_moeda      :SmallInt;
    FUsuario         :TUsuario;

    function GetUsuario: TUsuario;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_caixa          :Integer read Fcodigo_caixa          write Fcodigo_caixa;
    property codigo_usuario        :Integer read Fcodigo_usuario        write Fcodigo_usuario;
    property tipo                  :String  read Ftipo                  write Ftipo;
    property valor                 :Real    read Fvalor                 write Fvalor;
    property descricao             :String  read Fdescricao             write Fdescricao;
    property tipo_moeda            :SmallInt read FTipo_moeda           write FTipo_moeda;

  public
    property Usuario :TUsuario read GetUsuario;
end;

implementation

uses repositorio, FabricaRepositorio;

{ TSangriaReforco }

function TSangriaReforco.GetUsuario: TUsuario;
var repositorio :TRepositorio;
begin

  if not assigned(FUsuario) then
  begin
    repositorio := nil;
    try
      repositorio := TFabricaRepositorio.GetRepositorio(TUsuario.ClassName);
      FUsuario    := TUsuario(repositorio.Get(self.codigo_usuario));
    finally
      FreeAndNil(repositorio);
    end;
  end;

  result := FUsuario;
end;

end.
