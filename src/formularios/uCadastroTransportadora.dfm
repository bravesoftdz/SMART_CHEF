inherited frmCadastroTransportadora: TfrmCadastroTransportadora
  Caption = 'Cadastro de Transportadoras'
  ClientHeight = 599
  ClientWidth = 1221
  ExplicitWidth = 1227
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Left = 145
    Height = 564
    ExplicitLeft = 145
    ExplicitHeight = 564
  end
  inherited pnlBotoes: TPanel
    Width = 145
    Height = 564
    ExplicitWidth = 145
    ExplicitHeight = 564
  end
  inherited pnlPropaganda: TPanel
    Top = 564
    Width = 1221
    ExplicitTop = 564
    ExplicitWidth = 1221
    inherited Shape8: TShape
      Width = 1219
      ExplicitWidth = 1219
    end
  end
  inherited pgGeral: TPageControl
    Left = 151
    Width = 1070
    Height = 564
    ActivePage = tsDados
    ExplicitLeft = 151
    ExplicitWidth = 1070
    ExplicitHeight = 564
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 1062
      ExplicitHeight = 533
      inherited gridConsulta: TDBGridCBN
        Width = 1044
        Height = 478
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 516
        Width = 1062
        ExplicitTop = 516
        ExplicitWidth = 1062
      end
    end
    inherited tsDados: TTabSheet
      ExplicitWidth = 1062
      ExplicitHeight = 533
      inherited pnlDados: TPanel
        Width = 1062
        Height = 533
        ExplicitWidth = 1062
        ExplicitHeight = 533
        inherited lblCamposObrigatorios: TLabel
          Top = 486
          ExplicitTop = 486
        end
        inherited lblAsterisco: TLabel
          Top = 482
          ExplicitTop = 482
        end
        inherited Shape2: TShape
          Left = 3
          Top = 4
          Width = 1054
          Height = 521
          ExplicitLeft = 3
          ExplicitTop = 4
          ExplicitWidth = 1054
          ExplicitHeight = 521
        end
        object gpbDados: TGroupBox
          Left = 15
          Top = 13
          Width = 546
          Height = 191
          TabOrder = 0
          object Label1: TLabel
            Left = 17
            Top = 8
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
            Left = 17
            Top = 64
            Width = 85
            Height = 17
            Caption = 'Nome fantasia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbRgIe: TLabel
            Left = 333
            Top = 122
            Width = 10
            Height = 17
            Caption = 'IE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label33: TLabel
            Left = 505
            Top = 122
            Width = 71
            Height = 13
            Caption = 'Data cadastro'
            Visible = False
          end
          object lbIE: TLabel
            Left = 351
            Top = 113
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object Label17: TLabel
            Left = 108
            Top = -2
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtRazao: TEdit
            Left = 18
            Top = 31
            Width = 507
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 60
            ParentFont = False
            TabOrder = 0
          end
          object edtFantasia: TEdit
            Left = 18
            Top = 87
            Width = 507
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 60
            ParentFont = False
            TabOrder = 1
          end
          inline CpfCnpj: TMaskCpfCnpj
            Left = 13
            Top = 120
            Width = 297
            Height = 76
            TabOrder = 2
            ExplicitLeft = 13
            ExplicitTop = 120
            ExplicitWidth = 297
            ExplicitHeight = 76
            inherited Label19: TLabel
              Left = 167
              Font.Color = clMaroon
              ExplicitLeft = 167
            end
            inherited edtCpf: TMaskEdit
              Left = 125
              Width = 156
              Height = 23
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 125
              ExplicitWidth = 156
              ExplicitHeight = 23
            end
            inherited StaticText1: TStaticText [2]
              Left = 5
              Top = 4
              Height = 21
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Transparent = True
              ExplicitLeft = 5
              ExplicitTop = 4
              ExplicitHeight = 21
            end
            inherited comPessoa: TComboBox [3]
              Left = 5
              Width = 101
              ExplicitLeft = 5
              ExplicitWidth = 101
            end
            inherited StaticText2: TStaticText
              Left = 125
              Top = 4
              Width = 34
              Height = 21
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Transparent = True
              ExplicitLeft = 125
              ExplicitTop = 4
              ExplicitWidth = 34
              ExplicitHeight = 21
            end
          end
          object edtDataCadastro: TEdit
            Left = 505
            Top = 145
            Width = 121
            Height = 23
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 8
            ParentFont = False
            TabOrder = 3
            Visible = False
          end
          object edtIe: TEdit
            Left = 332
            Top = 145
            Width = 155
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 14
            ParentFont = False
            TabOrder = 4
          end
        end
        object gpbEndereco: TGroupBox
          Left = 15
          Top = 215
          Width = 546
          Height = 257
          Caption = ' Endere'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label4: TLabel
            Left = 17
            Top = 24
            Width = 97
            Height = 17
            Caption = 'Rua/Logradouro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 20
            Top = 82
            Width = 16
            Height = 17
            Caption = 'N'#186
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 103
            Top = 82
            Width = 35
            Height = 17
            Caption = 'Bairro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 18
            Top = 192
            Width = 82
            Height = 17
            Caption = 'Complemento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 430
            Top = 83
            Width = 22
            Height = 17
            Caption = 'CEP'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3355443
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 132
            Top = 17
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 43
            Top = 73
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label13: TLabel
            Left = 149
            Top = 73
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 98
            Top = 132
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtLogradouro: TEdit
            Left = 18
            Top = 47
            Width = 507
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 80
            ParentFont = False
            TabOrder = 0
          end
          object edtNumero: TEdit
            Left = 19
            Top = 105
            Width = 70
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
          end
          object edtBairro: TEdit
            Left = 103
            Top = 105
            Width = 315
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 50
            ParentFont = False
            TabOrder = 2
          end
          inline BuscaCidade1: TBuscaCidade
            Left = 20
            Top = 136
            Width = 523
            Height = 60
            TabOrder = 4
            ExplicitLeft = 20
            ExplicitTop = 136
            ExplicitWidth = 523
            ExplicitHeight = 60
            inherited StaticText3: TStaticText
              Left = 474
              Top = 1
              Width = 19
              Height = 21
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Transparent = True
              ExplicitLeft = 474
              ExplicitTop = 1
              ExplicitWidth = 19
              ExplicitHeight = 21
            end
            inherited StaticText2: TStaticText
              Left = 115
              Top = 1
              Width = 45
              Height = 21
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Transparent = True
              ExplicitLeft = 115
              ExplicitTop = 1
              ExplicitWidth = 45
              ExplicitHeight = 21
            end
            inherited StaticText1: TStaticText
              Top = 1
              Width = 47
              Height = 21
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              Transparent = True
              ExplicitTop = 1
              ExplicitWidth = 47
              ExplicitHeight = 21
            end
            inherited edtCidade: TEdit
              Left = 116
              Width = 343
              Height = 23
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 116
              ExplicitWidth = 343
              ExplicitHeight = 23
            end
            inherited btnBusca: TBitBtn
              Left = 83
              Top = 23
              ExplicitLeft = 83
              ExplicitTop = 23
            end
            inherited edtUF: TEdit
              Left = 473
              Width = 32
              Height = 23
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 473
              ExplicitWidth = 32
              ExplicitHeight = 23
            end
            inherited edtCodCid: TCurrencyEdit
              Width = 79
              Height = 28
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 79
              ExplicitHeight = 28
            end
          end
          object edtComplento: TEdit
            Left = 19
            Top = 215
            Width = 507
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 200
            ParentFont = False
            TabOrder = 5
          end
          object edtCEP: TMaskEdit
            Left = 431
            Top = 105
            Width = 92
            Height = 23
            EditMask = '00000\-000;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 9
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object edtCodigoEndereco: TCurrencyEdit
            Left = 155
            Top = 16
            Width = 64
            Height = 26
            AutoSize = False
            DisplayFormat = '0'
            TabOrder = 6
            Visible = False
          end
        end
        object gpbContato: TGroupBox
          Left = 575
          Top = 3
          Width = 474
          Height = 87
          Caption = ' Contato '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5197647
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          inline Fone1: TFone
            Left = 32
            Top = 24
            Width = 145
            Height = 47
            TabOrder = 0
            ExplicitLeft = 32
            ExplicitTop = 24
            ExplicitWidth = 145
            inherited Label12: TLabel
              Top = -3
              Width = 28
              Height = 17
              Font.Color = clBlack
              Font.Height = -13
              Font.Style = []
              ExplicitTop = -3
              ExplicitWidth = 28
              ExplicitHeight = 17
            end
            inherited edtFone: TMaskEdit
              Width = 126
              Height = 23
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 126
              ExplicitHeight = 23
            end
          end
          inline Fone2: TFone
            Left = 208
            Top = 24
            Width = 145
            Height = 47
            TabOrder = 1
            ExplicitLeft = 208
            ExplicitTop = 24
            ExplicitWidth = 145
            inherited Label12: TLabel
              Top = -3
              Width = 40
              Height = 17
              Caption = 'Celular'
              Font.Color = clBlack
              Font.Height = -13
              Font.Style = []
              ExplicitTop = -3
              ExplicitWidth = 40
              ExplicitHeight = 17
            end
            inherited edtFone: TMaskEdit
              Width = 126
              Height = 23
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 126
              ExplicitHeight = 23
            end
          end
        end
        object gpbEmail: TGroupBox
          Left = 575
          Top = 101
          Width = 474
          Height = 210
          Caption = ' E-mails '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label9: TLabel
            Left = 17
            Top = 187
            Width = 261
            Height = 15
            Caption = 'Alterar - Duplo Click                Remover - Delete'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7500402
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 151
            Top = 187
            Width = 4
            Height = 13
            Caption = '|'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 17
            Top = 24
            Width = 114
            Height = 17
            Caption = 'Endere'#231'o de e-mail'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7697781
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object DBGrid1: TDBGrid
            Left = 16
            Top = 80
            Width = 441
            Height = 105
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = [fsBold]
            Columns = <
              item
                Expanded = False
                FieldName = 'EMAIL'
                Width = 392
                Visible = True
              end>
          end
          object btnCancela: TBitBtn
            Left = 427
            Top = 44
            Width = 30
            Height = 30
            Hint = 'Confirma'
            Enabled = False
            Glyph.Data = {
              36080000424D3608000000000000360000002800000020000000100000000100
              2000000000000008000000000000000000000000000000000000FFFFFF00140E
              AE001711B800100BA100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00100BA1001711B800140EAE00FFFFFF009B9B9B000000
              4A000000540000003D009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B0000003D000000540000004A009B9B9B001F1AB5002522
              E9002723F1001F1BD100130EA600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00130EA6001F1BD1002723F1002522E9001F1AB500000051000000
              850000008D0000006D00000042009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B000000420000006D0000008D0000008500000051003D3AC8004648
              F6002425F1002A2BF3002121D400140FAD00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00140FAD002121D4002A2BF3002425F1004648F6003D3AC800000064000000
              920000008D0000008F0000007000000049009B9B9B009B9B9B009B9B9B009B9B
              9B00000049000000700000008F0000008D000000920000006400221CB6006262
              E100444BF300262DEF002C33F2002326D7001812B300FFFFFF00FFFFFF001812
              B3002326D7002C33F200262DEF00474DF4006262E100221CB600000052000000
              7D0000008F0000008B0000008E000000730000004F009B9B9B009B9B9B000000
              4F000000730000008E0000008B000000900000007D0000005200FFFFFF00241D
              BB006566E3004853F3002934EF002F3BF200262BD9001A13BA001A13BA00262B
              D9002F3BF2002834EF004752F3005F61DF00241DBA00FFFFFF009B9B9B000000
              570001027F0000008F0000008B0000008E000000750000005600000056000000
              750000008E0000008B0000008F0000007B00000056009B9B9B00FFFFFF00FFFF
              FF002621C200656AE5004756F3002C3DF0003041F1002B36E4002B36E4003041
              F1002D3DF0004A59F3005D5FE0002119BF00FFFFFF00FFFFFF009B9B9B009B9B
              9B0000005E000106810000008F0000008C0000008D0000008000000080000000
              8D0000008C0000008F0000007C0000005B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF002721C6006267E6004356F2003044F0003448F2003448F2003044
              EF004255F2006166E500221AC400FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B00000062000003820000008E0000008C0000008E0000008E000000
              8B0000008E0000028100000060009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF002C23CC004551E900354DF100364CEF00364CEF00354D
              F0004251EA002B23CD00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B00000068000000850000008D0000008B0000008B000000
              8C0000008600000069009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF001D14CE003240E6003C54F2003850F000384FF0003B54
              F2003445E9001D15CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B0000006A000000820000008E0000008C0000008C000000
              8E000000850000006A009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF001F17D400313EE4003E58F1003953F000455EF200455FF2003A53
              F0003E57F000303AE3001F15D300FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B00000070000000800000008D0000008C0000008E0000008E000000
              8C0000008C0000007F0000006F009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF002018D9003542E700425FF3003D59F100556EF300737FF200737EF200566E
              F3003D59F100425EF300313AE4001F16D900FFFFFF00FFFFFF009B9B9B009B9B
              9B00000075000000830000008F0000008D00000A8F000F1B8E000F1A8E00000A
              8F0000008D0000008F0000008000000075009B9B9B009B9B9B00FFFFFF002018
              DE003744E9004663F200405DF1005C77F3006E76EF003028DF002E25DF007078
              F0005D77F400405DF1004562F200333DE8002117DD00FFFFFF009B9B9B000000
              7A000000850000008E0000008D0000138F000A128B0000007B0000007B000C14
              8C000013900000008D0000008E0000008400000079009B9B9B00221BE2003947
              EC004A69F3004462F2005F7AF300686EF000271FE200FFFFFF00FFFFFF002C23
              E200717AF100607BF4004362F2004A69F3003846EB002019E20000007E000000
              880000058F0000008E0000168F00040A8C0000007E009B9B9B009B9B9B000000
              7E000D168D000017900000008E0000058F000000870000007E004144EC005372
              F4004464F2006481F4006E76F200271EE600FFFFFF00FFFFFF00FFFFFF00FFFF
              FF002D25E700747CF2006480F4004564F2005270F3003D41EB0000008800000E
              900000008E00001D90000A128E00000082009B9B9B009B9B9B009B9B9B009B9B
              9B000000830010188E00001C900000008E00000C8F00000087004441ED007B8F
              F5007A94F600737BF3002D24EA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF002D24EA00737CF3007A93F6007A8FF6004441ED0000008900172B
              9100163092000F178F00000086009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B00000086000F188F00162F9200162B920000008900FFFFFF004845
              F0005A59F2002D24ED00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF002D24ED005959F2004844F000FFFFFF009B9B9B000000
              8C0000008E00000089009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B000000890000008E0000008C009B9B9B00}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            TabStop = False
          end
          object edtEmail: TEdit
            Left = 16
            Top = 45
            Width = 377
            Height = 23
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 60
            ParentFont = False
            TabOrder = 1
          end
          object btnConfirma: TBitBtn
            Left = 396
            Top = 44
            Width = 30
            Height = 30
            Hint = 'Confirma'
            Enabled = False
            Glyph.Data = {
              36080000424D3608000000000000360000002800000020000000100000000100
              2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF001AA41C001AA41C00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B0000400000004000009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0022B72B002DCE3D0025BE2F0021B52900FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B0000530000006A0000005A0000005100009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF0020B4270031D548002DD4410023CD350025BD2E0022B62A00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B000050000000710000007000000069000000590000005200009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF001EB4240031D44A0030D74A004ADE63006DE4810025CE360024BF2F0021B5
              2900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B00005000000070000000730000007A000009801D00006A0000005B00000051
              00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF001CB4
              1E0033D44D0035DA530056E06D0051E167009BF1B00079E78D0022CE350024BD
              2E001AA51E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B000050
              00000070000000760000007C0900007D0300378D4C0015832900006A00000059
              0000004100009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0092DD920030D1
              4A0039DD5D005FE5780038C5400011B4130022BC2700A6F5B8006CE3810021CF
              340021B529001FAE2600FFFFFF00FFFFFF00FFFFFF00FFFFFF002E792E00006D
              0000007900000081140000610000005000000058000042915400087F1D00006B
              000000510000004A00009B9B9B009B9B9B009B9B9B009B9B9B0030C7410041E1
              690073E8910045CA4E000D9D0B00FFFFFF0011A310002DC03200AFF7C0005BDF
              6F0022CF360025BE3000169A1800FFFFFF00FFFFFF00FFFFFF0000630000007D
              05000F842D0000660000003900009B9B9B00003F0000005C00004B935C00007B
              0B00006B0000005A0000003600009B9B9B009B9B9B009B9B9B002BC1350080EB
              9E005BD36B000C9F0A00FFFFFF00FFFFFF00FFFFFF000EA70D0045C94E00B3F8
              C50046DA5C0024D0380020AD250015981400FFFFFF00FFFFFF00005D00001C87
              3A00006F0700003B00009B9B9B009B9B9B009B9B9B0000430000006500004F94
              610000760000006C000000490000003400009B9B9B009B9B9B00FFFFFF0079CA
              780079CA7800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000CA10B0053CE
              6000B3F7C70041DA560026D039001CA92100159A1400FFFFFF009B9B9B001566
              1400156614009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00003D0000006A
              00004F93630000760000006C000000450000003600009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000DA7
              0C0074DC8200BFF9D10044DC5A0024CB360019A41C0092DD92009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B000043
              000010781E005B956D000078000000670000004000002E792E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF0017B71F0068DB7900B8F8CB004ADF5F0022C6330018A11B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B00005300000477150054946700007B000000620000003D0000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF001ABA220054D464009DEEAD004FE167001FB52B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B000056000000700000398A4900007D030000510000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0016B81E0050D55F007EE690001CB627009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B0000540000007100001A822C0000520000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF003BCF4C0092DD9200FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B00006B00002E792E009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
              9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            TabStop = False
          end
        end
        object edtCodigo: TCurrencyEdit
          Left = 1
          Top = -8
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 4
          Visible = False
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 60
    end
    object cdsFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 60
    end
    object cdsCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Size = 14
    end
    object cdsENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object cdsCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 72
    end
    object cdsFONE: TStringField
      FieldName = 'FONE'
      Size = 14
    end
    object cdsCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
  end
  object dsEmails: TDataSource
    DataSet = cdsEmails
    Left = 796
    Top = 297
  end
  object cdsEmails: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 844
    Top = 297
    object cdsEmailsEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 60
    end
  end
end
