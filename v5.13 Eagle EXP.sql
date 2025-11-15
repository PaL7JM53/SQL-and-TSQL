--data for BI

   WITH mylist AS
     (SELECT     DECODE (LEVEL
,1,'42127%'
,2,'42323%'
,3,'42479%'
,4,'42507%'
,5,'42311%'
,6,'42283%'
) val
      FROM       DUAL
      CONNECT BY LEVEL <= 6)

  SELECT SUBSTR (W1."UWI", 1, 10) AS "API_10",
         MIN (w3."CONGRESS_TOWNSHIP") AS "Township",
         MIN (w3."CONGRESS_RANGE") AS "Range",
         MIN (w3."CONGRESS_SECTION") AS "Section",
         MIN (R1."BA_NAME") AS BA_NAME,
         MIN (R2."FORM_NAME") AS FORM_NAME,
         MIN (W1."WHIPSTOCK_DEPTH") AS WHIPSTOCK_DEPTH,
         MIN (W1."WELL_NAME") || ' ' || MIN (W1."WELL_NUMBER") AS WELL_NAME,
         MIN (W1."WATER_DEPTH_REF") AS WATER_DEPTH_REF,
         MIN (W1."WATER_DEPTH") AS WATER_DEPTH,
         MIN (W1."TVD_DEPTH") AS TVD_DEPTH,
         MIN (W1."SPUD_DATE") AS SPUD_DATE,
         MIN (W1."RIG_RELEASE_DATE") AS RIG_RELEASE_DATE,
         MIN (W1."REF_ELEV") AS REF_ELEV,
         MIN (W1."PLUGBACK_DEPTH") AS PLUGBACK_DEPTH,
         MIN (W1."LEASE_NAME") AS LEASE_NAME,
         MIN (W1."KB_ELEV") AS KB_ELEV,
         MIN (W1."INITIAL_CLASS") AS INITIAL_CLASS,
         MIN (W1."HOLE_DIRECTION") AS HOLE_DIRECTION,
         MIN (W1."GROUND_ELEV") AS GROUND_ELEV,
         MIN (W1."FINAL_DRILL_DATE") AS FINAL_DRILL_DATE,
         MIN (W1."FIELD_POOL_WILDCAT") AS FIELD_POOL_WILDCAT,
         MIN (W1."FAULTED_IND") AS FAULTED_IND,
         MIN (W1."ELEVATION_REF") AS ELEVATION_REF,
         MIN (W1."DRILL_TOTAL_DEPTH") AS DRILL_TOTAL_DEPTH,
         MIN (W1."CASING_FLANGE_ELEV") AS CASING_FLANGE_ELEV,
         MIN (R_WELL_STATUS.LONG_NAME) AS STATUS,
         MIN (W1."PI_LOG_TD") AS PI_LOG_TD,
         MIN (W1."PI_LAST_UPDATE") AS PI_LAST_UPDATE,
         MIN (W1."PI_ABAND_DATE") AS PI_ABAND_DATE,
         MIN (W1."PI_OLD_TD") AS PI_OLD_TD,
         MIN (W1."PI_LEASE_TYPE") AS PI_LEASE_TYPE,
         MIN (W1."PI_TAX_CREDIT") AS PI_TAX_CREDIT,
         MIN (W1."PI_BASIN") AS PI_BASIN,
         MIN (W1."PI_PERM_ELEV_REF") AS PI_PERM_ELEV_REF,
         MIN (W1."PI_MD") AS PI_MD,
         MIN (W1."PI_OPERATOR_NAME") AS PI_OPERATOR_NAME,
         MIN (W1."PLATFORM_ID") AS PLATFORM_ID,
         MIN (W1."PI_SEISMIC_DATUM") AS PI_SEISMIC_DATUM,
         MIN (W1."PI_LEASE_AREA") AS PI_LEASE_AREA,
         MIN (W1."PI_LEASE_AREA_OUOM") AS PI_LEASE_AREA_OUOM,
         MIN (W1."PI_SITUATION_CD") AS PI_SITUATION_CD,
         MIN (W1."PI_TVD_LGR") AS PI_TVD_LGR,
         MIN (W1."PI_WELL_SLOT_NO") AS PI_WELL_SLOT_NO,
         MIN (W1."PI_GROSS_NET_PAY") AS PI_GROSS_NET_PAY,
         MIN (W1."PI_GRS_NETPY_OUOM") AS PI_GRS_NETPY_OUOM,
         MIN (W1."PI_ACTIVE_CODE") AS PI_ACTIVE_CODE,
         MIN (W1."PI_BOTTOM_HOLE_LAT") AS PI_BOTTOM_HOLE_LAT,
         MIN (W1."PI_BOTTOM_HOLE_LNG") AS PI_BOTTOM_HOLE_LNG,
         MIN (W1."PI_SURFACE_LAT") AS PI_SURFACE_LAT,
         MIN (W1."PI_SURFACE_LONG") AS PI_SURFACE_LONG,
         MIN (W1."PI_DF_ELEV") AS PI_DF_ELEV,
         MIN (W1."PI_DF_ELEV_OUOM") AS PI_DF_ELEV_OUOM,
         MIN (W1."PI_ABND_LOC_DATE") AS PI_ABND_LOC_DATE,
         MIN (W1."PI_SUSPENDED_DATE") AS PI_SUSPENDED_DATE,
         MIN (W1."PI_REF_ELEV_SUBSEA") AS PI_REF_ELEV_SUBSEA,
         MIN (W1."PI_TERM_FORM_INTRP") AS PI_TERM_FORM_INTRP,
         MIN (W1."PI_PARENT_UWI") AS PI_PARENT_UWI,
         MIN (W1."PI_PARENT_RELATION") AS PI_PARENT_RELATION,
         MIN (W1."PI_INFILL_CODE") AS PI_INFILL_CODE,
         MIN (W1."PI_UNIT_AREA") AS PI_UNIT_AREA,
         MIN (W1."PI_UNIT_AREA_OUOM") AS PI_UNIT_AREA_OUOM,
         MIN (W1."PI_RIG_ON_SITE_DT") AS PI_RIG_ON_SITE_DT,
         MIN (W1."PI_DEEPEST_DEPTH") AS PI_DEEPEST_DEPTH,
         MIN (W1."PI_DEEP_DEPTH_OUOM") AS PI_DEEP_DEPTH_OUOM,
         MIN (P3."LAT_HOLE_ID") AS LAT_HOLE_ID,
         MIN (P3."CONTRACTOR_NM") AS CONTRACTOR_NM,
         MIN (P3."MAX_DEV_ANGLE") AS MAX_DEV_ANGLE,
         MIN (P3."BUILDUP_RAD_IND") AS BUILDUP_RAD_IND,
         MIN (P3."BUILDUP_RT_DEG") AS BUILDUP_RT_DEG,
         MIN (P3."BUILDUP_RT_LEN") AS BUILDUP_RT_LEN,
         MIN (P3."BUILDUP_RT_OUOM") AS BUILDUP_RT_OUOM,
         MIN (P3."RESERVOIR_NM") AS RESERVOIR_NM,
         MIN (P3."TYPE_HORIZ_DRLG") AS TYPE_HORIZ_DRLG,
         MIN (P3."TOTL_HORIZ_DISP") AS TOTL_HORIZ_DISP,
         MIN (P3."HORIZ_DISP_OUOM") AS HORIZ_DISP_OUOM,
         MIN (P3."LAT_HOLE_LEN") AS LAT_HOLE_LEN,
         MIN (P3."LAT_HOLE_OUOM") AS LAT_HOLE_OUOM,
         MIN (P3."HORIZ_LEN_FORM") AS HORIZ_LEN_FORM,
         MIN (P3."HORIZ_FORM_OUOM") AS HORIZ_FORM_OUOM,
         MIN (P3."LENGTH_PAY") AS LENGTH_PAY,
         MIN (P3."LENGTH_PAY_OUOM") AS LENGTH_PAY_OUOM,
         MIN (P3."RSN_HORIZ_DRLG") AS RSN_HORIZ_DRLG,
         MIN (P3."RAT_HOLE_DEPTH") AS RAT_HOLE_DEPTH,
         MIN (P3."RAT_HOLE_DPTH_OUOM") AS RAT_HOLE_DPTH_OUOM,
         MIN (P3."RAT_DEPTH_IND") AS RAT_DEPTH_IND,
         MIN (P3."REMARK") AS REMARK,
        min(Decode (T1.tubing_obs_no,1,t1.tubing_type)) AS Tub_Type_1,
        min(Decode (T1.tubing_obs_no,1,t1.base_depth)) AS Tub_Depth_1,
        min(Decode (T1.tubing_obs_no,1,t1.OUTSIDE_DIA)) AS Tub_OD_1,
        min(Decode (T1.tubing_obs_no,2,t1.tubing_type)) AS Tub_Type_2,
        min(Decode (T1.tubing_obs_no,2,t1.base_depth)) AS Tub_Depth_2,
        min(Decode (T1.tubing_obs_no,2,t1.OUTSIDE_DIA)) AS Tub_OD_2,
        min(Decode (T1.tubing_obs_no,3,t1.tubing_type)) AS Tub_Type_3,
        min(Decode (T1.tubing_obs_no,3,t1.base_depth)) AS Tub_Depth_3,
        min(Decode (T1.tubing_obs_no,3,t1.OUTSIDE_DIA)) AS Tub_OD_3,
         MIN (W1."PI_COMP_DATE") AS PI_COMP_DATE,
         MIN(C1.TOP_DEPTH) AS TOP_PERF,
         MAX (C1.BASE_DEPTH) AS BOTTOM_PERF,
         MIN(C1.METHOD) AS METHOD,             
        MAX(C1.COMP_OBS_NO) AS PERF_INTERVALS,
         Frac.TRTM_TYPE,
         Frac.ADDITIVE_TYPE,
         Frac.INJECTION_RATE,
         Frac.TRTM_START_DATE,
         Frac.TRTM_FLUID_TYPE,
         Frac.TRTM_AMOUNT,
         Frac.TOP_DEPTH,
         Frac.FORM_BREAK_PRESS,
         Frac.AGENT_AMOUNT,
         Frac.AGENT_TYPE,
         Frac.BASE_DEPTH,
         Frac.REMARK,
         Frac.PI_TREATMENT_PRS,
         Frac.PI_INSTANT_SI_PRS,
         Frac.PI_TRTM_COMPANY,
         Frac.PI_ADDITIVE2_TYPE,
         Frac.PI_ADDITIVE3_TYPE,
         Frac.PI_AGENT_MESH_SIZE,
        cum3.Max_CumOil_Mbbl,
        cum3.Max_CumWat_Mbbl,
        cum3.Max_CumCond_Mbbl,
        cum3.Max_CumGas_MMscf,
        Cum3.ON_PRODUCTION_DATE,
        Cum3.NumberAPI

    FROM "PIDM"."WELL" W1,
         "PIDM"."PI_HORIZ_DRLG_HDR" P3,
         "PI_CODES"."BUSINESS_ASSOCIATE" R1,
         "PI_CODES"."FORMATION" R2,
         "PIDM"."LEGAL_CONGRESS_LOC" W3,
         PI_CODES.R_WELL_STATUS,
         PIDM.well_tubular T1,
         PIDM.WELL_COMPLETION C1,
         mylist,
         --start of frac table
         (  SELECT SUBSTR (W2."UWI", 1, 10) AS API_10,
                   MIN (W2.TRTM_TYPE) AS TRTM_TYPE,
                   MIN (W2.ADDITIVE_TYPE) AS ADDITIVE_TYPE,
                   AVG (W2.INJECTION_RATE) AS INJECTION_RATE,
                   MIN (W2.TRTM_START_DATE) AS TRTM_START_DATE,
                   MIN (W2.TRTM_FLUID_TYPE) AS TRTM_FLUID_TYPE,
                   SUM (W2.TRTM_AMOUNT) AS TRTM_AMOUNT,
                   MIN (W2.TOP_DEPTH) AS TOP_DEPTH,
                   AVG (W2.FORM_BREAK_PRESS) AS FORM_BREAK_PRESS,
                   SUM (W2.AGENT_AMOUNT) AS AGENT_AMOUNT,
                   MIN (W2.AGENT_TYPE) AS AGENT_TYPE,
                   MAX (W2.BASE_DEPTH) AS BASE_DEPTH,
                   MIN (W2.REMARK) AS REMARK,
                   MIN (W2.PI_TREATMENT_PRS) AS PI_TREATMENT_PRS,
                   MIN (W2.PI_INSTANT_SI_PRS) AS PI_INSTANT_SI_PRS,
                   MIN (W2.PI_TRTM_COMPANY) AS PI_TRTM_COMPANY,
                   MIN (W2.PI_ADDITIVE2_TYPE) AS PI_ADDITIVE2_TYPE,
                   MIN (W2.PI_ADDITIVE3_TYPE) AS PI_ADDITIVE3_TYPE,
                   MIN (W2.PI_AGENT_MESH_SIZE) AS PI_AGENT_MESH_SIZE
              FROM "PIDM"."WELL_TREATMENT" W2,
              mylist
             WHERE    
            w2.uwi LIKE mylist.val
                   AND W2."TRTM_TYPE" = 'FRAC'
                   AND W2."AGENT_TYPE" = 'SAND'
          GROUP BY SUBSTR (W2."UWI", 1, 10)) Frac,
                 
         --start of cum production table
         ( 
          SELECT    -- this SELECT pivots volumes from rows by fluid into a single row
        SUBSTR (prod.well_identifier, 1, 10) AS uwi_10,
        min(pden.ON_PRODUCTION_DATE) AS ON_PRODUCTION_DATE,
         MAX (DECODE (cum.fluid, 'O', cum.cumulative, NULL) / 1000)            AS max_Cumoil_Mbbl,
         MAX (DECODE (cum.fluid, 'W', cum.cumulative, NULL) / 1000)            AS max_Cumwat_Mbbl,
         MAX (DECODE (cum.fluid, 'CN', cum.cumulative, NULL) / 1000)            AS max_Cumcond_Mbbl,
         MAX (            DECODE (cum.fluid, 'CG', cum.cumulative, 0) / 1000            +  DECODE (cum.fluid, 'G', cum.cumulative, 0) / 1000)            AS max_Cumgas_MMscf,
         min(EntityCount.NumAPI) AS NumberAPI
    FROM pidm.pi_pden_well prod,
         pidm.pden pden,
         pi_reports.pi_pden_cumulative cum,
         PIDM.PDEN_PROD_ZONE,
         mylist,
                            (select prod1.entity,
    count(prod1.well_identifier) AS NumAPI
    from pidm.pi_pden_well prod1,
    mylist
    where prod1.well_identifier LIKE mylist.val 
    group by prod1.entity) EntityCount
    
   WHERE    prod.entity=EntityCount.entity
         AND prod.entity = pden.entity
         AND prod.entity = cum.entity
         AND prod.entity = PDEN_PROD_ZONE.entity(+)
         AND pden.entity_type <> 'ALLOCATED'
         AND cum.SOURCE = 'PI'
         AND    prod.well_identifier LIKE mylist.val

GROUP BY SUBSTR (prod.well_identifier(+), 1, 10)

) Cum3
   --end of cum production table
   WHERE     (W1."UWI" = P3."UWI"(+))
         AND w1."OPERATOR" = R1."BA_ID"(+)
         AND w1."TERMINATING_FORM" = R2."FORM_ID"(+)
         AND w1.pi_crstatus = R_WELL_STATUS.Status(+)
         AND SUBSTR (w1."UWI", 1, 10) = SUBSTR (w3."WELL_NODE_ID"(+), 1, 10)
         AND SUBSTR (W1.UWI, 1, 10) = Frac.API_10(+)
         AND SUBSTR (W1.UWI, 1, 10) = Cum3.UWI_10(+)
         AND SUBSTR (W1.UWI, 1, 10) = SUBSTR(C1.UWI(+),1,10)
         AND SUBSTR (w1."UWI", 1, 10) = SUBSTR (t1.UWI(+), 1, 10)
        AND w1.uwi LIKE mylist.val

GROUP BY SUBSTR (W1."UWI", 1, 10),
         Frac.TRTM_TYPE,
         Frac.ADDITIVE_TYPE,
         Frac.INJECTION_RATE,
         Frac.TRTM_START_DATE,
         Frac.TRTM_FLUID_TYPE,
         Frac.TRTM_AMOUNT,
         Frac.TOP_DEPTH,
         Frac.FORM_BREAK_PRESS,
         Frac.AGENT_AMOUNT,
         Frac.AGENT_TYPE,
         Frac.BASE_DEPTH,
         Frac.REMARK,
         Frac.PI_TREATMENT_PRS,
         Frac.PI_INSTANT_SI_PRS,
         Frac.PI_TRTM_COMPANY,
         Frac.PI_ADDITIVE2_TYPE,
         Frac.PI_ADDITIVE3_TYPE,
         Frac.PI_AGENT_MESH_SIZE,
         cum3.Max_CumOil_Mbbl,
        cum3.Max_CumWat_Mbbl,
        cum3.Max_CumCond_Mbbl,
        cum3.Max_CumGas_MMscf,
        Cum3.ON_PRODUCTION_DATE,
        Cum3.NumberAPI

ORDER BY SUBSTR (W1."UWI", 1, 10)