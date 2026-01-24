WITH order_data AS (
    SELECT
        aufk."AUFNR" AS order_id,
        aufk."AUART" AS order_type,
        CASE aufk."AUART"
            WHEN 'PM01' THEN 'Maintenance'
            WHEN 'PM06' THEN 'Preventive Maintenance'
            ELSE 'Unknown'
        END AS order_type_description,
        aufk."VAPLZ" AS work_center,
        aufk."WERKS" AS plant,
        aufk."KTEXT" AS order_description,
        aufk."KOSTV" AS cost_center,
        CASE aufk."KOSTV"
            WHEN 'SE726300' THEN 'Laboratory'
            WHEN 'SE720600' THEN 'AZ SC formulation'
            WHEN 'SE726200' THEN 'Maintenance-Labor'
            WHEN 'SE725200' THEN 'Building & Grounds'
            WHEN 'SE720200' THEN 'SL Formulation'
            WHEN 'SE727000' THEN 'Technical & Projects'
            WHEN 'SE721300' THEN 'SC Formulation'
            WHEN 'SE726000' THEN 'Shipping & Receiving'
            WHEN 'SE721100' THEN 'Liquid Pack IFSC/PP'
            WHEN 'SE720400' THEN 'Bulk loading'
            WHEN 'SE720700' THEN 'SC Formulation'
            WHEN 'SE725400' THEN 'Water Treatment/Environmental'
            WHEN 'SE721400' THEN 'EC Formulation'
            WHEN 'SE720300' THEN 'Liquid Pack Herbicides'
            WHEN 'SE721500' THEN 'Mini-bulk IFSC/fungicides/PP'
            WHEN 'SE720800' THEN 'Liquid Pack Fungicides'
            WHEN 'SE721000' THEN 'Mini-bulk herbicides'
            WHEN 'SE725700' THEN 'Plant Manager'
            WHEN 'SE725900' THEN 'HSE'
            WHEN 'SE726500' THEN 'Production'
            WHEN 'SE721200' THEN 'Fungicide formulation'
        END AS cost_center_description,
        aufk."OBJNR" AS order_objnr
    FROM "NSAP"."AUFK" aufk
    WHERE 
        aufk."WERKS" = '0017'
        AND aufk."KOKRS" = 'CROP'
),

order_dates AS (
    SELECT
        afko."AUFNR" AS order_id,
        afko."AUFPL" AS routing_number,
        afko."GSTRP" AS basic_start_date,
        afko."GLTRP" AS basic_finish_date,
        SUBSTRING(afko."GSTRP", 1, 4) AS start_year,
        CAST(SUBSTRING(afko."GSTRP", 5, 2) AS INTEGER) AS start_month  
    FROM "NSAP"."AFKO" afko
),

filtered_orders AS (
    SELECT DISTINCT
        od.order_id
    FROM order_data od
    LEFT JOIN order_dates odt ON od.order_id = odt.order_id
    WHERE (
        odt.basic_start_date IS NULL
        OR odt.basic_start_date >= '20220101'
    )
),

pm_order_info AS (
    SELECT
        afih."AUFNR" AS order_id,
        afih."QMNUM" AS notification,
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
        afih."PRIOK" AS priority,
        afih."REVNR" AS revision,
        afih."ILOAN" AS func_loc_account
    FROM "NSAP"."AFIH" afih
),

functional_location_link AS (
    SELECT
        iloa."ILOAN" AS func_loc_account,
        iloa."TPLNR" AS functional_location,
        iloa."ABCKZ" AS abc_indicator,
        CASE iloa."ABCKZ"
        WHEN 'A' THEN 'High Criticality(A)'
        WHEN 'B' THEN 'Medium Criticality(B)'
        WHEN 'C' THEN 'Low Criticality(C)'
        ELSE 'Criticality Not Applicable(Z)'
    END AS ABC_indicator_description,
        iloa."MSGRP" AS sort_field,
        iloa."BEBER" AS plant_section,
        CASE 
            WHEN iloa."BEBER" = '000' THEN '000'
            WHEN iloa."BEBER" = '100' THEN '100'
            WHEN iloa."BEBER" = '200' THEN '200'
            WHEN iloa."BEBER" = '300' THEN '300'
            WHEN iloa."BEBER" = '400' THEN '400'
            WHEN iloa."BEBER" = '500' THEN '500'
            WHEN iloa."BEBER" = '600' THEN '600'
            WHEN iloa."BEBER" = '700' THEN '700'
            WHEN iloa."BEBER" = '800' THEN '800'
            WHEN iloa."BEBER" = '900' THEN '900'
            ELSE 'UNKNOWN'
        END AS unit,
        CASE 
            WHEN iloa."BEBER" = '000' THEN 'Plant/ Maintenance'
            WHEN iloa."BEBER" = '100' THEN 'Area 100'
            WHEN iloa."BEBER" = '200' THEN 'Area 200'
            WHEN iloa."BEBER" = '300' THEN 'Area 300'
            WHEN iloa."BEBER" = '400' THEN 'Area 400'
            WHEN iloa."BEBER" = '500' THEN 'Area 500'
            WHEN iloa."BEBER" = '600' THEN 'Area 600'
            WHEN iloa."BEBER" = '700' THEN 'Area 700'
            WHEN iloa."BEBER" = '800' THEN 'Area 800'
            WHEN iloa."BEBER" = '900' THEN 'Area 900'
            ELSE 'UNKNOWN'
        END AS unit_name 
    FROM "NSAP"."ILOA" iloa
    WHERE iloa."TPLNR" LIKE 'OM%'
),

functional_location_text AS (
    SELECT
        iflotx."TPLNR" AS functional_location,
        iflotx."PLTXT" AS description_of_functional_location
    FROM "NSAP"."IFLOTX" iflotx
    WHERE iflotx."SPRAS" = 'E'
),

functional_location_details AS (
    SELECT
        iflot."TPLNR" AS functional_location,
        iflot."EQART" AS object_type,
        iflot."FLTYP" AS category,
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
    END AS category_description
    FROM "NSAP"."IFLOT" iflot
    WHERE iflot."TPLNR" LIKE 'OM%'
),

object_type_text AS (
    SELECT
        t370k_t."EQART" AS object_type,
        t370k_t."EARTX" AS object_description
    FROM "NSAP"."T370K_T" t370k_t
    WHERE t370k_t."SPRAS" = 'E'
),

class_data AS (
    SELECT
        kssk."OBJEK" AS functional_location,
        klah."CLASS" AS class,
        swor."KSCHL" AS class_description
    FROM "NSAP"."KSSK" kssk
    JOIN "NSAP"."KLAH" klah 
        ON kssk."CLINT" = klah."CLINT"
    LEFT JOIN "NSAP"."SWOR" swor 
        ON kssk."CLINT" = swor."CLINT"
        AND swor."SPRAS" = 'E'
    WHERE kssk."STDCL" = 'X'
),

work_center_text AS (
    SELECT
        crhd."ARBPL" AS work_center,
        crtx."KTEXT" AS work_center_description
    FROM "NSAP"."CRHD" crhd
    LEFT JOIN "NSAP"."CRTX" crtx 
        ON crhd."OBJID" = crtx."OBJID"
        AND crtx."SPRAS" = 'E'
    WHERE crhd."WERKS" = '0017'
),

operations AS (
    SELECT
        afvc."AUFPL" AS routing_number,
        afvc."VORNR" AS activity
    FROM "NSAP"."AFVC" afvc
),

work_data AS (
    SELECT
        aufk."AUFNR" AS order_id,
        SUM(afvv."ARBEI") AS work,
        SUM(afvv."ISMNW") AS actual_work
    FROM "NSAP"."AUFK" aufk
    JOIN "NSAP"."AFKO" afko ON afko."AUFNR" = aufk."AUFNR"
    JOIN "NSAP"."AFVC" afvc ON afvc."AUFPL" = afko."AUFPL"
    JOIN "NSAP"."AFVV" afvv 
        ON afvv."AUFPL" = afko."AUFPL"
        AND afvv."APLZL" = afvc."APLZL"
    GROUP BY aufk."AUFNR"
),

user_status AS (
    SELECT
        x."OBJNR",
        x.user_status
    FROM (
        SELECT
            jest."OBJNR",
            tj30t."TXT04" AS user_status,
            ROW_NUMBER() OVER (
                PARTITION BY jest."OBJNR"
                ORDER BY jest."CHGNR" DESC
            ) AS rn
        FROM "NSAP"."JEST" jest
        JOIN "NSAP"."TJ30T" tj30t
            ON jest."STAT" = tj30t."ESTAT"
            AND tj30t."SPRAS" = 'E'
        WHERE
            jest."INACT" <> 'X'
            AND jest."STAT" LIKE 'E%'
    ) x
    WHERE x.rn = 1
),

order_materials_mseg AS (
    SELECT DISTINCT
        mseg."AUFNR" AS order_id,
        mseg."MATNR" AS material_id
    FROM "NSAP"."MSEG" mseg
    INNER JOIN filtered_orders fo ON mseg."AUFNR" = fo.order_id
    WHERE 
        mseg."MATNR" IS NOT NULL
        AND mseg."MATNR" <> ''
),

material_descriptions AS (
    SELECT DISTINCT
        makt."MATNR" AS material_id,
        makt."MAKTX" AS material_description
    FROM "NSAP"."MAKT" makt
    WHERE makt."SPRAS" = 'E'
)

SELECT
    od.order_id AS "Order",
    od.order_type AS "Order Type",
    od.order_type_description AS "Order type description",
    od.work_center AS "Work center",
    wct.work_center_description AS "Work center description",
    odt.basic_start_date AS "Basic start date",
    odt.basic_finish_date AS "Basic finish date",
    odt.start_year AS "Order Start Year",
    odt.start_month AS "Order Start Month",
    fll.plant_section AS "Plant section",
    fll.unit AS "Unit",
    fll.unit_name AS "Unit name",
    fll.functional_location AS "Functional Location",
    flt.description_of_functional_location AS "Description of functional location",
    fld.object_type AS "Object",
    ott.object_description AS "Object Description",
    fld.category AS "Category",
    fld.category_description,
    cd.class AS "Class",
    cd.class_description AS "Class Description",
    op.activity AS "Activity",
    wd.work AS "Work",
    wd.actual_work AS "Actual Work",
    pmi.main_activity_type AS "MaintActivityType",
    pmi.MAT_description AS "MAT_description",
    us.user_status AS "User Status",
    pmi.priority AS "Priority",
    fll.abc_indicator AS "ABC indicator",
    fll.ABC_indicator_description,
    pmi.revision AS "Revision",
    od.cost_center AS "Cost Center",
    od.cost_center_description AS "Cost Center description",
    om.material_id AS "Material ID",
    md.material_description AS "Material Description"
    
FROM order_data od
INNER JOIN filtered_orders fo ON od.order_id = fo.order_id
LEFT JOIN order_dates odt 
       ON od.order_id = odt.order_id
LEFT JOIN pm_order_info pmi 
       ON od.order_id = pmi.order_id
LEFT JOIN functional_location_link fll 
       ON pmi.func_loc_account = fll.func_loc_account
LEFT JOIN functional_location_text flt 
       ON fll.functional_location = flt.functional_location
LEFT JOIN functional_location_details fld 
       ON fll.functional_location = fld.functional_location
LEFT JOIN object_type_text ott 
       ON fld.object_type = ott.object_type
LEFT JOIN class_data cd 
       ON fll.functional_location = cd.functional_location
LEFT JOIN work_center_text wct 
       ON od.work_center = wct.work_center
LEFT JOIN operations op 
       ON odt.routing_number = op.routing_number
LEFT JOIN work_data wd 
       ON od.order_id = wd.order_id
LEFT JOIN user_status us 
       ON od.order_objnr = us."OBJNR"
LEFT JOIN order_materials_mseg om
       ON od.order_id = om.order_id
LEFT JOIN material_descriptions md
       ON om.material_id = md.material_id
ORDER BY odt.basic_start_date DESC, od.order_id, om.material_id;