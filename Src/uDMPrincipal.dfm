object DMPrincipal: TDMPrincipal
  Height = 930
  Width = 1137
  object ADOConnectionGeral: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=aluno;Persist Security Info=True;Use' +
      'r ID=postgres;Data Source=cadastroUsuarios;Initial Catalog=cadas' +
      'troUsuarios'
    LoginPrompt = False
    Left = 416
    Top = 200
  end
  object DataSourceProdutos: TDataSource
    DataSet = ADOQueryProdutos
    Left = 136
    Top = 104
  end
  object DataSourceCategorias: TDataSource
    DataSet = ADOQueryCategorias
    Left = 104
    Top = 8
  end
  object ADOQueryCategorias: TADOQuery
    Active = True
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *  from produtos Order By categoria')
    Left = 40
    Top = 8
  end
  object ADOQueryTamanho: TADOQuery
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM produtos ORDER BY tamanho_produto')
    Left = 680
    Top = 152
  end
  object DataSourceTamanho: TDataSource
    DataSet = ADOQueryTamanho
    Left = 632
    Top = 168
  end
  object ADOQueryQuantidade: TADOQuery
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM produtos ORDER BY quantidade_produto')
    Left = 408
    Top = 40
  end
  object DataSourceQuantidade: TDataSource
    DataSet = ADOQueryQuantidade
    Left = 480
    Top = 32
  end
  object ADOQueryVendas: TADOQuery
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    Left = 680
    Top = 32
  end
  object DataSourceVendas: TDataSource
    DataSet = ADOQueryVendas
    Left = 744
    Top = 16
  end
  object ADOQueryNomeFornecedor: TADOQuery
    Active = True
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT id_fornecedor, nome_fornecedor FROM fornecedores ORDER BY' +
        ' nome_fornecedor')
    Left = 800
    Top = 288
  end
  object DataSourceNomeFornecedor: TDataSource
    DataSet = ADOQueryNomeFornecedor
    Left = 896
    Top = 264
  end
  object ADOQuery_login: TADOQuery
    Active = True
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from cadusuarios')
    Left = 40
    Top = 224
    object ADOQuery_loginusuario: TStringField
      FieldName = 'usuario'
      Size = 50
    end
    object ADOQuery_loginsenha: TStringField
      FieldName = 'senha'
    end
    object ADOQuery_loginid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
  end
  object DataSource_login: TDataSource
    DataSet = ADOQuery_login
    Left = 112
    Top = 224
  end
  object ADOQuery_produtos: TADOQuery
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    Left = 352
    Top = 320
    object ADOQuery_produtosid_produto: TAutoIncField
      FieldName = 'id_produto'
      ReadOnly = True
    end
    object ADOQuery_produtosnome_produto: TStringField
      FieldName = 'nome_produto'
      Size = 100
    end
    object ADOQuery_produtosquantidade_produto: TIntegerField
      FieldName = 'quantidade_produto'
    end
    object ADOQuery_produtosfornecedor_produto: TStringField
      FieldName = 'fornecedor_produto'
      Size = 100
    end
    object ADOQuery_produtoscategoria: TStringField
      FieldName = 'categoria'
      Size = 50
    end
    object ADOQuery_produtospreco: TFMTBCDField
      FieldName = 'preco'
      Precision = 28
      Size = 6
    end
    object ADOQuery_produtostamanho_produto: TIntegerField
      FieldName = 'tamanho_produto'
    end
  end
  object DataSource_produtos: TDataSource
    DataSet = ADOQuery_produtos
    Left = 416
    Top = 304
  end
  object ADOQuery_contagem: TADOQuery
    Active = True
    Connection = ADOConnectionGeral
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT COUNT(*) AS total_itens FROM produtos;'
      
        'SELECT COUNT(DISTINCT categoria) AS total_categorias FROM produt' +
        'os;')
    Left = 903
    Top = 24
  end
  object ADOQueryFornecedores: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 896
    Top = 144
  end
  object DataSourceFornecedores: TDataSource
    DataSet = ADOQueryFornecedores
    Left = 952
    Top = 128
  end
  object ADOQueryVerificacaoFornecedores: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 728
    Top = 464
  end
  object DataSourceVerificacaoFornecedores: TDataSource
    DataSet = ADOQueryVerificacaoFornecedores
    Left = 792
    Top = 448
  end
  object ADOQueryRemoverVenda_Busca: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 48
    Top = 320
  end
  object DataSourceRemoverVenda_Busca: TDataSource
    DataSet = ADOQueryRemoverVenda_Busca
    Left = 112
    Top = 304
  end
  object ADOQueryRemoverVenda_Produtos: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 32
    Top = 440
  end
  object DataSourceRemoverVenda_Produtos: TDataSource
    DataSet = ADOQueryRemoverVenda_Produtos
    Left = 88
    Top = 440
  end
  object ADOQueryRemoverVenda_Delete: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 32
    Top = 568
  end
  object DataSourceRemoverVenda_Delete: TDataSource
    DataSet = ADOQueryRemoverVenda_Delete
    Left = 88
    Top = 552
  end
  object ADOQueryBuscaCliente: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 352
    Top = 464
  end
  object DataSourceBuscaCliente: TDataSource
    DataSet = ADOQueryBuscaCliente
    Left = 416
    Top = 440
  end
  object ADOQueryRemoverCliente: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 344
    Top = 592
  end
  object DataSourceRemoverCliente: TDataSource
    DataSet = ADOQueryRemoverCliente
    Left = 408
    Top = 568
  end
  object ADOQueryBuscaFornecedor: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 80
    Top = 776
  end
  object DataSourceBuscaFornecedor: TDataSource
    DataSet = ADOQueryBuscaFornecedor
    Left = 80
    Top = 744
  end
  object ADOQueryRemoverFornecedor: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 424
    Top = 712
  end
  object DataSourceRemoverFornecedor: TDataSource
    DataSet = ADOQueryRemoverFornecedor
    Left = 480
    Top = 696
  end
  object ADOQueryBuscaProduto: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 720
    Top = 672
  end
  object DataSourceBuscaProduto: TDataSource
    DataSet = ADOQueryBuscaProduto
    Left = 768
    Top = 656
  end
  object ADOQueryRemoverEstoque: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 984
    Top = 568
  end
  object DataSourceRemoverEstoque: TDataSource
    DataSet = ADOQueryRemoverEstoque
    Left = 1000
    Top = 528
  end
  object ADOQueryVerificaVariacao: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 936
    Top = 728
  end
  object DataSourceVerificaVariacao: TDataSource
    DataSet = ADOQueryVerificaVariacao
    Left = 976
    Top = 728
  end
  object ADOQueryRemoverProduto: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 352
    Top = 848
  end
  object DataSourceRemoverProduto: TDataSource
    DataSet = ADOQueryRemoverProduto
    Left = 384
    Top = 832
  end
  object ADOQueryProdutos: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 64
    Top = 128
  end
  object ADOQueryRemoverVenda_UpdateEstoque: TADOQuery
    Connection = ADOConnectionGeral
    Parameters = <>
    Left = 624
    Top = 832
  end
  object DataSourceRemoverVenda_UpdateEstoque: TDataSource
    DataSet = ADOQueryRemoverVenda_UpdateEstoque
    Left = 688
    Top = 808
  end
end
