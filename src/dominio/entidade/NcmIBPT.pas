unit NcmIBPT;

interface

uses SysUtils, Contnrs;

type
  TNcmIBPT = class

  private
    Fcodigo :Integer;
    Fncm_ibpt :String;
    Fex_ibpt :String;
    Ftabela_ibpt :String;
    Faliqnacional_ibpt :Real;
    Faliqinternacional_ibpt :Real;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property ncm_ibpt              :String read Fncm_ibpt              write Fncm_ibpt;
    property ex_ibpt               :String read Fex_ibpt               write Fex_ibpt;
    property tabela_ibpt           :String read Ftabela_ibpt           write Ftabela_ibpt;
    property aliqnacional_ibpt     :Real read Faliqnacional_ibpt     write Faliqnacional_ibpt;
    property aliqinternacional_ibpt :Real read Faliqinternacional_ibpt write Faliqinternacional_ibpt;
end;

implementation

{ TNcmIBPT }

end.
