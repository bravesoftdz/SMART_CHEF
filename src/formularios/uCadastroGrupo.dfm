inherited frmCadastroGrupo: TfrmCadastroGrupo
  Left = 360
  Top = 231
  Caption = 'Cadastro de Grupos'
  ClientHeight = 366
  ClientWidth = 528
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 331
    ExplicitHeight = 331
  end
  inherited pnlBotoes: TPanel
    Height = 331
    ExplicitHeight = 331
  end
  inherited pnlPropaganda: TPanel
    Top = 331
    Width = 528
    ExplicitTop = 331
    ExplicitWidth = 528
    inherited Shape8: TShape
      Width = 526
      ExplicitWidth = 526
    end
  end
  inherited pgGeral: TPageControl
    Width = 385
    Height = 331
    ExplicitWidth = 385
    ExplicitHeight = 331
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        377
        300)
      inherited gridConsulta: TDBGridCBN
        Left = 0
        Top = 0
        Width = 376
        Height = 292
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Descri'#231#227'o do grupo'
            Width = 279
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 313
        Width = 222
        Align = alNone
        ExplicitTop = 313
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited pnlDados: TPanel
        Width = 377
        Height = 300
        ExplicitWidth = 377
        ExplicitHeight = 300
        DesignSize = (
          377
          300)
        inherited Shape2: TShape [0]
          Width = 374
          Height = 298
          ExplicitWidth = 374
          ExplicitHeight = 298
        end
        inherited lblCamposObrigatorios: TLabel [1]
        end
        inherited lblAsterisco: TLabel [2]
        end
        object lblRazao: TLabel
          Left = 25
          Top = 73
          Width = 101
          Height = 13
          Caption = 'Descri'#231#227'o do grupo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3355443
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtGrupo: TEdit
          Left = 25
          Top = 89
          Width = 332
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
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
  end
end
