unit CampoAlteracaoAuditoria;

interface

uses
  Auditoria;

type
  TCampoAlteracaoAuditoria = class

  private
    FCodigoAuditoria  :Integer;
    FCodigo           :Integer;
    FValorCampoNovo   :String;
    FValorCampoAntigo :String;
    FAuditoria        :TAuditoria;
    FNomeCampo        :String;

  private
    procedure SetAuditoria       (const Value: TAuditoria);
    procedure SetNomeCampo       (const Value: String);
    procedure SetCodigo          (const Value: Integer);
    procedure SetCodigoAuditoria (const Value: Integer);
    procedure SetValorCampoAntigo(const Value: String);
    procedure SetValorCampoNovo  (const Value: String);

  public
    property Codigo            :Integer    read FCodigo           write SetCodigo;
    property NomeCampo         :String     read FNomeCampo        write SetNomeCampo;
    property ValorCampoNovo    :String     read FValorCampoNovo   write SetValorCampoNovo;
    property ValorCampoAntigo  :String     read FValorCampoAntigo write SetValorCampoAntigo;
    property Auditoria         :TAuditoria read FAuditoria        write SetAuditoria;
    property CodigoAuditoria   :Integer    read FCodigoAuditoria  write SetCodigoAuditoria;
end;

implementation

{ TCampoAlteracaoAuditoria }

procedure TCampoAlteracaoAuditoria.SetAuditoria(const Value: TAuditoria);
begin
  FAuditoria := Value;

  if Assigned(self.FAuditoria) then
    self.FCodigoAuditoria := self.FAuditoria.Codigo;
end;

procedure TCampoAlteracaoAuditoria.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCampoAlteracaoAuditoria.SetCodigoAuditoria(
  const Value: Integer);
begin
  FCodigoAuditoria := Value;
end;

procedure TCampoAlteracaoAuditoria.SetNomeCampo(const Value: String);
begin
  FNomeCampo := Value;
end;

procedure TCampoAlteracaoAuditoria.SetValorCampoAntigo(
  const Value: String);
begin
  FValorCampoAntigo := Value;
end;

procedure TCampoAlteracaoAuditoria.SetValorCampoNovo(const Value: String);
begin
  FValorCampoNovo := Value;
end;

end.
