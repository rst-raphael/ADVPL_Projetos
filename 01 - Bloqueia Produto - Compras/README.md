# 🔒 Bloqueio Específico para Compras (Protheus)

## 📌 Visão Geral

Esta solução customizada foi desenvolvida para o ERP **TOTVS Protheus** com o objetivo de **bloquear produtos descontinuados apenas nos processos de compras**, mantendo as vendas totalmente liberadas.

Diferentemente do campo nativo `B1_MSBLQL` (que realiza um bloqueio total – compras, vendas e movimentações), esta implementação atua de forma **cirúrgica**, permitindo que a empresa venda o estoque remanescente de um produto descontinuado sem correr o risco de realizar novas compras.

## 🎯 Problema Resolvido

- Produto sai de linha, mas ainda há estoque disponível para venda.
- A empresa **não pode comprar** novas quantidades, mas **precisa vender** o que tem.
- O campo `B1_MSBLQL` bloquearia também a venda, inviabilizando a operação.

## ⚙️ Solução Técnica

### 1. Campo Customizado no Cadastro de Produtos (SB1)

| Campo     | Tipo     | Descrição                                    |
|-----------|----------|----------------------------------------------|
| `B1_XDESCON` | Lógico (S/N) | Indica se o produto está descontinuado. |

- Quando `B1_XDESCON = "S"` → produto descontinuado.
- Quando `B1_XDESCON = "N"` ou vazio → produto normal.

### 2. Pontos de Entrada Utilizados

| Ponto de Entrada | Onde atua                          | Finalidade                                  |
|-----------------|-------------------------------------|---------------------------------------------|
| `MT110LOK`      | Solicitação de Compras (item a item) | Bloquear produto descontinuado na SC |
| `MT120LOK`      | Pedido de Compras (item a item)     | Bloquear produto descontinuado no pedido de compras |

### 3. Lógica de Validação (ADVPL)

Abaixo um exemplo prático do código implementado:

```advpl
// Ponto de Entrada MT110LOK (Solicitação de Compras)
// Ponto de Entrada MT120LOK (Pedido de Compras)

User Function MT110LOK()
Local cProduto  := SC1->C1_PRODUTO
Local lBloqueia := .F.

// Busca o campo customizado no cadastro do produto
DbSelectArea("SB1")
DbSetOrder(1)  // B1_COD
If DbSeek(xFilial("SB1") + cProduto)
    If SB1->B1_XDESCON == "S"
        lBloqueia := .T.
    EndIf
EndIf

If lBloqueia
    // Exibe mensagem de bloqueio e impede a inclusão/liberação do item
    Aviso("Produto Descontinuado", "Produto Descontinuado, não pode ser utilizado", {"OK"})
    Return .F.  // Bloqueia a operação
EndIf

Return .T.  // Libera o item