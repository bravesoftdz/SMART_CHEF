inherited frmConfiguraECF: TfrmConfiguraECF
  Left = 476
  Top = 199
  Caption = 'frmConfiguraECF'
  ClientWidth = 531
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPropaganda: TPanel
    Width = 531
    ExplicitWidth = 531
    inherited Shape8: TShape
      Width = 529
      ExplicitWidth = 529
    end
  end
  inherited pgGeral: TPageControl
    Width = 388
    ExplicitWidth = 388
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited gridConsulta: TDBGridCBN
        Width = 362
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MODELO'
            Width = 264
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Width = 222
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited pnlDados: TPanel
        Width = 380
        ExplicitWidth = 380
        inherited Shape2: TShape
          Width = 429
          ExplicitWidth = 429
        end
        object Label1: TLabel
          Left = 108
          Top = 32
          Width = 42
          Height = 15
          Caption = 'Modelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 108
          Top = 80
          Width = 30
          Height = 15
          Caption = 'Porta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 107
          Top = 128
          Width = 49
          Height = 15
          Caption = 'TimeOut'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 108
          Top = 176
          Width = 51
          Height = 15
          Caption = 'Intervalo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Left = 109
          Top = 224
          Width = 74
          Height = 15
          Caption = 'Linhas Buffer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 108
          Top = 272
          Width = 141
          Height = 15
          Caption = 'Tamanho Fonte dos itens '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4079166
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
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
        object cbxModelo: TComboBox
          Left = 108
          Top = 50
          Width = 158
          Height = 23
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Items.Strings = (
            'ecfBematech'
            'ecfSweda'
            'ecfDaruma'
            'ecfSchalter'
            'ecfMecaf'
            'ecfYanco'
            'ecfDataRegis'
            'ecfUrano'
            'ecfICash'
            'ecfQuattro')
        end
        object cbxPorta: TComboBox
          Left = 108
          Top = 98
          Width = 158
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'Procurar'
          Items.Strings = (
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'COM7'
            'COM8'
            'COM9'
            'COM10')
        end
        object spnTimeOut: TSpinEdit
          Left = 107
          Top = 145
          Width = 159
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 100
          MinValue = 1
          ParentFont = False
          TabOrder = 3
          Value = 10
        end
        object spnIntervaloAposComando: TSpinEdit
          Left = 108
          Top = 193
          Width = 158
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Increment = 10
          MaxValue = 1000
          MinValue = 0
          ParentFont = False
          TabOrder = 4
          Value = 100
        end
        object spnLinhasBuffer: TSpinEdit
          Left = 108
          Top = 241
          Width = 159
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 1000
          MinValue = 0
          ParentFont = False
          TabOrder = 5
          Value = 0
        end
        object SpnTamanhoFonte: TSpinEdit
          Left = 108
          Top = 289
          Width = 159
          Height = 24
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 32
          MinValue = 10
          ParentFont = False
          TabOrder = 6
          Value = 10
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 111
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsMODELO: TStringField
      FieldName = 'MODELO'
    end
  end
  inherited ds: TDataSource
    Left = 138
    Top = 167
  end
end
