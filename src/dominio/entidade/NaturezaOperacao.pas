unit NaturezaOperacao;

interface

uses
  TipoNaturezaOperacao;

type
  TNaturezaOperacao = class

  private
    FCodigo    :Integer;
    FCFOP      :String;
    FDescricao :String;
    Fsuspensao_icms: String;
    procedure Setsuspensao_icms(const Value: String);

  private
    function GetTipoNaturezaOperacao: TTipoNaturezaOperacao;

  private
    procedure SetCFOP(const Value: String);
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);

  public
    property Codigo    :Integer read FCodigo    write SetCodigo;
    property Descricao :String  read FDescricao write SetDescricao;
    property CFOP      :String  read FCFOP      write SetCFOP;
    property suspensao_icms :String read Fsuspensao_icms write Setsuspensao_icms;
    
    property Tipo      :TTipoNaturezaOperacao read GetTipoNaturezaOperacao;
end;

implementation

uses SysUtils;

{ TNaturezaOperacao }

function TNaturezaOperacao.GetTipoNaturezaOperacao: TTipoNaturezaOperacao;
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

procedure TNaturezaOperacao.SetCFOP(const Value: String);
begin
  FCFOP := Trim(Value);
end;

procedure TNaturezaOperacao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TNaturezaOperacao.SetDescricao(const Value: String);
begin
  FDescricao := UpperCase(Trim(Value));
end;

procedure TNaturezaOperacao.Setsuspensao_icms(const Value: String);
begin
  Fsuspensao_icms := Value;
end;

end.
