unit RepositorioNFCe;

interface

uses DB, Auditoria, Repositorio, Classes;

type
  TRepositorioNFCe = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses SysUtils, NFCe;

{ TRepositorioNFCe }

function TRepositorioNFCe.Get(Dataset: TDataSet): TObject;
var
  XMLBlob   :TBlobField;
  XMLStream :TMemoryStream;
  NFCe :TNFCe;
begin
   NFCe:= TNFCe.Create;
   NFCe.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   NFCe.nr_nota        := self.FQuery.FieldByName('nr_nota').AsInteger;
   NFCe.codigo_pedido  := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   NFCe.serie          := self.FQuery.FieldByName('serie').AsString;
   NFCe.chave          := self.FQuery.FieldByName('chave').AsString;
   NFCe.protocolo      := self.FQuery.FieldByName('protocolo').AsString;
   NFCe.dh_recebimento := self.FQuery.FieldByName('dh_recebimento').AsDateTime;
   NFCe.status         := self.FQuery.FieldByName('status').AsString;
   NFCe.motivo         := self.FQuery.FieldByName('motivo').AsString;
   NFCe.justificativa  := self.FQuery.FieldByName('justificativa').AsString;

   result := NFCe;
   
   if not self.FQuery.FieldByName('xml').IsNull then begin
     XMLStream := nil;
     try
       XMLBlob   := TBlobField(Dataset.FieldByName('XML'));
       XMLStream := TMemoryStream.Create;
       XMLBlob.SaveToStream(XMLStream);
       TNFCe(result).AdicionarXML(XMLStream);
     finally
       FreeAndNil(XMLStream);
     end;
   end;
end;

function TRepositorioNFCe.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TNFCe(Objeto).Codigo;
end;

function TRepositorioNFCe.GetNomeDaTabela: String;
begin
  result := 'NFCE';
end;

function TRepositorioNFCe.GetRepositorio: TRepositorio;
begin
  result := TRepositorioNFCe.Create;
end;

function TRepositorioNFCe.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TNFCe(Objeto).Codigo <= 0);
end;

procedure TRepositorioNFCe.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  NFCeAntigo :TNFCe;
  NFCeNovo :TNFCe;
begin
   NFCeAntigo := (AntigoObjeto as TNFCe);
   NFCeNovo   := (Objeto       as TNFCe);

   if (NFCeAntigo.nr_nota <> NFCeNovo.nr_nota) then
     Auditoria.AdicionaCampoAlterado('nr_nota', IntToStr(NFCeAntigo.nr_nota), IntToStr(NFCeNovo.nr_nota));

   if (NFCeAntigo.codigo_pedido <> NFCeNovo.codigo_pedido) then
     Auditoria.AdicionaCampoAlterado('codigo_pedido', IntToStr(NFCeAntigo.codigo_pedido), IntToStr(NFCeNovo.codigo_pedido));

   if (NFCeAntigo.serie <> NFCeNovo.serie) then
     Auditoria.AdicionaCampoAlterado('serie', NFCeAntigo.serie, NFCeNovo.serie);

   if (NFCeAntigo.chave <> NFCeNovo.chave) then
     Auditoria.AdicionaCampoAlterado('chave', NFCeAntigo.chave, NFCeNovo.chave);

   if (NFCeAntigo.protocolo <> NFCeNovo.protocolo) then
     Auditoria.AdicionaCampoAlterado('protocolo', NFCeAntigo.protocolo, NFCeNovo.protocolo);

   if (NFCeAntigo.dh_recebimento <> NFCeNovo.dh_recebimento) then
     Auditoria.AdicionaCampoAlterado('dh_recebimento', DateTimeToStr(NFCeAntigo.dh_recebimento), DateTimeToStr(NFCeNovo.dh_recebimento));

   if (NFCeAntigo.status <> NFCeNovo.status) then
     Auditoria.AdicionaCampoAlterado('status', NFCeAntigo.status, NFCeNovo.status);

   if (NFCeAntigo.motivo <> NFCeNovo.motivo) then
     Auditoria.AdicionaCampoAlterado('motivo', NFCeAntigo.motivo, NFCeNovo.motivo);

   if (NFCeAntigo.justificativa <> NFCeNovo.justificativa) then
     Auditoria.AdicionaCampoAlterado('justificativa', NFCeAntigo.justificativa, NFCeNovo.justificativa);

end;

procedure TRepositorioNFCe.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  NFCe :TNFCe;
begin
  NFCe := (Objeto as TNFCe);
  Auditoria.AdicionaCampoExcluido('codigo'        , IntToStr(NFCe.codigo));
  Auditoria.AdicionaCampoExcluido('nr_nota'       , IntToStr(NFCe.nr_nota));
  Auditoria.AdicionaCampoExcluido('codigo_pedido' , IntToStr(NFCe.codigo_pedido));
  Auditoria.AdicionaCampoExcluido('serie'         , NFCe.serie);
  Auditoria.AdicionaCampoExcluido('chave'         , NFCe.chave);
  Auditoria.AdicionaCampoExcluido('protocolo'     , NFCe.protocolo);
  Auditoria.AdicionaCampoExcluido('dh_recebimento', DateTimeToStr(NFCe.dh_recebimento));
  Auditoria.AdicionaCampoExcluido('status'        , NFCe.status);
  Auditoria.AdicionaCampoExcluido('motivo'        , NFCe.motivo);
  Auditoria.AdicionaCampoExcluido('justificativa' , NFCe.justificativa);
end;

procedure TRepositorioNFCe.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  NFCe :TNFCe;
begin
  NFCe := (Objeto as TNFCe);
  Auditoria.AdicionaCampoIncluido('codigo'        ,    IntToStr(NFCe.codigo));
  Auditoria.AdicionaCampoIncluido('nr_nota'       ,    IntToStr(NFCe.nr_nota));
  Auditoria.AdicionaCampoIncluido('codigo_pedido' ,    IntToStr(NFCe.codigo_pedido));
  Auditoria.AdicionaCampoIncluido('serie'         ,    NFCe.serie);
  Auditoria.AdicionaCampoIncluido('chave'         ,    NFCe.chave);
  Auditoria.AdicionaCampoIncluido('protocolo'     ,    NFCe.protocolo);
  Auditoria.AdicionaCampoIncluido('dh_recebimento',    DateTimeToStr(NFCe.dh_recebimento));
  Auditoria.AdicionaCampoIncluido('status'        ,    NFCe.status);
  Auditoria.AdicionaCampoIncluido('motivo'        ,    NFCe.motivo);
  Auditoria.AdicionaCampoIncluido('justificativa' ,    NFCe.justificativa);
end;

procedure TRepositorioNFCe.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TNFCe(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioNFCe.SetParametros(Objeto: TObject);
var
  NFCe :TNFCe;
begin
  NFCe := (Objeto as TNFCe);

  self.FQuery.ParamByName('codigo').AsInteger         := NFCe.codigo;
  self.FQuery.ParamByName('nr_nota').AsInteger        := NFCe.nr_nota;
  self.FQuery.ParamByName('codigo_pedido').AsInteger  := NFCe.codigo_pedido;
  self.FQuery.ParamByName('serie').AsString          := NFCe.serie;
  self.FQuery.ParamByName('chave').AsString          := NFCe.chave;
  self.FQuery.ParamByName('protocolo').AsString      := NFCe.protocolo;
  self.FQuery.ParamByName('dh_recebimento').AsDateTime := NFCe.dh_recebimento;
  self.FQuery.ParamByName('status').AsString         := NFCe.status;
  self.FQuery.ParamByName('motivo').AsString         := NFCe.motivo;
  self.FQuery.ParamByName('justificativa').AsString         := NFCe.justificativa;

  self.FQuery.ParamByName('xml').LoadFromStream(NFCe.XML, ftBlob);
end;

function TRepositorioNFCe.SQLGet: String;
begin
  result := 'select * from NFCE where codigo = :ncod';
end;

function TRepositorioNFCe.SQLGetAll: String;
begin
  result := 'select * from NFCE';
end;

function TRepositorioNFCe.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from NFCE where '+ campo +' = :ncampo';
end;

function TRepositorioNFCe.SQLRemover: String;
begin
  result := ' delete from NFCE where codigo = :codigo ';
end;

function TRepositorioNFCe.SQLSalvar: String;
begin
  result := 'update or insert into NFCE ( CODIGO ,NR_NOTA ,CODIGO_PEDIDO ,SERIE ,CHAVE ,PROTOCOLO ,DH_RECEBIMENTO ,XML ,STATUS ,MOTIVO, justificativa) '+
           '                     values ( :CODIGO , :NR_NOTA , :CODIGO_PEDIDO , :SERIE , :CHAVE , :PROTOCOLO , :DH_RECEBIMENTO , :XML , :STATUS , :MOTIVO, :justificativa) ';
end;

end.

