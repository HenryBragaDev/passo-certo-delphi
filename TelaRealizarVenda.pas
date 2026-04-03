unit TelaRealizarVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Data.Win.ADODB, Vcl.DBCtrls;

type
  TAdicionarVenda = class(TForm)
    pnlFundo: TPanel;
    pnlborda: TPanel;
    shpCriarProduto: TShape;
    speedbtn_fechar: TSpeedButton;
    pnlItens: TPanel;
    lblNome: TLabel;
    lblQuantidade: TLabel;
    lblCategoria: TLabel;
    lblPrecoTopico: TLabel;
    lblTamanho: TLabel;
    lblTitulo: TLabel;
    shpConfirmar: TShape;
    shpCancelar: TShape;
    SpeedbtnSalvar: TSpeedButton;
    SpeedbtnCancelar: TSpeedButton;
    lblPreco: TLabel;
    shpLinha: TShape;
    lblSubtotal: TLabel;
    lblTotal: TLabel;
    cbProduto: TDBLookupComboBox;
    cbCategoria: TDBLookupComboBox;
    cbTamanho: TDBLookupComboBox;
    cbQuantidade: TComboBox;
    edtSubtotal: TEdit;
    lblTotalCobrado: TLabel;
    procedure SpeedbtnCancelarClick(Sender: TObject);
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedbtnSalvarClick(Sender: TObject);
    procedure cbProdutoClick(Sender: TObject);

    procedure cbQuantidadeChange(Sender: TObject);
    procedure cbQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cbTamanhoClick(Sender: TObject);
    procedure edtSubtotalKeyPress(Sender: TObject; var Key: Char);
    procedure cbCategoriaCloseUp(Sender: TObject);




  private
    { Private declarations }

    procedure AtualizarProdutos(const categoriaFiltro: string = '');
    procedure AtualizarCategorias;

  public
    { Public declarations }
  end;

var
  AdicionarVenda: TAdicionarVenda;

implementation

{$R *.dfm}

  uses UnitTelaProdutos, UnitGlobais, uDMPrincipal, UnitTelaVendaspas;


  procedure TAdicionarVenda.cbCategoriaCloseUp(Sender: TObject);
  begin
    var
    categoriaSelecionada: string;
  begin
    categoriaSelecionada := cbCategoria.Text;

    // Atualiza o dataset produtos com filtro pela categoria selecionada
    DMPrincipal.ADOQueryProdutos.Close;
    DMPrincipal.ADOQueryProdutos.SQL.Text :=
      'SELECT DISTINCT p.id_produto, p.nome_produto ' +
      'FROM produtos p ' +
      'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
      'WHERE p.categoria = :categoria ' +
      'ORDER BY p.nome_produto';
    DMPrincipal.ADOQueryProdutos.Parameters.ParamByName('categoria').Value := categoriaSelecionada;
    DMPrincipal.ADOQueryProdutos.Open;

    cbProduto.ListSource := DMPrincipal.DataSourceProdutos;
    cbProduto.ListField := 'nome_produto';
    cbProduto.KeyField := 'id_produto';

    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
  end;
  end;


  // Processo para exibir preço unitário e mostrar apenas o tamanho do produto selecionado
  procedure TAdicionarVenda.cbProdutoClick(Sender: TObject);
  var
  idProdutoSelecionado: Integer;
  begin
    if not VarIsNull(cbProduto.KeyValue) then
    begin
      idProdutoSelecionado := cbProduto.KeyValue;

      // Atualiza a lista de tamanhos para o produto selecionado
      DMPrincipal.ADOQueryTamanho.Close;
      DMPrincipal.ADOQueryTamanho.SQL.Text :=
        'SELECT DISTINCT tamanho_produto FROM variacoes_produto ' +
        'WHERE id_produto = :id ORDER BY tamanho_produto';
      DMPrincipal.ADOQueryTamanho.Parameters.ParamByName('id').Value := idProdutoSelecionado;
      DMPrincipal.ADOQueryTamanho.Open;

      cbTamanho.ListSource := DMPrincipal.DataSourceTamanho;
      cbTamanho.ListField := 'tamanho_produto';
      cbTamanho.KeyField := 'tamanho_produto';

      cbQuantidade.Items.Clear;
      lblTotal.Caption := 'R$ 0,00';
      lblPreco.Caption := 'R$ 0,00';
    end;
  end;


  // Processo para exibir o valor total da venda
  procedure TAdicionarVenda.cbQuantidadeChange(Sender: TObject);
  var
  qtd: Integer;
  preco: Double;
  begin
    if TryStrToInt(cbQuantidade.Text, qtd) and (not DMPrincipal.ADOQueryQuantidade.IsEmpty) then
    begin
      preco := DMPrincipal.ADOQueryQuantidade.FieldByName('preco').AsFloat;
      lblTotal.Caption := FormatCurr('R$ #,##0.00', preco * qtd);
    end
    else
      lblTotal.Caption := 'R$ 0,00';
  end;


  // Processo para possibilitar inserir apenas números no campo quantidade
  procedure TAdicionarVenda.cbQuantidadeKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['0'..'9', #8]) then
    Key := #0;
  end;


  // Processo para relacionar o tamanho com a quantidade disponivel do produto
  procedure TAdicionarVenda.cbTamanhoClick(Sender: TObject);
  var
  idProdutoSelecionado: Integer;
  tamanhoSelecionado: Variant;
  preco: Double;
  quantidadeDisponivel, i: Integer;
  begin
    if VarIsNull(cbProduto.KeyValue) or VarIsNull(cbTamanho.KeyValue) then
      Exit;

    idProdutoSelecionado := cbProduto.KeyValue;
    tamanhoSelecionado := cbTamanho.KeyValue;

    // Busca preço e quantidade da variação
    DMPrincipal.ADOQueryQuantidade.Close;
    DMPrincipal.ADOQueryQuantidade.SQL.Text :=
      'SELECT preco, quantidade_produto FROM variacoes_produto ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho';
    DMPrincipal.ADOQueryQuantidade.Parameters.ParamByName('id').Value := idProdutoSelecionado;
    DMPrincipal.ADOQueryQuantidade.Parameters.ParamByName('tamanho').Value := tamanhoSelecionado;
    DMPrincipal.ADOQueryQuantidade.Open;

    if not DMPrincipal.ADOQueryQuantidade.IsEmpty then
    begin
      preco := DMPrincipal.ADOQueryQuantidade.FieldByName('preco').AsFloat;
      quantidadeDisponivel := DMPrincipal.ADOQueryQuantidade.FieldByName('quantidade_produto').AsInteger;

      lblPreco.Caption := FormatCurr('R$ #,##0.00', preco);

      cbQuantidade.Items.Clear;
      for i := 1 to quantidadeDisponivel do
        cbQuantidade.Items.Add(IntToStr(i));

      if quantidadeDisponivel > 0 then
        cbQuantidade.ItemIndex := 0
      else
        cbQuantidade.ItemIndex := -1;

      lblTotal.Caption := FormatCurr('R$ #,##0.00', preco);
    end
    else
    begin
      lblPreco.Caption := 'R$ 0,00';
      cbQuantidade.Items.Clear;
      lblTotal.Caption := 'R$ 0,00';
    end;
  end;


  // Permitir apenas valores numéricos
  procedure TAdicionarVenda.edtSubtotalKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['0'..'9', ',', '.', #8]) then
    Key := #0;
  end;



  // Processo para centralizar tela
  procedure TAdicionarVenda.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((AdicionarVenda.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((AdicionarVenda.Height - pnlFundo.Height)/2);
  end;


  // Processo para ordenar por ordem alfabética
  procedure TAdicionarVenda.FormCreate(Sender: TObject);
  begin

    AtualizarCategorias;
    AtualizarProdutos;

  end;

  // Processo para atualizar as categorias cadastradas
  procedure TAdicionarVenda.AtualizarCategorias;
  begin
    DMPrincipal.ADOQueryCategorias.Close;
    DMPrincipal.ADOQueryCategorias.SQL.Text :=
      'SELECT DISTINCT p.categoria ' +
      'FROM produtos p ' +
      'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
      'WHERE v.quantidade_produto > 0 ' +
      'ORDER BY p.categoria';
    DMPrincipal.ADOQueryCategorias.Open;

    cbCategoria.ListSource := DMPrincipal.DataSourceCategorias;
    cbCategoria.ListField := 'categoria';
    cbCategoria.KeyField := 'categoria';


  end;


  // Processo para atualizar os produtos
  procedure TAdicionarVenda.AtualizarProdutos(const categoriaFiltro: string = '');
  begin
    DMPrincipal.ADOQueryProdutos.Close;

    if categoriaFiltro = '' then
      DMPrincipal.ADOQueryProdutos.SQL.Text :=
        'SELECT DISTINCT p.id_produto, p.nome_produto ' +
        'FROM produtos p ' +
        'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
        'ORDER BY p.nome_produto'
    else
    begin
      DMPrincipal.ADOQueryProdutos.SQL.Text :=
        'SELECT DISTINCT p.id_produto, p.nome_produto ' +
        'FROM produtos p ' +
        'JOIN variacoes_produto v ON v.id_produto = p.id_produto ' +
        'WHERE p.categoria = :categoria ' +
        'ORDER BY p.nome_produto';
      DMPrincipal.ADOQueryProdutos.Parameters.ParamByName('categoria').Value := categoriaFiltro;
    end;

    DMPrincipal.ADOQueryProdutos.Open;

    cbProduto.ListSource := DMPrincipal.DataSourceProdutos;
    cbProduto.ListField := 'nome_produto';
    cbProduto.KeyField := 'id_produto';

    lblPreco.Caption := 'R$ 0,00';
    lblTotal.Caption := 'R$ 0,00';
    cbQuantidade.Clear;
  end;


  // Processo para exibição do label preço e total
  procedure TAdicionarVenda.FormShow(Sender: TObject);
  begin

    lblPreco.Caption := 'R$ 0,00';
    lblTotal.Caption := 'R$ 0,00';

    AtualizarCategorias;
    AtualizarProdutos;

  end;

  // Fechar tela de adicionar vendas
  procedure TAdicionarVenda.SpeedbtnCancelarClick(Sender: TObject);
  begin

    cbCategoria.KeyValue := null;
    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.Clear;
    lblPreco.Caption := 'R$ 0,00';
    lblTotal.Caption := 'R$ 0,00';
    edtSubtotal.Clear;

    AdicionarVenda.Close;

  end;


  // Processo para contabilizar a venda no banco de dados
  procedure TAdicionarVenda.SpeedbtnSalvarClick(Sender: TObject);
  var
  idProduto, quantidadeVendida, quantidadeAtual, tamanhoProdutoVendido: Integer;
  precoUnitario, total, valorCobrado: Double;
  nomeProdutoVendido: String;
  begin
    if VarIsNull(cbProduto.KeyValue) or VarIsNull(cbTamanho.KeyValue) or (cbQuantidade.Text = '') then
    begin
      ShowMessage('Preencha todos os campos antes de salvar a venda.');
      Exit;
    end;

    idProduto := cbProduto.KeyValue;
    tamanhoProdutoVendido := cbTamanho.KeyValue;
    quantidadeVendida := StrToInt(cbQuantidade.Text);

    // Busca variação
    DMPrincipal.ADOQueryQuantidade.Close;
    DMPrincipal.ADOQueryQuantidade.SQL.Text :=
      'SELECT preco, quantidade_produto FROM variacoes_produto ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho';
    DMPrincipal.ADOQueryQuantidade.Parameters.ParamByName('id').Value := idProduto;
    DMPrincipal.ADOQueryQuantidade.Parameters.ParamByName('tamanho').Value := tamanhoProdutoVendido;
    DMPrincipal.ADOQueryQuantidade.Open;

    if DMPrincipal.ADOQueryQuantidade.IsEmpty then
    begin
      ShowMessage('Variação não encontrada!');
      Exit;
    end;

    precoUnitario := DMPrincipal.ADOQueryQuantidade.FieldByName('preco').AsFloat;
    quantidadeAtual := DMPrincipal.ADOQueryQuantidade.FieldByName('quantidade_produto').AsInteger;

    if quantidadeVendida > quantidadeAtual then
    begin
      ShowMessage('Estoque insuficiente para essa venda!');
      Exit;
    end;

    total := precoUnitario * quantidadeVendida;
    valorCobrado := StrToFloat(StringReplace(edtSubtotal.Text, '.', '', [rfReplaceAll]));
    valorCobrado := StrToFloat(FormatFloat('0.00', valorCobrado));

    nomeProdutoVendido := cbProduto.Text;

    DMPrincipal.ADOConnectionGeral.BeginTrans;
    try
      // Inserir venda
      DMPrincipal.ADOQueryVendas.Close;
      DMPrincipal.ADOQueryVendas.SQL.Text :=
        'INSERT INTO vendas (id_produto, nome_produto_vendido, quantidade_vendida, preco_unitario, tamanho_produto_vendido, total, data_venda) ' +
        'VALUES (:id_produto, :nome_produto_vendido, :qtd, :preco, :tamanho, :total, CURRENT_TIMESTAMP)';
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('id_produto').Value := idProduto;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('nome_produto_vendido').Value := nomeProdutoVendido;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('qtd').Value := quantidadeVendida;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('preco').Value := precoUnitario;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('tamanho').Value := tamanhoProdutoVendido;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('total').Value := valorCobrado;
      DMPrincipal.ADOQueryVendas.ExecSQL;

      // Atualizar estoque da variação
      DMPrincipal.ADOQueryVendas.Close;
      DMPrincipal.ADOQueryVendas.SQL.Text :=
        'UPDATE variacoes_produto SET quantidade_produto = quantidade_produto - :qtd ' +
        'WHERE id_produto = :id AND tamanho_produto = :tamanho';
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('qtd').Value := quantidadeVendida;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('id').Value := idProduto;
      DMPrincipal.ADOQueryVendas.Parameters.ParamByName('tamanho').Value := tamanhoProdutoVendido;
      DMPrincipal.ADOQueryVendas.ExecSQL;

      DMPrincipal.ADOConnectionGeral.CommitTrans;

      ShowMessage('Venda registrada com sucesso!');
      AtualizarProdutos;

      telaVendas.ADOQueryGridVendas.Requery;

      cbCategoria.KeyValue := null;
      cbProduto.KeyValue := null;
      cbTamanho.KeyValue := null;
      cbQuantidade.Clear;
      lblPreco.Caption := 'R$ 0,00';
      lblTotal.Caption := 'R$ 0,00';
      edtSubtotal.Clear;

    except
      on E: Exception do
      begin
        DMPrincipal.ADOConnectionGeral.RollbackTrans;
        ShowMessage('Erro ao registrar a venda: ' + E.Message);
      end;
    end;
  end;


  // Fechar tela de adicionar vendas
  procedure TAdicionarVenda.speedbtn_fecharClick(Sender: TObject);
  begin

    cbCategoria.KeyValue := null;
    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.Clear;
    lblPreco.Caption := 'R$ 0,00';
    lblTotal.Caption := 'R$ 0,00';
    edtSubtotal.Clear;


    AdicionarVenda.Close;

  end;

end.
