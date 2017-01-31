object Fone: TFone
  Left = 0
  Top = 0
  Width = 132
  Height = 47
  TabOrder = 0
  object Label12: TLabel
    Left = 4
    Top = 3
    Width = 26
    Height = 13
    Caption = 'Fone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3355443
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtFone: TMaskEdit
    Left = 3
    Top = 19
    Width = 111
    Height = 21
    EditMask = '!\(99\)99999-9999;1; '
    MaxLength = 14
    TabOrder = 0
    Text = '(  )     -    '
    OnChange = edtFoneChange
    OnExit = edtFoneExit
  end
end
