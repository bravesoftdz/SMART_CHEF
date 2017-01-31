object frmImpressaoPedido: TfrmImpressaoPedido
  Left = 0
  Top = 0
  Caption = 'frmImpressaoPedido'
  ClientHeight = 487
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 35
    Top = 8
    Width = 280
    Height = 378
    Margins.LeftMargin = 0.610000000000000000
    Margins.TopMargin = 2.000000000000000000
    Margins.RightMargin = 0.610000000000000000
    Margins.BottomMargin = 0.000000000000000000
    Borders.Sides = sdCustom
    Borders.DrawLeft = False
    Borders.DrawTop = False
    Borders.DrawRight = False
    Borders.DrawBottom = False
    DataSource = dsItens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 74.000000000000000000
    PageSetup.PaperHeight = 100.000000000000000000
    PrintDialog = False
    Visible = False
    object RLBand1: TRLBand
      Left = 2
      Top = 8
      Width = 276
      Height = 114
      BandType = btTitle
      object RLLabel4: TRLLabel
        Left = -44
        Top = 17
        Width = 364
        Height = 14
        Alignment = taCenter
        Caption = 
          '----------------------------------------------------------------' +
          '--------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = -44
        Top = 60
        Width = 364
        Height = 14
        Alignment = taCenter
        Caption = 
          '----------------------------------------------------------------' +
          '--------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel1: TRLLabel
        Left = 1
        Top = 40
        Width = 54
        Height = 14
        Alignment = taCenter
        Caption = 'USU'#193'RIO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbUsuario: TRLLabel
        Left = 57
        Top = 40
        Width = 52
        Height = 14
        Caption = 'USU'#193'RIO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lbPreparo: TRLLabel
        Left = 57
        Top = 49
        Width = 52
        Height = 14
        Caption = 'PREPARO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object memoInfoPedido: TRLMemo
        Left = 0
        Top = 73
        Width = 273
        Height = 15
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 232
        Top = 0
        Width = 36
        Height = 15
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Info = itNow
        ParentFont = False
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = -1
        Top = 49
        Width = 56
        Height = 14
        Alignment = taCenter
        Caption = 'PREPARO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 2
      Top = 142
      Width = 276
      Height = 54
      DataFields = 'CODIGO_ITEM'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 276
        Height = 21
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = 4934475
        object RLDraw1: TRLDraw
          Left = 0
          Top = 1
          Width = 41
          Height = 19
          Align = faLeft
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = True
          Borders.DrawBottom = False
          Borders.Color = 7039851
          Brush.Style = bsClear
          Pen.Style = psClear
        end
        object RLDBText1: TRLDBText
          Left = 3
          Top = 2
          Width = 36
          Height = 18
          AutoSize = False
          DataField = 'QUANTIDADE'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Text = ''
        end
        object RLDBMemo1: TRLDBMemo
          Left = 45
          Top = 2
          Width = 222
          Height = 16
          Behavior = [beSiteExpander]
          DataField = 'PRODUTO'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 21
        Width = 276
        Height = 19
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        object RLDBText3: TRLDBText
          Left = 64
          Top = 2
          Width = 58
          Height = 14
          DataField = 'ADICIONAL'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText3BeforePrint
        end
      end
    end
    object RLBand3: TRLBand
      Left = 2
      Top = 122
      Width = 276
      Height = 20
      BandType = btTitle
      object RLDraw2: TRLDraw
        Left = -1
        Top = -5
        Width = 278
        Height = 21
        Anchors = [fkBottom]
        Brush.Color = 15263976
        Pen.Color = 4934475
        Pen.Style = psClear
      end
      object RLLabel3: TRLLabel
        Left = 3
        Top = 4
        Width = 72
        Height = 14
        Anchors = [fkBottom]
        Caption = 'QTD       ITEM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand5: TRLBand
      Left = 2
      Top = 208
      Width = 276
      Height = 56
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
    end
    object RLBand6: TRLBand
      Left = 2
      Top = 196
      Width = 276
      Height = 12
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
    end
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 24
    object cdsItensCODIGO_ITEM: TIntegerField
      FieldName = 'CODIGO_ITEM'
    end
    object cdsItensPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 80
    end
    object cdsItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsItensADICIONAL: TStringField
      FieldName = 'ADICIONAL'
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 336
    Top = 24
  end
end
