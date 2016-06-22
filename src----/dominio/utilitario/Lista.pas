unit Lista;

interface

uses
  Objeto,
  Especificacao,
  Contnrs,
  MetodoDelegadoSomarCampoEspecificoReal,
  MetodoDelegadoSomarCampoEspecificoInteger;

type
  TLista = class(TObjectList)

  private
    FListaObjetos :TObjectList;

  protected
    function GetItem (Index: Integer): TObjeto;

  protected
    procedure SetItem(Index: Integer; AObject: TObjeto);
    procedure SetListaObjetos(Lista :TObjectList);

  public
    function Add     (AObject: TObjeto) :Integer; 
    function Extract (Item   : TObjeto) :TObjeto;
    function Get     (Especificacao :TEspecificacao) :TObjeto; 
    function Remove  (AObject: TObjeto) :Integer;
    function IndexOf (AObject: TObjeto)                                       :Integer; overload;
    function IndexOf (Especificacao: TEspecificacao)                          :Integer; overload;
    function First                                                            :TObjeto;
    function Last                                                             :TObjeto;
    function Contains(AObject: TObjeto)                                       :Boolean; overload;
    function Contains(Especificacao :TEspecificacao)                          :Integer; overload;
    function Sum     (MetodoQueSoma: TMetodoDelegadoSomarCampoEspecificoReal)    :Real;    overload;
    function Sum     (MetodoQueSoma: TMetodoDelegadoSomarCampoEspecificoInteger) :Integer; overload;

  public
    property Items[Index: Integer]: TObjeto read GetItem write SetItem;
    property ListaObjetos :TObjectList write SetListaObjetos;
end;

implementation

uses Classes, Math;

{ TLista }

function TLista.Add(AObject: TObjeto): Integer;
begin
   result := inherited Add(AObject);
end;

function TLista.Contains(AObject: TObjeto): Boolean;
begin
   result := (self.IndexOf(AObject) >= 0); 
end;

function TLista.Contains(Especificacao: TEspecificacao): Integer;
begin
   result := self.IndexOf(Especificacao);
end;

function TLista.Extract(Item: TObjeto): TObjeto;
begin
   result := TObjeto(inherited Extract(Item));
end;

function TLista.First: TObjeto;
begin
   result := TObjeto(inherited First);
end;

function TLista.GetItem(Index: Integer): TObjeto;
begin
   result := TObjeto(inherited GetItem(Index));  
end;

function TLista.IndexOf(AObject: TObjeto): Integer;
var
  nX  :Integer;
begin
   result := -1;

   for nX := 0 to (self.Count-1) do begin
      if AObject.Equals(self.Items[nX]) then begin
        result := nX;
        exit;
      end;
   end;
end;

function TLista.Get(Especificacao: TEspecificacao): TObjeto;
var
  Indice :Integer;
begin
   result := nil;
   Indice := self.IndexOf(Especificacao);

   if (Indice >= 0) then
    result := self.Items[Indice]; 
end;

function TLista.IndexOf(Especificacao: TEspecificacao): Integer;
var
  nX :Integer;
begin
   result := -1;
   
   for nX := 0 to (self.Count-1) do begin
     if Especificacao.SatisfeitoPor(self.Items[nX]) then begin
       result := nX;
       exit;
     end;
   end;
end;

function TLista.Last: TObjeto;
begin
   result := TObjeto(inherited Last);
end;

function TLista.Remove(AObject: TObjeto): Integer;
begin
   result := self.IndexOf(AObject);
   self.Delete(result);
end;

procedure TLista.SetItem(Index: Integer; AObject: TObjeto);
begin
   inherited SetItem(Index, AObject);
end;

function TLista.Sum(
  MetodoQueSoma: TMetodoDelegadoSomarCampoEspecificoReal): Real;
var
  nX :Integer;
begin
   if not Assigned(MetodoQueSoma) then
    raise EInvalidArgument.Create('MetodoQueSoma');

   result := 0;

   for nX := 0 to (self.Count-1) do begin
      result := MetodoQueSoma(result, self.Items[nX]);
   end;
end;

function TLista.Sum(
  MetodoQueSoma: TMetodoDelegadoSomarCampoEspecificoInteger): Integer;
var
  nX :Integer;
begin
   if not Assigned(MetodoQueSoma) then
    raise EInvalidArgument.Create('MetodoQueSoma');

   result := 0;

   for nX := 0 to (self.Count-1) do begin
      result := MetodoQueSoma(result, self.Items[nX]);
   end;
end;

procedure TLista.SetListaObjetos(Lista: TObjectList);
var i :integer;
begin
  for i := 0 to Lista.Count - 1 do
    self.Add((Lista[i] as TObjeto));
end;

end.
