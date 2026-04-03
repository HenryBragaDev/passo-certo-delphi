unit Unit_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Data.DB, Vcl.Mask, Vcl.DBCtrls, Data.Win.ADODB,
  Vcl.Buttons;

type
  Tform_login = class(TForm)
    pnlFundo: TPanel;
    pnl_lateral: TPanel;
    lbl_bemvindo2: TLabel;
    lbl_autor: TLabel;
    lbl_versao: TLabel;
    img_logo: TImage;
    lbl_bemvindo: TLabel;
    pnl_nomeUsuario: TPanel;
    lbl_nomeUsuario: TLabel;
    pnl_senha: TPanel;
    lbl_senha: TLabel;
    pnl_bordaSenha: TPanel;
    pnl_btn: TPanel;
    speedbtn_login: TSpeedButton;
    speedbtn_fechar: TSpeedButton;
    lbl_conta: TLabel;
    speedbtn_criarConta: TSpeedButton;
    DBedt_nomeUsuario: TEdit;
    Panel1: TPanel;
    DBedt_senha: TEdit;
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure speedbtn_loginClick(Sender: TObject);
    procedure speedbtn_criarContaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  form_login: Tform_login;

implementation

{$R *.dfm}

uses Unit_login_criarConta, UnitTelaInicial, UnitGlobais, uDMPrincipal;

  // Processo de verificação do login (usuario e senha)
  procedure Tform_login.speedbtn_loginClick(Sender: TObject);
  var
  usuario, senha: string;

  begin
  // Pega os dados informados pelo usuário e remove o espaço em branco
  usuario := Trim(DBedt_nomeUsuario.Text);
  senha := Trim(DBedt_senha.Text);

    // Verifica se os campos foram preenchidos
    if (usuario = '') or (senha = '') then
    begin
      ShowMessage('Preencha usuário e senha.');
      Exit;
    end;

    try
      // Verifica o cadastro do usuário
      DMPrincipal.ADOQuery_login.SQL.Clear;
      DMPrincipal.ADOQuery_login.SQL.Add('SELECT * FROM cadusuarios WHERE usuario = :usuario AND senha = :senha');
      DMPrincipal.ADOQuery_login.Parameters.ParamByName('usuario').Value := usuario;
      DMPrincipal.ADOQuery_login.Parameters.ParamByName('senha').Value := senha;
      DMPrincipal.ADOQuery_login.Open;

      // Se a conta bater com o banco de dados abre a tela inicial,
      // caso contrario exibe "Usuário ou senha incorretos"
      if not DMPrincipal.ADOQuery_login.IsEmpty then
      begin
        UsuarioLogado := DMPrincipal.ADOQuery_login.FieldByName('usuario').AsString;
        TelaInicial.Show;
      end
      else
        ShowMessage('Usuário ou senha incorretos');
        DBedt_nomeUsuario.Clear;
        DBedt_senha.Clear;

    // Tratamento de exceções
    except
      on E: Exception do
        ShowMessage('Erro ao efetuar login: ' + E.Message);
    end;


  end;


  // Processo para centralizar a tela
  procedure Tform_login.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((form_login.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((form_login.Height - pnlFundo.Height)/2);
  end;


  // Processo para abrir o página de criar conta
  procedure Tform_login.speedbtn_criarContaClick(Sender: TObject);
  begin
    Form_login_criarConta.show;
  end;


  // Processo para fechar a aplicação
  procedure Tform_login.speedbtn_fecharClick(Sender: TObject);
  begin
    Application.Terminate;
  end;

end.
