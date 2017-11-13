unit Produto;

interface

uses
  SysUtils,
  Contnrs, NcmIBPT, Estoque, Generics.Collections;

type
  TProduto = class

  private
    Fcodigo_grupo: integer;
    Fcodigo: integer;
    Fvalor: Real;
    Fativo: Boolean;
    Fdescricao: String;
    Fcodigo_departamento: Integer;
    Fcodigo_ibpt: integer;
    FNcmIBPT: TNcmIBPT;
    FTipo :String;
    Ficms :Real;
    FTributacao :String;
    FPreparo    :String;
    FPreco_custo :Real;
    FAlteraPreco: String;
    Fcodbar: String;
    FCodigo_balanca: String;
    FEstoque :TEstoque;
    FReferencia: String;
    FAgranel: Boolean;


    function GetNcmIBPT :TNcmIBPT;                                      
    function GetIcmsParaECF :String;

    procedure SetNcmIBPT(const Value: TNcmIBPT);
    function GetEstoque: TEstoque;

  public
    property codigo              :integer read Fcodigo              write Fcodigo;
    property codigo_grupo        :integer read Fcodigo_grupo        write Fcodigo_grupo;
    property descricao           :String  read Fdescricao           write Fdescricao;
    property valor               :Real    read Fvalor               write Fvalor;
    property ativo               :Boolean read Fativo               write Fativo;
    property codigo_departamento :Integer read Fcodigo_departamento write Fcodigo_departamento;
    property codigo_ibpt         :integer read Fcodigo_ibpt         write Fcodigo_ibpt;
    property tipo                :String  read FTipo                write FTipo;
    property icms                :Real    read FIcms                write FIcms;
    property tributacao          :String  read FTributacao          write FTributacao;
    property icmsParaECF         :String  read GetIcmsParaECF;
    property preparo             :String  read FPreparo             write FPreparo;
    property preco_custo         :Real    read FPreco_custo         write FPreco_custo;
    property altera_preco        :String  read FAlteraPreco         write FAlteraPreco;
    property codbar              :String  read Fcodbar              write Fcodbar;
    property referencia          :String  read FReferencia          write FReferencia;
    property codigo_balanca      :String  read FCodigo_balanca      write FCodigo_balanca;
    property agranel             :Boolean read FAgranel             write FAgranel;

    property NcmIBPT             :TNcmIBPT read GetNcmIBPT write SetNcmIBPT;

    property Estoque             :TEstoque read GetEstoque write FEstoque;

end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoMateriasDoProduto, EspecificacaoEstoquePorProduto, funcoes;

{ TProduto }

function TProduto.GetEstoque: TEstoque;
var //Especificacao :TEspecificacaoEstoquePorProduto;
    Repositorio   :TRepositorio;
begin
 try
   Repositorio   := nil;
 //  Especificacao := nil;

   if not assigned(FEstoque) then
   begin
   //  Especificacao  := TEspecificacaoEstoquePorProduto.Create(self.codigo);
     Repositorio    := TFabricaRepositorio.GetRepositorio(TEstoque.ClassName);
     FEstoque       := TEstoque( repositorio.Get( strToIntDef(Campo_por_campo('ESTOQUE','CODIGO','CODIGO_PRODUTO',inttostr(self.codigo)),0)));
   end;

   result := FEstoque;
 finally
   FreeAndNil(Repositorio);
 //  FreeAndNil(Especificacao);
 end;
end;

function TProduto.GetIcmsParaECF: String;
begin
  result := self.tributacao;

  if (Result[1] in ['T','S']) and (length(Result) = 1) then
    Result := FloatToStr(self.icms) + Result;
end;

function TProduto.GetNcmIBPT: TNcmIBPT;
var
  Repositorio   :TRepositorio;
begin
   Repositorio    := nil;

   {serviço nao tributa imposto}
  // if self.tipo = 'S' then exit;
   
   try
      if not Assigned(self.FNcmIBPT) then begin
        Repositorio           := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
        self.FNcmIBPT         := TNcmIBPT( Repositorio.Get(self.Fcodigo_ibpt) );
      end;

      result := self.FNcmIBPT;
   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TProduto.SetNcmIBPT(const Value: TNcmIBPT);
begin
  FNcmIBPT := Value;
end;

end.
 