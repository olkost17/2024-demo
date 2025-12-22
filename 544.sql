WITH OrderDetails AS (
    SELECT
        aufk."AUFNR" AS "Order",
        afvc."VORNR" AS "Activity",
        iloa."BEBER" as "Plant_section",
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
        iloa."TPLNR" as "Functional_loc",
        crhd."ARBPL" AS "Oper_WorkCenter",
        crhd."OBJID" AS "Work_Center_Objid",
        aufk."AUART" AS "Order_type",
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
        --afih."REVNR" AS "Revision",
        array_join(array_agg(DISTINCT tj02t_systat."TXT04"),' ') AS "Operation_System_Status",
        --afvv."ARBEI" AS "Work", 
        --afru."ISMNW" AS "Booked_time",
        --afru."BUDAT" AS "Posting_date",
        --afru."ERNAM" AS "Posted_by",
        --afru."LEARR" AS "Activity_Code",
        --afru."GRUND" AS "Reason_Code",
        array_join(array_agg(DISTINCT ukgb_status_tj30t."TXT04"),' ') AS "FL_User_Status",
        array_join(array_agg(DISTINCT tj02t."TXT04"),' ') AS "Order_System_Status",
        array_join(array_agg(DISTINCT tj30t."TXT04"),' ') AS "Order_User_Status",
        array_join(array_agg(DISTINCT tj30t_oper."TXT04"),' ') AS "Operation_User_Status",
    
        CASE 
            WHEN afko."GLTRS" = '00000000' THEN NULL  
            ELSE date_format(date_parse(afko."GLTRS", '%Y%m%d'), '%Y-%m-%d')
        END AS "Order_Scheduled_Finish",
        
        CASE 
         WHEN afvv."SSEDD" = '00000000' THEN NULL  
         ELSE date_format(date_parse(afvv."SSEDD", '%Y%m%d'), '%Y-%m-%d')
        END AS "Operation_Latest_Finish_Date",
        afih."QMNUM" AS "Notification",
        CASE 
            WHEN qmel."LTRMN" = '00000000' THEN NULL  
            ELSE date_format(date_parse(qmel."LTRMN", '%Y%m%d'), '%Y-%m-%d')
        END AS "Notification_Req_End_Date"
        

    FROM "GSAP"."AUFK" aufk
    JOIN "GSAP"."AFKO" afko ON aufk."AUFNR" = afko."AUFNR"
    JOIN "GSAP"."AFIH" afih ON aufk."AUFNR" = afih."AUFNR"
    LEFT JOIN "GSAP"."QMEL" qmel 
           ON qmel."QMNUM" = afih."QMNUM"
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
    LEFT JOIN "GSAP"."JEST" jest_oper ON jest_oper."OBJNR" = afvc."OBJNR"
        AND jest_oper."INACT" <> 'X'
        AND jest_oper."STAT" LIKE 'E%'
    LEFT JOIN "GSAP"."TJ30T" tj30t_oper ON tj30t_oper."ESTAT" = jest_oper."STAT"
        AND tj30t_oper."SPRAS" = 'E'
        AND (tj30t_oper."STSMA" = 'PMPG' OR tj30t_oper."STSMA" = 'PMSP')
    WHERE 
    aufk."WERKS" = '5001'
    AND afru."BUDAT" >= '20250101'
    AND afru."BUDAT" <> '00000000'
    
    GROUP BY 
        aufk."AUFNR", afvc."VORNR", iloa."BEBER", iloa."TPLNR", crhd."ARBPL", crhd."OBJID", aufk."AUART",  afih."PRIOK",
        afih."ILART", afvv."SSEDD",  afko."GLTRS", afih."QMNUM", qmel."LTRMN"
        
)
SELECT  
    od."Order",
    od."Activity",
    od."Plant_section",
    od."unit",
    od."Functional_loc",
    od."Oper_WorkCenter",
    --od."Order_type",
    od."Priority",
    od."MAT",
    od."MAT_description",
    --od."Revision",
    --od."Work",
    --od."Lat_Start_Date",
    --od."Lat_Finish_Date", 
    --od."Booked_time",
    --od."Posting_date",
    --od."Posted_by",
    --od."Activity_Code",
    --od."Reason_Code",
    od."FL_User_Status",
    od."Order_System_Status",
    od."Operation_User_Status",
    od."Order_User_Status",
    od."Order_Scheduled_Finish",
    od."Operation_Latest_Finish_Date",
    od."Notification",
    od."Notification_Req_End_Date"
  
FROM OrderDetails od
ORDER BY   od."Order", od."Activity"