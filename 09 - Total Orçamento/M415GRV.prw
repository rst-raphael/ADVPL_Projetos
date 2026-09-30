#Include 'Protheus.ch'

/*/{Protheus.doc} M415GRV
Ponto de Entrada após a gravação do Orçamento de Vendas (MATA415).
Objetivo: Gravar o valor total dos itens (SCK) no cabeçalho (SCJ).
@author Raphael Silva
@since 30/09/2026
@version 1.0
/*/
User Function M415GRV()
    Local nOpc     := 0
    Local cNumOrc  := SCJ->CJ_NUM
    local nFrete   := SCJ->CJ_FRETE
    local nDespesa := SCJ->CJ_DESPESA
    local nSeguro  := SCJ->CJ_SEGURO
    Local cAreaSCK := SCK->(GetArea())
    Local nTotal   := 0
    
    // Captura o parâmetro enviado pelo Protheus de forma segura
    If Type("PARAMIXB") == "A" .And. Len(PARAMIXB) > 0
        nOpc := PARAMIXB[1]
    ElseIf Type("PARAMIXB") == "N"
        nOpc := PARAMIXB
    EndIf

    // Executa a totalização apenas se for Inclusão (1) ou Alteração (2)
    If nOpc == 1 .Or. nOpc == 2
        
        SCK->(DbSetOrder(1)) // Índice 1: Filial + Num. Orçamento + Item
        
        // Posiciona no primeiro item do orçamento atual
        If SCK->(DbSeek(xFilial("SCK") + cNumOrc))
            
            // Percorre todos os itens do orçamento
            While !SCK->(Eof()) .And. SCK->CK_FILIAL == xFilial("SCK") .And. SCK->CK_NUM == cNumOrc
                
                // Soma o valor do item, ignorando registros deletados
                If !SCK->(Deleted())
                    nTotal += SCK->CK_VALOR 
                EndIf
                
                SCK->(DbSkip())
            EndDo
        EndIf

        // Grava o valor total no campo customizado da SCJ e ssoma o frete, despesa e seguro
        RecLock("SCJ", .F.) 
        SCJ->CJ_XTOTAL := (nTotal + nFrete + nDespesa + nSeguro) 
        SCJ->(MsUnlock())
        
    EndIf

    // Restaura a área de trabalho
    RestArea(cAreaSCK)
    
Return Nil
