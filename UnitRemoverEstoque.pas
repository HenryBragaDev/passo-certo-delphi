unit UnitRemoverEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TtelaRemoverEstoque = class(TForm)
    pnlFundo: TPanel;
    pnlborda: TPanel;
    shpCriarProduto: TShape;
    speedbtn_fechar: TSpeedButton;
    lblTitulo: TLabel;
    pnlItens: TPanel;
    lblNome: TLabel;
    lbltelefone: TLabel;
    lblPreco: TLabel;
    shpSalvar: TShape;
    shpCancelar: TShape;
    SpeedbtnSalvar: TSpeedButton;
    SpeedbtnCancelar: TSpeedButton;
    shpCor: TShape;
    lblCategoria: TLabel;
    cbCategoria: TDBLookupComboBox;
    cbProduto: TDBLookupComboBox;
    cbTamanho: TDBLookupComboBox;
    cbQuantidade: TDBLookupComboBox;
    ADOQueryRemover_Categorias: TADOQuery;
    DataSourceRemover_Categorias: TDataSource;
    ADOQueryRemover_Produtos: TADOQuery;
    DataSourceRemover_Produtos: TDataSource;
    ADOQueryRemover_Quantidades: TADOQuery;
    DataSourceRemover_Quantidade: TDataSource;
    ADOQueryEstoque_Tamanho: TADOQuery;
    DataSourceEstoque_Tamanho: TDataSource;

    procedure FormActivate(Sender: TObject);
    procedure SpeedbtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbCategoriaCloseUp(Sender: TObject);
    procedure cbTamanhoCloseUp(Sender: TObject);
    procedure cbProdutoCloseUp(Sender: TObject);
    procedure SpeedbtnSalvarClick(Sender: TObject);
    procedure speedbtn_fecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  telaRemoverEstoque: TtelaRemoverEstoque;

implementation

{$R *.dfm}

  uses uDMPrincipal, UnitTelaEstoque;


  procedure TtelaRemoverEstoque.cbCategoriaCloseUp(Sender: TObject);
  begin
    ADOQueryRemover_Produtos.Close;
    ADOQueryRemover_Produtos.SQL.Text :=
      'SELECT DISTINCT p.id_produto, p.nome_produto ' +
      'FROM produtos p ' +
      'JOIN variacoes_produto vp ON vp.id_produto = p.id_produto ' +
      'WHERE p.categoria = :categoria ORDER BY p.nome_produto';
    ADOQueryRemover_Produtos.Parameters.ParamByName('categoria').Value := cbCategoria.Text;
    ADOQueryRemover_Produtos.Open;

    cbProduto.ListSource := DataSourceRemover_Produtos;
    cbProduto.ListField := 'nome_produto';
    cbProduto.KeyField := 'id_produto';  // agora usa id_produto

    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;
  end;



  procedure TtelaRemoverEstoque.cbProdutoCloseUp(Sender: TObject);
  begin
    ADOQueryEstoque_Tamanho.Close;
    ADOQueryEstoque_Tamanho.SQL.Text :=
      'SELECT DISTINCT tamanho_produto ' +
      'FROM variacoes_produto ' +
      'WHERE id_produto = :id ORDER BY tamanho_produto';
    ADOQueryEstoque_Tamanho.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryEstoque_Tamanho.Open;

    cbTamanho.ListSource := DataSourceEstoque_Tamanho;
    cbTamanho.ListField := 'tamanho_produto';
    cbTamanho.KeyField := 'tamanho_produto';

    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

  end;



  procedure TtelaRemoverEstoque.cbTamanhoCloseUp(Sender: TObject);
  begin

    ADOQueryRemover_Quantidades.Close;
    ADOQueryRemover_Quantidades.SQL.Text :=
      'SELECT quantidade_produto ' +
      'FROM variacoes_produto ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho AND quantidade_produto > 0';
    ADOQueryRemover_Quantidades.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryRemover_Quantidades.Parameters.ParamByName('tamanho').Value := cbTamanho.Text;
    ADOQueryRemover_Quantidades.Open;

    cbQuantidade.ListSource := DataSourceRemover_Quantidade;
    cbQuantidade.ListField := 'quantidade_produto';
    cbQuantidade.KeyField := 'quantidade_produto';

    cbQuantidade.KeyValue := Null;

  end;



  procedure TtelaRemoverEstoque.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((TelaRemoverEstoque.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((TelaRemoverEstoque.Height - pnlFundo.Height)/2);
  end;



  procedure TtelaRemoverEstoque.FormShow(Sender: TObject);
  begin


     ADOQueryRemover_Categorias.Close;
    ADOQueryRemover_Categorias.SQL.Text :=
      'SELECT DISTINCT p.categoria FROM produtos p ' +
      'JOIN variacoes_produto vp ON vp.id_produto = p.id_produto ' +
      'ORDER BY p.categoria';
    ADOQueryRemover_Categorias.Open;

    cbCategoria.ListSource := DataSourceRemover_Categorias;
    cbCategoria.ListField := 'categoria';
    cbCategoria.KeyField := 'categoria';

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

  end;



  procedure TtelaRemoverEstoque.SpeedbtnCancelarClick(Sender: TObject);
  begin

    cbCategoria.KeyValue := null;
    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.KeyValue := null;

    TelaRemoverEstoque.Close;
  end;



  procedure TtelaRemoverEstoque.SpeedbtnSalvarClick(Sender: TObject);
    begin
    if VarIsNull(cbCategoria.KeyValue) or
       VarIsNull(cbProduto.KeyValue) or
       VarIsNull(cbTamanho.KeyValue) then
    begin
      ShowMessage('Preencha todos os campos antes de remover o item do estoque.');
      Exit;
    end;

    if MessageDlg('Deseja realmente remover esta variação do estoque?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

    DMPrincipal.ADOQueryRemoverEstoque.Close;
    DMPrincipal.ADOQueryRemoverEstoque.SQL.Text :=
      'DELETE FROM variacoes_produto ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho';
    DMPrincipal.ADOQueryRemoverEstoque.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    DMPrincipal.ADOQueryRemoverEstoque.Parameters.ParamByName('tamanho').Value := cbTamanho.Text;
    DMPrincipal.ADOQueryRemoverEstoque.ExecSQL;

    ShowMessage('Variação removida com sucesso!');
    TelaEstoque.ADOQueryGridEstoque.Requery;

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;
  end;



  procedure TtelaRemoverEstoque.speedbtn_fecharClick(Sender: TObject);
  begin
    cbCategoria.KeyValue := null;
    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.KeyValue := null;

    TelaRemoverEstoque.Close;
  end;

end.
