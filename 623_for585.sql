-- last version of 585 query, 

WITH query_from_co_object AS (
    SELECT
        EXTRACT(MONTH FROM DATE_PARSE(cobk."BUDAT", '%Y%m%d')) AS posting_month,  
        coep."BELNR"  AS document_number,
        cobk."BLTXT"  AS document_description,
        cobk."BLART"  AS document_type,
        coep."EBELN"  AS purchasing_document,
        coep."MATNR"  AS material_id,
        cobk."GJAHR"  AS fiscal_year,
        coep."OBJNR"  AS object_number,
        coep."WKGBTR" AS amount,
        coep."KSTAR"  AS cost_element,
         CASE coep."KSTAR"
            WHEN '0000271000' THEN 'Rep & Maint Site Work'
            WHEN '0000274000' THEN 'Repair & Maintenance - Building Equipmen'
            WHEN '0000275000' THEN 'Rep & Maint Mach & Equip.'
            WHEN '0000275100' THEN 'Rep & Maint Elect Equip.'
            WHEN '0000275600' THEN 'On-site Repairs'
            WHEN '0000276000' THEN 'Rep & Maint Lab Equip.'
            WHEN '0000279000' THEN 'Rep & Maint Trucks'
            WHEN '0000279100' THEN 'Rep & Maint Bldg'
            WHEN '0000279200' THEN 'Rep & Maint Work'
            WHEN '0000312000' THEN 'Rent-Equipment'
            WHEN '0000332000' THEN 'Tools And Tools Repair'
            WHEN '0000332500' THEN 'Repair & Maint Supplies'
            WHEN '0000332600' THEN 'Repair & Maint.Supplies C'
            WHEN '0000800303' THEN 'Maintenance Variance Omaha'
        END AS cost_element_description,
         CASE coep."OBJNR"
        WHEN 'KSCROPSE726300' THEN 'Laboratory'
        WHEN 'KSCROPSE720600' THEN 'AZ SC formulation'
        WHEN 'KSCROPSE726200' THEN 'Maintenance-Labor'
        WHEN 'KSCROPSE725200' THEN 'Building & Grounds'
        WHEN 'KSCROPSE720200' THEN 'SL Formulation'
        WHEN 'KSCROPSE727000' THEN 'Technical & Projects'
        WHEN 'KSCROPSE721300' THEN 'SC Formulation'
        WHEN 'KSCROPSE726000' THEN 'Shipping & Receiving'
        WHEN 'KSCROPSE721100' THEN 'Liquid Pack IFSC/PP'
        WHEN 'KSCROPSE720400' THEN 'Bulk loading'
        WHEN 'KSCROPSE720700' THEN 'SC Formulation'
        WHEN 'KSCROPSE725400' THEN 'Water Treatment/Environmental'
        WHEN 'KSCROPSE721400' THEN 'EC Formulation'
        WHEN 'KSCROPSE720300' THEN 'Liquid Pack Herbicides'
        WHEN 'KSCROPSE721500' THEN 'Mini-bulk IFSC/fungicides/PP'
        WHEN 'KSCROPSE720800' THEN 'Liquid Pack Fungicides'
        WHEN 'KSCROPSE721000' THEN 'Mini-bulk herbicides'
        WHEN 'KSCROPSE725700' THEN 'Plant Manager'
        WHEN 'KSCROPSE725900' THEN 'HSE'
        WHEN 'KSCROPSE726500' THEN 'Production'
        WHEN 'KSCROPSE721200' THEN 'Fungicide formulation'
    END AS cost_center_description
    FROM
        "NSAP"."COEP" coep
    JOIN
        "NSAP"."COBK" cobk 
        ON coep."KOKRS" = cobk."KOKRS"
        AND coep."BELNR" = cobk."BELNR"
        AND coep."GJAHR" = cobk."GJAHR"
    WHERE
        coep."LEDNR" = '00'
        AND cobk."BUDAT" <= '20200101'
        AND coep."WRTTP" IN ('04', '11')
        AND coep."VERSN" = '000'
        AND coep."KOKRS" = 'CROP'
        
        AND coep."OBJNR" IN (
            'KSCROPSE726300', 'KSCROPSE720600', 'KSCROPSE726200', 'KSCROPSE725200',
            'KSCROPSE720200', 'KSCROPSE727000', 'KSCROPSE721300', 'KSCROPSE726000',
            'KSCROPSE721100', 'KSCROPSE720400', 'KSCROPSE720700', 'KSCROPSE725400',
            'KSCROPSE721400', 'KSCROPSE720300', 'KSCROPSE721500', 'KSCROPSE720800',
            'KSCROPSE721000', 'KSCROPSE725700', 'KSCROPSE725900', 
            'KSCROPSE726500', 'KSCROPSE721200'
        )
        AND coep."KSTAR" IN (
             '0000276000','0000332500','0000279200','0000332000',
            '0000332600','0000275600','0000274000', '0000275000',
            '0000312000', '0000279000', '0000275100',
            '0000271000','0000279100','0000800303'
        )
)

SELECT
   
    SUBSTRING(query_from_co_object.object_number, 9) AS cost_center,
    query_from_co_object.cost_center_description,
    query_from_co_object.posting_month,  
    query_from_co_object.fiscal_year,
    query_from_co_object.cost_element,
    query_from_co_object.cost_element_description,
    query_from_co_object.document_type,
    query_from_co_object.material_id,
    
    
    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN 
           ('0000332600') 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS STORE,

    -- ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN ( )
    --     THEN query_from_co_object.amount ELSE 0 END), 2) AS LABOR,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element = '0000332500' 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS MATERIAL,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN ( '0000274000', '0000275000','0000275100',
    '0000276000', '0000279200', '0000332000', '0000275600', '0000279000' )
        THEN query_from_co_object.amount ELSE 0 END), 2) AS SERVICE,

    ROUND(SUM(CASE WHEN query_from_co_object.cost_element IN ( '0000312000' ) 
        THEN query_from_co_object.amount ELSE 0 END), 2) AS RENTAL,
        
    ROUND(SUM(CASE 
              WHEN query_from_co_object.cost_element IN ( '0000800303', '0000279100' )
        THEN query_from_co_object.amount ELSE 0 END), 2) AS OTHER, 
        
        ROUND(SUM(query_from_co_object.amount), 2) AS TOTAL

FROM 
   query_from_co_object
   
GROUP BY
    SUBSTRING(query_from_co_object.object_number, 9),
    query_from_co_object.cost_center_description,
    query_from_co_object.fiscal_year, 
    query_from_co_object.posting_month,
    query_from_co_object.document_type,
    query_from_co_object.cost_element,
    query_from_co_object.material_id,
    query_from_co_object.cost_element_description

HAVING 
    ROUND(SUM(query_from_co_object.amount), 2) != 0.00
    
ORDER BY
    cost_center, fiscal_year, posting_month