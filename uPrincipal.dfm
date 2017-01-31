object frmPrincipal: TfrmPrincipal
  Left = 341
  Top = 331
  AlphaBlend = True
  AlphaBlendValue = 2
  Caption = 'Finaliza Smart'
  ClientHeight = 68
  ClientWidth = 179
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = Timer1Timer
    Left = 80
    Top = 40
  end
end
