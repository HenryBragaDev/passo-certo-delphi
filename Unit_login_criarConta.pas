unit Unit_login_criarConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons;

type
  TForm_login_criarConta = class(TForm)
    pnl_fundo: TPanel;
    titleCadastro: TLabel;
    pnl_nomeUsuario_criarConta: TPanel;
    lbl_nomeUsuario_criarConta: TLabel;
    pnl_bordaUsuario_criarConta: TPanel;
    pnl_lateralEsquerdo: TPanel;
    pnl_lateralDireito: TPanel;
    pnl_senha_criarConta: TPanel;
    pnl_borda_senha_criarConta: TPanel;
    lbl_senha_criarConta: TLabel;
    pnl_speedbtn_criarConta: TPanel;
    btn_criarConta: TSpeedButton;
    btn_login_voltar: TSpeedButton;
    speedbtn_fechar: TSpeedButton;
    DBedt_nomeUsuario_criarConta: TEdit;
    DBedt_login_criarConta: TEdit;
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure btn_login_voltarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_criarContaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_login_criarConta: TForm_login_criarConta;

implementation

{$R *.dfm}

  uses Unit_login,uDMPrincipal;


  // Processo de verificação do login (usuario e senha)
  procedure TForm_login_criarConta.btn_criarContaClick(Sender: TObject);
  var
  usuario, senha: string;

  begin

  // Pega os dados informados pelo usuário e remove o espaço em branco
  usuario := Trim(DBedt_nomeUsuario_criarConta.Text);
  senha := Trim(DBedt_login_criarConta.Text);

    // Verifica se os campos estão vazios
    if (usuario = '') or (senha = '') then
    begin
      ShowMessage('Preencha todos os campos.');
      Exit;
    end;

    try

      // Insere o novo usuário
      DMPrincipal.ADOQuery_login.SQL.Clear;
      DMPrincipal.ADOQuery_login.SQL.Add('INSERT INTO cadusuarios (usuario, senha) VALUES (:usuario, :senha)');
      DMPrincipal.ADOQuery_login.Parameters.ParamByName('usuario').Value := usuario;
      DMPrincipal.ADOQuery_login.Parameters.ParamByName('senha').Value := senha;
      DMPrincipal.ADOQuery_login.ExecSQL;

      ShowMessage('Conta criada com sucesso!');
      DBedt_nomeUsuario_criarConta.Clear;
      DBedt_login_criarConta.Clear;

    // Tratamento de exceções caso haja algum erro
    except
      on E: Exception do
      begin
        // Verifica se o erro é de violação de UNIQUE (Usuarios duplicados)
        if Pos('duplicate key value violates unique constraint', LowerCase(E.Message)) > 0 then
          ShowMessage('Este nome de usuário já está em uso. Escolha outro.')
        else
          ShowMessage('Erro ao criar conta: ' + E.Message);
      end;

    end;

    form_login.DBedt_nomeUsuario.Clear;
    form_login.DBedt_senha.Clear;

    form_login_criarConta.Close;

  end;


  // Processo para voltar no form login
  procedure TForm_login_criarConta.btn_login_voltarClick(Sender: TObject);
  begin

    form_login.DBedt_nomeUsuario.Clear;
    form_login.DBedt_senha.Clear;

    form_login_criarConta.Close;
  end;


  // Processo para centralizar a página
  procedure TForm_login_criarConta.FormActivate(Sender: TObject);
  begin
    pnl_fundo.Left := Round ((form_login_criarConta.Width - pnl_fundo.Width)/2);
    pnl_fundo.Top := Round ((form_login_criarConta.Height - pnl_fundo.Height)/2);
  end;


  // Processo para fechar a aplicação
  procedure TForm_login_criarConta.speedbtn_fecharClick(Sender: TObject);
  begin
    form_login_criarConta.close;
  end;

end.
