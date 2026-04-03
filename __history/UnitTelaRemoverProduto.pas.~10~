unit UnitTelaRemoverProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TTelaRemoverProduto = class(TForm)
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
    ADOQueryCategoria: TADOQuery;
    DataSourceCategoria: TDataSource;
    ADOQueryProduto: TADOQuery;
    DataSourceProduto: TDataSource;
    ADOQueryTamanho: TADOQuery;
    DataSourceTamanho: TDataSource;
    ADOQueryQuantidade: TADOQuery;
    DataSourceQuantidade: TDataSource;

    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbCategoriaCloseUp(Sender: TObject);
    procedure cbProdutoCloseUp(Sender: TObject);
    procedure cbTamanhoCloseUp(Sender: TObject);
    procedure SpeedbtnCancelarClick(Sender: TObject);
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure SpeedbtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaRemoverProduto: TTelaRemoverProduto;

implementation

{$R *.dfm}

uses uDMPrincipal, UnitTelaProdutos;



  procedure TTelaRemoverProduto.FormActivate(Sender: TObject);
  begin

    pnlFundo.Left := Round((TelaRemoverProduto.Width - pnlFundo.Width) / 2);
    pnlFundo.Top := Round((TelaRemoverProduto.Height - pnlFundo.Height) / 2);

  end;



  procedure TTelaRemoverProduto.FormShow(Sender: TObject);
  begin

    ADOQueryCategoria.Close;
    ADOQueryCategoria.SQL.Text :=
      'SELECT DISTINCT p.categoria ' +
      'FROM produtos p ' +
      'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
      'WHERE v.quantidade_produto > 0 ' +
      'ORDER BY p.categoria';
    ADOQueryCategoria.Open;

    cbCategoria.ListSource := DataSourceCategoria;
    cbCategoria.ListField := 'categoria';
    cbCategoria.KeyField := 'categoria';

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

  end;



  procedure TTelaRemoverProduto.cbCategoriaCloseUp(Sender: TObject);
  begin

    ADOQueryProduto.Close;
    ADOQueryProduto.SQL.Text :=
      'SELECT DISTINCT p.id_produto, p.nome_produto ' +
      'FROM produtos p ' +
      'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
      'WHERE p.categoria = :categoria AND v.quantidade_produto > 0 ' +
      'ORDER BY p.nome_produto';
    ADOQueryProduto.Parameters.ParamByName('categoria').Value := cbCategoria.Text;
    ADOQueryProduto.Open;

    cbProduto.ListSource := DataSourceProduto;
    cbProduto.ListField := 'nome_produto';
    cbProduto.KeyField := 'id_produto'; // usa id_produto como chave

    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

  end;



  procedure TTelaRemoverProduto.cbProdutoCloseUp(Sender: TObject);
  begin

    ADOQueryTamanho.Close;
    ADOQueryTamanho.SQL.Text :=
      'SELECT DISTINCT tamanho_produto ' +
      'FROM variacoes_produto ' +
      'WHERE id_produto = :id AND quantidade_produto > 0 ' +
      'ORDER BY tamanho_produto';
    ADOQueryTamanho.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryTamanho.Open;

    cbTamanho.ListSource := DataSourceTamanho;
    cbTamanho.ListField := 'tamanho_produto';
    cbTamanho.KeyField := 'tamanho_produto';

    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

  end;



  procedure TTelaRemoverProduto.cbTamanhoCloseUp(Sender: TObject);
  begin

    ADOQueryQuantidade.Close;
    ADOQueryQuantidade.SQL.Text :=
      'SELECT quantidade_produto, id_variacao ' +
      'FROM variacoes_produto ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho AND quantidade_produto > 0';
    ADOQueryQuantidade.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryQuantidade.Parameters.ParamByName('tamanho').Value := cbTamanho.Text;
    ADOQueryQuantidade.Open;

    cbQuantidade.ListSource := DataSourceQuantidade;
    cbQuantidade.ListField := 'quantidade_produto';
    cbQuantidade.KeyField := 'id_variacao'; // chave primária da variação

    cbQuantidade.KeyValue := Null;

  end;



  procedure TTelaRemoverProduto.SpeedbtnCancelarClick(Sender: TObject);
  begin

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

    TelaRemoverProduto.Close;

  end;



  procedure TTelaRemoverProduto.SpeedbtnSalvarClick(Sender: TObject);
  begin
    if VarIsNull(cbCategoria.KeyValue) or
       VarIsNull(cbProduto.KeyValue) or
       VarIsNull(cbTamanho.KeyValue) or
       VarIsNull(cbQuantidade.KeyValue) then
    begin
      ShowMessage('Preencha todos os campos antes de remover o produto.');
      Exit;
    end;

    if MessageDlg('Deseja realmente remover esta variação do produto?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

    DMPrincipal.ADOQueryRemoverProduto.Close;
    DMPrincipal.ADOQueryRemoverProduto.SQL.Text :=
      'DELETE FROM variacoes_produto WHERE id_variacao = :id';
    DMPrincipal.ADOQueryRemoverProduto.Parameters.ParamByName('id').Value := cbQuantidade.KeyValue;
    DMPrincipal.ADOQueryRemoverProduto.ExecSQL;

    ShowMessage('Variação removida com sucesso!');
    telaProdutos.ADOQueryGrid.Requery;

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;
  end;



  procedure TTelaRemoverProduto.speedbtn_fecharClick(Sender: TObject);
  begin

    cbCategoria.KeyValue := Null;
    cbProduto.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;

    TelaRemoverProduto.Close;

  end;

END.
