#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include "TBICONN.CH"
#Include "totvs.ch"
#Include "RPTDEF.CH"
#Include "FWPrintSetup.ch"

/*/{Protheus.doc} 
Este Ponto de Entrada pode ser utilizado para inserir novas opções no
menu do MATA311
/*/

User Function MT311ROT()

Local aRet := Paramixb // Array contendo os botoes padroes da rotina.

// Tratamento no array aRet para adicionar novos botoes e retorno do novo array.
ADD OPTION aRet TITLE "Gera Relatório" ACTION "U_BIOESTRF" OPERATION 4 ACCESS 0


Return aRet


