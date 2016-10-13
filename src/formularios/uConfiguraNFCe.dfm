inherited frmConfiguraNFCe: TfrmConfiguraNFCe
  Left = 266
  Caption = 'Configura'#231#227'o NFC-e'
  ClientHeight = 445
  ClientWidth = 767
  ExplicitWidth = 773
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 410
    ExplicitHeight = 410
  end
  inherited pnlBotoes: TPanel
    Height = 410
    ExplicitHeight = 410
  end
  inherited pnlPropaganda: TPanel
    Top = 410
    Width = 767
    ExplicitTop = 410
    ExplicitWidth = 767
    inherited Shape8: TShape
      Width = 765
      ExplicitWidth = 765
    end
  end
  inherited pgGeral: TPageControl
    Width = 624
    Height = 410
    ExplicitWidth = 624
    ExplicitHeight = 410
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 616
      ExplicitHeight = 379
      inherited gridConsulta: TDBGridCBN
        Width = 470
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 362
        Width = 616
        ExplicitTop = 362
        ExplicitWidth = 616
      end
    end
    inherited tsDados: TTabSheet
      ExplicitWidth = 616
      ExplicitHeight = 379
      inherited pnlDados: TPanel
        Width = 616
        Height = 379
        ExplicitWidth = 616
        ExplicitHeight = 379
        inherited lblCamposObrigatorios: TLabel
          Top = 350
          Visible = False
          ExplicitTop = 350
        end
        inherited lblAsterisco: TLabel
          Top = 346
          Visible = False
          ExplicitTop = 346
        end
        inherited Shape2: TShape
          Width = 612
          Height = 377
          ExplicitWidth = 612
          ExplicitHeight = 377
        end
        object Label7: TLabel
          Left = 208
          Top = 258
          Width = 58
          Height = 15
          Caption = 'Tentativas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 32
          Top = 258
          Width = 110
          Height = 15
          Caption = 'Intervalo tentativas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 32
          Top = 14
          Width = 61
          Height = 15
          Caption = 'Certificado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbsenha: TLabel
          Left = 32
          Top = 73
          Width = 97
          Height = 15
          Caption = 'Senha certificado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 32
          Top = 119
          Width = 76
          Height = 15
          Caption = 'C'#243'digo Token'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 32
          Top = 160
          Width = 35
          Height = 15
          Caption = 'Token'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 208
          Top = 210
          Width = 56
          Height = 15
          Caption = 'Vers'#227'o DF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 32
          Top = 210
          Width = 82
          Height = 15
          Caption = 'Forma emiss'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 383
          Top = 0
          Width = 1
          Height = 360
          Pen.Color = 12698049
        end
        object Label8: TLabel
          Left = 32
          Top = 306
          Width = 55
          Height = 15
          Caption = 'Ambiente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbxFormaEmissao: TComboBox
          Left = 32
          Top = 226
          Width = 154
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          Items.Strings = (
            '0-Normal'
            '8-Contingencia Offline')
        end
        object edtCertificado: TEdit
          Left = 32
          Top = 30
          Width = 329
          Height = 21
          TabOrder = 0
        end
        object spnTentativas: TSpinEdit
          Left = 208
          Top = 273
          Width = 154
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 10
          MinValue = 1
          ParentFont = False
          TabOrder = 8
          Value = 4
        end
        object spnIntervalo: TSpinEdit
          Left = 32
          Top = 273
          Width = 155
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Increment = 50
          MaxValue = 1000
          MinValue = 10
          ParentFont = False
          TabOrder = 7
          Value = 400
        end
        object btnSeleciona: TBitBtn
          Left = 220
          Top = 54
          Width = 140
          Height = 24
          Caption = 'Seleciona'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF4D74AB234179C5ABA7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF4173AF008EEC009AF41F4B80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF2F6EB22BA7
            F516C0FF00A0F3568BC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFEFFFF2974BB68C4F86BD4FF279CE66696C8FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3D8FD5A4E3FEB5EEFF4CAA
            E7669DD2FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEA188898A6A6A93736E866567B0
            9595BAA8B1359EE8BDF5FF77C4EF63A1DAFFFFFFFFFFFFFFFFFFFFFFFFD7CDCD
            7E5857DFD3CBFFFFF7FFFFE7FFFEDBD6BB9E90584D817B8E1794E46BB5E9FFFF
            FFFFFFFFFFFFFFFFFFFFEDE9E9886565FFFFFFFFFFFFFDF8E8FAF2DCF8EDCFFF
            F1CFF6DEBA9F5945C0C7D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA38889F6EFEA
            FFFFFFFEFBF5FBF7E8F9F4DAF5EBCCE6CEACF3DAB8E2BD99AB8B8EFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF937674FFFFFFFDFBF1FCF8EEFAF3E1FCF5E3F7F0D7F0
            DFC1E7C9A9F0D1ABA87E75F8F6F6FFFFFFFFFFFFFFFFFFFFFFFF997D7AFFFFFC
            F9F2E1FAF3DEFAF7E5FAF1DCF1DFC0EDD9BAECD8B9EDCAA5AF8679EDE8E9FFFF
            FFFFFFFFFFFFFFFFFFFF9C807BFFFFEBF9EED5FAF1D7F9F2DAF2E3C6FEFBF9FF
            FFF0EFDFC0E9C69EB0857BF5F2F3FFFFFFFFFFFFFFFFFFFFFFFFAF9596F7EAC8
            F9EBCCEFDCBEF4E4C7F0E1C5FDFCECFAF5DDEFDCBCDFB087B59A9AFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFDED4D7BA998CFDECC4EDD4B0E5CAA8EFDBBFF2E3C4F2
            DEBCEABF93BB8E7DE7DFE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEBFC5
            BE9A8DE6C7A5EFCBA3ECC8A2E8BE94DCAA86BE9585DFD6D7FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E4E6C9B3B4B99C93C3A097BF9F96CC
            B9B7F1EEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 1
          OnClick = btnSelecionaClick
        end
        object edtSenhaCertificado: TEdit
          Left = 32
          Top = 89
          Width = 329
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtCodigoToken: TEdit
          Left = 32
          Top = 135
          Width = 329
          Height = 21
          TabOrder = 3
        end
        object edtToken: TEdit
          Left = 32
          Top = 176
          Width = 329
          Height = 21
          TabOrder = 4
        end
        object cbxVersaoDF: TComboBox
          Left = 208
          Top = 226
          Width = 154
          Height = 21
          Style = csDropDownList
          ItemIndex = 2
          TabOrder = 6
          Text = 've310'
          Items.Strings = (
            've200'
            've300'
            've310')
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
          TabOrder = 10
          Text = '0'
          Visible = False
        end
        object rgpVisualizaImpressao: TRadioGroup
          Left = 408
          Top = 16
          Width = 185
          Height = 81
          Caption = ' Visualiza impress'#227'o '
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o')
          TabOrder = 11
        end
        object rgpViaConsumidor: TRadioGroup
          Left = 408
          Top = 128
          Width = 185
          Height = 81
          Caption = ' Via consumidor '
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o')
          TabOrder = 12
        end
        object rgpImprimeItens: TRadioGroup
          Left = 408
          Top = 240
          Width = 185
          Height = 81
          Caption = ' Imprime itens '
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o')
          TabOrder = 13
        end
        object cbxAmbiente: TComboBox
          Left = 32
          Top = 322
          Width = 154
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 9
          Text = 'Produ'#231#227'o'
          Items.Strings = (
            'Produ'#231#227'o'
            'Homologa'#231#227'o')
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Top = 144
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsTOKEN: TStringField
      FieldName = 'TOKEN'
      Size = 40
    end
  end
  inherited ds: TDataSource
    Left = 170
    Top = 144
  end
end
