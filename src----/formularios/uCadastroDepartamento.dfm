inherited frmCadastroDepartamento: TfrmCadastroDepartamento
  Left = 466
  Top = 244
  Caption = 'Cadastro de Departamentos'
  ClientHeight = 384
  ClientWidth = 547
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 349
  end
  inherited pnlBotoes: TPanel
    Height = 349
  end
  inherited pnlPropaganda: TPanel
    Top = 349
    Width = 547
    inherited Shape8: TShape
      Width = 545
    end
  end
  inherited pgGeral: TPageControl
    Width = 404
    Height = 349
    inherited tsConsulta: TTabSheet
      inherited gridConsulta: TDBGridCBN
        Width = 378
        Height = 357
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 301
        Width = 222
      end
    end
    inherited tsDados: TTabSheet
      inherited pnlDados: TPanel
        Width = 396
        Height = 318
        inherited Shape2: TShape
          Width = 392
          Height = 316
        end
        object lblRazao: TLabel
          Left = 25
          Top = 41
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
          TabOrder = 0
          Text = '0'
          Visible = False
        end
        object edtDepartamento: TEdit
          Left = 25
          Top = 57
          Width = 332
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDEPARTAMENTO: TStringField
      FieldName = 'DEPARTAMENTO'
    end
  end
end
