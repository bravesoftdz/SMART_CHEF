inherited frmCadastroEmpresa: TfrmCadastroEmpresa
  Left = 349
  Top = 200
  Caption = 'Cadastro de Empresas'
  ClientHeight = 514
  ClientWidth = 571
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Left = 138
    Height = 479
    ExplicitLeft = 138
    ExplicitHeight = 479
  end
  inherited pnlBotoes: TPanel
    Width = 138
    Height = 479
    ExplicitWidth = 138
    ExplicitHeight = 479
  end
  inherited pnlPropaganda: TPanel
    Top = 479
    Width = 571
    ExplicitTop = 479
    ExplicitWidth = 571
    inherited Shape8: TShape
      Width = 569
      ExplicitWidth = 569
    end
  end
  inherited pgGeral: TPageControl
    Left = 144
    Width = 427
    Height = 479
    ExplicitLeft = 144
    ExplicitWidth = 427
    ExplicitHeight = 479
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        419
        448)
      inherited gridConsulta: TDBGridCBN
        Left = 0
        Top = 0
        Width = 417
        Height = 436
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 419
        Width = 222
        Align = alNone
        ExplicitTop = 419
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited pnlDados: TPanel
        Width = 419
        Height = 448
        ExplicitWidth = 419
        ExplicitHeight = 448
        DesignSize = (
          419
          448)
        inherited lblCamposObrigatorios: TLabel
          Top = 427
          Visible = False
          ExplicitTop = 427
        end
        inherited lblAsterisco: TLabel
          Top = 423
          Visible = False
          ExplicitTop = 423
        end
        inherited Shape2: TShape
          Top = 16
          Width = 418
          Height = 446
          ExplicitTop = 16
          ExplicitWidth = 418
          ExplicitHeight = 446
        end
        object Label1: TLabel
          Left = 32
          Top = 22
          Width = 73
          Height = 17
          Caption = 'Raz'#227'o social'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 32
          Top = 67
          Width = 87
          Height = 17
          Caption = 'Nome Fantasia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 164
          Top = 114
          Width = 16
          Height = 17
          Caption = 'I.E.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 32
          Top = 160
          Width = 21
          Height = 17
          Caption = 'Site'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 277
          Top = 114
          Width = 50
          Height = 17
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 138
          Top = 203
          Width = 41
          Height = 17
          Caption = 'Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 31
          Top = 291
          Width = 40
          Height = 17
          Caption = 'Estado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 30
          Top = 335
          Width = 22
          Height = 17
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 32
          Top = 245
          Width = 22
          Height = 17
          Caption = 'Rua'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 296
          Top = 245
          Width = 16
          Height = 17
          Caption = 'N'#186
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lbbairro: TLabel
          Left = 128
          Top = 290
          Width = 35
          Height = 17
          Caption = 'Bairro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 32
          Top = 203
          Width = 72
          Height = 17
          Caption = 'C'#243'd. Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lbcomp: TLabel
          Left = 31
          Top = 381
          Width = 82
          Height = 17
          Caption = 'Complemento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object edtCodigo: TEdit
          Left = 1
          Top = 0
          Width = 65
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '0'
          Visible = False
        end
        object edtRazao: TEdit
          Left = 32
          Top = 40
          Width = 354
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtFantasia: TEdit
          Left = 32
          Top = 85
          Width = 354
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        inline CpfCnpj: TMaskCpfCnpj
          Left = 24
          Top = 107
          Width = 125
          Height = 58
          TabOrder = 3
          ExplicitLeft = 24
          ExplicitTop = 107
          ExplicitWidth = 125
          inherited Label19: TLabel
            Visible = False
          end
          inherited comPessoa: TComboBox [1]
            Visible = False
          end
          inherited StaticText1: TStaticText [2]
            Visible = False
          end
          inherited StaticText2: TStaticText [3]
            Left = 9
            Width = 43
            Height = 20
            Font.Height = -13
            ExplicitLeft = 9
            ExplicitWidth = 43
            ExplicitHeight = 20
          end
          inherited edtCpf: TMaskEdit [4]
            Left = 8
            ExplicitLeft = 8
          end
        end
        object edtInscricao: TEdit
          Left = 164
          Top = 132
          Width = 96
          Height = 21
          TabOrder = 4
          OnKeyPress = edtInscricaoKeyPress
        end
        object edtSite: TEdit
          Left = 32
          Top = 177
          Width = 354
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 5
        end
        object edtFone: TMaskEdit
          Left = 278
          Top = 132
          Width = 108
          Height = 21
          EditMask = '(##)####-####;0; '
          MaxLength = 13
          TabOrder = 6
          Text = ''
        end
        object edtCidade: TEdit
          Left = 138
          Top = 220
          Width = 249
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 7
        end
        object cmbUF: TComboBox
          Left = 31
          Top = 308
          Width = 83
          Height = 21
          Style = csDropDownList
          TabOrder = 8
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MT'
            'MS'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
        end
        object edtCep: TMaskEdit
          Left = 31
          Top = 353
          Width = 82
          Height = 21
          EditMask = '#####-###;0; '
          MaxLength = 9
          TabOrder = 9
          Text = ''
        end
        object edtRua: TEdit
          Left = 32
          Top = 263
          Width = 249
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 10
        end
        object edtNumero: TEdit
          Left = 296
          Top = 263
          Width = 90
          Height = 21
          TabOrder = 11
          OnKeyPress = edtInscricaoKeyPress
        end
        object edtBairro: TEdit
          Left = 128
          Top = 308
          Width = 258
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 12
        end
        object edtCodigoCidade: TCurrencyEdit
          Left = 32
          Top = 220
          Width = 89
          Height = 22
          AutoSize = False
          Color = clWhite
          DisplayFormat = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Anchors = [akLeft, akBottom]
          ParentFont = False
          TabOrder = 13
        end
        object edtComplemento: TEdit
          Left = 31
          Top = 400
          Width = 354
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 14
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Padr'#245'es'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlPadroes: TPanel
        Left = 0
        Top = -1
        Width = 418
        Height = 454
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 0
        DesignSize = (
          418
          454)
        object Shape1: TShape
          Left = 0
          Top = 1
          Width = 418
          Height = 445
          Anchors = [akLeft, akTop, akRight, akBottom]
          Brush.Style = bsClear
          Pen.Color = 13092807
        end
        object grpPadroes: TGroupBox
          Left = 10
          Top = 297
          Width = 399
          Height = 53
          Caption = ' Padr'#245'es '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Visible = False
          DesignSize = (
            399
            53)
          object Label7: TLabel
            Left = 72
            Top = 21
            Width = 129
            Height = 17
            Caption = 'Quantidade de Mesas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object edtQuantidadeMesas: TCurrencyEdit
            Left = 210
            Top = 20
            Width = 105
            Height = 22
            AutoSize = False
            Color = clWhite
            DisplayFormat = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Anchors = [akLeft, akBottom]
            ParentFont = False
            TabOrder = 0
          end
        end
        object rgDiaCouvert: TRadioGroup
          Left = 10
          Top = 313
          Width = 399
          Height = 45
          Caption = ' Dia de couvert art'#237'stico? '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Items.Strings = (
            'Sim'
            'N'#227'o')
          ParentFont = False
          TabOrder = 2
          TabStop = True
          Visible = False
          OnClick = rgDiaCouvertClick
        end
        object gbDiaCouvert: TGroupBox
          Left = 10
          Top = 334
          Width = 399
          Height = 57
          Enabled = False
          TabOrder = 3
          Visible = False
          DesignSize = (
            399
            57)
          object Label6: TLabel
            Left = 261
            Top = 10
            Width = 35
            Height = 17
            Caption = 'Valor '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 155
            Top = 10
            Width = 48
            Height = 17
            Caption = 'Al'#237'quota'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object edtValorCouvert: TCurrencyEdit
            Left = 262
            Top = 27
            Width = 105
            Height = 22
            AutoSize = False
            Color = clWhite
            DisplayFormat = 'R$ ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Anchors = [akLeft, akBottom]
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox1: TGroupBox
          Left = 10
          Top = 154
          Width = 399
          Height = 55
          Caption = ' Pasta fecha conta das pistas de boliche '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object edtCaminhoBoliche: TEdit
            Left = 12
            Top = 22
            Width = 350
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object btnBoliche: TBitBtn
            Left = 367
            Top = 20
            Width = 27
            Height = 25
            Glyph.Data = {
              36080000424D3608000000000000360000002800000020000000100000000100
              2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00667BB7003370
              C200206DC9001E69C6001B67C6001A65C6001864C6001663C6001460C400125E
              C600105CC400105BC400105BC400105EC8001059C1005E77B60002175300000C
              5E00000965000005620000036200000162000000620000006200000060000000
              62000000600000006000000060000000640000005D0000135200284AA10080DF
              FF0041BCFF0043B8FF003FB4FF003BB1FF0036AEFF0032A9FF002EA6FF0029A1
              FF00259EFF00219AFF002097FF00209AFF00229FFF00063AA00000003D001C7B
              9B0000589B0000549B0000509B00004D9B00004A9B0000459B0000429B00003D
              9B00003A9B0000369B0000339B0000369B00003B9B0000003C002447A30079D3
              FF0040B1FE0041AEFC003FABFC0039A7FA0037A3F90033A0F9002F9CF9002C99
              F9002896F8002393F8001E8EF8001D8DF9001F92FF00053CA20000003F00156F
              9B00004D9A00004A98000047980000439600003F9500003C9500003895000035
              950000329400002F9400002A940000299500002E9B0000003E00254CA8007ED7
              FF0045B7FE0048B3FC0044B0FC0040ACFC003CA9FB0039A6FA0035A2FA00319F
              FA002D9BFA002998F9002594F9002292FB002095FF00063FA600000044001A73
              9B0000539A00004F9800004C9800004898000045970000429600003E9600003B
              9600003796000034950000309500002E970000319B0000004200254CA80084DB
              FF004CBBFE004DB8FD004AB5FD0045B1FC0041AEFC003EAAFC003AA7FA0036A4
              FA0032A0FA002D9DFA002B99FA002998FA002499FF000642AC00000044002077
              9B0000579A000054990000519900004D9800004A980000469800004396000040
              9600003C960000399600003596000034960000359B00000048002554B30080DD
              FF004EBFFE0050BDFD004FBAFD004CB6FC0046B3FC0043AFFC003FABFC003DA7
              FB0037A4FA0033A1FA002D9CFA002396FB00259BFF000642AC0000004F001C79
              9B00005B9A00005999000056990000529800004F9800004B9800004798000043
              970000409600003D9600003896000032970000379B00000048002554B300AAEC
              FF0061C9FE0053C2FD004EBDFD004AB9FD0046B5FD0042B1FC003EAEFC003AAA
              FC0036A6FB0031A3FA0036A2FB004DADFD006FC0FF001450B70000004F004688
              9B0000659A00005E9900005999000055990000519900004D9800004A98000046
              980000429700003F9600003E9700004999000B5C9B0000005300295ABC00BEF4
              FF0095DEFF0093D9FE0082D3FE0071C9FD0069C6FD0067C4FD0062C0FD005FBC
              FD006ABFFD0072C2FD007EC6FD007CC5FE0080CBFF001452BB00000058005A90
              9B00317A9B002F759A001E6F9A000D6599000562990003609900005C99000058
              9900065B99000E5E99001A62990018619A001C679B0000005700285DC200BDF5
              FF0093DFFF0094DCFE0093DAFE0091DAFE0090D8FF008DD6FF008BD4FF0087D1
              FF0083CDFF007EC8FF0076C5FF0076C4FF007BCBFF001456C20000005E005991
              9B002F7B9B0030789A002F769A002D769A002C749B0029729B0027709B00236D
              9B001F699B001A649B0012619B0012609B0017679B0000005E00285DC200C0F8
              FF0097E1FF0095DFFE0093DFFF00B4EFFF00B2EDFF00B0EBFF00AFE9FF00ACE6
              FF00A9E4FF00A7E2FF00A5E0FF00A7E1FF00A9E5FF001B5FCA0000005E005C94
              9B00337D9B00317B9A002F7B9B00508B9B004E899B004C879B004B859B004882
              9B0045809B00437E9B00417C9B00437D9B0045819B0000006600285DC200BFFB
              FF0099E5FF0098E2FF009DE9FF004881D9002B60CD002D6CD2002D6BD1002D6B
              D1002C6AD1002B6AD0002D6BD0002D6CD1002E6DD30085A9E20000005E005B97
              9B0035819B00347E9B0039859B00001D75000000690000086E0000076D000007
              6D0000066D0000066C0000076C0000086D0000096F0021457E002E6ED500D4FF
              FF00A8F1FF00A6EFFF00B1F9FF001462D200FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000A7100709B
              9B00448D9B00428B9B004D959B0000006E009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B001866D800B6E5
              FA00B3E8FB00B2E5FC00A8DEF8001667D900FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000274005281
              96004F8497004E819800447A9400000375009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00ACC8F2001F6C
              DE002B72DE002B70DE00206CDE00A2C1F000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0048648E000008
              7A00000E7A00000C7A0000087A003E5D8C009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnBolicheClick
          end
        end
        object GroupBox2: TGroupBox
          Left = 10
          Top = 218
          Width = 399
          Height = 55
          Caption = ' Pasta destino de comunica'#231#227'o com a dispensadora de comandas '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object edtCaminhoDispensadora: TEdit
            Left = 12
            Top = 22
            Width = 350
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object btnDispensadora: TBitBtn
            Left = 367
            Top = 20
            Width = 27
            Height = 25
            Glyph.Data = {
              36080000424D3608000000000000360000002800000020000000100000000100
              2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00667BB7003370
              C200206DC9001E69C6001B67C6001A65C6001864C6001663C6001460C400125E
              C600105CC400105BC400105BC400105EC8001059C1005E77B60002175300000C
              5E00000965000005620000036200000162000000620000006200000060000000
              62000000600000006000000060000000640000005D0000135200284AA10080DF
              FF0041BCFF0043B8FF003FB4FF003BB1FF0036AEFF0032A9FF002EA6FF0029A1
              FF00259EFF00219AFF002097FF00209AFF00229FFF00063AA00000003D001C7B
              9B0000589B0000549B0000509B00004D9B00004A9B0000459B0000429B00003D
              9B00003A9B0000369B0000339B0000369B00003B9B0000003C002447A30079D3
              FF0040B1FE0041AEFC003FABFC0039A7FA0037A3F90033A0F9002F9CF9002C99
              F9002896F8002393F8001E8EF8001D8DF9001F92FF00053CA20000003F00156F
              9B00004D9A00004A98000047980000439600003F9500003C9500003895000035
              950000329400002F9400002A940000299500002E9B0000003E00254CA8007ED7
              FF0045B7FE0048B3FC0044B0FC0040ACFC003CA9FB0039A6FA0035A2FA00319F
              FA002D9BFA002998F9002594F9002292FB002095FF00063FA600000044001A73
              9B0000539A00004F9800004C9800004898000045970000429600003E9600003B
              9600003796000034950000309500002E970000319B0000004200254CA80084DB
              FF004CBBFE004DB8FD004AB5FD0045B1FC0041AEFC003EAAFC003AA7FA0036A4
              FA0032A0FA002D9DFA002B99FA002998FA002499FF000642AC00000044002077
              9B0000579A000054990000519900004D9800004A980000469800004396000040
              9600003C960000399600003596000034960000359B00000048002554B30080DD
              FF004EBFFE0050BDFD004FBAFD004CB6FC0046B3FC0043AFFC003FABFC003DA7
              FB0037A4FA0033A1FA002D9CFA002396FB00259BFF000642AC0000004F001C79
              9B00005B9A00005999000056990000529800004F9800004B9800004798000043
              970000409600003D9600003896000032970000379B00000048002554B300AAEC
              FF0061C9FE0053C2FD004EBDFD004AB9FD0046B5FD0042B1FC003EAEFC003AAA
              FC0036A6FB0031A3FA0036A2FB004DADFD006FC0FF001450B70000004F004688
              9B0000659A00005E9900005999000055990000519900004D9800004A98000046
              980000429700003F9600003E9700004999000B5C9B0000005300295ABC00BEF4
              FF0095DEFF0093D9FE0082D3FE0071C9FD0069C6FD0067C4FD0062C0FD005FBC
              FD006ABFFD0072C2FD007EC6FD007CC5FE0080CBFF001452BB00000058005A90
              9B00317A9B002F759A001E6F9A000D6599000562990003609900005C99000058
              9900065B99000E5E99001A62990018619A001C679B0000005700285DC200BDF5
              FF0093DFFF0094DCFE0093DAFE0091DAFE0090D8FF008DD6FF008BD4FF0087D1
              FF0083CDFF007EC8FF0076C5FF0076C4FF007BCBFF001456C20000005E005991
              9B002F7B9B0030789A002F769A002D769A002C749B0029729B0027709B00236D
              9B001F699B001A649B0012619B0012609B0017679B0000005E00285DC200C0F8
              FF0097E1FF0095DFFE0093DFFF00B4EFFF00B2EDFF00B0EBFF00AFE9FF00ACE6
              FF00A9E4FF00A7E2FF00A5E0FF00A7E1FF00A9E5FF001B5FCA0000005E005C94
              9B00337D9B00317B9A002F7B9B00508B9B004E899B004C879B004B859B004882
              9B0045809B00437E9B00417C9B00437D9B0045819B0000006600285DC200BFFB
              FF0099E5FF0098E2FF009DE9FF004881D9002B60CD002D6CD2002D6BD1002D6B
              D1002C6AD1002B6AD0002D6BD0002D6CD1002E6DD30085A9E20000005E005B97
              9B0035819B00347E9B0039859B00001D75000000690000086E0000076D000007
              6D0000066D0000066C0000076C0000086D0000096F0021457E002E6ED500D4FF
              FF00A8F1FF00A6EFFF00B1F9FF001462D200FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000A7100709B
              9B00448D9B00428B9B004D959B0000006E009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B001866D800B6E5
              FA00B3E8FB00B2E5FC00A8DEF8001667D900FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000274005281
              96004F8497004E819800447A9400000375009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00ACC8F2001F6C
              DE002B72DE002B70DE00206CDE00A2C1F000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0048648E000008
              7A00000E7A00000C7A0000087A003E5D8C009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnDispensadoraClick
          end
        end
        object gbTaxa: TGroupBox
          Left = 10
          Top = 348
          Width = 399
          Height = 68
          Caption = ' Percentagem da taxa de servi'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Visible = False
          DesignSize = (
            399
            68)
          object Label8: TLabel
            Left = 155
            Top = 18
            Width = 48
            Height = 17
            Caption = 'Al'#237'quota'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 261
            Top = 18
            Width = 76
            Height = 17
            Caption = 'Percentagem'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object edtTaxaServico: TCurrencyEdit
            Left = 261
            Top = 36
            Width = 105
            Height = 22
            AutoSize = False
            Color = clWhite
            DisplayFormat = '% ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Anchors = [akLeft, akBottom]
            ParentFont = False
            TabOrder = 0
          end
        end
        object gbAliquotas: TGroupBox
          Left = 10
          Top = 13
          Width = 399
          Height = 130
          Caption = ' Al'#237'quotas de servi'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          DesignSize = (
            399
            130)
          object Label13: TLabel
            Left = 40
            Top = 73
            Width = 95
            Height = 17
            Caption = 'Couvert art'#237'stico'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 243
            Top = 73
            Width = 91
            Height = 17
            Caption = 'Taxa de servi'#231'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 244
            Top = 25
            Width = 101
            Height = 17
            Caption = 'Tributa'#231#227'o Tx Srv'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 41
            Top = 24
            Width = 109
            Height = 17
            Caption = 'Tributa'#231#227'o couvert'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Shape3: TShape
            Left = 196
            Top = 8
            Width = 1
            Height = 121
            Pen.Color = 12829635
          end
          object edtAliqCouvert: TCurrencyEdit
            Left = 41
            Top = 92
            Width = 109
            Height = 22
            AutoSize = False
            Color = clWhite
            DisplayFormat = '% ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Anchors = [akLeft, akBottom]
            ParentFont = False
            TabOrder = 0
          end
          object edtAliqTxServico: TCurrencyEdit
            Left = 244
            Top = 92
            Width = 114
            Height = 22
            AutoSize = False
            Color = clWhite
            DisplayFormat = '% ,0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            Anchors = [akLeft, akBottom]
            ParentFont = False
            TabOrder = 1
          end
          object cbTributacaoTxServico: TComboBox
            Left = 244
            Top = 43
            Width = 115
            Height = 25
            Style = csDropDownList
            TabOrder = 2
            Items.Strings = (
              'Tributado'
              'Isento'
              'N'#227'o Incid'#234'ncia'
              'Substitui'#231#227'o')
          end
          object cbTributacaoCouvert: TComboBox
            Left = 41
            Top = 43
            Width = 110
            Height = 25
            Style = csDropDownList
            TabOrder = 3
            Items.Strings = (
              'Tributado'
              'Isento'
              'N'#227'o Incid'#234'ncia'
              'Substitui'#231#227'o')
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 119
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 200
    end
  end
  inherited ds: TDataSource
    Left = 152
    Top = 168
  end
end
