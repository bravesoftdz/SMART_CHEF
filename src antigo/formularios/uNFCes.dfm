inherited frmNFCes: TfrmNFCes
  Left = 283
  Top = 202
  Caption = 'NFC-es'
  ClientHeight = 428
  ClientWidth = 1068
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 268
    Top = 18
    Width = 7
    Height = 17
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 148
    Top = 374
    Width = 322
    Height = 15
    Caption = 'BARRA DE ESPA'#199'O seleciona as NFC-Es para gera'#231#227'o do XML'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13603877
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 700
    Top = 374
    Width = 130
    Height = 15
    Caption = 'Registros selecionados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3881787
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object lbSelecionados: TLabel [3]
    Left = 843
    Top = 371
    Width = 8
    Height = 19
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13603877
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlPropaganda: TPanel
    Top = 393
    Width = 1068
    inherited Shape8: TShape
      Width = 1066
    end
  end
  object DBGridCBN1: TDBGridCBN
    Left = 148
    Top = 48
    Width = 908
    Height = 318
    Anchors = [akLeft, akTop, akRight]
    Color = 14803425
    DataSource = dsNFCes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridCBN1DrawColumnCell
    OnEnter = DBGridCBN1Enter
    OnKeyDown = DBGridCBN1KeyDown
    BuscaHabilitada = True
    ConfCores.Normal.CorFonte = clWindowText
    ConfCores.Normal.CorFundo = 14803425
    ConfCores.Normal.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Normal.Tipo.Color = clWindowText
    ConfCores.Normal.Tipo.Height = -11
    ConfCores.Normal.Tipo.Name = 'MS Sans Serif'
    ConfCores.Normal.Tipo.Style = []
    ConfCores.Zebrada.CorFonte = clWindowText
    ConfCores.Zebrada.CorFundo = clWhite
    ConfCores.Zebrada.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Zebrada.Tipo.Color = clWindowText
    ConfCores.Zebrada.Tipo.Height = -11
    ConfCores.Zebrada.Tipo.Name = 'MS Sans Serif'
    ConfCores.Zebrada.Tipo.Style = []
    ConfCores.Selecao.CorFonte = clWindowText
    ConfCores.Selecao.CorFundo = 16037533
    ConfCores.Selecao.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Selecao.Tipo.Color = clWindowText
    ConfCores.Selecao.Tipo.Height = -11
    ConfCores.Selecao.Tipo.Name = 'MS Sans Serif'
    ConfCores.Selecao.Tipo.Style = []
    ConfCores.Destacado.CorFonte = 8650884
    ConfCores.Destacado.CorFundo = clWhite
    ConfCores.Destacado.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Destacado.Tipo.Color = 8650884
    ConfCores.Destacado.Tipo.Height = -11
    ConfCores.Destacado.Tipo.Name = 'Lucida Console'
    ConfCores.Destacado.Tipo.Style = [fsBold]
    ConfCores.Titulo.CorFonte = clWindowText
    ConfCores.Titulo.CorFundo = clBtnFace
    ConfCores.Titulo.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Titulo.Tipo.Color = clWindowText
    ConfCores.Titulo.Tipo.Height = -11
    ConfCores.Titulo.Tipo.Name = 'MS Sans Serif'
    ConfCores.Titulo.Tipo.Style = []
    Ordenavel = True
    TipoBusca.ListarApenasEncontrados = False
    TipoBusca.QualquerParte = False
    SalvaConfiguracoes = True
    Columns = <
      item
        Expanded = False
        FieldName = 'NR_NOTA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_PEDIDO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHAVE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROTOCOLO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DH_RECEBIMENTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOTIVO'
        Width = 212
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'XML'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAG'
        Visible = False
      end>
  end
  object dtpInicio: TDateTimePicker
    Left = 148
    Top = 16
    Width = 113
    Height = 21
    Date = 42220.383775347230000000
    Time = 42220.383775347230000000
    TabOrder = 2
  end
  object dtpFim: TDateTimePicker
    Left = 284
    Top = 16
    Width = 113
    Height = 21
    Date = 42220.383775347230000000
    Time = 42220.383775347230000000
    TabOrder = 3
  end
  object btnBusca: TBitBtn
    Left = 412
    Top = 14
    Width = 101
    Height = 25
    Caption = ' Filtrar'
    TabOrder = 4
    OnClick = btnBuscaClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFB46822D09D74F0E2D9FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0933CE8
      A527AD570FBC7B4CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFCD903FEAAF30BD660EB56217FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD09446E9
      B23EC06B14BA671DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFD2994AECB849C6711BBE6B1FFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD59C4EEE
      BF53CB7820C26F22FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFD8A253F1C45FCE7E24C77A27FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAA558F2
      C866D1842ACB7F2CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFE2B88BEAC681EFC261DA983ACB7824E3BD8EFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFD6B9E9C588F3CF76EF
      C264E7B358D17D26D58C33F1DBC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFF5E5D2E5BB7CF8DB8FEEC463EFC76CF2C96CDC9337D5852CD9983CF6E7
      D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF7F0E1AC5AF8DE91F1C55DF2C666F1
      C363F4CB6AE8AF44D9851DDF9331E19F40FEFBF6FFFFFFFFFFFFFFFFFFFFFFFF
      E5B46CFBEEC3FAE8B9F7E8C6F5EEE0F3F0EAF1EDE9EEE9DBDAA964D6A259E0AB
      5DE4B061FFFFFFFFFFFFFBF3E7ECC990FEFEFAFFFFFFF6F4F3F2F3F4EEE9DFE7
      D5AAE2CFA1E6E2D7D9C9A8CFB278CAB796D3C4ADEBC68EFCF3E7E5AF54E7B75B
      E5B24EDB931ADC981EDD971EDD971EDC961ADD951BDF9920E09D29E19F2AE2A0
      29E0AA43E2AF52E4B054F9ECD3F4DBACF0CC89F1CB7DEFC56DEFC56DF0C56CF4
      CD7AF4CE7CF0C56EEFC56DEFC66DF1CA7EF2CE8BF5DBADFAECD3}
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 0
    Width = 144
    Height = 393
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'c'
    TabOrder = 5
    DesignSize = (
      144
      393)
    object Shape10: TShape
      Left = 0
      Top = 0
      Width = -3
      Height = 393
      Align = alLeft
      Brush.Color = 15724527
      Pen.Color = 12040119
      Pen.Style = psClear
    end
    object Shape12: TShape
      Left = 136
      Top = -7
      Width = -137
      Height = 399
      Anchors = [akLeft, akTop, akBottom]
      Brush.Color = 14737632
      Pen.Color = 12040119
    end
    object btnCancelar: TBitBtn
      Left = 7
      Top = 13
      Width = 123
      Height = 35
      Anchors = [akTop, akRight]
      Caption = ' Cancelar'
      TabOrder = 0
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
    object btnGerarXml: TBitBtn
      Left = 7
      Top = 61
      Width = 123
      Height = 35
      Anchors = [akTop, akRight]
      Caption = ' Gerar XML'
      Enabled = False
      TabOrder = 1
      OnClick = btnGerarXmlClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE6E8DECACDBDFEFEFDFFFFFFFFFFFEFFFFFDFFFFFFFFFFFFCFD1BFE6E6
        DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFAABAAA8938DAEF0F1F9EBEBEDBA
        BAC4B1B1BED7D7DCF8F8FB9692B1ACACAAFFFFFBFFFFFFFFFFFFFFFFFFFFFFFF
        D7D9C46058C56B60F3EDEEEC9696B13C3CAF3232B66868A3E0E2D76C64F75752
        C1DBDDC7FFFFFFFFFFFFFFFFFFFFFFE88886AE2F29F3BDBEF8FFFFF26868D458
        58F66666FF4B4BDBE0E0E2BBBBF72F27EF9390A7FFFFEEFFFFFFFFFFFFC9CBBC
        453FD77572EEFFFFFFCACAFC6969F7B2B2FBC1C1FA7D7DF9A0A0FBFEFEF96560
        EF514BD1D6D8C2FFFFFFEFF0CC716DBD3D37F2E5E5F3FFFFFF8C8CF17676F2AA
        AAF6ABABF69292F55D5DEBFDFDFDD1D2ED2D25F17D7BAFF7F8DB9E9EB74A44E2
        9F9EE8FFFFFFFBFBFE6E6EE86161F07C7CF27B7BF27070F33F3FE4E0E0F7FFFF
        FF7B76ED524BDCBFC0BC5855DD3C38E2BFC0B8FFFFFEFEFEFE5E5EE12F2FED43
        43EE4545ED3737F02525DCDCDCF6FFFFF6A5A4B9352FE9A1A1DED2D2ED4A44F0
        6E6BB9F7F8D6FFFFFF6464DC3434EC4343EE4343EC3A3AF12727D3E4E4F7F4F5
        D06461BD5955EEF5F6F9FFFFFFA3A1F43931E6A4A4A6FFFFF38080DE5E5EEE6D
        6DF26969F06B6BF45252DAF0F0EA9FA0AB3732E7B5B3EEFFFFFFFFFFFFF3F4F4
        4E49F25752C4E8E9C3B8B8EB6C6CE89191FA9191F87C7CF48E8EE7E5E6C1524E
        C8534EEFF9F9F2FFFFFFFFFFFFFFFFFFADACE7312AEC9390B3FAFAEC7171DB8B
        8BF59D9DFE6666E0D9DAE5A09EBA352DEAB4B4E6FFFFFFFFFFFFFFFFFFFFFFFF
        FAFAF86864E95B54E5EEEEEAE3E3F37D7DD96C6CD7C5C5EAFFFFF35C57E56863
        E7FBFCF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACCE37E81D4E2E2F4FFFFFFEE
        EEF5E6E6F1FFFFFFF6F6FB7F83D1C8C9E1FFFFFFFFFFFFFFFFFF}
    end
  end
  object chTodas: TCheckBox
    Left = 952
    Top = 374
    Width = 113
    Height = 17
    Caption = 'Selecionar todas'
    TabOrder = 6
    OnClick = chTodasClick
  end
  object cdsNFCes: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsNFCesAfterScroll
    Left = 252
    Top = 128
    object cdsNFCesNR_NOTA: TIntegerField
      FieldName = 'NR_NOTA'
    end
    object cdsNFCesCODIGO_PEDIDO: TIntegerField
      FieldName = 'CODIGO_PEDIDO'
    end
    object cdsNFCesCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 44
    end
    object cdsNFCesPROTOCOLO: TStringField
      FieldName = 'PROTOCOLO'
      Size = 15
    end
    object cdsNFCesDH_RECEBIMENTO: TDateTimeField
      FieldName = 'DH_RECEBIMENTO'
    end
    object cdsNFCesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 3
    end
    object cdsNFCesMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 150
    end
    object cdsNFCesXML: TBlobField
      FieldName = 'XML'
      Visible = False
    end
    object cdsNFCesTAG: TIntegerField
      FieldName = 'TAG'
    end
  end
  object dsNFCes: TDataSource
    DataSet = cdsNFCes
    Left = 284
    Top = 128
  end
end
