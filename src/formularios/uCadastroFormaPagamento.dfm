inherited frmCadastroFormaPagamento: TfrmCadastroFormaPagamento
  Caption = 'Cadastro de Formas de Pagamento'
  ClientHeight = 417
  ExplicitWidth = 320
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 382
    ExplicitHeight = 382
  end
  inherited pnlBotoes: TPanel
    Height = 382
    ExplicitHeight = 382
  end
  inherited pnlPropaganda: TPanel
    Top = 382
    ExplicitTop = 382
  end
  inherited pgGeral: TPageControl
    Height = 382
    ActivePage = tsDados
    ExplicitHeight = 382
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 351
      inherited gridConsulta: TDBGridCBN
        Height = 296
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 334
        Width = 222
        ExplicitTop = 334
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 351
      inherited pnlDados: TPanel
        Height = 351
        ExplicitHeight = 351
        inherited Shape2: TShape
          Left = 2
          ExplicitLeft = 2
        end
        object Label1: TLabel
          Left = 125
          Top = 64
          Width = 57
          Height = 17
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 33
          Top = 64
          Width = 43
          Height = 17
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object edtCodigo: TCurrencyEdit
          Left = 32
          Top = 86
          Width = 64
          Height = 25
          DisplayFormat = '0'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Visible = False
        end
        object edtDescricao: TEdit
          Left = 125
          Top = 86
          Width = 401
          Height = 25
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
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
      Size = 100
    end
  end
end
