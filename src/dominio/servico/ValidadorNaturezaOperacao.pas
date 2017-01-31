unit ValidadorNaturezaOperacao;

interface

uses
  NaturezaOperacao;

type
  TValidadorNaturezaOperacao = class

  private
    FNaturezaQueVaiSerValidada      :TNaturezaOperacao;
    FNaturezaOperacaoEncontradaNoBD :TNaturezaOperacao;

  private
    procedure ValidarNovaNaturezaOperacao       (NovaNaturezaOperacao        :TNaturezaOperacao);
    procedure ValidarNaturezaOperacaoEmAlteracao(NaturezaOperacaoEmAlteracao :TNaturezaOperacao);

  public
    constructor Create(NaturezaQueVaiSerValidada :TNaturezaOperacao; NaturezaOperacaoEncontradaNoBD :TNaturezaOperacao);

  public
    procedure ValidarCFOP;
end;

implementation

uses
  ExcecaoCFOPDuplicada, ExcecaoCFOPInvalida;

{ TValidadorNaturezaOperacao }

constructor TValidadorNaturezaOperacao.Create(NaturezaQueVaiSerValidada :TNaturezaOperacao; NaturezaOperacaoEncontradaNoBD :TNaturezaOperacao);
begin
   self.FNaturezaQueVaiSerValidada      := NaturezaQueVaiSerValidada;
   self.FNaturezaOperacaoEncontradaNoBD := NaturezaOperacaoEncontradaNoBD;
end;

procedure TValidadorNaturezaOperacao.ValidarCFOP;
begin
   if (Length(self.FNaturezaQueVaiSerValidada.CFOP) <> 4) or
      (not (self.FNaturezaQueVaiSerValidada.CFOP[1] in ['1', '2', '3', '5', '6', '7'])) then
      raise TExcecaoCFOPInvalida.Create;

   if (self.FNaturezaQueVaiSerValidada.Codigo > 0) then
    self.ValidarNaturezaOperacaoEmAlteracao(self.FNaturezaQueVaiSerValidada)
   else
    self.ValidarNovaNaturezaOperacao(self.FNaturezaQueVaiSerValidada);
end;

procedure TValidadorNaturezaOperacao.ValidarNaturezaOperacaoEmAlteracao(
  NaturezaOperacaoEmAlteracao: TNaturezaOperacao);
begin
   if not Assigned(self.FNaturezaOperacaoEncontradaNoBD) then exit;
   
   if (self.FNaturezaOperacaoEncontradaNoBD.Codigo <> NaturezaOperacaoEmAlteracao.Codigo) and
      (self.FNaturezaOperacaoEncontradaNoBD.CFOP   =  NaturezaOperacaoEmAlteracao.CFOP)       then
     raise TExcecaoCFOPDuplicada.Create;
end;

procedure TValidadorNaturezaOperacao.ValidarNovaNaturezaOperacao(
  NovaNaturezaOperacao: TNaturezaOperacao);
begin
   if not Assigned(self.FNaturezaOperacaoEncontradaNoBD) then exit;

   if (self.FNaturezaOperacaoEncontradaNoBD.CFOP = NovaNaturezaOperacao.CFOP) then
     raise TExcecaoCFOPDuplicada.Create;
end;

end.
