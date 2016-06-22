unit Caixa;

interface

uses
  SysUtils,
  Contnrs, Movimento, Repositorio, Printers;

type
  TCaixa = class

  private
    Fcodigo: integer;
    Fvalor_abertura: Real;
    Fvalor_fechamento: Real;
    Fdata_fechamento: TDateTime;
    Fdata_abertura: TDateTime;
    FTotal_dinheiro :Real;
    FTotal_cheque :Real;
    FTotal_cartaoC :Real;
    FTotal_cartaoD :Real;
    FMovimentos :TObjectList;

    function GetMovimentos: TObjectList;

  public
    property codigo           :integer   read Fcodigo           write Fcodigo;
    property data_abertura    :TDateTime read Fdata_abertura    write Fdata_abertura;
    property valor_abertura   :Real      read Fvalor_abertura   write Fvalor_abertura;
    property data_fechamento  :TDateTime read Fdata_fechamento  write Fdata_fechamento;
    property valor_fechamento :Real      read Fvalor_fechamento write Fvalor_fechamento;

    property Total_dinheiro :Real        read FTotal_dinheiro;
    property Total_cheque   :Real        read FTotal_cheque;
    property Total_cartaoC   :Real        read FTotal_cartaoC;
    property Total_cartaoD   :Real        read FTotal_cartaoD;

    property movimentos       :TObjectList read GetMovimentos;

  public
    procedure imprime_48Colunas;
    constructor Create;
end;

const
  I_NEGRITO         = #27 + #69;
  F_NEGRITO         = #27 + #70 + #10;
  I_ITALICO         = #27 + #52;
  F_ITALICO         = #27 + #53 + #10;
  ACIONA_GUILHOTINA = #27 + #109;
  
implementation

uses EspecificacaoMovimentosCaixa, FabricaRepositorio, Classes, StrUtils;

{ TCaixa }

constructor TCaixa.Create;
begin
  FMovimentos := nil;
end;

function TCaixa.GetMovimentos: TObjectList;
var especificacao :TEspecificacaoMovimentosCaixa;
    repositorio   :TRepositorio;
    i             :integer;
begin
  repositorio   := nil;
  especificacao := nil;

  try
    if not assigned(FMovimentos) then begin
      self.FTotal_dinheiro := 0;
      self.FTotal_cheque   := 0;
      self.FTotal_cartaoC  := 0;
      self.FTotal_cartaoD  := 0;

      repositorio := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);

      especificacao    := TEspecificacaoMovimentosCaixa.Create(self);

      self.FMovimentos := repositorio.GetListaPorEspecificacao(especificacao, 'CODIGO_CAIXA = '+intToStr(self.codigo));

      for i := 0 to FMovimentos.Count - 1 do begin

        if TMovimento(FMovimentos[i]).tipo_moeda = 1 then
          FTotal_dinheiro := FTotal_dinheiro + TMovimento(FMovimentos[i]).valor_pago
        else if TMovimento(FMovimentos[i]).tipo_moeda = 2 then
          FTotal_cheque := FTotal_cheque + TMovimento(FMovimentos[i]).valor_pago
        else if TMovimento(FMovimentos[i]).tipo_moeda = 3 then
          FTotal_cartaoC := FTotal_cartaoC + TMovimento(FMovimentos[i]).valor_pago
        else if TMovimento(FMovimentos[i]).tipo_moeda = 4 then
          FTotal_cartaoD := FTotal_cartaoD + TMovimento(FMovimentos[i]).valor_pago;
      end;

    end;

  Finally
    if assigned(repositorio) then  FreeAndNil(repositorio);
    if assigned(especificacao) then  FreeAndNil(especificacao);    
  end;
end;

procedure TCaixa.imprime_48Colunas;
var Arq               :TextFile;
    impressora_padrao :String;
    TotalGeral        :Real;
begin
  GetMovimentos;

  TotalGeral := 0;

  if(Printer.PrinterIndex >= 0)then begin
    impressora_padrao := IfThen(pos('\\',Printer.Printers[Printer.PrinterIndex]) > 0,'','\\localhost\' )+ Printer.Printers[Printer.PrinterIndex];
    AssignFile(Arq, impressora_padrao);
    ReWrite(Arq);
  end
  else
    raise Exception.Create('Nenhuma impressora Padrão foi detectada');
             //123456789012345678901234567890123456789012345678

  Writeln(Arq, '* * * * * * * VALORES DO CAIXA * * * * * * * * *');
  Writeln(Arq, StringOfChar(' ',48- length(DateToStr(self.data_abertura)+' '+TimeToStr(Time)))+DateToStr(self.data_abertura)+' '+TimeToStr(Time));
  Writeln(Arq, StringOfChar('-',48));
  Writeln(Arq, 'Total em dinheiro >'+StringOfChar(' ', 27- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_dinheiro))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_dinheiro));
  Writeln(Arq, 'Total em cheque >'+StringOfChar(' ', 29- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_cheque))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_cheque));
  Writeln(Arq, 'Total cartão crédito >'+StringOfChar(' ', 24- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_cartaoC))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_cartaoC));
  Writeln(Arq, 'Total cartão débito >'+StringOfChar(' ', 25- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_cartaoD))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_cartaoD));
  WriteLn(Arq, '');
  Writeln(Arq, 'Valor da abertura >'+StringOfChar(' ', 27- (length(FloatToStr(self.valor_abertura))) ) + FloatToStr(self.valor_abertura));
  Writeln(Arq, StringOfChar('-',48));

  TotalGeral := self.Total_dinheiro + self.Total_cheque + self.Total_cartaoC + self.Total_cartaoD;

  Writeln(Arq, 'TOTAL GERAL >'+StringOfChar(' ', 30- (length(FloatToStr(TotalGeral))) ) + FormatFloat(' ,0.00; -,0.00;',TotalGeral));

  writeLn(Arq, '');
  writeLn(Arq, '');
  WriteLn(Arq, ACIONA_GUILHOTINA);
  CloseFile(Arq);
end;

end.
