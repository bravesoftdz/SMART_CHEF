unit EspecificacaoNotaFiscalPorPeriodoEStatus;

interface

uses
  Especificacao, Dialogs, SysUtils;

type
  TEspecificacaoNotaFiscalPorPeriodoEStatus = class(TEspecificacao)

  private
    FDataInicial              :TDateTime;
    FDataFinal                :TDateTime;
    FComStatusAguardandoEnvio :Boolean;
    FComStatusAutorizada      :Boolean;
    FComStatusRejeitada       :Boolean;
    FComStatusCancelada       :Boolean;
    FTipoDaNota               :String;
    FCNPJ_empresa_selecionada :String;

  public
    constructor Create(DataInicial, DataFinal   :TDateTime;
                       ComStatusAguardandoEnvio :Boolean;
                       ComStatusAutorizada      :Boolean;
                       ComStatusRejeitada       :Boolean;
                       ComStatusCancelada       :Boolean;
                       const CNPJ_empresa_selecionada :String = '0';
                       const TipoDaNota :String = 'A');

  public
    function SatisfeitoPor(NotaFiscal :TObject) :Boolean; override;
end;

implementation

uses
  NotaFiscal,
  TipoStatusNotaFiscal;

{ TEspecificacaoNotaFiscalPorPeriodoEStatus }

constructor TEspecificacaoNotaFiscalPorPeriodoEStatus.Create(DataInicial,
  DataFinal: TDateTime; ComStatusAguardandoEnvio, ComStatusAutorizada,
  ComStatusRejeitada, ComStatusCancelada: Boolean; const CNPJ_empresa_selecionada :String; const TipoDaNota :String);
begin

    FDataInicial              := DataInicial;
    FDataFinal                := DataFinal;
    FComStatusAguardandoEnvio := ComStatusAguardandoEnvio;
    FComStatusAutorizada      := ComStatusAutorizada;
    FComStatusRejeitada       := ComStatusRejeitada;
    FComStatusCancelada       := ComStatusCancelada;
    FCNPJ_empresa_selecionada := CNPJ_empresa_selecionada;
    FTipoDaNota               := TipoDaNota;

end;

function TEspecificacaoNotaFiscalPorPeriodoEStatus.SatisfeitoPor(
  NotaFiscal: TObject): Boolean;
var
  NF :TNotaFiscal;
begin
   NF := (NotaFiscal as TNotaFiscal);

   if FTipoDaNota <> 'A' then
     if (NF.Entrada_saida <> FTipoDaNota) then begin
       result := false;
       exit;
     end;

   //Verifico se a nota é de entrada e se a especificação nao esta sendo chamada pelo GeradorSintegra ou foi nota de importacao pelo xml
   if ( NF.Entrada_saida = 'E' ) and (( self.FCNPJ_empresa_selecionada = '0' ) or NF.notaDeImportacao) then begin
     result := false;
     exit;
   end;

   //verifico se a nota pertence ou não a empresa especificada
   if Length(self.FCNPJ_empresa_selecionada) > 10 then
     if ((Nf.Entrada_saida = 'E') and (NF.Destinatario.CPF_CNPJ <> self.FCNPJ_empresa_selecionada)) or
       ((NF.Entrada_saida <> 'E') and (NF.Emitente.CPF_CNPJ <> self.FCNPJ_empresa_selecionada)) then begin
       result := false;
       exit;
     end;

//   if (Nf.Entrada_saida = 'E') and ((NF.DataEmissao >= self.FDataInicial) and (NF.DataEmissao <= self.FDataFinal)) then
//     showmessage(IntToStr(Nf.CodigoNotaFiscal)+' - '+DateToStr(NF.DataEmissao));

   // Verifico se nota fiscal satisfaz o período de emissão da especificação
   result := ((self.FDataInicial = 0) and (self.FDataFinal = 0)) or ((NF.DataEmissao >= self.FDataInicial) and (NF.DataEmissao <= self.FDataFinal));

   // Se não satisfaz a data sai do método e retorna falso
   if not result then
    exit;

   //se for nota de entrada e for de importacao por XML ja esta com status de enviada
   if (NF.Entrada_saida = 'E') and ( length(self.FCNPJ_empresa_selecionada) > 10) then begin
     result := true;
     exit;
   end;

   // Verifico se a nota fiscal satistaz o status de aguardando envio
   if self.FComStatusAguardandoEnvio then begin
      result := (NF.Status = snfAguardandoEnvio);

      if result then exit;
   end;

   // Verifico se a nota fiscal satistaz o status de autorizada
   if self.FComStatusAutorizada then begin
      result := (NF.Status = snfAutorizada);

      if result then exit;
   end;

   // Verifico se a nota fiscal satistaz o status de rejeitada
   if self.FComStatusRejeitada then begin
      result := (NF.Status = snfRejeitada);

      if result then exit;
   end;

      // Verifico se a nota fiscal satistaz o status de cancelada
   if self.FComStatusCancelada then begin
      result := (NF.Status = snfCancelada);

      if result then exit;
   end;
end;

end.
