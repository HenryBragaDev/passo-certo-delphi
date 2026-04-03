object TelaRemoverFornecedor: TTelaRemoverFornecedor
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'TelaRemoverFornecedor'
  ClientHeight = 701
  ClientWidth = 1139
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnShow = FormShow
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 39
    Top = -68
    Width = 1042
    Height = 769
    BevelOuter = bvNone
    Color = clBackground
    ParentBackground = False
    TabOrder = 0
    object pnlborda: TPanel
      Left = 128
      Top = 88
      Width = 801
      Height = 569
      BevelOuter = bvNone
      Color = 13487565
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        801
        569)
      object shpCriarProduto: TShape
        Left = 0
        Top = 55
        Width = 801
        Height = 562
        Brush.Color = clBtnFace
      end
      object speedbtn_fechar: TSpeedButton
        Left = 776
        Top = 10
        Width = 17
        Height = 17
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BiDiMode = bdLeftToRight
        Caption = 'X'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = 4802889
        Font.Height = -33
        Font.Name = 'Arrial Narrow'
        Font.Style = []
        ParentFont = False
        ParentBiDiMode = False
        OnClick = speedbtn_fecharClick
      end
      object lblTitulo: TLabel
        Left = 24
        Top = 15
        Width = 199
        Height = 24
        Caption = 'Remover Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Poppins'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlItens: TPanel
        Left = 0
        Top = 55
        Width = 801
        Height = 566
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblCnpj: TLabel
          Left = 59
          Top = 103
          Width = 61
          Height = 29
          Caption = 'Cnpj:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTamanho: TLabel
          Left = 55
          Top = 171
          Width = 104
          Height = 29
          Caption = 'Telefone:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblEmail: TLabel
          Left = 59
          Top = 242
          Width = 71
          Height = 29
          Caption = 'Email:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object shpSalvar: TShape
          Left = 387
          Top = 418
          Width = 145
          Height = 41
          Brush.Color = 7091712
          Shape = stRoundRect
        end
        object shpCancelar: TShape
          Left = 567
          Top = 418
          Width = 138
          Height = 41
          Shape = stRoundRect
        end
        object SpeedbtnSalvar: TSpeedButton
          Left = 388
          Top = 419
          Width = 142
          Height = 39
          Caption = 'Salvar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedbtnSalvarClick
        end
        object SpeedbtnCancelar: TSpeedButton
          Left = 569
          Top = 419
          Width = 135
          Height = 39
          Caption = 'Cancelar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedbtnCancelarClick
        end
        object shpCor: TShape
          Left = 0
          Top = 0
          Width = 801
          Height = 1
          Align = alTop
          Brush.Color = 15724527
          ExplicitWidth = 799
        end
        object lblFornecedor: TLabel
          Left = 59
          Top = 39
          Width = 139
          Height = 29
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Poppins'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbFornecedor: TDBLookupComboBox
          Left = 288
          Top = 38
          Width = 417
          Height = 30
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Poppins'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnCloseUp = cbFornecedorCloseUp
        end
        object cbCnpj: TDBLookupComboBox
          Left = 288
          Top = 103
          Width = 417
          Height = 30
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Poppins'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnCloseUp = cbCnpjCloseUp
        end
        object cbTelefone: TDBLookupComboBox
          Left = 288
          Top = 171
          Width = 281
          Height = 30
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Poppins'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnCloseUp = cbTelefoneCloseUp
        end
        object cbEmail: TDBLookupComboBox
          Left = 288
          Top = 241
          Width = 281
          Height = 30
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Poppins'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnCloseUp = cbTelefoneCloseUp
        end
      end
    end
  end
  object ADOQueryFornecedor_Nome: TADOQuery
    Connection = DMPrincipal.ADOConnectionGeral
    Parameters = <>
    Left = 63
    Top = 604
  end
  object DataSourceFornecedor_Nome: TDataSource
    DataSet = ADOQueryFornecedor_Nome
    Left = 111
    Top = 580
  end
  object ADOQueryFornecedor_Cnpj: TADOQuery
    Connection = DMPrincipal.ADOConnectionGeral
    Parameters = <>
    Left = 279
    Top = 628
  end
  object DataSourceFornecedor_Cnpj: TDataSource
    DataSet = ADOQueryFornecedor_Cnpj
    Left = 327
    Top = 612
  end
  object ADOQueryFornecedor_Telefone: TADOQuery
    Connection = DMPrincipal.ADOConnectionGeral
    Parameters = <>
    Left = 527
    Top = 636
  end
  object DataSourceFornecedor_Telefone: TDataSource
    DataSet = ADOQueryFornecedor_Telefone
    Left = 599
    Top = 620
  end
  object ADOQueryFornecedor_Email: TADOQuery
    Connection = DMPrincipal.ADOConnectionGeral
    Parameters = <>
    Left = 807
    Top = 620
  end
  object DataSourceFornecedor_Email: TDataSource
    DataSet = ADOQueryFornecedor_Email
    Left = 847
    Top = 604
  end
end
