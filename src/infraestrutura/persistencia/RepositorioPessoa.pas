unit RepositorioPessoa;

interface

uses
  DB,
  Auditoria,
  Repositorio;

type
  TRepositorioPessoa = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;    
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

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
  Pessoa, StrUtils, Endereco, FabricaRepositorio;

{ TRepositorioPessoa }

function TRepositorioPessoa.CondicaoSQLGetAll: String;
begin
  result := ' WHERE CPF_CNPJ = '''+FIdentificador+'''';
end;

procedure TRepositorioPessoa.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  Pessoa                :TPessoa;
  RepositorioEndereco   :TRepositorio;
  Endereco              :TEndereco;
begin
   Pessoa := (Objeto as TPessoa);
   try
     RepositorioEndereco := nil;

     if Assigned(Pessoa.Enderecos) and (Pessoa.Enderecos.Count > 0) then
     begin
       for Endereco in Pessoa.Enderecos do
       begin
         Endereco.codigo_pessoa  := Pessoa.codigo;
         RepositorioEndereco     := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
         RepositorioEndereco.Salvar(Endereco);
       end;
     end;

   finally
     FreeAndNil(RepositorioEndereco);
   end;
end;

function TRepositorioPessoa.Get(Dataset: TDataSet): TObject;
var
  Pessoa :TPessoa;
begin
   Pessoa              := TPessoa.Create;
   Pessoa.Codigo       := self.FQuery.FieldByName('codigo'    ).AsInteger;
   Pessoa.Razao        := self.FQuery.FieldByName('razao'     ).AsString;
   Pessoa.NomeFantasia := self.FQuery.FieldByName('nome_fantasia').AsString;
   Pessoa.Pessoa       := self.FQuery.FieldByName('pessoa'    ).AsString;
   Pessoa.Tipo         := self.FQuery.FieldByName('tipo'      ).AsString;
   Pessoa.CPF_CNPJ     := self.FQuery.FieldByName('cpf_cnpj'  ).AsString;
   Pessoa.RG_IE        := self.FQuery.FieldByName('rg_ie'     ).AsString;
   Pessoa.DtCadastro   := self.FQuery.FieldByName('DtCadastro').AsDateTime;
   Pessoa.Fone1        := self.FQuery.FieldByName('fone1'     ).AsString;
   Pessoa.Fone2        := self.FQuery.FieldByName('fone2'     ).AsString;
   Pessoa.Fax          := self.FQuery.FieldByName('fax'       ).AsString;
   Pessoa.Email        := self.FQuery.FieldByName('email'     ).AsString;
   Pessoa.Observacao   := self.FQuery.FieldByName('observacao').AsString;
   Pessoa.Bloqueado    := self.FQuery.FieldByName('Bloqueado').AsString;
   Pessoa.MotivoBloq   := self.FQuery.FieldByName('Motivo_Bloq').AsString;

   result := Pessoa;
end;

function TRepositorioPessoa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TPessoa(Objeto).Codigo;
end;

function TRepositorioPessoa.GetNomeDaTabela: String;
begin
  result := 'PESSOAS';
end;

function TRepositorioPessoa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioPessoa.Create;
end;

function TRepositorioPessoa.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TPessoa(Objeto).Codigo <= 0);
end;

procedure TRepositorioPessoa.SetCamposAlterados(Auditoria: TAuditoria;
  AntigoObjeto, Objeto: TObject);
var
  PessoaAntigo :TPessoa;
  PessoaNovo   :TPessoa;
begin
   PessoaAntigo := (AntigoObjeto as TPessoa);
   PessoaNovo   := (Objeto       as TPessoa);

   if (PessoaAntigo.Razao <> PessoaNovo.Razao) then
    Auditoria.AdicionaCampoAlterado('razao', PessoaAntigo.Razao, PessoaNovo.Razao);

   if (PessoaAntigo.Pessoa <> PessoaNovo.Pessoa) then
    Auditoria.AdicionaCampoAlterado('pessoa', PessoaAntigo.Pessoa, PessoaNovo.Pessoa);

   if (PessoaAntigo.Tipo <> PessoaNovo.Tipo) then
    Auditoria.AdicionaCampoAlterado('tipo', PessoaAntigo.Tipo, PessoaNovo.Tipo);
                                                                                           
   if (PessoaAntigo.CPF_CNPJ <> PessoaNovo.CPF_CNPJ) then
    Auditoria.AdicionaCampoAlterado('cpf_cnpj', PessoaAntigo.CPF_CNPJ, PessoaNovo.CPF_CNPJ);
                                                                                           
   if (PessoaAntigo.RG_IE <> PessoaNovo.RG_IE) then
    Auditoria.AdicionaCampoAlterado('rg_ie', PessoaAntigo.RG_IE, PessoaNovo.RG_IE);
                                                                                           
   if (PessoaAntigo.DtCadastro <> PessoaNovo.DtCadastro) then
    Auditoria.AdicionaCampoAlterado('DtCadastro', DateToStr(PessoaAntigo.DtCadastro), DateToStr(PessoaNovo.DtCadastro));

   if (PessoaAntigo.Fone1 <> PessoaNovo.Fone1) then
    Auditoria.AdicionaCampoAlterado('fone1', PessoaAntigo.Fone1, PessoaNovo.Fone1);

   if (PessoaAntigo.Fone2 <> PessoaNovo.Fone2) then
    Auditoria.AdicionaCampoAlterado('fone2', PessoaAntigo.Fone2, PessoaNovo.Fone2);

   if (PessoaAntigo.Fax <> PessoaNovo.Fax) then
    Auditoria.AdicionaCampoAlterado('fax', PessoaAntigo.Fax, PessoaNovo.Fax);

   if (PessoaAntigo.Email <> PessoaNovo.Email) then
    Auditoria.AdicionaCampoAlterado('email', PessoaAntigo.Email, PessoaNovo.Email);

   if (PessoaAntigo.Observacao <> PessoaNovo.Observacao) then
    Auditoria.AdicionaCampoAlterado('observacao', PessoaAntigo.Observacao, PessoaNovo.Observacao);

   if (PessoaAntigo.Bloqueado <> PessoaNovo.Bloqueado) then
    Auditoria.AdicionaCampoAlterado('Bloqueado', PessoaAntigo.Bloqueado, PessoaNovo.Bloqueado);

   if (PessoaAntigo.MotivoBloq <> PessoaNovo.MotivoBloq) then
    Auditoria.AdicionaCampoAlterado('Motivo_Bloq', PessoaAntigo.MotivoBloq, PessoaNovo.MotivoBloq);

   if (PessoaAntigo.NomeFantasia <> PessoaNovo.NomeFantasia) then
    Auditoria.AdicionaCampoAlterado('nome_fantasia', PessoaAntigo.NomeFantasia, PessoaNovo.NomeFantasia);
end;

procedure TRepositorioPessoa.SetCamposExcluidos(Auditoria: TAuditoria;
  Objeto: TObject);
var
  Pessoa :TPessoa;
begin
   Pessoa := (Objeto as TPessoa);

   Auditoria.AdicionaCampoExcluido('codigo'    , intToStr(Pessoa.Codigo));
   Auditoria.AdicionaCampoExcluido('razao'     , Pessoa.Razao);
   Auditoria.AdicionaCampoExcluido('nome_fantasia' , Pessoa.Razao);
   Auditoria.AdicionaCampoExcluido('pessoa'    , Pessoa.Pessoa);
   Auditoria.AdicionaCampoExcluido('tipo'      , Pessoa.Tipo);   
   Auditoria.AdicionaCampoExcluido('cpf_cnpj'  , Pessoa.CPF_CNPJ);
   Auditoria.AdicionaCampoExcluido('rg_ie'     , Pessoa.RG_IE);
   Auditoria.AdicionaCampoExcluido('DtCadastro', DateToStr(Pessoa.DtCadastro));
   Auditoria.AdicionaCampoExcluido('fone1'     , Pessoa.Fone1);
   Auditoria.AdicionaCampoExcluido('fone2'     , Pessoa.Fone2);
   Auditoria.AdicionaCampoExcluido('fax'       , Pessoa.Fax);
   Auditoria.AdicionaCampoExcluido('email'     , Pessoa.Email);
   Auditoria.AdicionaCampoExcluido('observacao', Pessoa.Observacao);
   Auditoria.AdicionaCampoExcluido('Bloqueado' , Pessoa.Bloqueado);
   Auditoria.AdicionaCampoExcluido('Motivo_Bloq', Pessoa.MotivoBloq);
   Auditoria.AdicionaCampoExcluido('nome_fantasia' , Pessoa.NomeFantasia);
end;

procedure TRepositorioPessoa.SetCamposIncluidos(Auditoria: TAuditoria;
  Objeto: TObject);
var
  Pessoa :TPessoa;
begin
   Pessoa := (Objeto as TPessoa);

   Auditoria.AdicionaCampoIncluido('codigo'    , intToStr(Pessoa.Codigo));
   Auditoria.AdicionaCampoIncluido('razao'     , Pessoa.Razao);
   Auditoria.AdicionaCampoIncluido('nome_fantasia' , Pessoa.Razao);
   Auditoria.AdicionaCampoIncluido('pessoa'    , Pessoa.Pessoa);
   Auditoria.AdicionaCampoIncluido('tipo'      , Pessoa.Tipo);   
   Auditoria.AdicionaCampoIncluido('cpf_cnpj'  , Pessoa.CPF_CNPJ);
   Auditoria.AdicionaCampoIncluido('rg_ie'     , Pessoa.RG_IE);
   Auditoria.AdicionaCampoIncluido('DtCadastro', DateToStr(Pessoa.DtCadastro));
   Auditoria.AdicionaCampoIncluido('fone1'     , Pessoa.Fone1);
   Auditoria.AdicionaCampoIncluido('fone2'     , Pessoa.Fone2);
   Auditoria.AdicionaCampoIncluido('fax'       , Pessoa.Fax);
   Auditoria.AdicionaCampoIncluido('email'     , Pessoa.Email);
   Auditoria.AdicionaCampoIncluido('observacao', Pessoa.Observacao);
   Auditoria.AdicionaCampoIncluido('Bloqueado' , Pessoa.Bloqueado);
   Auditoria.AdicionaCampoIncluido('Motivo_Bloq', Pessoa.MotivoBloq);
   Auditoria.AdicionaCampoIncluido('nome_fantasia' , Pessoa.NomeFantasia);
end;

procedure TRepositorioPessoa.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
  TPessoa(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioPessoa.SetParametros(Objeto: TObject);
var
  Pessoa :TPessoa;
begin
   Pessoa := (Objeto as TPessoa);

   if (Pessoa.Codigo > 0) then  inherited SetParametro('codigo', Pessoa.Codigo)
   else                         inherited LimpaParametro('codigo');

   self.FQuery.ParamByName('razao').AsString        := Pessoa.Razao;
   self.FQuery.ParamByName('nome_fantasia').AsString       := Pessoa.NomeFantasia;
   self.FQuery.ParamByName('pessoa').AsString       := Pessoa.Pessoa;
   self.FQuery.ParamByName('tipo').AsString         := Pessoa.Tipo;
   self.FQuery.ParamByName('cpf_cnpj').AsString     := Pessoa.CPF_CNPJ;
   self.FQuery.ParamByName('rg_ie').AsString        := Pessoa.RG_IE;
   self.FQuery.ParamByName('DtCadastro').AsDateTime := Pessoa.DtCadastro;
   self.FQuery.ParamByName('fone1').AsString        := Pessoa.Fone1;
   self.FQuery.ParamByName('fone2').AsString        := Pessoa.Fone2;
   self.FQuery.ParamByName('fax').AsString          := Pessoa.Fax;
   self.FQuery.ParamByName('email').AsString        := Pessoa.Email;
   self.FQuery.ParamByName('observacao').AsString   := Pessoa.Observacao;
   self.FQuery.ParamByName('bloqueado').AsString    := Pessoa.bloqueado;
   self.FQuery.ParamByName('motivo_bloq').AsString  := Pessoa.MotivoBloq;
   self.FQuery.ParamByName('nome_fantasia').AsString := Pessoa.NomeFantasia;
end;

function TRepositorioPessoa.SQLGet: String;
begin
  result := 'select * from Pessoas where codigo = :ncod';
end;

function TRepositorioPessoa.SQLGetAll: String;
begin
  result := 'select * from Pessoas '+ IfThen(FIdentificador = '','', CondicaoSQLGetAll);
end;

function TRepositorioPessoa.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from Pessoas where '+ campo +' = :ncampo';
end;

function TRepositorioPessoa.SQLRemover: String;
begin
   result := ' delete from Pessoas where codigo = :codigo ';
end;

function TRepositorioPessoa.SQLSalvar: String;
begin
  result := 'update or insert into Pessoas                                                                                        '+
            '(codigo, razao, pessoa, tipo, cpf_cnpj, rg_ie, dtCadastro, fone1, fone2, fax, email, observacao, bloqueado, motivo_bloq, nome_fantasia)                     '+
            ' Values (:codigo, :razao, :pessoa, :tipo, :cpf_cnpj, :rg_ie, :dtCadastro, :fone1, :fone2, :fax, :email, :observacao, :bloqueado, :motivo_bloq, :nome_fantasia) ';
end;

end.
              
              
              
              
              
              
              
              
