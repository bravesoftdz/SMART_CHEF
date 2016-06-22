unit CampoIncluidoAuditoria;

interface

uses
  Auditoria;

type
  TCampoIncluidoAuditoria = class

  private
    FCodigo           :Integer;
    FNomeCampo        :String;
    FValorCampo       :String;
    FCodigoAuditoria  :Integer;
    FAuditoria        :TAuditoria;

    procedure SetCodigo         (const Value: Integer);
    procedure SetNomeCampo      (const Value: String);
    procedure SetValorCampo     (const Value: String);
    procedure SetAuditoria      (const Value: TAuditoria);
    procedure SetCodigoAuditoria(const Value: Integer);

  public
    property Codigo          :Integer     read FCodigo          write SetCodigo;
    property NomeCampo       :String      read FNomeCampo       write SetNomeCampo;
    property ValorCampo      :String      read FValorCampo      write SetValorCampo;
    property Auditoria       :TAuditoria  read FAuditoria       write SetAuditoria;
    property CodigoAuditoria :Integer     read FCodigoAuditoria write SetCodigoAuditoria;
end;

implementation

{ TCampoIncluidoAuditoria }

procedure TCampoIncluidoAuditoria.SetAuditoria(const Value: TAuditoria);
begin
  FAuditoria := Value;
end;

procedure TCampoIncluidoAuditoria.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TCampoIncluidoAuditoria.SetCodigoAuditoria(const Value: Integer);
begin
  FCodigoAuditoria := Value;
end;

procedure TCampoIncluidoAuditoria.SetNomeCampo(const Value: String);
begin
  FNomeCampo := Value;
end;

procedure TCampoIncluidoAuditoria.SetValorCampo(const Value: String);
begin
  FValorCampo := Value;
end;

end.
