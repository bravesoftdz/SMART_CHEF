object Horario: THorario
  Left = 0
  Top = 0
  Width = 192
  Height = 73
  TabOrder = 0
  object lblNomeDoHorario: TGroupBox
    Left = 0
    Top = 0
    Width = 192
    Height = 73
    Align = alClient
    Caption = 'Nome do Hor'#225'rio'
    TabOrder = 0
    object lblHoras: TStaticText
      Left = 6
      Top = 16
      Width = 32
      Height = 17
      Caption = 'Horas'
      TabOrder = 0
    end
    object edtHoras: TSpinEdit
      Left = 6
      Top = 35
      Width = 41
      Height = 22
      MaxLength = 2
      MaxValue = 23
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object lblMinutos: TStaticText
      Left = 66
      Top = 16
      Width = 41
      Height = 17
      Caption = 'Minutos'
      TabOrder = 2
    end
    object edtMinutos: TSpinEdit
      Left = 66
      Top = 35
      Width = 41
      Height = 22
      MaxLength = 2
      MaxValue = 59
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object edtSegundos: TSpinEdit
      Left = 123
      Top = 35
      Width = 41
      Height = 22
      MaxLength = 2
      MaxValue = 59
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object lblSegundos: TStaticText
      Left = 123
      Top = 16
      Width = 52
      Height = 17
      Caption = 'Segundos'
      TabOrder = 5
    end
    object lblPrimeiraSeparacao: TStaticText
      Left = 51
      Top = 38
      Width = 7
      Height = 17
      Caption = ':'
      TabOrder = 6
    end
    object lblSegundaSeparacao: TStaticText
      Left = 111
      Top = 38
      Width = 7
      Height = 17
      Caption = ':'
      TabOrder = 7
    end
  end
end
