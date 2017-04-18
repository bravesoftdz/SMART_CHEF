object frmDadosPessoa: TfrmDadosPessoa
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Dados'
  ClientHeight = 441
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 20
  object gpbEndereco: TGroupBox
    Left = 8
    Top = 159
    Width = 489
    Height = 266
    Caption = ' Endere'#231'o '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5855577
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label4: TLabel
      Left = 17
      Top = 24
      Width = 109
      Height = 20
      Caption = 'Rua/Logradouro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 17
      Top = 82
      Width = 17
      Height = 20
      Caption = 'N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 95
      Top = 82
      Width = 40
      Height = 20
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 17
      Top = 199
      Width = 95
      Height = 20
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 376
      Top = 83
      Width = 25
      Height = 20
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtLogradouro: TEdit
      Left = 17
      Top = 47
      Width = 447
      Height = 28
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 80
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtNumero: TEdit
      Left = 17
      Top = 105
      Width = 62
      Height = 28
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtBairro: TEdit
      Left = 95
      Top = 105
      Width = 271
      Height = 28
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 50
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    inline BuscaCidade1: TBuscaCidade
      Left = 17
      Top = 138
      Width = 458
      Height = 60
      TabOrder = 4
      ExplicitLeft = 17
      ExplicitTop = 138
      ExplicitWidth = 458
      ExplicitHeight = 60
      inherited StaticText3: TStaticText
        Left = 418
        Top = 1
        Width = 23
        Height = 24
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Transparent = True
        ExplicitLeft = 418
        ExplicitTop = 1
        ExplicitWidth = 23
        ExplicitHeight = 24
      end
      inherited StaticText2: TStaticText
        Left = 93
        Top = 1
        Width = 51
        Height = 24
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Transparent = True
        ExplicitLeft = 93
        ExplicitTop = 1
        ExplicitWidth = 51
        ExplicitHeight = 24
      end
      inherited StaticText1: TStaticText
        Top = 1
        Width = 53
        Height = 24
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Transparent = True
        ExplicitTop = 1
        ExplicitWidth = 53
        ExplicitHeight = 24
      end
      inherited edtCidade: TEdit
        Left = 94
        Width = 313
        Height = 28
        TabStop = False
        Font.Color = 12418084
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 94
        ExplicitWidth = 313
        ExplicitHeight = 28
      end
      inherited btnBusca: TBitBtn
        Left = 63
        Top = 23
        ExplicitLeft = 63
        ExplicitTop = 23
      end
      inherited edtUF: TEdit
        Left = 415
        Width = 32
        Height = 28
        Font.Color = 12418084
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 415
        ExplicitWidth = 32
        ExplicitHeight = 28
      end
      inherited edtCodCid: TCurrencyEdit
        Width = 61
        Height = 28
        TabStop = False
        Font.Color = 12418084
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ExplicitWidth = 61
        ExplicitHeight = 28
      end
    end
    object edtComplento: TEdit
      Left = 17
      Top = 222
      Width = 447
      Height = 28
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 200
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object edtCEP: TMaskEdit
      Left = 377
      Top = 105
      Width = 87
      Height = 28
      TabStop = False
      EditMask = '00000\-000;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
    object edtCodigoEndereco: TCurrencyEdit
      Left = 155
      Top = 16
      Width = 64
      Height = 26
      TabStop = False
      AutoSize = False
      DisplayFormat = '0'
      TabOrder = 6
      Visible = False
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 12
    Width = 489
    Height = 139
    TabOrder = 1
    object lbRgIe: TLabel
      Left = 181
      Top = 66
      Width = 12
      Height = 20
      Caption = 'IE'
    end
    object Label2: TLabel
      Left = 17
      Top = 8
      Width = 97
      Height = 20
      Caption = 'Nome fantasia'
    end
    object edtIe: TEdit
      Left = 180
      Top = 89
      Width = 135
      Height = 28
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 14
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtFantasia: TEdit
      Left = 18
      Top = 31
      Width = 447
      Height = 29
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12418084
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 60
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    inline CpfCnpj: TMaskCpfCnpj
      Left = 12
      Top = 64
      Width = 155
      Height = 65
      TabOrder = 2
      ExplicitLeft = 12
      ExplicitTop = 64
      ExplicitWidth = 155
      ExplicitHeight = 65
      inherited Label19: TLabel
        Left = 48
        Font.Color = clMaroon
        Visible = False
        ExplicitLeft = 48
      end
      inherited StaticText2: TStaticText [1]
        Left = 7
        Top = 3
        Width = 37
        Height = 24
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        Transparent = True
        ExplicitLeft = 7
        ExplicitTop = 3
        ExplicitWidth = 37
        ExplicitHeight = 24
      end
      inherited edtCpf: TMaskEdit [2]
        Left = 6
        Width = 139
        Height = 28
        TabStop = False
        Font.Color = 12418084
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        Text = '111111111111'
        ExplicitLeft = 6
        ExplicitWidth = 139
        ExplicitHeight = 28
      end
      inherited StaticText1: TStaticText
        Left = -43
        Visible = False
        ExplicitLeft = -43
      end
      inherited comPessoa: TComboBox [4]
        Left = -92
        Top = 33
        Width = 101
        Height = 28
        Visible = False
        ExplicitLeft = -92
        ExplicitTop = 33
        ExplicitWidth = 101
        ExplicitHeight = 28
      end
    end
    inline Fone1: TFone
      Left = 335
      Top = 70
      Width = 145
      Height = 47
      TabOrder = 3
      ExplicitLeft = 335
      ExplicitTop = 70
      ExplicitWidth = 145
      inherited Label12: TLabel
        Top = -3
        Width = 32
        Height = 20
        Font.Color = clBlack
        Font.Height = -15
        Font.Style = []
        ExplicitTop = -3
        ExplicitWidth = 32
        ExplicitHeight = 20
      end
      inherited edtFone: TMaskEdit
        Width = 126
        Height = 28
        TabStop = False
        Font.Color = 12418084
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ExplicitWidth = 126
        ExplicitHeight = 28
      end
    end
  end
end
