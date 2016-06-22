unit RepositorioComanda;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioComanda = class(TRepositorio)

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

  //==============================================================================
  // Auditoria
  //==============================================================================
  protected
    procedure SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
    procedure SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject); override;
    procedure SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject); override;
end;

implementation

uses
  SysUtils,
  Comanda;

{ TRepositorioComanda }

function TRepositorioComanda.Get(Dataset: TDataSet): TObject;
var
  Comanda :TComanda;
begin
   Comanda                := TComanda.Create;
   Comanda.Codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Comanda.numero_comanda := self.FQuery.FieldByName('numero_comanda').AsInteger;
   Comanda.ativa          := ((self.FQuery.FieldByName('ativa').AsString = 'S')or(self.FQuery.FieldByName('ativa').AsString = ''));
   Comanda.motivo         := self.FQuery.FieldByName('motivo').AsString;

   result := Comanda;
end;

function TRepositorioComanda.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TComanda(Objeto).Codigo;
end;

function TRepositorioComanda.GetNomeDaTabela: String;
begin
   result := 'ComandaS';
end;

function TRepositorioComanda.GetRepositorio: TRepositorio;
begin
   result := TRepositorioComanda.Create;
end;

function TRepositorioComanda.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TComanda(Objeto).Codigo <= 0);
end;

procedure TRepositorioComanda.SetCamposAlterados(Auditoria :TAuditoria; AntigoObjeto, Objeto :TObject);
var
  ComandaAntigo :TComanda;
  ComandaNovo   :TComanda;
begin
   ComandaAntigo := (AntigoObjeto as TComanda);
   ComandaNovo   := (Objeto       as TComanda);

   if (ComandaAntigo.numero_comanda <> ComandaNovo.numero_comanda) then
    Auditoria.AdicionaCampoAlterado('numero_comanda', IntToStr(ComandaAntigo.numero_comanda), IntToStr(ComandaNovo.numero_comanda));

   if      (ComandaAntigo.ativa <> ComandaNovo.ativa) and ComandaAntigo.ativa then
    Auditoria.AdicionaCampoAlterado('ativa', 'S', 'N')
   else if (ComandaAntigo.ativa <> ComandaNovo.ativa) and (not ComandaAntigo.ativa) then
    Auditoria.AdicionaCampoAlterado('ativa', 'N', 'S');

   if (ComandaAntigo.motivo <> ComandaNovo.motivo) then
    Auditoria.AdicionaCampoAlterado('motivo', IntToStr(ComandaAntigo.motivo), IntToStr(ComandaNovo.motivo));

end;

procedure TRepositorioComanda.SetCamposExcluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Comanda :TComanda;
begin
   Comanda := (Objeto as TComanda);

   Auditoria.AdicionaCampoExcluido('codigo',         IntToStr(Comanda.Codigo));
   Auditoria.AdicionaCampoExcluido('numero_comanda', IntToStr(Comanda.numero_comanda));

   if Comanda.ativa then Auditoria.AdicionaCampoExcluido('ativa',  'S')
   else                  Auditoria.AdicionaCampoExcluido('ativa',  'N');

   Auditoria.AdicionaCampoExcluido('motivo',         IntToStr(Comanda.motivo));
end;

procedure TRepositorioComanda.SetCamposIncluidos(Auditoria :TAuditoria;               Objeto :TObject);
var
  Comanda :TComanda;
begin
   Comanda := (Objeto as TComanda);

   Auditoria.AdicionaCampoIncluido('codigo',         IntToStr(Comanda.codigo));
   Auditoria.AdicionaCampoIncluido('numero_comanda', IntToStr(Comanda.numero_comanda));

   if Comanda.ativa then Auditoria.AdicionaCampoIncluido('ativa',  'S')
   else                  Auditoria.AdicionaCampoIncluido('ativa',  'N');

   Auditoria.AdicionaCampoIncluido('motivo',         IntToStr(Comanda.motivo));
end;

procedure TRepositorioComanda.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TComanda(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioComanda.SetParametros(Objeto: TObject);
var
  Comanda :TComanda;
begin
   Comanda := (Objeto as TComanda);

   self.FQuery.ParamByName('codigo').AsInteger   := Comanda.Codigo;
   self.FQuery.ParamByName('numero_comanda').AsInteger := Comanda.numero_comanda;

   if Comanda.Bloqueado then inherited SetParametro('ativa', 'S')
   else                      inherited SetParametro('ativa', 'N');

   self.FQuery.ParamByName('motivo').AsString := Comanda.motivo;   
end;

function TRepositorioComanda.SQLGet: String;
begin
  result := 'select * from Comandas where codigo = :ncod';
end;

function TRepositorioComanda.SQLGetAll: String;
begin
   result := 'select * from Comandas';
end;

function TRepositorioComanda.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Comandas where '+ campo +' = :ncampo';
end;

function TRepositorioComanda.SQLRemover: String;
begin
   result := ' delete from Comandas where codigo = :codigo ';
end;

function TRepositorioComanda.SQLSalvar: String;
begin
   result := 'update or insert into Comandas (codigo, numero_comanda, ativa, motivo) '+
             '                      values (:codigo, :numero_comanda, :ativa, :motivo) ';
end;

end.
