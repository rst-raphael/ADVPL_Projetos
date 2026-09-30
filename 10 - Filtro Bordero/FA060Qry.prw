#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

/*/{Protheus.doc} FA060Qry
Ponto de entrada na rotina de Borderô (FINA060) para filtrar apenas
títulos de clientes que emitem boleto (A1_XBORDER = 'S').
@author Raphael Silva
@since 22/09/2026
@version 1.0
/*/
User Function FA060Qry()
    // Recebe os parâmetros enviados pelo PE (opcional para o nosso caso, mas boa prática declarar)
    //Local cAgen060  := PARAMIXB[1]
    //Local cConta060 := PARAMIXB[2]
    
    Local CQUERY := ""

    CQUERY := "E1_CLIENTE+E1_LOJA IN ( SELECT A1_COD+A1_LOJA FROM "+RetSqlName('SA1')+" WHERE A1_XBORDER = 'S')"
    
Return CQUERY
