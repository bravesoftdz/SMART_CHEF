unit LocalEntregaNotaFiscal;

interface

uses
  Classes;

type
   TLocalEntregaNotaFiscal = class

   private
    FAposAtualizarLocalEntrega :TNotifyEvent;
    FCodigoMunicipio           :Integer;
    FNomeMunicipio             :String;
    FBairro                    :String;
    FCnpjCpf                   :String;
    FNumero                    :String;
    FUF                        :String;
    FLogradouro                :String;
    FComplemento               :String;
    FCEP                       :String;
    FCodigoNotaFiscal          :integer;
    function GetCEPSemFormatacao: String;

   private
    procedure ExecutarAposAtualizarNotaFiscal;
    procedure SetBairro         (const Value: String);
    procedure SetCnpjCpf        (const Value: String);
    procedure SetCodigoMunicipio(const Value: Integer);
    procedure SetComplemento    (const Value: String);
    procedure SetLogradouro     (const Value: String);
    procedure SetNomeMunicipio  (const Value: String);
    procedure SetNumero         (const Value: String);
    procedure SetUF             (const Value: String);
    procedure SetCEP            (const Value: String);

   private
    function GetToString          :String;
    function GetBairro            :String;
    function GetLogradouro        :String;
    function GetBairroSemTrim     :String;
    function GetLogradouroSemTrim :String;
    function GetCEP               :String;

   public
     procedure ValidarCamposObrigatorios;

   public
     property CodigoNotaFiscal :Integer read FCodigoNotaFiscal  write FCodigoNotaFiscal;
     property CnpjCpf          :String  read FCnpjCpf         write SetCnpjCpf;
     property Logradouro       :String  read GetLogradouro    write SetLogradouro; 
     property Numero           :String  read FNumero          write SetNumero;
     property Complemento      :String  read FComplemento     write SetComplemento;
     property Bairro           :String  read GetBairro        write SetBairro;
     property CodigoMunicipio  :Integer read FCodigoMunicipio write SetCodigoMunicipio;
     property NomeMunicipio    :String  read FNomeMunicipio   write SetNomeMunicipio;
     property UF               :String  read FUF              write SetUF;
     property CEP              :String  read GetCEP           write SetCEP;

     property LogradouroSemTrim :String read GetLogradouroSemTrim;
     property BairroSemTrim     :String read GetBairroSemTrim;
     property CEPSemFormatacao  :String read GetCEPSemFormatacao;

     property ToString         :String  read  GetToString;
end;

implementation

uses
  SysUtils,
  StringUtilitario,
  ExcecaoCampoNaoInformado;

{ TLocalEntregaNotaFiscal }
          {
procedure TLocalEntregaNotaFiscal.AdicionarAposAtualizarLocalEntrega(
  Metodo: TNotifyEvent);
begin
   self.FAposAtualizarLocalEntrega := Metodo;
end;  }
          {
procedure TLocalEntregaNotaFiscal.AdicionarBuscadorNotaFiscal(
  Metodo: TMetodoDelegadoObtemCampoInteger);
begin
  self.FBuscadorCodigoNotaFiscal := Metodo;
end;     }

procedure TLocalEntregaNotaFiscal.ExecutarAposAtualizarNotaFiscal;
begin
   if Assigned(self.FAposAtualizarLocalEntrega) then
    self.FAposAtualizarLocalEntrega(self);    
end;

function TLocalEntregaNotaFiscal.GetBairro: String;
begin
   result := Trim(self.FBairro);
end;

function TLocalEntregaNotaFiscal.GetBairroSemTrim: String;
begin
   result := FBairro;
end;

function TLocalEntregaNotaFiscal.GetCEP: String;
begin
   result := TStringUtilitario.FormataCEP(FCEP);
end;

function TLocalEntregaNotaFiscal.GetCEPSemFormatacao: String;
begin
   result := TStringUtilitario.ApenasNumeros(self.FCEP);
end;

function TLocalEntregaNotaFiscal.GetLogradouro: String;
begin
   result := Trim(self.FLogradouro);
end;

function TLocalEntregaNotaFiscal.GetLogradouroSemTrim: String;
begin
   result := self.FLogradouro;
end;

function TLocalEntregaNotaFiscal.GetToString: String;
begin
   result := 'END. P/ ENTREGA: '+self.FLogradouro+', '+self.FNumero+'. '+self.FBairro+', '+self.FNomeMunicipio+' - '+self.FUF+'. '+
             'CEP: '+self.FCEP+'.'; 
end;

procedure TLocalEntregaNotaFiscal.SetBairro(const Value: String);
begin
  FBairro := UpperCase(Value);
  self.ExecutarAposAtualizarNotaFiscal;
end;

procedure TLocalEntregaNotaFiscal.SetCEP(const Value: String);
begin
  FCEP := Value;
  self.ExecutarAposAtualizarNotaFiscal;  
end;

procedure TLocalEntregaNotaFiscal.SetCnpjCpf(const Value: String);
begin
  FCnpjCpf := TStringUtilitario.ApenasNumeros(Value);
  self.ExecutarAposAtualizarNotaFiscal;
end;

procedure TLocalEntregaNotaFiscal.SetCodigoMunicipio(const Value: Integer);
begin
  FCodigoMunicipio := Value;
  self.ExecutarAposAtualizarNotaFiscal;  
end;

procedure TLocalEntregaNotaFiscal.SetComplemento(const Value: String);
begin
  FComplemento := UpperCase(Trim(Value));
  self.ExecutarAposAtualizarNotaFiscal;
end;

procedure TLocalEntregaNotaFiscal.SetLogradouro(const Value: String);
begin
  FLogradouro := UpperCase(Value);
  self.ExecutarAposAtualizarNotaFiscal;  
end;

procedure TLocalEntregaNotaFiscal.SetNomeMunicipio(const Value: String);
begin
  FNomeMunicipio := UpperCase(Trim(Value));
end;

procedure TLocalEntregaNotaFiscal.SetNumero(const Value: String);
begin
  FNumero := TStringUtilitario.ApenasNumeros(Value);
  self.ExecutarAposAtualizarNotaFiscal;    
end;

procedure TLocalEntregaNotaFiscal.SetUF(const Value: String);
begin
  FUF := UpperCase(Trim(Value));
end;

procedure TLocalEntregaNotaFiscal.ValidarCamposObrigatorios;
begin
   if (Length(self.FCnpjCpf) <> 14) then
    raise TExcecaoCampoNaoInformado.Create('CPF / CNPJ');

   if (self.FLogradouro = '') then
    raise TExcecaoCampoNaoInformado.Create('LOGRADOURO');

   if (self.FNumero = '') then
    raise TExcecaoCampoNaoInformado.Create('NÚMERO');

   if (self.FBairro = '') then
    raise TExcecaoCampoNaoInformado.Create('BAIRRO');

   if ((self.FCodigoMunicipio <= 0) or (self.FNomeMunicipio = '') or (self.FUF = '')) then
    raise TExcecaoCampoNaoInformado.Create('CIDADE');

   if (self.FComplemento = '') then
    raise TExcecaoCampoNaoInformado.Create('COMPLEMENTO');

   if (Length(TStringUtilitario.ApenasNumeros(self.FCEP)) <> 8) then
    raise TExcecaoCampoNaoInformado.Create('CEP');
end;

end.
