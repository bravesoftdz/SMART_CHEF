inherited frmCadastroMateriaPrima: TfrmCadastroMateriaPrima
  Left = 228
  Top = 231
  Caption = 'Cadastro de Materias Primas'
  ClientWidth = 591
  ExplicitWidth = 597
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
      ExplicitWidth = 440
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
      ExplicitWidth = 440
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
        object Label5: TLabel
          Left = 138
          Top = 175
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
