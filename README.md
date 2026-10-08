# ADVPL_Projetos

Repositório destinado a projetos, exemplos e customizações desenvolvidos em **ADVPL** (Ambiente de Desenvolvimento da TOTVS) para o sistema **Protheus**.

A ideia é reunir soluções práticas aplicadas a diferentes módulos (compras, estoque, faturamento, financeiro, etc.), tanto para estudo quanto para uso em ambientes reais.

---

## 📁 Estrutura atual

| Pasta                                            | Descrição                                                                                      |
| ------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| `01 - Bloqueia Produto - Compras`                | Rotinas de bloqueio de produtos - Solicitação de Compras e Pedido de Compra                    |
| `02 - Altera Dados Pesagem`                      | Programa para alterar dados de pesagem (módulo de compras/produção).                           |
| `03 - MILE - Importação de TES inteligente`      | Processo de importação de Tipo de Estoque (TES) com lógica personalizada.                      |
| `04 - Cadastro de Privilégios`                   | Guia de configuração de privilégios para controlar as operações permitidas por usuário.        |
| `06 - Relação das Solicitações de Transferencia` | Relatório de solicitações de transferência (MATA311) via ponto de entrada `MT311ROT`.          |
| `09 - Total Orçamento`                           | Gravação do valor total do orçamento de venda (MATA415) para exibição no browser.              |
| `10 - Filtro Bordero`                            | Filtro de clientes na geração de borderô via ponto de entrada `FA060Qry`.                      |

---

## 🧩 Projetos já incluídos

### 1. Bloqueia Produto – Compras

- **Arquivos:** `MT110LOK.PRW`, `MT120LOK.PRW`
- **Funcionalidade:**
  Customiza as rotinas padrão `MT110LOK` (Solicitação de compras) e `MT120LOK` (Pedido de Compra) para permitir/bloquear a compra de produtos com base em regras definidas pelo negócio.
- **Observação:** As imagens `B1_MSBLQL.png` e `B1_XDESCON.png` ilustram os novos campos ou flags utilizados.

### 2. Altera Dados Pesagem

- **Arquivo:** `ALTPESO.PRW`
- **Funcionalidade:**
  Rotina que altera informações de pesagem – útil para alteração de pedidos de venda
- **Acompanha:** imagem demonstrativa da tela.

### 3. MILE – Importação de TES inteligente

- **Arquivos:** (código não explicitado, mas há imagens do processo)
- **Funcionalidade:**
  Automatiza e torna inteligente a importação de Tipos de Estoque, reduzindo erros manuais e agilizando a parametrização de movimentações.
- **Imagens:** `01 - MILE - SFM.png` e `02 - MILE - SFM.png` mostram etapas da solução.

### 4. Cadastro de Privilégios

- **Rotinas monitoradas:** `MATA010.PRW` (Cadastro de Produtos) e `CRMA980.PRW` (Cadastro de Clientes – MVC)
- **Funcionalidade:**
  Documenta a configuração de privilégios no Protheus, permitindo controle granular por usuário ou grupo, indo além do acesso ao menu e chegando às operações de transação (Incluir, Alterar, Excluir, etc.). Impede ações não autorizadas em cadastros críticos como Produtos e Clientes.
- **Como configurar:** No **Configurador (SIGACFG)**, em *Usuário > Senhas > Privilégios*, crie uma regra associando a rotina às ações desejadas e atribua a regra ao usuário.
- **Observação:** É um recurso nativo do Protheus, não exige compilação de fontes.

### 6. Relação das Solicitações de Transferência

- **Arquivos:** `MT311ROT.prw` (ponto de entrada que adiciona o botão no menu da `MATA311`) e `BIOESTRF.prw` (relatório customizado)
- **Funcionalidade:**
  Adiciona em *Outras Ações* da rotina **MATA311** (Solicitação de Transferência, módulo Estoque/Custos) um botão que emite relatório formatado para conferência dos itens, com filtros por código de transferência, data e produto.
- **Função chamada:** `U_BIOESTRF()`
- **Observação:** Caso já exista um ponto de entrada `MT311ROT` no RPO, mescle o código usando `ADD OPTION`.

### 9. Total Orçamento

- **Arquivo:** `M415GRV.prw` + campo `CJ_XTOTAL` (tabela `SCJ`)
- **Funcionalidade:**
  Exibe o valor total dos orçamentos de venda direto no browser da rotina **MATA415**. O ponto de entrada `M415GRV` soma os itens (`SCK`) e os campos de cabeçalho (`CJ_FRETE`, `CJ_SEGURO`, `CJ_DESPESA`) e grava o resultado em `CJ_XTOTAL`.
- **Pré-requisito:** Criar o campo `CJ_XTOTAL` (Numérico, 14,2) na tabela `SCJ` via Configurador.

### 10. Filtro Borderô

- **Arquivo:** `FA060Qry.prw` + campo `A1_XBORDER` (tabela `SA1`)
- **Funcionalidade:**
  Permite excluir clientes específicos da rotina de geração de borderô. O ponto de entrada `FA060Qry` adiciona à query a condição `AND SA1.A1_XBORDER <> '2'`, ocultando os títulos de clientes marcados como "Não", evitando remessas bancárias indevidas.
- **Pré-requisito:** Criar o campo `A1_XBORDER` (Caracter, 1, combo `1=Sim;2=Nao`, padrão `1`) na tabela `SA1`, pasta Adm/Fin.

---

## 🚀 Como utilizar

1. Clone o repositório:

```
git clone https://github.com/rst-raphael/ADVPL_Projetos.git
```
