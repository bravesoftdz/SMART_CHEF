inherited frmconfiguracoesSistema: TfrmconfiguracoesSistema
  Caption = 'Configura'#231#245'es do sistema'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgGeral: TPageControl
    inherited tsConsulta: TTabSheet
      inherited gridConsulta: TDBGridCBN
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'POSSUI_BOLICHE'
            Title.Caption = 'Possui Boliche'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'POSSUI_DISPENSADORA'
            Title.Caption = 'Possui Dispensadora'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DUAS_VIAS_PEDIDO'
            Title.Caption = 'Duas Vias Pedido'
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Width = 222
      end
    end
    inherited tsDados: TTabSheet
      inherited pnlDados: TPanel
        object PageControl1: TPageControl
          Left = 1
          Top = 4
          Width = 544
          Height = 377
          ActivePage = TabSheet2
          Style = tsFlatButtons
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = 'Geral'
            object Label1: TLabel
              Left = 17
              Top = 24
              Width = 130
              Height = 13
              Caption = 'Controla pista de boliche'
            end
            object Label2: TLabel
              Left = 185
              Top = 24
              Width = 106
              Height = 13
              Caption = 'Possui dispensadora'
            end
            object Label5: TLabel
              Left = 345
              Top = 24
              Width = 89
              Height = 13
              Caption = 'Utiliza Comandas'
            end
            object Label6: TLabel
              Left = 17
              Top = 72
              Width = 75
              Height = 13
              Caption = 'Possui delivery'
            end
            object cbxUsaBoliche: TComboBox
              Left = 16
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
            object cbxUsaDispensadora: TComboBox
              Left = 184
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 1
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
            object edtCodigo: TEdit
              Left = 9
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
              TabOrder = 2
              Text = '0'
              Visible = False
            end
            object cbxUtilizaComandas: TComboBox
              Left = 344
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 3
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
            object cbxPossuiDelivery: TComboBox
              Left = 16
              Top = 88
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Pedido'
            ImageIndex = 1
            object Label3: TLabel
              Left = 17
              Top = 24
              Width = 124
              Height = 13
              Caption = 'Duas vias de impress'#227'o?'
            end
            object Label4: TLabel
              Left = 193
              Top = 24
              Width = 130
              Height = 13
              Caption = 'Editar pre'#231'o do produto?'
            end
            object Label7: TLabel
              Left = 369
              Top = 24
              Width = 134
              Height = 13
              Caption = 'Impress'#227'o dep. espa'#231'ada?'
            end
            object cbxViasImpressao: TComboBox
              Left = 16
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
            object cbxEditaPrecoPedido: TComboBox
              Left = 192
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 1
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
            object cbxImpDepEspacada: TComboBox
              Left = 368
              Top = 40
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 2
              Items.Strings = (
                'SIM'
                'N'#195'O')
            end
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 167
    Top = 160
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsPOSSUI_BOLICHE: TStringField
      FieldName = 'POSSUI_BOLICHE'
      Size = 3
    end
    object cdsPOSSUI_DISPENSADORA: TStringField
      FieldName = 'POSSUI_DISPENSADORA'
      Size = 3
    end
    object cdsDUAS_VIAS_PEDIDO: TStringField
      FieldName = 'DUAS_VIAS_PEDIDO'
      Size = 3
    end
    object cdsUTILIZA_COMANDAS: TStringField
      FieldName = 'UTILIZA_COMANDAS'
      Size = 4
    end
    object cdsPOSSUI_DELIVERY: TStringField
      FieldName = 'POSSUI_DELIVERY'
      Size = 1
    end
  end
  inherited ds: TDataSource
    Top = 160
  end
end
