object BuscaCliente: TBuscaCliente
  Left = 0
  Top = 0
  Width = 115
  Height = 64
  AutoSize = True
  TabOrder = 0
  object Label28: TLabel
    Left = 9
    Top = 0
    Width = 67
    Height = 17
    Caption = 'Telefone >'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object edtTelefone: TMaskEdit
    Left = 12
    Top = 22
    Width = 103
    Height = 19
    Ctl3D = False
    EditMask = '!\(99\)9999-9999;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 13
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Text = ''
  end
  object edtCodigo: TCurrencyEdit
    Left = 0
    Top = 43
    Width = 64
    Height = 21
    AutoSize = False
    DisplayFormat = '0'
    TabOrder = 1
    Visible = False
  end
end
