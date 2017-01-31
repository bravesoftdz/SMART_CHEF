unit Caixa;

interface

uses
  SysUtils,
  Contnrs, Movimento, Repositorio, Printers, Generics.Collections, SangriaReforco;

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
    FTotal_sangria :Real;
    FTotal_reforco :Real;
    FTotal_Geral: Real;
    FMovimentos :TObjectList<TMovimento>;
    FSangriaReforco :TObjectList<TSangriaReforco>;

    function GetTotalGeral: Real;
    function GetMovimentos: TObjectList<TMovimento>;
    function GetSangriaReforco: TObjectList<TSangriaReforco>;

  public
    property codigo           :integer   read Fcodigo           write Fcodigo;
    property data_abertura    :TDateTime read Fdata_abertura    write Fdata_abertura;
    property valor_abertura   :Real      read Fvalor_abertura   write Fvalor_abertura;
    property data_fechamento  :TDateTime read Fdata_fechamento  write Fdata_fechamento;
    property valor_fechamento :Real      read Fvalor_fechamento write Fvalor_fechamento;

    property Total_dinheiro :Real        read FTotal_dinheiro;
    property Total_cheque   :Real        read FTotal_cheque;
    property Total_cartaoC   :Real       read FTotal_cartaoC;
    property Total_cartaoD   :Real       read FTotal_cartaoD;
    property Total_sangria   :Real       read FTotal_sangria;
    property Total_reforco   :Real       read FTotal_reforco;

    property Total_Geral     :Real       read GetTotalGeral;

    property movimentos       :TObjectList<TMovimento>      read GetMovimentos;
    property SangriasReforcos :TObjectList<TSangriaReforco> read GetSangriaReforco;

  public
    procedure imprime_48Colunas;
    constructor Create;
  private
    destructor Destroy;override;
end;

const
  I_NEGRITO         = #27 + #69;
  F_NEGRITO         = #27 + #70 + #10;
  I_ITALICO         = #27 + #52;
  F_ITALICO         = #27 + #53 + #10;
  ACIONA_GUILHOTINA = #27 + #109;
  
implementation

uses EspecificacaoMovimentosCaixa, FabricaRepositorio, Classes, StrUtils, EspecificacaoSangriaReforcoPorCodigoCaixa;

{ TCaixa }

constructor TCaixa.Create;
begin
  FMovimentos := nil;
end;

destructor TCaixa.Destroy;
begin
  if assigned(FMovimentos) then
    FreeAndNil(FMovimentos);
  if assigned(FSangriaReforco) then
    FreeAndNil(FSangriaReforco);
  inherited;
end;

function TCaixa.GetMovimentos: TObjectList<TMovimento>;
var especificacao :TEspecificacaoMovimentosCaixa;
    repositorio   :TRepositorio;
    i             :integer;
begin
  repositorio   := nil;
  especificacao := nil;
  try
    if assigned(FMovimentos) then
      freeAndNil(FMovimentos);

      self.FTotal_dinheiro := 0;
      self.FTotal_cheque   := 0;
      self.FTotal_cartaoC  := 0;
      self.FTotal_cartaoD  := 0;

      repositorio := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);

      especificacao    := TEspecificacaoMovimentosCaixa.Create(self);

      self.FMovimentos := repositorio.GetListaPorEspecificacao<TMovimento>(especificacao, 'CODIGO_CAIXA = '+intToStr(self.codigo));

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

  Finally
    if assigned(repositorio) then  FreeAndNil(repositorio);
    if assigned(especificacao) then  FreeAndNil(especificacao);
  end;
end;

function TCaixa.GetSangriaReforco: TObjectList<TSangriaReforco>;
var especificacao :TEspecificacaoSangriaReforcoPorCodigoCaixa;
    repositorio   :TRepositorio;
    i             :integer;
begin
  repositorio   := nil;
  especificacao := nil;
  try
    if assigned(FSangriaReforco) then
      FreeAndNil(FSangriaReforco);

      self.FTotal_sangria := 0;
      self.FTotal_reforco := 0;

      repositorio := TFabricaRepositorio.GetRepositorio(TSangriaReforco.ClassName);

      especificacao    := TEspecificacaoSangriaReforcoPorCodigoCaixa.Create(self.codigo);

      self.FSangriaReforco := repositorio.GetListaPorEspecificacao<TSangriaReforco>(especificacao, 'CODIGO_CAIXA = '+intToStr(self.codigo));

      if not assigned(FSangriaReforco) then
        exit;

      for i := 0 to FSangriaReforco.Count - 1 do begin
        if FSangriaReforco[i].tipo = 'S' then
          FTotal_sangria := FTotal_sangria + FSangriaReforco[i].valor
        else if FSangriaReforco[i].tipo = 'R' then
          FTotal_reforco := FTotal_reforco + FSangriaReforco[i].valor;
      end;

  Finally
    if assigned(repositorio) then  FreeAndNil(repositorio);
    if assigned(especificacao) then  FreeAndNil(especificacao);
  end;
end;

function TCaixa.GetTotalGeral: Real;
begin
   GetMovimentos;
   GetSangriaReforco;
   FTotal_Geral := 0;
   FTotal_Geral := self.Total_dinheiro + self.Total_cheque + self.Total_cartaoC + self.Total_cartaoD + Self.Total_reforco - self.Total_sangria;
   result       := FTotal_Geral;
end;

procedure TCaixa.imprime_48Colunas;
var Arq               :TextFile;
    impressora_padrao :String;
    TotalGeral        :Real;
begin
  TotalGeral := self.GetTotalGeral;

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
  Writeln(Arq, StringOfChar('-',48));
  Writeln(Arq, 'Total sangria >'+StringOfChar(' ', 31- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_sangria))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_sangria));
  Writeln(Arq, 'Total reforço >'+StringOfChar(' ', 31- (length(FormatFloat(' ,0.00; -,0.00;',self.Total_reforco))) ) + FormatFloat(' ,0.00; -,0.00;',self.Total_reforco));
  WriteLn(Arq, '');
  Writeln(Arq, 'Valor da abertura >'+StringOfChar(' ', 27- (length(FloatToStr(self.valor_abertura))) ) + FloatToStr(self.valor_abertura));
  Writeln(Arq, StringOfChar('-',48));

  Writeln(Arq, 'TOTAL GERAL >'+StringOfChar(' ', 30- (length(FloatToStr(TotalGeral))) ) + FormatFloat(' ,0.00; -,0.00;',TotalGeral));

  writeLn(Arq, '');
  writeLn(Arq, '');
  writeLn(Arq, '');
  writeLn(Arq, '');
  WriteLn(Arq, ACIONA_GUILHOTINA);
  CloseFile(Arq);
end;

end.
