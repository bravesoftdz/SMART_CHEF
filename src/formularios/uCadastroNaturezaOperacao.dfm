inherited frmCadastroNaturezaOperacao: TfrmCadastroNaturezaOperacao
  Left = 368
  Top = 110
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Naturezas de Opera'#231#227'o'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgGeral: TPageControl
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited gridConsulta: TDBGridCBN
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CFOP'
            Width = 44
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'SUSPENSAO_ICMS'
            Title.Caption = 'Suspens'#227'o ICMS'
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
        inherited lblAsterisco: TLabel
          Font.Color = 9010488
        end
        object lblAsteriscoDescricao: TLabel
          Left = 4
          Top = 8
          Width = 11
          Height = 32
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = 9010488
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDescricao: TLabel
          Left = 17
          Top = 17
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3355443
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCFOP: TLabel
          Left = 481
          Top = 17
          Width = 28
          Height = 13
          Caption = 'CFOP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3355443
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblAsteriscoCFOP: TLabel
          Left = 467
          Top = 8
          Width = 11
          Height = 32
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = 9010488
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCodigo: TEdit
          Left = 169
          Top = 8
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
          Left = 17
          Top = 33
          Width = 449
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 1
        end
        object edtCFOP: TMaskEdit
          Left = 479
          Top = 33
          Width = 53
          Height = 21
          MaxLength = 4
          TabOrder = 2
          Text = ''
        end
        object rgSuspensaoICMS: TRadioGroup
          Left = 18
          Top = 69
          Width = 209
          Height = 60
          Caption = ' Suspens'#227'o de ICMS '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Items.Strings = (
            'N'#227'o'
            'Sim')
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object cdsCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object cdsSUSPENSAO_ICMS: TStringField
      FieldName = 'SUSPENSAO_ICMS'
      Size = 3
    end
  end
end
