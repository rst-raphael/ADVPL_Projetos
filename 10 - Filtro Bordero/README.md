# 📑 Filtro Personalizado de Borderô (FA060Qry)

Este repositório contém a implementação técnica para otimização da rotina de geração de Borderôs no módulo Financeiro do ERP Protheus. A solução permite segregar clientes específicos da rotina de cobrança bancária através de uma parametrização simples no cadastro de clientes.

## 📝 Visão Geral

O objetivo deste projeto é fornecer um controle granular sobre quais títulos devem ser exibidos na rotina de **Geração de Borderô (FINA060)**. 

Através da criação do campo customizado `A1_XBORDER` e da implementação do Ponto de Entrada `FA060Qry`, o sistema passa a filtrar automaticamente os títulos a receber, ocultando aqueles pertencentes a clientes marcados como "Não" para geração de borderô. Isso evita erros operacionais e o envio indevido de remessas bancárias.

## 🗂️ Estrutura & Fontes .prw

| Fonte | Tipo | Descrição |
| :--- | :--- | :--- |
| `FA060Qry.prw` | Ponto de Entrada | Responsável por injetar a cláusula SQL `WHERE` na consulta principal da rotina FINA060. |
| `A1_XBORDER` | Dicionário (SX3) | Campo de usuário no cadastro de Clientes (SA1) para controle binário (Sim/Não). |

## 🚀 Tecnologias Utilizadas

*   **Linguagem:** AdvPL (Advanced Protheus Language)
*   **Banco de Dados:** Relacional (SQL Server/Oracle/PostgreSQL)
*   **Plataforma:** TOTVS Protheus (Linha Microsiga)
*   **Ferramenta de Filtro:** Ponto de Entrada padrão `FA060Qry`

## ⚙️ Pré-requisitos

1.  **Acesso ao Configurador (SIGACFG):** Necessário para a criação do campo na tabela SA1.
2.  **Módulo Financeiro (SIGAFIN):** Rotina de Borderô (FINA060) instalada e funcional.
3.  **Ambiente Protheus:** Versão 12.1.x ou superior (compatível com versões anteriores conforme documentação TDN).

## 🛠️ Instalação / Deploy

### 1. Criação do Campo (Dicionário de Dados)
Via **Configurador (SIGACFG)**, crie o seguinte campo na tabela **SA1 (Clientes)**:

*   **Campo:** `A1_XBORDER`
*   **Tipo:** Caracter
*   **Tamanho:** 1
*   **Contexto:** Real
*   **Propriedade:** Alterar
*   **Pasta:** Adm/Fin.
*   **Opções (X3_COMBO):** `1=Sim;2=Nao`
*   **Trigger/Default:** `1` (Sim)

### 2. Compilação do Ponto de Entrada
1.  Abra o **VS Code** com o plugin **TOTVS Developer Studio**.
2.  Inclua o arquivo `FA060Qry.prw` no seu projeto.
3.  Compile o código no repositório (RPO) do seu ambiente.

## 📖 Como Usar

1.  Acesse o módulo **Financeiro (SIGAFIN)**.
2.  Vá em **Atualizações > Cadastros > Clientes**.
3.  Na aba **Adm/Fin.**, localize o campo **Gera Borderô (A1_XBORDER)**.
4.  Defina como **"2 - Não"** para os clientes que devem ser excluídos da rotina automática.
5.  Ao acessar **Atualizações > Contas a Receber > Borderô**, os títulos desses clientes não serão listados para seleção.

## 🔍 Endpoints / Rotinas

A lógica está centralizada na rotina padrão:
*   **FINA060 (Transferência de Contas a Receber):** A query de seleção de títulos é interceptada para incluir:
    ```sql
    AND SA1.A1_XBORDER <> '2'
    ```

## 📊 Logs & Monitoramento

*   **Console Log:** Caso o filtro não retorne dados inesperadamente, verifique o `console.log` do AppServer para validar se a query montada pelo Protheus está correta.
*   **DBAccess:** Utilize o monitor do DBAccess para visualizar a instrução SQL completa enviada ao banco de dados durante a execução da rotina FINA060.

## 🤝 Contribuição

Contribuições são bem-vindas! Siga os passos:
1. Faça um **Fork** do projeto.
2. Crie uma **Branch** para sua feature (`git checkout -b feature/NovaMelhoria`).
3. Dê um **Commit** em suas alterações (`git commit -m 'Adicionando melhoria X'`).
4. Faça o **Push** da Branch (`git push origin feature/NovaMelhoria`).
5. Abra um **Pull Request**.

## ⚖️ Licença

Este projeto está sob a licença **MIT**. Sinta-se à vontade para utilizar, modificar e distribuir em seus projetos Protheus.

---
> **Nota:** Este Ponto de Entrada foi baseado na documentação oficial [TDN - FA060Qry](https://tdn.totvs.com/pages/releaseview.action?pageId=6071120).