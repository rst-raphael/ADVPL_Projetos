# ADVPL_Projetos

Repositório destinado a projetos, exemplos e customizações desenvolvidos em **ADVPL** (Ambiente de Desenvolvimento da TOTVS) para o sistema **Protheus**.

A ideia é reunir soluções práticas aplicadas a diferentes módulos (compras, produção, logística, etc.), tanto para estudo quanto para uso em ambientes reais.

---

## 📁 Estrutura atual

| Pasta | Descrição |
|-------|------------|
| `01 - Bloqueia Produto - Compras` | Rotinas de bloqueio de produtos e grupos de produtos no momento da compra. |
| `02 - Altera Dados Pesagem` | Programa para alterar dados de pesagem (módulo de compras/produção). |
| `03 - MILE - Importação de TES inteligente` | Processo de importação de Tipo de Estoque (TES) com lógica personalizada. |

---

## 🧩 Projetos já incluídos

### 1. Bloqueia Produto – Compras
- **Arquivos:** `MT110LOK.PRW`, `MT120LOK.PRW`
- **Funcionalidade:**  
  Customiza as rotinas padrão `MT110` (cadastro de produtos) e `MT120` (cadastro de grupos) para permitir/bloquear a compra de produtos com base em regras definidas pelo negócio.
- **Observação:** As imagens `B1_MSBLQL.png` e `B1_XDESCON.png` ilustram os novos campos ou flags utilizados.

### 2. Altera Dados Pesagem
- **Arquivo:** `ALTPESO.PRW`
- **Funcionalidade:**  
  Rotina que altera informações de pesagem – útil para correção ou ajuste de notas fiscais de entrada, romaneios ou processos industriais.
- **Acompanha:** imagem demonstrativa da tela.

### 3. MILE – Importação de TES inteligente
- **Arquivos:** (código não explicitado, mas há imagens do processo)
- **Funcionalidade:**  
  Automatiza e torna inteligente a importação de Tipos de Estoque, reduzindo erros manuais e agilizando a parametrização de movimentações.
- **Imagens:** `01 - MILE - SFM.png` e `02 - MILE - SFM.png` mostram etapas da solução.

---

## 🚀 Como utilizar

1. Clone o repositório:
   ```bash
   git clone https://github.com/rst-raphael/ADVPL_Projetos.git