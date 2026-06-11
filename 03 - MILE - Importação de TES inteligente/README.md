# 🚀 Totvs Protheus - Importação MILE – TES Inteligente

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![TOTVS Protheus](https://img.shields.io/badge/TOTVS-Protheus-blue)](https://www.totvs.com/)
[![MILE](https://img.shields.io/badge/Framework-MILE-orange)](https://centraldeatendimento.totvs.com/hc/pt-br/articles/360028814432-Framework-Linha-Protheus-MILE-Model-Integrator-Layout-Engine)

## 📌 Sobre o Projeto

Este repositório contém a documentação e os artefatos de uma solução desenvolvida para automatizar o cadastro em massa da tabela **SFM (TES Inteligente)** no módulo de Faturamento do **TOTVS Protheus**.

O grande problema operacional era a inclusão manual de centenas de registros, gerando:
- Horas de trabalho repetitivo
- Alto risco de erros de digitação
- Retrabalho constante
- Baixa produtividade da equipe

A solução adotada foi o **MILE (Model Integrator Layout Engine)**, framework nativo do Protheus que permite criar layouts customizados para importação/exportação de dados, integrando planilhas (Excel/CSV) diretamente com as tabelas do sistema, respeitando todas as regras de negócio.

---

## 📂 Estrutura do Repositório

| Arquivo | Descrição |
|---------|------------|
| `01 - MILE - SFM.png` | Tela de manutenção de layouts MILE – filtro para o layout SFM |
| `02 - MILE - SFM.png` | Detalhamento do layout SFM (abas Geral, Canais, Campos, Saídas) |
| `03 - LAYOUT_EXCEL.png` | Exemplo da planilha de origem (colunas: FM_TIPO, FM_CLIENTE, FM_LOJA, FM_POSIPI, FM_GRPTI, FM_DESCR, FM_ID) |
| `04 - TES INTELIGENTE.png` | Visualização dos dados cadastrados no programa TES Inteligente do Faturamento |
| `05 - TES INTELIGENTE.png` | Visualização dos dados cadastrados no programa TES Inteligente do Faturamento |
| `README.md` | Este arquivo – documentação completa do projeto |

---

## ⚙️ Como a Solução Foi Implementada

### 1. Criação do Layout MILE (SFM)
- Acesse o **Configurador (SIGACFG)** → Manutenção de Layouts MILE.
- Crie um novo layout com código `SFM` e descrição `CADASTRO - TES INTELIGENTE`.
- Defina a **Tabela Principal** como `SFM` (TES Inteligente).
- No canal `SFM_01`:
  - Tipo de ocorrência: **Única** (processa todo o arquivo de uma vez)
  - Pós-execução: habilitar ações de **Incluir**, **Alterar** e **Excluir**

### 2. Adapter Utilizado
- **Adapter:** `MATA089` (rotina padrão do Protheus para manutenção do TES Inteligente)
- **Tipo Adapter:** `1 - MSExecAuto` (execução automática via rotina)

### 3. Mapeamento dos Campos (Planilha → SFM)

| Coluna da Planilha | Campo da Tabela SFM | Descrição |
|--------------------|----------------------|------------|
| FM_TIPO            | FM_TIPO              | Tipo de operação |
| FM_CLIENTE         | FM_CLIENTE           | Cliente |
| FM_LOJA            | FM_LOJA              | Loja do cliente |
| FM_POSIPI          | FM_POSIPI            | NCM |
| FM_GRPTI           | FM_GRPTI             | Grupo do TES Inteligente |
| FM_DESCR           | FM_DESCR             | Descrição do grupo |
| FM_ID              | FM_ID                | Identificador da regra |

### 4. Arquivo de Importação
- O arquivo deve ser gerado em formato **CSV** ou **TXT** com separador `|` (pipe) ou ponto-e-vírgula, conforme configurado no layout.
- Exemplo de linha:
