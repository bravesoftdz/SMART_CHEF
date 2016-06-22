inherited frmCadastroProduto: TfrmCadastroProduto
  Left = 342
  Top = 171
  Caption = 'Cadastro de Produtos'
  ClientHeight = 551
  ClientWidth = 670
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 516
    ExplicitHeight = 516
  end
  inherited pnlBotoes: TPanel
    Height = 516
    ExplicitHeight = 516
  end
  inherited pnlPropaganda: TPanel
    Top = 516
    Width = 670
    ExplicitTop = 516
    ExplicitWidth = 670
    inherited Shape8: TShape
      Width = 668
      ExplicitWidth = 668
    end
  end
  inherited pgGeral: TPageControl
    Width = 527
    Height = 516
    ExplicitWidth = 527
    ExplicitHeight = 516
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 519
      ExplicitHeight = 485
      inherited gridConsulta: TDBGridCBN
        Left = 0
        Top = 0
        Width = 519
        Height = 435
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Produto'
            Width = 354
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Caption = 'Valor'
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 420
        Width = 222
        Align = alNone
        Visible = False
        ExplicitTop = 420
      end
    end
    inherited tsDados: TTabSheet
      ExplicitWidth = 519
      ExplicitHeight = 485
      inherited pnlDados: TPanel
        Width = 519
        Height = 485
        ExplicitWidth = 519
        ExplicitHeight = 485
        DesignSize = (
          519
          485)
        inherited lblAsterisco: TLabel [0]
          Top = 459
          Anchors = [akLeft, akBottom]
          ExplicitTop = 459
        end
        inherited lblCamposObrigatorios: TLabel [1]
          Top = 463
          Anchors = [akLeft, akBottom]
          ExplicitTop = 463
        end
        inherited Shape2: TShape
          Top = 5
          Width = 519
          Height = 481
          ExplicitTop = 5
          ExplicitWidth = 519
          ExplicitHeight = 481
        end
        object Image1: TImage
          Left = -24
          Top = 220
          Width = 546
          Height = 31
        end
        object lblRazao: TLabel
          Left = 25
          Top = 25
          Width = 119
          Height = 15
          Caption = 'Descri'#231#227'o do produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 24
          Top = 73
          Width = 29
          Height = 15
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 330
          Top = 170
          Width = 35
          Height = 15
          Caption = 'Ativo?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 12
          Top = 16
          Width = 11
          Height = 21
          AutoSize = False
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 12
          Top = 64
          Width = 11
          Height = 21
          AutoSize = False
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 12
          Top = 224
          Width = 495
          Height = 13
          Caption = 
            'Informe os itens que compoem o produto, e que podem ser removido' +
            's no pedido, pelo cliente.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 405
          Top = 23
          Width = 24
          Height = 15
          Caption = 'Tipo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 391
          Top = 14
          Width = 11
          Height = 21
          AutoSize = False
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbPrecoCusto: TStaticText
          Left = 416
          Top = 170
          Width = 86
          Height = 19
          Caption = 'Pre'#231'o de custo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 20
          Visible = False
        end
        object lbEstoque: TStaticText
          Left = 142
          Top = 170
          Width = 48
          Height = 19
          Caption = 'Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 18
          Visible = False
        end
        object StaticText1: TStaticText
          Left = 284
          Top = 124
          Width = 63
          Height = 19
          Caption = 'Tributa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 16
        end
        object lbAliquota: TStaticText
          Left = 416
          Top = 124
          Width = 82
          Height = 19
          Caption = 'Al'#237'quota ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
        end
        object edtProduto: TEdit
          Left = 25
          Top = 41
          Width = 368
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtCodigo: TEdit
          Left = 17
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
        object edtValor: TCurrencyEdit
          Left = 24
          Top = 91
          Width = 105
          Height = 21
          AutoSize = False
          DisplayFormat = ',0.00;-,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object cbAtivo: TComboBox
          Left = 330
          Top = 188
          Width = 71
          Height = 21
          Style = csDropDownList
          TabOrder = 11
          Items.Strings = (
            'SIM'
            'N'#195'O')
        end
        inline ListaGrupo: TListaCampo
          Left = 320
          Top = 72
          Width = 182
          Height = 47
          TabOrder = 5
          ExplicitLeft = 320
          ExplicitTop = 72
          ExplicitWidth = 182
          ExplicitHeight = 47
          inherited Label4: TLabel
            Left = 7
            Top = -7
            ExplicitLeft = 7
            ExplicitTop = -7
          end
          inherited staTitulo: TStaticText
            Left = 20
            ExplicitLeft = 20
          end
          inherited comListaCampo: TComboBox
            Left = 19
            Width = 163
            ExplicitLeft = 19
            ExplicitWidth = 163
          end
        end
        object gridItens: TDBGridCBN
          Left = 24
          Top = 303
          Width = 467
          Height = 156
          Hint = 
            'Pressione Ctrl + Alt + F2 para configurar as colunas'#13'Pressione C' +
            'trl + Alt + F3 para configurar as cores'#13'Pressione Ctrl + Alt + F' +
            '4 para configurar o tipo de busca'#13'Pressione Ctrl + Alt + F5 para' +
            ' recarregar o grid'
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = 14803425
          DataSource = dsMaterias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnKeyDown = gridItensKeyDown
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
              FieldName = 'CODIGO_MATERIA'
              Title.Caption = 'C'#243'digo'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Mat'#233'ria-prima'
              Width = 376
              Visible = True
            end>
        end
        inline BuscaMateriaPrima1: TBuscaMateriaPrima
          Left = 24
          Top = 253
          Width = 369
          Height = 43
          TabOrder = 13
          ExplicitLeft = 24
          ExplicitTop = 253
          ExplicitWidth = 369
          inherited StaticText1: TStaticText
            Width = 48
            Font.Color = 5460819
            Font.Style = [fsBold]
            ExplicitWidth = 48
          end
          inherited StaticText2: TStaticText
            Left = 90
            Width = 92
            Font.Color = 5460819
            Font.Style = [fsBold]
            ExplicitLeft = 90
            ExplicitWidth = 92
          end
          inherited edtCodigo: TCurrencyEdit
            Width = 57
            ExplicitWidth = 57
          end
          inherited btnBusca: TBitBtn
            Left = 61
            ExplicitLeft = 61
          end
          inherited edtMateria: TEdit
            Left = 91
            Width = 278
            ExplicitLeft = 91
            ExplicitWidth = 278
          end
        end
        object btnAddMateria: TBitBtn
          Left = 408
          Top = 267
          Width = 81
          Height = 23
          Caption = 'Adiciona'
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
            FB0021A93A001ED04E0022D5550021D3550003B82C0000A7120000A7120003B8
            2C0021D3550022D555001ED04E0021A93A00FBFDFB00FFFFFF009B9B9B009799
            970000450000006C000000710000006F00000054000000430000004300000054
            0000006F000000710000006C000000450000979997009B9B9B00FFFFFF004EB1
            5B001ECE4D0021D354001FCC4D000FCC450000AD1300FFFFFF00FFFFFF0000AD
            13000FCC45001FCC4D0021D354001ECE4D004EB15B00FFFFFF009B9B9B00004D
            0000006A0000006F00000068000000680000004900009B9B9B009B9B9B000049
            00000068000000680000006F0000006A0000004D00009B9B9B00BDDEBE0017BA
            3F0021DA5A001ECC510020D053000DC7420000BE2500FFFFFF00FFFFFF0000BE
            25000DC7420020D053001ECC510021DA5A0017BA3F00BDDEBE00597A5A000056
            00000076000000680000006C000000630000005A00009B9B9B009B9B9B00005A
            000000630000006C0000006800000076000000560000597A5A006ABC740017D1
            510020D45F000BCC4A0004CA430000C1330000BC2200FFFFFF00FFFFFF0000BD
            270000C23B0010CA4B000ECC4C0020D45F0017D151006ABC740006581000006D
            0000007000000068000000660000005D0000005800009B9B9B009B9B9B000059
            0000005E0000006600000068000000700000006D00000658100030A03F0033E6
            7A0000B62D0000AD130000AD130000AD130000AD1300FFFFFF00FFFFFF0000AD
            130000BD270000BD230000AD130000B62D0033E67A0030A14100003C00000082
            160000520000004900000049000000490000004900009B9B9B009B9B9B000049
            00000059000000590000004900000052000000821600003D000030A3430081FC
            C30000AF2100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF0000AF210081FCC40030A14200003F00001D98
            5F00004B00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
            9B009B9B9B009B9B9B009B9B9B00004B00001D986000003D00002395370085FD
            CC002AC26200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002AC2620085FDCC0023953500003100002199
            6800005E00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
            9B009B9B9B009B9B9B009B9B9B00005E0000219968000031000033933D007BFA
            C3003CD07D0071C780001EBF590021C05B000ABA4D00FFFFFF00FFFFFF0010BC
            510022C05C001EBF590071C780003CD07D007BFAC30033933D00002F00001796
            5F00006C19000D631C00005B0000005C0000005600009B9B9B009B9B9B000058
            0000005C0000005B00000D631C00006C190017965F00002F000067AB66008AE5
            B90065EAB00050DF970056DF9C0041DB8D0022C05C00FFFFFF00FFFFFF0022C0
            5C0049DC930056DF9C0050DF970065EAB0008AE5B90067AB6600034702002681
            550001864C00007B3300007B380000772900005C00009B9B9B009B9B9B00005C
            000000782F00007B3800007B330001864C002681550003470200B9D4B9004EB0
            6800AFFFEA005EE0A10056E19F0045DE970066D58900FFFFFF00FFFFFF0023C0
            5B0050E09E0056E19F005EE0A100AFFFEA004EB06800B9D4B90055705500004C
            04004B9B8600007C3D00007D3B00007A3300027125009B9B9B009B9B9B00005C
            0000007C3A00007D3B00007C3D004B9B8600004C040055705500FFFFFF004589
            45007BDCA800B6FFEF0076E5B50051DFA30066D58900FFFFFF00FFFFFF0024BF
            590056E2A80076E5B500B6FFEF007BDCA80045894500FFFFFF009B9B9B000025
            000017784400529B8B0012815100007B3F00027125009B9B9B009B9B9B00005B
            0000007E440012815100529B8B0017784400002500009B9B9B00FFFFFF00FAFD
            FA00157215006DD6A300B7FFF500AAF7E30070E0B00022C05C0022C05C0074E2
            B300ABF7E400B7FFF5006DD6A30015721500FAFDFA00FFFFFF009B9B9B009699
            9600000E000009723F00539B910046937F000C7C4C00005C0000005C0000107E
            4F0047938000539B910009723F00000E0000969996009B9B9B00FFFFFF00FFFF
            FF00F9FCF9004586450038A75E007FE1B800A9FFEC00B9FFFB00B9FFFB00A9FF
            EC007FE1B80038A75E0045864500F9FCF900FFFFFF00FFFFFF009B9B9B009B9B
            9B009598950000220000004300001B7D5400459B8800559B9700559B9700459B
            88001B7D54000043000000220000959895009B9B9B009B9B9B00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00B7CEB70067A56700247D33002887380028873800247D
            330067A56700B7CEB700FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
            9B009B9B9B009B9B9B00536A5300034103000019000000230000002300000019
            000003410300536A53009B9B9B009B9B9B009B9B9B009B9B9B00}
          NumGlyphs = 2
          TabOrder = 14
          OnClick = btnAddMateriaClick
        end
        inline ListaDepartamento: TListaCampo
          Left = 138
          Top = 72
          Width = 184
          Height = 47
          TabOrder = 4
          ExplicitLeft = 138
          ExplicitTop = 72
          ExplicitWidth = 184
          ExplicitHeight = 47
          inherited Label4: TLabel
            Left = 1
            Top = -7
            ExplicitLeft = 1
            ExplicitTop = -7
          end
          inherited staTitulo: TStaticText
            Left = 14
            ExplicitLeft = 14
          end
          inherited comListaCampo: TComboBox
            Left = 13
            Width = 167
            ExplicitLeft = 13
            ExplicitWidth = 167
          end
        end
        inline BuscaNCM1: TBuscaNCM
          Left = 4
          Top = 119
          Width = 267
          Height = 47
          TabOrder = 6
          ExplicitLeft = 4
          ExplicitTop = 119
          ExplicitWidth = 267
          ExplicitHeight = 47
          inherited Label7: TLabel
            Left = 7
            Top = -7
            ExplicitLeft = 7
            ExplicitTop = -7
          end
          inherited StaticText2: TStaticText
            Left = 152
            Top = 5
            Width = 98
            Height = 19
            Caption = 'Al'#237'quota imposto'
            Font.Color = 3815994
            Font.Height = -12
            Font.Style = [fsBold]
            ExplicitLeft = 152
            ExplicitTop = 5
            ExplicitWidth = 98
            ExplicitHeight = 19
          end
          inherited StaticText1: TStaticText
            Left = 19
            Top = 5
            Width = 31
            Height = 19
            Font.Color = 3815994
            Font.Height = -12
            Font.Style = [fsBold]
            ExplicitLeft = 19
            ExplicitTop = 5
            ExplicitWidth = 31
            ExplicitHeight = 19
          end
          inherited edtCodigo: TCurrencyEdit
            Left = 59
            Top = -2
            ExplicitLeft = 59
            ExplicitTop = -2
          end
          inherited btnBusca: TBitBtn
            Left = 120
            Top = 21
            ExplicitLeft = 120
            ExplicitTop = 21
          end
          inherited edtNCM: TEdit
            Left = 19
            Top = 23
            ExplicitLeft = 19
            ExplicitTop = 23
          end
          inherited edtAliquota: TCurrencyEdit
            Left = 152
            Top = 23
            Width = 108
            DisplayFormat = '% ,0.00;-,0.00'
            ExplicitLeft = 152
            ExplicitTop = 23
            ExplicitWidth = 108
          end
        end
        object cbTipo: TComboBox
          Left = 405
          Top = 41
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          OnChange = cbTipoChange
          OnClick = cbTipoChange
          Items.Strings = (
            'PRODUTO'
            'SERVI'#199'O')
        end
        object edtICMS: TCurrencyEdit
          Left = 416
          Top = 142
          Width = 86
          Height = 21
          AutoSize = False
          DisplayFormat = '% ,0.00;-,0.00'
          TabOrder = 8
        end
        object cbTributacao: TComboBox
          Left = 283
          Top = 142
          Width = 118
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            'Tributado'
            'Isento'
            'N'#227'o Incid'#234'ncia'
            'Substitui'#231#227'o')
        end
        object StaticText2: TStaticText
          Left = 25
          Top = 170
          Width = 48
          Height = 19
          Caption = 'Preparo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 17
        end
        object cbPreparo: TComboBox
          Left = 24
          Top = 188
          Width = 105
          Height = 21
          Style = csDropDownList
          TabOrder = 9
          Items.Strings = (
            'CHAPA'
            'FOG'#195'O'
            'FORNO'
            'FRITADEIRA'
            'FRIOS')
        end
        object edtEstoque: TCurrencyEdit
          Left = 142
          Top = 188
          Width = 77
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          Enabled = False
          TabOrder = 10
          Visible = False
        end
        object edtPrecoCusto: TCurrencyEdit
          Left = 416
          Top = 188
          Width = 86
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          TabOrder = 19
          Visible = False
        end
        object lbEstoqueMin: TStaticText
          Left = 236
          Top = 170
          Width = 75
          Height = 19
          Caption = 'Estoque M'#237'n.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 21
          Visible = False
        end
        object edtEstoqueMin: TCurrencyEdit
          Left = 236
          Top = 188
          Width = 77
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          TabOrder = 22
          Visible = False
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 215
    Top = 32
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ',0.00;-,0.00'
    end
  end
  inherited ds: TDataSource
    Left = 246
    Top = 32
  end
  object cdsMaterias: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 63
    Top = 280
    object cdsMateriasCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsMateriasCODIGO_MATERIA: TIntegerField
      FieldName = 'CODIGO_MATERIA'
    end
    object cdsMateriasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
  end
  object dsMaterias: TDataSource
    DataSet = cdsMaterias
    Left = 102
    Top = 280
  end
end
