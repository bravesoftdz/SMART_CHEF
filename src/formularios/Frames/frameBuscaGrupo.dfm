object buscaGrupo: TbuscaGrupo
  Left = 0
  Top = 0
  Width = 448
  Height = 56
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 2
    Top = -1
    Width = 47
    Height = 21
    Caption = 'C'#243'digo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 100
    Top = -1
    Width = 41
    Height = 21
    Caption = 'Grupo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtCodigo: TCurrencyEdit
    Left = 1
    Top = 18
    Width = 64
    Height = 21
    AutoSize = False
    DisplayFormat = '0'
    TabOrder = 2
    OnChange = edtCodigoChange
    OnExit = edtCodigoExit
  end
  object btnBusca: TBitBtn
    Left = 71
    Top = 16
    Width = 25
    Height = 25
    Glyph.Data = {
      36080000424D3608000000000000360000002800000020000000100000000100
      2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004D74AB0023417900C5ABA7009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B00001047000000150061474300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004173AF00008EEC00009AF4001F4B80009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B00000F4B00002A88000036900000001C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FEFFFF002F6EB2002BA7F50016C0FF0000A0F300568BC3009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009A9B9B00000A4E0000439100005C9B00003C8F0000275F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFF
      FF002974BB0068C4F8006BD4FF00279CE6006696C800FFFFFF009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009A9B
      9B00001057000460940007709B0000388200023264009B9B9B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003D8F
      D500A4E3FE00B5EEFF004CAAE700669DD200FFFFFF00FFFFFF009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00002B
      7100407F9A00518A9B000046830002396E009B9B9B009B9B9B00FFFFFF00FFFF
      FF00FEFEFE00A18889008A6A6A0093736E0086656700B0959500BAA8B100359E
      E800BDF5FF0077C4EF0063A1DA00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
      9B009A9A9A003D242500260606002F0F0A00220103004C31310056444D00003A
      840059919B0013608B00003D76009B9B9B009B9B9B009B9B9B00FFFFFF00D7CD
      CD007E585700DFD3CB00FFFFF700FFFFE700FFFEDB00D6BB9E0090584D00817B
      8E001794E4006BB5E900FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B007369
      69001A0000007B6F67009B9B93009B9B83009B9A770072573A002C0000001D17
      2A0000308000075185009B9B9B009B9B9B009B9B9B009B9B9B00EDE9E9008865
      6500FFFFFF00FFFFFF00FDF8E800FAF2DC00F8EDCF00FFF1CF00F6DEBA009F59
      4500C0C7D500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00898585002401
      01009B9B9B009B9B9B0099948400968E780094896B009B8D6B00927A56003B00
      00005C6371009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00A3888900F6EF
      EA00FFFFFF00FEFBF500FBF7E800F9F4DA00F5EBCC00E6CEAC00F3DAB800E2BD
      9900AB8B8E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003F242500928B
      86009B9B9B009A979100979384009590760091876800826A48008F7654007E59
      350047272A009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0093767400FFFF
      FF00FDFBF100FCF8EE00FAF3E100FCF5E300F7F0D700F0DFC100E7C9A900F0D1
      AB00A87E7500F8F6F600FFFFFF00FFFFFF00FFFFFF00FFFFFF002F1210009B9B
      9B0099978D0098948A00968F7D0098917F00938C73008C7B5D00836545008C6D
      4700441A1100949292009B9B9B009B9B9B009B9B9B009B9B9B00997D7A00FFFF
      FC00F9F2E100FAF3DE00FAF7E500FAF1DC00F1DFC000EDD9BA00ECD8B900EDCA
      A500AF867900EDE8E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00351916009B9B
      9800958E7D00968F7A0096938100968D78008D7B5C0089755600887455008966
      41004B221500898485009B9B9B009B9B9B009B9B9B009B9B9B009C807B00FFFF
      EB00F9EED500FAF1D700F9F2DA00F2E3C600FEFBF900FFFFF000EFDFC000E9C6
      9E00B0857B00F5F2F300FFFFFF00FFFFFF00FFFFFF00FFFFFF00381C17009B9B
      8700958A7100968D7300958E76008E7F62009A9795009B9B8C008B7B5C008562
      3A004C211700918E8F009B9B9B009B9B9B009B9B9B009B9B9B00AF959600F7EA
      C800F9EBCC00EFDCBE00F4E4C700F0E1C500FDFCEC00FAF5DD00EFDCBC00DFB0
      8700B59A9A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004B3132009386
      6400958768008B785A00908063008C7D610099988800969179008B7858007B4C
      2300513636009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00DED4D700BA99
      8C00FDECC400EDD4B000E5CAA800EFDBBF00F2E3C400F2DEBC00EABF9300BB8E
      7D00E7DFE200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7073005635
      28009988600089704C00816644008B775B008E7F60008E7A5800865B2F00572A
      1900837B7E009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00CEBF
      C500BE9A8D00E6C7A500EFCBA300ECC8A200E8BE9400DCAA8600BE958500DFD6
      D700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B006A5B
      61005A362900826341008B673F0088643E00845A3000784622005A3121007B72
      73009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
      FF00E9E4E600C9B3B400B99C9300C3A09700BF9F9600CCB9B700F1EEEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
      9B0085808200654F500055382F005F3C33005B3B3200685553008D8A8B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
    NumGlyphs = 2
    TabOrder = 3
    TabStop = False
    OnClick = btnBuscaClick
  end
  object edtGrupo: TEdit
    Left = 101
    Top = 18
    Width = 335
    Height = 21
    ReadOnly = True
    TabOrder = 4
    OnEnter = edtGrupoEnter
  end
end
