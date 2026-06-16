# 📦 Relatório de Solicitação de Transferência (MATA311)

Este repositório contém a customização para Protheus que permite a consulta e geração de relatórios de Solicitações de Transferência diretamente pela rotina padrão **MATA311**, utilizando o ponto de entrada **MT311ROT**.

## 📝 Visão Geral

A rotina padrão de Solicitação de Transferência do módulo de Estoque e Custos (SIGAEST) não possui um botão nativo para emissão de relatório formatado para conferência de itens. Esta implementação adiciona um botão no menu "Outras Ações" que dispara a função customizada de impressão, permitindo filtrar por código de transferência, intervalo de datas e produtos.

## 🗂️ Estrutura & Fontes .prw

| Fonte | Descrição | Observação |
| :--- | :--- | :--- |
| `MT311ROT.prw` | Ponto de Entrada para manipulação do MenuDef. | Responsável por adicionar o botão no menu da MATA311. |
| `BIOESTRF.prw` | Relatório customizado de Solicitações. | Processa os dados e gera a saída (PDF/Excel/Impressora). |

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** AdvPL (Advanced Protheus Language)
- **Ponto de Entrada:** Utilização do MT311ROT para manipulação do array aRotina.
- **TReport / Relatórios Customizados:** Criação de interface de parâmetros (Pergunte) para filtragem de dados.
- **Banco de Dados:** Compatível com todos os suportados pelo Protheus (MSSQL, Oracle, etc).

## 🚀 Pré-requisitos

- Acesso ao VSCODE para compilação.
- Permissão de acesso à rotina `MATA311` no módulo 04 (Estoque).

## 📥 Instalação/Deploy

1.  Baixe os arquivos `.prw` contidos neste repositório.
2.  Compile os fontes `MT311ROT.prw` e `BIOESTRF.prw` utilizando o **VS Code (com extensões TOTVS)** 
3.  Certifique-se de que não existam outros pontos de entrada com o mesmo nome (`MT311ROT`) no seu RPO. Caso existam, mescle o código utilizando o comando `ADD OPTION`.

## 🎮 Como Usar

1.  Acesse o módulo **Estoque e Custos (04)**.
2.  Vá em **Atualizações > Movimentações > Internas > Solicitação de Transf. (MATA311)**.
3.  Clique no botão **Outras Ações**.
4.  Selecione a nova opção (ex: **"Relatório de Solicitações"**).
5.  Preencha os parâmetros de filtro:
    *   **Cod. Transf. De/Até**
    *   **Data De/Até**
    *   **Produto De/Até**
6.  Confirme para visualizar o relatório.

## 🔍 Endpoints/Rotinas

A integração ocorre exclusivamente via interface Protheus:
- **Rotina Técnica:** `MATA311` (Solicitação de Transferência)
- **Função Chamada:** `U_BIOESTRF()` (Executada via botão criado no P.E.)

