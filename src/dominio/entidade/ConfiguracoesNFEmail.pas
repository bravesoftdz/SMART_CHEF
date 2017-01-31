unit ConfiguracoesNFEmail;

interface

uses SysUtils, Contnrs, Classes;

type
  TConfiguracoesNFEmail = class

  private
    Fcodigo_empresa :Integer;
    Fsmtp_host :String;
    Fsmtp_port :String;
    Fsmtp_user :String;
    Fsmtp_password :String;
    Fassunto :String;
    Fmensagem :String;
    Fusa_ssl :String;
    FMensagemList :TStrings;

    function getMensagem :TStrings;

  public
    constructor Create(codigoEmpresa :integer;
                       SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String);
    constructor CriaParaRepositorio(CodigoEmpresa :Integer; SMTPHost, SMTPPort, SMTPUser,
                                    SMTPPassword, Assunto, Mensagem: String);
    destructor destroy;override;

  public
    property codigo_empresa        :Integer read Fcodigo_empresa        write Fcodigo_empresa;
    property smtp_host             :String read Fsmtp_host             write Fsmtp_host;
    property smtp_port             :String read Fsmtp_port             write Fsmtp_port;
    property smtp_user             :String read Fsmtp_user             write Fsmtp_user;
    property smtp_password         :String read Fsmtp_password         write Fsmtp_password;
    property assunto               :String read Fassunto               write Fassunto;
    property mensagem              :TStrings read GetMensagem;
    property usa_ssl               :String read Fusa_ssl               write Fusa_ssl;
end;

implementation

{ TConfiguracoesNFEmail }

constructor TConfiguracoesNFEmail.Create(codigoEmpresa :integer;
  SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String);
begin
   self.Fcodigo_empresa             := codigoEmpresa;
   self.Fsmtp_host                       := SMTPHost;
   self.Fsmtp_port                       := SMTPPort;
   self.Fsmtp_user                       := SMTPUser;
   self.Fsmtp_password                   := SMTPPassword;
   self.FAssunto                    := Assunto;
   self.FMensagem                   := Mensagem;
   self.FMensagemList               := nil;
end;

constructor TConfiguracoesNFEmail.CriaParaRepositorio(CodigoEmpresa :Integer; SMTPHost, SMTPPort, SMTPUser,
  SMTPPassword, Assunto, Mensagem: String);
begin
   self.Fcodigo_empresa              := CodigoEmpresa;
   self.Fsmtp_host                   := SMTPHost;
   self.Fsmtp_port                   := SMTPPort;
   self.Fsmtp_user                   := SMTPUser;
   self.Fsmtp_password               := SMTPPassword;
   self.FAssunto                     := Assunto;
   self.FMensagem                    := Mensagem;
   self.FMensagemList                := nil;
end;

destructor TConfiguracoesNFEmail.destroy;
begin
  FreeAndNil(self.FMensagemList);
  inherited;
end;

function TConfiguracoesNFEmail.getMensagem: TStrings;
begin
   if not Assigned(self.FMensagemList) then begin
      self.FMensagemList := TStringList.Create;
      self.FMensagemList.Clear;
      self.FMensagemList.Add(self.FMensagem);
   end;

   result := self.FMensagemList;
end;

end.
