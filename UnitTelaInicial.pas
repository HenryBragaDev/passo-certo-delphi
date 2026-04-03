unit UnitTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TTelaInicial = class(TForm)
    pnlFundo: TPanel;
    lblEscrita2: TLabel;
    imgIcone: TImage;
    lblEscrita: TLabel;
    speedbtn_fechar: TSpeedButton;
    lbl_nomeUsuario: TLabel;
    ADOConnection_login: TADOConnection;
    ADOQuery_login: TADOQuery;
    ADOQuery_loginusuario: TStringField;
    DataSource_login: TDataSource;
    imgSino: TImage;
    pnlLateral: TPanel;
    lblDate: TLabel;
    lblTime: TLabel;
    tmr: TTimer;
    SpdbtnInicio: TSpeedButton;
    pnlInicio: TPanel;
    pnlProdutos: TPanel;
    SpdbtnProdutos: TSpeedButton;
    imgProdutos: TImage;
    pnlVendas: TPanel;
    SpdbtnVendas: TSpeedButton;
    pnlClientes: TPanel;
    SpdbtnClientes: TSpeedButton;
    pnlFornecedores: TPanel;
    SpdbtnFornecedores: TSpeedButton;
    imgFornecedores: TImage;
    imgVendas: TImage;
    imgInicio: TImage;
    imgClientes: TImage;
    pnlEstoque: TPanel;
    spdbtnEstoque: TSpeedButton;
    imgEstoque: TImage;
    pnlFundoCategorias: TPanel;
    ADOConnectionClientes: TADOConnection;
    DBGridClienteInicial: TDBGrid;
    ADOQueryClienteInicial: TADOQuery;
    DataSourceClienteInicial: TDataSource;
    Shape1: TShape;
    DBGridProdutoInicial: TDBGrid;
    Shape2: TShape;
    ADOConnectionProdutosInicial: TADOConnection;
    ADOQueryProdutosInicial: TADOQuery;
    DataSourceProdutosInicial: TDataSource;
    DBGridFornecedoresInicial: TDBGrid;
    Shape3: TShape;
    ADOConnectionFornecedoresInicial: TADOConnection;
    ADOQueryFornecedoresInicial: TADOQuery;
    DataSourceFornecedoresInicial: TDataSource;
    Shape4: TShape;
    DBGridVendaProdutoInicial: TDBGrid;
    ADOConnectionVendasInicial: TADOConnection;
    ADOQueryVendasInicial: TADOQuery;
    DataSourceVendasInicial: TDataSource;
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure SpdbtnProdutosClick(Sender: TObject);
    procedure SpdbtnVendasClick(Sender: TObject);
    procedure SpdbtnClientesClick(Sender: TObject);
    procedure SpdbtnFornecedoresClick(Sender: TObject);
    procedure spdbtnEstoqueClick(Sender: TObject);


  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  TelaInicial: TTelaInicial;

implementation

{$R *.dfm}

  uses UnitGlobais, DateUtils, UnitTelaProdutos, UnitTelaVendaspas, UnitTelaCliente, UnitTelaFornecedore,
  UnitTelaEstoque;


  // Processo para preencher a tela e posicionar a unit
  procedure TTelaInicial.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((TelaInicial.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((TelaInicial.Height - pnlFundo.Height)/2);
  end;


  // Processo para exibição do nome
  procedure TTelaInicial.FormShow(Sender: TObject);
  var

  nomeFormatado: String;
  nomeTitulo: String;
  nomeMinusculo:String;

  //Formatação do nome para exibição
  begin

    nomeFormatado:= AnsiLowerCase(UsuarioLogado);
    nomeMinusculo:= AnsiLowerCase(Copy(UsuarioLogado, 2));
    nomeTitulo:= AnsiUpperCase(Copy(nomeFormatado, 1,1));
    lbl_nomeUsuario.Caption:= 'Olá, '+ nomeTitulo + nomeMinusculo +'!';


    with DBGridClienteINicial.Columns[0] do
    begin
      Title.Caption := 'CLIENTES';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 13;
      Font.Name := 'Poppins'
      ;
    end;

    with DBGridProdutoInicial.Columns[0] do
    begin
      Title.Caption := 'PRODUTOS';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 13;
      Font.Name := 'Poppins'
      ;
    end;

    with DBGridFornecedoresInicial.Columns[0] do
    begin
      Title.Caption := 'FORNECEDORES';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 13;
      Font.Name := 'Poppins'
      ;
    end;

    with DBGridVendaProdutoInicial.Columns[0] do
    begin
      Title.Caption := 'VENDAS';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 14;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 11;
      Font.Name := 'Poppins';
      width := 210;
    end;

     with DBGridVendaProdutoInicial.Columns[1] do
    begin
      Title.Caption := 'TOTAL';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 14;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 13;
      Font.Name := 'Poppins'
      ;
    end;


    ADOQueryClienteInicial.Requery;
    ADOQueryProdutosInicial.Requery;
    ADOQueryFornecedoresInicial.requery;
    ADOQueryVendasInicial.requery;

  end;


  // Processo para abrir a tela de clientes
  procedure TTelaInicial.SpdbtnClientesClick(Sender: TObject);
  begin
    telaCliente.show;
    telaInicial.Hide;
  end;


  // Processo para abrir a tela estoque
  procedure TTelaInicial.spdbtnEstoqueClick(Sender: TObject);
  begin
    telaEstoque.show;
    telaInicial.Hide;
  end;


  // Processo para abrir a tela de fornecedores
  procedure TTelaInicial.SpdbtnFornecedoresClick(Sender: TObject);
  begin
    telaFornecedor.show;
    telaInicial.Hide;
  end;

// Processo para abrir a tela de produtos
  procedure TTelaInicial.SpdbtnProdutosClick(Sender: TObject);
  begin
    TelaProdutos.Show;
    TelaInicial.Hide;
  end;

  // Processo para abrir tela de vendas
  procedure TTelaInicial.SpdbtnVendasClick(Sender: TObject);
  begin
    telaVendas.Show;
    TelaInicial.Hide;

  end;


  // Fechar aplicação
  procedure TTelaInicial.speedbtn_fecharClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

  // Passando o label para datetime
  procedure TTelaInicial.tmrTimer(Sender: TObject);
  var
    DataFormatada:String;
    HoraFormatada:String;

  begin
    //Formatação do dateTime para exibição no label
    DataFormatada:= FormatDateTime('dd "de" mmmm yyyy', date);
    HoraFormatada:= FormatDateTime('hh:nn', time);

    lbltime.Caption:=HoraFormatada;
    lbldate.Caption:=DataFormatada;
  end;

end.
