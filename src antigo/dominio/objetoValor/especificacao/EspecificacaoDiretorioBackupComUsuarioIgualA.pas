{******************************************************************************}
{                                                                              }
{                               SMART CHEF                                     }
{                                                                              }
{                    Copyright (C) 2013 CBN Inform�tica                        }
{							                                                                 }
{ Objetivo: Classe com objeto de filtrar os objetos DiretorioBackup na         }
{  consulta ao reposit�rio. Apenas DiretoriosBackup com o usu�rio igual ao     }
{  passado na constructor ser�o satisfeitos.                                   }
{							                                                                 }
{                                                                              }
{******************************************************************************}

unit EspecificacaoDiretorioBackupComUsuarioIgualA;



interface

uses
  Especificacao,
  Usuario;

type
  TEspecificacaoDiretorioBackupComUsuarioIgualA = class(TEspecificacao)

  private
    FUsuario :TUsuario;

  public
    constructor Create(Usuario :TUsuario);
    destructor  Destroy; override;

  public
    function SatisfeitoPor(DiretorioBackup :TObject) :Boolean; override;
end;

implementation

uses DiretorioBackup;

{ TEspecificacaoDiretorioBackupComUsuarioIgualA }

constructor TEspecificacaoDiretorioBackupComUsuarioIgualA.Create(
  Usuario: TUsuario);
begin
   self.FUsuario := Usuario;
end;

destructor TEspecificacaoDiretorioBackupComUsuarioIgualA.Destroy;
begin
  self.FUsuario := nil;
  
  inherited;
end;

function TEspecificacaoDiretorioBackupComUsuarioIgualA.SatisfeitoPor(
  DiretorioBackup: TObject): Boolean;
begin
   result := (TDiretorioBackup(DiretorioBackup).CodigoUsuario = self.FUsuario.Codigo);
end;

end.
