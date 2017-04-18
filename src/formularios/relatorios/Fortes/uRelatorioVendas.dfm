inherited frmRelatorioVendas: TfrmRelatorioVendas
  Top = 209
  Caption = 'Relat'#243'rio de vendas'
  ClientHeight = 178
  ClientWidth = 673
  OnShow = FormShow
  ExplicitWidth = 679
  ExplicitHeight = 206
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 286
    Top = 32
    Width = 7
    Height = 17
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [1]
    Left = 160
    Top = 14
    Width = 70
    Height = 17
    Caption = 'Data inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [2]
    Left = 304
    Top = 14
    Width = 61
    Height = 17
    Caption = 'Data final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RLReport1: TRLReport [3]
    Left = 120
    Top = 104
    Width = 794
    Height = 1123
    Margins.LeftMargin = 6.000000000000000000
    Margins.RightMargin = 6.000000000000000000
    Borders.Sides = sdCustom
    Borders.DrawLeft = True
    Borders.DrawTop = True
    Borders.DrawRight = True
    Borders.DrawBottom = True
    Borders.FixedBottom = True
    DataSource = dsVendas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Visible = False
    object RLBand1: TRLBand
      Left = 24
      Top = 39
      Width = 746
      Height = 99
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLDraw9: TRLDraw
        Left = 0
        Top = 55
        Width = 569
        Height = 20
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 5131854
        Pen.Style = psClear
      end
      object RLDraw1: TRLDraw
        Left = 568
        Top = 0
        Width = 180
        Height = 98
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 5131854
        Pen.Style = psClear
      end
      object RLLabel8: TRLLabel
        Left = 160
        Top = 15
        Width = 196
        Height = 24
        Caption = 'Relat'#243'rio de Vendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 664
        Top = 22
        Width = 39
        Height = 16
        Alignment = taCenter
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 664
        Top = 54
        Width = 39
        Height = 16
        Alignment = taCenter
        Info = itHour
        Text = ''
      end
      object RLLabel10: TRLLabel
        Left = 592
        Top = 54
        Width = 43
        Height = 16
        Caption = 'Hora >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw8: TRLDraw
        Left = 0
        Top = 77
        Width = 568
        Height = 20
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 5131854
        Pen.Style = psClear
      end
      object RLLabel23: TRLLabel
        Left = 3
        Top = 80
        Width = 52
        Height = 16
        Caption = 'Per'#237'odo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbPeriodo: TRLLabel
        Left = 59
        Top = 80
        Width = 46
        Height = 16
        Caption = 'periodo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 592
        Top = 22
        Width = 43
        Height = 16
        Caption = 'Data >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel24: TRLLabel
        Left = 3
        Top = 59
        Width = 52
        Height = 16
        Caption = 'Usu'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbUsuario: TRLLabel
        Left = 59
        Top = 59
        Width = 46
        Height = 16
        Caption = 'usuario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand4: TRLBand
      Left = 24
      Top = 252
      Width = 746
      Height = 126
      GreenBarColor = 14540253
      AlignToBottom = True
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      Color = clWhite
      ParentColor = False
      Transparent = False
      object RLLabel7: TRLLabel
        Left = -7
        Top = 8
        Width = 753
        Height = 16
        Caption = 
          '________________________________________________________________' +
          '___________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 11447982
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = -7
        Top = 28
        Width = 753
        Height = 16
        Caption = 
          '________________________________________________________________' +
          '___________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 11447982
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = -7
        Top = 45
        Width = 753
        Height = 16
        Caption = 
          '________________________________________________________________' +
          '___________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 11447982
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = -7
        Top = 68
        Width = 753
        Height = 16
        Caption = 
          '________________________________________________________________' +
          '___________________________________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 11447982
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw7: TRLDraw
        Left = 1
        Top = 84
        Width = 746
        Height = 22
        Brush.Color = 14540253
        Pen.Style = psClear
      end
      object RLDraw6: TRLDraw
        Left = 1
        Top = 44
        Width = 746
        Height = 22
        Brush.Color = 15329769
        Pen.Style = psClear
      end
      object RLDraw5: TRLDraw
        Left = 1
        Top = 1
        Width = 746
        Height = 22
        Brush.Color = 15329769
        Pen.Style = psClear
      end
      object RLLabel9: TRLLabel
        Left = 376
        Top = 5
        Width = 173
        Height = 17
        Caption = 'Total Produtos                 >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBResult3: TRLDBResult
        Left = 601
        Top = 5
        Width = 140
        Height = 16
        Alignment = taRightJustify
        DataField = 'VLR_TOTAL_IT'
        DataSource = dsVendas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Text = ''
        AfterPrint = RLDBResult3AfterPrint
      end
      object rlbTxServico: TRLLabel
        Left = 672
        Top = 46
        Width = 68
        Height = 16
        Alignment = taRightJustify
        Caption = 'TxServico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbCouvert: TRLLabel
        Left = 687
        Top = 66
        Width = 53
        Height = 16
        Alignment = taRightJustify
        Caption = 'Couvert'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbDesconto: TRLLabel
        Left = 678
        Top = 86
        Width = 62
        Height = 16
        Alignment = taRightJustify
        Caption = 'Desconto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbSaldo: TRLLabel
        Left = 697
        Top = 107
        Width = 44
        Height = 18
        Alignment = taRightJustify
        Caption = 'Saldo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 376
        Top = 44
        Width = 174
        Height = 17
        Caption = 'Total Taxa Servi'#231'o            >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel17: TRLLabel
        Left = 376
        Top = 64
        Width = 173
        Height = 17
        Caption = 'Total Couvert Art'#237'stico     >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel18: TRLLabel
        Left = 376
        Top = 85
        Width = 171
        Height = 17
        Caption = 'Total Desconto                >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel19: TRLLabel
        Left = 376
        Top = 106
        Width = 171
        Height = 17
        Caption = 'TOTAL GERAL                  >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel20: TRLLabel
        Left = 619
        Top = 45
        Width = 13
        Height = 17
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 619
        Top = 65
        Width = 13
        Height = 17
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel22: TRLLabel
        Left = 621
        Top = 85
        Width = 9
        Height = 17
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 606
        Top = -1
        Width = 1
        Height = 127
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 11447982
        Brush.Style = bsClear
        Pen.Style = psClear
      end
      object RLLabel26: TRLLabel
        Left = 376
        Top = 24
        Width = 173
        Height = 17
        Caption = 'Total Adicionais               >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBResult2: TRLDBResult
        Left = 595
        Top = 25
        Width = 146
        Height = 16
        Alignment = taRightJustify
        DataField = 'VLR_TOTAL_AD'
        DataSource = dsVendas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Text = ''
        AfterPrint = RLDBResult3AfterPrint
      end
      object RLLabel27: TRLLabel
        Left = 619
        Top = 24
        Width = 13
        Height = 17
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 24
      Top = 138
      Width = 746
      Height = 114
      DataFields = 'CODGRUPO'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 746
        Height = 50
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        object RLDraw3: TRLDraw
          Left = 1
          Top = 27
          Width = 746
          Height = 23
          Brush.Color = 15132390
          Pen.Style = psClear
        end
        object RLLabel1: TRLLabel
          Left = 8
          Top = 31
          Width = 54
          Height = 16
          Caption = 'Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel2: TRLLabel
          Left = 399
          Top = 31
          Width = 78
          Height = 16
          Caption = 'Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 494
          Top = 31
          Width = 80
          Height = 16
          Caption = 'Vlr. Unit'#225'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 592
          Top = 31
          Width = 62
          Height = 16
          Caption = 'Vlr. Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel12: TRLLabel
          Left = -2
          Top = 11
          Width = 753
          Height = 16
          Caption = 
            '________________________________________________________________' +
            '___________________________________________'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText8: TRLDBText
          Left = 320
          Top = 5
          Width = 51
          Height = 16
          DataField = 'GRUPO'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Text = ''
        end
        object RLLabel5: TRLLabel
          Left = 256
          Top = 5
          Width = 55
          Height = 16
          Caption = 'GRUPO:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel25: TRLLabel
          Left = 672
          Top = 31
          Width = 66
          Height = 16
          Caption = 'Vlr. Adici.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 50
        Width = 746
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        BeforePrint = RLBand3BeforePrint
        object RLDBText1: TRLDBText
          Left = 6
          Top = 5
          Width = 409
          Height = 15
          AutoSize = False
          DataField = 'PRODUTO'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 526
          Top = 5
          Width = 48
          Height = 15
          Alignment = taRightJustify
          DataField = 'VLR_UNI'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText5BeforePrint
        end
        object RLDBText6: TRLDBText
          Left = 445
          Top = 5
          Width = 32
          Height = 15
          Alignment = taRightJustify
          DataField = 'QTDE'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText6BeforePrint
        end
        object RLDBText2: TRLDBText
          Left = 578
          Top = 5
          Width = 77
          Height = 15
          Alignment = taRightJustify
          DataField = 'VLR_TOTAL_IT'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 656
          Top = 5
          Width = 82
          Height = 15
          Alignment = taRightJustify
          DataField = 'VLR_TOTAL_AD'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 74
        Width = 746
        Height = 27
        GreenBarColor = 14540253
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLDraw4: TRLDraw
          Left = 1
          Top = 1
          Width = 376
          Height = 25
          Brush.Color = clSilver
          Brush.Style = bsBDiagonal
          Pen.Style = psClear
        end
        object RLDBResult6: TRLDBResult
          Left = 397
          Top = 7
          Width = 80
          Height = 16
          Alignment = taRightJustify
          DataField = 'QTDE'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          Text = ''
          Transparent = False
          Visible = False
        end
        object RLLabel3: TRLLabel
          Left = 112
          Top = 5
          Width = 153
          Height = 17
          Caption = 'TOTAIS DO GRUPO >>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult4: TRLDBResult
          Left = 514
          Top = 6
          Width = 140
          Height = 16
          Alignment = taRightJustify
          DataField = 'VLR_TOTAL_IT'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          Text = ''
          Transparent = False
        end
        object RLDBResult1: TRLDBResult
          Left = 592
          Top = 6
          Width = 146
          Height = 16
          Alignment = taRightJustify
          DataField = 'VLR_TOTAL_AD'
          DataSource = dsVendas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          Text = ''
          Transparent = False
        end
      end
    end
  end
  inherited pnlPropaganda: TPanel
    Top = 143
    Width = 673
    ExplicitTop = 176
    ExplicitWidth = 661
    inherited Shape8: TShape
      Width = 671
      ExplicitWidth = 687
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 143
    Align = alLeft
    TabOrder = 5
    ExplicitHeight = 176
    object Shape12: TShape
      Left = 1
      Top = 1
      Width = 127
      Height = 141
      Align = alClient
      Brush.Color = 14737632
      Pen.Color = 12040119
      ExplicitHeight = 130
    end
    object BitBtn1: TBitBtn
      Left = 11
      Top = 24
      Width = 105
      Height = 30
      Caption = ' Imprimir'
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D7C39B00ECE3D600ECE3D600ECE3D600ECE3D600ECE3
        D600ECE3D600D7C39B00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00735F3700887F7200887F7200887F7200887F7200887F
        7200887F7200735F37009B9B9B009B9B9B009B9B9B009B9B9B00B0ACAC00B1AC
        AC00A7A2A200726C7300C4AB7F00EDE1D500EDE1D500EDE1D500EDE1D500EDE1
        D500EDE1D500C4AB7F0076717700A49E9E00A9A4A400ABA5A5004C4848004D48
        4800433E3E000E080F0060471B00897D7100897D7100897D7100897D7100897D
        7100897D710060471B00120D1300403A3A004540400047414100958F8F00C3C0
        BF00C3C0BF00837D8400C6A87400E0CBAE00E0CBAE00E0CBAE00E0CBAE00E0CB
        AE00E0CBAE00C6A87400837D8400C3C0BF00C3C0BF0099929200312B2B005F5C
        5B005F5C5B001F192000624410007C674A007C674A007C674A007C674A007C67
        4A007C674A00624410001F1920005F5C5B005F5C5B00352E2E00A49FA100D1CF
        CE00D1CFCE00D3D2D100D2D2D300D0D0D200D0D0D200D0D0D200D0D0D200D0D0
        D200D0D0D200D2D2D300D3D2D100BACAD7006E9BE300A49FA100403B3D006D6B
        6A006D6B6A006F6E6D006E6E6F006C6C6E006C6C6E006C6C6E006C6C6E006C6C
        6E006C6C6E006E6E6F006F6E6D00566673000A377F00403B3D00AAA7A700D9D7
        D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7
        D700D9D7D700D9D7D700D9D7D7008AC3E900004BFB00ABA8A800464343007573
        7300757373007573730075737300757373007573730075737300757373007573
        7300757373007573730075737300265F85000000970047444400B7B3B300E6E8
        E900D6C5AF00BC6B1000BB6A0F00BB6A0F00BB6A0F00BB6A0F00BB6A0F00BB6A
        0F00BB6A0F00BB6A0F00BC6B1000D6C5AF00E6E8E900B8B5B500534F4F008284
        850072614B005807000057060000570600005706000057060000570600005706
        000057060000570600005807000072614B008284850054515100BCB9BA00EEF2
        F500BA7B3E00E1A94200E1A84200E1A84200E1A84200E1A84200E1A84200E1A8
        4200E1A84200E1A84200E1A94200BA7B3E00EEF2F500BFBBBC00585556008A8E
        9100561700007D4500007D4400007D4400007D4400007D4400007D4400007D44
        00007D4400007D4400007D450000561700008A8E91005B575800CDC8C900F8FC
        FF00CD975300EEC67000EEC77100EEC77100EEC77100EEC77100EEC77100EEC7
        7100EEC77100EEC77100EEC67000CD975300F8FCFF00CECBCC00696465009498
        9B00693300008A620C008A630D008A630D008A630D008A630D008A630D008A63
        0D008A630D008A630D008A620C006933000094989B006A676800D2D0D000FCFF
        FF00D7A55C00EDC97700E9BF6800E9BF6800E9BF6800E9BF6800E9BF6800E9BF
        6800E9BF6800E9BF6800EDC97700D7A55C00FCFFFF00D4D1D0006E6C6C00989B
        9B007341000089651300855B0400855B0400855B0400855B0400855B0400855B
        0400855B0400855B04008965130073410000989B9B00706D6C00DEDCDB00FFFF
        FF00E8C07000E0AC5400B99D6B00D7BD9100D7BD9100D7BD9100D7BD9100D7BD
        9100D7BD9100B99D6B00E0AC5400E8C07000FFFFFF00E3DFDF007A7877009B9B
        9B00845C0C007C4800005539070073592D0073592D0073592D0073592D007359
        2D0073592D00553907007C480000845C0C009B9B9B007F7B7B00D1CBCD00BCBB
        C000DEB67300CF9E5F00C4AB7F00DFCAAD00DFCAAD00DFCAAD00DFCAAD00DFCA
        AD00DFCAAD00C4AB7F00CD995600DDB36E00BEBDC100D1CACC006D6769005857
        5C007A520F006B3A000060471B007B6649007B6649007B6649007B6649007B66
        49007B66490060471B0069350000794F0A005A595D006D666800FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D0BD9800ECDFD100ECDFD100ECDFD100ECDFD100ECDF
        D100ECDFD100D0BD9800FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B006C593400887B6D00887B6D00887B6D00887B6D00887B
        6D00887B6D006C5934009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D5C4A400EFE4D800EFE4D800EFE4D800EFE4D800EFE4
        D800EFE4D800D5C4A400FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00716040008B8074008B8074008B8074008B8074008B80
        74008B807400716040009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00DED0B800F5EDE400F5EDE400F5EDE400F5EDE400F5ED
        E400F5EDE400DED0B800FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B007A6C5400918980009189800091898000918980009189
        8000918980007A6C54009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E2D6C100F8F3EA00F8F3EA00F8F3EA00F8F3EA00F8F3
        EA00F8F3EA00E2D6C100FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B007E725D00948F8600948F8600948F8600948F8600948F
        8600948F86007E725D009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E7DDCD00EFE8DB00EFE8DB00EFE8DB00EFE8DB00EFE8
        DB00EFE8DB00E8DFD000FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00837969008B8477008B8477008B8477008B8477008B84
        77008B847700847B6C009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 72
      Width = 105
      Height = 30
      Caption = ' Cancelar'
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00DFDF
        F0009594CB00C6C6E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF002322BE007F7EBA00FFFFFF009B9B9B007B7B
        8C003130670062627C009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B0000005A001B1A56009B9B9B00ECECF4001410
        C100110EFF000B09DD00A5A5C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF006665B100110CFC007D7CAF00FFFFFF00888890000000
        5D0000009B000000790041415F009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B0002014D000000980019184B009B9B9B00B7B6DB00110F
        DF000E0CFC00100EFF00110FB600F4F4F700FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00D2D2E2000D0CDC000D0BD600D6D6E600FFFFFF00535277000000
        7B000000980000009B0000005200909093009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B006E6E7E000000780000007200727282009B9B9B00C7C7E0002524
        D7000F0EFB000E0EEF000F0FFA007271BB00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F7F7FB001B19BF001313FF00201EA600FFFFFF00FFFFFF0063637C000000
        73000000970000008B00000096000E0D57009B9B9B009B9B9B009B9B9B009B9B
        9B009393970000005B0000009B00000042009B9B9B009B9B9B00FFFFFF003C3B
        B3002627FF00090AEE001214FA000F10DB00DDDDEE00FFFFFF00FFFFFF00FFFF
        FF004F4EC5001416FF001112E5009F9FCE00FFFFFF00FFFFFF009B9B9B000000
        4F0000009B0000008A00000096000000770079798A009B9B9B009B9B9B009B9B
        9B000000610000009B00000081003B3B6A009B9B9B009B9B9B00FFFFFF00E0E0
        F000272BC600252CFE000D0EEE00161CFE003232CC00FFFFFF00FFFFFF006969
        D600181DF900191EFE002121C000FFFFFF00FFFFFF00FFFFFF009B9B9B007C7C
        8C000000620000009A0000008A0000009A00000068009B9B9B009B9B9B000505
        72000000950000009A0000005C009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00ABAAE100393FE0002531FA00121CF6001B25F6009492E1008988E3001D26
        F7001E2BFF00151BE200C3C2E900FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B0047467D0000007C00000096000000920000009200302E7D0025247F000000
        930000009B0000007E005F5E85009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00726FD8004C57F6002839F8001B2DF7001F29EE002131F6002236
        F9001F2FF2006B68DD00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B000E0B740000009200000094000000930000008A00000092000000
        950000008E00070479009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00615FDC005261F500293CF600253AF800263AF7002638
        F6003C3ADE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B0000007800000091000000920000009400000093000000
        920000007A009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF008B8BEC002939F1002F45F8002338F600253EF8001F28
        EA00E3E1FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B002727880000008D000000940000009200000094000000
        86007F7D97009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00C1C0FA00353FF000314CF9002B46F800253FF6004E69F900536EF9002341
        F6004A4FF000F3F3FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B005D5C960000008C0000009500000094000000920000059500000A95000000
        920000008C008F8F9A009B9B9B009B9B9B009B9B9B009B9B9B00F9F9FF005D60
        F400314CF6003656F8002F4AF600304FF600516EF9003D3FF200555CF4006B8A
        FA00385EF8002833F300D5D3FC00FFFFFF00FFFFFF00FFFFFF0095959B000000
        900000009200000094000000920000009200000A950000008E00000090000726
        96000000940000008F00716F98009B9B9B009B9B9B009B9B9B005A5FF5003B61
        F8003A5AF7003150F7003D5FF700637DFA004042F600E9E8FD00CAC8FB003F40
        F500778EFA006389FA002D45F5009696FA00FFFFFF00FFFFFF00000091000000
        9400000093000000930000009300001996000000920085849900666497000000
        9100132A96000025960000009100323296009B9B9B009B9B9B004755F8004F76
        F8003E61F8005679F8006279F9005955F700F7F6FF00FFFFFF00FFFFFF00F0EF
        FF00726DF700525AF8007F9CFA006B89FA005661F700D4D3FD00000094000012
        94000000940000159400001595000000930093929B009B9B9B009B9B9B008C8B
        9B000E099300000094001B3896000725960000009300706F99006462F600697B
        F9006C82F9005055F6008984F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00DBDAFD006561F6005455F7006B7EF8004A4FF700000092000517
        9500081E950000009200252095009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B00777699000100920000009300071A940000009300B9B7FB005353
        F6005C5FF7006763F600F5F5FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E4E3FE009E9BF9006566F6006D6CF700555397000000
        9200000093000300920091919B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B00807F9A003A3795000102920009089300}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  inline listaGrupos: TListaCampo
    Left = 440
    Top = 13
    Width = 215
    Height = 44
    TabOrder = 4
    ExplicitLeft = 440
    ExplicitTop = 13
    ExplicitHeight = 44
    inherited Label4: TLabel
      Left = 73
      Top = 11
      ExplicitLeft = 73
      ExplicitTop = 11
    end
    inherited staTitulo: TStaticText
      Top = 1
      Width = 59
      Height = 21
      Font.Height = -13
      ExplicitTop = 1
      ExplicitWidth = 59
      ExplicitHeight = 21
    end
  end
  object dtpInicio: TDateTimePicker
    Left = 160
    Top = 32
    Width = 113
    Height = 21
    Date = 42118.383622881940000000
    Time = 42118.383622881940000000
    TabOrder = 1
  end
  object dtpFim: TDateTimePicker
    Left = 304
    Top = 32
    Width = 113
    Height = 21
    Date = 42118.383718449080000000
    Time = 42118.383718449080000000
    TabOrder = 2
  end
  object chkPeriodoGeral: TCheckBox
    Left = 160
    Top = 64
    Width = 217
    Height = 17
    Caption = 'Considerar per'#237'odo geral'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = chkPeriodoGeralClick
  end
  object dsVendas: TDataSource
    DataSet = cdsVendas
    Left = 480
    Top = 40
  end
  object dsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 480
    Top = 88
  end
  object cdsVendas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 40
    object cdsVendasCODGRUPO: TIntegerField
      FieldName = 'CODGRUPO'
    end
    object cdsVendasGRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 60
    end
    object cdsVendasPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 150
    end
    object cdsVendasQTDE: TFloatField
      FieldName = 'QTDE'
      DisplayFormat = ' ,0.000;-,0.000'
    end
    object cdsVendasVLR_UNI: TFloatField
      FieldName = 'VLR_UNI'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object cdsVendasVLR_TOTAL_IT: TFloatField
      FieldName = 'VLR_TOTAL_IT'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object cdsVendasVLR_TOTAL_AD: TFloatField
      FieldName = 'VLR_TOTAL_AD'
      DisplayFormat = ' ,0.00;-,0.00'
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2015 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 568
    Top = 88
  end
  object qryPedidos: TFDQuery
    SQL.Strings = (
      'select ped.codigo, ped.couvert, ped.taxa_servico, ped.desconto'
      ''
      'from pedidos ped'
      ''
      'left join itens i on i.codigo_pedido = ped.codigo'
      'left join produtos p on p.codigo = i.codigo_produto'
      'left join grupos gr on gr.codigo = p.codigo_grupo'
      ''
      'where ped.situacao = '#39'F'#39' and (ped.data between :dti and :dtf)'
      
        '  and (iif( (ped.data <> :dti) or ((ped.data = :dti)and(i.hora >' +
        ' '#39'07:00:00'#39')) ,1,0) = 1)'
      
        '  and (iif( (ped.data <> :dtf) or ((ped.data = :dtf)and(i.hora <' +
        ' '#39'07:00:00'#39')) ,1,0) = 1)'
      ''
      
        'group by ped.codigo, ped.couvert, ped.taxa_servico, ped.valor_to' +
        'tal, ped.desconto'
      '')
    Left = 312
    Top = 88
    ParamData = <
      item
        Name = 'DTI'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTF'
        DataType = ftDate
        ParamType = ptInput
      end>
    object qryPedidosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPedidosCOUVERT: TBCDField
      FieldName = 'COUVERT'
      Origin = 'COUVERT'
      DisplayFormat = ',0.00; ,0.00'
      Precision = 18
      Size = 2
    end
    object qryPedidosTAXA_SERVICO: TBCDField
      FieldName = 'TAXA_SERVICO'
      Origin = 'TAXA_SERVICO'
      DisplayFormat = ',0.00; ,0.00'
      Precision = 18
      Size = 2
    end
    object qryPedidosDESCONTO: TBCDField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
      DisplayFormat = ',0.00; ,0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryVendas: TFDQuery
    SQL.Strings = (
      
        'select iif( gr.codigo is null, 0, gr.codigo) codgrupo , iif( gr.' +
        'descricao is null, '#39'SERVI'#199'O'#39', gr.descricao) grupo ,'
      ' p.descricao produto,'
      'sum( iif(i.quantidade > 599, 0, i.quantidade )) qtde,'
      'sum(i.valor_unitario) vlr_uni,'
      
        ' sum(i.valor_unitario * i.quantidade) vlr_total_it, i.qtd_fracio' +
        'nado,'
      
        '( select sum(i.quantidade * ait.quantidade * ait.valor_unitario ' +
        ') from adicionais_item ait'
      '    where ait.codigo_item = i.codigo ) vlr_total_ad'
      ''
      'from pedidos ped'
      ''
      'left join itens i on i.codigo_pedido = ped.codigo'
      'left join produtos p on p.codigo = i.codigo_produto'
      'left join grupos gr on gr.codigo = p.codigo_grupo'
      ''
      'where ped.situacao = '#39'F'#39' and (ped.data between :dti and :dtf)'
      ''
      
        'group by gr.codigo , gr.descricao , p.descricao, i.codigo, i.qua' +
        'ntidade, i.qtd_fracionado'
      'order by 1'
      '')
    Left = 312
    Top = 32
    ParamData = <
      item
        Name = 'DTI'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTF'
        DataType = ftDate
        ParamType = ptInput
      end>
    object qryVendasCODGRUPO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CODGRUPO'
      Origin = 'CODGRUPO'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryVendasGRUPO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'GRUPO'
      Origin = 'GRUPO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryVendasPRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTO'
      Origin = 'PRODUTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryVendasQTDE: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'QTDE'
      Origin = 'QTDE'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = ' ,0.000;-,0.000'
      Precision = 18
    end
    object qryVendasVLR_UNI: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VLR_UNI'
      Origin = 'VLR_UNI'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = ',0.00; ,0.00'
      Precision = 18
    end
    object qryVendasQTD_FRACIONADO: TIntegerField
      FieldName = 'QTD_FRACIONADO'
    end
    object qryVendasVLR_TOTAL_IT: TFMTBCDField
      FieldName = 'VLR_TOTAL_IT'
      Size = 0
    end
    object qryVendasVLR_TOTAL_AD: TFMTBCDField
      FieldName = 'VLR_TOTAL_AD'
      Size = 0
    end
  end
end
