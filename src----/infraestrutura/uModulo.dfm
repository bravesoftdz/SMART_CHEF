object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 559
  Top = 233
  Height = 179
  Width = 265
  object qryGenerica: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 160
    Top = 24
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    Properties.Strings = (
      'controls_cp=GET_ACP')
    AutoCommit = False
    TransactIsolationLevel = tiReadCommitted
    Port = 0
    User = 'SYSDBA'
    Password = 'masterkey'
    Protocol = 'firebird-1.5'
    Left = 56
    Top = 24
  end
  object qryGenerica2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 160
    Top = 80
  end
end
