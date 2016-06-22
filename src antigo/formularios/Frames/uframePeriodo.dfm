object framePeriodo: TframePeriodo
  Left = 0
  Top = 0
  Width = 193
  Height = 36
  AutoSize = True
  TabOrder = 0
  OnExit = FrameExit
  object StaticText2: TStaticText
    Left = 105
    Top = 0
    Width = 49
    Height = 17
    Caption = 'Data final'
    TabOrder = 3
  end
  object StaticText1: TStaticText
    Left = 1
    Top = 0
    Width = 56
    Height = 17
    Caption = 'Data inicial'
    TabOrder = 2
  end
  object edtDtI: TFocusMaskEdit
    Left = 0
    Top = 15
    Width = 88
    Height = 21
    EditMask = '##/##/####;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnEnter = edtDtIEnter
    OnExit = edtDtIExit
    Padrao = True
  end
  object edtDtF: TFocusMaskEdit
    Left = 104
    Top = 15
    Width = 89
    Height = 21
    EditMask = '##/##/####;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    OnEnter = edtDtIEnter
    OnExit = edtDtIExit
    Padrao = True
  end
  object balao: TMarcianoBallon
    TipoIcone = tiErro
    TituloDefault = 'Erro'
    Autor = 'Marciano Bandeira'
    Left = 136
  end
end
