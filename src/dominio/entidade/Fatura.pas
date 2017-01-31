unit Fatura;

interface

uses
  Contnrs,
  Duplicata;

type
  TFatura = class

  private
    FNumeroFatura  :Integer;
    FValorBruto    :Real;
    FValorDesconto :Real;
    FValorLiquido  :Real;
    FDuplicatas    :TObjectList;
    function GetNumeroFaturaStr: String;

  private
    function GetDuplicatas     :TObjectList;
    function GetNumeroFatura   :Integer;
    function GetValorBruto     :Real;
    function GetValorDesconto  :Real;
    function GetValorLiquido   :Real;

  public
    constructor Create(NumeroFatura  :Integer;
                       ValorBruto    :Real;
                       ValorDesconto :Real;
                       ValorLiquido  :Real);

  public
    property NumeroFatura    :Integer     read GetNumeroFatura;
    property NumeroFaturaStr :String      read GetNumeroFaturaStr;
    property ValorBruto      :Real        read GetValorBruto;
    property ValorDesconto   :Real        read GetValorDesconto;
    property ValorLiquido    :Real        read GetValorLiquido;
    property Duplicatas      :TObjectList read GetDuplicatas;

  public
    procedure AdicionarDuplicata(ValorDuplicata :Real; DataVencimento :TDateTime);
end;

implementation

uses
  ExcecaoParametroInvalido,
  StringUtilitario,
  Classes,
  SysUtils;

{ TFatura }

procedure TFatura.AdicionarDuplicata(ValorDuplicata: Real; DataVencimento: TDateTime);
var
  LetraDuplicata :String;
  nX             :Integer;
  Duplicata      :TDuplicata;
begin
   LetraDuplicata := TStringUtilitario.LetraPorSequencia(self.FDuplicatas.Count + 1);

   { Verifico se a data do vencimento é mesmo maior que das outras duplicatas adicionadas }
   for nX := 0 to (self.FDuplicatas.Count-1) do begin
      Duplicata := (self.FDuplicatas[nX] as TDuplicata);

      if (DataVencimento < Duplicata.DataVencimento) then
        raise TExcecaoParametroInvalido.Create(self.ClassName, 'AdicionarDuplicata(ValorDuplicata: Real; DataVencimento: TDateTime)', 'DataVencimento');
   end;

   Duplicata := TDuplicata.Create(LetraDuplicata+' - '+IntToStr(self.FNumeroFatura),
                                  DataVencimento,
                                  ValorDuplicata);

   self.FDuplicatas.Add(Duplicata);
end;

constructor TFatura.Create(NumeroFatura: Integer; ValorBruto, ValorDesconto, ValorLiquido: Real);
const
  NOME_METODO = 'Create(NumeroFatura: Integer; ValorBruto, ValorDesconto, ValorLiquido: Real)';
begin
   if (NumeroFatura <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'NumeroFatura');

   if (ValorBruto <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'ValorBruto');

   if (ValorDesconto < 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'ValorDesconto');

   if (ValorLiquido <= 0) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, NOME_METODO, 'ValorLiquido');

   self.FNumeroFatura  := NumeroFatura;
   self.FValorBruto    := ValorBruto;
   self.FValorDesconto := ValorDesconto;
   self.FValorLiquido  := ValorLiquido;
   self.FDuplicatas    := TObjectList.Create;
end;

function TFatura.GetDuplicatas: TObjectList;
begin
   result := self.FDuplicatas;
end;

function TFatura.GetNumeroFatura: Integer;
begin
   result := self.FNumeroFatura;
end;

function TFatura.GetNumeroFaturaStr: String;
begin
   result := IntToStr(self.FNumeroFatura);
end;

function TFatura.GetValorBruto: Real;
begin
   result := self.FValorBruto;
end;

function TFatura.GetValorDesconto: Real;
begin
   result := self.FValorDesconto;
end;

function TFatura.GetValorLiquido: Real;
begin
   result := self.FValorLiquido;
end;

end.
