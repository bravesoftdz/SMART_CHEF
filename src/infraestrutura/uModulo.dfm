object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 179
  Width = 265
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'Protocol=firebird-2.1'
      'Server=servidor'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode]
    TxOptions.AutoStop = False
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object qryGenerica: TFDQuery
    Connection = FDConnection
    Left = 160
    Top = 16
  end
  object qryGenerica2: TFDQuery
    Connection = FDConnection
    Left = 160
    Top = 80
  end
end
