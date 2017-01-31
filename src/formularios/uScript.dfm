object frmScript: TfrmScript
  Left = 285
  Top = 246
  Caption = 'frmScript'
  ClientHeight = 442
  ClientWidth = 723
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
  object versao21: TMemo
    Left = 86
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE PRODUTO_DEPENDENCIA_EST ('
      '    CODIGO INTEGER NOT NULL,'
      '    CODIGO_PRODUTO INTEGER,'
      '    CODIGO_DISPENSA INTEGER,'
      '    QUANTIDADE_BAIXA NUMERIC(15,2))'
      '^'
      'alter table PRODUTO_DEPENDENCIA_EST'
      'add constraint PK_PRODUTO_DEPENDENCIA_EST'
      'primary key (CODIGO)'
      '^'
      'CREATE GENERATOR GEN_PRODUTO_DEPENDENCIA_EST_ID'
      '^'
      
        'CREATE TRIGGER PRODUTO_DEPENDENCIA_EST_BI FOR PRODUTO_DEPENDENCI' +
        'A_EST'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL) OR (NEW.CODIGO = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_PRODUTO_DEPENDENCIA_EST_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 20
    WordWrap = False
  end
  object versao22: TMemo
    Left = 126
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PEDIDOS'
      'ADD STS_RECEBIMENTO CHAR(1)'
      '^'
      'ALTER TABLE ITENS'
      'ADD FRACIONADO CHAR(1)'
      '^'
      'ALTER TABLE ITENS'
      'ADD QUANTIDADE_PG NUMERIC(15,2)'
      '^')
    ParentCtl3D = False
    TabOrder = 21
    WordWrap = False
  end
  object versao23: TMemo
    Left = 166
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE ITENS'
      'ADD QTD_FRACIONADO SMALLINT'
      '^')
    ParentCtl3D = False
    TabOrder = 22
    WordWrap = False
  end
  object versao24: TMemo
    Left = 206
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE ITENS'
      'ADD CANCELADO CHAR(1)'
      '^'
      'ALTER TABLE ITENS'
      'ADD MOTIVO_CANCELAMENTO VARCHAR(100)'
      '^')
    ParentCtl3D = False
    TabOrder = 23
    WordWrap = False
  end
  object versao25: TMemo
    Left = 246
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD DESCONTO_PEDIDO SMALLINT'
      '^'
      'ALTER TABLE PRODUTOS'
      'ADD ALTERA_PRECO CHAR(1)'
      '^')
    ParentCtl3D = False
    TabOrder = 24
    WordWrap = False
  end
  object versao26: TMemo
    Left = 286
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD JUST_CONTINGENCIA VARCHAR(40)'
      '^'
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD INICIO_CONTINGENCIA TIMESTAMP'
      '^'
      'ALTER TABLE PEDIDOS'
      'ADD EM_CONTINGENCIA CHAR(1)'
      '^')
    ParentCtl3D = False
    TabOrder = 25
    WordWrap = False
  end
  object versao27: TMemo
    Left = 326
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD IMPRESSOES_PARCIAIS SMALLINT'
      '^'
      'ALTER TABLE CONFIGURACOES_SISTEMA'
      'ADD PERGUNTA_IMPRIMIR_PEDIDO SMALLINT'
      '^')
    ParentCtl3D = False
    TabOrder = 26
    WordWrap = False
  end
  object versao28: TMemo
    Left = 366
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PRODUTOS'
      'ADD CODBAR VARCHAR(13)'
      '^')
    ParentCtl3D = False
    TabOrder = 27
    WordWrap = False
  end
  object versao29: TMemo
    Left = 406
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE ESTOQUE'
      'ADD UNIDADE_ENTRADA VARCHAR(3)'
      '^'
      'ALTER TABLE ESTOQUE'
      'ADD MULTIPLICADOR NUMERIC(15,2)'
      '^'
      'ALTER TABLE PRODUTOS'
      'ADD REFERENCIA VARCHAR(18)'
      '^')
    ParentCtl3D = False
    TabOrder = 28
    WordWrap = False
  end
  object versao30: TMemo
    Left = 446
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'update RDB$FIELDS set'
      'RDB$FIELD_SCALE = -4'
      'where RDB$FIELD_NAME = '#39'RDB$120'#39
      '^'
      'update RDB$FIELDS set'
      'RDB$FIELD_SCALE = -4'
      'where RDB$FIELD_NAME = '#39'RDB$121'#39
      '^'
      'update RDB$FIELDS set'
      'RDB$FIELD_SCALE = -4'
      'where RDB$FIELD_NAME = '#39'RDB$126'#39
      '^'
      'update RDB$FIELDS set'
      'RDB$FIELD_SCALE = -4'
      'where RDB$FIELD_NAME = '#39'RDB$184'#39
      '^'
      'update RDB$FIELDS set'
      'RDB$FIELD_SCALE = -4'
      'where RDB$FIELD_NAME = '#39'RDB$191'#39
      '^')
    ParentCtl3D = False
    TabOrder = 29
    WordWrap = False
  end
  object versao31: TMemo
    Left = 486
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE FORNECEDORES ('
      '    CODIGO INTEGER NOT NULL,'
      '    NOME_RAZAO VARCHAR(15),'
      '    CPF_CNPJ VARCHAR(14),'
      '    RG_IE VARCHAR(15),'
      '    FONE VARCHAR(15),'
      '    FONE2 VARCHAR(15),'
      '    EMAIL VARCHAR(60))'
      '^'
      'alter table FORNECEDORES'
      'add constraint PK_FORNECEDORES'
      'primary key (CODIGO)'
      '^'
      'CREATE GENERATOR GEN_FORNECEDORES_ID'
      '^'
      'CREATE TRIGGER FORNECEDORES_BI FOR FORNECEDORES'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL) or (NEW.CODIGO = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_FORNECEDORES_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 30
    WordWrap = False
  end
  object versao32: TMemo
    Left = 526
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 31
    WordWrap = False
  end
  object versao36: TMemo
    Left = 686
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE fornecedores ALTER nome_razao TYPE VARCHAR(80)'
      '^')
    ParentCtl3D = False
    TabOrder = 32
    WordWrap = False
  end
  object versao33: TMemo
    Left = 566
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 33
    WordWrap = False
  end
  object versao35: TMemo
    Left = 646
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 34
    WordWrap = False
  end
  object versao37: TMemo
    Left = 6
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 35
    WordWrap = False
  end
  object versao34: TMemo
    Left = 606
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 36
    WordWrap = False
  end
  object versao38: TMemo
    Left = 46
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_SANGRIA_REFORCO_ID'
      '^'
      'CREATE TABLE SANGRIA_REFORCO ('
      '    CODIGO INTEGER NOT NULL,'
      '    CODIGO_CAIXA INTEGER,'
      '    CODIGO_USUARIO INTEGER,'
      '    TIPO CHAR(1),'
      '    VALOR NUMERIC(15,2),'
      '    DESCRICAO VARCHAR(100))'
      '^'
      'alter table SANGRIA_REFORCO'
      'add constraint PK_SANGRIA_REFORCO'
      'primary key (CODIGO)'
      '^'
      'alter table SANGRIA_REFORCO'
      'add constraint FK_SANGRIA_REFORCO_1'
      'foreign key (CODIGO_CAIXA)'
      'references CAIXA(CODIGO)'
      '^'
      'alter table SANGRIA_REFORCO'
      'add constraint FK_SANGRIA_REFORCO_2'
      'foreign key (CODIGO_USUARIO)'
      'references USUARIOS(CODIGO)'
      '^'
      'CREATE TRIGGER SANGRIA_REFORCO_BI FOR SANGRIA_REFORCO'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL) or (NEW.CODIGO = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_SANGRIA_REFORCO_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 37
    WordWrap = False
  end
  object versao39: TMemo
    Left = 86
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_CFOP_CORRESPONDENTE_ID^'
      'CREATE GENERATOR GEN_ICMS_ESTADO_ID^'
      'CREATE GENERATOR GEN_ITENS_AVULSOS_ID^'
      'CREATE GENERATOR GEN_ITENS_NOTAS_FISCAIS_ID^'
      'CREATE GENERATOR GEN_IT_AVULSOS_QTDS_ID^'
      'CREATE GENERATOR GEN_LOTES_NFE_ID^'
      'CREATE GENERATOR GEN_NATUREZAS_OPERACAO_ID^'
      'CREATE GENERATOR GEN_NOTAS_FISCAIS_ID^'
      'CREATE GENERATOR GEN_PRODUTO_FORNECEDOR_ID^'
      'CREATE GENERATOR GEN_PESSOAS_ID^'
      'CREATE GENERATOR GEN_FORMAS_PAGAMENTO_ID'
      '^'
      'CREATE TABLE ALIQ_INTERNA_ICMS ('
      '    CODIGO         INTEGER NOT NULL,'
      '    CODIGO_ESTADO  INTEGER,'
      '    ALIQUOTA       NUMERIC(15,2)'
      ')^'
      ''
      'CREATE TABLE CFOP_CORRESPONDENTE ('
      '    CODIGO            INTEGER NOT NULL,'
      '    COD_CFOP_SAIDA    INTEGER,'
      '    COD_CFOP_ENTRADA  INTEGER'
      ')^'
      ''
      'CREATE TABLE ICMS_ESTADO ('
      '    CODIGO           INTEGER NOT NULL,'
      '    CODIGO_ESTADO    INTEGER,'
      '    PERC_REDUCAO_BC  NUMERIC(15,2)'
      ')^'
      ''
      'CREATE TABLE ITENS_AVULSOS ('
      '    CODIGO               CODIGO NOT NULL,'
      '    CODIGO_NOTA_FISCAL   CODIGO,'
      '    CODIGO_PRODUTO       CODIGO,'
      '    PRECO                NUMERIC(15,2) NOT NULL,'
      '    QUANTIDADE     NUMERIC(15,2) NOT NULL,'
      '    PERCENTUAL_DESCONTO  NUMERIC(15,2) NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_COFINS_ALIQ ('
      '    CODIGO_ITEM  CODIGO NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_COFINS_NT ('
      '    CODIGO_ITEM  CODIGO NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_ICMS_00 ('
      '    CODIGO_ITEM      CODIGO NOT NULL,'
      '    ORIGEM           INTEGER NOT NULL,'
      '    ALIQUOTA         NUMERIC(15,2) NOT NULL,'
      '    PERC_REDUCAO_BC  NUMERIC(15,2)'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_ICMS_SN_101 ('
      '    CODIGO_ITEM          CODIGO NOT NULL,'
      '    ORIGEM               INTEGER NOT NULL,'
      '    ALIQUOTA_CREDITO_SN  NUMERIC(15,2) NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_IPI_NT ('
      '    CODIGO_ITEM  CODIGO NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_IPI_TRIB ('
      '    CODIGO_ITEM  CODIGO NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_PIS_ALIQ ('
      '    CODIGO_ITEM  CODIGO NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NF_PIS_NT ('
      '    CODIGO_ITEM  CODIGO NOT NULL'
      ')^'
      ''
      'CREATE TABLE ITENS_NOTAS_FISCAIS ('
      '    CODIGO              INTEGER NOT NULL,'
      '    CODIGO_NOTA_FISCAL  CODIGO,'
      '    CODIGO_PRODUTO      CODIGO,'
      '    CODIGO_NATUREZA     CODIGO,'
      '    QUANTIDADE          NUMERIC(15,4) NOT NULL,'
      '    VALOR_UNITARIO      NUMERIC(15,4) NOT NULL'
      ')^'
      ''
      'CREATE TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL  CODIGO NOT NULL,'
      '    CNPJ_CPF            VARCHAR(14) NOT NULL,'
      '    LOGRADOURO          VARCHAR(80) NOT NULL,'
      '    NUMERO              VARCHAR(10) NOT NULL,'
      '    BAIRRO              NOME_MEDIO,'
      '    COMPLEMENTO         VARCHAR(100) NOT NULL,'
      '    COD_MUN             INTEGER NOT NULL,'
      '    NOME_MUN            VARCHAR(80) NOT NULL,'
      '    UF                  VARCHAR(2) NOT NULL,'
      '    CEP                 VARCHAR(10) NOT NULL'
      ')^'
      ''
      'CREATE TABLE LOTES_NFE ('
      '    CODIGO              CODIGO NOT NULL,'
      '    CODIGO_NOTA_FISCAL  CODIGO,'
      '    DATA                TIMESTAMP NOT NULL'
      ')^'
      ''
      'CREATE TABLE LOTES_NFE_RETORNO ('
      '    CODIGO_LOTE  CODIGO NOT NULL,'
      '    STATUS       VARCHAR(3) NOT NULL,'
      '    MOTIVO       VALOR_EXTRA_GRANDE,'
      '    RECIBO       VARCHAR(15) NOT NULL'
      ')^'
      ''
      'CREATE TABLE NATUREZAS_OPERACAO ('
      '    CODIGO          CODIGO NOT NULL,'
      '    DESCRICAO       NOME_MEDIO,'
      '    CFOP            VARCHAR(4) NOT NULL,'
      '    SUSPENSAO_ICMS  CHAR(1)'
      ')^'
      ''
      'CREATE TABLE NOTAS_FISCAIS ('
      '    CODIGO                 CODIGO NOT NULL,'
      '    NUMERO_NOTA_FISCAL     INTEGER NOT NULL,'
      '    CODIGO_NATUREZA        CODIGO,'
      '    SERIE                  VARCHAR(3) NOT NULL,'
      '    CODIGO_EMITENTE        CODIGO,'
      '    CODIGO_DESTINATARIO    CODIGO,'
      '    CODIGO_FPAGTO          CODIGO,'
      '    DATA_EMISSAO           TIMESTAMP NOT NULL,'
      '    DATA_SAIDA             TIMESTAMP NOT NULL,'
      '    CODIGO_TRANSPORTADORA  CODIGO,'
      '    TIPO_FRETE             INTEGER NOT NULL,'
      '    ENTRADA_SAIDA          CHAR(1),'
      '    FINALIDADE             CHAR(1),'
      '    NFE_REFERENCIADA       VARCHAR(44)'
      ')^'
      ''
      'CREATE TABLE NOTAS_FISCAIS_NFE ('
      '    CODIGO_NOTA_FISCAL  CODIGO NOT NULL,'
      '    CHAVE_ACESSO        VARCHAR(44) NOT NULL,'
      '    XML                 BLOB SUB_TYPE 1 SEGMENT SIZE 80 NOT NULL'
      ')^'
      ''
      'CREATE TABLE NOTAS_FISCAIS_NFE_RETORNO ('
      '    CODIGO_NOTA_FISCAL  CODIGO NOT NULL,'
      '    STATUS              VARCHAR(3) NOT NULL,'
      '    MOTIVO              VALOR_EXTRA_GRANDE'
      ')^'
      ''
      'CREATE TABLE OBSERVACOES_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL    CODIGO NOT NULL,'
      '    OBSERVACOES           VALOR_EXTRA_GRANDE,'
      '    OBS_GER_PELO_SISTEMA  VALOR_EXTRA_GRANDE'
      ')^'
      ''
      'CREATE TABLE TOTAIS_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL          CODIGO NOT NULL,'
      '    FRETE                       NUMERIC(15,2) NOT NULL,'
      '    SEGURO                      NUMERIC(15,2) NOT NULL,'
      '    DESCONTO                    NUMERIC(15,2) NOT NULL,'
      '    OUTRAS_DESPESAS             NUMERIC(15,2) NOT NULL,'
      '    PERCENTUAL_DESCONTO_FATURA  NUMERIC(15,2)'
      ')^'
      ''
      'CREATE TABLE VOLUMES_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL  CODIGO NOT NULL,'
      '    ESPECIE             NOME_MEDIO,'
      '    QUANTIDADE_VOLUMES  NUMERIC(15,2) NOT NULL,'
      '    PESO_LIQUIDO        NUMERIC(15,2) NOT NULL,'
      '    PESO_BRUTO          NUMERIC(15,2) NOT NULL'
      ')^'
      'CREATE TABLE PRODUTO_FORNECEDOR ('
      '    CODIGO                     INTEGER NOT NULL,'
      '    CODIGO_PRODUTO                INTEGER,'
      '    CODIGO_FORNECEDOR          INTEGER,'
      '    CODIGO_PRODUTO_FORNECEDOR  VARCHAR(40)'
      ')^'
      'CREATE TABLE PESSOAS ('
      '    CODIGO         INTEGER NOT NULL,'
      '    RAZAO          VARCHAR(60),'
      '    PESSOA         CHAR(1),'
      '    TIPO           CHAR(1),'
      '    CPF_CNPJ       VARCHAR(14),'
      '    RG_IE          VARCHAR(15),'
      '    DTCADASTRO     DATE,'
      '    FONE1          VARCHAR(15),'
      '    FONE2          VARCHAR(15),'
      '    FAX            VARCHAR(15),'
      '    EMAIL          VARCHAR(250),'
      '    OBSERVACAO     VARCHAR(200),'
      '    BLOQUEADO      CHAR(1),'
      '    MOTIVO_BLOQ    VARCHAR(500),'
      '    NOME_FANTASIA  VARCHAR(60)'
      ')^'
      'CREATE TABLE FORMAS_PAGAMENTO ('
      '    CODIGO     INTEGER NOT NULL,'
      '    DESCRICAO  VARCHAR(100)'
      ')'
      '^'
      'ALTER TABLE ENDERECOS'
      'ADD CODIGO_PESSOA INTEGER'
      '^')
    ParentCtl3D = False
    TabOrder = 38
    WordWrap = False
  end
  object versao40: TMemo
    Left = 126
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'ALTER TABLE ESTADOS ADD CONSTRAINT PK_ESTADOS PRIMARY KEY (CODIG' +
        'O)^'
      
        'ALTER TABLE ALIQ_INTERNA_ICMS ADD CONSTRAINT PK_ALIQ_INTERNA_ICM' +
        'S PRIMARY KEY (CODIGO)^'
      
        'ALTER TABLE CFOP_CORRESPONDENTE ADD CONSTRAINT PK_CFOP_CORRESPON' +
        'DENTE PRIMARY KEY (CODIGO)^'
      
        'ALTER TABLE ICMS_ESTADO ADD CONSTRAINT PK_ICMS_ESTADO PRIMARY KE' +
        'Y (CODIGO)^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT PK_ITENS_AVULSOS PRIMAR' +
        'Y KEY (CODIGO)^'
      
        'ALTER TABLE ITENS_NF_COFINS_ALIQ ADD CONSTRAINT PK_ITENS_NF_COFI' +
        'NS_ALIQ PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_COFINS_NT ADD CONSTRAINT PK_ITENS_NF_COFINS' +
        '_NT PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_ICMS_00 ADD CONSTRAINT PK_ITENS_NF_ICMS_00 ' +
        'PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_ICMS_SN_101 ADD CONSTRAINT PK_ITENS_NF_ICMS' +
        '_SN_101 PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_IPI_NT ADD CONSTRAINT PK_ITENS_NF_IPI_NT PR' +
        'IMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_IPI_TRIB ADD CONSTRAINT PK_ITENS_NF_IPI_TRI' +
        'B PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_PIS_ALIQ ADD CONSTRAINT PK_ITENS_NF_PIS_ALI' +
        'Q PRIMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NF_PIS_NT ADD CONSTRAINT PK_ITENS_NF_PIS_NT PR' +
        'IMARY KEY (CODIGO_ITEM)^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT PK_ITENS_NOTAS_FI' +
        'SCAIS PRIMARY KEY (CODIGO)^'
      
        'ALTER TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ADD CONSTRAINT PK_LOCAI' +
        'S_ENTREGA_NOTAS_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE LOTES_NFE ADD CONSTRAINT PK_LOTES_NFE PRIMARY KEY (C' +
        'ODIGO)^'
      
        'ALTER TABLE LOTES_NFE_RETORNO ADD CONSTRAINT PK_LOTES_NFE_RETORN' +
        'O PRIMARY KEY (CODIGO_LOTE)^'
      
        'ALTER TABLE NATUREZAS_OPERACAO ADD CONSTRAINT PK_NATUREZAS_OPERA' +
        'CAO PRIMARY KEY (CODIGO)^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT PK_NOTAS_FISCAIS PRIMAR' +
        'Y KEY (CODIGO)^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE ADD CONSTRAINT PK_NOTAS_FISCAIS_NF' +
        'E PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE_RETORNO ADD CONSTRAINT PK_NOTAS_FI' +
        'SCAIS_NFE_RETORNO PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE OBSERVACOES_NOTAS_FISCAIS ADD CONSTRAINT PK_OBSERVAC' +
        'OES_NOTAS_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE TOTAIS_NOTAS_FISCAIS ADD CONSTRAINT PK_TOTAIS_NOTAS_' +
        'FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE VOLUMES_NOTAS_FISCAIS ADD CONSTRAINT PK_VOLUMES_NOTA' +
        'S_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)^'
      
        'ALTER TABLE PRODUTO_FORNECEDOR ADD CONSTRAINT PK_PRODUTO_FORNECE' +
        'DOR PRIMARY KEY (CODIGO)^'
      
        'ALTER TABLE PESSOAS ADD CONSTRAINT PK_PESSOAS PRIMARY KEY (CODIG' +
        'O)^'
      
        'ALTER TABLE FORMAS_PAGAMENTO ADD CONSTRAINT PK_FORMAS_PAGAMENTO ' +
        'PRIMARY KEY (CODIGO)^')
    ParentCtl3D = False
    TabOrder = 39
    WordWrap = False
  end
  object versao42: TMemo
    Left = 206
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TRIGGER CFOP_CORRESPONDENTE_BI FOR CFOP_CORRESPONDENTE'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN     ' +
        'NEW.CODIGO = GEN_ID(GEN_CFOP_CORRESPONDENTE_ID,1); END'
      '^'
      'CREATE TRIGGER ICMS_ESTADO_BI FOR ICMS_ESTADO'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN     ' +
        'NEW.CODIGO = GEN_ID(GEN_ICMS_ESTADO_ID,1); END'
      '^'
      'CREATE TRIGGER ITENS_AVULSOS_BI FOR ITENS_AVULSOS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_itens_avulsos_id,1); end'
      '^'
      'CREATE TRIGGER ITENS_NOTAS_FISCAIS_BI FOR ITENS_NOTAS_FISCAIS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_itens_notas_fiscais_id,1); end'
      '^'
      'CREATE TRIGGER LOTES_NFE_BI FOR LOTES_NFE'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0)) then   ' +
        '  new.codigo = gen_id(gen_lotes_nfe_id,1); end'
      '^'
      'CREATE TRIGGER NATUREZAS_OPERACAO_BI FOR NATUREZAS_OPERACAO'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_naturezas_operacao_id,1); end'
      '^'
      'CREATE TRIGGER NOTAS_FISCAIS_BI FOR NOTAS_FISCAIS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_notas_fiscais_id,1); end'
      '^'
      'CREATE TRIGGER PRODUTO_FORNECEDOR_BI FOR PRODUTO_FORNECEDOR'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL) or (NEW.CODIGO = 0)) THEN   ' +
        '  NEW.CODIGO = GEN_ID(GEN_PRODUTO_FORNECEDOR_ID,1); END'
      '^'
      'CREATE TRIGGER PESSOAS_BI FOR PESSOAS'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL)or(new.codigo = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_PESSOAS_ID,1);'
      'END'
      '^'
      'CREATE TRIGGER FORMAS_PAGAMENTO_BI FOR FORMAS_PAGAMENTO'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN     ' +
        'NEW.CODIGO = GEN_ID(GEN_FORMAS_PAGAMENTO_ID,1); END'
      '^')
    ParentCtl3D = False
    TabOrder = 40
    WordWrap = False
  end
  object versao41: TMemo
    Left = 166
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'ALTER TABLE ALIQ_INTERNA_ICMS ADD CONSTRAINT FK_ALIQ_INTERNA_ICM' +
        'S_1 FOREIGN KEY (CODIGO_ESTADO) REFERENCES ESTADOS (CODIGO)^'
      
        'ALTER TABLE CFOP_CORRESPONDENTE ADD CONSTRAINT FK_CFOP_CORRESPON' +
        'DENTE_1 FOREIGN KEY (COD_CFOP_SAIDA) REFERENCES NATUREZAS_OPERAC' +
        'AO (CODIGO)^'
      
        'ALTER TABLE CFOP_CORRESPONDENTE ADD CONSTRAINT FK_CFOP_CORRESPON' +
        'DENTE_2 FOREIGN KEY (COD_CFOP_ENTRADA) REFERENCES NATUREZAS_OPER' +
        'ACAO (CODIGO)^'
      
        'ALTER TABLE ICMS_ESTADO ADD CONSTRAINT FK_ICMS_ESTADO_1 FOREIGN ' +
        'KEY (CODIGO_ESTADO) REFERENCES ESTADOS (CODIGO)^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT FK_ITENS_AVULSOS_NF FOR' +
        'EIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (CODIGO) ' +
        'ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT FK_ITENS_AVULSOS_PRODUT' +
        'O FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS (CODIGO)^'
      
        'ALTER TABLE ITENS_NF_COFINS_ALIQ ADD CONSTRAINT FK_ITENS_NF_COFI' +
        'NS_ALIQ_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_COFINS_NT ADD CONSTRAINT FK_ITENS_NF_COFINS' +
        '_NT_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS ' +
        '(CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_ICMS_00 ADD CONSTRAINT FK_ITENS_NF_ICMS_00_' +
        'IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (COD' +
        'IGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_ICMS_SN_101 ADD CONSTRAINT FK_ITENS_NF_ICMS' +
        '_SN_101_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_IPI_NT ADD CONSTRAINT FK_ITENS_NF_IPI_NT_IT' +
        ' FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (CODIG' +
        'O) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_IPI_TRIB ADD CONSTRAINT FK_ITENS_NF_IPI_TRI' +
        'B_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (C' +
        'ODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_PIS_ALIQ ADD CONSTRAINT FK_ITENS_NF_PIS_ALI' +
        'Q_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (C' +
        'ODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NF_PIS_NT ADD CONSTRAINT FK_ITENS_NF_PIS_NT_IT' +
        ' FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (CODIG' +
        'O) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_NAT FOREIGN KEY (CODIGO_NATUREZA) REFERENCES NATUREZAS_OPE' +
        'RACAO (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_NF FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCA' +
        'IS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_PROD FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS (COD' +
        'IGO) ON DELETE CASCADE^'
      
        'ALTER TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ADD CONSTRAINT FK_LOCAI' +
        'S_ENTREGA_NOTAS_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFEREN' +
        'CES NOTAS_FISCAIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE LOTES_NFE ADD CONSTRAINT FK_LOTES_NFE_NOTA_FISCAL FO' +
        'REIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (CODIGO)' +
        ' ON DELETE CASCADE^'
      
        'ALTER TABLE LOTES_NFE_RETORNO ADD CONSTRAINT FK_LOTES_NFE_RETORN' +
        'O FOREIGN KEY (CODIGO_LOTE) REFERENCES LOTES_NFE (CODIGO) ON DEL' +
        'ETE CASCADE^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_DEST F' +
        'OREIGN KEY (CODIGO_DESTINATARIO) REFERENCES PESSOAS (CODIGO)^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_EMIT F' +
        'OREIGN KEY (CODIGO_EMITENTE) REFERENCES PESSOAS (CODIGO)^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_FPAGTO' +
        ' FOREIGN KEY (CODIGO_FPAGTO) REFERENCES FORMAS_PAGAMENTO (CODIGO' +
        ')^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_NAT FO' +
        'REIGN KEY (CODIGO_NATUREZA) REFERENCES NATUREZAS_OPERACAO (CODIG' +
        'O)^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_TRANSP' +
        ' FOREIGN KEY (CODIGO_TRANSPORTADORA) REFERENCES PESSOAS (CODIGO)' +
        '^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE ADD CONSTRAINT FK_NOTAS_FISCAIS_NF' +
        'E FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (COD' +
        'IGO) ON DELETE CASCADE^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE_RETORNO ADD CONSTRAINT FK_NOTAS_FI' +
        'SCAIS_NFE_RETORNO FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NO' +
        'TAS_FISCAIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE OBSERVACOES_NOTAS_FISCAIS ADD CONSTRAINT FK_OBSERVAC' +
        'OES_NOTAS_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NO' +
        'TAS_FISCAIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE TOTAIS_NOTAS_FISCAIS ADD CONSTRAINT FK_TOTAIS_NOTAS_' +
        'FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAI' +
        'S (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE VOLUMES_NOTAS_FISCAIS ADD CONSTRAINT FK_VOLUMES_NOTA' +
        'S_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE^'
      
        'ALTER TABLE PRODUTO_FORNECEDOR ADD CONSTRAINT FK_PRODUTO_FORNECE' +
        'DOR_1 FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS (CODIGO)^'
      
        'ALTER TABLE PRODUTO_FORNECEDOR ADD CONSTRAINT FK_PRODUTO_FORNECE' +
        'DOR_2 FOREIGN KEY (CODIGO_FORNECEDOR) REFERENCES PESSOAS (CODIGO' +
        ')^'
      
        'ALTER TABLE ENDERECOS ADD CONSTRAINT FK_ENDERECOS_2 FOREIGN KEY ' +
        '(CODIGO_PESSOA) REFERENCES PESSOAS (CODIGO)^')
    ParentCtl3D = False
    TabOrder = 41
    WordWrap = False
  end
  object versao43: TMemo
    Left = 246
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (1, '#39'VENDA DE PRODU'#199#195'O DO ESTABELECIMENTO'#39', '#39'510' +
        '1'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (2, '#39'VENDA DE PRODU'#199#195'O DO ESTABELECIMENTO'#39', '#39'610' +
        '1'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (3, '#39'REMESSA DE MERCADORIA OU BEM PARA DEMONSTRA' +
        #199#195'O'#39', '#39'6912'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (4, '#39'REMESSA DE MERCADORIA OU BEM PARA DEMONSTRA' +
        #199#195'O'#39', '#39'5912'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (5, '#39'BONIFICA'#199#195'O'#39', '#39'5910'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (6, '#39'RETORNO DE BEM RECEBIDO DE CONTRATO DE COMO' +
        'DATO'#39', '#39'6909'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (7, '#39'VENDA DE MERC. ADQUIRIDA OU RECEBIDA DE TER' +
        'CEIRO'#39', '#39'5102'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (8, '#39'VENDA DE MERC. ADQUIRIDA OU RECEBIDA DE TER' +
        'CEIRO'#39', '#39'6102'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (9, '#39'RETORNO DE MERC RECEBIDA PARA IND E NAO APL' +
        'IC. NO'#39', '#39'6903'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (10, '#39'ENTRADA'#39', '#39'2903'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (11, '#39'INDUSTRIALIZA'#199#195'O MERC REC CTA ORDEM TERCEI' +
        'RO'#39', '#39'6125'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (12, '#39'ENTRADA'#39', '#39'2125'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (13, '#39'RETORNO MERC REC CTA ORDEM TERCEIRO'#39', '#39'692' +
        '5'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (14, '#39'ENTRADA'#39', '#39'2925'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (15, '#39'ENTRADA'#39', '#39'2101'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (16, '#39'VENDA OUT. ESTADOS'#39', '#39'6122'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (17, '#39'ENTRADA'#39', '#39'2122'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (18, '#39'COMPRA DE BEM PARA O ATIVO IMOBILIZADO'#39', '#39 +
        '1551'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (19, '#39'ENTRADA'#39', '#39'1102'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (20, '#39'DEVOLU'#199#195'O DE VASILHAME OU SACARIA'#39', '#39'5921'#39 +
        ', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (21, '#39'DEVOLU'#199#195'O DE VASILHAME OU SACARIA'#39', '#39'6921'#39 +
        ', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (22, '#39'REMESSA VASILHAME OU SACARIA'#39', '#39'6920'#39', NUL' +
        'L)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (23, '#39'REMESSA VASILHAME OU SACARIA'#39', '#39'5920'#39', NUL' +
        'L)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (24, '#39'ENTRADA'#39', '#39'2920'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (25, '#39'ENTRADA'#39', '#39'1920'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (26, '#39'DEVOLU'#199#195'O DE VENDA DE MERC. ADQ. OU REC. D' +
        'E TERCEI'#39', '#39'2202'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (27, '#39'REMESSA DE MER. POR CONTA E ORDEM DE TER. ' +
        'EM VENDA'#39', '#39'5923'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (28, '#39'REMESSA DE MER. POR CONTA E ORDEM DE TER. ' +
        'EM VENDA'#39', '#39'6923'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (29, '#39'ENTRADA'#39', '#39'2102'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (30, '#39'RETORNO DE EMPRESTIMO / LOCA'#199#195'O'#39', '#39'5949'#39', ' +
        'NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (31, '#39'OUTRA SA'#205'DA DE MERC. OU PREST. DE SERV. NA' +
        'O ESPEC'#39', '#39'6949'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (32, '#39'VENDA DE MERCADORIA SUB. TRIB.'#39', '#39'5405'#39', N' +
        'ULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (33, '#39'ENTRADA'#39', '#39'1403'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (34, '#39'REMESSA PARA INDUSTRIALIZA'#199#195'O POR ENCOMEND' +
        'A'#39', '#39'5901'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (35, '#39'BONIFICA'#199#195'O'#39', '#39'6910'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (36, '#39'DEVOLU'#199#195'O DE VENDA DE PRODU'#199#195'O DO ESTABELE' +
        'CIMENTO'#39', '#39'5201'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (40, '#39'RETORNO DE MERC. UTILIZADA NA IND. POR ENC' +
        'OMENDA'#39', '#39'5902'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (37, '#39'DEVOLU'#199#195'O DE VENDA DE PRODU'#199#195'O DO ESTABELE' +
        'CIMENTO'#39', '#39'1201'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (38, '#39'DEV. DE VENDA DE MER. ADQUIRIDA OU REC. PO' +
        'R TERCEI'#39', '#39'1202'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (39, '#39'DEV. DE VENDA DE MER. ADQUIRIDA OU REC. PO' +
        'R TERCEI'#39', '#39'5202'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (41, '#39'SERVI'#199'O DE INDUSTRIALIZA'#199#195'O POR ENCOMENDA'#39 +
        ', '#39'5124'#39', NULL)^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (42, '#39'RETORNO DE DEMONSTRACAO'#39', '#39'6913'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (43, '#39'RETORNO DE DEMONSTRACAO'#39', '#39'2913'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (44, '#39'DEVOLU'#199#195'O DE COMPRA PARA COMERCIALIZA'#199#195'O'#39',' +
        ' '#39'6202'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (45, '#39'DEVOLU'#199#195'O DE VENDA DE PRODU'#199#195'O DO ESTABELE' +
        'CIMENTO'#39', '#39'2201'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (46, '#39'VENDA DE MERCADORIA C/SUBSTITUICAO TRIBUTA' +
        'RIA'#39', '#39'5403'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (47, '#39'ENTRADA'#39', '#39'2403'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (48, '#39'RETORNO MERC.OU BEM RECEBIDO P/ CONSERTO O' +
        'U REPARO'#39', '#39'5916'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (49, '#39'REMESSA MERC.OU BEM P/CONSERTO OU REPARO'#39',' +
        ' '#39'5915'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (50, '#39'ENTRADA'#39', '#39'1915'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (51, '#39'ENTRADA'#39', '#39'2915'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (52, '#39'VENDA REF CUPOM FISCAL EMITIDO'#39', '#39'5929'#39', '#39 +
        'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (53, '#39'ENTRADA'#39', '#39'1929'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (54, '#39'REMESSA PARA INDUSTRIALIZA'#199#195'O POR ENCOMEND' +
        'A'#39', '#39'6901'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (55, '#39'ENTRADA DE MERC. OU PREST. DE SERV. N'#195'O ES' +
        'PECIFIC'#39', '#39'1949'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (56, '#39'REMESSA DE MERC. OU BEM PARA CONSERTO OU R' +
        'EPARO'#39', '#39'6915'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (57, '#39'REMESSA DE AMOSTRA GRATIS'#39', '#39'6911'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (58, '#39'ENTRADA DE AMOSTRA GRATIS'#39', '#39'2911'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (59, '#39'RETORNO DE MERC. OU BEM REMETIDO PARA CONS' +
        'ERTO'#39', '#39'6916'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (60, '#39'ENTRADA DE RETORNO DE MERC. PARA CONSERTO'#39 +
        ', '#39'2916'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (61, '#39'ENTRADA'#39', '#39'2949'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (62, '#39'COMPRA DE MATERIAL PARA USO OU CONSUMO'#39', '#39 +
        '1556'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (63, '#39'COMPRA DE MATERIAL PARA USO OU CONSUMO'#39', '#39 +
        '2556'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (64, '#39'VENDA DE COMB. OU LUB., ADQUIRIDOS OU REC.' +
        ' TERC.'#39', '#39'5656'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (65, '#39'ENTRADA PARA INDUSTRIALIZA'#199#195'O POR ENCOMEND' +
        'A'#39', '#39'2901'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (69, '#39'INDUSTRIALIZA'#199#195'O EFETUADA PARA OUTRA EMPRE' +
        'SA'#39', '#39'6124'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (66, '#39'ENTRADA PARA INDUSTRIALIZA'#199#195'O POR ENCOMEND' +
        'A'#39', '#39'1901'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (67, '#39'ENTRADA'#39', '#39'1902'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (68, '#39'ENTRADA'#39', '#39'2902'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (70, '#39'INDUSTRIALIZA'#199#195'O EFETUADA POR OUTRA EMPRES' +
        'A'#39', '#39'2124'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (71, '#39'ENTRADA'#39', '#39'2910'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (74, '#39'REMESSA DE AMOSTRA GRATIS'#39', '#39'5911'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (75, '#39'ENTRADA DE AMOSTRA GRATIS'#39', '#39'1911'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (76, '#39'RETORNO DE MERC. UTILIZADA NA INDUSTRIALIZ' +
        'ACAO'#39', '#39'6902'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (77, '#39'VENDA DE PROD. ESTAB. REMET. P/ INDUSTRIAL' +
        'IZACAO'#39', '#39'5122'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (78, '#39'ENTRADA'#39', '#39'1122'#39', '#39'N'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (79, '#39'INDUSTRIALIZACAO P/ TERCEIRO P/ ENCOMENDA'#39 +
        ', '#39'5125'#39', '#39'S'#39')^'
      
        'INSERT INTO NATUREZAS_OPERACAO (CODIGO, DESCRICAO, CFOP, SUSPENS' +
        'AO_ICMS) VALUES (80, '#39'RETORNO MERC. RECEB. P/ IND. P/ CTA. ORDE'#39 +
        ', '#39'5925'#39', '#39'S'#39')^')
    ParentCtl3D = False
    TabOrder = 42
    WordWrap = False
  end
  object versao44: TMemo
    Left = 286
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE PROCEDURE TRANSFERE_CAD_EMPRESA '
      'as'
      'declare variable razao varchar(60);'
      'declare variable nome_fantasia varchar(60);'
      'declare variable cnpj varchar(14);'
      'declare variable ie varchar(14);'
      'declare variable telefone varchar(11);'
      'declare variable cep integer;'
      'declare variable rua varchar(100);'
      'declare variable numero varchar(20);'
      'declare variable bairro varchar(100);'
      'declare variable complemento varchar(200);'
      'declare variable codigo_pessoa integer;'
      'declare variable estado char(2);'
      'declare variable cod_mun integer;'
      'begin'
      
        '  select E.razao_social, E.nome_fantasia, E.cnpj, E.ie, E.telefo' +
        'ne, E.cep, E.rua, E.numero,'
      '         E.bairro, E.complemento, E.cod_municipio, E.estado'
      '   FROM empresa E'
      '     intO'
      
        '   :razao, :nome_fantasia, :cnpj, :ie, :telefone, :cep, :rua, :n' +
        'umero, :bairro, :complemento, :cod_mun, :ESTADO;'
      ''
      
        '  INSERT INTO PESSOAS VALUES(0,:razao, '#39'J'#39', '#39'E'#39', :cnpj, :ie, cur' +
        'rent_date, :telefone, '#39#39', '#39#39', '#39#39', '#39#39', '#39'N'#39', '#39#39', :nome_fantasia);'
      ''
      '  SELECT MAX(CODIGO) FROM pessoas   INTO    :codigo_pessoa;'
      ''
      
        '  INSERT INTO enderecos(codigo, CEP, LOGRADOURO, NUMERO, REFEREN' +
        'CIA, bairro,  CODIGO_CIDADE, UF, FONE, CODIGO_PESSOA)'
      
        '                 VALUES(0, :cep, :rua, :numero, :complemento, :b' +
        'airro, :cod_mun, :estado, :telefone, :codigo_pessoa);'
      '  suspend;'
      'end'
      '^')
    ParentCtl3D = False
    TabOrder = 43
    WordWrap = False
  end
  object versao46: TMemo
    Left = 366
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'DROP PROCEDURE TRANSFERE_CAD_EMPRESA'
      '^'
      'ALTER TABLE EMPRESA DROP RAZAO_SOCIAL'
      '^'
      'ALTER TABLE EMPRESA DROP NOME_FANTASIA'
      '^'
      'ALTER TABLE EMPRESA DROP CNPJ'
      '^'
      'ALTER TABLE EMPRESA DROP IE'
      '^'
      'ALTER TABLE EMPRESA DROP TELEFONE'
      '^'
      'ALTER TABLE EMPRESA DROP SITE'
      '^'
      'ALTER TABLE EMPRESA DROP CIDADE'
      '^'
      'ALTER TABLE EMPRESA DROP ESTADO'
      '^'
      'ALTER TABLE EMPRESA DROP CEP'
      '^'
      'ALTER TABLE EMPRESA DROP RUA'
      '^'
      'ALTER TABLE EMPRESA DROP NUMERO'
      '^'
      'ALTER TABLE EMPRESA DROP BAIRRO'
      '^'
      'ALTER TABLE EMPRESA DROP COMPLEMENTO'
      '^'
      'ALTER TABLE EMPRESA DROP COD_MUNICIPIO'
      '^')
    ParentCtl3D = False
    TabOrder = 44
    WordWrap = False
  end
  object versao45: TMemo
    Left = 326
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'EXECUTE PROCEDURE TRANSFERE_CAD_EMPRESA '
      '^')
    ParentCtl3D = False
    TabOrder = 45
    WordWrap = False
  end
  object versao47: TMemo
    Left = 406
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE PROCEDURE TRANSFERE_CADCLI'
      'as'
      'declare variable cod_cli integer;'
      'declare variable cliente varchar(60);'
      'declare variable codigo_pessoa integer;'
      'declare variable cnpj varchar(14);'
      'begin'
      '  for select c.codigo, c.nome, c.cpf_cnpj'
      '   FROM clientes c'
      '     intO'
      '   :cod_cli, :cliente, :cnpj'
      '  do'
      '  begin'
      ''
      
        '  INSERT INTO PESSOAS(codigo, razao, pessoa, tipo, cpf_cnpj, dtc' +
        'adastro)'
      
        '               VALUES(0,:cliente, '#39'F'#39', '#39'C'#39', :cnpj, current_date)' +
        ';'
      ''
      '  SELECT MAX(CODIGO) FROM pessoas   INTO    :codigo_pessoa;'
      ''
      '  update enderecos set codigo_pessoa = :codigo_pessoa'
      '   Where codigo_cliente = :cod_cli;'
      '  end'
      '  suspend;'
      'end')
    ParentCtl3D = False
    TabOrder = 46
    WordWrap = False
  end
  object versao48: TMemo
    Left = 446
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'EXECUTE PROCEDURE TRANSFERE_CADCLI'
      '^')
    ParentCtl3D = False
    TabOrder = 47
    WordWrap = False
  end
  object versao49: TMemo
    Left = 486
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'drop PROCEDURE TRANSFERE_CADCLI'
      '^')
    ParentCtl3D = False
    TabOrder = 48
    WordWrap = False
  end
  object versao50: TMemo
    Left = 526
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE ENDERECOS DROP CODIGO_CLIENTE'
      '^'
      'DROP TABLE CLIENTES'
      '^'
      'DROP TABLE FORNECEDORES'
      '^')
    ParentCtl3D = False
    TabOrder = 49
    WordWrap = False
  end
  object versao51: TMemo
    Left = 566
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'DROP GENERATOR GEN_FORNECEDORES_ID'
      '^'
      'DROP GENERATOR GEN_CLIENTES_ID'
      '^')
    ParentCtl3D = False
    TabOrder = 50
    WordWrap = False
  end
  object versao52: TMemo
    Left = 606
    Top = 69
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE CONFIGURACOES_NF ('
      '    CODIGO_EMPRESA      INTEGER NOT NULL,'
      '    ALIQ_CRED_SN        NUMERIC(15,2),'
      '    ALIQ_ICMS           NUMERIC(15,2),'
      '    ALIQ_PIS            NUMERIC(15,2),'
      '    ALIQ_COFINS         NUMERIC(15,2),'
      '    NUM_CERTIFICADO     VARCHAR(50),'
      '    AMBIENTE_NFE        VARCHAR(1) NOT NULL,'
      '    SENHA_CERTIFICADO   VARCHAR(50),'
      '    SEQUENCIA_NF        INTEGER,'
      '    TIPO_EMISSAO        SMALLINT,'
      '    DT_CONTINGENCIA     TIMESTAMP,'
      '    CRT                 SMALLINT,'
      '    OBS_GERADA_SISTEMA  VARCHAR(1500)'
      ')^'
      ''
      'CREATE TABLE CONFIGURACOES_NF_EMAIL ('
      '    CODIGO_EMPRESA  INTEGER NOT NULL,'
      '    SMTP_HOST       VARCHAR(50) NOT NULL,'
      '    SMTP_PORT       VARCHAR(10) NOT NULL,'
      '    SMTP_USER       VARCHAR(50) NOT NULL,'
      '    SMTP_PASSWORD   VARCHAR(50) NOT NULL,'
      '    ASSUNTO         VARCHAR(50) NOT NULL,'
      '    MENSAGEM        VARCHAR(2000),'
      '    USA_SSL         CHAR(1) NOT NULL'
      ')^'
      ''
      
        'ALTER TABLE CONFIGURACOES_NF ADD CONSTRAINT PK_CONFIGURACOES_NF ' +
        'PRIMARY KEY (CODIGO_EMPRESA)^'
      
        'ALTER TABLE CONFIGURACOES_NF_EMAIL ADD CONSTRAINT PK_CONFIGURACO' +
        'ES_NF_EMAIL PRIMARY KEY (CODIGO_EMPRESA)^'
      ''
      
        'ALTER TABLE CONFIGURACOES_NF ADD CONSTRAINT FK_CONFIGURACOES_NF_' +
        '1 FOREIGN KEY (CODIGO_EMPRESA) REFERENCES PESSOAS (CODIGO)^'
      
        'ALTER TABLE CONFIGURACOES_NF_EMAIL ADD CONSTRAINT FK_CONFIGURACO' +
        'ES_NF_EMAIL_1 FOREIGN KEY (CODIGO_EMPRESA) REFERENCES PESSOAS (C' +
        'ODIGO)^')
    ParentCtl3D = False
    TabOrder = 51
    WordWrap = False
  end
  object Zsql: TZSQLProcessor
    Params = <>
    Delimiter = ';'
    Left = 24
    Top = 112
  end
end
