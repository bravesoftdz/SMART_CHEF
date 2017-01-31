inherited frmCadastroCfopCorrespondente: TfrmCadastroCfopCorrespondente
  Left = 328
  Top = 131
  Caption = 'Cadastro de CFOP'#39's correspondentes'
  ClientHeight = 402
  ClientWidth = 581
  ExplicitWidth = 587
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Left = 129
    Height = 367
    ExplicitLeft = 129
    ExplicitHeight = 367
  end
  inherited pnlBotoes: TPanel
    Width = 129
    Height = 367
    ExplicitWidth = 129
    ExplicitHeight = 367
    inherited btnIncluir: TSpeedButton
      Top = 9
      Width = 110
      ExplicitTop = 9
      ExplicitWidth = 110
    end
    inherited btnAlterar: TSpeedButton
      Top = 45
      Width = 110
      ExplicitTop = 45
      ExplicitWidth = 110
    end
    inherited btnCancelar: TBitBtn
      Top = 81
      Width = 110
      ExplicitTop = 81
      ExplicitWidth = 110
    end
    inherited btnSalvar: TBitBtn
      Top = 117
      Width = 110
      ExplicitTop = 117
      ExplicitWidth = 110
    end
  end
  inherited pnlPropaganda: TPanel
    Top = 367
    Width = 581
    ExplicitTop = 367
    ExplicitWidth = 581
    inherited Shape8: TShape
      Width = 579
      ExplicitWidth = 579
    end
  end
  inherited pgGeral: TPageControl
    Left = 135
    Width = 446
    Height = 367
    ActivePage = tsDados
    ExplicitLeft = 135
    ExplicitWidth = 446
    ExplicitHeight = 367
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 438
      ExplicitHeight = 336
      inherited gridConsulta: TDBGridCBN
        Width = 420
        Height = 375
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CFOP_SAIDA'
            Title.Alignment = taCenter
            Title.Caption = 'CFOP Sa'#237'da'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 114
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CFOP_ENTRADA'
            Title.Alignment = taCenter
            Title.Caption = 'CFOP Entrada'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 319
        Width = 438
        ExplicitTop = 319
        ExplicitWidth = 438
      end
    end
    inherited tsDados: TTabSheet
      ExplicitWidth = 438
      ExplicitHeight = 336
      inherited pnlDados: TPanel
        Width = 438
        Height = 336
        ExplicitWidth = 438
        ExplicitHeight = 336
        inherited lblCamposObrigatorios: TLabel
          Top = 356
          ExplicitTop = 356
        end
        inherited lblAsterisco: TLabel
          Top = 352
          ExplicitTop = 352
        end
        inherited Shape2: TShape
          Width = 532
          Height = 334
          ExplicitWidth = 532
          ExplicitHeight = 334
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 427
          Height = 313
          Caption = ' Selecinone o CFOP de Sa'#237'da e seu respectivo CFOP de Entrada '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          inline ListaCFOPSaida: TListaCampo
            Left = 56
            Top = 40
            Width = 145
            Height = 64
            TabOrder = 0
            ExplicitLeft = 56
            ExplicitTop = 40
            ExplicitWidth = 145
            inherited Label4: TLabel
              Visible = False
            end
            inherited staTitulo: TStaticText
              Width = 78
              Caption = 'CFOP de sa'#237'da'
              ExplicitWidth = 78
            end
            inherited comListaCampo: TComboBox
              Width = 131
              ExplicitWidth = 131
            end
          end
          inline ListaCFOPEntrada: TListaCampo
            Left = 224
            Top = 40
            Width = 137
            Height = 64
            TabOrder = 1
            ExplicitLeft = 224
            ExplicitTop = 40
            ExplicitWidth = 137
            inherited Label4: TLabel
              Visible = False
            end
            inherited staTitulo: TStaticText
              Width = 91
              Caption = 'CFOP de entrada'
              ExplicitWidth = 91
            end
            inherited comListaCampo: TComboBox
              Width = 123
              ExplicitWidth = 123
            end
          end
          object edtCodigo: TEdit
            Left = 9
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
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCFOP_SAIDA: TStringField
      FieldName = 'CFOP_SAIDA'
      Size = 4
    end
    object cdsCFOP_ENTRADA: TStringField
      FieldName = 'CFOP_ENTRADA'
    end
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
end
