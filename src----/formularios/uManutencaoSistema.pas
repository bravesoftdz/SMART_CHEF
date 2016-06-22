unit uManutencaoSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, frameHorario;

type
  TfrmManutencaoSistema = class(TfrmPadrao)
    gbOpcoes: TGroupBox;
    btnRealizarManutencao: TBitBtn;
    btnCancelar: TBitBtn;
    lblUsuarioResponsavel: TLabel;
    lblTerminalResponsavel: TLabel;
    horarioDeInicio: THorario;
    horarioDeTermino: THorario;
    
  private
    procedure DefineEventos;

    procedure CarregarDados       (Sender :TObject);
    procedure RealizarManutencao  (Sender :TObject);
    procedure Cancelar            (Sender :TObject);

  public
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmManutencaoSistema: TfrmManutencaoSistema;

implementation

uses
  Repositorio,
  ManutencaoSistema,
  FabricaRepositorio;

{$R *.dfm}

{ TfrmManutencaoSistema }

procedure TfrmManutencaoSistema.Cancelar(Sender: TObject);
begin
   self.Close;
end;

procedure TfrmManutencaoSistema.CarregarDados(Sender: TObject);
begin
   self.lblUsuarioResponsavel.Caption  := self.lblUsuarioResponsavel.Caption  + self.Fdm.UsuarioLogado.Nome;
   self.lblTerminalResponsavel.Caption := self.lblTerminalResponsavel.Caption + self.Fdm.NomeDoTerminal;
   self.horarioDeInicio.Horario        := TRepositorio.HorarioBancoDeDados;
   self.horarioDeTermino.Horario       := self.horarioDeInicio.Horario +  StrToDateTime('00:03:00');
end;

constructor TfrmManutencaoSistema.Create(AOwner: TComponent);
begin
   inherited;

   self.DefineEventos;
end;

procedure TfrmManutencaoSistema.DefineEventos;
begin
   self.OnShow                        := self.CarregarDados;
   self.btnCancelar.OnClick           := self.Cancelar;
   self.btnRealizarManutencao.OnClick := self.RealizarManutencao;
end;

procedure TfrmManutencaoSistema.RealizarManutencao(Sender: TObject);
var
  Manutencao  :TManutencaoSistema;
  Repositorio :TRepositorio;
begin
   if not inherited Confirma('ESSE PROCEDIMENTO SÓ DEVE SER EXECUTADO NO TERMINAL DE BANCO DE DADOS! Deseja realmente realizar a manutenção do sistema?') then
    exit;

   Repositorio := TFabricaRepositorio.GetRepositorio(TManutencaoSistema.ClassName);
   Manutencao  := nil; 

   try
     try
       Manutencao := TManutencaoSistema(Repositorio.Get(0));

       if Assigned(Manutencao) then
        raise Exception.Create('O sistema já se encontra em manutenção!');

       Manutencao := TManutencaoSistema.Create(self.Fdm.UsuarioLogado, self.Fdm.NomeDoTerminal, self.horarioDeInicio.Horario, self.horarioDeTermino.Horario);
       Repositorio.Salvar(Manutencao);

       self.Cancelar(nil);
     except
       on E: Exception do begin
         inherited Avisar(E.Message);
         self.FDM.LogErros.AdicionaErro('uManutencaoSistema', E.ClassName, E.Message);
       end;
     end;
   finally
     FreeAndNil(Manutencao);
     FreeAndNil(Repositorio);
   end;
end;

end.
