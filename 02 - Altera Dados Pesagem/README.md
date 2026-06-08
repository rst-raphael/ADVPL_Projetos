# ⚖️ Tela Customizada para Dados de Pesagem – Expedição (Protheus)

## 📌 Visão Geral

Esta solução customizada foi desenvolvida para o ERP **TOTVS Protheus** com o objetivo de permitir que a equipe de **expedição** registre dados de pesagem (peso bruto, peso líquido, volume, espécie, tipo de frete) em um pedido de venda **sem alterar campos críticos** e **sem perder a liberação financeira** já concedida.

A rotina é acessada pelo menu do pedido de venda (`MA410`) através de uma nova opção **"Dados Pesagem"**, adicionada via ponto de entrada `MA410MNU`.

## 🎯 Problema Resolvido

- Pedido de venda já liberado pelo financeiro.
- A expedição precisa preencher dados logísticos para emissão de nota fiscal/conhecimento de frete.
- Alterar o pedido diretamente poderia invalidar a liberação financeira, exigindo nova aprovação.
- A solução permite atualizar **apenas os campos de pesagem**, preservando a liberação original.

## ⚙️ Solução Técnica

### 1. Ponto de Entrada Utilizado

| Ponto de Entrada | Onde atua                          | Finalidade                                  |
|-----------------|-------------------------------------|---------------------------------------------|
| `MA410MNU`      | Menu do Pedido de Venda (MA410)     | Adiciona a opção "Dados Pesagem" ao menu    |

**Código (MA410MNU.PRW):**
```advpl
#Include "Protheus.ch"
#INCLUDE "RWMAKE.CH"

User Function MA410MNU()
    AADD(aRotina, {"Dados Pesagem", "U_ALTPESO()", 0, 0, 0, .F.})
Return