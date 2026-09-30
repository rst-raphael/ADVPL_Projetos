# 📊 Protheus: Gravação de Valor Total no Browser de Orçamentos (MATA415)

Este repositório contém a solução técnica para exibir o valor total dos orçamentos de venda diretamente no *browser* (tela principal) da rotina **MATA415**, facilitando a visualização rápida pelos usuários de faturamento sem a necessidade de abrir cada documento.

## 📝 Visão Geral

Por padrão, a tabela **SCJ** (Cabeçalho do Orçamento de Venda) não armazena o valor total calculado (itens + frete + seguro + despesas). Este projeto utiliza um campo customizado (`CJ_XTOTAL`) e o ponto de entrada `M415GRV` para persistir o valor total no momento da gravação, permitindo sua exibição em colunas de consulta.

## 📂 Estrutura & Fontes .prw

| Fonte | Tipo | Descrição |
| :--- | :--- | :--- |
| `M415GRV.prw` | Ponto de Entrada | Executado após a gravação do Orçamento de Venda. Responsável por calcular o somatório e atualizar o campo `CJ_XTOTAL`. |
| `Dicionário de Dados` | Configuração | Criação do campo `CJ_XTOTAL` na tabela **SCJ** via Configurador (SIGACFG). |

## 🚀 Tecnologias Utilizadas

*   **ADVPL** (Advanced Protheus Language)
*   **Protheus 12** (Módulo de Faturamento - SIGAFAT)
*   **Banco de Dados** (MSSQL/Oracle/PostgreSQL)

## ⚙️ Pré-requisitos

1.  Acesso ao módulo **Configurador (SIGACFG)**.
2.  Permissão para compilar fontes no **VS Code (TDS)**.
3.  Tabela **SCJ** e **SCK** ativas no ambiente.

## 🔧 Instalação / Deploy

### 1. Criação do Campo no Dicionário
Conforme as especificações da imagem anexada:
*   **Tabela:** SCJ
*   **Campo:** `CJ_XTOTAL`
*   **Tipo:** 2 - Numérico
*   **Tamanho:** 14
*   **Decimal:** 2
*   **Formato:** `@E 99,999,999,999.99`
*   **Contexto:** Real
*   **Propriedade:** Visualizar (para garantir a integridade via código)

### 2. Compilação do Código
Compile o fonte `M415GRV.prw` em seu repositório de customizados. O gatilho deve somar os itens da tabela `SCK` e adicionar os campos de cabeçalho (`CJ_FRETE`, `CJ_SEGURO`, `CJ_DESPESA`).

## 📖 Como Usar

1.  Acesse o módulo **Faturamento (SIGAFAT)**.
2.  Vá em **Atualizações > Vendas > Orçamentos (MATA415)**.
3.  Ao incluir ou alterar um orçamento, informe os valores de itens e despesas acessórias.
4.  Clique em **Salvar**.
5.  O valor total será calculado automaticamente e exibido na coluna "Valor Total" do browser, conforme demonstrado no screenshot da rotina.

## 🔍 Endpoints / Rotinas

*   **MATA415:** Rotina padrão de Orçamentos de Venda.
*   **SCJ:** Tabela de cabeçalho onde o total é gravado.
*   **SCK:** Tabela de itens utilizada para o cálculo do somatório.

## 📈 Logs & Monitoramento

Para validar se o valor está sendo gravado corretamente:
*   Utilize o **APSdu** para consultar o conteúdo do campo `CJ_XTOTAL` após salvar um registro.
*   Verifique o log de console (AppServer) caso tenha adicionado funções de `ConOut` no Ponto de Entrada para depuração.

## 🤝 Contribuição

1.  Faça um **Fork** do projeto.
2.  Crie uma **Branch** para sua modificação (`git checkout -b feature/melhoria-calculo`).
3.  Faça o **Commit** (`git commit -m 'Adicionando tratamento para descontos'`).
4.  **Push** (`git push origin feature/melhoria-calculo`).
5.  Abra um **Pull Request**.

## ⚖️ Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---
> **Mantenedor:** [Seu Nome/Empresa]  
> **Contexto:** Customização Protheus - ERP TOTVS.