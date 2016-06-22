unit uScript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MDOScript, MDOQuery, StdCtrls, ZSqlProcessor, ZDataset, uPadrao;

type
  TfrmScript = class(TfrmPadrao)
    Versao1: TMemo;
    Zsql: TZSQLProcessor;
    versao2: TMemo;
    versao3: TMemo;
    versao4: TMemo;
    versao5: TMemo;
    versao6: TMemo;
    versao7: TMemo;
    versao8: TMemo;
    versao9: TMemo;
    versao10: TMemo;
    versao11: TMemo;
    versao12: TMemo;
    versao13: TMemo;
    versao14: TMemo;
    versao15: TMemo;
    versao16: TMemo;
    versao17: TMemo;
    versao18: TMemo;
    versao19: TMemo;
    versao20: TMemo;
    procedure qry2ExecuteError(Sender: TObject; Error, SQLText: String;
      LineIndex: Integer; var Ignore: Boolean);
    procedure qry2ParseError(Sender: TObject; Error, SQLText: String;
      LineIndex: Integer);
    procedure FormCreate(Sender: TObject);
  private
    FQuery  :TZQuery;

    function SeparaSQLs(StringComSQLs :String) :TStrings;
    function ExecutaAtualizacao(nomemem: String; versao: Integer): Boolean;

    procedure ExecutarAntes(nVersao: Integer);
    procedure ExecutarDepois(nVersao: Integer);
    procedure Atualiza_versao_BD;

    destructor destroy; override;
    
  public
    function ExecutaAtualizacoesBanco: Boolean;
  end;

var
  frmScript: TfrmScript;

const
  UltimaVersaoSistema = 20;
  ScriptExterno = '<<SCRIPT EXTERNO>>';

implementation

uses uModulo, Versao, Repositorio, FabricaRepositorio;

{$R *.dfm}

function TfrmScript.ExecutaAtualizacao(nomemem: String; versao: Integer): Boolean;
var
   qry : TMDOQuery;
   mem : TMemo;
   ListaSQLs :TStrings;
   nX  :integer;
begin
  try

    Result := true;

    if (dm.Versao_BD >= versao) then
      exit;

    mem := (self.FindComponent(nomemem) as TMemo);

    if mem <> nil then
      begin
        // Executar antes
        self.ExecutarAntes(versao);

        ListaSQLs := self.SeparaSQLs( mem.Text );

        try
           for nX := 0 to (ListaSQLs.Count-1) do begin
               self.FQuery.SQL.Clear;
               self.FQuery.SQL.Add(ListaSQLs[nX]);
               self.FQuery.ExecSQL;
           end;

           self.FQuery.Connection.Commit;

         except
           on E: Exception do begin
             self.FQuery.Connection.RollBack;
             Result := false;
           end;
         end;

         FreeAndNil(ListaSQLs);

        Result := true;

      end
    else
      begin
        Result := false;
        exit;
      end;

    // Executar Depois
    self.ExecutarDepois(versao);

  except
    on E: Exception do begin
      Avisar('ERRO: '+e.Message);

    Result := false;

    if mem = nil then
      Avisar('>>> Aten��o <<<' + #13 + 'Erro ao executar script da vers�o: ' + IntToStr(versao))
    else
      Avisar('>>> Aten��o <<<' + #13 + 'Erro ao executar script da vers�o: ' + IntToStr(versao) + #13 + mem.Text);
    end;
  end;
end;

function TfrmScript.ExecutaAtualizacoesBanco: Boolean;
var nX: Integer;
begin
  Result := true;

  self.FQuery.Connection.AutoCommit := false;

  for nX := 0 to UltimaVersaoSistema do
    begin
      Application.ProcessMessages;
      Result := ExecutaAtualizacao('versao' + IntToStr(nX), nX);

      if not Result then
        break;
    end;

  self.FQuery.Connection.AutoCommit := true;

  Atualiza_versao_BD;

end;

procedure TfrmScript.ExecutarAntes(nVersao: Integer);
begin
  //se versao for tal , ent�o cria fun��o que faz algo necess�rio antes
  //if      (nVersao = 80)   then self.ExecutarAntesVersao80
end;

procedure TfrmScript.ExecutarDepois(nVersao: Integer);
begin
  //se versao for tal , ent�o cria fun��o que faz algo necess�rio ap�s
  //if      (nVersao = 90)   then self.ExecutarAntesVersao90
end;

procedure TfrmScript.qry2ExecuteError(Sender: TObject; Error, SQLText: String;
  LineIndex: Integer; var Ignore: Boolean);
begin
  raise Exception.Create('Erro no script: Execute Error: ' + Error);
end;

procedure TfrmScript.qry2ParseError(Sender: TObject; Error, SQLText: String;
  LineIndex: Integer);
begin
  raise Exception.Create('Erro no script: Parse Error: ' + Error);
end;

procedure TfrmScript.FormCreate(Sender: TObject);
begin
  inherited;
  self.FQuery                  := self.FDM.GetConsulta;
end;

procedure TfrmScript.Atualiza_versao_BD;
var
  Repositorio :TRepositorio;
  Versao      :TVersao;
begin
   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TVersao.ClassName);
     Versao        := TVersao( repositorio.Get( 0 ) );

     if not assigned(Versao) then exit;

     Versao.VersaoBancoDeDados  := UltimaVersaoSistema;

     Repositorio.Salvar(Versao);

   finally
     FreeAndNil(Repositorio);
     FreeAndNil(Versao);
   end;
end;

destructor TfrmScript.destroy;
begin
  if Assigned(self.FQuery) then
    FreeAndNil(self.FQuery);
  inherited;
end;

function TfrmScript.SeparaSQLs(StringComSQLs: String): TStrings;
var
  nX :Integer;
begin
  result           := TStringList.Create;
  StringComSQLs    := StringReplace(StringComSQLs, #$D#$A, ' ',    [rfReplaceAll]);
  result.Text      := StringReplace(StringComSQLs, '^',    #13#10, [rfReplaceAll]);

  // Para remover a �ltima linha vazia.
  if (result.Count > 1) and (Trim(result[result.Count-1]) = '') then
    result.Delete(result.Count-1);
end;

end.

