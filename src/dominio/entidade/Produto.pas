unit Produto;

interface

uses
  SysUtils,
  Contnrs, NcmIBPT;

type
  TProduto = class

  private
    Fcodigo_grupo: integer;
    Fcodigo: integer;
    Fvalor: Real;
    Fativo: String;
    Fdescricao: String;
    FListaMaterias :TObjectList;
    Fcodigo_departamento: Integer;
    Fcodigo_ibpt: integer;
    FNcmIBPT: TNcmIBPT;
    FTipo :String;
    Ficms :REal;
    FTributacao :String;
    FPreparo    :String;
    FPreco_custo :Real;
    FAlteraPreco: String;

    function GetListaMaterias: TobjectList;
    function GetNcmIBPT :TNcmIBPT;                                      
    function GetIcmsParaECF :String;

    procedure SetNcmIBPT(const Value: TNcmIBPT);

  public
    property codigo              :integer read Fcodigo              write Fcodigo;
    property codigo_grupo        :integer read Fcodigo_grupo        write Fcodigo_grupo;
    property descricao           :String  read Fdescricao           write Fdescricao;
    property valor               :Real    read Fvalor               write Fvalor;
    property ativo               :String  read Fativo               write Fativo;
    property codigo_departamento :Integer read Fcodigo_departamento write Fcodigo_departamento;
    property codigo_ibpt         :integer read Fcodigo_ibpt         write Fcodigo_ibpt;
    property tipo                :String  read FTipo                write FTipo;
    property icms                :Real    read FIcms                write FIcms;
    property tributacao          :String  read FTributacao          write FTributacao;
    property icmsParaECF         :String  read GetIcmsParaECF;
    property preparo             :String  read FPreparo             write FPreparo;
    property preco_custo         :Real    read FPreco_custo         write FPreco_custo;
    property altera_preco        :String  read FAlteraPreco         write FAlteraPreco;

    property NcmIBPT             :TNcmIBPT read GetNcmIBPT write SetNcmIBPT;

    property ListaMaterias       :TobjectList read GetListaMaterias;

end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoMateriasDoProduto, ProdutoHasMateria;

{ TProduto }

function TProduto.GetIcmsParaECF: String;
begin
  result := self.tributacao;

  if (Result[1] in ['T','S']) and (length(Result) = 1) then
    Result := FloatToStr(self.icms) + Result;
end;

function TProduto.GetListaMaterias: TobjectList;
var
  Repositorio   :TRepositorio;
  Especificacao :TEspecificacaoMateriasDoProduto;
begin
   Repositorio    := nil;
   Especificacao  := nil;
   
   try
      if not Assigned(self.FListaMaterias) then begin
        Especificacao         := TEspecificacaoMateriasDoProduto.Create(self.Fcodigo);
        Repositorio           := TFabricaRepositorio.GetRepositorio(TProdutoHasMateria.ClassName);
        self.FListaMaterias   := Repositorio.GetListaPorEspecificacao(Especificacao);
      end;

      result := self.FListaMaterias;
   finally
     FreeAndNil(Especificacao);
     FreeAndNil(Repositorio);
   end;
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
 