--- Point to parts that could be optimized
--- Feel free to comment any row that you think could be optimize/adjusted in some way!
--- The following query is from SAP HANA but applies to any DB
--- Do not worry if the tables/columns are not familiar to you 
----   -> you do not need to interpret the result (in fact the query does not reflect actual DB content)
SELECT 
    RSEG.EBELN,
    RSEG.EBELP,
    RSEG.BELNR,
    RSEG.AUGBL AS AUGBL_W,
    LPAD(EKPO.BSART,6,0) as BSART,
    BKPF.GJAHR,
    BSEG.BUKRS,
    BSEG.BUZEI,
    BSEG.BSCHL,
    BSEG.SHKZG,
    CASE WHEN BSEG.SHKZG = 'H' THEN (-1) * BSEG.DMBTR ELSE BSEG.DMBTR END AS DMBTR,
    COALESCE(BSEG.AUFNR, 'Kein SM-A Zuordnung') AS AUFNR,
    COALESCE(LFA1.LAND1, 'Andere') AS LAND1, 
    LFA1.LIFNR,
    LFA1.ZSYSNAME,
    BKPF.BLART as BLART,
    BKPF.BUDAT as BUDAT,
    BKPF.CPUDT as CPUDT
FROM "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_RSEG" AS RSEG
LEFT JOIN "DTAG_DEV_CSBI_CELONIS_WORK"."dtag.dev.csbi.celonis.app.p2p_elog::__P2P_REF_CASES" AS EKPO ON 1=1  
--- left join before inner join automatically becomes inner join
    AND RSEG.ZSYSNAME = EKPO.SOURCE_SYSTEM
    AND RSEG.MANDT = EKPO.MANDT --- here, "using clause" is not appropriate because we need additional join to columns with different names
    AND RSEG.EBELN || RSEG.EBELP = EKPO.EBELN || EKPO.EBELP --- concating + joining, probably better to just join on rseg.ebeln = ekpo.ebeln and rseg.ebelp = ekpo.ebelp
INNER JOIN "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_BKPF" AS BKPF ON 1=1
-- with same column names, we can use "join using (column1, column2, ...)", column will appear only once in the result set
-- the foreign keys should be defined
-- however, additional conditions would need to be moved to "where clause" after joins, i.e. where rseg.mandt in ('200')
-- it's better to filter the table immediately when joining larger data, not afterwards in where clause, so depends on the condition
-- sometimes it's better to define the conditions in a where clause for better readibility
    AND RSEG.ZSYSNAME = BKPF.ZSYSNAME --- x
    AND BKPF.AWKEY = RSEG.AWKEY --- using (awkey, zsysname) 
    AND RSEG.MANDT in ('200') --- rseg.mandt::int = 200 (integers faster than strings)
INNER JOIN "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_BSEG" AS BSEG ON 1=1
    AND DATS_IS_VALID(BSEG.ZFBDT) = 1
    AND BSEG.KOART = 'K'
    AND CAST(BSEG.GJAHR AS INT) = 2020
    AND BKPF.ZSYSNAME = BSEG.ZSYSNAME --- using (zsysname, mandt, bukrs, gjahr, belnr)
    AND BKPF.MANDT = BSEG.MANDT --- x
    AND BKPF.BUKRS = BSEG.BUKRS --- x
    AND BKPF.GJAHR = BSEG.GJAHR --- x
    AND BKPF.BELNR = BSEG.BELNR --- x
    AND BSEG.DMBTR*-1 >= 0 --- no need to multiply, just bseg.dmbtr <= 0 
INNER JOIN (SELECT * FROM "DTAG_DEV_CSBI_CELONIS_DATA"."dtag.dev.csbi.celonis.data.elog::V_LFA1" AS TEMP --- if we already write "inner join select where" we should already specify columns which are needed instead of *
            WHERE TEMP.LIFNR > '020000000') AS LFA1 ON 1=1 --- not sure whether we really need "> string", don't we want integer here?
    AND BSEG.ZSYSNAME = LFA1.ZSYSNAME --- using (zsysname, lifnr, mandt)
    AND BSEG.LIFNR=LFA1.LIFNR --- x
    AND BSEG.MANDT=LFA1.MANDT --- x
    AND LFA1.LAND1 in ('DE','SK')
;
