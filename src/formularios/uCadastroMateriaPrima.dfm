inherited frmCadastroMateriaPrima: TfrmCadastroMateriaPrima
  Left = 228
  Top = 231
  Caption = 'Cadastro de Materias Primas'
  ClientWidth = 591
  ExplicitWidth = 597
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPropaganda: TPanel
    Width = 591
    ExplicitWidth = 591
    inherited Shape8: TShape
      Width = 589
      ExplicitWidth = 578
    end
  end
  inherited pgGeral: TPageControl
    Width = 448
    ActivePage = tsDados
    ExplicitWidth = 448
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 440
      ExplicitHeight = 0
      DesignSize = (
        440
        384)
      inherited gridConsulta: TDBGridCBN
        Left = 0
        Top = 2
        Width = 439
        Height = 378
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 43
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Mat'#233'ria-prima'
            Width = 274
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
        Top = 395
        Width = 222
        Align = alNone
        ExplicitTop = 395
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 440
      ExplicitHeight = 0
      inherited pnlDados: TPanel
        Width = 440
        ExplicitWidth = 440
        DesignSize = (
          440
          384)
        inherited Shape2: TShape [0]
          Width = 439
          ExplicitWidth = 439
        end
        inherited lblCamposObrigatorios: TLabel [1]
        end
        inherited lblAsterisco: TLabel [2]
        end
        object lblRazao: TLabel
          Left = 33
          Top = 41
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 32
          Top = 187
          Width = 77
          Height = 13
          Caption = 'Valor adicional'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 18
          Top = 31
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
        object Label2: TLabel
          Left = 33
          Top = 89
          Width = 125
          Height = 13
          Caption = 'Descri'#231#227'o para adicional'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 152
          Top = 187
          Width = 62
          Height = 13
          Caption = 'Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton1: TSpeedButton
          Left = 254
          Top = 203
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFE4D6BBCFB370B78E27BA8E1EBA8E1EB78E27CFB370E4D6BBFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFAB9964FC29319C79A1BCD990FDD
            9E03D89C09C89816C6991CBF9118B9964FFDFCFAFFFFFFFFFFFFFFFFFFFDFCFB
            A97E21D0A41ECE9B18B98705EBCC81F2D491EBCC81BA8501C89413D19E1CCB9F
            1CA97E21FDFCFBFFFFFFFFFFFFB18C4ECEA21DC9991FB78206BC890EF2E7CEFF
            FFFFF4EBD1C99D30B47C00C2911DCE9C1BC99D1CB18C4EFFFFFFDECFBDBE9218
            C99D1BC1921CBC8607BA8505F2E7CEFFFFFFF4EAD0C99B2DB67D00C3931EC08F
            17D29F1BB78D16DECFBDBC9C6ACCA11AC39318C2921CBC8608B98403F2E7CEFF
            FFFFF4E9CDC99826B67E00C4931EC08F17C5951BC59A15BC9C6AA07630BF9414
            BE8E16C4941EBC8708BB8501F2E7CEFFFFFFF3E9CCC89825B87E00C4941EBD8F
            18B7870DDFAF25A17830A37C30C28E08BC8A0DBC8D1BBA8409B78200F2E7CEFF
            FFFFF3E8CCC69725B67F00C5951FBC8A0DBA8707FED776A17A30956F23E5BE60
            DCA828CC9610C18A07BD8805F2E7CEFFFFFFF2E7CEC2932AB47B00C59414C894
            0EE2BC64FBD77A956D23936C33E3C867E4C168DCAC33D59A06DCA825EFDDB3F8
            EED9EFDDB3D2A226CB9000CA9719E3BE6BE3C065F6D363936C33AB8766E3CE6D
            DFBD54DFBB5FE2C26DDDB34CD8A427CE9A16C69003DDAC32E8CA7BE2C066DDB6
            51E3BC59E2D181AB8766D4C6B9C0AA62E7D680D8AB3FDBAD3AD8A627F6EACCFF
            FFFFF6EACCDCAE3BDBAC39DDB14ADDB650FAF3B8B19849D4C6B9FFFFFF896745
            E4DE8DEDE09FD9AE46D8A72FF7EED5FFFFFFF7EED5DCB348D6A52FE8CE86FDFA
            CADACD76896745FFFFFFFFFFFFFDFCFA724315DEDE82FAF6C2E5BE60D6A834E8
            CD8CDDB85BDAAD3BFFF3C5F8F6BAD5C766724315FDFCFAFFFFFFFFFFFFFFFFFF
            FCFBF9866645AD9B41DED57BF9EE9BFEE096FFE392F4E291D3C66EAA92318666
            45FCFBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEC3B7A586677D5F2487
            66288766287D5F24A58667CEC3B7FFFFFFFFFFFFFFFFFFFFFFFF}
          OnClick = SpeedButton1Click
        end
        object edtMateria: TEdit
          Left = 33
          Top = 57
          Width = 391
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object edtCodigo: TEdit
          Left = 25
          Top = 16
          Width = 65
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '0'
          Visible = False
        end
        object edtValor: TCurrencyEdit
          Left = 32
          Top = 203
          Width = 97
          Height = 21
          AutoSize = False
          DisplayFormat = ',0.00;-,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object edtDescricao2: TEdit
          Left = 33
          Top = 105
          Width = 391
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        inline BuscaProduto1: TBuscaProduto
          Left = 34
          Top = 138
          Width = 399
          Height = 47
          TabOrder = 3
          ExplicitLeft = 34
          ExplicitTop = 138
          ExplicitWidth = 399
          inherited StaticText1: TStaticText
            Top = -1
            Width = 158
            Caption = 'Produto de origem da mat'#233'ria'
            Font.Color = 3355443
            Font.Name = 'Segoe UI'
            ExplicitTop = -1
            ExplicitWidth = 158
          end
          inherited StaticText2: TStaticText
            Left = 71
            Width = 46
            Font.Color = 3355443
            Font.Name = 'Segoe UI'
            Visible = False
            ExplicitLeft = 71
            ExplicitWidth = 46
          end
          inherited btnBusca: TBitBtn
            Left = 43
            ExplicitLeft = 43
          end
          inherited edtProduto: TEdit
            Left = 71
            Width = 319
            ExplicitLeft = 71
            ExplicitWidth = 319
          end
          inherited edtCodigo: TEdit
            Width = 42
            ExplicitWidth = 42
          end
        end
        object edtQuantidade: TCurrencyEdit
          Left = 152
          Top = 203
          Width = 97
          Height = 21
          AutoSize = False
          DecimalPlaces = 3
          DisplayFormat = ',0.000;-,0.000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 63
    Top = 206
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object cdsVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ',0.00;-,0.00'
    end
  end
  inherited ds: TDataSource
    Left = 98
    Top = 206
  end
end
