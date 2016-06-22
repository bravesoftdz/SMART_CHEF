object ListaCampo: TListaCampo
  Left = 0
  Top = 0
  Width = 215
  Height = 64
  TabOrder = 0
  object Label4: TLabel
    Left = 89
    Top = 3
    Width = 11
    Height = 21
    AutoSize = False
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object staTitulo: TStaticText
    Left = 7
    Top = 2
    Width = 49
    Height = 17
    Caption = 'staTitulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object comListaCampo: TComboBox
    Left = 6
    Top = 19
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
end
