# Passo Certo 👟

Sistema desktop para gestão de uma loja de calçados, desenvolvido em Delphi com integração a banco de dados PostgreSQL.

## Funcionalidades

- **Login** de usuário
- **Cadastro de produtos**, com categoria, fornecedor, tamanho e preço
- **Cadastro de clientes**
- **Cadastro de fornecedores**
- **Registro de vendas**
- **Controle de estoque** (adicionar/remover)
- Remoção de produtos, clientes, fornecedores e vendas

## Tecnologias

- Delphi (VCL)
- ADO (TADOConnection / TADOQuery) para acesso a dados
- PostgreSQL

## Telas

As imagens das telas do sistema estão na pasta `TelasPassoCerto/`.

## Como rodar

1. Abra o projeto na IDE do Delphi.
2. Configure a conexão do `ADOConnectionGeral` (em `uDMPrincipal`) apontando para o seu banco PostgreSQL.
3. Compile e execute.

## Estrutura do projeto

```
├── Unit_login.pas/.dfm              # tela de login
├── UnitTelaInicial.pas/.dfm         # tela inicial
├── UnitTelaProdutos.pas/.dfm        # gestão de produtos
├── UnitCriarProduto.pas/.dfm        # cadastro de produto
├── UnitRemoverProduto.pas/.dfm      # remoção de produto
├── UnitTelaCliente.pas/.dfm         # gestão de clientes
├── UnitCriarCliente.pas/.dfm        # cadastro de cliente
├── UnitRemoverCliente.pas/.dfm      # remoção de cliente
├── UnitTelaFornecedore.pas/.dfm     # gestão de fornecedores
├── UnitTelaCriarFornecedor.pas/.dfm # cadastro de fornecedor
├── UnitRealizarVenda.pas/.dfm       # registrar venda
├── UnitTelaEstoque.pas/.dfm         # controle de estoque
├── configurarContaBD.pas/.dfm       # configuração da conta/banco
├── Src/uDMPrincipal.pas/.dfm        # data module (conexão com o banco)
├── icones/                          # ícones da interface
└── TelasPassoCerto/                 # prints das telas do sistema
```

## Autor

Desenvolvido por [Henry Braga](https://github.com/HenryBragaDev) como projeto de estudo em Análise e Desenvolvimento de Sistemas.
