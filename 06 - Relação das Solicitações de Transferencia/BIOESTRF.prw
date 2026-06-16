#INCLUDE "TOTVS.CH"
#INCLUDE "Topconn.ch"

/*------------------------------------------------------------------------//
//Programa:	 BIOESTRF
//Autor:	 Raphael Silva
//Data:		 06/05/2026
//Descricao: Relação das Solicitações de Transferência
//------------------------------------------------------------------------*/

User Function BIOESTRF()
    Private oReport     := NIL
    Private oSection1   := NIL
    Private cAlias

    Private cPerg := "BIOESTRF"

    //Exibir perguntas ao abrir o relatorio no protheus

    Pergunte(cPerg,.T.)

    ReportDef()
    oReport:PrintDialog()

Return

Static Function ReportDef()
    oReport := TReport():New("BIOESTRF", "Relação das Solicitações de Transferência", cPerg,{|oReport| PrintReport(oReport)}, "Relação das Solicitações de Transferência")
    //oReport :SetLandscape(.T.)

    oSection1 := TRsection():New(oReport, "Solicitações de Transferência")

    //Itens do Relatório

    TRCell():New(oSection1,"NNT_FILIAL", cAlias,"Filial")
    TRCell():New(oSection1,"NNT_COD",    cAlias,"Cod. Transf.")
    TRCell():New(oSection1,"NNS_DATA",   cAlias,"Data")
    TRCell():New(oSection1,"NNT_PROD",   cAlias,"Produto")
    TRCell():New(oSection1,"B1_DESC",    cAlias,"Descrição")
    TRCell():New(oSection1,"NNT_LOCAL",  cAlias,"Armaz. Orig")
    TRCell():New(oSection1,"NNT_LOCALI", cAlias,"Endereço")
    TRCell():New(oSection1,"NNT_LOTECT", cAlias,"Lote")
    TRCell():New(oSection1,"NNT_DTVALI", cAlias,"Dt. Validade")
    TRCell():New(oSection1,"NNT_QUANT",  cAlias,"Quantidade")
    TRCell():New(oSection1,"NNT_FILDES", cAlias,"Filial Dest.")
    TRCell():New(oSection1,"NNT_TS",     cAlias,"TES Saída")
    TRCell():New(oSection1,"NNT_TE",     cAlias,"TES Entrada")
    TRCell():New(oSection1,"NNT_DOC",    cAlias,"Documento")
    TRCell():New(oSection1,"NNS_SOLICT", cAlias,"Solicitante")
    TRCell():New(oSection1,"NNS_XLOGIN", cAlias,"Nome",,22,,{|| UsrFullName(NNS_SOLICT)})    

Return

Static Function PrintReport(oReport)
    Private cAlias       := ""
    Private cNomeUsuario := ""

    cAlias := GetNextAlias()
    cNomeUsuario := AllTrim(UsrFullName())

    oSection1:BeginQuery()

    BeginSQL Alias cAlias
        SELECT
            NNT_FILIAL,
            NNT_COD,
            NNS_DATA,
            NNS_SOLICT,
            NNT_PROD,
            B1_DESC,
            NNT_LOCAL,
            NNT_LOCALI,
            NNT_LOTECT,
            NNT_DTVALI,
            NNT_QUANT,
            NNT_FILDES,
            NNT_TS,
            NNT_TE,
            NNT_DOC
        FROM
            %Table:NNT% NNT
        INNER JOIN %Table:NNS% NNS
        ON NNT_FILIAL = NNS_FILIAL
            AND NNT_COD = NNS_COD
        INNER JOIN %Table:SB1% SB1
        ON B1_COD = NNT_PROD
            AND SB1.%notDel%
        WHERE
            NNT.%notDel%
            AND NNS.%notDel%
            AND NNS_COD BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
            AND NNS_DATA BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
            AND NNT_PROD BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
        ORDER BY
            NNT_COD
    EndSQL

    oSection1:EndQuery()//Fim da Query
    
    oSection1:Print()

    //O Alias utiizado para execução da query é fechado
    (cAlias)->(DBCloseArea())

Return

