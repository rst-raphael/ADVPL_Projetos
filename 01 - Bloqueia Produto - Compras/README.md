# 🔒 Bloqueio Específico para Compras (Protheus) – Códigos Reais

## 📌 Visão Geral

Esta solução customizada foi desenvolvida para o ERP **TOTVS Protheus** com o objetivo de **bloquear produtos descontinuados apenas nos processos de compras**, mantendo as vendas totalmente liberadas.

Diferentemente do campo nativo `B1_MSBLQL` (que bloqueia **todas** as movimentações – compras, vendas, produção, etc.), esta implementação atua de forma **cirúrgica**:
- ✅ **Compras bloqueadas** (Solicitação de Compras e Pedido de Compra)
- ✅ **Vendas liberadas** (estoque remanescente pode ser comercializado)

## 🎯 Problema Resolvido

- Produto sai de linha, mas ainda há estoque disponível para venda.
- A empresa **não pode comprar** novas quantidades, mas **precisa vender** o que tem.
- O campo `B1_MSBLQL` bloquearia também a venda, inviabilizando a operação.
- A solução customizada resolve exatamente esse cenário de **descontinuação gradual**.

## ⚙️ Solução Técnica

### 1. Campo Customizado no Cadastro de Produtos (SB1)

| Campo     | Tipo     | Descrição                                    |
|-----------|----------|----------------------------------------------|
| `B1_XDESCON` | Lógico (S/N) | Indica se o produto está descontinuado. |

- `B1_XDESCON = "S"` → produto descontinuado (compras bloqueadas)
- `B1_XDESCON = "N"` ou vazio → produto normal

### 2. Pontos de Entrada Utilizados

| Ponto de Entrada | Onde atua                          | Finalidade                                  |
|-----------------|-------------------------------------|---------------------------------------------|
| `MT110LOK`      | Solicitação de Compras (item a item) | Bloqueia produto descontinuado na SC |
| `MT120LOK`      | Pedido de Compras (item a item)     | Bloqueia produto descontinuado no Pedido de Compras |

### 3. Código Fonte Real

#### Arquivo: `MT110LOK.PRW`

```advpl
#include "rwmake.ch"
#include "topconn.ch"
#INCLUDE "protheus.ch"
/*------------------------------------------------------------------------//
//Programa: MT110LOK 
//Autor:    Raphael Silva
//Data:     27/06/2024
//Descricao:responsável pela validação de cada linha da GetDados da Solicitação de Compras .
//          O ponto se encontra no final da função e deve ser utilizado para validações especificas do usuario 
//          onde será controlada pelo retorno do ponto de entrada o qual se for .F. o processo será interrompido e se .T. será validado.      
//Uso:
//Parametros:
//Retorno:
//------------------------------------------------------------------------*/
User Function MT110LOK()

Local lRet    := .T.

    if SM0->M0_CODIGO=='80'
       Return(lRet)
    EndIf  

    _cProd := aCols[n,aScan(aHeader,{|x| AllTrim(x[2])=="C1_PRODUTO"})]

    SB1->(dbSetOrder(1))
    SB1->(dbseek(xFilial("SB1")+_cProd))
   
    IF SB1->B1_XDESCON == 'S' //Valida se o Produto está Descontinuado
        lRet := .F.
        ALERT("Produto descontinuado, não pode ser utilizado! <MT110LOK> ")
    ENDIF

Return lRet