-- SQL Migration Script for KSNDMC.CONTINGENCY_CROP_PLAN
-- Generated on 2026-05-27T13:27:51.037Z

-- 1. Drop Table and Sequence if they exist
DECLARE
  e_table_not_exist EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_table_not_exist, -942);
  e_seq_not_exist EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_seq_not_exist, -2289);
BEGIN
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE "KSNDMC"."CONTINGENCY_CROP_PLAN" CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table CONTINGENCY_CROP_PLAN dropped.');
  EXCEPTION
    WHEN e_table_not_exist THEN NULL;
  END;
  BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE "KSNDMC"."CONTINGENCY_PLAN_SEQ"';
    DBMS_OUTPUT.PUT_LINE('Sequence CONTINGENCY_PLAN_SEQ dropped.');
  EXCEPTION
    WHEN e_seq_not_exist THEN NULL;
  END;
END;
/

-- 2. Create Sequence
CREATE SEQUENCE "KSNDMC"."CONTINGENCY_PLAN_SEQ"
  MINVALUE 1
  MAXVALUE 9999999999999999999999999999
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOCYCLE;

-- 3. Create Table
CREATE TABLE "KSNDMC"."CONTINGENCY_CROP_PLAN" (
  "CONTINGENCY_PLAN_ID" NUMBER NOT NULL,
  "DISTRICT" VARCHAR2(300 CHAR) NOT NULL,
  "SCENARIO" VARCHAR2(1000 CHAR) NOT NULL,
  "CONTINGENCY_PLAN_EN" CLOB,
  "CONTINGENCY_PLAN_KN" CLOB,
  "REGION_CODE" VARCHAR2(10 CHAR) NOT NULL,
  "CREATED_DATE" TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
  "CREATED_BY" VARCHAR2(100 CHAR),
  "UPDATED_DATE" TIMESTAMP(6),
  "UPDATED_BY" VARCHAR2(100 CHAR),
  "IS_ACTIVE" CHAR(1 CHAR) DEFAULT 'Y',
  CONSTRAINT "CONTINGENCY_CROP_PLAN_PK" PRIMARY KEY ("CONTINGENCY_PLAN_ID")
);

-- 4. Insert Data (111 rows)
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (498, 'Haveri', 'July 15 - 30', 'Redgram, Cotton,   Cowpea, Bajra, Maize, Sugarcane, Foxtail millet,Barnyard Millet', 'ತೊಗರಿ, ಹತ್ತಿ, ಅಲಸಂದಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (499, 'Haveri', 'August 1 - 15', 'Sunflower, Cowpea, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (500, 'Haveri', 'August 15 - 30', 'Sunflower, Cowpea, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ, ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (501, 'Belagavi', 'June 1 - 15', 'Greengram, Blackgram,  Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (502, 'Belagavi', 'June 15 - 30', 'Greengram, Blackgram,  Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (503, 'Belagavi', 'July 1 - 15', 'Soybean,   Bajra, Cowpea, Maize,Sugarcane, Foxtail millet,Barnyard Millet', 'ಸೋಯಾಅವರೆ ಅಲಸಂದಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (504, 'Belagavi', 'July 15 - 30', 'Bajra, Cowpea, Maize,Sugarcane, Foxtail millet,Barnyard Millet', 'ಅಲಸಂದಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (505, 'Belagavi', 'August 1 - 15', 'Sunflower, Cowpea, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (506, 'Belagavi', 'August 15 - 30', 'Sunflower, Cowpea, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ, ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (507, 'Chamarajanagar', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', '• 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನು ಬಳಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
• ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜಗಳನ್ನು ಉಪಚರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಸಾಲುಗಳ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ: 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು ಬಿತ್ತನೆಯಾದ 30 ದಿನಗಳ ನಂತರದಲ್ಲಿ ಸಂರಕ್ಷಣಾ ಕ್ರಮಗಳನ್ನು ಕೈಗೊಳ್ಳಿ.
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳ ಪ್ರಮಾಣವನ್ನು ನಿರ್ಧರಿಸಿ ಬಳಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಬೆಳೆಯ ಆರಂಭಿಕ ಹಂತದ ಕಳೆ ನಿಯಂತ್ರಣ ಮಾಡಿ ಮತ್ತು ಸಮಾನಾಂತರ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (508, 'Chamarajanagar', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (509, 'Chamarajanagar', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (510, 'Chamarajanagar', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (511, 'Chamarajanagar', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (441, 'Bidar', 'June 1 - 15', 'Greengram, Redgram, Blackgram, soybean, Groundnut, Bajra, Sorghum, Maize', 'ಹೆಸರು, ತೊಗರಿ, ಉದ್ದು, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (442, 'Bidar', 'June 15 - 30', 'Greengram, Redgram, Blackgram, soybean, Groundnut, Bajra, Sorghum, Maize', 'ಹೆಸರು, ತೊಗರಿ, ಉದ್ದು, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (443, 'Bidar', 'July 1 - 15', 'Redgram,  soybean, Groundnut, Bajra,  Maize', 'ತೊಗರಿ,  ಸೋಯಾಅವರೆ, ಸಜ್ಜೆ, ಶೇಂಗಾ, ಮೆಕ್ಕೆಜೋಳ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (444, 'Bidar', 'July 15 - 30', 'Redgram,  Bajra,  Maize, Sugarcane', 'ತೊಗರಿ,  ಸಜ್ಜೆ, ಕಬ್ಬು, ಮೆಕ್ಕೆಜೋಳ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (445, 'Bidar', 'August 1 - 15', 'Sunflower, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (446, 'Bidar', 'August 15 - 30', 'Sunflower, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (447, 'Kalaburgi', 'June 1 - 15', 'Greengram, Redgram, Blackgram, soybean, Groundnut, Bajra, Sorghum, Maize, Foxtail millet', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (448, 'Kalaburgi', 'June 15 - 30', 'Greengram, Redgram, Blackgram, soybean, Groundnut, Bajra, Sorghum, Maize, Foxtail millet', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (449, 'Kalaburgi', 'July 1 - 15', 'Redgram, soybean,  Bajra,  Maize, Foxtail millet, Sugarcane', 'ತೊಗರಿ, ಸೋಯಾಅವರೆ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (450, 'Kalaburgi', 'July 15 - 30', 'Redgram,  Bajra,  Maize, Foxtail millet, Sugarcane', 'ತೊಗರಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (451, 'Kalaburgi', 'August 1 - 15', 'Sunflower, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (452, 'Kalaburgi', 'August 15 - 30', 'Sunflower, Sugarcane', 'ಸೂರ್ಯಕಾಂತಿ, ಕಬ್ಬು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (453, 'Yadagir', 'June 1 - 15', 'Greengram, Redgram, Blackgram, soybean, Groundnut, Bajra, Sorghum, Maize, Cotton, Foxtail millet, Paddy', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ, ಹತ್ತಿ, ನವಣೆ, ಭತ್ತ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (454, 'Yadagir', 'June 15 - 30', 'Greengram, Redgram, Blackgram,  Groundnut, Bajra, Sorghum, Maize, Cotton, Foxtail millet, Paddy', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ,  ಶೇಂಗಾ, ಸಜ್ಜೆ, ಜೋಳ, ಮೆಕ್ಕೆಜೋಳ, ಹತ್ತಿ, ನವಣೆ, ಭತ್ತ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (455, 'Yadagir', 'July 1 - 15', 'Redgram,  Bajra,  Maize, Cotton, Foxtail millet, Paddy', 'ತೊಗರಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಹತ್ತಿ, ನವಣೆ, ಭತ್ತ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (456, 'Yadagir', 'July 15 - 30', 'Redgram,  Bajra,  Maize, Cotton, Foxtail millet, Paddy', 'ತೊಗರಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಹತ್ತಿ, ನವಣೆ, ಭತ್ತ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (457, 'Yadagir', 'August 1 - 15', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (458, 'Yadagir', 'August 15 - 30', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (459, 'Vijayapur', 'June 1 - 15', 'Greengram,  Groundnut, Bajra, Maize, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (460, 'Vijayapur', 'June 15 - 30', 'Greengram,  Groundnut, Bajra, Maize, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (461, 'Vijayapur', 'July 1 - 15', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (462, 'Vijayapur', 'July 15 - 30', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (463, 'Vijayapur', 'August 1 - 15', 'Sugarcane', 'ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (464, 'Vijayapur', 'August 15 - 30', 'Sugarcane', 'ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (465, 'BagalKote', 'June 1 - 15', 'Greengram,  Groundnut, Bajra, Maize, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (466, 'BagalKote', 'June 15 - 30', 'Greengram,  Groundnut, Bajra, Maize, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (467, 'BagalKote', 'July 1 - 15', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (468, 'BagalKote', 'July 15 - 30', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (469, 'BagalKote', 'August 1 - 15', 'Sugarcane', 'ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (470, 'BagalKote', 'August 15 - 30', 'Sugarcane', 'ಕಬ್ಬು', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (471, 'Raichur', 'June 1 - 15', 'Greengram,  Groundnut, Bajra, Maize, Paddy, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಭತ್ತ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (472, 'Raichur', 'June 15 - 30', 'Greengram,  Groundnut, Bajra, Maize, Paddy, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಭತ್ತ,  ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (473, 'Raichur', 'July 1 - 15', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಭತ್ತ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (474, 'Raichur', 'July 15 - 30', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಭತ್ತ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (475, 'Raichur', 'August 1 - 15', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (476, 'Raichur', 'August 15 - 30', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (477, 'Koppal', 'June 1 - 15', 'Greengram,  Groundnut, Bajra, Maize, Paddy, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಭತ್ತ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (478, 'Koppal', 'June 15 - 30', 'Greengram,  Groundnut, Bajra, Maize, Paddy, Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಭತ್ತ,  ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (479, 'Koppal', 'July 1 - 15', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಭತ್ತ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (480, 'Koppal', 'July 15 - 30', 'Maize, sugarcane, Foxtail millet,Barnyard Millet', 'ಭತ್ತ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (481, 'Koppal', 'August 1 - 15', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (482, 'Koppal', 'August 15 - 30', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (483, 'Gadag', 'June 1 - 15', 'Greengram, Blackgram, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (484, 'Gadag', 'June 15 - 30', 'Greengram, Blackgram, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ,  ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (485, 'Gadag', 'July 1 - 15', 'Soybean, Maize, Foxtail millet,Barnyard Millet,', 'ಸೋಯಾಅವರೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (486, 'Gadag', 'July 15 - 30', 'Maize, Foxtail millet,Barnyard Millet,', 'ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (487, 'Gadag', 'August 1 - 15', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (488, 'Gadag', 'August 15 - 30', 'Sunflower', 'ಸೂರ್ಯಕಾಂತಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (489, 'Dharwad', 'June 1 - 15', 'Greengram, Blackgram, Redgram, Cotton, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ, ಹತ್ತಿ, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (490, 'Dharwad', 'June 15 - 30', 'Greengram, Blackgram, Redgram, Cotton, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ತೊಗರಿ, ಹತ್ತಿ, ಸೋಯಾಅವರೆ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (491, 'Dharwad', 'July 1 - 15', 'Redgram, Cotton, Soybean,  Bajra, Cowpea, Maize,Foxtail millet,Barnyard Millet,', 'ಸೋಯಾಅವರೆ , ತೊಗರಿ, ಹತ್ತಿ,  ಅಲಸಂದಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ,ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (492, 'Dharwad', 'July 15 - 30', 'Redgram, Cotton,  Bajra, Cowpea, Maize,Foxtail millet,Barnyard Millet', 'ಅಲಸಂದಿ, ತೊಗರಿ, ಹತ್ತಿ,  ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ,  ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (493, 'Dharwad', 'August 1 - 15', 'Sunflower, Cowpea', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (494, 'Dharwad', 'August 15 - 30', 'Sunflower, Cowpea', 'ಸೂರ್ಯಕಾಂತಿ, ಅಲಸಂದಿ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (495, 'Haveri', 'June 1 - 15', 'Greengram, Blackgram, Redgram, Cotton, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ, ತೊಗರಿ, ಹತ್ತಿ, ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (496, 'Haveri', 'June 15 - 30', 'Greengram, Blackgram, Redgram, Cotton, Soybean,  Groundnut, Bajra, Maize,Foxtail millet,Barnyard Millet, Little Millet, Proso Millet', 'ಹೆಸರು, ಉದ್ದು, ಸೋಯಾಅವರೆ, ತೊಗರಿ, ಹತ್ತಿ,  ಶೇಂಗಾ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ನವಣೆ, ಊದಲು, ಬರಗು, ಸಾಮೆ,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (497, 'Haveri', 'July 1 - 15', 'Redgram, Cotton, Soybean,  Cowpea, Bajra, Maize, Sugarcane, Foxtail millet,Barnyard Millet', 'ಸೋಯಾಅವರೆ, ತೊಗರಿ, ಹತ್ತಿ, ಅಲಸಂದಿ, ಸಜ್ಜೆ, ಮೆಕ್ಕೆಜೋಳ, ಕಬ್ಬು, ನವಣೆ, ಊದಲು,', 'NIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (512, 'Chikkaballapur', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (513, 'Chikkaballapur', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (514, 'Chikkaballapur', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (515, 'Chikkaballapur', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (516, 'Chikkaballapur', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (517, 'Chikkamagaluru', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (518, 'Chikkamagaluru', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (519, 'Chikkamagaluru', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (520, 'Chikkamagaluru', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (521, 'Chikkamagaluru', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (522, 'Chitradurga', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (523, 'Chitradurga', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (524, 'Chitradurga', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (530, 'Davanagere', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (531, 'Davanagere', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (532, 'Hassan', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (533, 'Hassan', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (534, 'Hassan', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (535, 'Hassan', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (536, 'Hassan', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (525, 'Chitradurga', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (526, 'Chitradurga', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (527, 'Davanagere', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (528, 'Davanagere', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (529, 'Davanagere', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:43', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (542, 'Shivamogga', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (543, 'Shivamogga', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (544, 'Shivamogga', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (545, 'Shivamogga', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (546, 'Shivamogga', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (547, 'Tumakuru', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (548, 'Tumakuru', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (549, 'Tumakuru', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (537, 'Kolar', 'June 20 - July 10', '• If sowing has not been taken up by June 20, farmers may proceed with normal Kharif crops such as Finger millet (MR-1, MR-6, GPU-28) intercropped with Pigeonpea (BRG-1, BRG-2, BRG-5) in 8:2 ratio, or Maize (MAH-14-5, Nityashree, Hema) + Pigeonpea system depending on soil type.
• Undertake dry sowing 8–10 days before anticipated rainfall after proper land preparation.
• Treat seeds with recommended biofertilizers (Azospirillum, PSB) and fungicide as per package of practices.
• Apply well decomposed FYM @ 2–3 t/acre before sowing and incorporate into soil.
• Follow recommended spacing (Finger millet: 30 cm rows; Pigeonpea: 90–120 cm rows).
• Create conservation furrows or compartment bunds at 30 DAS to conserve in-situ moisture.
• Apply recommended RDF based on soil test values and split nitrogen application.
• Ensure early weed control within 20–25 DAS and thinning to maintain optimum plant population.', TO_CLOB('• ಜೂನ್ 20 ವರೆಗೂ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಲಾಗದಿದ್ದರೆ, 8:2 ಅನುಪಾತದಲ್ಲಿ ತೊಗರಿ (BRG-1, BRG-2, BRG-5) ಜೊತೆ ಅಂತರ ಬೆಳೆ ಮಾಡಿದ ಸಾಮಾನ್ಯ ಮುಂಗಾರು ಬೆಳೆಗಳಾದ ರಾಗಿ (MR-1, MR-6, GPU-28) ಅಥವಾ ಮಣ್ಣಿನ ಪ್ರಕಾರವನ್ನು ಅವಲಂಬಿಸಿ ಮೆಕ್ಕೆಜೋಳ (MAH-14-5, ನಿತ್ಯಶ್ರೀ, ಹೇಮಾ) + ತೊಗರಿ ಮಿಶ್ರ ಬೆಳೆ ಪದ್ಧತಿಯನ್ನುಅನುಸರಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳಬಹುದು.
•  ಭೂಮಿ ಸಿದ್ಧಪಡಿಸಿಟ್ಟುಕೊಂಡಿದ್ದಲ್ಲಿ, ಮಳೆಯ ನೀರೀಕ್ಷಣೆಯಿದ್ದಲ್ಲಿ 8-10 ದಿನಗಳ ಮೊದಲು ಒಣ ಬಿತ್ತನೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಸುಧಾರಿತ ಬೇಸಾಯ ಪದ್ಧತಿಗಳ ಪ್ರಕಾರ ಶಿಫಾರಸು ಮಾಡಲಾದ ಜೈವಿಕ ಗೊಬ್ಬರಗಳು (ಅಜೋಸ್ಪಿರಿಲ್ಲಮ್, PSB) ಮತ್ತು ಶಿಲೀಂಧ್ರನಾಶಕಗಳೊಂದಿಗೆ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಎಕರೆಗೆ 2-3 ಟನ್ ಚೆನ್ನಾಗಿ ಕೊಳೆತ ಕೊಟ್ಟಿಗೆ ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಿದ ಅಂತರವನ್ನು ಅನುಸರಿಸಿ (ರಾಗಿ: 30 ಸೆಂ.ಮೀ ಸಾಲುಗಳು; ತೊಗರಿ : 90-120 ಸೆಂ.ಮೀ ಸಾಲುಗಳು).
• ಸ್ಥಳದಲ್ಲೇ ತೇವಾಂಶವನ್ನು ಸಂರಕ್ಷಿಸಲು 30 DAS ನಲ್ಲಿ ಸಂರಕ್ಷಣಾ ತೋಡುಗಳು ಅಥವಾ ವಿಭಾಗದ ಕಟ್ಟುಗಳನ್ನು ') || TO_CLOB('ರಚಿಸಿ.
• ಶಿಫಾರಸು ಮಾಡಲಾದ RDF ಅನ್ನು ಅನ್ವಯಿಸಿ. ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳು ಮತ್ತು ವಿಭಜಿತ ಸಾರಜನಕ ಅನ್ವಯವನ್ನು ಆಧರಿಸಿ.
• 20–25 ದಿನಗಳ ಒಳಗೆ ಆರಂಭಿಕ ಕಳೆ ನಿಯಂತ್ರಣವನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ ಮತ್ತು ಅತ್ಯುತ್ತಮ ಸಸ್ಯ ಸಂಖ್ಯೆಯನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಲು ತೆಳುವಾಗಿಸುವುದು."'), 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (538, 'Kolar', 'July 11- July 31', '• If sowing is delayed up to July 10, shift to short to medium duration crops such as Finger millet (GPU-28, HR-911, ML-365), Cowpea (KBC-1, IT-38956-1), Field bean (HA-4, HA-5), Sunflower (KBSH-41, KBSH-53) and short duration Groundnut (TMV-2, JL-24).
• Increase seed rate by 15% to compensate for possible poor establishment.
• Undertake seed hardening practices prior to sowing to improve drought tolerance.
• Apply balanced NPK fertilizers based on LRI/soil test values with emphasis on potassium for drought tolerance.
• Complete first weeding and intercultivation at 20–25 DAS to reduce moisture competition.
• Adopt ridge and furrow system in medium to heavy soils to improve drainage and root growth.
• Monitor rainfall forecast and avoid long duration crops like cotton and long duration pigeonpea.', '• ರಾಗಿ (GPU-28, HR-911, ML-365), ಮೆಕ್ಕೆಜೋಳ (KBC-1, IT-38956-1), ಅವರೆ (HA-4, HA-5), ಸೂರ್ಯಕಾಂತಿ (KBSH-41, KBSH-53) ಮತ್ತು ಅಲ್ಪಾವಧಿಯ ನೆಲಗಡಲೆ (TMV-2, JL-24) ನಂತಹ ಅಲ್ಪಾವಧಿಯಿಂದ ಮಧ್ಯಮ ಅವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬಿತ್ತನೆ ಮಾಡಬಹುದು.
• ಸಂಭಾವ್ಯ ಕಳಪೆ ಬೆಳೆ ಬೆಳವಣಿಗೆ ಸರಿದೂಗಿಸಲು ಬಿತ್ತನೆ ಬೀಜ ದರವನ್ನು 15% ಹೆಚ್ಚಿಸಿ ಬಿತ್ತನೆ ಕೈಗೊಳ್ಳುವುದು.
• ಬೆಳೆಯಲ್ಲಿ ಬರ ಸಹಿಷ್ಣುತೆಯನ್ನು ಸುಧಾರಿಸಲು ಬಿತ್ತನೆ ಮಾಡುವ ಮೊದಲು ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಬರ ಸಹಿಷ್ಣುತೆಗಾಗಿ ಪೊಟ್ಯಾಸಿಯಮ್‌ಗೆ ಒತ್ತು ನೀಡುವ ಮೂಲಕ LRI/ಮಣ್ಣಿನ ಪರೀಕ್ಷಾ ಮೌಲ್ಯಗಳ ಆಧಾರದ ಮೇಲೆ ಸಮತೋಲಿತ NPK ರಸಗೊಬ್ಬರಗಳನ್ನು ಅನ್ವಯಿಸಿ.
• ತೇವಾಂಶ ನಿರ್ವಹಣೆ ಮಾಡಲು ಬಿತ್ತನೆಯಾದ 20–25 ದಿನಗಳ ನಂತರ ಕಳೆಗಳನ್ನು ಕಿತ್ತುಹಾಕಿ ಮತ್ತು ಎಡೆಕುಂಟೆ ಬಳಸಿ ಸಾಲಿನ ಮಧ್ಯದ ಕಳೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ
• ಬದು ಮತ್ತು ತೋಡು (ridges and furrow) ವ್ಯವಸ್ಥೆಯನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳುವುದರಿಂದ ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಬಹುದಲ್ಲದೇ, ಬೆಳೆಗಳ ಬೇರಿನ ಬೆಳವಣಿಗೆಯನ್ನು ಸುಧಾರಿಸಬಹುದು.
• ಮಳೆಯ ಮುನ್ಸೂಚನೆಯನ್ನು ಗಮನಿಸಿ ಹತ್ತಿ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿ ಬೆಳೆಗಳನ್ನು ತಪ್ಪಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (539, 'Kolar', 'August 1 - August 20', '• If sowing is delayed up to August 1, prefer short duration and drought tolerant crops such as Finger millet (GPU-48, GPU-45), Foxtail millet (RS-118), Little millet (Co-2), Horsegram (PHG-9), Cowpea (KBC-1, KBC-2), Niger and Grain amaranth (Suvarna).
• Avoid long duration crops such as cotton, maize and long duration pigeonpea.
• Use ridge sowing or broad bed furrow system to improve drainage and moisture conservation.
• Apply recommended seed treatment with Rhizobium for pulses and biofertilizers for millets.
• Maintain proper spacing and conduct thinning after 15 DAS to maintain uniform crop stand.
• Apply balanced fertilizers and micronutrients such as ZnSO4 and Borax where deficiency is reported.
• Ensure strict moisture conservation through contour cultivation and intercultivation.', '• ಆಗಸ್ಟ್ 1 ರವರೆಗೆ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ರಾಗಿ (GPU-48, GPU-45), ನವಣೆ (RS-118), ಸಾವೆ (Co-2), ಹುರುಳಿ (PHG-9), ಆಲಸಂದೆ (KBC-1, KBC-2), ಹುಚ್ಚೆಳ್ಳು ಮತ್ತು ರಾಜಗಿರಿ (ಸುವರ್ಣ) ಯಂತಹ ಅಲ್ಪಾವಧಿಯ ಮತ್ತು ಬರ ಸಹಿಷ್ಣು ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ. 
• ಹತ್ತಿ, ಮೆಕ್ಕೆಜೋಳ ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ತೊಗರಿಯಂತಹ ದೀರ್ಘಾವಧಿಯ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯಬೇಡಿ. 
• ಅಧಿಕವಾದ ಮಳೆ ನೀರನ್ನು ಹೊರಹಾಕಲು ಮತ್ತು ತೇವಾಂಶ ಸಂರಕ್ಷಣೆಯನ್ನು ಸುಧಾರಿಸಲು ಬದುಗಳ ಮೇಲೆ ಬಿತ್ತನೆ ಅಥವಾ ಅಗಲ ಬದು ಮತ್ತು ತೋಡು ವ್ಯವಸ್ಥೆಯನ್ನು ಬಳಸಿ. 
• ದ್ವಿದಳ ಧಾನ್ಯಗಳಿಗೆ ರೈಜೋಬಿಯಂ ಮತ್ತು ರಾಗಿಗೆ ಜೈವಿಕ ಗೊಬ್ಬರಗಳೊಂದಿಗೆ ಶಿಫಾರಸು ಮಾಡಿದ ಬೀಜೋಪಚಾರ ಮಾಡಿ.
• ಸಮಾನಾಂತರ ಬೇಳೆ ಕಾಪಾಡಿಕೊಳ್ಳಲು ಬಿತ್ತನೆಯಾದ 15 ದಿನಗಳ ನಂತರ ಹೆಚ್ಚಾದ ಗಿಡಗಳನ್ನು ತೆಗೆದುಹಾಕಿ ಸರಿಯಾದ ಅಂತರವನ್ನು ಕಾಪಾಡಿಕೊಳ್ಳಿ. 
• LRI ಆಧರಿಸಿ ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ZnSO4 ಮತ್ತು ಬೊರಾಕ್ಸ್‌ನಂತಹ ಸೂಕ್ಷ್ಮ ಪೋಷಕಾಂಶಗಳನ್ನು ಅನ್ವಯಿಸಿ. 
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬಿತ್ತನೆ ಮತ್ತು ಅಂತರಬೇಸಾಯದ ಮೂಲಕ ತೇವಾಂಶ ಸಂರಕ್ಷಣೆ ಮಾಡಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (540, 'Kolar', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (541, 'Kolar', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (550, 'Tumakuru', 'August 21 - September 30', '• If sowing is delayed beyond August 20, adopt risk-minimization cropping strategy.
• Prefer very short duration crops such as Horsegram (PHG-9), Cowpea (KBC-1), Field bean (HA-4, HA-5), and fodder crops like Fodder sorghum (SA Tall) and Fodder bajra.
• Avoid investment intensive crops and long duration varieties.
• If finger millet is inevitable, raise nursery in irrigated patch and transplant 20–25 day old seedlings.
• Reduce fertilizer dose proportionately and avoid excess nitrogen application.
• Adopt strict moisture conservation practices including contour bunding and intercultivation.
• Consider fodder production as priority to support livestock under delayed monsoon conditions.', '• ಆಗಸ್ಟ್ 20 ರ ನಂತರವೂ ಬಿತ್ತನೆ ವಿಳಂಬವಾದರೆ, ಅಪಾಯವನ್ನು ಕಡಿಮೆ ಮಾಡುವ ಬೆಳೆ ತಂತ್ರವನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ಹುರುಳಿ (PHG-9), ಮೆಕ್ಕೆಜೋಳ (KBC-1), ಅವರೆ (HA-4, HA-5) ನಂತಹ ಅಲ್ಪಾವಧಿಯ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ, ಮತ್ತು ಮೇವಿನ ಜೋಳ (SA ಟಾಲ್) ಮತ್ತು ಮೇವಿನ ಸಜ್ಜೆಯತಹ ಮೇವಿನ ಬೆಳೆಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.
• ಹೂಡಿಕೆ ತೀವ್ರ ಬೆಳೆಗಳು ಮತ್ತು ದೀರ್ಘಾವಧಿಯ ಪ್ರಭೇದಗಳನ್ನು ತಪ್ಪಿಸಿ.
• ರಾಗಿ ಬೆಳೆಯುವುದು ಅನಿವಾರ್ಯವಾದರೆ, ನೀರಾವರಿ ಮಾಡಿದ ಭಾಗದಲ್ಲಿ ನರ್ಸರಿ ಬೆಳೆಸಿ ಮತ್ತು 20–25 ದಿನಗಳ ಸಸಿಗಳನ್ನು ನಾಟಿ ಮಾಡಿ.
• ರಸಗೊಬ್ಬರ ಪ್ರಮಾಣವನ್ನು ಕಡಿಮೆ ಮಾಡಿ ಮತ್ತು ಹೆಚ್ಚುವರಿ ಸಾರಜನಕ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
• ಇಳಿಜಾರಿಗೆ ಅಡ್ಡಲಾಗಿ ಬದುಗಳ ನಿರ್ಮಾಣ ಮತ್ತು ಅಂತರ ಕೃಷಿ ಸೇರಿದಂತೆ ಇತರೆ ತೇವಾಂಶ ಸಂರಕ್ಷಣಾ ಪದ್ಧತಿಗಳನ್ನು ಅಳವಡಿಸಿಕೊಳ್ಳಿ.
• ವಿಳಂಬಿತ ಮುಂಗಾರು ಪರಿಸ್ಥಿತಿಗಳಲ್ಲಿ ಜಾನುವಾರುಗಳ ಮೇವಿಗಾಗಿ ಮೇವು ಬೆಳೆ ಬೆಳೆಯುವುದನ್ನು ಆದ್ಯತೆಯಾಗಿ ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');
INSERT INTO "KSNDMC"."CONTINGENCY_CROP_PLAN" ("CONTINGENCY_PLAN_ID", "DISTRICT", "SCENARIO", "CONTINGENCY_PLAN_EN", "CONTINGENCY_PLAN_KN", "REGION_CODE", "CREATED_DATE", "CREATED_BY", "UPDATED_DATE", "UPDATED_BY", "IS_ACTIVE") VALUES (551, 'Tumakuru', '> September 30', '• If Kharif sowing is completely missed, focus on soil health restoration and preparation for Rabi season.
• Undertake deep summer ploughing to break hard pan and improve infiltration.
• Apply FYM @ 2–3 t/acre and incorporate into soil to enhance soil organic carbon.
• Grow green manure crops like Sunhemp and incorporate at 45 DAS before Rabi season.
• Apply tank silt in red soils to improve moisture holding capacity.
• Strengthen bunds and repair farm ponds to conserve rainfall during subsequent showers.
• Plan Rabi crops such as Chickpea (JG-11, A-1), Safflower (A-1, NARI-6) and Rabi sorghum (M-35-1) based on soil moisture availability.
• Consider fodder crops if residual moisture is insufficient for grain crops.', '• ಮುಂಗಾರು ಬಿತ್ತನೆ ಸಾಧ್ಯವೇ ಆಗದಿದ್ದಲ್ಲಿ ಮಣ್ಣಿನ ಆರೋಗ್ಯ ಪುನಃಸ್ಥಾಪನೆ ಮತ್ತು ಹಿಂಗಾರು ಋತುವಿಗೆ ಸಿದ್ಧತೆಯತ್ತ ಗಮನಹರಿಸಿ.
• ಮಣ್ಣಿನಲ್ಲಿ ಉಂಟಾಗಿರಬಹುದಾದ ಗಟ್ಟಿತಳ ಒಡೆಯಲು ಮತ್ತು ನೀರಿನ ಇಂಗುವಿಕೆಯನ್ನು ಸುಧಾರಿಸಲು ಆಳವಾದ ಬೇಸಿಗೆಯ ಉಳುಮೆಯನ್ನು ಕೈಗೊಳ್ಳಿ.
• ಮಣ್ಣಿನ ಸಾವಯವ ಇಂಗಾಲವನ್ನು ಹೆಚ್ಚಿಸಲು ಎಕರೆಗೆ 2–3 ಟನ್‌ಗಳಷ್ಟು ಗೊಬ್ಬರವನ್ನು ಹಾಕಿ ಮಣ್ಣಿನಲ್ಲಿ ಸೇರಿಸಿ.
•ಸೆಣಬಿನಂತಹ ಹಸಿರು ಗೊಬ್ಬರ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಸಿ 40-45 ದಿನಗಳ ಒಳಗೆ ಮಣ್ಣಿಗೆ ಸೇರಿಸಿ.
• ತೇವಾಂಶ ಹಿಡಿದಿಟ್ಟುಕೊಳ್ಳುವ ಸಾಮರ್ಥ್ಯವನ್ನು ಸುಧಾರಿಸಲು ಕೆಂಪು ಮಣ್ಣಿನಲ್ಲಿ ಕೆರೆಹೂಳು ಹಾಕಿ.
• ನಂತರದ ಮಳೆಯ ಸಮಯದಲ್ಲಿ ಮಳೆನೀರನ್ನು ಸಂರಕ್ಷಿಸಲು ಬದುಗಳನ್ನು ಬಲಪಡಿಸಿ ಮತ್ತು ಕೃಷಿ ಹೊಂಡಗಳನ್ನು ದುರಸ್ತಿ ಮಾಡಿ.
• ಮಣ್ಣಿನ ತೇವಾಂಶದ ಲಭ್ಯತೆಯ ಆಧಾರದ ಮೇಲೆ ಕಡಲೆ (JG-11, A-1), ಕುಸುಬೆ (A-1, NARI-6) ಮತ್ತು ಹಿಂಗಾರಿ ಜೋಳ (M-35-1) ನಂತಹ ಹಿಂಗಾರಿ ಬೆಳೆಗಳನ್ನು ಯೋಜಿಸಿ.
• ಧಾನ್ಯ ಬೆಳೆಗಳಿಗೆ ಮಣ್ಣಿನ ತೇವಾಂಶವು ಸಾಕಷ್ಟಿಲ್ಲದಿದ್ದರೆ ಮೇವಿನ ಬೆಳೆಗಳನ್ನು ಪರಿಗಣಿಸಿ.', 'SIK', TO_TIMESTAMP('2026-05-10 07:39:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, 'Y');

COMMIT;
