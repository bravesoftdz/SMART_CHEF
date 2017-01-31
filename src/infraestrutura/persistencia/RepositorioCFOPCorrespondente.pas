unit RepositorioCFOPCorrespondente;

interface
                                                                                          
uses DB,
     Auditoria,
     Repositorio;                                       
type
  TRepositorioCFOPCorrespondente = class(TRepositorio)                      
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
  CFOPCorrespondente;                                                                        

{ TRepositorioCFOPCorrespondente }                                                      

function TRepositorioCFOPCorrespondente.Get(Dataset: TDataSet): TObject;                  
var                                                                                                
  CFOPCorrespondente :TCFOPCorrespondente;                                                 
begin                                                                                              
   CFOPCorrespondente                    := TCFOPCorrespondente.Create;
   CFOPCorrespondente.CODIGO             := self.FQuery.FieldByName('CODIGO'  ).AsInteger;
   CFOPCorrespondente.COD_CFOP_SAIDA     := self.FQuery.FieldByName('COD_CFOP_SAIDA'  ).AsInteger;
   CFOPCorrespondente.COD_CFOP_ENTRADA   := self.FQuery.FieldByName('COD_CFOP_ENTRADA'  ).AsInteger;
   CFOPCorrespondente.cfop_saida         := self.FQuery.FieldByName('CFOP_SAIDA').AsString;
   CFOPCorrespondente.cfop_entrada       := self.FQuery.FieldByName('CFOP_ENTRADA').AsString;
   result := CFOPCorrespondente;
end;                                                                                               

function TRepositorioCFOPCorrespondente.GetIdentificador(Objeto: TObject): Variant;       
begin                                                                                              
  result := TCFOPCorrespondente(Objeto).Codigo;                                                 
end;                                                                                               

function TRepositorioCFOPCorrespondente.GetNomeDaTabela: String;                          
begin                                                                                              
result := 'CFOP_CORRESPONDENTE';                                                                          
end;                                                                                               

function TRepositorioCFOPCorrespondente.GetRepositorio: TRepositorio;                     
begin                                                                                              
result := TRepositorioCFOPCorrespondente.Create;                                          
end;                                                                                               

function TRepositorioCFOPCorrespondente.IsInsercao(Objeto: TObject): Boolean;             
begin                                                                                              
  result := (TCFOPCorrespondente(Objeto).Codigo <= 0);                                         
end;                                                                                               

procedure TRepositorioCFOPCorrespondente.SetCamposAlterados(Auditoria: TAuditoria;        
  AntigoObjeto, Objeto: TObject);                                                                  
var                                                                                                
  CFOPCorrespondenteAntigo :TCFOPCorrespondente;                                           
  CFOPCorrespondenteNovo   :TCFOPCorrespondente;                                           
begin                                                                                              
   CFOPCorrespondenteAntigo := (AntigoObjeto as TCFOPCorrespondente);                      
   CFOPCorrespondenteNovo   := (Objeto       as TCFOPCorrespondente);                      

   if (CFOPCorrespondenteAntigo.COD_CFOP_SAIDA <> CFOPCorrespondenteNovo.COD_CFOP_SAIDA) then
   Auditoria.AdicionaCampoAlterado('COD_CFOP_SAIDA', intToStr(CFOPCorrespondenteAntigo.COD_CFOP_SAIDA), intToStr(CFOPCorrespondenteNovo.COD_CFOP_SAIDA));

   if (CFOPCorrespondenteAntigo.COD_CFOP_ENTRADA <> CFOPCorrespondenteNovo.COD_CFOP_ENTRADA) then
   Auditoria.AdicionaCampoAlterado('COD_CFOP_ENTRADA', intToStr(CFOPCorrespondenteAntigo.COD_CFOP_ENTRADA), intToStr(CFOPCorrespondenteNovo.COD_CFOP_ENTRADA));


end;                                                                                               

procedure TRepositorioCFOPCorrespondente.SetCamposExcluidos(Auditoria: TAuditoria;        
  Objeto: TObject);                                                                                
var                                                                                                
  CFOPCorrespondente :TCFOPCorrespondente;                                                 
begin                                                                                              
   CFOPCorrespondente := (Objeto as TCFOPCorrespondente);                                  

   Auditoria.AdicionaCampoExcluido('CODIGO' , intToStr(CFOPCorrespondente.CODIGO));
   Auditoria.AdicionaCampoExcluido('COD_CFOP_SAIDA' , intToStr(CFOPCorrespondente.COD_CFOP_SAIDA));
   Auditoria.AdicionaCampoExcluido('COD_CFOP_ENTRADA' , intToStr(CFOPCorrespondente.COD_CFOP_ENTRADA));

end;                                                                                               

procedure TRepositorioCFOPCorrespondente.SetCamposIncluidos(Auditoria: TAuditoria;        
  Objeto: TObject);                                                                                
var                                                                                                
  CFOPCorrespondente :TCFOPCorrespondente;                                                 
begin                                                                                              
   CFOPCorrespondente := (Objeto as TCFOPCorrespondente);                                  

   Auditoria.AdicionaCampoIncluido('CODIGO' , intToStr(CFOPCorrespondente.CODIGO));
   Auditoria.AdicionaCampoIncluido('COD_CFOP_SAIDA' , intToStr(CFOPCorrespondente.COD_CFOP_SAIDA));
   Auditoria.AdicionaCampoIncluido('COD_CFOP_ENTRADA' , intToStr(CFOPCorrespondente.COD_CFOP_ENTRADA));

end;                                                                                               

procedure TRepositorioCFOPCorrespondente.SetIdentificador(Objeto: TObject;                
  Identificador: Variant);                                                                         
begin                                                                                              
  TCFOPCorrespondente(Objeto).Codigo := Integer(Identificador);                                
end;                                                                                               

procedure TRepositorioCFOPCorrespondente.SetParametros(Objeto: TObject);                  
var                                                                                                
  CFOPCorrespondente :TCFOPCorrespondente;                                                 
begin                                                                                              
   CFOPCorrespondente := (Objeto as TCFOPCorrespondente);                                  
  if (CFOPCorrespondente.Codigo > 0) then  inherited SetParametro('codigo', CFOPCorrespondente.Codigo) 
  else                         inherited LimpaParametro('codigo');                     

   self.FQuery.ParamByName('CODIGO').AsInteger            := CFOPCorrespondente.CODIGO;
   self.FQuery.ParamByName('COD_CFOP_SAIDA').AsInteger    := CFOPCorrespondente.COD_CFOP_SAIDA;
   self.FQuery.ParamByName('COD_CFOP_ENTRADA').AsInteger  := CFOPCorrespondente.COD_CFOP_ENTRADA;
 {  self.FQuery.ParamByName('CFOP_SAIDA').AsString         := CFOPCorrespondente.cfop_saida;
   self.FQuery.ParamByName('CFOP_ENTRADA').AsString       := CFOPCorrespondente.cfop_entrada; }

end;                                                                                               

function TRepositorioCFOPCorrespondente.SQLGet: String;                                   
begin                                                                                              
  result := 'select cc.*, n_s.cfop CFOP_SAIDA, n_e.cfop CFOP_ENTRADA from CFOP_CORRESPONDENTE cc '+
            ' left join naturezas_operacao n_s  on  (n_s.CODIGO = cc.COD_CFOP_SAIDA)             '+
            ' left join naturezas_operacao n_e  on  (n_e.CODIGO = cc.COD_CFOP_ENTRADA)           '+
            'where cc.codigo = :ncod                                                             ';
end;                                                                                               

function TRepositorioCFOPCorrespondente.SQLGetAll: String;                                
begin                                                                                              
  result := 'select cc.*, n_s.cfop CFOP_SAIDA, n_e.cfop CFOP_ENTRADA from CFOP_CORRESPONDENTE cc '+
            ' left join naturezas_operacao n_s  on  (n_s.CODIGO = cc.COD_CFOP_SAIDA)             '+
            ' left join naturezas_operacao n_e  on  (n_e.CODIGO = cc.COD_CFOP_ENTRADA)           ';
end;                                                                                               

function TRepositorioCFOPCorrespondente.SQLGetExiste(campo: String): String;              
begin                                                                                              
  result := 'select '+ campo +' from CFOP_CORRESPONDENTE where '+ campo +' = :ncampo';                
end;                                                                                               

function TRepositorioCFOPCorrespondente.SQLRemover: String;                               
begin                                                                                              
   result := ' delete from CFOP_CORRESPONDENTE where codigo = :codigo ';                                  
end;                                                                                               

function TRepositorioCFOPCorrespondente.SQLSalvar: String;                                
begin                                                                                              
  result := 'update or insert into CFOP_CORRESPONDENTE              '+
            ' ( CODIGO, COD_CFOP_SAIDA, COD_CFOP_ENTRADA)           '+
            ' Values ( :CODIGO, :COD_CFOP_SAIDA, :COD_CFOP_ENTRADA) ';
end;                                                                                               

end.                                                                                               
