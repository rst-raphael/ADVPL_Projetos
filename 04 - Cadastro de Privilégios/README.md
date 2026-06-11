# 🔐 Protheus Privileges Manager: Controle de Acesso e Regras

## 📋 Visão Geral
Este guia documenta o processo de configuração e gerenciamento de privilégios no ecossistema **TOTVS Protheus**. O sistema de privilégios permite um controle granular sobre o que cada usuário ou grupo pode realizar dentro das rotinas standard ou customizadas, indo além da simples permissão de acesso ao menu, chegando ao nível de operações de transação (Incluir, Alterar, Excluir, etc.).

O objetivo principal é garantir a conformidade e a segurança dos dados, impedindo ações não autorizadas em cadastros críticos como Produtos e Clientes.

---

## 📂 Estrutura & Fontes .prw
Abaixo estão as rotinas principais citadas no processo de configuração e as funções monitoradas pelo controle de acesso:

| Fonte .prw | Descrição da Transação/Rotina | Funcionalidade Mapeada |
| :--- | :--- | :--- |
| `MATA010.PRW` | Cadastro de Produtos | Pesquisar, Visualizar, Incluir, Alterar, Excluir, Consulta |
| `CRMA980.PRW` | Cadastro de Clientes (MVC) | Gestão de Clientes e Prospects |
| `APSADU.PRW` / `APCFG001.PRW` | Configurador (SIGACFG) | Gestão de Regras de Privilégios e Usuários |

---

## 🛠️ Tecnologias Utilizadas
*   **ERP:** TOTVS Protheus (Linha Protheus)
*   **Módulo:** SIGACFG (Configurador)
*   **Linguagem:** AdvPL (Advanced Protheus Language)
*   **Framework:** MVC (Model-View-Controller) para rotinas como CRMA980.

---

## 📌 Pré-requisitos
1.  Acesso ao módulo **Configurador (SIGACFG)** com perfil de administrador.
2.  Dicionário de dados atualizado.
3.  Usuário(s) previamente cadastrado(s) na tabela de usuários do sistema.

---

## 🚀 Instalação/Deploy
A configuração de privilégios é nativa do Protheus e não exige instalação de pacotes externos, apenas parametrização via interface:

1.  Acesse o módulo **Configurador (SIGACFG)**.
2.  Navegue em **Usuário -> Senhas -> Privilégios**.
3.  Defina uma nova **Regra** (ex: `BLOQUEIA_ALTERACAO_CADASTROS`).

---

## 📖 Como Usar

### 1. Criando uma Regra de Acesso
No cadastro de regras, você deve associar a rotina à ação desejada:
*   **Transação/Rotina:** Informe o fonte (ex: `MATA010`).
*   **Acesso:** Defina como "Permitido" para a rotina geral.
*   **Funcionalidades:** Na grade inferior, selecione as operações específicas. Para bloquear alterações, marque "Alterar" e "Excluir" como **Negado**.

### 2. Atribuindo a Regra ao Usuário
1.  Vá em **Usuário -> Senhas -> Usuários**.
2.  Selecione o usuário desejado (ex: `raphael`).
3.  Clique na aba **Privilégios** ou acesse via Outras Ações.
4.  Adicione a regra criada anteriormente à lista de restrições do usuário.

---

## 🔗 Endpoints / Rotinas de Monitoramento
As seguintes rotinas de interface (Browses) são afetadas diretamente por estas configurações:

*   **A010ALTERA**: Acionada ao tentar salvar uma modificação em `MATA010`.
*   **VIEWDEF.CRMA980**: Acionada na renderização da View da rotina de Clientes.
*   **Mata010Deleta**: Acionada no processo de exclusão de registros.

---

## 📊 Logs & Monitoramento
Quando um usuário sem privilégios tenta realizar uma operação bloqueada, o sistema exibe um alerta impeditivo (conforme evidenciado nos prints de execução):

> **Atenção:** "Esse usuário não possui acesso para executar essa operação. Menu: MATA010 / Rotina: A010ALTERA"

Para auditoria, utilize o **Log de Auditoria (GAFE020)** caso o parâmetro `MV_AUDIT` esteja ativo, para rastrear tentativas de violação de acesso.

---

## 🤝 Contribuição
Para sugerir melhorias neste fluxo de segurança:
1.  Abra uma **Issue** relatando o cenário de negócio.
2.  Envie um **Pull Request** caso possua customizações em `User Functions (U_)` que automatizem a atribuição de privilégios via `MsExecAuto`.

---

## 📜 Licença
Este guia de configuração é distribuído sob a licença **MIT**. O software Protheus é propriedade exclusiva da TOTVS S.A.

---
*Mantido por: [Seu Nome/Organização]* 🚀