unit ObjetoGenerico;

interface

uses
  DB,
  DBClient,
  SysUtils,
  Auditoria;

type
  TObjetoGenerico = class

  private
    FAuditoria  :TAuditoria;
    FLista      :TDataSet;
    FSQL        :String;
    FBuscaVazia :Boolean;

  private
    procedure SetLista(const value :TDataSet);
    procedure SetSQL(const value :String);

  private
    procedure CriaAuditoria(DataSet: TDataSet);

  private
    function retornaTabela :String;
    function retornaCampos :String;

  public
    constructor Create;
    destructor  Destroy; override;

  public
    property lista      :TDataSet read FLista       write SetLista;
    property SQL        :String   read FSQL         write SetSQL;
    property BuscaVazia :Boolean  read FBuscaVazia;

    procedure Editar;
    procedure inserir;
    procedure Salvar;
    function  getCampo(nomeCampo:String):TField;
    function  verificaExiste(SQL :String): boolean;

  end;

implementation

uses
   uModulo;

{ TObjetoGenerico }

constructor TObjetoGenerico.Create;
begin
   self.FAuditoria  := nil;
   self.FLista      := nil;
   self.FSQL        := '';
end;

procedure TObjetoGenerico.CriaAuditoria(DataSet: TDataSet);
begin
   if Assigned(self.FAuditoria) then
    FreeAndNil(self.FAuditoria);

   self.FAuditoria := TAuditoria.Create(dm.UsuarioLogado, self.retornaTabela, dm.NomeDoTerminal);
end;

destructor TObjetoGenerico.Destroy;
begin
  if Assigned(self.FAuditoria) then
    FreeAndNil(self.FAuditoria);

  if Assigned(self.FLista) then
   FreeAndNil(self.FLista);
   
  inherited;
end;

procedure TObjetoGenerico.Editar;
begin
  self.FLista.Edit;
end;

function TObjetoGenerico.getCampo(nomeCampo: String): TField;
begin
  if assigned(FLista) then
    Result := FLista.fieldByName(nomecampo);
end;

procedure TObjetoGenerico.inserir;
begin
  self.FLista.Append;
end;

function TObjetoGenerico.retornaCampos: String;
var i:integer;
 parte1, parte2 :String;
begin
  parte1 := ' ('+self.FLista.Fields[0].FieldName;
  parte2 := ' values(:'+self.FLista.Fields[0].FieldName;

  for i:=1 to self.FLista.FieldCount - 1 do begin
    parte1 := parte1 + ',' + self.FLista.Fields[i].FieldName;
    parte2 := parte2 + ',:'+ self.FLista.Fields[i].FieldName;
  end;
  parte1 := parte1+') ';
  parte2 := parte2+') ';

  result := parte1 + parte2;

end;

function TObjetoGenerico.retornaTabela: String;
var i, posInicial :integer;
begin
  posInicial := 0;

  for i:= pos('FROM',FSQL)+4 to length(sql) do begin
    if (FSQL[i] <> ' ')and (posInicial = 0) then
      posInicial := i;

    if (posInicial > 0) and (FSQL[i] = ' ') then begin
      result := copy(FSQL,posInicial, (i-posinicial));
      break;
    end;
  end;
end;

procedure TObjetoGenerico.Salvar;
var tabela, campos :String;
  i:integer;
begin
  tabela := RetornaTabela;
  campos := RetornaCampos;
  dm.qryGenerica.SQL.Text := 'UPDATE OR INSERT INTO '+tabela+campos;

  for i:= 0 to self.FLista.FieldCount -1 do begin

    if self.FLista.Fields[i].DataType in [ftSmallint, ftInteger, ftWord] then
      dm.qryGenerica.ParamByName(self.FLista.Fields[i].FieldName).AsInteger := self.FLista.fieldByName(self.FLista.Fields[i].FieldName).AsInteger
    else
      if self.FLista.Fields[i].DataType in [ftString] then
        dm.qryGenerica.ParamByName(self.FLista.Fields[i].FieldName).AsString := self.FLista.fieldByName(self.FLista.Fields[i].FieldName).AsString
    else
      if self.FLista.Fields[i].DataType in [ftBoolean, ftFloat, ftCurrency, ftBCD] then
        dm.qryGenerica.ParamByName(self.FLista.Fields[i].FieldName).AsFloat := self.FLista.fieldByName(self.FLista.Fields[i].FieldName).AsFloat
    else
      if self.FLista.Fields[i].DataType in [ftDate, ftTime, ftDateTime] then
        dm.qryGenerica.ParamByName(self.FLista.Fields[i].FieldName).AsDateTime := self.FLista.fieldByName(self.FLista.Fields[i].FieldName).AsDateTime;

  end;
  dm.qryGenerica.ExecSQL;
end;

procedure TObjetoGenerico.SetLista(const value: TDataSet);
begin
  FLista := value;
end;

procedure TObjetoGenerico.SetSQL(const value: String);
begin

  self.FBuscaVazia := true;
  FSQL := uppercase(value);
  FLista := dm.GetConsulta(value);
  FLista.Open;
                                                                                      
  if not FLista.IsEmpty then
    self.FBuscaVazia := false;

  FLista.Filtered := false;
end;

function TObjetoGenerico.verificaExiste(SQL: String): boolean;
begin
  Result := false;

  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := SQL;
  dm.qryGenerica.Open;

  if not dm.qryGenerica.IsEmpty then  Result := true;
end;

end.
