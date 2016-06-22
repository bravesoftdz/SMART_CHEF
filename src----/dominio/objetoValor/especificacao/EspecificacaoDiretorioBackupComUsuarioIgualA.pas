{******************************************************************************}
{                                                                              }
{                               SMART CHEF                                     }
{                                                                              }
{                    Copyright (C) 2013 CBN Informática                        }
{							                                                                 }
{ Objetivo: Classe com objeto de filtrar os objetos DiretorioBackup na         }
{  consulta ao repositório. Apenas DiretoriosBackup com o usuário igual ao     }
{  passado na constructor serão satisfeitos.                                   }
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
