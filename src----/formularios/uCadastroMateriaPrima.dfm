inherited frmCadastroMateriaPrima: TfrmCadastroMateriaPrima
  Left = 228
  Top = 231
  Caption = 'Cadastro de Materias Primas'
  ClientWidth = 580
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPropaganda: TPanel
    Width = 580
    inherited Shape8: TShape
      Width = 578
    end
  end
  inherited pgGeral: TPageControl
    Width = 437
    inherited tsConsulta: TTabSheet
      DesignSize = (
        429
        384)
      inherited gridConsulta: TDBGridCBN
        Left = 0
        Top = 0
        Width = 428
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
      end
    end
    inherited tsDados: TTabSheet
      inherited pnlDados: TPanel
        Width = 429
        DesignSize = (
          429
          384)
        object lblRazao: TLabel [2]
          Left = 33
          Top = 81
          Width = 140
          Height = 13
          Caption = 'Descri'#231#227'o da mat'#233'ria prima'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3355443
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel [3]
          Left = 32
          Top = 137
          Width = 77
          Height = 13
          Caption = 'Valor adicional'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel [4]
          Left = 18
          Top = 71
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
        inherited Shape2: TShape
          Width = 432
        end
        object edtMateria: TEdit
          Left = 33
          Top = 97
          Width = 365
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object edtCodigo: TEdit
          Left = 25
          Top = 48
          Width = 65
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '0'
          Visible = False
        end
        object edtValor: TCurrencyEdit
          Left = 32
          Top = 155
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
          TabOrder = 2
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Top = 208
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
    Left = 162
    Top = 206
  end
end
