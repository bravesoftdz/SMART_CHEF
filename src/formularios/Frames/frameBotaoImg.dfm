object BotaoImg: TBotaoImg
  Left = 0
  Top = 0
  Width = 183
  Height = 151
  AutoScroll = False
  Color = clWhite
  ParentColor = False
  TabOrder = 0
  OnMouseMove = FrameMouseMove
  object StaticText1: TStaticText
    Left = 21
    Top = 104
    Width = 57
    Height = 21
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 'Usu'#225'rios'
    Color = 4504967
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    Transparent = False
  end
  object Panel1: TPanel
    Left = 14
    Top = 0
    Width = 129
    Height = 102
    BevelOuter = bvNone
    Color = 5096587
    TabOrder = 0
    object Image1: TImage
      Left = 1
      Top = 6
      Width = 107
      Height = 96
    end
    object Image2: TImage
      Left = 5
      Top = 2
      Width = 121
      Height = 101
      Visible = False
    end
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 129
      Height = 102
      Cursor = crHandPoint
      Align = alClient
      AutoSize = False
      Color = clBlue
      ParentColor = False
      Transparent = True
      OnClick = Label1Click
      OnMouseDown = Label1MouseDown
      OnMouseMove = Label1MouseMove
      OnMouseUp = Label1MouseUp
      OnMouseLeave = Label1MouseLeave
    end
  end
end
