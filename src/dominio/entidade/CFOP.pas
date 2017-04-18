unit CFOP;

interface

uses SysUtils, Contnrs, TipoNaturezaOperacao;

type
  TCFOP = class

  private
    Fcodigo :Integer;
    Fdescricao :String;
    Fcfop :String;
    FSuspensao_icms: String;

    function GetTipoNaturezaOperacao: TTipoNaturezaOperacao;
  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property descricao             :String read Fdescricao             write Fdescricao;
    property cfop                  :String read Fcfop                  write Fcfop;
    property suspensao_icms        :String read FSuspensao_icms        write FSuspensao_icms;

    property tipo :TTipoNaturezaOperacao read GetTipoNaturezaOperacao;
end;

implementation

function TCFOP.GetTipoNaturezaOperacao: TTipoNaturezaOperacao;
var
   PrimeiroDigito :Char;
begin
   PrimeiroDigito := self.FCFOP[1];

   case PrimeiroDigito of
     '1': result := tnoEntradaDentroEstado;
     '2': result := tnoEntradaForaEstado;
     '3': result := tnoImportacao;
     '5': result := tnoSaidaDentroEstado;
     '6': result := tnoSaidaForaEstado;
     '7': result := tnoExportacao;
   end;

end;

{ TCFOP }

end.
