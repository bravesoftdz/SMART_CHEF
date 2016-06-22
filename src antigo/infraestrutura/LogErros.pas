unit LogErros;

interface

uses
  Classes;

type
  TLogErros = class

  private
    FDiretorioSistema :String;
    FArquivo          :TStrings;

  private
    function GetNomeArquivo: String;

  private
    procedure AdicionaSeparador;
    procedure AdicionaQuebraDeLinha;

  public
    constructor Create(DiretorioSistema :String);
    destructor  Destroy; override;

  public
    procedure AdicionaErro(NomeDaUnit :String; ClasseDaExcecao :String; MensagemErro :String);

  public
    property NomeArquivo :String read GetNomeArquivo;
end;

implementation

uses
  SysUtils,
  StrUtils;

const
  CAMINHO_ARQUIVO = 'log_erros.txt';

{ TLogErros }

procedure TLogErros.AdicionaErro(NomeDaUnit :String; ClasseDaExcecao :String; MensagemErro :String);
begin
   self.AdicionaQuebraDeLinha;
   self.AdicionaSeparador;
   self.FArquivo.Insert(0, 'Mensagem de erro: ' + MensagemErro);
   self.FArquivo.Insert(0, 'Data: ' + FormatDateTime('dd/mm/yyyy', Now) + ' - Hora: '+FormatDateTime('hh:mm:ss', Now));
   self.FArquivo.Insert(0, 'Lançada exceção2 ' + ClasseDaExcecao + ' na unit ' + NomeDaUnit);
   self.AdicionaSeparador;

   self.FArquivo.SaveToFile(self.NomeArquivo);
end;

procedure TLogErros.AdicionaQuebraDeLinha;
begin
   self.FArquivo.Insert(0, '');
end;

procedure TLogErros.AdicionaSeparador;
var
  Separador :String;
begin
   Separador := StringOfChar('=', 150);
   self.FArquivo.Insert(0, Separador);
end;

constructor TLogErros.Create(DiretorioSistema :String);
begin
   self.FDiretorioSistema := DiretorioSistema;
   self.FArquivo          := TStringList.Create;

   try
     self.FArquivo.LoadFromFile(self.NomeArquivo);
   except
     on E: EFOpenError do begin
        self.FArquivo.SaveToFile(self.NomeArquivo);
        self.FArquivo.LoadFromFile(self.NomeArquivo);
     end;
   end;
end;

destructor TLogErros.Destroy;
begin
  FreeAndNil(self.FArquivo);
  
  inherited;
end;

function TLogErros.GetNomeArquivo: String;
begin
   result :=  self.FDiretorioSistema + CAMINHO_ARQUIVO;
end;

end.
