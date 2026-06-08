#include "rwmake.ch"
#include "topconn.ch"
#INCLUDE "protheus.ch"
/*------------------------------------------------------------------------//
//Programa: MT110LOK 
//Autor:	Raphael Silva
//Data:		27/06/2024
//Descricao:responsável pela validação de cada linha da GetDados da Solicitação de Compras .
//		    O ponto se encontra no final da função e deve ser utilizado para validações especificas do usuario 
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
