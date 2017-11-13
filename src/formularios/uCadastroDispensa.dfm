inherited frmCadastroDispensa: TfrmCadastroDispensa
  Caption = 'Cadastro de itens da dispensa'
  ClientHeight = 236
  ClientWidth = 726
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 201
    ExplicitHeight = 201
  end
  inherited pnlBotoes: TPanel
    Height = 201
    ExplicitHeight = 201
  end
  inherited pnlPropaganda: TPanel
    Top = 201
    Width = 726
    ExplicitTop = 201
    ExplicitWidth = 726
    inherited Shape8: TShape
      Width = 724
      ExplicitWidth = 724
    end
  end
  inherited pgGeral: TPageControl
    Width = 583
    Height = 201
    ExplicitWidth = 583
    ExplicitHeight = 201
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited lblAjudaSelecionar: TStaticText
        Top = 171
        Width = 222
        ExplicitTop = 171
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited pnlDados: TPanel
        Width = 575
        Height = 170
        ExplicitWidth = 575
        ExplicitHeight = 170
        inherited Shape2: TShape
          Width = 575
          Height = 168
          ExplicitWidth = 575
          ExplicitHeight = 168
        end
        object lblRazao: TLabel
          Left = 33
          Top = 41
          Width = 166
          Height = 15
          Caption = 'Descri'#231#227'o do item da dispensa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 32
          Top = 92
          Width = 107
          Height = 15
          Caption = 'Unidade de medida'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object StaticText3: TStaticText
          Left = 272
          Top = 92
          Width = 93
          Height = 19
          Caption = 'Estoque M'#237'nimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
        end
        object StaticText2: TStaticText
          Left = 451
          Top = 92
          Width = 86
          Height = 19
          Caption = 'Pre'#231'o de custo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
        end
        object StaticText1: TStaticText
          Left = 384
          Top = 92
          Width = 35
          Height = 19
          Caption = 'Pe'#231'as'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
        end
        object lbEstoque: TStaticText
          Left = 161
          Top = 92
          Width = 48
          Height = 19
          Caption = 'Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
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
        object edtDescricao: TEdit
          Left = 33
          Top = 58
          Width = 505
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtEstoque: TCurrencyEdit
          Left = 161
          Top = 109
          Width = 96
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          Enabled = False
          TabOrder = 2
        end
        object cmbUnidadeMedida: TComboBox
          Left = 33
          Top = 109
          Width = 112
          Height = 21
          Style = csDropDownList
          Enabled = False
          TabOrder = 4
          Items.Strings = (
            'UN'
            'PT'
            'CX'
            'PC'
            'KG')
        end
        object edtPecas: TCurrencyEdit
          Left = 384
          Top = 109
          Width = 51
          Height = 21
          AutoSize = False
          DisplayFormat = '0'
          MinValue = 1.000000000000000000
          TabOrder = 5
          Value = 1.000000000000000000
        end
        object edtPrecoCusto: TCurrencyEdit
          Left = 451
          Top = 109
          Width = 88
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          TabOrder = 7
        end
        object edtEstoqueMin: TCurrencyEdit
          Left = 272
          Top = 109
          Width = 97
          Height = 21
          AutoSize = False
          DisplayFormat = ' ,0.00;-,0.00'
          TabOrder = 9
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 159
    Top = 160
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 150
    end
  end
end
