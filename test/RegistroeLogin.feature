
Funcionalidade: Registro e Login de Usuário

  Cenário: Registrando um novo usuário
    Dado que estou na página de registro
    Quando eu inserir meu nome de usuário e senha
    E eu confirmar meu registro
    Então eu devo ser redirecionado para a página de login

  Cenário: Fazendo login com credenciais válidas
    Dado que estou na página de login
    Quando eu inserir meu nome de usuário e senha
    E eu pressionar o botão de login
    Então eu devo estar logado no aplicativo
    E eu devo ver meu painel