unit RepositorioItemNotaFiscal;

interface

uses
  DB,
  Repositorio;

type
  TRepositorioItemNotaFiscal = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet)  :TObject; overload; override;
    function GetNomeDaTabela                      :String;            override;
    function GetIdentificador(Objeto :TObject)    :Variant;           override;
    function GetChaveParaRemocao(Objeto :TObject) :Variant;           override;
    function GetRepositorio                       :TRepositorio;      override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
    function IsColecao ()                :Boolean;           override; 

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

end;

implementation

uses
  ItemNotaFiscal,
  FabricaRepositorio,
  Icms00,
  IpiTrib,
  PisAliq,
  CofinsAliq,
  IcmsSn101,
  IpiNt,
  PisNt,
  CofinsNt,
  SysUtils;

{ TRepositorioItemNotaFiscal }

procedure TRepositorioItemNotaFiscal.ExecutaDepoisDeSalvar(
  Objeto: TObject);
var
  It              :TItemNotaFiscal;

  RepIcms00       :TRepositorio;
  RepIpiTrib      :TRepositorio;
  RepPisAliq      :TRepositorio;
  RepCofinsAliq   :TRepositorio;
  RepIcmsSn101    :TRepositorio;
  RepIpiNt        :TRepositorio;
  RepPisNt        :TRepositorio;
  RepCofinsNt     :TRepositorio;
begin
   It := (Objeto as TItemNotaFiscal);

   RepIcms00       := nil;
   RepIpiTrib      := nil;
   RepPisAliq      := nil;
   RepCofinsAliq   := nil;

   RepIcmsSn101    := nil;
   RepIpiNt        := nil;
   RepPisNt        := nil;
   RepCofinsNt     := nil;


   try
     if Assigned(It.Icms00) then begin
        RepIcms00 := TFabricaRepositorio.GetRepositorio(TIcms00.ClassName);
        It.Icms00.codigoItem := It.Codigo;
        RepIcms00.Salvar(It.Icms00);
     end;

     if Assigned(It.IpiTrib) then begin
        RepIpiTrib := TFabricaRepositorio.GetRepositorio(TIpiTrib.ClassName);
        It.IpiTrib.codigoItem := It.Codigo;
        RepIpiTrib.Salvar(It.IpiTrib);
     end;

     if Assigned(It.PisAliq) then begin
       RepPisAliq := TFabricaRepositorio.GetRepositorio(TPisAliq.ClassName);
       It.PisAliq.codigoItem := It.Codigo;
       RepPisAliq.Salvar(It.PisAliq);
     end;

     if Assigned(It.CofinsAliq) then begin
       RepCofinsAliq := TFabricaRepositorio.GetRepositorio(TCofinsAliq.ClassName);
       It.CofinsAliq.codigoItem := It.Codigo;
       RepCofinsAliq.Salvar(It.CofinsAliq);
     end;

     if Assigned(It.IcmsSn101) then begin
       RepIcmsSn101 := TFabricaRepositorio.GetRepositorio(TIcmsSn101.ClassName);
       It.IcmsSn101.codigoItem := It.Codigo;
       RepIcmsSn101.Salvar(It.IcmsSn101);
     end;

     if Assigned(It.IpiNt) then begin
       RepIpiNt := TFabricaRepositorio.GetRepositorio(TIpiNt.ClassName);
       It.IpiNt.codigoItem := It.Codigo;
       RepIpiNt.Salvar(It.IpiNt);
     end;

     if Assigned(It.PisNt) then begin
       RepPisNt := TFabricaRepositorio.GetRepositorio(TPisNt.ClassName);
       It.PisNt.codigoItem := It.Codigo;
       RepPisNt.Salvar(It.PisNt);
     end;

     if Assigned(It.CofinsNt) then begin
       RepCofinsNt := TFabricaRepositorio.GetRepositorio(TCofinsNt.ClassName);
       It.CofinsNt.codigoItem := It.Codigo;
       RepCofinsNt.Salvar(It.CofinsNt);
     end;

   finally
     FreeAndNil(RepIcms00);
     FreeAndNil(RepIpiTrib);
     FreeAndNil(RepPisAliq);
     FreeAndNil(RepCofinsAliq);
     FreeAndNil(RepIcmsSn101);
     FreeAndNil(RepIpiNt);
     FreeAndNil(RepPisNt);
     FreeAndNil(RepCofinsNt);
   end;
end;

function TRepositorioItemNotaFiscal.Get(Dataset: TDataSet): TObject;
begin
   result := TItemNotaFiscal.CriaParaRepositorio(Dataset.FieldByName('codigo').AsInteger,
                                                 Dataset.FieldByName('codigo_nota_fiscal').AsInteger, 
                                                 Dataset.FieldByName('codigo_produto').AsInteger,
                                                 Dataset.FieldByName('codigo_natureza').AsInteger,
                                                 Dataset.FieldByName('quantidade').AsFloat,
                                                 Dataset.FieldByName('valor_unitario').AsFloat);
end;

function TRepositorioItemNotaFiscal.GetChaveParaRemocao(
  Objeto: TObject): Variant;
begin
   result := TItemNotaFiscal(Objeto).CodigoNotaFiscal;
end;

function TRepositorioItemNotaFiscal.GetIdentificador(
  Objeto: TObject): Variant;
begin
   result := TItemNotaFiscal(Objeto).Codigo;
end;

function TRepositorioItemNotaFiscal.GetNomeDaTabela: String;
begin
   result := 'itens_notas_fiscais';
end;

function TRepositorioItemNotaFiscal.GetRepositorio: TRepositorio;
begin
   result := TRepositorioItemNotaFiscal.Create;
end;

function TRepositorioItemNotaFiscal.IsColecao: Boolean;
begin
   result := false;
end;

function TRepositorioItemNotaFiscal.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TItemNotaFiscal(Objeto).Codigo <= 0);
end;
                                       {
procedure TRepositorioItemNotaFiscal.SetCamposExcluidos(
  Auditoria: TAuditoria; Objeto: TObject);
var
  Obj :TItemNotaFiscal;
begin
   Obj := (Objeto as TItemNotaFiscal);

   Auditoria.AdicionaCampoExcluido('codigo',             IntToStr(Obj.Codigo));
   Auditoria.AdicionaCampoExcluido('codigo_nota_fiscal', IntToStr(Obj.CodigoNotaFiscal));
   Auditoria.AdicionaCampoExcluido('codigo_produto',     IntToStr(Obj.Produto.Codigo));
   Auditoria.AdicionaCampoExcluido('codigo_natureza',    IntToStr(Obj.NaturezaOperacao.Codigo));
   Auditoria.AdicionaCampoExcluido('quantidade',         FloatToStr(Obj.Quantidade));
   Auditoria.AdicionaCampoExcluido('valor_unitario',     FloatToStr(Obj.ValorUnitario));
end;

procedure TRepositorioItemNotaFiscal.SetCamposIncluidos(
  Auditoria: TAuditoria; Objeto: TObject);
var
  Obj :TItemNotaFiscal;
begin
   Obj := (Objeto as TItemNotaFiscal);

   Auditoria.AdicionaCampoIncluido('codigo',             IntToStr(Obj.Codigo));
   Auditoria.AdicionaCampoIncluido('codigo_nota_fiscal', IntToStr(Obj.CodigoNotaFiscal));
   Auditoria.AdicionaCampoIncluido('codigo_produto',     IntToStr(Obj.Produto.Codigo));
   Auditoria.AdicionaCampoIncluido('codigo_natureza',    IntToStr(Obj.NaturezaOperacao.Codigo));
   Auditoria.AdicionaCampoIncluido('quantidade',         FloatToStr(Obj.Quantidade));
   Auditoria.AdicionaCampoIncluido('valor_unitario',     FloatToStr(Obj.ValorUnitario));
end;                                             }

procedure TRepositorioItemNotaFiscal.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TItemNotaFiscal(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioItemNotaFiscal.SetParametros(Objeto: TObject);
var
  obj :TItemNotaFiscal;
begin
  obj := (Objeto as TItemNotaFiscal);

  if (obj.Codigo > 0) then inherited SetParametro('codigo', obj.Codigo)
  else                     inherited LimpaParametro('codigo');

  inherited SetParametro('codigo_nota_fiscal', Obj.CodigoNotaFiscal);
  inherited SetParametro('codigo_produto',     Obj.Produto.Codigo);
  inherited SetParametro('codigo_natureza',    Obj.NaturezaOperacao.Codigo);
  inherited SetParametro('quantidade',         Obj.Quantidade);
  inherited SetParametro('valor_unitario',     Obj.ValorUnitario);
end;

function TRepositorioItemNotaFiscal.SQLGet: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' where codigo = :codigo';
end;

function TRepositorioItemNotaFiscal.SQLGetAll: String;
begin
   result := 'select * from '+self.GetNomeDaTabela+' order by codigo';
end;

function TRepositorioItemNotaFiscal.SQLRemover: String;
begin
   result := 'delete from '+self.GetNomeDaTabela+' where codigo = :codigo';
end;

function TRepositorioItemNotaFiscal.SQLSalvar: String;
begin
   result := ' update or insert into ' + self.GetNomeDaTabela +
             '        (codigo,  codigo_nota_fiscal, codigo_produto, codigo_natureza, quantidade, valor_unitario)     '+
             ' values (:codigo, :codigo_nota_fiscal, :codigo_produto, :codigo_natureza, :quantidade, :valor_unitario) ';
end;

end.
