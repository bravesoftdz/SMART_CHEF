inherited frmCadastroCliente: TfrmCadastroCliente
  Left = 339
  Top = 167
  Caption = 'Cadastro de Clientes'
  ClientHeight = 536
  ClientWidth = 682
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Height = 501
  end
  inherited pnlBotoes: TPanel
    Height = 501
  end
  inherited pnlPropaganda: TPanel
    Top = 501
    Width = 682
    inherited Shape8: TShape
      Width = 680
    end
  end
  inherited pgGeral: TPageControl
    Width = 539
    Height = 501
    inherited tsConsulta: TTabSheet
      inherited gridConsulta: TDBGridCBN
        Width = 513
        Height = 509
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 292
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CPF'
            Title.Caption = 'CPF/CNPJ'
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 453
        Width = 222
      end
    end
    inherited tsDados: TTabSheet
      inherited pnlDados: TPanel
        Width = 531
        Height = 470
        inherited lblCamposObrigatorios: TLabel
          Top = 451
        end
        inherited lblAsterisco: TLabel
          Top = 447
        end
        inherited Shape2: TShape
          Top = 2
          Width = 527
          Height = 468
        end
        object Label19: TLabel
          Left = 12
          Top = 4
          Width = 11
          Height = 32
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblRazao: TLabel
          Left = 25
          Top = 9
          Width = 34
          Height = 15
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3815994
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCodigo: TEdit
          Left = 65
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
        object edtNome: TEdit
          Left = 25
          Top = 25
          Width = 485
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        inline cpfCnpj: TMaskCpfCnpj
          Left = 16
          Top = 47
          Width = 225
          Height = 49
          TabOrder = 2
          inherited Label19: TLabel
            Left = 91
            Top = -7
            Font.Color = clMaroon
          end
          inherited edtCpf: TMaskEdit
            Left = 103
            Top = 21
          end
          inherited comPessoa: TComboBox
            Top = 21
            Width = 77
          end
          inherited StaticText1: TStaticText
            Top = 4
          end
          inherited StaticText2: TStaticText
            Left = 104
            Top = 4
          end
        end
        object gpbEndereco: TGroupBox
          Left = 13
          Top = 99
          Width = 500
          Height = 349
          Caption = ' Endere'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Shape1: TShape
            Left = 3
            Top = 190
            Width = 494
            Height = 42
            Pen.Style = psClear
          end
          object btnAlterarEnd: TSpeedButton
            Left = 119
            Top = 199
            Width = 78
            Height = 24
            Caption = 'Alterar'
            OnClick = btnAlterarEndClick
          end
          object btnIncluirEnd: TSpeedButton
            Left = 28
            Top = 199
            Width = 78
            Height = 24
            Caption = 'Incluir'
            OnClick = btnIncluirEndClick
          end
          object btnSalvarend: TSpeedButton
            Left = 392
            Top = 199
            Width = 78
            Height = 24
            Caption = 'Concluir'
            OnClick = btnSalvarendClick
          end
          object btnCancelarEnd: TSpeedButton
            Left = 301
            Top = 199
            Width = 78
            Height = 24
            Caption = 'Cancelar'
            OnClick = btnCancelarEndClick
          end
          object btnDeletarEnd: TSpeedButton
            Left = 210
            Top = 199
            Width = 78
            Height = 24
            Caption = 'Deletar'
            OnClick = btnDeletarEndClick
          end
          object gridEnderecos: TDBGrid
            Left = 12
            Top = 245
            Width = 475
            Height = 95
            DataSource = dsEndereco
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = [fsBold]
            OnEnter = gridEnderecosEnter
            Columns = <
              item
                Expanded = False
                FieldName = 'fone'
                Width = 82
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'logradouro'
                Width = 275
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'bairro'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'numero'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'referencia'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'cod_cidade'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UF'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CEP'
                Visible = True
              end>
          end
          object pnlEndereco: TPanel
            Left = 3
            Top = 14
            Width = 489
            Height = 179
            BevelOuter = bvNone
            Enabled = False
            TabOrder = 1
            object Label5: TLabel
              Left = 13
              Top = 84
              Width = 77
              Height = 15
              Caption = 'Complemento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 13
              Top = 44
              Width = 31
              Height = 15
              Caption = 'Bairro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 13
              Top = 3
              Width = 62
              Height = 15
              Caption = 'Logradouro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 349
              Top = 3
              Width = 44
              Height = 15
              Caption = 'N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 413
              Top = 5
              Width = 21
              Height = 15
              Caption = 'CEP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 393
              Top = 45
              Width = 46
              Height = 15
              Caption = 'Telefone'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 3815994
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            inline BuscaCidade1: TBuscaCidade
              Left = 13
              Top = 123
              Width = 476
              Height = 49
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              inherited StaticText3: TStaticText
                Left = 435
                Top = 4
                Width = 18
                Font.Style = []
              end
              inherited StaticText2: TStaticText
                Top = 4
                Width = 37
                Font.Style = []
              end
              inherited StaticText1: TStaticText
                Top = 4
                Width = 37
                Font.Style = []
              end
              inherited edtCidade: TEdit
                Top = 20
                Width = 334
              end
              inherited btnBusca: TBitBtn
                Top = 18
              end
              inherited edtUF: TEdit
                Left = 435
                Top = 20
              end
              inherited edtCodCid: TCurrencyEdit
                Top = 20
              end
            end
            object edtComplemento: TEdit
              Left = 13
              Top = 100
              Width = 468
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object edtBairro: TEdit
              Left = 13
              Top = 60
              Width = 364
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object edtLogradouro: TEdit
              Left = 13
              Top = 19
              Width = 324
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object edtNumero: TEdit
              Left = 349
              Top = 19
              Width = 52
              Height = 21
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edtcep: TMaskEdit
              Left = 412
              Top = 20
              Width = 64
              Height = 21
              EditMask = '99999\-999;0; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 2
            end
            object edtFone: TMaskEdit
              Left = 393
              Top = 60
              Width = 88
              Height = 21
              EditMask = '!\(00\)0000-0000;0; '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 13
              ParentFont = False
              TabOrder = 4
            end
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
  end
  object dsEndereco: TDataSource
    DataSet = cdsendereco
    Left = 322
    Top = 424
  end
  object cdsendereco: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsenderecoAfterScroll
    Left = 287
    Top = 424
    object cdsenderecoCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsenderecoCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object cdsenderecologradouro: TStringField
      FieldName = 'logradouro'
      Size = 60
    end
    object cdsenderecobairro: TStringField
      FieldName = 'bairro'
      Size = 60
    end
    object cdsendereconumero: TStringField
      FieldName = 'numero'
      Size = 10
    end
    object cdsenderecoreferencia: TStringField
      FieldName = 'referencia'
      Size = 100
    end
    object cdsenderecocod_cidade: TIntegerField
      FieldName = 'cod_cidade'
    end
    object cdsenderecoUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsenderecofone: TStringField
      FieldName = 'fone'
      Size = 15
    end
  end
  object cdsEndDeletado: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsenderecoAfterScroll
    Left = 375
    Top = 424
    object cdsEndDeletadoCOD_END: TIntegerField
      FieldName = 'COD_END'
    end
  end
end
