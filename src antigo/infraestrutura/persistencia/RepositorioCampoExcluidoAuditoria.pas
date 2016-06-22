unit RepositorioCampoExcluidoAuditoria;

interface

uses
  Repositorio,
  RepositorioCampoAuditoria;

type
  TRepositorioCampoExcluidoAuditoria = class(TRepositorioCampoAuditoria)

  protected
    function GetNomeDaTabela                     :String;            override;
    function GetRepositorio                      :TRepositorio;       override;
end;

implementation

{ TRepositorioCampoExcluidoAuditoria }

function TRepositorioCampoExcluidoAuditoria.GetNomeDaTabela: String;
begin
   result := 'EXCLUSOES_AUDITORIA';
end;

function TRepositorioCampoExcluidoAuditoria.GetRepositorio: TRepositorio;
begin
   result := TRepositorioCampoExcluidoAuditoria.Create;
end;

end.
