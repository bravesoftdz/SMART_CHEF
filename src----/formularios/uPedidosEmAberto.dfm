inherited frmPedidosEmAberto: TfrmPedidosEmAberto
  Left = 288
  Top = 178
  Caption = 'Pedidos em aberto'
  ClientHeight = 495
  ClientWidth = 853
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel [0]
    Left = 177
    Top = 17
    Width = 168
    Height = 17
    Caption = 'Lista de pedidos em aberto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 11494192
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel [1]
    Left = 177
    Top = 430
    Width = 219
    Height = 17
    Caption = 'Quantidade de pedidos encontrados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 11494192
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Label2: TLabel [2]
    Left = 521
    Top = 430
    Width = 187
    Height = 17
    Caption = 'Total dos pedidos encontrados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 11494192
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
  end
  inherited pnlPropaganda: TPanel
    Top = 460
    Width = 853
    inherited Shape8: TShape
      Width = 851
    end
  end
  object gridItens: TDBGridCBN
    Left = 176
    Top = 40
    Width = 665
    Height = 385
    Anchors = [akLeft, akTop, akBottom]
    Color = clWhite
    Ctl3D = True
    DataSource = dsPedidos
    FixedColor = 15066597
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 2960685
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    BuscaHabilitada = True
    ConfCores.Normal.CorFonte = clBlack
    ConfCores.Normal.CorFundo = clWhite
    ConfCores.Normal.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Normal.Tipo.Color = clWindowText
    ConfCores.Normal.Tipo.Height = -11
    ConfCores.Normal.Tipo.Name = 'MS Sans Serif'
    ConfCores.Normal.Tipo.Style = []
    ConfCores.Zebrada.CorFonte = clBlack
    ConfCores.Zebrada.CorFundo = 16053492
    ConfCores.Zebrada.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Zebrada.Tipo.Color = clWindowText
    ConfCores.Zebrada.Tipo.Height = -11
    ConfCores.Zebrada.Tipo.Name = 'MS Sans Serif'
    ConfCores.Zebrada.Tipo.Style = []
    ConfCores.Selecao.CorFonte = clBlack
    ConfCores.Selecao.CorFundo = clSilver
    ConfCores.Selecao.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Selecao.Tipo.Color = clWindowText
    ConfCores.Selecao.Tipo.Height = -11
    ConfCores.Selecao.Tipo.Name = 'MS Sans Serif'
    ConfCores.Selecao.Tipo.Style = [fsBold]
    ConfCores.Destacado.CorFonte = 13334580
    ConfCores.Destacado.CorFundo = clWhite
    ConfCores.Destacado.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Destacado.Tipo.Color = 8650884
    ConfCores.Destacado.Tipo.Height = -11
    ConfCores.Destacado.Tipo.Name = 'Lucida Console'
    ConfCores.Destacado.Tipo.Style = [fsBold]
    ConfCores.Titulo.CorFonte = 2960685
    ConfCores.Titulo.CorFundo = 15066597
    ConfCores.Titulo.Tipo.Charset = DEFAULT_CHARSET
    ConfCores.Titulo.Tipo.Color = clWindowText
    ConfCores.Titulo.Tipo.Height = -11
    ConfCores.Titulo.Tipo.Name = 'MS Sans Serif'
    ConfCores.Titulo.Tipo.Style = [fsBold]
    Ordenavel = True
    TipoBusca.ListarApenasEncontrados = False
    TipoBusca.QualquerParte = False
    SalvaConfiguracoes = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_COMANDA'
        Title.Caption = 'COMANDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_MESA'
        Title.Alignment = taCenter
        Title.Caption = 'MESA'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR TOTAL'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'NOME CLIENTE'
        Width = 207
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Width = 90
        Visible = True
      end>
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 460
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'c'
    TabOrder = 2
    DesignSize = (
      153
      460)
    object Shape12: TShape
      Left = 0
      Top = 0
      Width = 153
      Height = 460
      Align = alClient
      Brush.Color = 14737632
      Pen.Color = 12040119
    end
    object btnCancelaCupom: TSpeedButton
      Left = 8
      Top = 543
      Width = 123
      Height = 35
      Caption = ' Cancela cupom'
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
    object btnImprimir: TBitBtn
      Left = 10
      Top = 21
      Width = 131
      Height = 35
      Anchors = [akTop, akRight]
      Caption = ' Imprimir '
      TabOrder = 0
      OnClick = btnImprimirClick
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000C1761B00C275
        1900BD6B1300B9650400B9650400B9650400BA650400BA650400BA650400BA65
        0400BA650400BA650400BA650400BC690A00B96A1500C3791F005D1200005E11
        0000590700005501000055010000550100005601000056010000560100005601
        000056010000560100005601000058050000550600005F150000D5933D00EFB7
        3600CDC6C000E9F8FF00DBE5F600DBE8F800DBE8F800DBE8F900DBE8F800DAE7
        F800DBE7F800D8E4F500E9F6FF00CDC6C000EAA71400C0761D00712F00008B53
        000069625C0085949B0077819200778494007784940077849500778494007683
        9400778394007480910085929B0069625C00864300005C120000CD955100E8AE
        3C00DCD7D400ECE8E900ADA0A200A79B9E009E93950094898C008A8185008379
        7C007B727600685F6400ECE8E900DCD7D400E59E2000C77B250069310000844A
        00007873700088848500493C3E0043373A003A2F310030252800261D21001F15
        1800170E1200040000008884850078737000813A000063170000D0965300EAB4
        4700DCD7D400EFF0EF00DFDEDC00E1E0DF00E0DFDE00DFE0DD00E0DFDD00DFDE
        DD00DFE0DE00DBD9D900EDEDED00DCD7D400E7A62B00C9802B006C3200008650
        0000787370008B8C8B007B7A78007D7C7B007C7B7A007B7C79007C7B79007B7A
        79007B7C7A0077757500898989007873700083420000651C0000D49B5800EBB9
        5000DCD7D400ECE8E900A99D9F00A4999E009A91940092888B00897F85008279
        7C007A717700655C6200ECE8E900DCD7D400E8AC3700CC853100703700008755
        0000787370008884850045393B0040353A00362D30002E242700251B21001E15
        1800160D13000100000088848500787370008448000068210000D69E5B00EDBD
        5A00DCD7D400FFFFFF00FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00DCD7D400EAB34000D08B3400723A00008959
        0000787370009B9B9B009B9A9A009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B0078737000864F00006C270000D9A45E00F0C2
        6300DCD7D400ECE8E900A99D9F00A4999E009A91940092888B00897F85008279
        7C007A717700655C6200ECE8E900DCD7D400EDB74900D2903A00754000008C5E
        0000787370008884850045393B0040353A00362D30002E242700251B21001E15
        1800160D1300010000008884850078737000895300006E2C0000D8A35C00F0C6
        6D00DCD7D400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00DCD7D400EEBD5400D7963E00743F00008C62
        0900787370009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B00787370008A59000073320000DEAC6900F9D2
        8100C1975C009A7B600095775E0097795D0097795D0097795D0097795D009779
        5C0097795C0095775E009A7A5E00C19A6400F7CA6B00D99B44007A480500956E
        1D005D3300003617000031130000331500003315000033150000331500003315
        00003315000031130000361600005D3600009366070075370000DDAB6700F6D5
        8B00FFD05600C0A88700C8C5C900CEC6BF00CDC6C000CDC6C000CDC6BF00D6D0
        CA00D6D3D000CFCED400C0A88800FFD25D00F3CC7500DCA14800794703009271
        27009B6C00005C442300646165006A625B0069625C0069625C0069625B00726C
        6600726F6C006B6A70005C4424009B6E00008F681100783D0000DCA96600F6D9
        9300FBC85D00C2B4A200D7DEEB00DDDDDD00DCDDDE00DCDBDD00E7E8EA00C8BA
        A700A2969200C2B4A200C6BCA900FBCB6300F3D07E00E0A74C00784502009275
        2F00976400005E503E00737A87007979790078797A0078777900838486006456
        43003E322E005E503E0062584500976700008F6C1A007C430000E5B97300F6DA
        9700FBCC6200C8BAA700DDE0E900E1DFDD00E0DFDE00DFDDDC00EFF3F9009F88
        6F00E5AF47009E918900C7BDB200FDCF6A00F5D48400E3AC510081550F009276
        33009768000064564300797C85007D7B79007C7B7A007B7978008B8F95003B24
        0B00814B00003A2D250063594E00996B0600917020007F480000E9BC7500F8DD
        9E00FDCF6900CEC0AF00E3E7EF00E7E5E300E6E5E400E5E4E200F1F6FF00BAA3
        8600FFE87300B5AB9E00CAC0B800FFD26E00F9DA8E00E7B25B00855811009479
        3A00996B05006A5C4B007F838B0083817F008281800081807E008D929B00563F
        22009B840F0051473A00665C54009B6E0A0095762A00834E0000EAC07900F8E0
        9B00FBD16500D3C4AF00EAEEF600ECEBE800ECEBE900EBE9E600FBFFFF00A28E
        7800DEAF4F00A89C9500D1C7B900FFDA7800F5D88900E2A44200865C1500947C
        3700976D01006F604B00868A9200888784008887850087858200979B9B003E2A
        14007A4B0000443831006D6355009B761400917425007E400000ECC47E00FEF4
        D500FFE29000DCD7D400F5FFFF00F6FEFF00F6FEFF00F6FDFF00FFFFFF00DFDD
        DC00C8BAA700DFDDDC00E5E4E200FFDE8800E4AA4500FCF5EC0088601A009A90
        71009B7E2C0078737000919B9B00929A9B00929A9B0092999B009B9B9B007B79
        7800645643007B79780081807E009B7A24008046000098918800ECC68100F0CA
        8200F4CA7D00E8C78800EFCF9400EFD49800EDCF9200EED09200EED09300F2D3
        9600F7D79B00F6D69B00E6C48A00EBB55200FDF9F200FFFFFF0088621D008C66
        1E0090661900846324008B6B30008B703400896B2E008A6C2E008A6C2F008E6F
        32009373370092723700826026008751000099958E009B9B9B00}
      NumGlyphs = 2
    end
    object btnVoltar: TBitBtn
      Left = 10
      Top = 69
      Width = 131
      Height = 35
      Anchors = [akTop, akRight]
      Caption = ' Voltar     '
      TabOrder = 1
      OnClick = btnVoltarClick
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5650800E46A0C00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0081010000800600009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6670A00E5801A00E5781600FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B0082030000811C0000811400009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00E7690700ED9A2E00F0B03E00E26E1000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B0083050000893600008C4C00007E0A00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E96F0800EEA13900F8CB5D00E99B3600DC700E00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00850B00008A3D00009467000085370000780C00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00ED770900EFAE4A00F9D06F00F7C05400DF973700D7782100E082
        2500DC781F00DC781900DB721300DA6B0F00DA680A00D35008009B9B9B009B9B
        9B009B9B9B00891300008B4A0000956C0B00935C00007B330000731400007C1E
        00007814000078140000770E000076070000760400006F000000FFFFFF00FFFF
        FF00EE7F0A00F4BB5F00FAD88500F7C76500F6C05900EDAF4A00EAAA4100E7A5
        3500E89E2B00E7932100E4891900E2821100E37D0A00CB4B00009B9B9B009B9B
        9B008A1B0000905700009674210093630100925C0000894B0000864600008341
        0000843A0000832F0000802500007E1E00007F19000067000000FFFFFF00F188
        0C00F6C67100FCE19F00F9CE7A00F7CA6D00F6C36100F6C05500F6BA4A00F4B3
        3E00F3AA3300F1A32900F09A1F00EF921700EE8B0F00CE4E02009B9B9B008D24
        000092620D00987D3B00956A160093660900925F0000925C000092560000904F
        00008F4600008D3F00008C3600008B2E00008A2700006A000000F3971400F9DC
        9B00FEEFD000FAD78800F9D38300F8CF7700F7C86900F5C15B00F4BB5100F2B6
        4500F1AC3900F0A53000EE9D2600ED941C00EF911500D05406008F3300009578
        37009A8B6C0096732400956F1F00946B130093640500915D0000905700008E52
        00008D4800008C4100008A390000893000008B2D00006C000000F2950E00F8CF
        8700FFF9EC00FCE1AC00F9D58300F8D27F00F7CB7200F6C56300F4BD5400F3B5
        4400F2AF3B00F0A63200EF9F2600ED951D00F0971800D65908008E310000946B
        23009B958800987D480095711F00946E1B0093670E0092610000905900008F51
        00008E4B00008C4200008B3B0000893100008C33000072000000FFFFFF00F386
        0100F5C17000FFFAEC00FCE2AD00F9D17D00F8CF7A00F7C86800F6C56A00F4C2
        6100F3BB5300F2B44700F0AE3D00EFA53200F09F2000DA6009009B9B9B008F22
        0000915D0C009B968800987E4900956D1900946B16009364040092610600905E
        00008F5700008E5000008C4A00008B4100008C3B000076000000FFFFFF00FFFF
        FF00F17D0000F5BB6800FFFAEB00FBE1AD00F9CE7000F8CC7000FBE7B600FAEA
        BE00F9E2AB00F8DE9C00F6D88A00F6D47F00F6C34E00D96209009B9B9B009B9B
        9B008D190000915704009B968700977D4900956A0C0094680C00978352009686
        5A00957E4700947A38009274260092701B00925F000075000000FFFFFF00FFFF
        FF00FFFFFF00EF780000F2B35C00FEF8E400FCE7BF00F8D17C00F3A94300F1A1
        3700F0A03100EF9A2B00ED912500EC882100EC8A2100DF640F009B9B9B009B9B
        9B009B9B9B008B1400008E4F00009A94800098835B00946D18008F4500008D3D
        00008C3C00008B360000892D000088240000882600007B000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00EE700000F1AC5000FEFDF100F9D59300EA780300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B008A0C00008D4800009A998D0095712F00861400009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00ED6F0000F1AA5500FAE39F00ED8F1B00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B00890B00008D460000967F3B00892B00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ED710400EEA03100ED952500FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B00890D00008A3C0000893100009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EF830700ED820B00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B008B1F0000891E00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
    end
  end
  object edtQtdePedidos: TCurrencyEdit
    Left = 407
    Top = 429
    Width = 81
    Height = 22
    TabStop = False
    AutoSize = False
    Color = clWhite
    Ctl3D = False
    DisplayFormat = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Anchors = [akLeft, akBottom]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Visible = False
  end
  object DBEdit1: TDBEdit
    Left = 716
    Top = 429
    Width = 123
    Height = 23
    Ctl3D = False
    DataField = 'TOTAL_GERAL'
    DataSource = dsPedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  object dsPedidos: TDataSource
    DataSet = cdsPedidos
    Left = 128
    Top = 56
  end
  object qryPedidos: TZQuery
    Connection = dm.ZConnection1
    SQL.Strings = (
      
        'select ped.data, ped.codigo_comanda, ped.codigo_mesa, ped.valor_' +
        'total,'
      'ped.nome_cliente, ped.telefone'
      ''
      'from pedidos ped'
      'where ped.situacao = '#39'A'#39)
    Params = <>
    Left = 16
    Top = 56
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspPedidos'
    Left = 88
    Top = 56
    object cdsPedidosDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsPedidosCODIGO_COMANDA: TIntegerField
      FieldName = 'CODIGO_COMANDA'
    end
    object cdsPedidosCODIGO_MESA: TIntegerField
      FieldName = 'CODIGO_MESA'
    end
    object cdsPedidosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = 'R$ ,0.00; ,0.00'
    end
    object cdsPedidosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Size = 150
    end
    object cdsPedidosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 15
    end
    object cdsPedidosTOTAL_GERAL: TAggregateField
      FieldName = 'TOTAL_GERAL'
      Expression = 'SUM(VALOR_TOTAL)'
    end
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Left = 56
    Top = 56
  end
end
