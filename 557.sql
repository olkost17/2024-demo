WITH query_w_vendors AS(

WITH query_wo_vendors AS (

WITH query_from_co_object AS (
    SELECT
        EXTRACT(MONTH FROM DATE_PARSE(cobk."BUDAT", '%Y%m%d')) AS posting_month,
        coep."BELNR"  AS document_number,
        --coep."SGTXT"  AS document_description,
        cobk."BLTXT"  AS document_description,
        cobk."BLART"  AS document_type,
        coep."EBELN"  AS purchasing_document,
        coep."MATNR"  AS material,
        cobk."GJAHR"  AS fiscal_year,
        coep."OBJNR"  AS object_number,
        coep."PAROB1" AS object_number_aufnr,
        coep."WOGBTR" AS amount,
      --  coep."WTGBTR" AS amount,
        coep."KSTAR"  AS cost_element
    FROM
        "GSAP"."COEP" coep
    JOIN
        "GSAP"."COBK" cobk 
        ON  coep."KOKRS" = cobk."KOKRS"
        AND coep."BELNR" = cobk."BELNR"
    WHERE
        coep."VERSN" IN ( '000', '001',  'BUD' )
        AND coep."WRTTP" IN ('01', '04')
        AND coep."KOKRS" = '1100'
        AND coep."LEDNR" = '00'
        AND cobk."BUDAT" >= '2020-01-01'

      AND (
  
    coep."OBJNR" = 'KS11000000060101'
 OR coep."OBJNR" BETWEEN 'KS11000000060109' AND 'KS11000000060111'
 OR coep."OBJNR" = 'KS11000000060114'
 OR coep."OBJNR" BETWEEN 'KS11000000060160' AND 'KS11000000060165'
 OR coep."OBJNR" BETWEEN 'KS11000000060167' AND 'KS11000000060170'
 OR coep."OBJNR" BETWEEN 'KS11000000060172' AND 'KS11000000060173'
 OR coep."OBJNR" = 'KS11000000060175'
 OR coep."OBJNR" = 'KS11000000060177'
 OR coep."OBJNR" = 'KS11000000060179'
 OR coep."OBJNR" BETWEEN 'KS11000000060202' AND 'KS11000000060204'
 OR coep."OBJNR" BETWEEN 'KS11000000060218' AND 'KS11000000060219'
 OR coep."OBJNR" = 'KS11000000060241' 
 OR coep."OBJNR" BETWEEN 'KS11000000060244' AND 'KS11000000060245'
 OR coep."OBJNR" BETWEEN 'KS11000000060251' AND 'KS11000000060252'
 OR coep."OBJNR" BETWEEN 'KS11000000060270' AND 'KS11000000060271'
 OR coep."OBJNR" BETWEEN 'KS11000000060273' AND 'KS11000000060276'
 OR coep."OBJNR" = 'KS11000000060291'
 OR coep."OBJNR" = 'KS11000000060296'
 OR coep."OBJNR" = 'KS11000000060302'
 OR coep."OBJNR" = 'KS11000000060308'
 OR coep."OBJNR" = 'KS11000000060310'
 OR coep."OBJNR" = 'KS11000000060313'
 OR coep."OBJNR" = 'KS11000000060322'
 OR coep."OBJNR" = 'KS11000000060325'
 OR coep."OBJNR" = 'KS11000000060331'
 OR coep."OBJNR" BETWEEN 'KS11000000060336' AND 'KS11000000060337'
 OR coep."OBJNR" BETWEEN 'KS11000000060339' AND 'KS11000000060340'
 OR coep."OBJNR" BETWEEN 'KS11000000060344' AND 'KS11000000060366'
 OR coep."OBJNR" = 'KS11000000060368'
 OR coep."OBJNR" = 'KS11000000060371'
 OR coep."OBJNR" BETWEEN 'KS11000000060382' AND 'KS11000000060400'
 OR coep."OBJNR" BETWEEN 'KS11000000060405' AND 'KS11000000060415'
 OR coep."OBJNR" BETWEEN 'KS11000000060422' AND 'KS11000000060429'
 OR coep."OBJNR" BETWEEN 'KS11000000060437' AND 'KS11000000060438'
 OR coep."OBJNR" = 'KS11000000060440'
 OR coep."OBJNR" BETWEEN 'KS11000000060442' AND 'KS11000000060447'
 OR coep."OBJNR" = 'KS11000000060484'
 OR coep."OBJNR" BETWEEN 'KS11000000060652' AND 'KS11000000060653'
 OR coep."OBJNR" BETWEEN 'KS11000000060658' AND 'KS11000000060659'
 OR coep."OBJNR" = 'KS11000000060661'
 OR coep."OBJNR" BETWEEN 'KS11000000060683' AND 'KS11000000060692'
 OR coep."OBJNR" BETWEEN 'KS11000000060701' AND 'KS11000000060702'
 OR coep."OBJNR" = 'KS11000000060706'
 OR coep."OBJNR" = 'KS11000000060708'
 OR coep."OBJNR" = 'KS11000000060715'
 OR coep."OBJNR" BETWEEN 'KS11000000060721' AND 'KS11000000060723'
 OR coep."OBJNR" = 'KS11000000060805'
 OR coep."OBJNR" BETWEEN 'KS11000000060841' AND 'KS11000000060880'
 OR coep."OBJNR" = 'KS11000000060886'
 OR coep."OBJNR" BETWEEN 'KS11000000060888' AND 'KS11000000060891'
 OR coep."OBJNR" BETWEEN 'KS11000000060894' AND 'KS11000000060895'
 OR coep."OBJNR" BETWEEN 'KS11000000060922' AND 'KS11000000060923'
 OR coep."OBJNR" = 'KS11000000060925'
 OR coep."OBJNR" = 'KS11000000060977'
 OR coep."OBJNR" BETWEEN 'KS11000000062160' AND 'KS11000000062165'
 OR coep."OBJNR" BETWEEN 'KS11000000062167' AND 'KS11000000062170'
 OR coep."OBJNR" BETWEEN 'KS11000000062172' AND 'KS11000000062173'
 OR coep."OBJNR" = 'KS11000000062175'
 OR coep."OBJNR" = 'KS11000000062177'
 OR coep."OBJNR" = 'KS11000000062179'
 OR coep."OBJNR" BETWEEN 'KS11000000062190' AND 'KS11000000062193'
 OR coep."OBJNR" BETWEEN 'KS11000000062218' AND 'KS11000000062219'
 OR coep."OBJNR" = 'KS11000000062241'
 OR coep."OBJNR" = 'KS11000000062244'
 OR coep."OBJNR" = 'KS11000000062251'
 OR coep."OBJNR" = 'KS11000000062296'
 OR coep."OBJNR" = 'KS11000000062302'
 OR coep."OBJNR" = 'KS11000000062308'
 OR coep."OBJNR" = 'KS11000000062313'
 OR coep."OBJNR" = 'KS11000000062331'
 OR coep."OBJNR" BETWEEN 'KS11000000062336' AND 'KS11000000062337'
 OR coep."OBJNR" BETWEEN 'KS11000000062339' AND 'KS11000000062340'
 OR coep."OBJNR" = 'KS11000000062354'
 OR coep."OBJNR" = 'KS11000000062366'
 OR coep."OBJNR" = 'KS11000000062368'
 OR coep."OBJNR" = 'KS11000000062382'
 OR coep."OBJNR" = 'KS11000000062388'
 OR coep."OBJNR" = 'KS11000000062405'
 OR coep."OBJNR" = 'KS11000000062407'
 OR coep."OBJNR" = 'KS11000000062440'
 OR coep."OBJNR" = 'KS11000000062683'
 OR coep."OBJNR" = 'KS11000000062692'
 OR coep."OBJNR" = 'KS11000000062708'
 OR coep."OBJNR" BETWEEN 'KS11000000062722' AND 'KS11000000062723'
 OR coep."OBJNR" = 'KS11000000062749'
 OR coep."OBJNR" = 'KS11000000062805'
 OR coep."OBJNR" = 'KS11000000062810'
 OR coep."OBJNR" = 'KS11000000062841'
 OR coep."OBJNR" = 'KS11000000062844'
 OR coep."OBJNR" BETWEEN 'KS11000000062879' AND 'KS11000000062895'
 OR coep."OBJNR" = 'KS11000000064800'
 OR coep."OBJNR" BETWEEN 'KS11000000064803' AND 'KS11000000064805'
 OR coep."OBJNR" = 'KS11000000068741'
 OR coep."OBJNR" BETWEEN 'KL11000000060101700001' AND 'KL11000000060101814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060109710000' AND 'KL11000000060111814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060114700001' AND 'KL11000000060114814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060160700001' AND 'KL11000000060165814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060167700001' AND 'KL11000000060170814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060172700001' AND 'KL11000000060173814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060175700001' AND 'KL11000000060175814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060177700001' AND 'KL11000000060177814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060179700001' AND 'KL11000000060179814340'
 OR coep."OBJNR" BETWEEN 'KL11000000060202814195' AND 'KL11000000060204814251'
 OR coep."OBJNR" BETWEEN 'KL11000000060218814195' AND 'KL11000000060219814251'
 OR coep."OBJNR" BETWEEN 'KL11000000060241814195' AND 'KL11000000060241814251'
 OR coep."OBJNR" BETWEEN 'KL11000000060244814195' AND 'KL11000000060251814251'
 OR coep."OBJNR" BETWEEN 'KL11000000060270814195' AND 'KL11000000060271814258'
 OR coep."OBJNR" BETWEEN 'KL11000000060273814251' AND 'KL11000000060275814258'
 OR coep."OBJNR" BETWEEN 'KL11000000060291814195' AND 'KL11000000060296814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060302814195' AND 'KL11000000060302814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060308814195' AND 'KL11000000060308814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060310814195' AND 'KL11000000060310814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060322814195' AND 'KL11000000060322814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060325814195' AND 'KL11000000060325814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060331814195' AND 'KL11000000060331814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060336814195' AND 'KL11000000060337814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060339814195' AND 'KL11000000060366814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060368814195' AND 'KL11000000060368814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060371814195' AND 'KL11000000060371814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060382814195' AND 'KL11000000060415814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060422814195' AND 'KL11000000060438814197'
 OR coep."OBJNR" = 'KL11000000060440814197'
 OR coep."OBJNR" = 'KL11000000060484814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060652814195' AND 'KL11000000060653814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060683814195' AND 'KL11000000060692814330'
 OR coep."OBJNR" BETWEEN 'KL11000000060701730000' AND 'KL11000000060702814197'
 OR coep."OBJNR" BETWEEN 'KL1100000006070673003' AND 'KL11000000060706814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060715814195' AND 'KL11000000060721814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060805814195' AND 'KL11000000060880814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060886814195' AND 'KL11000000060886814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060888814195' AND 'KL11000000060890814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060894814195' AND 'KL11000000060894814197'
 OR coep."OBJNR" BETWEEN 'KL11000000060977814195' AND 'KL11000000060977814197'
 OR coep."OBJNR" BETWEEN 'KL11000000064800740101' AND 'KL11000000064800814197'
 OR coep."OBJNR" BETWEEN 'KL11000000068741700102' AND 'KL11000000068741814310'
 )
  AND 
      (
      coep."KSTAR" BETWEEN '0030512001' AND '0081005603'
       )

),

functional_locations AS (

WITH cte_func_loc_12 AS (

SELECT
   iflot."TPLNR" AS functional_location,
   --iflotx."PLTXT" AS descr_of_functional_location,
   CASE 
        WHEN iflotx_e."PLTXT" IS NOT NULL 
         AND iflotx_e."PLTXT" != '0' 
         AND TRIM(iflotx_e."PLTXT") != '' 
        THEN iflotx_e."PLTXT"
        ELSE iflotx_f."PLTXT"
    END as descr_of_functional_location,
   klah.class   AS class,
   swor."KSCHL" AS class_description,
   iflot."EQART" AS object,
   t370k_t."EARTX" AS object_description,
   iflot."FLTYP" AS category,
   tj30t."TXT04" AS user_status,
   CASE iflot."FLTYP"
        WHEN 'A' THEN 'ANALYZERS'
        WHEN 'E' THEN 'ELECTRICAL'
        WHEN 'F' THEN 'FACILITIES'
        WHEN 'H' THEN 'HSE'
        WHEN 'I' THEN 'INSTRUMENTATION & CONTROLS'
        WHEN 'M' THEN 'MECHANICAL/STATIC'
        WHEN 'N' THEN 'NON-SPECIFIC'
        WHEN 'P' THEN 'PIPING'
        WHEN 'R' THEN 'ROTATING MACHINERY'
        WHEN 'V' THEN 'ROLLING EQUIPMENT'
        ELSE 'NON-MAINTAINABLE ITEMS'
    END AS category_description,
    iloa."ABCKZ" AS ABC_indicator,
    CASE iloa."ABCKZ"
        WHEN 'A' THEN 'High Criticality(A)'
        WHEN 'B' THEN 'Medium Criticality(B)'
        WHEN 'C' THEN 'Low Criticality(C)'
        ELSE 'Criticality Not Applicable(Z)'
    END AS ABC_indicator_description
FROM
    "GSAP"."IFLOT" iflot    
--JOIN 
    --"GSAP"."IFLOTX" iflotx ON iflotx."TPLNR" = iflot."TPLNR"
                       -- AND iflotx."SPRAS" = 'E' 	
LEFT JOIN 
    "GSAP"."IFLOTX" iflotx_e ON iflotx_e."TPLNR" = iflot."TPLNR"
                             AND iflotx_e."SPRAS" = 'E'
LEFT JOIN 
    "GSAP"."IFLOTX" iflotx_f ON iflotx_f."TPLNR" = iflot."TPLNR"
                             AND iflotx_f."SPRAS" = 'F'
JOIN
    "GSAP"."ILOA" ILOA ON iloa."ILOAN" = iflot."ILOAN"
LEFT JOIN
   "GSAP"."KSSK" kssk  ON iflot."TPLNR" = kssk."OBJEK" AND
                       kssk."STDCL" = 'X'
                       AND kssk.zzslt_flag != 'D'
LEFT JOIN
  "GSAP"."KLAH" klah ON kssk."CLINT" = klah."CLINT"
LEFT JOIN "GSAP"."SWOR" swor ON kssk."CLINT" = swor."CLINT" AND
                                  swor."SPRAS" = 'E'
LEFT JOIN "GSAP"."T370K" t370k ON iflot."EQART" = t370k."EQART"
LEFT JOIN "GSAP"."T370K_T" t370k_t ON t370k."EQART"   = t370k_t."EQART" AND
                                        t370k_t."SPRAS" = 'E'  
LEFT JOIN "GSAP"."JEST" jest ON iflot."OBJNR" = jest."OBJNR"
                   AND jest."INACT" != 'X'
                   AND jest."STAT" LIKE 'E%'-- current status
                --   AND jest."STAT" NOT IN ('E0041', 'E0042')
LEFT JOIN "GSAP"."TJ30T" tj30t ON jest."STAT" = tj30t."ESTAT"
                   AND tj30t."STSMA" = 'UKGB'
                   AND tj30t."SPRAS" = 'E'
)     
             
                   
SELECT cte_func_loc_12.functional_location,
       cte_func_loc_12.descr_of_functional_location,   
       cte_func_loc_12.class,
       cte_func_loc_12.class_description,
       cte_func_loc_12.object,
       cte_func_loc_12.object_description,
       cte_func_loc_12.category,
       cte_func_loc_12.category_description,
       cte_func_loc_12.ABC_indicator,
       cte_func_loc_12.ABC_indicator_description,
          ARRAY_JOIN(
            ARRAY_AGG(
                CONCAT(cte_func_loc_12.user_status, ' ')
            ORDER BY cte_func_loc_12.user_status
            ), ' '
        ) AS user_statuses
FROM cte_func_loc_12
GROUP BY 1,2,3,4,5,6,7,8,9,10
ORDER BY functional_location
)

SELECT
    coalesce( aufk."AUFNR", query_from_co_object.document_number ) AS order_id,
    coalesce( aufk."KTEXT", query_from_co_object.document_description ) AS order_description,
    query_from_co_object.purchasing_document,
    query_from_co_object.material as material_id,
    query_from_co_object.posting_month,  
    query_from_co_object.fiscal_year,
    query_from_co_object.cost_element,
    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN 
           ( '0039221100', '0039212015' ) 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS STORE,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN (
    '0032019000'
    ) 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS LABOR,

    ROUND(SUM(CASE 
    --WHEN query_from_co_object.cost_element IN (
      --'0032019033', '0032019034', '0032019035',
      --'0032019036', '0032019037', '0032019038',
      --'0039212017', '0032017007'
    --)
   -- AND  query_from_co_object.material IS NOT NULL
    --AND query_from_co_object.material <> '0'
    --AND TRIM(query_from_co_object.material) <> ''
    --THEN query_from_co_object.amount 
   
    WHEN query_from_co_object.cost_element IN (
      '0039212016', '0032019003'
    )
    THEN query_from_co_object.amount
    ELSE 0
  END), 2) AS MATERIAL,

    ROUND(SUM(CASE 
    --WHEN query_from_co_object.cost_element IN (
      --'0032019033', '0032019034', '0032019035',
      --'0032019036', '0032019037', '0032019038',
      --'0039212017', '0032017007'
    --)
    --AND ( query_from_co_object.material IS NULL
   -- OR query_from_co_object.material = '0'
    --OR TRIM(query_from_co_object.material) = '' )
    --THEN query_from_co_object.amount
    
    WHEN query_from_co_object.cost_element IN (
      '0032019002', '0032019009'
    )
    THEN query_from_co_object.amount
    ELSE 0
  END), 2) AS SERVICE,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN ('0039213004')

        THEN query_from_co_object.amount ELSE 0 END), 2) AS RENTAL,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element LIKE '0081%' 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS OTHER,

    ROUND(SUM(query_from_co_object.amount), 2) AS TOTAL,   

    coalesce( aufk."AUART", query_from_co_object.document_type ) AS order_type,
    CASE 
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'AA' THEN 'Asset posting'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'AB' THEN 'Accounting document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'AF' THEN 'Dep. postings'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'DA' THEN 'Customer document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'EC' THEN 'Expense Claim CONCUR'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'ER' THEN 'Expense Rvrsl CONCUR'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'I0' THEN 'SN Fakturen'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'I8' THEN 'AMEXCO'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'I9' THEN 'Pisa Salaries'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'KA' THEN 'Vendor document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'KG' THEN 'Vendor credit memo'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'KR' THEN 'Vendor invoice'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'OF' THEN 'G/L ACCRUALS'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'OK' THEN 'G/L ACCRUAL REVERSAL'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'RE' THEN 'Inv. Purch. SC'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'SA' THEN 'G/L account document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'S4' THEN 'Balance Takeover'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'WA' THEN 'Goods issue'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'WE' THEN 'Goods receipt'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'WI' THEN 'Inventory document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'Y9' THEN 'Sundry sale Document'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'PM01' THEN 'Maintenance'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'PM02' THEN 'Plans & Schedules'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'PM05' THEN 'Project'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'GB41' THEN 'CTR Orders'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'RM01' THEN 'Production Cost Collector'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'PP01' THEN 'Standard Production Order SCP'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = 'ZW01' THEN 'PO for rework NTC goods SCP'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = '300' THEN 'Invest.: Underpos.expensed'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = '800' THEN 'Restrukturierung'
        WHEN coalesce( aufk."AUART", query_from_co_object.document_type ) = '950' THEN 'Übrige Aufträge'
        ELSE 'Unknown'
    END AS order_type_description,
    
    
    afih."PRIOK" AS priority,
    afih."REVNR" AS revision,
    afih."WARPL" AS maintenance_plan,
    afih."ILART" AS main_activity_type,
     CASE 
        WHEN afih."ILART" = 'Z10' THEN 'Reactive HSE Repair'
        WHEN afih."ILART" = 'Z11' THEN 'Reactive Non-HSE Repair'
        WHEN afih."ILART" = 'Z12' THEN 'Proactive Repair from HSE PM'
        WHEN afih."ILART" = 'Z13' THEN 'Proactive Repair from PdM'
        WHEN afih."ILART" = 'Z14' THEN 'Proactive Repair from Non-HSE PM'
        WHEN afih."ILART" = 'Z20' THEN 'Proactive Mods / Improvements'
        WHEN afih."ILART" = 'Z30' THEN 'Preventive (PM) HSE'
        WHEN afih."ILART" = 'Z31' THEN 'Preventive (PM) non-HSE'
        WHEN afih."ILART" = 'Z32' THEN 'Predictive (PdM)'
        WHEN afih."ILART" = 'Z40' THEN 'Proactive Refurbish / Replace'
        WHEN afih."ILART" = 'Z50' THEN 'Production Support Activities'
        WHEN afih."ILART" = 'Z60' THEN 'Training / Meetings / Admin'
        ELSE 'Unknown'
    END AS MAT_description,
   -- iloa."TPLNR" AS functional_location,
    iloa."BEBER" AS plant_section,
    CASE 
        WHEN iloa."BEBER"  IN ( '271', '311' ) THEN 'Ingénierie'
        WHEN iloa."BEBER" IN ( '317', '328', '337', '343', '349', '351', '352', '358', '371', '382','389', '398',
        '399', '415', '454', '267', '268', '313', '314', '344', '353', '370', '396', '397', '416' ) THEN 'AIP'
        WHEN iloa."BEBER" IN ( '334', '363', '452', '453', '302', '350' ) THEN 'NAIS'
        WHEN iloa."BEBER" IN ( '342', '442' ) THEN 'Logistics'
        WHEN iloa."BEBER" = '400' THEN 'Contrôle qualité'
        WHEN iloa."BEBER" = '440' THEN 'Site Services'
        WHEN iloa."BEBER" IN ( '421', '455' ) THEN 'Transports'
        ELSE 'Unknown'
    END AS unit,

    CASE 
        WHEN iloa."BEBER" IN ( '271', '311' ) THEN 'Ingénierie'
        WHEN iloa."BEBER" IN ( '317', '328', '337', '454', '344' ) THEN 'Secteur 317/ 337/ 454/ 344'
        WHEN iloa."BEBER" IN ( '334', '452', '453', '350' ) THEN 'Secteur 334/ 452/ 453/ 302'
        WHEN iloa."BEBER" = '342' THEN 'B342 stockage matières premières'
        WHEN iloa."BEBER" IN ( '343', '389', '268', '313', '314', '370' ) THEN 'Chemical services'
        WHEN iloa."BEBER" = '349' THEN 'RTO - STRATOPAIR_Monthey'
        WHEN iloa."BEBER" IN ( '351', '382', '353' ) THEN 'Secteur 351/ 353/ 382/'
        WHEN iloa."BEBER" IN ( '352', '371' ) THEN 'Secteur 352/ 371/ 377'
        WHEN iloa."BEBER" IN ( '398', '396', '397' ) THEN 'Secteur 398'
        WHEN iloa."BEBER" = '399' THEN 'Secteur 399'
        WHEN iloa."BEBER" = '400' THEN 'Contrôle qualité'
        WHEN iloa."BEBER" IN ( '415', '416' ) THEN 'Secteur 415/ 416'
        WHEN iloa."BEBER" = '440' THEN 'Vestiaires'
        WHEN iloa."BEBER" = '442' THEN 'B429/ 442 transports'
        WHEN iloa."BEBER" = '266' THEN 'Secteur 317/ 337/ 344/Secteur 452/363'
        WHEN iloa."BEBER" = '267' THEN 'Secteur 317/ 337/ 344'
        WHEN iloa."BEBER" IN ( '421', '455' ) THEN 'Transports'
        ELSE 'Unknown'
    END AS unit_name,

    aufk."VAPLZ" AS main_work_center,
    CASE 
    WHEN aufk."VAPLZ" IN ( '8317-T', '8334-T', '8337-T', '8343-T', '8351-T', '8352-T', '8358-T', '8363-T', '8371-T', 
    '8382-T', '8398-T', '8399-T', '8415-T', '8452-T', '8454-T', '8440-T', '8271-T' ) THEN 'COORDINATEUR TECHNIQUE'
    WHEN aufk."VAPLZ" IN ( '8317-TL', '8334-TL', '8337-TL', '8343-TL', '8351-TL', '8352-TL', '8358-TL', '8363-TL', 
    '8371-TL', '8382-TL', '8398-TL', '8399-TL', '8415-TL', '8452-TL', '8454-TL' ) THEN 'COORDINATEUR TECHNIQUE CTRL LEGAUX'
    WHEN aufk."VAPLZ" IN ( '8271-I', '8291-I', '8317-I', '8334-I', '8337-I', '8343-I' , '8351-I', '8352-I', 
    '8358-I' , '8363-I', '8371-I', '8382-I', '8398-I', '8399-I', '8400-I', '8415-I', '8442-I', 
    '8452-I', '8454-I', '8302-I', '8342-I', '8440-I', '8429-I', '8355-I' ) THEN 'ENGINEERING'
    WHEN aufk."VAPLZ" IN ( '8440-MAG', '8355-MAG', '8342-MAG' ) THEN 'GROUPE MAGASIN 440/355/376'
    WHEN aufk."VAPLZ" = '8271-PDM' THEN 'INGENIEUR ELECTRICIEN PDM'
    WHEN aufk."VAPLZ" IN ( '8291-E', '8302-E', '8311-E', '8317-E', '8334-E', '8337-E', '8342-E', '8343-E', 
    '8351-E', '8352-E', '8358-E', '8363-E', '8370-E', '8371-E', '8382-E', '8398-E',
    '8399-E', '8415-E', '8440-E', '8452-E', '8454-E', '8271-E', '8365-E', '8425-E',
    '8400-E' ) THEN 'MAINTENANCE ELECTRIC'
    WHEN aufk."VAPLZ" = '8271-N' THEN 'METHODES ELECTRIQUES & BALANCES'
    WHEN aufk."VAPLZ" IN ( '8317-M', '8334-M', '8337-M', '8343-M', '8352-M', '8358-M', '8363-M', 
    '8371-M', '8382-M', '8398-M', '8399-M', '8415-M', '8452-M', '8454-M', '8311-M',
    '8351-M', '8400-M', '8440-M') THEN 'MAINTENANCE MECHANICS'
    WHEN aufk."VAPLZ" ='8415-L' THEN 'LABORATOIRE'
    WHEN aufk."VAPLZ" IN ( '8334-V', '8351-V', '8398-V', '8415-V', '8452-V', '8454-V', '8317-V', 
    '8440-V') THEN 'MAINTENANCE VERRE'
    WHEN aufk."VAPLZ" = '8000-I' THEN 'POSTE DE TRAVAIL POUR GAMME: INGENIERE'
    WHEN aufk."VAPLZ" = '8271-C' THEN 'ENCADREMENT'
    WHEN aufk."VAPLZ" IN ( '8351-F', '8358-F', '8398-F', '8454-F' ) THEN 'PRODUCTION'
    WHEN aufk."VAPLZ" IN ( '8317-R', '8337-R', '8371-R', '8415-R', '8454-R', '8351-R', '8382-R',
    '8398-R') THEN 'TECHNICIEN DE FIABILITE'
    WHEN aufk."VAPLZ" = '8271-D' THEN 'GROUPE METHODES MECANIQUES'
END AS work_center_description,
    iloa."KOSTL" AS cost_center,
    functional_locations.functional_location,
    functional_locations.descr_of_functional_location,   
    functional_locations.class,
    functional_locations.class_description,
    functional_locations.object,
    functional_locations.object_description,
    functional_locations.category,
    functional_locations.category_description,
    functional_locations.ABC_indicator,
    functional_locations.ABC_indicator_description,
    functional_locations.user_statuses
FROM 
   query_from_co_object
LEFT JOIN
  "GSAP"."AUFK" aufk ON aufk."OBJNR" = query_from_co_object.object_number_aufnr 
LEFT JOIN
   "GSAP"."AFIH" afih ON aufk."AUFNR" = afih."AUFNR"
LEFT JOIN
   "GSAP"."AFKO" afko ON aufk."AUFNR" = afko."AUFNR"
LEFT JOIN
   "GSAP"."ILOA" iloa ON afih."ILOAN" = iloa."ILOAN"
LEFT JOIN
   functional_locations ON functional_locations.functional_location = iloa."TPLNR"
  --WHERE aufk."WERKS" IN ('1102', '1352') 
   
GROUP BY
    COALESCE(aufk."AUFNR", query_from_co_object.document_number), coalesce( aufk."KTEXT", query_from_co_object.document_description ),
    coalesce( aufk."AUART", query_from_co_object.document_type ),
    afih."PRIOK", afih."REVNR", afih."WARPL", afih."ILART",
    query_from_co_object.purchasing_document, query_from_co_object.material,
    query_from_co_object.fiscal_year, query_from_co_object.posting_month, query_from_co_object.cost_element,
    iloa."TPLNR", iloa."BEBER", aufk."VAPLZ", iloa."KOSTL",
    functional_locations.functional_location,
    functional_locations.descr_of_functional_location,   
    functional_locations.class,
    functional_locations.class_description,
    functional_locations.object,
    functional_locations.object_description,
    functional_locations.category,
    functional_locations.category_description,
    functional_locations.ABC_indicator,
    functional_locations.ABC_indicator_description,
    functional_locations.user_statuses
HAVING 
    ROUND(SUM(query_from_co_object.amount), 2) != 0.00
ORDER BY
    COALESCE(aufk."AUFNR", query_from_co_object.document_number)
),

filtered_ekpo AS (
    SELECT *
    FROM (
        SELECT matnr, ebeln,
               ROW_NUMBER() OVER (PARTITION BY matnr ORDER BY ebeln) AS rn
        FROM "GSAP"."EKPO" ekpo
        WHERE matnr IN (
            SELECT DISTINCT material_id
            FROM query_wo_vendors
            WHERE material_id IS NOT NULL
              AND material_id <> '0'
              AND TRIM(material_id) <> ''
        )
    ) AS sub
    WHERE rn = 1
)

SELECT q.order_id,
       q.order_description,
       q.purchasing_document,
       q.material_id,
CASE 
  WHEN TRIM(q.purchasing_document) <> '' THEN lfa1."MCOD1"
  WHEN TRIM(q.material_id) <> '' THEN lfa2."MCOD1"
  ELSE NULL
END AS vendor_name,
    q.posting_month,  
    q.fiscal_year,
    q.STORE,
    q.LABOR,
    q.MATERIAL,
    q.SERVICE,
    q.RENTAL,
    q.OTHER,
    q.TOTAL,
    q.order_type,
    q.order_type_description,
    q.priority,
    q.revision,
    q.maintenance_plan,
    q.main_activity_type,
    q.MAT_description,
    q.plant_section,
    q.unit,
    q.unit_name,
    q.main_work_center,
    q.work_center_description,
    q.cost_center,
    q.cost_element,
    q.functional_location,
    q.descr_of_functional_location,   
    q.class,
    q.class_description,
    q.object,
    q.object_description,
    q.category,
    q.category_description,
    q.ABC_indicator,
    q.ABC_indicator_description,
    q.user_statuses
    
FROM query_wo_vendors q
LEFT JOIN "GSAP"."EKKO" ekko1 
    ON q.purchasing_document = ekko1."EBELN"
LEFT JOIN filtered_ekpo e
    ON q.material_id = e.matnr
LEFT JOIN "GSAP"."EKKO" ekko2 
    ON ekko2."EBELN" = e."EBELN"
LEFT JOIN "GSAP"."LFA1" lfa1 
     ON ekko1."LIFNR" = lfa1."LIFNR"
LEFT JOIN "GSAP"."LFA1" lfa2 

    ON ekko2."LIFNR" = lfa2."LIFNR"
--WHERE q.order_type <> 'GB41'    
    
)

SELECT q.order_id,
       q.order_description,
       q.purchasing_document,
       q.material_id,
       q.vendor_name,
       q.posting_month,  
       q.fiscal_year,
       q.STORE,
       q.LABOR,
       q.MATERIAL,
       q.SERVICE,
       q.RENTAL,
       q.OTHER,
       q.TOTAL,
       q.order_type,
       q.order_type_description,
       q.priority,
       q.revision,
       q.maintenance_plan,
       q.main_activity_type,
       q.MAT_description,
       q.plant_section,
       q.unit,
       q.unit_name,
       q.main_work_center,
       q.work_center_description,
       q.cost_center,
       q.cost_element,
       q.functional_location,
       q.descr_of_functional_location,   
       q.class,
       q.class_description,
       q.object,
       q.object_description,
       q.category,
       q.category_description,
       q.ABC_indicator,
       q.ABC_indicator_description,
       q.user_statuses
    
FROM query_w_vendors q
--WHERE order_type <> 'PM05'