WITH OrderDetails AS (
    SELECT
        aufk."AUFNR" AS "Order",
        afvc."VORNR" AS "Activity",
     --   afru."LEARR" as "ActivityCode",
        iloa."BEBER" as "plant_section",
    CASE 
        WHEN iloa."BEBER" = 'H10' THEN 'KIP'
        WHEN iloa."BEBER" = 'H12' THEN 'KIP'
        WHEN iloa."BEBER" = 'H14' THEN 'Plinazolin'
        WHEN iloa."BEBER" = 'H20' THEN 'Misc Inters'
        WHEN iloa."BEBER" = 'H30' THEN 'Paraquat'
        WHEN iloa."BEBER" = 'H40' THEN 'R6'
        WHEN iloa."BEBER" = 'H50' THEN 'R5'
        WHEN iloa."BEBER" = 'H60' THEN 'Reglone'
        WHEN iloa."BEBER" = 'H70' THEN 'MP1'
        WHEN iloa."BEBER" = 'H72' THEN 'MP1'
        WHEN iloa."BEBER" = 'H74' THEN 'MP1'
        WHEN iloa."BEBER" = 'H80' THEN 'ETP'
        WHEN iloa."BEBER" = 'H90' THEN 'Services'
        WHEN iloa."BEBER" = 'H92' THEN 'Infrastructure'
        WHEN iloa."BEBER" = 'H97' THEN 'QC Labs'
        WHEN iloa."BEBER" = 'H98' THEN 'T&E'
        WHEN iloa."BEBER" = 'H99' THEN 'Projects'
        ELSE 'Unknown'
    END AS unit,
        iloa."TPLNR" as "functional_loc",
        crhd."ARBPL" AS "Oper_WorkCenter",
        crhd."OBJID" AS "Work Center Objid",
     -- aufk."VAPLZ" AS "Main WorkCtr",
        aufk."AUART" AS "order_type",
        afih."PRIOK" AS "Priority",
        afih."ILART" AS "MAT",
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
        afih."REVNR" AS "Revision",
        array_join(array_agg(DISTINCT tj30t."TXT04"),' ') AS "Order_User_Status",
        array_join(array_agg(DISTINCT tj02t."TXT04"),' ') AS "Order_System_Status",
        array_join(array_agg(DISTINCT tj02t_systat."TXT04"),' ') AS "Operation_System_Status",
        afvv."ARBEI" AS "Work", 
        CASE 
         WHEN afvv."IEDD" = '00000000' THEN NULL  
         ELSE date_format(date_parse(afvv."IEDD", '%Y%m%d'), '%d/%m/%Y') 
        END AS "Lat.Start_Date",
        CASE 
         WHEN afvv."SSEDD" = '00000000' THEN NULL  
         ELSE date_format(date_parse(afvv."SSEDD", '%Y%m%d'), '%d/%m/%Y')
        END AS "Lat.Finish_Date",
        afru."ISMNW" AS "Booked time",
        afru."BUDAT" AS "Posting date",
        afru."ERNAM" AS "Posted by",
        afru."LEARR" AS "ActivityCode",
        afru."GRUND" AS "Reason Code"

    FROM "GSAP"."AUFK" aufk
    JOIN "GSAP"."AFKO" afko ON aufk."AUFNR" = afko."AUFNR"
    JOIN "GSAP"."AFIH" afih ON aufk."AUFNR" = afih."AUFNR"
    JOIN "GSAP"."AFVV" afvv ON afvv."AUFPL" = afko."AUFPL"
    JOIN "GSAP"."AFVC" afvc ON afvc."AUFPL" = afvv."AUFPL"
        AND afvc."APLZL" = afvv."APLZL"
    JOIN "GSAP"."AFRU" afru ON afru."AUFPL" = afvc."AUFPL"
        AND afru."APLZL" = afvc."APLZL"
    JOIN "GSAP"."ILOA" iloa on iloa."ILOAN" = afih."ILOAN"
    	AND iloa."TPLNR" like '12%'
    JOIN "GSAP"."IFLOT" iflot ON iflot."TPLNR" = iloa."TPLNR"
    JOIN "GSAP"."CRHD" crhd ON crhd."OBJID" = afvc."ARBID"
	JOIN "GSAP"."JEST" jest_ukgb ON jest_ukgb."OBJNR" = iflot."OBJNR"
    	AND jest_ukgb."INACT" <> 'X'
    LEFT OUTER JOIN "GSAP"."TJ30T" ukgb_status_tj30t ON jest_ukgb."STAT" = ukgb_status_tj30t."ESTAT"
    	AND ukgb_status_tj30t."SPRAS" = 'E'
    	AND ukgb_status_tj30t."STSMA" = 'UKGB'
    JOIN "GSAP"."JEST" jest_e ON jest_e."OBJNR" = aufk."OBJNR"
        AND jest_e."INACT" <> 'X'
        AND jest_e."STAT" LIKE 'E%'
    LEFT JOIN "GSAP"."TJ30T" tj30t ON tj30t."ESTAT" = jest_e."STAT"
        AND tj30t."SPRAS" = 'E'
        AND (tj30t."STSMA" = 'PMPG' OR tj30t."STSMA" = 'PMSP')
    JOIN "GSAP"."JEST" jest_i ON jest_i."OBJNR" = aufk."OBJNR"
        AND jest_i."INACT" <> 'X'
        AND jest_i."STAT" LIKE 'I%'
    JOIN "GSAP"."TJ02T" tj02t ON tj02t."ISTAT" = jest_i."STAT"
        AND tj02t."SPRAS" = 'E'
        and (tj02t."TXT04" = 'CRTD' OR tj02t."TXT04" = 'REL')
    JOIN "GSAP"."JEST" jest_systat ON jest_systat."OBJNR" = afvc."OBJNR"
        AND jest_systat."INACT" <> 'X'
        AND jest_systat."STAT" LIKE 'I%'
    LEFT JOIN "GSAP"."TJ02T" tj02t_systat ON tj02t_systat."ISTAT" = jest_systat."STAT"
        AND tj02t_systat."SPRAS" = 'E'
    WHERE 
    aufk."WERKS" = '5001'
    AND afru."BUDAT" >= '20250101'
    AND afru."BUDAT" <> '00000000'
    
    GROUP BY 
        aufk."AUFNR", afvc."VORNR", iloa."BEBER", iloa."TPLNR", crhd."ARBPL", crhd."OBJID", aufk."AUART",  afih."PRIOK",
        afih."ILART", afih."REVNR",  afvv."ARBEI",  afvv."IEDD", afvv."SSEDD", afru."ISMNW", afru."BUDAT", afru."ERNAM",
        afru."LEARR", afru."GRUND" 
        
    --    aufk."KTEXT",aufk."VAPLZ",aufk."AUART",afih."PRIOK", afih."ILART",afko."GSTRP",afko."GLTRP",iloa."ABCKZ",
    --    afko."GSTRS",afko."GLTRS",",aufk."ERDAT",aufk."ERNAM",afih."REVNR",afih."QMNUM",tj02t."TXT04"
),

Capacities AS (
SELECT crhd."OBJID" as object_id,
       crca."KAPID" as capacity_id,
       kako."BEGZT" as start_time,
       kako."ENDZT" as finish_time,
       kako."PAUSE" as break_time,
       kako."AZNOR" as no_of_individual_capacities,
       kako."NGRAD" as capacity_utilization,
CAST(
  (
    (
      ( CAST(kako."ENDZT" AS DECIMAL(10,2)) - CAST(kako."BEGZT" AS DECIMAL(10,2)) ) / 3600
    )
    * ( CAST(kako."NGRAD" AS DECIMAL(5,2)) / 100 )
    * CAST(kako."AZNOR" AS DECIMAL(5,2))
  ) AS DECIMAL(15,2)
) AS "CAPACITY"

     FROM
      "GSAP"."CRHD" crhd
     JOIN
      "GSAP"."CRCA" crca ON
      crhd."OBJID" = crca."OBJID" AND
      crca."OBJTY" = 'A'
     JOIN
     "GSAP"."KAKO" kako ON
     crca."KAPID" = kako."KAPID"
     WHERE crhd."WERKS" = '5001' and CRCA."CANUM" = '0512'

)


SELECT  
    od."Order",
    od."Activity",
    od."plant_section",
    od."unit",
    od."functional_loc",
    od."Oper_WorkCenter",
    od."order_type",
    od."Priority",
    od."MAT",
    od."MAT_description",
    od."Revision",
    od."Order_User_Status",
    od."Order_System_Status",
    od."Operation_System_Status",
    od."Work",
    od."Lat.Start_Date",
    od."Lat.Finish_Date", 
    od."Booked time",
    od."Posting date",
    od."Posted by",
    od."ActivityCode",
    od."Reason Code",
    cp."Capacity"
    
--    od."Description",
 --   od."Main WorkCtr",
 --   od."Functional loc.",
 --   od."System Status",
 --   od."User Status",
 --   od."Basic Start",
 --   od."Basic Finish",
 --   od."Scheduled Start",
 --   od."Scheduled Finish",
 --   od."Created on",
 --   od."Created by",
 --   od."Notification",
 --   od."FL User Status",
 --   od."ABC Indicator",
 --   od."Plant Section"
FROM OrderDetails od
LEFT JOIN Capacities cp on od."Work Center Objid" = cp.object_id
ORDER BY   od."Order", od."Activity"