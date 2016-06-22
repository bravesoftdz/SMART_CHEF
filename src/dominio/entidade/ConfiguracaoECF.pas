unit ConfiguracaoECF;

interface

uses SysUtils, Contnrs;

type
  TConfiguracaoECF = class

  private
    Fcodigo :Integer;
    Fmodelo :String;
    Fporta :String;
    Ftimeout :Integer;
    Fintervalo :Integer;
    Flinhas_buffer :Integer;
    Ftamanho_fonte :Integer;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property modelo                :String read Fmodelo                write Fmodelo;
    property porta                 :String read Fporta                 write Fporta;
    property timeout               :Integer read Ftimeout               write Ftimeout;
    property intervalo             :Integer read Fintervalo             write Fintervalo;
    property linhas_buffer         :Integer read Flinhas_buffer         write Flinhas_buffer;
    property tamanho_fonte         :Integer read Ftamanho_fonte         write Ftamanho_fonte;
end;

implementation

{ TConfiguracaoECF }

end.
