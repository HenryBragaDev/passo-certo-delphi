unit UnitCriarCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Mask, Vcl.DBCtrls, Data.Win.ADODB, System.Character;

type
  TTelaCadastroCliente = class(TForm)
    pnlFundo: TPanel;
    pnlborda: TPanel;
    shpCriarProduto: TShape;
    speedbtn_fechar: TSpeedButton;
    lblTitulo: TLabel;
    pnlItens: TPanel;
    lblNome: TLabel;
    lbltelefone: TLabel;
    lblPreco: TLabel;
    lblEmail: TLabel;
    shpSalvar: TShape;
    shpCancelar: TShape;
    SpeedbtnSalvar: TSpeedButton;
    SpeedbtnCancelar: TSpeedButton;
    shpCor: TShape;
    ADOConnection_cliente: TADOConnection;
    ADOQueryCliente: TADOQuery;
    ADOQueryClienteid_cliente: TAutoIncField;
    ADOQueryClientenome_cliente: TStringField;
    ADOQueryClientetelefone_cliente: TStringField;
    ADOQueryClienteemail: TStringField;
    ADOQueryClientedataCadastro: TDateField;
    DataSourceCliente: TDataSource;
    ADOQueryVerificaEmail: TADOQuery;
    DBedtNomeCliente: TEdit;
    DBedtEmail: TEdit;
    DBedtTelefone: TEdit;
    DBedtDate: TEdit;
    tmr: TTimer;
    procedure SpeedbtnCancelarClick(Sender: TObject);
    procedure speedbtn_fecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedbtnSalvarClick(Sender: TObject);
    procedure DBedtNomeClienteKeyPress(Sender: TObject; var Key: Char);
    procedure DBedtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure DBedtDateKeyPress(Sender: TObject; var Key: Char);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaCadastroCliente: TTelaCadastroCliente;

implementation

{$R *.dfm}

uses UnitTelaCliente;


  // Processo para validação de campos numéricos
  procedure TTelaCadastroCliente.DBedtDateKeyPress(Sender: TObject;
  var Key: Char);
  begin
   if not (Key in ['0'..'9', #8, '/']) then
    Key := #0;
  end;


  // Processo para validação de campos string
  procedure TTelaCadastroCliente.DBedtNomeClienteKeyPress(Sender: TObject;
  var Key: Char);
  begin
    if not (TCharacter.IsLetter(Key) or (Key = ' ') or (Key = #8)) then
      Key := #0;
  end;


  // Processo para centralizar a tela de clientes
  procedure TTelaCadastroCliente.DBedtTelefoneKeyPress(Sender: TObject;
  var Key: Char);
  begin
     if not (Key in ['0'..'9', #8, '/', '-']) then
    Key := #0;
  end;


  // Processo para centralizar a tela
  procedure TTelaCadastroCliente.FormActivate(Sender: TObject);
  begin
    pnlFundo.Left := Round ((TelaCadastroCliente.Width - pnlFundo.Width)/2);
    pnlFundo.Top := Round ((TelaCadastroCliente.Height- pnlFundo.Height)/2);
  end;


  // Processo para limpar os campos e fechar a tela
  procedure TTelaCadastroCliente.SpeedbtnCancelarClick(Sender: TObject);
  begin

    DBedtNomeCliente.Clear;
    DBedtEmail.Clear;
    DBedtTelefone.Clear;
    DBedtDate.Clear;

    TelaCadastroCliente.close;

  end;


  // Processo para salvar no banco de dados
  procedure TTelaCadastroCliente.SpeedbtnSalvarClick(Sender: TObject);
  var
    nomeCliente, emailCliente, telefoneCliente: string;
  begin
    nomeCliente := Trim(DBedtNomeCliente.Text);
    emailCliente := Trim(DBedtEmail.Text);
    telefoneCliente := Trim(DBedtTelefone.Text);

    if (nomeCliente = '') or ((emailCliente = '') and (telefoneCliente = '')) then
    begin
      ShowMessage('Por favor, preencha todos os campos obrigatórios.');
      Exit;
    end;

    if (Pos('@', emailCliente) = 0) or (Pos('.', emailCliente) = 0) or
       (Pos('@', emailCliente) = Length(emailCliente)) then
    begin
      ShowMessage('E-mail inválido. Verifique e tente novamente.');
      Exit;
    end;

    try
      ADOQueryVerificaEmail.Close;
      ADOQueryVerificaEmail.SQL.Text :=
        'SELECT COUNT(*) AS qtd FROM clientes WHERE email = :email';
      ADOQueryVerificaEmail.Parameters.ParamByName('email').Value := emailCliente;
      ADOQueryVerificaEmail.Open;

      if ADOQueryVerificaEmail.FieldByName('qtd').AsInteger > 0 then
      begin
        ShowMessage('E-mail já cadastrado.');
        Exit;
      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao verificar e-mail: ' + E.Message);
        Exit;
      end;
    end;

    try
      ADOQueryCliente.Close;
      ADOQueryCliente.SQL.Clear;
      ADOQueryCliente.SQL.Add(
        'INSERT INTO clientes (nome_cliente, telefone_cliente, email) ' +
        'VALUES (:nome, :telefone, :email)'
      );
      ADOQueryCliente.Parameters.ParamByName('nome').Value := nomeCliente;
      ADOQueryCliente.Parameters.ParamByName('telefone').Value := telefoneCliente;
      ADOQueryCliente.Parameters.ParamByName('email').Value := emailCliente;

      ADOQueryCliente.ExecSQL;

      ShowMessage('Cliente cadastrado com sucesso!');

      // Atualiza o grid principal
      TelaCliente.ADOQueryGridClientes.Requery;


      DBedtNomeCliente.Clear;
      DBedtEmail.Clear;
      DBedtTelefone.Clear;

    except
      on E: Exception do
        ShowMessage('Erro ao cadastrar cliente: ' + E.Message);
    end;

    DBedtNomeCliente.Clear;
    DBedtEmail.Clear;
    DBedtTelefone.Clear;
    DBedtDate.Clear;

  end;

  // Processo para limpar os campos e fechar a tela
  procedure TTelaCadastroCliente.speedbtn_fecharClick(Sender: TObject);
  begin

    DBedtNomeCliente.Clear;
    DBedtEmail.Clear;
    DBedtTelefone.Clear;
    DBedtDate.Clear;

    TelaCadastroCliente.Close;
  end;


end.
