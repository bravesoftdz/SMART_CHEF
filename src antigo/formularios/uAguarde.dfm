object frmAguarde: TfrmAguarde
  Left = 400
  Top = 288
  BorderStyle = bsNone
  Caption = 'frmAguarde'
  ClientHeight = 113
  ClientWidth = 426
  Color = clBtnHighlight
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape3: TShape
    Left = 0
    Top = 0
    Width = 426
    Height = 113
    Pen.Color = 10197915
  end
  object Shape1: TShape
    Left = 107
    Top = 1
    Width = 319
    Height = 112
    Brush.Color = 13744555
    Pen.Color = 13035741
    Pen.Style = psClear
  end
  object gifAguarde: TACBrGIF
    Left = 10
    Top = 12
    Width = 81
    Height = 88
    Transparent = True
  end
  object memoAguarde: TMemo
    Left = 119
    Top = 32
    Width = 294
    Height = 52
    TabStop = False
    BevelInner = bvNone
    BorderStyle = bsNone
    Color = 13744555
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Aguarde um momento por favor')
    ParentFont = False
    TabOrder = 0
  end
end
