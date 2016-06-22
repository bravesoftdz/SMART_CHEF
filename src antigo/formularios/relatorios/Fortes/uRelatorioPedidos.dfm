inherited frmRelatorioPedidos: TfrmRelatorioPedidos
  Left = 515
  Top = 99
  Caption = 'Relat'#243'rio de Pedidos'
  ClientHeight = 275
  ClientWidth = 580
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPropaganda: TPanel
    Top = 240
    Width = 580
    TabOrder = 4
    inherited Shape8: TShape
      Width = 578
    end
  end
  object RLReport1: TRLReport
    Left = 141
    Top = 235
    Width = 794
    Height = 1123
    Borders.Sides = sdCustom
    Borders.DrawLeft = True
    Borders.DrawTop = True
    Borders.DrawRight = True
    Borders.DrawBottom = True
    Borders.FixedBottom = True
    DataSource = dsPedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Visible = False
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 39
      Top = 39
      Width = 716
      Height = 108
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLDraw9: TRLDraw
        Left = 0
        Top = 55
        Width = 536
        Height = 23
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 5131854
        Pen.Style = psClear
      end
      object RLDraw1: TRLDraw
        Left = 536
        Top = 0
        Width = 180
        Height = 98
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = 5131854
        Pen.Style = psClear
      end
      object RLLabel8: TRLLabel
        Left = 160
        Top = 15
        Width = 202
        Height = 24
        Caption = 'Relat'#243'rio de Pedidos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 640
        Top = 22
        Width = 39
        Height = 16
        Alignment = taCenter
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 640
        Top = 62
        Width = 39
        Height = 16
        Alignment = taCenter
        Info = itHour
      end
      object RLLabel10: TRLLabel
        Left = 568
        Top = 62
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
      object RLLabel23: TRLLabel
        Left = 3
        Top = 80
        Width = 58
        Height = 16
        Caption = 'Per'#237'odo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbPeriodo: TRLLabel
        Left = 61
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
        Left = 568
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
        Width = 56
        Height = 16
        Caption = 'Usu'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbUsuario: TRLLabel
        Left = 61
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
    object RLGroup1: TRLGroup
      Left = 39
      Top = 172
      Width = 716
      Height = 191
      DataFields = 'CODPED'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 716
        Height = 66
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        BeforePrint = RLBand2BeforePrint
        object RLDraw3: TRLDraw
          Left = 1
          Top = 42
          Width = 716
          Height = 23
          Brush.Color = 15132390
          Pen.Style = psClear
        end
        object RLLabel1: TRLLabel
          Left = 96
          Top = 46
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
          Left = 496
          Top = 46
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
        object RLLabel6: TRLLabel
          Left = 624
          Top = 46
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
          Top = 26
          Width = 718
          Height = 16
          Caption = 
            '________________________________________________________________' +
            '______________________________________'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText8: TRLDBText
          Left = 61
          Top = 4
          Width = 58
          Height = 16
          DataField = 'CODPED'
          DataSource = dsPedidos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel5: TRLLabel
          Left = 2
          Top = 4
          Width = 57
          Height = 16
          Caption = 'PEDIDO:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText2: TRLDBText
          Left = 214
          Top = 4
          Width = 35
          Height = 16
          DataField = 'CODCOMANDA'
          DataSource = dsPedidos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel25: TRLLabel
          Left = 136
          Top = 4
          Width = 74
          Height = 16
          Caption = 'COMANDA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText3: TRLDBText
          Left = 393
          Top = 4
          Width = 41
          Height = 16
          DataField = 'MESA'
          DataSource = dsPedidos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel26: TRLLabel
          Left = 344
          Top = 4
          Width = 45
          Height = 16
          Caption = 'MESA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 24
          Top = 46
          Width = 34
          Height = 16
          Caption = 'Hora'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 442
          Top = 4
          Width = 87
          Height = 16
          Caption = 'TX. SERVI'#199'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel13: TRLLabel
          Left = 539
          Top = 4
          Width = 76
          Height = 16
          Caption = 'DESCONTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel14: TRLLabel
          Left = 632
          Top = 4
          Width = 81
          Height = 16
          Caption = 'VLR. TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText14: TRLDBText
          Left = 419
          Top = 23
          Width = 101
          Height = 16
          Alignment = taRightJustify
          DataField = 'TAXA_SERVICO'
          DataSource = dsPedidos
          Transparent = False
        end
        object RLDBText15: TRLDBText
          Left = 531
          Top = 23
          Width = 76
          Height = 16
          Alignment = taRightJustify
          DataField = 'DESCONTO'
          DataSource = dsPedidos
          Transparent = False
        end
        object RLDBText16: TRLDBText
          Left = 609
          Top = 23
          Width = 95
          Height = 16
          Alignment = taRightJustify
          DataField = 'VALOR_TOTAL'
          DataSource = dsPedidos
          Transparent = False
          BeforePrint = RLDBText16BeforePrint
        end
        object RLDBText17: TRLDBText
          Left = 137
          Top = 22
          Width = 76
          Height = 15
          DataField = 'AGRUPADAS'
          DataSource = dsPedidos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object RLGroup2: TRLGroup
        Left = 0
        Top = 66
        Width = 716
        Height = 74
        DataFields = 'CODITEM'
        object RLBand3: TRLBand
          Left = 0
          Top = 0
          Width = 716
          Height = 44
          BandType = btColumnHeader
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLDraw6: TRLDraw
            Left = 433
            Top = 23
            Width = 285
            Height = 20
            Brush.Color = 15658734
            Pen.Style = psClear
          end
          object RLDBText1: TRLDBText
            Left = 96
            Top = 5
            Width = 80
            Height = 16
            DataField = 'DESCRICAO'
            DataSource = dsPedidos
            Transparent = False
          end
          object RLDBText6: TRLDBText
            Left = 491
            Top = 5
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'QTD_ITEM'
            DataSource = dsPedidos
            Transparent = False
            BeforePrint = RLDBText6BeforePrint
          end
          object RLDBText7: TRLDBText
            Left = 639
            Top = 5
            Width = 65
            Height = 16
            Alignment = taRightJustify
            DataField = 'TOT_ITEM'
            DataSource = dsPedidos
            Transparent = False
          end
          object RLDBText4: TRLDBText
            Left = 14
            Top = 5
            Width = 41
            Height = 16
            DataField = 'HORA'
            DataSource = dsPedidos
            Transparent = False
          end
          object RLDBText12: TRLDBText
            Left = 504
            Top = 24
            Width = 43
            Height = 16
            Alignment = taJustify
            DataField = 'NOME'
            DataSource = dsPedidos
          end
          object RLLabel3: TRLLabel
            Left = 440
            Top = 24
            Width = 56
            Height = 16
            Caption = 'Usu'#225'rio:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLDraw5: TRLDraw
            Left = 0
            Top = 23
            Width = 433
            Height = 20
            Brush.Color = 15132390
            Brush.Style = bsFDiagonal
            Pen.Style = psClear
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 44
          Width = 716
          Height = 24
          GreenBarColor = clWhite
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLDBText5: TRLDBText
            Left = 128
            Top = 5
            Width = 79
            Height = 16
            DataField = 'MAT_PRIMA'
            DataSource = dsPedidos
            Transparent = False
          end
          object RLDBText9: TRLDBText
            Left = 453
            Top = 5
            Width = 105
            Height = 16
            Alignment = taRightJustify
            DataField = 'QTD_ADICIONAL'
            DataSource = dsPedidos
            Transparent = False
            BeforePrint = RLDBText9BeforePrint
          end
          object RLDBText10: TRLDBText
            Left = 601
            Top = 5
            Width = 103
            Height = 16
            Alignment = taRightJustify
            DataField = 'TOT_ADICIONAL'
            DataSource = dsPedidos
            Transparent = False
          end
          object RLDraw4: TRLDraw
            Left = 10
            Top = 4
            Width = 26
            Height = 18
            DrawKind = dkArrow
          end
          object RLDBText11: TRLDBText
            Left = 48
            Top = 5
            Width = 39
            Height = 16
            DataField = 'FLAG'
            DataSource = dsPedidos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4737096
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 39
      Top = 363
      Width = 716
      Height = 108
      GreenBarColor = clWhite
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
      object RLLabel15: TRLLabel
        Left = 376
        Top = 88
        Width = 169
        Height = 16
        Caption = 'TOTAL DOS PEDIDOS     >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbTotal: TRLLabel
        Left = 569
        Top = 88
        Width = 145
        Height = 16
        Alignment = taRightJustify
        Caption = 'TOTAL DOS PEDIDOS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw7: TRLDraw
        Left = -30
        Top = 63
        Width = 746
        Height = 22
        Brush.Color = 14540253
        Pen.Style = psClear
      end
      object RLDraw2: TRLDraw
        Left = -30
        Top = 22
        Width = 746
        Height = 22
        Brush.Color = 15329769
        Pen.Style = psClear
      end
      object rlbTxServico: TRLLabel
        Left = 655
        Top = 25
        Width = 60
        Height = 16
        Alignment = taRightJustify
        Caption = 'TxServico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbCouvert: TRLLabel
        Left = 667
        Top = 45
        Width = 47
        Height = 16
        Alignment = taRightJustify
        Caption = 'Couvert'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbDesconto: TRLLabel
        Left = 656
        Top = 65
        Width = 59
        Height = 16
        Alignment = taRightJustify
        Caption = 'Desconto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel29: TRLLabel
        Left = 376
        Top = 24
        Width = 172
        Height = 16
        Caption = 'Total Taxa Servi'#231'o          >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel30: TRLLabel
        Left = 376
        Top = 44
        Width = 172
        Height = 16
        Caption = 'Total Couvert Art'#237'stico     >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Left = 376
        Top = 65
        Width = 170
        Height = 16
        Caption = 'Total Desconto                >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel33: TRLLabel
        Left = 612
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
      object RLLabel34: TRLLabel
        Left = 612
        Top = 44
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
      object RLLabel35: TRLLabel
        Left = 614
        Top = 64
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
      object RLDraw10: TRLDraw
        Left = 598
        Top = -1
        Width = 1
        Height = 109
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 11447982
        Brush.Style = bsClear
        Pen.Style = psClear
      end
      object RLLabel20: TRLLabel
        Left = 376
        Top = 3
        Width = 174
        Height = 16
        Caption = 'Total Itens                        >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3552822
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbTotItens: TRLLabel
        Left = 664
        Top = 5
        Width = 50
        Height = 16
        Alignment = taRightJustify
        Caption = 'TotItens'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand6: TRLBand
      Left = 39
      Top = 147
      Width = 716
      Height = 25
      GreenBarColor = clWhite
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Color = 15263976
      ParentColor = False
      Transparent = False
      Visible = False
      object RLLabel17: TRLLabel
        Left = 442
        Top = 5
        Width = 87
        Height = 16
        Caption = 'TX. SERVI'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel18: TRLLabel
        Left = 539
        Top = 5
        Width = 76
        Height = 16
        Caption = 'DESCONTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel19: TRLLabel
        Left = 632
        Top = 5
        Width = 81
        Height = 16
        Caption = 'VLR. TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 240
    Align = alLeft
    TabOrder = 6
    object Shape12: TShape
      Left = 1
      Top = 1
      Width = 127
      Height = 238
      Align = alClient
      Brush.Color = 14737632
      Pen.Color = 12040119
    end
    object BitBtn1: TBitBtn
      Left = 11
      Top = 24
      Width = 105
      Height = 30
      Caption = ' Imprimir'
      TabOrder = 0
      OnClick = BitBtn1Click
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
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 72
      Width = 105
      Height = 30
      Caption = ' Cancelar'
      TabOrder = 1
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
    end
  end
  object rgpSituacao: TRadioGroup
    Left = 425
    Top = 16
    Width = 144
    Height = 105
    Caption = ' Situa'#231#227'o '
    ItemIndex = 0
    Items.Strings = (
      'Finalizados'
      'Abertos')
    TabOrder = 1
  end
  object grpComanda: TGroupBox
    Left = 142
    Top = 126
    Width = 275
    Height = 64
    TabOrder = 2
    inline ListaComanda: TListaCampo
      Left = 58
      Top = 17
      Width = 145
      Height = 41
      TabOrder = 0
      inherited Label4: TLabel
        Left = 97
      end
      inherited staTitulo: TStaticText
        Top = 0
        Transparent = False
      end
      inherited comListaCampo: TComboBox
        Top = 16
        Width = 139
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 143
    Top = 16
    Width = 273
    Height = 105
    Caption = ' Per'#237'odo '
    TabOrder = 0
    object Label2: TLabel
      Left = 132
      Top = 40
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
    object Label3: TLabel
      Left = 12
      Top = 22
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
    object Label4: TLabel
      Left = 148
      Top = 22
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
    object Label1: TLabel
      Left = 1
      Top = 67
      Width = 270
      Height = 15
      Caption = '_____________________________________________'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12500670
      Font.Height = -11
      Font.Name = 'Century'
      Font.Style = []
      ParentFont = False
    end
    object dtpInicio: TDateTimePicker
      Left = 12
      Top = 40
      Width = 113
      Height = 21
      Date = 42118.383622881940000000
      Time = 42118.383622881940000000
      TabOrder = 0
    end
    object dtpFim: TDateTimePicker
      Left = 148
      Top = 40
      Width = 113
      Height = 21
      Date = 42118.383718449080000000
      Time = 42118.383718449080000000
      TabOrder = 1
    end
    object chkPeriodoGeral: TCheckBox
      Left = 42
      Top = 83
      Width = 198
      Height = 17
      Caption = 'Considerar per'#237'odo geral'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object grpLeiaute: TRadioGroup
    Left = 425
    Top = 126
    Width = 144
    Height = 107
    Caption = ' Leiaute '
    ItemIndex = 0
    Items.Strings = (
      'Anal'#237'tico'
      'Sint'#233'tico')
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 142
    Top = 192
    Width = 275
    Height = 41
    TabOrder = 7
    object chkAgrupadas: TCheckBox
      Left = 16
      Top = 16
      Width = 249
      Height = 17
      Caption = 'Somente pedidos com comandas agrupadas'
      TabOrder = 0
    end
  end
  object qryPedidos: TZQuery
    Connection = dm.ZConnection1
    SQL.Strings = (
      
        'select ped.data, ped.codigo CODPED, ped.codigo_comanda CODCOMAND' +
        'A, ped.codigo_mesa MESA, ped.couvert, ped.taxa_servico,'
      
        '       ped.valor_total, pro.descricao, i.hora, i.quantidade qtd_' +
        'item, (i.quantidade * i.valor_unitario) tot_item,  ped.desconto,' +
        '    '
      
        '       iif(ait.flag = '#39'A'#39', '#39'Adiciona'#39', '#39'Remove'#39') flag, usu.nome,' +
        '  map.descricao mat_prima, i.codigo CODITEM,     '
      
        '       ait.quantidade qtd_Adicional, (ait.quantidade * ait.valor' +
        '_unitario) tot_Adicional, ped.agrupadas                         ' +
        '      '
      'from itens i'
      ''
      'left join produtos         pro on pro.codigo = i.codigo_produto'
      'left join adicionais_item  ait on ait.codigo_item = i.codigo'
      
        'left join materias_primas  map on map.codigo = ait.codigo_materi' +
        'a'
      'left join pedidos          ped on ped.codigo = i.codigo_pedido'
      'left join usuarios         usu on usu.codigo = i.codigo_usuario'
      '')
    Params = <>
    Left = 360
    Top = 64
    object qryPedidosDATA: TDateField
      FieldName = 'DATA'
    end
    object qryPedidosCODPED: TIntegerField
      FieldName = 'CODPED'
      Required = True
    end
    object qryPedidosCODCOMANDA: TIntegerField
      FieldName = 'CODCOMANDA'
    end
    object qryPedidosMESA: TIntegerField
      FieldName = 'MESA'
    end
    object qryPedidosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 150
    end
    object qryPedidosQTD_ITEM: TFloatField
      FieldName = 'QTD_ITEM'
    end
    object qryPedidosTOT_ITEM: TFloatField
      FieldName = 'TOT_ITEM'
      ReadOnly = True
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosMAT_PRIMA: TStringField
      FieldName = 'MAT_PRIMA'
      Size = 100
    end
    object qryPedidosQTD_ADICIONAL: TSmallintField
      FieldName = 'QTD_ADICIONAL'
    end
    object qryPedidosTOT_ADICIONAL: TFloatField
      FieldName = 'TOT_ADICIONAL'
      ReadOnly = True
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosHORA: TTimeField
      FieldName = 'HORA'
    end
    object qryPedidosCODITEM: TIntegerField
      FieldName = 'CODITEM'
      Required = True
    end
    object qryPedidosFLAG: TStringField
      FieldName = 'FLAG'
      ReadOnly = True
      Size = 8
    end
    object qryPedidosNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object qryPedidosCOUVERT: TFloatField
      FieldName = 'COUVERT'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosTAXA_SERVICO: TFloatField
      FieldName = 'TAXA_SERVICO'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      DisplayFormat = ' ,0.00;-,0.00'
    end
    object qryPedidosAGRUPADAS: TStringField
      FieldName = 'AGRUPADAS'
      Size = 80
    end
  end
  object dsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 408
    Top = 64
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2015 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 512
    Top = 112
  end
end
