unit uDMPrincipal;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDMPrincipal = class(TDataModule)
    ADOConnectionGeral: TADOConnection;
    DataSourceProdutos: TDataSource;
    DataSourceCategorias: TDataSource;
    ADOQueryCategorias: TADOQuery;
    ADOQueryTamanho: TADOQuery;
    DataSourceTamanho: TDataSource;
    ADOQueryQuantidade: TADOQuery;
    DataSourceQuantidade: TDataSource;
    ADOQueryVendas: TADOQuery;
    DataSourceVendas: TDataSource;
    ADOQueryNomeFornecedor: TADOQuery;
    DataSourceNomeFornecedor: TDataSource;
    ADOQuery_login: TADOQuery;
    ADOQuery_loginusuario: TStringField;
    ADOQuery_loginsenha: TStringField;
    ADOQuery_loginid: TAutoIncField;
    DataSource_login: TDataSource;
    ADOQuery_produtos: TADOQuery;
    ADOQuery_produtosid_produto: TAutoIncField;
    ADOQuery_produtosnome_produto: TStringField;
    ADOQuery_produtosquantidade_produto: TIntegerField;
    ADOQuery_produtosfornecedor_produto: TStringField;
    ADOQuery_produtoscategoria: TStringField;
    ADOQuery_produtospreco: TFMTBCDField;
    ADOQuery_produtostamanho_produto: TIntegerField;
    DataSource_produtos: TDataSource;
    ADOQuery_contagem: TADOQuery;
    ADOQueryFornecedores: TADOQuery;
    DataSourceFornecedores: TDataSource;
    ADOQueryVerificacaoFornecedores: TADOQuery;
    DataSourceVerificacaoFornecedores: TDataSource;
    ADOQueryRemoverVenda_Busca: TADOQuery;
    DataSourceRemoverVenda_Busca: TDataSource;
    ADOQueryRemoverVenda_Produtos: TADOQuery;
    DataSourceRemoverVenda_Produtos: TDataSource;
    ADOQueryRemoverVenda_Delete: TADOQuery;
    DataSourceRemoverVenda_Delete: TDataSource;
    ADOQueryBuscaCliente: TADOQuery;
    DataSourceBuscaCliente: TDataSource;
    ADOQueryRemoverCliente: TADOQuery;
    DataSourceRemoverCliente: TDataSource;
    ADOQueryBuscaFornecedor: TADOQuery;
    DataSourceBuscaFornecedor: TDataSource;
    ADOQueryRemoverFornecedor: TADOQuery;
    DataSourceRemoverFornecedor: TDataSource;
    ADOQueryBuscaProduto: TADOQuery;
    DataSourceBuscaProduto: TDataSource;
    ADOQueryRemoverEstoque: TADOQuery;
    DataSourceRemoverEstoque: TDataSource;
    ADOQueryVerificaVariacao: TADOQuery;
    DataSourceVerificaVariacao: TDataSource;
    ADOQueryRemoverProduto: TADOQuery;
    DataSourceRemoverProduto: TDataSource;
    ADOQueryProdutos: TADOQuery;
    ADOQueryRemoverVenda_UpdateEstoque: TADOQuery;
    DataSourceRemoverVenda_UpdateEstoque: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }


  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



end.
