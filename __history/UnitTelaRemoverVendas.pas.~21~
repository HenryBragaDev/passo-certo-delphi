unit UnitTelaRemoverVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TTelaRemoverVendas = class(TForm)
    pnlFundo: TPanel;
    pnlborda: TPanel;
    shpCriarProduto: TShape;
    speedbtn_fechar: TSpeedButton;
    lblTitulo: TLabel;
    pnlItens: TPanel;
    lblQuantidade: TLabel;
    lblTamanho: TLabel;
    lblDataVenda: TLabel;
    shpSalvar: TShape;
    shpCancelar: TShape;
    SpeedbtnSalvar: TSpeedButton;
    SpeedbtnCancelar: TSpeedButton;
    shpCor: TShape;
    lblCategoria: TLabel;


    cbProduto: TDBLookupComboBox;
    cbQuantidade: TDBLookupComboBox;
    cbTamanho: TDBLookupComboBox;
    cbDataVenda: TDBLookupComboBox;


    ADOQueryRemoverVenda_Tamanho: TADOQuery;
    DataSourceRemoverVenda_Tamanho: TDataSource;

    ADOQueryRemoverVenda_Quantidade: TADOQuery;
    DataSourceRemoverVenda_Quantidade: TDataSource;

    ADOQueryRemoverVenda_Data: TADOQuery;
    DataSourceRemoverVenda_Data: TDataSource;

    procedure speedbtn_fecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedbtnCancelarClick(Sender: TObject);

    procedure cbProdutoCloseUp(Sender: TObject);
    procedure cbTamanhoCloseUp(Sender: TObject);
    procedure cbQuantidadeCloseUp(Sender: TObject);
    procedure SpeedbtnSalvarClick(Sender: TObject);


  private
    function GetIdVenda: Integer;
    function GetVendaInfo: TDataSet;

  public
  end;

var
  TelaRemoverVendas: TTelaRemoverVendas;

implementation

{$R *.dfm}

uses
  uDMPrincipal, UnitTelaVendaspas;

  function TTelaRemoverVendas.GetIdVenda: Integer;
  begin
    Result := 0;

    with DMPrincipal.ADOQueryRemoverVenda_Busca do
    begin
      Close;
      SQL.Text :=
        'SELECT id_venda FROM vendas ' +
        'WHERE id_produto = :id AND tamanho_produto_vendido = :t AND quantidade_vendida = :q AND data_venda = :d';
      Parameters.ParamByName('id').Value := cbProduto.KeyValue;
      Parameters.ParamByName('t').Value := cbTamanho.KeyValue;
      Parameters.ParamByName('q').Value := cbQuantidade.KeyValue;
      Parameters.ParamByName('d').Value := cbDataVenda.KeyValue;
      Open;

      if not IsEmpty then
        Result := FieldByName('id_venda').AsInteger;
    end;
  end;

  function TTelaRemoverVendas.GetVendaInfo: TDataSet;
  begin
    DMPrincipal.ADOQueryRemoverVenda_Busca.Close;
    DMPrincipal.ADOQueryRemoverVenda_Busca.SQL.Text :=
      'SELECT id_produto, tamanho_produto_vendido, quantidade_vendida ' +
      'FROM vendas ' +
      'WHERE id_venda = :id';
    DMPrincipal.ADOQueryRemoverVenda_Busca.Parameters.ParamByName('id').Value := GetIdVenda;
    DMPrincipal.ADOQueryRemoverVenda_Busca.Open;

    Result := DMPrincipal.ADOQueryRemoverVenda_Busca;
  end;


  procedure TTelaRemoverVendas.FormShow(Sender: TObject);
  begin
    // Carrega apenas produtos que possuem vendas com quantidade > 0
    DMPrincipal.ADOQueryRemoverVenda_Produtos.Close;
    DMPrincipal.ADOQueryRemoverVenda_Produtos.SQL.Text :=
      'SELECT DISTINCT id_produto, nome_produto_vendido ' +
      'FROM vendas ' +
      'WHERE quantidade_vendida > 0 ' +
      'ORDER BY nome_produto_vendido';
    DMPrincipal.ADOQueryRemoverVenda_Produtos.Open;

    cbProduto.ListSource := DMPrincipal.DataSourceRemoverVenda_Produtos;
    cbProduto.ListField  := 'nome_produto_vendido';
    cbProduto.KeyField   := 'id_produto'; // usa id_produto como chave

    // Limpa os outros lookups
    cbQuantidade.KeyValue := Null;
    cbTamanho.KeyValue := Null;
    cbDataVenda.KeyValue := Null;
  end;



  procedure TTelaRemoverVendas.cbProdutoCloseUp(Sender: TObject);
  begin
    // Carrega apenas tamanhos que possuem vendas com quantidade > 0
    ADOQueryRemoverVenda_Tamanho.Close;
    ADOQueryRemoverVenda_Tamanho.SQL.Text :=
      'SELECT DISTINCT tamanho_produto_vendido ' +
      'FROM vendas ' +
      'WHERE id_produto = :id AND quantidade_vendida > 0 ' +
      'ORDER BY tamanho_produto_vendido';
    ADOQueryRemoverVenda_Tamanho.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryRemoverVenda_Tamanho.Open;

    cbTamanho.ListSource := DataSourceRemoverVenda_Tamanho;
    cbTamanho.ListField  := 'tamanho_produto_vendido';
    cbTamanho.KeyField   := 'tamanho_produto_vendido';

    ADOQueryRemoverVenda_Quantidade.Close;
    ADOQueryRemoverVenda_Data.Close;

    cbTamanho.KeyValue := Null;
    cbQuantidade.KeyValue := Null;
    cbDataVenda.KeyValue := Null;
  end;



  procedure TTelaRemoverVendas.cbTamanhoCloseUp(Sender: TObject);
  begin
    ADOQueryRemoverVenda_Quantidade.Close;
    ADOQueryRemoverVenda_Quantidade.SQL.Text :=
      'SELECT DISTINCT quantidade_vendida FROM vendas ' +
      'WHERE id_produto = :id AND tamanho_produto_vendido = :t ORDER BY quantidade_vendida';
    ADOQueryRemoverVenda_Quantidade.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryRemoverVenda_Quantidade.Parameters.ParamByName('t').Value := cbTamanho.KeyValue;
    ADOQueryRemoverVenda_Quantidade.Open;

    cbQuantidade.ListSource := DataSourceRemoverVenda_Quantidade;
    cbQuantidade.ListField  := 'quantidade_vendida';
    cbQuantidade.KeyField   := 'quantidade_vendida';

    ADOQueryRemoverVenda_Data.Close;
    cbQuantidade.KeyValue := Null;
    cbDataVenda.KeyValue := Null;
  end;



  procedure TTelaRemoverVendas.cbQuantidadeCloseUp(Sender: TObject);
  begin
    if VarIsNull(cbProduto.KeyValue) or
       VarIsNull(cbTamanho.KeyValue) or
       VarIsNull(cbQuantidade.KeyValue) then
    begin
      ShowMessage('Selecione produto, tamanho e quantidade antes de buscar a data.');
      Exit;
    end;

    ADOQueryRemoverVenda_Data.Close;
    ADOQueryRemoverVenda_Data.SQL.Text :=
      'SELECT DISTINCT data_venda, ' +
      'TO_CHAR(data_venda, ''YYYY-MM-DD HH24:MI:SS'') AS data_venda_str ' +
      'FROM vendas ' +
      'WHERE id_produto = :id AND tamanho_produto_vendido = :t AND quantidade_vendida = :q ' +
      'ORDER BY data_venda';

    ADOQueryRemoverVenda_Data.Parameters.ParamByName('id').Value := cbProduto.KeyValue;
    ADOQueryRemoverVenda_Data.Parameters.ParamByName('t').Value := cbTamanho.KeyValue;
    ADOQueryRemoverVenda_Data.Parameters.ParamByName('q').Value := cbQuantidade.KeyValue;

    ADOQueryRemoverVenda_Data.Open;

    cbDataVenda.ListSource := DataSourceRemoverVenda_Data;
    cbDataVenda.KeyField   := 'data_venda';      // timestamp original
    cbDataVenda.ListField  := 'data_venda_str';  // string formatada
end;



  procedure TTelaRemoverVendas.SpeedbtnCancelarClick(Sender: TObject);
  begin

    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.KeyValue := null;
    cbDataVenda.KeyValue := null;


    TelaRemoverVendas.Close;
  end;



  procedure TTelaRemoverVendas.SpeedbtnSalvarClick(Sender: TObject);
  var
  idVenda, idProduto, tamanho, quantidade: Integer;
begin
  if VarIsNull(cbProduto.KeyValue) or
     VarIsNull(cbTamanho.KeyValue) or
     VarIsNull(cbQuantidade.KeyValue) or
     VarIsNull(cbDataVenda.KeyValue) then
  begin
    ShowMessage('Preencha todos os campos antes de remover a venda.');
    Exit;
  end;

  idVenda := GetIdVenda;

  if idVenda = 0 then
  begin
    ShowMessage('Venda não encontrada! Verifique os dados selecionados.');
    Exit;
  end;

  if MessageDlg('Deseja realmente remover esta venda?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  // Recupera os dados da venda antes de excluir
  with DMPrincipal.ADOQueryRemoverVenda_Busca do
  begin
    Close;
    SQL.Text :=
      'SELECT id_produto, tamanho_produto_vendido, quantidade_vendida ' +
      'FROM vendas WHERE id_venda = :id';
    Parameters.ParamByName('id').Value := idVenda;
    Open;

    idProduto := FieldByName('id_produto').AsInteger;
    tamanho := FieldByName('tamanho_produto_vendido').AsInteger;
    quantidade := FieldByName('quantidade_vendida').AsInteger;
  end;

  // Atualiza o estoque
  with DMPrincipal.ADOQueryRemoverVenda_UpdateEstoque do
  begin
    Close;
    SQL.Text :=
      'UPDATE variacoes_produto ' +
      'SET quantidade_produto = quantidade_produto + :qtd ' +
      'WHERE id_produto = :id AND tamanho_produto = :tamanho';
    Parameters.ParamByName('qtd').Value := quantidade;
    Parameters.ParamByName('id').Value := idProduto;
    Parameters.ParamByName('tamanho').Value := tamanho;
    ExecSQL;
  end;

  // Exclui a venda
  with DMPrincipal.ADOQueryRemoverVenda_Delete do
  begin
    Close;
    SQL.Text := 'DELETE FROM vendas WHERE id_venda = :id';
    Parameters.ParamByName('id').Value := idVenda;
    ExecSQL;
  end;

  ShowMessage('Venda removida e estoque restaurado com sucesso!');

  DMPrincipal.ADOQueryRemoverVenda_Produtos.Close;
  DMPrincipal.ADOQueryRemoverVenda_Produtos.Open;

  telaVendas.ADOQueryGridVendas.Requery;

  cbProduto.KeyValue := Null;
  cbTamanho.KeyValue := Null;
  cbQuantidade.KeyValue := Null;
  cbDataVenda.KeyValue := Null;

  Close;
end;



  procedure TTelaRemoverVendas.speedbtn_fecharClick(Sender: TObject);
  begin

    cbProduto.KeyValue := null;
    cbTamanho.KeyValue := null;
    cbQuantidade.KeyValue := null;
    cbDataVenda.KeyValue := null;

    TelaRemoverVendas.Close;
  end;


  procedure TTelaRemoverVendas.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round((Width - pnlFundo.Width) / 2);
    pnlFundo.Top  := Round((Height - pnlFundo.Height) / 2);
  end;


  end.
