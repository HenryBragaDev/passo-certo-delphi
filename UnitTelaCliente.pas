unit UnitTelaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB;

type
  TTelaCliente = class(TForm)
    pnlFundo: TPanel;
    lblEscrita2: TLabel;
    imgIcone: TImage;
    lblEscrita: TLabel;
    speedbtn_fechar: TSpeedButton;
    lbl_nomeUsuario: TLabel;
    imgSino: TImage;
    lblDate: TLabel;
    lblTime: TLabel;
    pnlLateral: TPanel;
    pnlInicio: TPanel;
    SpdbtnInicio: TSpeedButton;
    imgInicio: TImage;
    pnlProdutos: TPanel;
    SpdbtnProdutos: TSpeedButton;
    imgProdutos: TImage;
    pnlVendas: TPanel;
    SpdbtnVendas: TSpeedButton;
    imgVendas: TImage;
    pnlClientes: TPanel;
    SpdbtnClientes: TSpeedButton;
    pnlFornecedores: TPanel;
    SpdbtnFornecedores: TSpeedButton;
    imgFornecedores: TImage;
    pnlFundoCategorias: TPanel;
    lblTitulo: TLabel;
    shpCriarProduto: TShape;
    SpdbtnCriarCliente: TSpeedButton;
    tmr: TTimer;
    imgClientes: TImage;
    pnlEstoque: TPanel;
    spdbtnEstoque: TSpeedButton;
    imgEstoque: TImage;
    shpRemover: TShape;
    SpeedtbnRemoverCliente: TSpeedButton;
    ADOConnectionGridClientes: TADOConnection;
    ADOQueryGridClientes: TADOQuery;
    DBGridClientes: TDBGrid;
    DataSourceGridClientes: TDataSource;
    procedure SpdbtnInicioClick(Sender: TObject);
    procedure SpdbtnProdutosClick(Sender: TObject);
    procedure SpdbtnVendasClick(Sender: TObject);
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpdbtnCriarClienteClick(Sender: TObject);
    procedure SpdbtnFornecedoresClick(Sender: TObject);
    procedure spdbtnEstoqueClick(Sender: TObject);
    procedure SpdbtnRemoverClienteClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaCliente: TTelaCliente;

implementation

{$R *.dfm}

  uses UnitTelaFornecedore, UnitTelaInicial, UnitTelaProdutos, UnitTelaVendaspas, UnitGlobais, UnitCriarCliente,
  UnitTelaEstoque, UnitRemoverCliente;


  // Processo para centralizar a tela de clientes
  procedure TTelaCliente.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((TelaCliente.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((TelaCliente.Height- pnlFundo.Height)/2);
  end;


  //Processo para exibir o usuário logado
  procedure TTelaCliente.FormShow(Sender: TObject);
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

    with DBGridCLientes.Columns[0] do
    begin
      Title.Caption := 'ID';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taCenter;
      Alignment := taCenter;
      Font.Size := 12;
      width := 100;
    end;

    with DBGridCLientes.Columns[1] do
    begin
      Title.Caption := 'CLIENTE';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 12;
      width := 160;
    end;

    with DBGridCLientes.Columns[2] do
    begin
      Title.Caption := 'TELEFONE';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 12;
      width := 160;

    end;

    with DBGridCLientes.Columns[3] do
    begin
      Title.Caption := 'EMAIL';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      Title.Alignment := taLeftJustify;
      Alignment := taLeftJustify;
      Font.Size := 12;
      width := 190;
    end;

    with DBGridCLientes.Columns[4] do
    begin
      Title.Caption := 'DATA';
      Title.Font.Style := [fsBold];
      Title.Font.Size := 15;
      //Title.Alignment := taLeftJustify;
      //Alignment := taLeftJustify;
      Font.Size := 10;

    end;

  end;

  // Processo para abrir a tela de inicial
  procedure TTelaCliente.SpdbtnInicioClick(Sender: TObject);
  begin
    telainicial.show;
    telaCliente.Hide;
  end;


  // Processo para abri a tela de produtos
  procedure TTelaCliente.SpdbtnProdutosClick(Sender: TObject);
  begin
    telaProdutos.show;
    telaCliente.hide;
  end;


  procedure TTelaCliente.SpdbtnRemoverClienteClick(Sender: TObject);
  begin
    TelaRemoverCliente.show;
  end;

  // Processo abrir tela para cadastrar cliente
  procedure TTelaCliente.SpdbtnCriarClienteClick(Sender: TObject);
  begin
    TelaCadastroCliente.show;
  end;



  procedure TTelaCliente.spdbtnEstoqueClick(Sender: TObject);
  begin
    TelaEstoque.show;
    TelaCliente.Hide;
  end;



  procedure TTelaCliente.SpdbtnFornecedoresClick(Sender: TObject);
  begin
    TelaFornecedor.show;
    TelaCliente.Hide;
  end;


  // Processo para abrin a tela de vendas
  procedure TTelaCliente.SpdbtnVendasClick(Sender: TObject);
  begin
    telaVendas.show;
    telaCliente.hide;
  end;


  // Processo para fechar a aplicação
  procedure TTelaCliente.speedbtn_fecharClick(Sender: TObject);
  begin
    Application.Terminate;
  end;


  // Processo para exibição da data e hora formatada
  procedure TTelaCliente.tmrTimer(Sender: TObject);
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
