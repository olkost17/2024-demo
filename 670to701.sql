WITH
query_from_co_object AS (
    SELECT
        cobk."BUDAT" AS budat,
        EXTRACT(MONTH FROM DATE_PARSE(cobk."BUDAT", '%Y%m%d')) AS posting_month,

        coep."BELNR"  AS document_number,
        cobk."BLTXT"  AS document_description,
        cobk."BLART"  AS document_type,

        coep."EBELN"  AS purchasing_document,
        coep."MATNR"  AS material_id,

        cobk."GJAHR"  AS fiscal_year,
        coep."OBJNR"  AS object_number,

        CASE
            WHEN STRPOS(coep."OBJNR", 'BR') = 0 THEN NULL
            ELSE
                CASE
                    WHEN REGEXP_LIKE(
                        SUBSTRING(coep."OBJNR", STRPOS(coep."OBJNR", 'BR')),
                        'BR[0-9A-Z]+(PL|PU|PE|PD)'
                    )
                    THEN REGEXP_EXTRACT(
                             SUBSTRING(coep."OBJNR", STRPOS(coep."OBJNR", 'BR')),
                             '(BR[0-9A-Z]+?)(PL|PU|PE|PD)',
                             1
                         )
                    ELSE SUBSTRING(coep."OBJNR", STRPOS(coep."OBJNR", 'BR'))
                END
        END AS cost_center,

        coep."PAROB1" AS object_number_aufnr,

        coep."WOGBTR" AS amount,
        coep."KSTAR"  AS cost_element
    FROM "FNDG"."COEP" coep
    JOIN "FNDG"."COBK" cobk
      ON  coep."KOKRS" = cobk."KOKRS"
      AND coep."BELNR" = cobk."BELNR"
      AND coep."GJAHR" = cobk."GJAHR"
    WHERE
        coep."KOKRS" = '1000'
        AND cobk."BUDAT" >= '20220101'
        AND (
            coep."OBJNR" = 'KS1000BR92AGP200'
            OR coep."OBJNR" = 'KS1000BR92AGP201'
OR coep."OBJNR" = 'KS1000BR92AGP202'
OR coep."OBJNR" = 'KS1000BR92AGP203'
OR coep."OBJNR" = 'KS1000BR92AGP204'
OR coep."OBJNR" = 'KS1000BR92AGP205'
OR coep."OBJNR" = 'KS1000BR92AGP207'
OR coep."OBJNR" = 'KS1000BR92AGP208'
OR coep."OBJNR" = 'KS1000BR92AGP209'
OR coep."OBJNR" = 'KS1000BR92AGP20A'
OR coep."OBJNR" = 'KS1000BR92AGP20B'
OR coep."OBJNR" = 'KS1000BR92AGP20C'
OR coep."OBJNR" = 'KS1000BR92AGP20D'
OR coep."OBJNR" = 'KS1000BR92AGP20E'
OR coep."OBJNR" = 'KS1000BR92AGP20F'
OR coep."OBJNR" = 'KS1000BR92AGP20G'
OR coep."OBJNR" = 'KS1000BR92AGP20I'
OR coep."OBJNR" = 'KS1000BR92AGP20N'
OR coep."OBJNR" = 'KS1000BR92AGP20S'
OR coep."OBJNR" = 'KL1000BR92AGP200PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP200PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP200PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP200PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP200PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP201PD0501'
OR coep."OBJNR" = 'KL1000BR92AGP201PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP201PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP201PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP201PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP201PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP202PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP202PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP202PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP202PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP202PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP203PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP203PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP203PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP203PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP203PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP204PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP204PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP204PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP204PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP204PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP205PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP205PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP205PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP205PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP205PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP207PD0501'
OR coep."OBJNR" = 'KL1000BR92AGP207PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP207PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP207PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP207PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP207PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP208PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP208PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP208PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP208PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP208PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP209PE0501'
OR coep."OBJNR" = 'KL1000BR92AGP209PL0501'
OR coep."OBJNR" = 'KL1000BR92AGP209PU0501'
OR coep."OBJNR" = 'KL1000BR92AGP209PU0502'
OR coep."OBJNR" = 'KL1000BR92AGP209PU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20APE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20APL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20APU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20APU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20APU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20BPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20BPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20BPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20BPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20BPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20CPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20CPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20CPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20CPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20CPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20DPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20DPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20DPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20DPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20DPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20EPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20EPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20EPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20EPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20EPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20FPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20FPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20FPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20FPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20FPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20GPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20GPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20GPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20GPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20GPU0503'
OR coep."OBJNR" = 'KL1000BR92AGP20IPE0501'
OR coep."OBJNR" = 'KL1000BR92AGP20IPL0501'
OR coep."OBJNR" = 'KL1000BR92AGP20IPU0501'
OR coep."OBJNR" = 'KL1000BR92AGP20IPU0502'
OR coep."OBJNR" = 'KL1000BR92AGP20IPU0503'

        )
        AND coep."KSTAR" IN ('0031219202')
),

ekkn_ebeln_to_aufnr AS (
    SELECT
        ekkn."EBELN" AS ebeln,
        CASE
            WHEN COUNT(DISTINCT NULLIF(TRIM(ekkn."AUFNR"), '')) = 1
              THEN MAX(NULLIF(TRIM(ekkn."AUFNR"), ''))
            ELSE NULL
        END AS aufnr
    FROM "FNDG"."EKKN" ekkn
    WHERE ekkn."EBELN" IS NOT NULL
      AND TRIM(ekkn."EBELN") <> ''
    GROUP BY 1
),

query_wo_vendors AS (
    SELECT
        q.document_number,

        CASE
            WHEN aufk_par."AUFNR" IS NOT NULL THEN aufk_par."AUFNR"
            WHEN aufk_ebeln."AUFNR" IS NOT NULL THEN aufk_ebeln."AUFNR"
            ELSE NULL
        END AS order_id,

        CASE
            WHEN aufk_par."AUFNR" IS NOT NULL THEN 'PAROB1(OBJNR)->AUFK'
            WHEN aufk_ebeln."AUFNR" IS NOT NULL THEN 'EBELN->EKKN.AUFNR->AUFK'
            ELSE 'NONE'
        END AS order_id_source,

        COALESCE(aufk_par."KTEXT", aufk_ebeln."KTEXT", q.document_description) AS order_description,

        q.purchasing_document,
        q.material_id,
        q.posting_month,
        q.fiscal_year,
        q.cost_element,
        q.cost_center,

        ROUND(SUM(CASE WHEN q.cost_element IN ('0039221100','0039212015') THEN q.amount ELSE 0 END), 1) AS STORE,
        ROUND(SUM(CASE WHEN q.cost_element IN ('0032019000','0032019004') THEN q.amount ELSE 0 END), 1) AS LABOR,
        ROUND(SUM(CASE WHEN q.cost_element IN ('0039212016','0032019003') THEN q.amount ELSE 0 END), 1) AS MATERIAL,
        ROUND(SUM(CASE WHEN q.cost_element IN ('0032019002','0032019009') THEN q.amount ELSE 0 END), 1) AS SERVICE,
        ROUND(SUM(CASE WHEN q.cost_element IN ('0039213004') THEN q.amount ELSE 0 END), 1) AS RENTAL,
        ROUND(SUM(CASE WHEN q.cost_element LIKE '0081%' THEN q.amount ELSE 0 END), 1) AS OTHER,
        ROUND(SUM(q.amount), 1) AS TOTAL,

        COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) AS order_type,

        CASE
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'AA' THEN 'Asset posting'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'AB' THEN 'Accounting document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'AF' THEN 'Dep. postings'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'DA' THEN 'Customer document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'EC' THEN 'Expense Claim CONCUR'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'ER' THEN 'Expense Rvrsl CONCUR'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'I0' THEN 'SN Fakturen'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'I8' THEN 'AMEXCO'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'I9' THEN 'Pisa Salaries'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'KA' THEN 'Vendor document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'KG' THEN 'Vendor credit memo'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'KR' THEN 'Vendor invoice'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'OF' THEN 'G/L ACCRUALS'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'OK' THEN 'G/L ACCRUAL REVERSAL'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'RE' THEN 'Inv. Purch. SC'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'SA' THEN 'G/L account document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'S4' THEN 'Balance Takeover'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'WA' THEN 'Goods issue'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'WE' THEN 'Goods receipt'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'WI' THEN 'Inventory document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'Y9' THEN 'Sundry sale Document'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'PM01' THEN 'Maintenance'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'PM02' THEN 'Plans & Schedules'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'PM05' THEN 'Project'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'GB41' THEN 'CTR Orders'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'RM01' THEN 'Production Cost Collector'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'PP01' THEN 'Standard Production Order SCP'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = 'ZW01' THEN 'PO for rework NTC goods SCP'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = '300' THEN 'Invest.: Underpos.expensed'
            WHEN COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type) = '800' THEN 'Restrukturierung'
            ELSE 'Unknown'
        END AS order_type_description,

        CAST(NULL AS varchar) AS priority,
        CAST(NULL AS varchar) AS revision,
        CAST(NULL AS varchar) AS maintenance_plan,
        CAST(NULL AS varchar) AS main_activity_type,
        CAST(NULL AS varchar) AS MAT_description,
        CAST(NULL AS varchar) AS plant_section,
        CAST(NULL AS varchar) AS unit,
        CAST(NULL AS varchar) AS unit_name,

        COALESCE(aufk_par."VAPLZ", aufk_ebeln."VAPLZ") AS main_work_center

    FROM query_from_co_object q

    LEFT JOIN "FNDG"."AUFK" aufk_par
      ON TRIM(aufk_par."OBJNR") = TRIM(q.object_number_aufnr)

    LEFT JOIN ekkn_ebeln_to_aufnr e2o
      ON e2o.ebeln = q.purchasing_document
    LEFT JOIN "FNDG"."AUFK" aufk_ebeln
      ON TRIM(aufk_ebeln."AUFNR") = TRIM(e2o.aufnr)

    GROUP BY
        q.document_number,
        CASE
            WHEN aufk_par."AUFNR" IS NOT NULL THEN aufk_par."AUFNR"
            WHEN aufk_ebeln."AUFNR" IS NOT NULL THEN aufk_ebeln."AUFNR"
            ELSE NULL
        END,
        CASE
            WHEN aufk_par."AUFNR" IS NOT NULL THEN 'PAROB1(OBJNR)->AUFK'
            WHEN aufk_ebeln."AUFNR" IS NOT NULL THEN 'EBELN->EKKN.AUFNR->AUFK'
            ELSE 'NONE'
        END,
        COALESCE(aufk_par."KTEXT", aufk_ebeln."KTEXT", q.document_description),
        q.purchasing_document,
        q.material_id,
        q.posting_month,
        q.fiscal_year,
        q.cost_element,
        q.cost_center,
        COALESCE(aufk_par."AUART", aufk_ebeln."AUART", q.document_type),
        COALESCE(aufk_par."VAPLZ", aufk_ebeln."VAPLZ")

    HAVING ROUND(SUM(q.amount), 2) != 0.00
),

filtered_ekpo AS (
    SELECT matnr, ebeln
    FROM (
        SELECT
            ekpo.matnr,
            ekpo.ebeln,
            ROW_NUMBER() OVER (PARTITION BY ekpo.matnr ORDER BY ekpo.ebeln) AS rn
        FROM "FNDG"."EKPO" ekpo
        WHERE ekpo.matnr IN (
            SELECT DISTINCT material_id
            FROM query_wo_vendors
            WHERE material_id IS NOT NULL
              AND material_id <> '0'
              AND TRIM(material_id) <> ''
        )
    ) s
    WHERE rn = 1
),

query_w_vendors AS (
    SELECT
        q.*,
        CASE
            WHEN TRIM(q.purchasing_document) <> '' THEN lfa1."MCOD1"
            WHEN TRIM(q.material_id) <> '' THEN lfa2."MCOD1"
            ELSE NULL
        END AS vendor_name
    FROM query_wo_vendors q
    LEFT JOIN "FNDG"."EKKO" ekko1
      ON q.purchasing_document = ekko1."EBELN"
    LEFT JOIN filtered_ekpo e
      ON q.material_id = e.matnr
    LEFT JOIN "FNDG"."EKKO" ekko2
      ON ekko2."EBELN" = e.ebeln
    LEFT JOIN "FNDG"."LFA1" lfa1
      ON ekko1."LIFNR" = lfa1."LIFNR"
    LEFT JOIN "FNDG"."LFA1" lfa2
      ON ekko2."LIFNR" = lfa2."LIFNR"
)

SELECT
    --order_id,
    --order_id_source,
    order_description AS "document_header_text",
    purchasing_document,
    material_id,
    vendor_name,
    posting_month,
    fiscal_year,
    ROUND(SUM(STORE), 1) AS STORE,
    ROUND(SUM(LABOR), 1) AS LABOR,
    ROUND(SUM(MATERIAL), 1) AS MATERIAL,
    ROUND(SUM(SERVICE), 1) AS SERVICE,
    ROUND(SUM(RENTAL), 1) AS RENTAL,
    ROUND(SUM(OTHER), 1) AS OTHER,
    ROUND(SUM(TOTAL), 1) AS TOTAL,
    order_type,
    order_type_description,
    --priority,
    --revision,
    --maintenance_plan,
    --main_activity_type,
    --MAT_description,
    --plant_section,
    --unit,
    --unit_name,
    --main_work_center,
    cost_center,
     CASE
        WHEN cost_center = 'BR92AGP200' THEN 'SYNTHESIS'
        WHEN cost_center = 'BR92AGP201' THEN 'HNS - Formulation'
        WHEN cost_center = 'BR92AGP202' THEN 'HS - Formulation'
        WHEN cost_center = 'BR92AGP203' THEN 'FW - Formulation'
        WHEN cost_center = 'BR92AGP204' THEN 'FUNGI - Formulation'
        WHEN cost_center = 'BR92AGP205' THEN 'IL - Formulation'
        WHEN cost_center = 'BR92AGP207' THEN 'PEPITE - Formulation'
        WHEN cost_center = 'BR92AGP208' THEN 'SEEDCARE - Formulation'
        WHEN cost_center = 'BR92AGP209' THEN 'HNS - Fill & Pack'
        WHEN cost_center = 'BR92AGP20A' THEN 'HS - Fill & Pack'
        WHEN cost_center = 'BR92AGP20B' THEN 'FW - Fill & Pack'
        WHEN cost_center = 'BR92AGP20C' THEN 'FUNGI - Fill & Pack'
        WHEN cost_center = 'BR92AGP20D' THEN 'IL - Fill & Pack'
        WHEN cost_center = 'BR92AGP20E' THEN 'WP - Fill & Pack - Masipack'
        WHEN cost_center = 'BR92AGP20F' THEN 'WP - Fill & Pack - Fabrima'
        WHEN cost_center = 'BR92AGP20G' THEN 'PEPITE - Fill & Pack'
        WHEN cost_center = 'BR92AGP20I' THEN 'WG - Fill & Pack'
        WHEN cost_center = 'BR92AGP20N' THEN 'Maintenance'
        WHEN cost_center = 'BR92AGP20S' THEN 'Paulinia Building'
        ELSE 'Unknown cost center'
    END AS cost_center_description,
    cost_element, 
    CASE
        WHEN cost_element = '0031219202' THEN 'Out Maint-Bldngs'
        ELSE 'Unknown cost element'
    END AS cost_element_description
FROM query_w_vendors
GROUP BY
    order_description,
    purchasing_document,
    material_id,
    vendor_name,
    posting_month,
    fiscal_year,
    order_type,
    order_type_description,
    cost_center,
    cost_element;