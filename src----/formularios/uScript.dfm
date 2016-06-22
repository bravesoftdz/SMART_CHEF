object frmScript: TfrmScript
  Left = 285
  Top = 246
  Width = 739
  Height = 480
  Caption = 'frmScript'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Versao1: TMemo
    Left = 6
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'insert into parametros values(0,1)'
      '^')
    ParentCtl3D = False
    TabOrder = 0
    WordWrap = False
  end
  object versao2: TMemo
    Left = 46
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE EMPRESA'
      'ADD CEP INTEGER'
      '^'
      'ALTER TABLE EMPRESA'
      'ADD RUA VARCHAR(100)'
      '^'
      'ALTER TABLE EMPRESA'
      'ADD NUMERO VARCHAR(20)'
      '^'
      'ALTER TABLE EMPRESA'
      'ADD BAIRRO VARCHAR(100)'
      '^'
      'ALTER TABLE EMPRESA'
      'ADD COMPLEMENTO VARCHAR(200)'
      '^'
      'ALTER TABLE EMPRESA'
      'ADD COD_MUNICIPIO INTEGER'
      '^')
    ParentCtl3D = False
    TabOrder = 1
    WordWrap = False
  end
  object versao3: TMemo
    Left = 86
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE PARAMETROS_NFCE ('
      '    CODIGO INTEGER NOT NULL,'
      '    FORMA_EMISSAO INTEGER,'
      '    INTERVALO_TENTATIVAS SMALLINT,'
      '    TENTATIVAS SMALLINT,'
      '    VERSAO_DF SMALLINT,'
      '    ID_TOKEN VARCHAR(10),'
      '    TOKEN VARCHAR(100),'
      '    CERTIFICADO VARCHAR(20),'
      '    SENHA VARCHAR(20))'
      '^'
      'alter table PARAMETROS_NFCE'
      'add constraint PK_PARAMETROS_NFCE'
      'primary key (CODIGO)'
      '^')
    ParentCtl3D = False
    TabOrder = 2
    WordWrap = False
  end
  object versao4: TMemo
    Left = 126
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE NFCE ('
      '    CODIGO INTEGER NOT NULL,'
      '    NR_NOTA INTEGER,'
      '    CODIGO_PEDIDO INTEGER,'
      '    SERIE CHAR(1),'
      '    CHAVE VARCHAR(44),'
      '    PROTOCOLO VARCHAR(15),'
      '    DH_RECEBIMENTO TIMESTAMP,'
      '    STATUS CHAR(3),'
      '    MOTIVO VARCHAR(150),'
      '    RECIBO VARCHAR(20),'
      '    XML BLOB SUB_TYPE 0 SEGMENT SIZE 80)'
      '^'
      'alter table NFCE'
      'add constraint PK_NFCE'
      'primary key (CODIGO)'
      '^'
      'alter table NFCE'
      'add constraint FK_NFCE_1'
      'foreign key (CODIGO_PEDIDO)'
      'references PEDIDOS(CODIGO)'
      '^')
    ParentCtl3D = False
    TabOrder = 3
    WordWrap = False
  end
  object versao5: TMemo
    Left = 166
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_LOTE_NFCE'
      '^'
      'CREATE GENERATOR gen_nrnota_nfce'
      '^'
      'CREATE GENERATOR GEN_NFCE_ID'
      '^'
      'CREATE TRIGGER NFCE_BI FOR NFCE'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL) or (new.codigo = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_NFCE_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 4
    WordWrap = False
  end
  object versao6: TMemo
    Left = 206
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD VISUALIZA_IMPRESSAO CHAR(1)'
      '^'
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD VIA_CONSUMIDOR CHAR(1)'
      '^'
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD IMPRIME_ITENS CHAR(1)')
    ParentCtl3D = False
    TabOrder = 5
    WordWrap = False
  end
  object versao7: TMemo
    Left = 246
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD AMBIENTE CHAR(1)'
      '^')
    ParentCtl3D = False
    TabOrder = 6
    WordWrap = False
  end
  object versao8: TMemo
    Left = 286
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE NFCE ALTER RECIBO TYPE VARCHAR(100) '
      '^'
      'ALTER TABLE NFCE ALTER RECIBO TO JUSTIFICATIVA'
      '^')
    ParentCtl3D = False
    TabOrder = 7
    WordWrap = False
  end
  object versao9: TMemo
    Left = 326
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE CONFIGURACOES_SISTEMA ('
      '    CODIGO INTEGER NOT NULL,'
      '    POSSUI_BOLICHE SMALLINT DEFAULT 0,'
      '    POSSUI_DISPENSADORA SMALLINT DEFAULT 0,'
      '    DUAS_VIAS_PEDIDO SMALLINT DEFAULT 0)'
      '^'
      'alter table CONFIGURACOES_SISTEMA'
      'add constraint PK_CONFIGURACOES_SISTEMA'
      'primary key (CODIGO)'
      '^')
    ParentCtl3D = False
    TabOrder = 8
    WordWrap = False
  end
  object versao10: TMemo
    Left = 366
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'INSERT INTO CONFIGURACOES_SISTEMA (CODIGO, POSSUI_BOLICHE, POSSU' +
        'I_DISPENSADORA, DUAS_VIAS_PEDIDO) VALUES (1, 0, 0, 0)'
      '^')
    ParentCtl3D = False
    TabOrder = 9
    WordWrap = False
  end
  object versao11: TMemo
    Left = 406
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD PRECO_PRODUTO_ALTERAVEL SMALLINT'
      'DEFAULT 1 '
      '^')
    ParentCtl3D = False
    TabOrder = 10
    WordWrap = False
  end
  object versao12: TMemo
    Left = 446
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD UTILIZA_COMANDAS SMALLINT'
      'DEFAULT 1 '
      '^')
    ParentCtl3D = False
    TabOrder = 11
    WordWrap = False
  end
  object versao13: TMemo
    Left = 486
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE CIDADES ('
      '    CODIGO   INTEGER NOT NULL,'
      '    CODEST   INTEGER NOT NULL,'
      '    NOME     VARCHAR(72),'
      '    CEP      VARCHAR(10),'
      '    CODIBGE  INTEGER'
      ')'
      '^'
      'CREATE TABLE ESTADOS ('
      '    CODIGO  INTEGER NOT NULL,'
      '    SIGLA   CHAR(2),'
      '    NOME    VARCHAR(20)'
      ')'
      '^'
      'CREATE TABLE CLIENTES ('
      '    CODIGO INTEGER NOT NULL,'
      '    NOME VARCHAR(60),'
      '    CPF_CNPJ VARCHAR(14),'
      '    FONE VARCHAR(13),'
      '    CEP VARCHAR(8),'
      '    LOGRADOURO VARCHAR(60),'
      '    NUMERO VARCHAR(10),'
      '    COMPLEMENTO VARCHAR(100),'
      '    BAIRRO VARCHAR(60),'
      '    CODIGO_CIDADE INTEGER,'
      '    UF CHAR(2))'
      '^'
      'alter table CLIENTES'
      'add constraint PK_CLIENTES'
      'primary key (CODIGO)'
      '^'
      'CREATE GENERATOR GEN_CLIENTES_ID'
      '^'
      'CREATE TRIGGER CLIENTES_BI FOR CLIENTES'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL)or(new.codigo = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_CLIENTES_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 12
    WordWrap = False
  end
  object versao14: TMemo
    Left = 526
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE ENDERECOS ('
      '    CODIGO          INTEGER NOT NULL,'
      '    CODIGO_CLIENTE  SMALLINT,'
      '    CEP             VARCHAR(8),'
      '    LOGRADOURO      VARCHAR(60),'
      '    NUMERO          VARCHAR(10),'
      '    REFERENCIA      VARCHAR(100),'
      '    BAIRRO          VARCHAR(60),'
      '    CODIGO_CIDADE   INTEGER,'
      '    UF              CHAR(2)'
      ')'
      '^'
      
        'ALTER TABLE ENDERECOS ADD CONSTRAINT PK_ENDERECOS PRIMARY KEY (C' +
        'ODIGO)'
      '^'
      
        'ALTER TABLE ENDERECOS ADD CONSTRAINT FK_ENDERECOS_1 FOREIGN KEY ' +
        '(CODIGO_CLIENTE) REFERENCES CLIENTES (CODIGO)'
      '^'
      'CREATE GENERATOR GEN_ENDERECOS_ID'
      '^'
      'CREATE TRIGGER ENDERECOS_BI FOR ENDERECOS'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL)OR(new.codigo = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_ENDERECOS_ID,1);'
      'END'
      '^'
      'ALTER TABLE CLIENTES DROP CEP'
      '^'
      'ALTER TABLE CLIENTES DROP LOGRADOURO'
      '^'
      'ALTER TABLE CLIENTES DROP NUMERO'
      '^'
      'ALTER TABLE CLIENTES DROP COMPLEMENTO'
      '^'
      'ALTER TABLE CLIENTES DROP BAIRRO'
      '^'
      'ALTER TABLE CLIENTES DROP CODIGO_CIDADE'
      '^'
      'ALTER TABLE CLIENTES DROP UF'
      '^'
      'ALTER TABLE CLIENTES DROP FONE'
      '^'
      'ALTER TABLE PEDIDOS ADD CODIGO_ENDERECO INTEGER'
      '^'
      'ALTER TABLE ENDERECOS'
      'ADD FONE VARCHAR(13)'
      '^')
    ParentCtl3D = False
    TabOrder = 13
    WordWrap = False
  end
  object versao15: TMemo
    Left = 566
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD POSSUI_DELIVERY SMALLINT'
      '^')
    ParentCtl3D = False
    TabOrder = 14
    WordWrap = False
  end
  object versao16: TMemo
    Left = 606
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PEDIDOS'
      'ADD VALOR_PAGO NUMERIC(15,2)'
      '^')
    ParentCtl3D = False
    TabOrder = 15
    WordWrap = False
  end
  object versao17: TMemo
    Left = 646
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PEDIDOS'
      'ADD AGRUPADAS VARCHAR(80)'
      '^')
    ParentCtl3D = False
    TabOrder = 16
    WordWrap = False
  end
  object versao18: TMemo
    Left = 686
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE EMPRESA'
      'ADD TAXA_ENTREGA NUMERIC(15,2)'
      '^')
    ParentCtl3D = False
    TabOrder = 17
    WordWrap = False
  end
  object versao19: TMemo
    Left = 6
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PEDIDOS'
      'ADD TAXA_ENTREGA NUMERIC(15,2)'
      '^')
    ParentCtl3D = False
    TabOrder = 18
    WordWrap = False
  end
  object versao20: TMemo
    Left = 46
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD IMP_DEP_ESPACADA SMALLINT'
      '^')
    ParentCtl3D = False
    TabOrder = 19
    WordWrap = False
  end
  object Zsql: TZSQLProcessor
    Params = <>
    Connection = dm.ZConnection1
    Delimiter = ';'
    Left = 72
    Top = 88
  end
end
