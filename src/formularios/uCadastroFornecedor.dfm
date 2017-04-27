inherited frmCadastroFornecedor: TfrmCadastroFornecedor
  Caption = 'Cadastro de Fornecedores'
  ClientHeight = 381
  ExplicitHeight = 409
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 346
    ExplicitHeight = 346
  end
  inherited pnlBotoes: TPanel
    Height = 346
    ExplicitHeight = 346
  end
  inherited pnlPropaganda: TPanel
    Top = 346
    ExplicitTop = 346
  end
  inherited pgGeral: TPageControl
    Height = 346
    ActivePage = tsDados
    ExplicitHeight = 346
    inherited tsConsulta: TTabSheet
      ExplicitHeight = 315
      inherited gridConsulta: TDBGridCBN
        Height = 354
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 298
        ExplicitTop = 298
        ExplicitWidth = 553
      end
    end
    inherited tsDados: TTabSheet
      ExplicitHeight = 315
      inherited pnlDados: TPanel
        Height = 315
        ExplicitHeight = 315
        inherited lblCamposObrigatorios: TLabel
          Top = 286
          ExplicitTop = 286
        end
        inherited lblAsterisco: TLabel
          Top = 282
          ExplicitTop = 282
        end
        inherited Shape2: TShape
          Left = 2
          Height = 313
          ExplicitLeft = 2
          ExplicitHeight = 395
        end
        object lblRazao: TLabel
          Left = 25
          Top = 25
          Width = 66
          Height = 15
          Caption = 'Raz'#227'o social'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 279
          Top = 73
          Width = 10
          Height = 15
          Caption = 'IE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 25
          Top = 169
          Width = 34
          Height = 15
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtRazao: TEdit
          Left = 23
          Top = 41
          Width = 368
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
        end
        inline CNPJ: TMaskCpfCnpj
          Left = 24
          Top = 64
          Width = 233
          Height = 58
          TabOrder = 1
          ExplicitLeft = 24
          ExplicitTop = 64
          ExplicitWidth = 233
          inherited Label19: TLabel
            Left = 73
            Visible = False
            ExplicitLeft = 73
          end
          inherited StaticText2: TStaticText [1]
            Left = 94
            Width = 32
            Height = 19
            Font.Color = 3815994
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Transparent = True
            ExplicitLeft = 94
            ExplicitWidth = 32
            ExplicitHeight = 19
          end
          inherited edtCpf: TMaskEdit [2]
            Left = 93
            Width = 112
            ExplicitLeft = 93
            ExplicitWidth = 112
          end
          inherited comPessoa: TComboBox [3]
            Left = 0
            ExplicitLeft = 0
          end
          inherited StaticText1: TStaticText [4]
            Left = 0
            Transparent = True
            ExplicitLeft = 0
          end
        end
        object edtIE: TEdit
          Left = 277
          Top = 89
          Width = 114
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        inline Fone1: TFone
          Left = 20
          Top = 120
          Width = 132
          Height = 47
          TabOrder = 3
          ExplicitLeft = 20
          ExplicitTop = 120
          inherited edtFone: TMaskEdit
            Width = 114
            ExplicitWidth = 114
          end
        end
        object edtCodigo: TEdit
          Left = 24
          Top = 6
          Width = 65
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = '0'
          Visible = False
        end
        inline Fone2: TFone
          Left = 156
          Top = 120
          Width = 132
          Height = 47
          TabOrder = 5
          ExplicitLeft = 156
          ExplicitTop = 120
          inherited edtFone: TMaskEdit
            Width = 114
            ExplicitWidth = 114
          end
        end
        object edtEmail: TEdit
          Left = 23
          Top = 185
          Width = 368
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 6
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 60
    end
  end
end
