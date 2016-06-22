object RealEdit: TRealEdit
  Left = 0
  Top = 0
  Width = 116
  Height = 39
  TabOrder = 0
  object edtValor: TMaskEdit
    Left = 24
    Top = 8
    Width = 81
    Height = 21
    EditMask = '!99999999\0,\0\0;0; '
    MaxLength = 12
    TabOrder = 0
    OnChange = edtValorChange
    OnEnter = edtValorEnter
    OnKeyPress = edtValorKeyPress
  end
end
