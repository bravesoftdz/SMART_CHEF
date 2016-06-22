inherited frmAvisoPedidoPendente: TfrmAvisoPedidoPendente
  Left = 380
  Top = 246
  BorderIcons = []
  Caption = 'Avisos de pedidos pendentes'
  ClientHeight = 382
  ClientWidth = 672
  FormStyle = fsStayOnTop
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape [0]
    Left = 0
    Top = 48
    Width = 672
    Height = 19
    Align = alTop
    Brush.Color = 12958117
    Pen.Color = 9145227
    Pen.Style = psClear
  end
  object Shape9: TShape [1]
    Left = 0
    Top = 0
    Width = 672
    Height = 48
    Align = alTop
    Brush.Color = 11377793
    Pen.Color = 9145227
  end
  object Label2: TLabel [2]
    Left = 16
    Top = 14
    Width = 467
    Height = 17
    Caption = 
      'Imprima itens pedidos que est'#227'o pendentes, ou marque-os como imp' +
      'resso.'
    Color = 11377793
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel [3]
    Left = 176
    Top = 48
    Width = 269
    Height = 17
    Caption = '<Duplo clique> seleciona o registro desejado'
    Color = 11377793
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  inherited pnlPropaganda: TPanel
    Top = 347
    Width = 672
    ExplicitTop = 347
    ExplicitWidth = 672
    inherited Shape8: TShape
      Width = 670
      ExplicitWidth = 670
    end
  end
  object gridItens: TDBGridCBN
    Left = 176
    Top = 74
    Width = 484
    Height = 169
    Hint = 
      'Pressione Ctrl + Alt + F2 para configurar as colunas'#13'Pressione C' +
      'trl + Alt + F3 para configurar as cores'#13'Pressione Ctrl + Alt + F' +
      '4 para configurar o tipo de busca'#13'Pressione Ctrl + Alt + F5 para' +
      ' recarregar o grid'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWhite
    DataSource = dsItens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = gridItensDrawColumnCell
    OnDblClick = gridItensDblClick
    BuscaHabilitada = True
    ConfCores.Normal.CorFonte = clWindowText
    ConfCores.Normal.CorFundo = clWhite
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
    Ordenavel = False
    TipoBusca.ListarApenasEncontrados = False
    TipoBusca.QualquerParte = False
    SalvaConfiguracoes = False
    Columns = <
      item
        Expanded = False
        FieldName = 'MESA'
        Title.Caption = 'Mesa'
        Width = 37
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRODUTO'
        Title.Caption = 'Produto'
        Width = 289
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Title.Caption = 'Qtde'
        Width = 37
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORA'
        Title.Caption = 'Hora Pedido'
        Width = 80
        Visible = True
      end>
  end
  object gridAdicionais: TDBGridCBN
    Left = 176
    Top = 253
    Width = 484
    Height = 86
    Hint = 
      'Pressione Ctrl + Alt + F2 para configurar as colunas'#13'Pressione C' +
      'trl + Alt + F3 para configurar as cores'#13'Pressione Ctrl + Alt + F' +
      '4 para configurar o tipo de busca'#13'Pressione Ctrl + Alt + F5 para' +
      ' recarregar o grid'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWhite
    DataSource = dsAdicionais
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    BuscaHabilitada = True
    ConfCores.Normal.CorFonte = clWindowText
    ConfCores.Normal.CorFundo = clWhite
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
    Ordenavel = False
    TipoBusca.ListarApenasEncontrados = False
    TipoBusca.QualquerParte = False
    SalvaConfiguracoes = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ACAO'
        Title.Caption = 'A'#231#227'o'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Title.Caption = 'Qtde'
        Width = 37
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MATERIA'
        Title.Caption = 'Mat'#233'ria'
        Width = 331
        Visible = True
      end>
  end
  object rgAcoes: TRadioGroup
    Left = 8
    Top = 70
    Width = 161
    Height = 97
    ItemIndex = 0
    Items.Strings = (
      'Imprimir'
      'Marcar como impresso')
    TabOrder = 3
    OnClick = rgAcoesClick
  end
  object btnExecutar: TBitBtn
    Left = 8
    Top = 177
    Width = 161
    Height = 35
    Caption = ' Executar'
    Glyph.Data = {
      36080000424D3608000000000000360000002800000020000000100000000100
      2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00BBE4C20070CF850027B747001EBA40001EBA400027B7
      470070CF8500BBE4C200FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
      9B009B9B9B009B9B9B0057805E000C6B21000053000000560000005600000053
      00000C6B210057805E009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
      FF00FAFDFA004FB9620019C140001FCE4C0024DC580027DD5C0027DD5C0024DC
      58001FCE4C0019C140004FB96200FAFDFA00FFFFFF00FFFFFF009B9B9B009B9B
      9B009699960000550000005D0000006A00000078000000790000007900000078
      0000006A0000005D000000550000969996009B9B9B009B9B9B00FFFFFF00FBFD
      FB0021A93A001ED04E0021D4540020D0530004B62A0018C440001DCE4A0018C8
      440020D1510021D454001ED04E0021A93A00FBFDFB00FFFFFF009B9B9B009799
      970000450000006C000000700000006C00000052000000600000006A00000064
      0000006D000000700000006C000000450000979997009B9B9B00FFFFFF004EB1
      5B001ECE4D0022D4560015C948001CAC2F009DD2A10037AF460014C13B001FD2
      4E001ECE4B001ECD4A0020D253001ECE4D004EB15B00FFFFFF009B9B9B00004D
      0000006A0000007000000065000000480000396E3D00004B0000005D0000006E
      0000006A000000690000006E0000006A0000004D00009B9B9B00BDDEBE0017BA
      3F0021D85A0013C6460012A82600F2F4EC00FFFFFF00EAF2E60026AA38000DC0
      390020D24F001ECE49001DCD4D0020D7580017BA3F00BDDEBE00597A5A000056
      00000074000000620000004400008E9088009B9B9B00868E820000460000005C
      0000006E0000006A0000006900000073000000560000597A5A006ABC740018D1
      520014CB4E000BA01E00F2F4EC00FFFBFF00FFFAFF00FFFFFF00EAF2E60023A8
      35000BC03A001ED359001CCF53001ED2580018CF51006ABC740006581000006D
      000000670000003C00008E9088009B979B009B969B009B9B9B00868E82000044
      0000005C0000006F0000006B0000006E0000006B00000658100030A03F002DE1
      72001BA82D00F2F4EC00FFF8FF00EAF2E600A9D5A400EEF2EB00FFFFFF00D0EB
      D30023A834000AC2420018D6620013CF540030E1730030A14100003C0000007D
      0E00004400008E9088009B949B00868E8200457140008A8E87009B9B9B006C87
      6F0000440000005E000000720000006B0000007D0F00003D000030A3430065EA
      A10058B25C00EAF2E600EAF2E6000EB42F0000BF30003AB64900F2F4EC00FFFF
      FF00EAF2E60023A8330007C13D0024D8690073F0B10030A14200003F00000186
      3D00004E0000868E8200868E820000500000005B0000005200008E9088009B9B
      9B00868E820000440000005D0000007405000F8C4D00003D00002395370078F4
      BC0049CD7A0074BF7F002DB64C0024D367002ED8720019CC5A0048B55800EAF2
      E600FFFFFF00EAF2E60026A7310025D0600077F6BE0023953500003100001490
      580000691600105B1B0000520000006F030000740E000068000000510000868E
      82009B9B9B00868E820000430000006C000013925A000031000033933D0071F2
      B50061E4A8004CDB95005BE1A50061DEA50063DDA40063E2AB004DDA96004FB8
      6000EEF2E800FFFFFF00EAF2E6002AB343006DF0B30033933D00002F00000D8E
      51000080440000773100007D4100007A410000794000007E4700007632000054
      00008A8E84009B9B9B00868E8200004F0000098C4F00002F000067AB660086E3
      B50062E7A9005DE2A40060E2A6005FE1A6005FE1A6005EE1A50063E5AD004CDA
      95004DB75E00EAF0E500FFFFFF0061BC650080DFAE0067AB660003470200227F
      510000834500007E4000007E4200007D4200007D4200007D4100008149000076
      310000530000868C81009B9B9B00005801001C7B4A0003470200B9D4B9004EB0
      6800A8FCE1005FE1A20057E09F005BE0A3005DE1A4005DE1A4005DE1A40061E5
      AB004EDC970048BA60005DC2700096EABF004EB06800B9D4B90055705500004C
      040044987D00007D3E00007C3B00007C3F00007D4000007D4000007D40000081
      47000078330000560000005E0C0032865B00004C040055705500FFFFFF004589
      45007BDBA700B0FCE80076E5B50062E3AA005EE0A6005EE1A6005EE1A6005EE0
      A50066E6B0006FE3AF00A7F9E0007ADCA80045894500FFFFFF009B9B9B000025
      0000177743004C98840012815100007F4600007C4200007D4200007D4200007C
      410002824C000B7F4B0043957C0016784400002500009B9B9B00FFFFFF00FAFD
      FA00157215006DD6A300B3FDF000A4F5DF008CE9C7008CE8C4008AE7C2008DE9
      C600A5F5DE00B3FDF0006DD6A30015721500FAFDFA00FFFFFF009B9B9B009699
      9600000E000009723F004F998C0040917B00288563002884600026835E002985
      620041917A004F998C0009723F00000E0000969996009B9B9B00FFFFFF00FFFF
      FF00F9FCF9004586450038A75E007FE1B800A9FFEC00B9FFFB00B9FFFB00A9FF
      EC007FE1B80038A75E0045864500F9FCF900FFFFFF00FFFFFF009B9B9B009B9B
      9B009598950000220000004300001B7D5400459B8800559B9700559B9700459B
      88001B7D54000043000000220000959895009B9B9B009B9B9B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B7CEB70067A56700247D33002887380028873800247D
      330067A56700B7CEB700FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
      9B009B9B9B009B9B9B00536A5300034103000019000000230000002300000019
      000003410300536A53009B9B9B009B9B9B009B9B9B009B9B9B00}
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnExecutarClick
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsItensAfterScroll
    Left = 176
    Top = 93
    object cdsItensMESA: TIntegerField
      FieldName = 'MESA'
    end
    object cdsItensPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsItensHORA: TStringField
      FieldName = 'HORA'
    end
    object cdsItensCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsItensCODIGO_PEDIDO: TIntegerField
      FieldName = 'CODIGO_PEDIDO'
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 216
    Top = 93
  end
  object cdsAdicionais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 277
    object cdsAdicionaisACAO: TStringField
      FieldName = 'ACAO'
      Size = 10
    end
    object cdsAdicionaisQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsAdicionaisMATERIA: TStringField
      FieldName = 'MATERIA'
      Size = 100
    end
    object cdsAdicionaisCODIGO_ITEM: TIntegerField
      FieldName = 'CODIGO_ITEM'
    end
  end
  object dsAdicionais: TDataSource
    DataSet = cdsAdicionais
    Left = 216
    Top = 277
  end
  object cdsSelecionados: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsItensAfterScroll
    Left = 392
    Top = 88
    object cdsSelecionadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 8
    Top = 216
  end
end
