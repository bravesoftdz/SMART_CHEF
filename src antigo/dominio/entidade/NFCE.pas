unit NFCe;

interface

uses SysUtils, Contnrs, Classes;

type
  TNFCe = class

  private
    Fcodigo :Integer;
    Fnr_nota :Integer;
    Fcodigo_pedido :Integer;
    Fserie :String;
    Fchave :String;
    Fprotocolo :String;
    Fdh_recebimento :TDateTime;
    FXML            :TMemoryStream;
    Fstatus :String;
    Fmotivo :String;
    Fjustificativa :String;

  public
    property codigo          :Integer read Fcodigo                write Fcodigo;
    property nr_nota         :Integer read Fnr_nota               write Fnr_nota;
    property codigo_pedido   :Integer read Fcodigo_pedido         write Fcodigo_pedido;
    property serie           :String read Fserie                 write Fserie;
    property chave           :String read Fchave                 write Fchave;
    property protocolo       :String read Fprotocolo             write Fprotocolo;
    property dh_recebimento  :TDateTime read Fdh_recebimento        write Fdh_recebimento;
    property XML             :TMemoryStream   read Fxml                   write Fxml;
    property status          :String read Fstatus                write Fstatus;
    property motivo          :String read Fmotivo                write Fmotivo;
    property justificativa   :String read Fjustificativa         write Fjustificativa;

  public
    procedure AdicionarXML    (XMLStream :TMemoryStream);

  public
    constructor create;
    destructor  destroy;    
end;

implementation

{ TNFCe }

{ TNFCe }

procedure TNFCe.AdicionarXML(XMLStream: TMemoryStream);
begin
   FreeAndNil(self.FXML);

   self.FXML := TMemoryStream.Create;
   self.FXML.LoadFromStream(XMLStream);
end;

constructor TNFCe.create;
begin
  self.FXML := TMemoryStream.Create;
end;

destructor TNFCe.destroy;
begin
  FreeAndNil(FXML);
  inherited;
end;

end.
