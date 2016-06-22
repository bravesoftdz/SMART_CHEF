inherited frmEntradaSaidaMercadoria: TfrmEntradaSaidaMercadoria
  Left = 421
  Top = 197
  Caption = 'Entrada e sa'#237'da de mercadoria'
  ClientHeight = 518
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPropaganda: TPanel
    Top = 483
    TabOrder = 3
  end
  object rgpOperacao: TRadioGroup
    Left = 0
    Top = 0
    Width = 589
    Height = 57
    Align = alTop
    Caption = ' Selecione a opera'#231#227'o a ser executada '
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3552822
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      ' Entrada de mercadoria'
      ' Sa'#237'da de mercadoria')
    ParentFont = False
    TabOrder = 0
    OnClick = rgpOperacaoClick
  end
  object rgpTipo: TRadioGroup
    Left = 0
    Top = 145
    Width = 589
    Height = 32
    Align = alTop
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Produto'
      'Dispensa')
    TabOrder = 2
    OnClick = rgpTipoClick
  end
  inline BuscaDispensa1: TBuscaDispensa
    Left = 0
    Top = 177
    Width = 589
    Height = 56
    Align = alTop
    TabOrder = 4
    Visible = False
    OnExit = BuscaDispensa1Exit
    inherited StaticText3: TStaticText
      Left = 469
      Top = 8
    end
    inherited StaticText1: TStaticText
      Left = 16
      Top = 8
    end
    inherited StaticText2: TStaticText
      Left = 109
      Top = 8
    end
    inherited edtCodigo: TCurrencyEdit
      Left = 16
      Top = 24
    end
    inherited btnBusca: TBitBtn
      Left = 81
      Top = 22
    end
    inherited edtItem: TEdit
      Left = 109
      Top = 24
    end
    inherited cmbUnidadeMedida: TComboBox
      Left = 470
      Top = 24
    end
  end
  inline BuscaProduto1: TBuscaProduto
    Left = 0
    Top = 233
    Width = 589
    Height = 56
    Align = alTop
    TabOrder = 5
    OnExit = BuscaProduto1Exit
    inherited StaticText1: TStaticText
      Left = 16
      Top = 8
    end
    inherited StaticText2: TStaticText
      Left = 109
      Top = 8
    end
    inherited edtCodigo: TCurrencyEdit
      Left = 16
      Top = 24
    end
    inherited btnBusca: TBitBtn
      Left = 81
      Top = 22
    end
    inherited edtProduto: TEdit
      Left = 109
      Top = 24
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 235
    Width = 589
    Height = 90
    Align = alBottom
    Caption = ' Situa'#231#227'o estoque '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3026478
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lbEstoque: TStaticText
      Left = 20
      Top = 23
      Width = 75
      Height = 17
      Caption = 'Estoque atual'
      Color = 15329769
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3026478
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      Transparent = False
    end
    object edtEstoque: TCurrencyEdit
      Left = 20
      Top = 40
      Width = 117
      Height = 26
      TabStop = False
      AutoSize = False
      DisplayFormat = ' ,0.00;-,0.00'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3026478
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object lbQuantidade: TStaticText
      Left = 300
      Top = 23
      Width = 66
      Height = 19
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
    object edtQuantidade: TCurrencyEdit
      Left = 300
      Top = 40
      Width = 117
      Height = 26
      AutoSize = False
      DisplayFormat = ' ,0.00;-,0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3026478
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnChange = edtQuantidadeChange
    end
    object btnAdd: TBitBtn
      Left = 461
      Top = 14
      Width = 115
      Height = 31
      Caption = 'Adicionar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnAddClick
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004EB145006DC06600FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B00004D0000095C02009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0056B24F001CC6320018B921008ECB8A00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B00004E000000620000005500002A6726009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0065B9600019C3380028E9580029E3460015B113009CD2
        9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B0001550000005F000000850000007F0000004D0000386E
        35009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF0077BF710017C5400025EB6A001FDD4C0020DC3F0029E0360013A7
        0900B8DFB500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B00135B0D0000610000008706000079000000780000007C00000043
        0000547B51009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF0070BD6A0016C7480023EF79001AE05B0033E8650032E453001FD92E002ADE
        2C000FA00400CEE9CC00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B000C59060000630000008B1500007C0000008401000080000000750000007A
        0000003C00006A8568009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF0075BF
        700015CA520020F389001CE56C0027EC6B0046D1570076E8830033E449001FD7
        22002AD821001FA41500E0F1DE00FFFFFF00FFFFFF00FFFFFF009B9B9B00115B
        0C0000660000008F25000081080000880700006D000012841F00008000000073
        000000740000004000007C8D7A009B9B9B009B9B9B009B9B9B006FC0690016CF
        5D001CF99B0017E87A0026F07D0043D3600060B4600036A92E0087F5940025DB
        2C0023DA1D0027D31F002EA72400FAFDF900FFFFFF00FFFFFF000B5C0500006B
        00000095370000841600008C1900006F00000050000000450000239130000077
        000000760000006F000000430000969995009B9B9B009B9B9B004FB1480029D6
        6A001AF99E002EFA980045D769006FBD6A00FFFFFF00E0F1E0002AAA270084F9
        8A0026D8230025DC1E0026CF1D002BA22100FFFFFF00FFFFFF00004D00000072
        060000953A0000963400007305000B5906009B9B9B007C8D7C00004600002095
        26000074000000780000006B0000003E00009B9B9B009B9B9B00FFFFFF0054B0
        4F0030D76C004ADD7A0077C07200FFFFFF00FFFFFF00FFFFFF00BFE2BF0040BA
        3E0085FC82001BD2120028DC200021C819004AAF4200FFFFFF009B9B9B00004C
        00000073080000791600135C0E009B9B9B009B9B9B009B9B9B005B7E5B000056
        000021981E00006E00000078000000640000004B00009B9B9B00FFFFFF00FFFF
        FF0063BA58004DB04400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADD9
        AD0049C2470083FF7E001BD212002AE023001FC4180060B959009B9B9B009B9B
        9B0000560000004C00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B004975
        4900005E00001F9B1A00006E0000007C00000060000000550000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0098CF98005ACB520081FF7C0023DC1D001CBF140054B44C009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B00346B3400006700001D9B180000780000005B000000500000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF006FBC6F006CDC66003AC6350066BA6600FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B000B580B000878020000620000025602009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0060BB5E008ECE8900FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B00005700002A6A25009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
    end
    object btnCancelar: TBitBtn
      Left = 461
      Top = 52
      Width = 115
      Height = 31
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnCancelarClick
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
    object StaticText6: TStaticText
      Left = 162
      Top = 23
      Width = 82
      Height = 19
      Caption = 'Pre'#231'o de custo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Transparent = False
    end
    object edtPrecoCusto: TCurrencyEdit
      Left = 162
      Top = 40
      Width = 117
      Height = 26
      TabStop = False
      AutoSize = False
      DisplayFormat = ' ,0.00;-,0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3026478
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnChange = edtPrecoCustoChange
    end
  end
  object grpInfEntrada: TGroupBox
    Left = 0
    Top = 57
    Width = 589
    Height = 88
    Align = alTop
    TabOrder = 1
    object edtNumDoc: TCurrencyEdit
      Left = 104
      Top = 16
      Width = 129
      Height = 21
      AutoSize = False
      DisplayFormat = '0'
      TabOrder = 0
    end
    object edtData: TEdit
      Left = 357
      Top = 16
      Width = 100
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object StaticText1: TStaticText
      Left = 12
      Top = 19
      Width = 84
      Height = 19
      Caption = 'N'#186' Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
    object StaticText2: TStaticText
      Left = 324
      Top = 19
      Width = 28
      Height = 19
      Caption = 'Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Transparent = False
    end
    object mmoObs: TMemo
      Left = 104
      Top = 48
      Width = 465
      Height = 33
      TabOrder = 4
    end
    object StaticText3: TStaticText
      Left = 12
      Top = 46
      Width = 66
      Height = 19
      Caption = 'Observa'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Transparent = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 325
    Width = 589
    Height = 158
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object btnExecutar: TBitBtn
      Left = 421
      Top = 114
      Width = 161
      Height = 31
      Caption = 'Executar movimenta'#231#227'o'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnExecutarClick
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004EB145006DC06600FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B00004D0000095C02009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0056B24F001CC6320018B921008ECB8A00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B00004E000000620000005500002A6726009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0065B9600019C3380028E9580029E3460015B113009CD2
        9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B0001550000005F000000850000007F0000004D0000386E
        35009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF0077BF710017C5400025EB6A001FDD4C0020DC3F0029E0360013A7
        0900B8DFB500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B00135B0D0000610000008706000079000000780000007C00000043
        0000547B51009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF0070BD6A0016C7480023EF79001AE05B0033E8650032E453001FD92E002ADE
        2C000FA00400CEE9CC00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B000C59060000630000008B1500007C0000008401000080000000750000007A
        0000003C00006A8568009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF0075BF
        700015CA520020F389001CE56C0027EC6B0046D1570076E8830033E449001FD7
        22002AD821001FA41500E0F1DE00FFFFFF00FFFFFF00FFFFFF009B9B9B00115B
        0C0000660000008F25000081080000880700006D000012841F00008000000073
        000000740000004000007C8D7A009B9B9B009B9B9B009B9B9B006FC0690016CF
        5D001CF99B0017E87A0026F07D0043D3600060B4600036A92E0087F5940025DB
        2C0023DA1D0027D31F002EA72400FAFDF900FFFFFF00FFFFFF000B5C0500006B
        00000095370000841600008C1900006F00000050000000450000239130000077
        000000760000006F000000430000969995009B9B9B009B9B9B004FB1480029D6
        6A001AF99E002EFA980045D769006FBD6A00FFFFFF00E0F1E0002AAA270084F9
        8A0026D8230025DC1E0026CF1D002BA22100FFFFFF00FFFFFF00004D00000072
        060000953A0000963400007305000B5906009B9B9B007C8D7C00004600002095
        26000074000000780000006B0000003E00009B9B9B009B9B9B00FFFFFF0054B0
        4F0030D76C004ADD7A0077C07200FFFFFF00FFFFFF00FFFFFF00BFE2BF0040BA
        3E0085FC82001BD2120028DC200021C819004AAF4200FFFFFF009B9B9B00004C
        00000073080000791600135C0E009B9B9B009B9B9B009B9B9B005B7E5B000056
        000021981E00006E00000078000000640000004B00009B9B9B00FFFFFF00FFFF
        FF0063BA58004DB04400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADD9
        AD0049C2470083FF7E001BD212002AE023001FC4180060B959009B9B9B009B9B
        9B0000560000004C00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B004975
        4900005E00001F9B1A00006E0000007C00000060000000550000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0098CF98005ACB520081FF7C0023DC1D001CBF140054B44C009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B00346B3400006700001D9B180000780000005B000000500000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF006FBC6F006CDC66003AC6350066BA6600FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B000B580B000878020000620000025602009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0060BB5E008ECE8900FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B00005700002A6A25009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
    end
    object DBGrid1: TDBGrid
      Left = 11
      Top = 8
      Width = 399
      Height = 137
      DataSource = ds
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Width = 286
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Width = 74
          Visible = True
        end>
    end
    object StaticText4: TStaticText
      Left = 468
      Top = 15
      Width = 59
      Height = 19
      Caption = '<DELETE>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8487297
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
    object StaticText5: TStaticText
      Left = 429
      Top = 31
      Width = 140
      Height = 19
      Caption = 'Remove item selecionado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8487297
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Transparent = False
    end
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 427
    object cdsCODIGO_ITEM: TIntegerField
      FieldName = 'CODIGO_ITEM'
    end
    object cdsQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object cdsCODIGO_ESTOQUE: TIntegerField
      FieldName = 'CODIGO_ESTOQUE'
    end
    object cdsUN_MEDIDA: TStringField
      FieldName = 'UN_MEDIDA'
      Size = 4
    end
    object cdsPRECO_CUSTO: TFloatField
      FieldName = 'PRECO_CUSTO'
    end
  end
  object ds: TDataSource
    DataSet = cds
    Left = 56
    Top = 427
  end
end
