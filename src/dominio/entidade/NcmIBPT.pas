unit NcmIBPT;

interface

uses SysUtils, Contnrs, NaturezaOperacao;

type
  TNcmIBPT = class

  private
    Fcodigo :Integer;
    Fncm_ibpt :String;
    Fex_ibpt :String;
    Ftabela_ibpt :String;
    Faliqnacional_ibpt :Real;
    Faliqinternacional_ibpt :Real;
    Fcst :String;
    Fcfop :TNaturezaOperacao;
    FCodigo_cfop: integer;
    FCodigo_cfop_fora: integer;
    function getCFOP: TNaturezaOperacao;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property ncm_ibpt              :String read Fncm_ibpt              write Fncm_ibpt;
    property ex_ibpt               :String read Fex_ibpt               write Fex_ibpt;
    property tabela_ibpt           :String read Ftabela_ibpt           write Ftabela_ibpt;
    property aliqnacional_ibpt     :Real read Faliqnacional_ibpt     write Faliqnacional_ibpt;
    property aliqinternacional_ibpt :Real read Faliqinternacional_ibpt write Faliqinternacional_ibpt;
    property cst                   :String read Fcst                   write Fcst;
    property codigo_cfop           :integer read FCodigo_cfop          write FCodigo_cfop;
    property codigo_cfop_fora      :integer read FCodigo_cfop_fora     write FCodigo_cfop_fora;

    property cfop                  :TNaturezaOperacao read getCFOP;
end;

implementation

{ TNcmIBPT }

uses repositorio, fabricaRepositorio;

function TNcmIBPT.getCFOP: TNaturezaOperacao;
var repositorio :TRepositorio;
begin
  try
    if (self.codigo_cfop > 0) and not assigned(Fcfop) then
    begin
      repositorio  := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
      FCFOP        := TNaturezaOperacao(repositorio.Get(codigo_cfop));
    end;

    result := FCFOP;
  finally
    FreeAndNil(repositorio);
  end;
end;

end.

