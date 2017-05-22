object frmImpressaoPedido: TfrmImpressaoPedido
  Left = 0
  Top = 0
  Caption = 'frmImpressaoPedido'
  ClientHeight = 445
  ClientWidth = 715
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
  object RLReport2: TRLReport
    Left = 376
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
    object RLBand7: TRLBand
      Left = 2
      Top = 8
      Width = 276
      Height = 96
      BandType = btTitle
      object RLLabel10: TRLLabel
        Left = -24
        Top = 66
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
      object RLLabel5: TRLLabel
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
      object rlbEmpresa: TRLLabel
        Left = 1
        Top = 27
        Width = 272
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'EMPRESA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbCidadeUF: TRLLabel
        Left = 1
        Top = 41
        Width = 272
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'CIDADE / ESTADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
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
      object rlbTelefone: TRLLabel
        Left = 1
        Top = 55
        Width = 272
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'TELEFONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 1
        Top = 77
        Width = 44
        Height = 14
        Caption = 'PEDIDO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 89
        Top = 77
        Width = 37
        Height = 14
        Caption = 'MESA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbPedido: TRLLabel
        Left = 49
        Top = 77
        Width = 42
        Height = 14
        Caption = 'PEDIDO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbMesa: TRLLabel
        Left = 129
        Top = 77
        Width = 32
        Height = 14
        Caption = 'MESA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbComanda: TRLLabel
        Left = 217
        Top = 77
        Width = 56
        Height = 14
        Caption = 'COMANDA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 153
        Top = 77
        Width = 62
        Height = 14
        Caption = 'COMANDA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLGroup2: TRLGroup
      Left = 2
      Top = 124
      Width = 276
      Height = 51
      DataFields = 'CODIGO_ITEM'
      object RLBand8: TRLBand
        Left = 0
        Top = 0
        Width = 276
        Height = 17
        BandType = btTitle
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = 4934475
        BeforePrint = RLBand8BeforePrint
        object RLDraw3: TRLDraw
          Left = 0
          Top = 1
          Width = 31
          Height = 15
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
        object RLDBText2: TRLDBText
          Left = 0
          Top = 2
          Width = 29
          Height = 18
          AutoSize = False
          DataField = 'QUANTIDADE'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBMemo2: TRLDBMemo
          Left = 34
          Top = 2
          Width = 183
          Height = 13
          Behavior = [beSiteExpander]
          DataField = 'PRODUTO'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object RLDBMemo3: TRLDBMemo
          Left = 210
          Top = 1
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Behavior = [beSiteExpander]
          DataField = 'VLR_ITEM'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
      end
      object RLBand9: TRLBand
        Left = 0
        Top = 17
        Width = 276
        Height = 17
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        object RLDBText4: TRLDBText
          Left = 78
          Top = 2
          Width = 132
          Height = 14
          AutoSize = False
          DataField = 'ADICIONAL'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 9
          Top = 2
          Width = 57
          Height = 14
          AutoSize = False
          DataField = 'ADD_REM'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText5BeforePrint
        end
        object RLDBText6: TRLDBText
          Left = 53
          Top = 2
          Width = 23
          Height = 14
          AutoSize = False
          DataField = 'QTD_ADICIONAL'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          Visible = False
        end
        object RLDBText7: TRLDBText
          Left = 214
          Top = 2
          Width = 54
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLR_ADCIONAL'
          DataSource = dsItens
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText7BeforePrint
        end
      end
    end
    object RLBand10: TRLBand
      Left = 2
      Top = 104
      Width = 276
      Height = 20
      BandType = btTitle
      object RLDraw4: TRLDraw
        Left = -1
        Top = 0
        Width = 278
        Height = 21
        Anchors = [fkBottom]
        Brush.Color = 15263976
        Pen.Color = 4934475
        Pen.Style = psClear
      end
      object RLLabel11: TRLLabel
        Left = 3
        Top = 4
        Width = 270
        Height = 14
        Anchors = [fkBottom]
        Caption = 
          'QTD   ITEM                                                     V' +
          'ALORES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLSubDetail1: TRLSubDetail
      Left = 2
      Top = 175
      Width = 276
      Height = 33
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      DataSource = dsTotais
      Positioning = btSummary
      object RLBand12: TRLBand
        Left = 0
        Top = 1
        Width = 276
        Height = 18
        object RLDBText8: TRLDBText
          Left = 14
          Top = 3
          Width = 211
          Height = 14
          AutoSize = False
          DataField = 'DESCRICAO'
          DataSource = dsTotais
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText8BeforePrint
        end
        object RLDBText9: TRLDBText
          Left = 211
          Top = 3
          Width = 62
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dsTotais
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText8BeforePrint
        end
      end
    end
    object RLSubDetail2: TRLSubDetail
      Left = 2
      Top = 208
      Width = 276
      Height = 50
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      DataSource = dsPago
      Positioning = btSummary
      object RLBand13: TRLBand
        Left = 0
        Top = 1
        Width = 276
        Height = 18
        object RLDBText11: TRLDBText
          Left = 211
          Top = 3
          Width = 62
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dsPago
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText11BeforePrint
        end
        object RLDBText10: TRLDBText
          Left = 5
          Top = 3
          Width = 220
          Height = 14
          AutoSize = False
          DataField = 'DESCRICAO'
          DataSource = dsPago
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object RLBand14: TRLBand
        Left = 0
        Top = 19
        Width = 276
        Height = 20
        BandType = btSummary
        object RLLabel7: TRLLabel
          Left = 62
          Top = 5
          Width = 146
          Height = 14
          Caption = 'OBRIGADO, VOLTE SEMPRE!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object RLSubDetail3: TRLSubDetail
      Left = 2
      Top = 258
      Width = 276
      Height = 50
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      DataSource = dsPago
      Positioning = btSummary
      BeforePrint = RLSubDetail3BeforePrint
      object RLBand15: TRLBand
        Left = 0
        Top = 1
        Width = 276
        Height = 29
        AutoSize = True
        BandType = btSummary
      end
      object memoEndereco: TRLMemo
        Left = 8
        Top = 11
        Width = 257
        Height = 14
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 72
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
    object cdsItensVLR_ITEM: TFloatField
      FieldName = 'VLR_ITEM'
      DisplayFormat = ' ,0.00; -,0.00;'
    end
    object cdsItensVLR_ADCIONAL: TFloatField
      FieldName = 'VLR_ADCIONAL'
      DisplayFormat = ' ,0.00; -,0.00;'
    end
    object cdsItensQTD_ADICIONAL: TIntegerField
      FieldName = 'QTD_ADICIONAL'
    end
    object cdsItensADD_REM: TStringField
      FieldName = 'ADD_REM'
      Size = 15
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 296
    Top = 24
  end
  object cdsTotais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 304
    object cdsTotaisDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsTotaisVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ' ,0.00; -,0.00;'
    end
  end
  object dsTotais: TDataSource
    DataSet = cdsTotais
    Left = 336
    Top = 256
  end
  object dsPago: TDataSource
    DataSet = cdsPago
    Left = 672
    Top = 256
  end
  object cdsPago: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 304
    object cdsPagoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 80
    end
    object cdsPagoVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ' ,0.00; -,0.00;'
    end
  end
end
