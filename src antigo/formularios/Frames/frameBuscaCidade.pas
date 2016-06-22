unit frameBuscaCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ObjetoGenerico, Mask, ToolEdit, CurrEdit;

type
  TBuscaCidade = class(TFrame)
    StaticText1: TStaticText;
    edtCidade: TEdit;
    btnBusca: TBitBtn;
    StaticText2: TStaticText;
    edtUF: TEdit;
    StaticText3: TStaticText;
    edtCodCid: TCurrencyEdit;
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCidadeEnter(Sender: TObject);
    procedure edtUFEnter(Sender: TObject);

  private
//    cidades :TObjetoGenerico;
    FcodCid :String;
    FCodigoMunicipio :Integer;

    procedure SetCodCid(const value:String);
    procedure buscaCidade(codigo :String);
    procedure BuscaCidadePorCodigoMunicipio(_CodigoMunicipio :Integer);
    function EstadoCodSigla(C_S:String):String;
    procedure SetCodigoMunicipio(const Value: Integer);

  public
//    destructor Destroy; override;
    procedure limpa;

  public
    property codCid :String read FCodCid write SetCodCid;
    property CodigoMunicipio :Integer read FCodigoMunicipio write SetCodigoMunicipio;

  public
    procedure Clear;
  end;

implementation

uses uPesquisaSimples, DB;

{$R *.dfm}

procedure TBuscaCidade.btnBuscaClick(Sender: TObject);
var campoRetorno :String;
begin
  campoRetorno := 'CODIBGE';
  
  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'select c.codibge, c.nome, e.sigla from cidades c '+
                                                        ' left join estados e on e.codigo = c.codest',
                                                        campoRetorno, 'Selecione uma cidade...');

  if frmPesquisaSimples.ShowModal = mrOk then
    buscaCidade(frmPesquisaSimples.cds_retorno.Fields[0].AsString);

  frmPesquisaSimples.Release;

  edtCidade.SetFocus;
end;

procedure TBuscaCidade.buscaCidade(codigo: String);
var
  campoRetorno :String;
  Cidades :TObjetoGenerico;
begin
  Cidades := nil;
  
  try
    campoRetorno := 'CODIBGE'; //campo que deseja que retorne

    if cidades = nil then
      cidades := TObjetoGenerico.Create;

    cidades.SQL := 'Select first 1 * from cidades where '+campoRetorno+'='+ codigo;

    if not cidades.BuscaVazia then begin
      edtCodCid.Value       := cidades.getCampo('codibge').AsInteger;
      edtCidade.Text        := cidades.getCampo('nome').AsString;
      edtUF.Text            := EstadoCodSigla(cidades.getCampo('codest').AsString);
      self.FCodigoMunicipio := cidades.GetCampo('codibge').AsInteger;
    end
    else
      limpa;
  finally
    FreeAndNil(Cidades);
  end;
end;

function TBuscaCidade.EstadoCodSigla(C_S: String): String;
var num :Integer;
begin
  num := StrToIntDef(C_S,0);

  if num = 0 then begin
    if C_S = 'AC' then result := '1'
    else if C_S = 'AL' then result := '2'
    else if C_S = 'AP' then result := '3'
    else if C_S = 'AM' then result := '4'
    else if C_S = 'BA' then result := '5'
    else if C_S = 'CE' then result := '6'
    else if C_S = 'DF' then result := '7'
    else if C_S = 'ES' then result := '8'
    else if C_S = 'RR' then result := '9'
    else if C_S = 'GO' then result := '10'
    else if C_S = 'MA' then result := '11'
    else if C_S = 'MT' then result := '12'
    else if C_S = 'MS' then result := '13'
    else if C_S = 'MG' then result := '14'
    else if C_S = 'PA' then result := '15'
    else if C_S = 'PB' then result := '16'
    else if C_S = 'PR' then result := '17'
    else if C_S = 'PE' then result := '18'
    else if C_S = 'PI' then result := '19'
    else if C_S = 'RJ' then result := '20'
    else if C_S = 'RN' then result := '21'
    else if C_S = 'RS' then result := '22'
    else if C_S = 'RO' then result := '23'
    else if C_S = 'TO' then result := '24'
    else if C_S = 'SC' then result := '25'
    else if C_S = 'SP' then result := '26'
    else if C_S = 'SE' then result := '27';

  end
  else begin
    if C_S = '1' then result := 'AC'
    else if C_S = '2'  then result := 'AL'
    else if C_S = '3'  then result := 'AP'
    else if C_S = '4'  then result := 'AM'
    else if C_S = '5'  then result := 'BA'
    else if C_S = '6'  then result := 'CE'
    else if C_S = '7'  then result := 'DF'
    else if C_S = '8'  then result := 'ES'
    else if C_S = '9'  then result := 'RR'
    else if C_S = '10' then result := 'GO'
    else if C_S = '11' then result := 'MA'
    else if C_S = '12' then result := 'MT'
    else if C_S = '13' then result := 'MS'
    else if C_S = '14' then result := 'MG'
    else if C_S = '15' then result := 'PA'
    else if C_S = '16' then result := 'PB'
    else if C_S = '17' then result := 'PR'
    else if C_S = '18' then result := 'PE'
    else if C_S = '19' then result := 'PI'
    else if C_S = '20' then result := 'RJ'
    else if C_S = '21' then result := 'RN'
    else if C_S = '22' then result := 'RS'
    else if C_S = '23' then result := 'RO'
    else if C_S = '24' then result := 'TO'
    else if C_S = '25' then result := 'SC'
    else if C_S = '26' then result := 'SP'
    else if C_S = '27' then result := 'SE';

  end;
end;

procedure TBuscaCidade.edtCidadeEnter(Sender: TObject);
begin
  if edtCodCid.Value > 0 then
    buscaCidade(edtCodCid.Text)
  else begin
    limpa;
    btnBusca.Click;
  end;
  
  try
    edtUF.SetFocus;
  except
  end;
end;

procedure TBuscaCidade.edtUFEnter(Sender: TObject);
begin
  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaCidade.SetCodCid(const value: String);
begin
  if (value = '0') or (value = '') then
    limpa
  else  
    buscaCidade(value);
end;

procedure TBuscaCidade.Clear;
begin
   self.Limpa;
end;

//destructor TBuscaCidade.Destroy;
//begin
//  if Assigned(self.cidades) then
//    FreeAndNil(self.cidades);
//
//  inherited;
//end;

procedure TBuscaCidade.limpa;
begin
  edtCodCid.Clear;
  edtCidade.Clear;
  edtUF.Clear;
  self.FCodigoMunicipio := 0;
end;

procedure TBuscaCidade.BuscaCidadePorCodigoMunicipio(
  _CodigoMunicipio: Integer);
var
  campoRetorno :String;
  Cidades      :TObjetoGenerico;
begin
  Cidades := nil;

  try
    campoRetorno := 'CODIBGE'; //campo que deseja que retorne

    if cidades = nil then
      cidades := TObjetoGenerico.Create;

    cidades.SQL := 'Select first 1 * from cidades where '+campoRetorno+'='+ IntToStr(_CodigoMunicipio);

    if not cidades.BuscaVazia then begin
      edtCodCid.Value       := cidades.getCampo('codibge').AsInteger;
      edtCidade.Text        := cidades.getCampo('nome').AsString;
      edtUF.Text            := EstadoCodSigla(cidades.getCampo('codest').AsString);
        self.FCodigoMunicipio := cidades.GetCampo('codibge').AsInteger;
    end
    else
      limpa;
  finally
    FreeAndNil(Cidades);
  end;
end;

procedure TBuscaCidade.SetCodigoMunicipio(const Value: Integer);
begin
   self.BuscaCidadePorCodigoMunicipio(Value);
end;

end.
