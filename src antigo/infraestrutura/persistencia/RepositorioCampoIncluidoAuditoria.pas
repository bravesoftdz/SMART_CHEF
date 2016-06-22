unit RepositorioCampoIncluidoAuditoria;

interface

uses
  Repositorio,
  RepositorioCampoAuditoria,
  DB;

type
  TRepositorioCampoIncluidoAuditoria = class(TRepositorioCampoAuditoria)


  protected
    function GetNomeDaTabela                     :String;            override;
    function GetRepositorio                      :TRepositorio;      override;
end;

{ TRepositorioCampoIncluidoAuditoria }

implementation

uses
  CampoAuditoria;

function TRepositorioCampoIncluidoAuditoria.GetNomeDaTabela: String;
begin
  result := 'INCLUSOES_AUDITORIA';
end;

function TRepositorioCampoIncluidoAuditoria.GetRepositorio: TRepositorio;
begin
   result := TRepositorioCampoIncluidoAuditoria.Create;
end;

end.
