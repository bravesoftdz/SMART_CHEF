inherited frmRelatorioNotasFiscaisEntrada: TfrmRelatorioNotasFiscaisEntrada
  Caption = 'Relat'#243'rio de Notas Fiscais de Entrada'
  ClientHeight = 278
  ClientWidth = 703
  OnShow = FormShow
  ExplicitWidth = 709
  ExplicitHeight = 306
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport [0]
    Left = 114
    Top = 120
    Width = 794
    Height = 1123
    Borders.Sides = sdCustom
    Borders.DrawLeft = True
    Borders.DrawTop = True
    Borders.DrawRight = True
    Borders.DrawBottom = True
    DataSource = dsNotas2
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
      Height = 91
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLLabel4: TRLLabel
        Left = 32
        Top = 29
        Width = 424
        Height = 27
        Caption = 'Relat'#243'rio de Notas Fiscais de Entrada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -23
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 488
        Top = -1
        Width = 1
        Height = 93
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = False
        Pen.Style = psClear
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 600
        Top = 16
        Width = 39
        Height = 16
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 600
        Top = 48
        Width = 39
        Height = 16
        Info = itHour
        Text = ''
      end
      object RLLabel5: TRLLabel
        Left = 543
        Top = 16
        Width = 35
        Height = 16
        Caption = 'Data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 543
        Top = 48
        Width = 35
        Height = 16
        Caption = 'Hora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand4: TRLBand
      Left = 39
      Top = 402
      Width = 716
      Height = 22
      AlignToBottom = True
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      BeforePrint = RLBand4BeforePrint
      object rlbTotalGeral: TRLLabel
        Left = 479
        Top = 2
        Width = 87
        Height = 16
        Caption = 'Total Geral >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rlbTotalGeralBeforePrint
      end
    end
    object RLSubDetail1: TRLSubDetail
      Left = 39
      Top = 265
      Width = 716
      Height = 137
      DataSource = dsNotas2
      object RLGroup1: TRLGroup
        Left = 0
        Top = 46
        Width = 716
        Height = 51
        DataFields = 'CODIGO_FORNECEDOR'
        object RLBand7: TRLBand
          Left = 0
          Top = 22
          Width = 716
          Height = 20
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Borders.Color = 9868950
          object RLDBText6: TRLDBText
            Left = 604
            Top = 1
            Width = 91
            Height = 18
            Alignment = taRightJustify
            DataField = 'VALOR_TOTAL'
            DataSource = dsNotas2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText7: TRLDBText
            Left = 146
            Top = 1
            Width = 123
            Height = 18
            DataField = 'NUM_DOCUMENTO'
            DataSource = dsNotas2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 18
            Top = 1
            Width = 38
            Height = 18
            Alignment = taCenter
            DataField = 'DATA'
            DataSource = dsNotas2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
        end
        object RLBand9: TRLBand
          Left = 0
          Top = 0
          Width = 716
          Height = 22
          BandType = btColumnHeader
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLDraw3: TRLDraw
            Left = 0
            Top = 0
            Width = 716
            Height = 20
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Brush.Color = 16119285
            Pen.Style = psClear
            Transparent = False
          end
          object RLDBText10: TRLDBText
            Left = 16
            Top = 4
            Width = 77
            Height = 15
            DataField = 'FORNECEDOR'
            DataSource = dsNotas2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3618615
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            Text = ''
          end
        end
      end
      object RLBand8: TRLBand
        Left = 0
        Top = 0
        Width = 716
        Height = 23
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 9868950
        Color = 16512227
        ParentColor = False
        Transparent = False
        object RLLabel14: TRLLabel
          Left = 0
          Top = 3
          Width = 716
          Height = 20
          Align = faBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'ENTRADAS SEM XML'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand12: TRLBand
        Left = 0
        Top = 23
        Width = 716
        Height = 23
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLLabel15: TRLLabel
          Left = 0
          Top = 0
          Width = 8
          Height = 22
          AutoSize = False
          Caption = ' '
          Color = 15652774
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLLabel10: TRLLabel
          Left = 143
          Top = 4
          Width = 51
          Height = 16
          Caption = 'N'#186' Nota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel11: TRLLabel
          Left = 7
          Top = 4
          Width = 106
          Height = 16
          Caption = 'Data de entrada'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel12: TRLLabel
          Left = 631
          Top = 4
          Width = 38
          Height = 16
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand11: TRLBand
        Left = 0
        Top = 97
        Width = 716
        Height = 20
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = 9868950
        object RLDBResult2: TRLDBResult
          Left = 555
          Top = 2
          Width = 140
          Height = 16
          Alignment = taRightJustify
          DataField = 'VALOR_TOTAL'
          DataSource = dsNotas2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2105376
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          Text = ''
        end
      end
    end
    object RLSubDetail2: TRLSubDetail
      Left = 39
      Top = 130
      Width = 716
      Height = 135
      DataSource = dsNotas
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 716
        Height = 23
        BandType = btHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = 9868950
        Color = 16512227
        ParentColor = False
        Transparent = False
        object RLLabel7: TRLLabel
          Left = 0
          Top = 3
          Width = 716
          Height = 20
          Align = faBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'ENTRADAS COM XML'
          Color = 15857895
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
      end
      object RLGroup2: TRLGroup
        Left = 0
        Top = 46
        Width = 716
        Height = 51
        DataFields = 'CODIGO_EMITENTE'
        object RLBand3: TRLBand
          Left = 0
          Top = 21
          Width = 716
          Height = 20
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          object RLDBText1: TRLDBText
            Left = 146
            Top = 2
            Width = 150
            Height = 18
            DataField = 'NUMERO_NOTA_FISCAL'
            DataSource = dsNotas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText2: TRLDBText
            Left = 12
            Top = 2
            Width = 100
            Height = 18
            Alignment = taCenter
            DataField = 'DATA_EMISSAO'
            DataSource = dsNotas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText3: TRLDBText
            Left = 650
            Top = 2
            Width = 45
            Height = 18
            Alignment = taRightJustify
            DataField = 'VALOR'
            DataSource = dsNotas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText4: TRLDBText
            Left = 246
            Top = 2
            Width = 44
            Height = 18
            Alignment = taCenter
            DataField = 'CFOPS'
            DataSource = dsNotas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
        end
        object RLBand5: TRLBand
          Left = 0
          Top = 0
          Width = 716
          Height = 21
          BandType = btColumnHeader
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLDraw2: TRLDraw
            Left = 0
            Top = 0
            Width = 716
            Height = 20
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Brush.Color = 16119285
            Pen.Style = psClear
            Transparent = False
          end
          object RLDBText5: TRLDBText
            Left = 16
            Top = 3
            Width = 77
            Height = 15
            DataField = 'FORNECEDOR'
            DataSource = dsNotas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3618615
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            Text = ''
          end
        end
      end
      object RLBand6: TRLBand
        Left = 0
        Top = 23
        Width = 716
        Height = 23
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 8
          Height = 22
          AutoSize = False
          Caption = ' '
          Color = 14150314
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLLabel1: TRLLabel
          Left = 143
          Top = 5
          Width = 51
          Height = 16
          Caption = 'N'#186' Nota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel2: TRLLabel
          Left = 7
          Top = 5
          Width = 109
          Height = 16
          Caption = 'Data de emiss'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel3: TRLLabel
          Left = 631
          Top = 5
          Width = 38
          Height = 16
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 247
          Top = 5
          Width = 40
          Height = 16
          Caption = 'CFOP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand10: TRLBand
        Left = 0
        Top = 97
        Width = 716
        Height = 20
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = 9868950
        object RLDBResult3: TRLDBResult
          Left = 605
          Top = 2
          Width = 90
          Height = 16
          Alignment = taRightJustify
          DataField = 'VALOR'
          DataSource = dsNotas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2105376
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          Text = ''
        end
      end
    end
  end
  inherited pnlPropaganda: TPanel
    Top = 243
    Width = 703
    ExplicitTop = 234
    ExplicitWidth = 702
    inherited Shape8: TShape
      Width = 701
      ExplicitWidth = 577
    end
  end
  object GroupBox1: TGroupBox
    Left = 145
    Top = 9
    Width = 291
    Height = 105
    Caption = ' Per'#237'odo '
    TabOrder = 1
    object Label2: TLabel
      Left = 141
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
      Left = 13
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
      Left = 165
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
      Width = 288
      Height = 15
      Caption = '________________________________________________'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12500670
      Font.Height = -11
      Font.Name = 'Century'
      Font.Style = []
      ParentFont = False
    end
    object dtpInicio: TDateTimePicker
      Left = 13
      Top = 40
      Width = 113
      Height = 21
      Date = 42118.383622881940000000
      Time = 42118.383622881940000000
      TabOrder = 0
    end
    object dtpFim: TDateTimePicker
      Left = 165
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
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 243
    Align = alLeft
    TabOrder = 4
    ExplicitHeight = 234
    object Shape12: TShape
      Left = 1
      Top = 1
      Width = 127
      Height = 241
      Align = alClient
      Brush.Color = 14737632
      Pen.Color = 12040119
      ExplicitHeight = 163
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 16
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
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 11
      Top = 64
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
      OnClick = BitBtn3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 450
    Top = 9
    Width = 237
    Height = 105
    Caption = ' Filtro Nota '
    TabOrder = 2
    inline BuscaNotaFiscal1: TBuscaNotaFiscal
      Left = 35
      Top = 26
      Width = 190
      Height = 65
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 35
      ExplicitTop = 26
      ExplicitWidth = 190
      ExplicitHeight = 65
      inherited StaticText1: TStaticText
        Width = 53
        Height = 21
        Font.Height = -13
        Transparent = True
        ExplicitWidth = 53
        ExplicitHeight = 21
      end
      inherited edtNrNota: TCurrencyEdit
        Top = 22
        Width = 100
        ExplicitTop = 22
        ExplicitWidth = 100
      end
      inherited btnBusca: TBitBtn
        Left = 106
        ExplicitLeft = 106
      end
      inherited StaticText2: TStaticText
        Left = 151
        Width = 16
        Height = 21
        Font.Height = -13
        Transparent = True
        Visible = False
        ExplicitLeft = 151
        ExplicitWidth = 16
        ExplicitHeight = 21
      end
      inherited edtID: TEdit
        Left = 150
        Top = 22
        Visible = False
        ExplicitLeft = 150
        ExplicitTop = 22
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 146
    Top = 132
    Width = 541
    Height = 93
    Caption = ' Filtro Fornecedor '
    TabOrder = 3
    inline buscaFornecedor1: TBuscaFornecedor
      Left = 28
      Top = 27
      Width = 513
      Height = 62
      TabOrder = 0
      ExplicitLeft = 28
      ExplicitTop = 27
      ExplicitWidth = 513
      ExplicitHeight = 62
      inherited StaticText2: TStaticText
        Left = 108
        Top = 1
        Width = 45
        Height = 21
        Font.Height = -13
        ExplicitLeft = 108
        ExplicitTop = 1
        ExplicitWidth = 45
        ExplicitHeight = 21
      end
      inherited StaticText1: TStaticText
        Top = 1
        Width = 47
        Height = 21
        Font.Height = -13
        ExplicitTop = 1
        ExplicitWidth = 47
        ExplicitHeight = 21
      end
      inherited edtCodigo: TCurrencyEdit
        Width = 70
        Height = 25
        AutoSize = True
        Font.Height = -13
        ExplicitWidth = 70
        ExplicitHeight = 25
      end
      inherited btnBusca: TBitBtn
        Left = 75
        Width = 27
        Height = 27
        ExplicitLeft = 75
        ExplicitWidth = 27
        ExplicitHeight = 27
      end
      inherited edtNome: TEdit
        Left = 108
        Width = 397
        Height = 25
        AutoSize = True
        Font.Height = -13
        ExplicitLeft = 108
        ExplicitWidth = 397
        ExplicitHeight = 25
      end
    end
  end
  object qryNotas: TFDQuery
    SQL.Strings = (
      
        'select nf.numero_nota_fiscal, nf.data_emissao, n.cfop, nf.codigo' +
        '_emitente, forn.razao fornecedor, tnf.total - tnf.subst_tributar' +
        'ia valor'
      'from notas_fiscais nf'
      'left join naturezas_operacao n on n.codigo = nf.codigo_natureza'
      'left join pessoas forn on forn.codigo = nf.codigo_emitente'
      
        'left join totais_notas_fiscais tnf on tnf.codigo_nota_fiscal = n' +
        'f.codigo'
      'where nf.entrada_saida = '#39'E'#39)
    Left = 48
    Top = 128
    object qryNotasNUMERO_NOTA_FISCAL: TIntegerField
      FieldName = 'NUMERO_NOTA_FISCAL'
      Origin = 'NUMERO_NOTA_FISCAL'
      Required = True
    end
    object qryNotasFORNECEDOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FORNECEDOR'
      Origin = 'RAZAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryNotasCODIGO_EMITENTE: TIntegerField
      FieldName = 'CODIGO_EMITENTE'
      Origin = 'CODIGO_EMITENTE'
      Required = True
    end
    object qryNotasVALOR: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = ',0.00; ,0.00'
      Precision = 18
      Size = 2
    end
    object qryNotasDATA_EMISSAO: TDateField
      FieldName = 'DATA_EMISSAO'
    end
    object qryNotasCFOPS: TStringField
      FieldName = 'CFOPS'
      Size = 50
    end
  end
  object dsNotas: TDataSource
    DataSet = qryNotas
    Left = 48
    Top = 184
  end
  object qryNotas2: TFDQuery
    SQL.Strings = (
      'select es.num_documento, es.data, es.codigo_fornecedor,'
      ' fn.razao fornecedor, es.valor_total from entrada_saida es'
      
        ' left join pessoas fn on fn.codigo = es.codigo_fornecedor       ' +
        '  '
      
        ' where not(es.codigo_fornecedor is null)                        ' +
        '  '
      
        ' group by es.num_documento, es.data, es.codigo_fornecedor, fn.ra' +
        'zao, es.valor_total'
      ' order by es.num_documento, es.codigo_fornecedor')
    Left = 112
    Top = 128
    object qryNotas2NUM_DOCUMENTO: TIntegerField
      FieldName = 'NUM_DOCUMENTO'
      Origin = 'NUM_DOCUMENTO'
    end
    object qryNotas2DATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryNotas2CODIGO_FORNECEDOR: TIntegerField
      FieldName = 'CODIGO_FORNECEDOR'
      Origin = 'CODIGO_FORNECEDOR'
    end
    object qryNotas2FORNECEDOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FORNECEDOR'
      Origin = 'RAZAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object qryNotas2VALOR_TOTAL: TSingleField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      DisplayFormat = ',0.00; ,0.00'
    end
  end
  object dsNotas2: TDataSource
    DataSet = qryNotas2
    Left = 112
    Top = 184
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2015 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 576
    Top = 104
  end
end
