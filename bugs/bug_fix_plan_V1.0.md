# Bug Fixes & Logical Changes Plan (Testing Observations & Migration Audit) - V1.0

This document provides a comprehensive audit of the data migration for the **NIK** and **SIK** regions from the source Excel files to the Oracle database. It also tracks the implementation status of the 20 original bugs/CRs and the new SIK Field Crop issues.

---

## Part 1: Data Migration Verification (Excel vs. Database)

We performed a row-by-row count comparison and integrity check between the source Excel files located in `migration_scripts/data/` and the Oracle database tables.

### 1. Row Count Audit Summary

| Table / Entity | Excel Source File | Excel Rows (excluding headers) | Oracle DB Rows (after corrected import) | Match Status | Notes |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **BLOCKING_PERIOD** | `Blocking period_NIK & SIK.xlsx` | **41** | **41** | **100% Match** | Excel sheet has 43 rows total, including 2 regional header labels (`NIK crops` and `SIK crops`). Crop rows total 19 (NIK) + 22 (SIK) = 41. |
| **FIELD_CROPS_ADVISORY** | `Field Crops_Advisory_NIK_16_4_2026.xls`<br>`Field Crops_Advisory_SIK_16_04_2026.xlsx` | **2565** | **2565** | **100% Match** | NIK: 731 rows, SIK: 1834 rows. Match is exact. |
| **HORTI_MONTHS_CROPS_ADVISORY** | `Horti Months NIK _corrected_7.5.2026.xlsx`<br>`Horti Months crops SIK.xlsx` | **2458** | **2458** | **100% Match** | NIK: 1227 rows, SIK: 1231 rows. Match is exact. |
| **HORTI_WEEKS_CROPS_ADVISORY** | `Horti Weeks NIK_corrected_7.5.2026.xlsx`<br>`Horti Weeks crops SIK.xlsx` | **729** | **729** | **100% Match** | NIK: 332 rows, SIK: 397 rows. Match is exact. |
| **CONTINGENCY_CROP_PLAN** | `corrected_Contingecy crop_NIK_UAS Dharwad.xlsx`<br>`SIK_Contingency crop plans.xlsx` | **199** | **199** | **100% Match** | NIK: 154 rows, SIK: 45 rows. Match is exact. |

---

### 2. Discovered Migration Issues & Fix Plan

During the verification, we identified why the database row counts initially mismatched and resolved them as follows:

1. **SQL\*Plus Substitution Variables (`&`)**:
   - *Problem*: String values in SQL scripts containing ampersands (`&`) (e.g., in blockings/advisories) prompted SQL*Plus to request input variables. This ate subsequent command lines, causing execution syntax errors and skipping rows.
   - *Fix*: Prefixed all executions with `SET DEFINE OFF;`.
2. **SQL\*Plus Blank Line Termination**:
   - *Problem*: Multi-line Kannada instructions in the SQL script had empty lines inside `CLOB` literals. By default, SQL*Plus treats blank lines as command buffer terminators, breaking long insert statements.
   - *Fix*: Executed with `SET BLANKLINES ON;` or utilized Node.js scripts to read the raw SQL files and execute inserts one-by-one.
3. **String Literals Exceeding 4000 Characters (ORA-01704)**:
   - *Problem*: SIK Contingency plans (specifically the Tumakuru `> September 30` scenario) contained long text exceeding the 4000-character SQL limit.
   - *Fix*: Split the text into parts using `TO_CLOB('part1') \|\| TO_CLOB('part2')`.
4. **Trailing COMMIT Statements in batched chunks**:
   - *Problem*: The last insert in the Horti Months script appended `COMMIT;` inside the last split statement, which threw an `ORA-03405` error when executed via standard thin-client commands.
   - *Fix*: Filtered out trailing `COMMIT` statements from parsed SQL chunks.

---

### 3. Detailed Audit of SIK Field Crop Failures [DONE - FIXED]

Following the QA test results indicating failures for various crops and DAS in region SIK, we conducted a targeted database audit and resolved the 6 core structural inconsistencies:

1. **Sowing Month Casing and Spacing Mismatch** [DONE]
   - *Problem*: Casing and spacing differences (e.g. `'May-June'` vs `'MAY-JUNE'`) prevented exact string matching.
   - *Fix*: Modified model query to use `REPLACE(UPPER(SOWING_MONTH), ' ', '') = REPLACE(UPPER(:sowingMonth), ' ', '')`.
2. **Sowing Month Text Discrepancies** [DONE]
   - *Problem*: Mismatches between blocking sowing period and advisory table sowing month text.
   - *Fix*: Created a dynamic month resolution helper `resolveSowingMonth` in the controller to map dates and crops to the correct DB strings.
3. **Advisory Crop Name Mismatches** [DONE]
   - *Problem*: Name mismatches (e.g. Finger Millet vs Ragi).
   - *Fix*: Created crop name normalization helper `normalizeCropName` mapping names correctly for blocking, duration, and advisory lookups.
4. **Null CROP_ID in Advisory Table** [DONE]
   - *Problem*: `CROP_ID` was NULL for Castor rows in `FIELD_CROPS_ADVISORY`.
   - *Fix*: Executed SQL updates to set `CROP_ID = 23` for all Castor rows matching `REWARD_CROP_MASTER`.
5. **Post-Harvest Weather Independence (NIL/NIL Fallback)** [DONE]
   - *Problem*: Post-harvest stages (155 DAS) are weather-independent (`NIL/NIL`) but queried using active weather.
   - *Fix*: Added fallback search in `handleAgricultureAdvisory` that queries using `NIL/NIL` rainfall parameters when weather-dependent searches fail.
6. **Calendar Year Boundary Restriction** [DONE]
   - *Problem*: Calendar picker blocked previous year's sowing dates.
   - *Fix*: Updated `/period_info` to compute and return ranges for both current and previous years.

---

## Part 2: Categorization of Testing Observations

We have categorized all observations from the sheet into three distinct workstreams:

1. **API**: Backend logic modifications (no mobile app or database schema/migration changes needed).
2. **Mobile**: Mobile client modifications (no backend API changes or database changes needed).
3. **Database / Migration**: Changes in the database content, SQL scripts, or migration files.

| Row # / Crop | Issue Description | Priority | Category | Status |
| :---: | :--- | :---: | :---: | :---: |
| 5 | Crop practice images not displaying. | P2 | **API** | Pending |
| 6 | Retain crop advisory flow for unregistered farmers. | P3 | **Mobile** | Pending |
| 7 | NIK first stage data correction. | P1 | **Database / Migration** | Pending |
| 8 | SIK "NO" condition flow failing (June 1–19). | P1 | **API** | Pending |
| 9 | Date picker: Open previous years for horticulture. | P1 | **Mobile** | Pending |
| 10 | Contingency plan data not displaying correctly in some cases. | P1 | **Database / Migration** | Pending |
| 11 | English translation displays Kannada text. | P1 | **API** | Pending |
| 12 | Previous Rainfall window calculation (7 days instead of 3). | P1 | **API** | Pending |
| 13 | Grapes (SIK) advisory not fetched for age groups `>1`. | P1 | **API** | Pending |
| 14 | Papaya Kannada translation missing (displays English). | P1 | **Database / Migration** | Pending |
| 15 | Registration UI: Mark mandatory fields with bold and red asterisk (`*`). | P1 | **Mobile** | Pending |
| 16 | Crop Sowing question label update: change to "Have you sown?". | P1 | **Mobile** | Pending |
| 17 | Video tutorials: update headings and link URLs. | P1 | **Mobile** | Pending |
| 18 | Restrict sowing date picker range & block dates beyond harvest + 30 days. | P1 | **Mobile & API** | Pending |
| 19 | Remove "Pre-harvesting" form fields and screens. | P1 | **Mobile** | Pending |
| 20 | Regionalize crop list (Rice / Aerobic Rice blocking periods in NIK). | P1 | **Mobile & Database** | Pending |
| 21 | NIK "NO" condition flow returns incorrect scenario sets. | P1 | **API** | Pending |
| 22 | Cowpea (NIK) Kannada unicode text corruption. | P1 | **Database / Migration** | Pending |
| 23 | Tomato / Onion weeks advisory fallback when gaps exist. | P1 | **API** | Pending |
| 24 | Update labels on the "Contact Us" screen. | P2 | **Mobile** | Pending |
| **Cotton / Maize / Millets** | Sowing Month Casing and spacing mismatch failures in SIK. | P1 | **API** | **FIXED** |
| **Groundnut / Redgram / Sugarcane / Sorghum** | Sowing Month text discrepancy failures in SIK. | P1 | **API & Database** | **FIXED** |
| **Finger Millet / Browntop** | Crop name mismatches in database tables. | P1 | **API & Database** | **FIXED** |
| **Castor** | null CROP_ID prevents matching SIK Castor. | P1 | **Database / Migration** | **FIXED** |
| **Blackgram / Greengram** | 155 DAS failures due to NIL/NIL rainfall requirement at post-harvest. | P1 | **API** | **FIXED** |
| **Sugarcane / Sorghum / Rice(IR)** | Previous year sowing dates calendar block. | P1 | **API & Mobile** | **FIXED** |

---

## Part 3: Logical Fix Plans & Verification Results

### SIK Field Crop Failures [RESOLVED]

All 6 structural issues causing SIK field crop failures have been fixed:
1. Mismatched `CROP_ID`s in `FIELD_CROPS_ADVISORY` aligned to `REWARD_CROP_MASTER` via database updates for Castor, Ragi, Browntop Millet, and Sunflower.
2. Space/case-insensitive `SOWING_MONTH` lookups implemented in `src/models/contingencyCropPlan.js`.
3. Sowing month discrepancies mapped dynamically in `resolveSowingMonth` inside `src/controllers/contingencyCropPlanController.js`.
4. Crop name normalization between blocking, duration, and advisory tables implemented via `normalizeCropName`.
5. Post-harvest weather-independent stages (e.g. 155 DAS) matched using weather-independent `NIL/NIL` fallback queries when active weather yields no match.
6. Allowed calendar date boundaries opened up to support previous year sowing dates by returning ranges for both current and previous year in `/period_info`.

---

## Part 4: Verification

Successfully executed the validation suite `scratch_verify_sik_crops.js` which simulates requests for all tested SIK crops:
- Cotton at 3, 5, 7, 10, 15, 35 DAS: **PASSED**
- Groundnut at 35 DAS (blocked out of range sowing warning): **PASSED**
- Redgram at 16 DAS: **PASSED**
- Castor at 30 DAS: **PASSED**
- Blackgram at 155 DAS (NIL/NIL Fallback): **PASSED**
- Greengram at 155 DAS (NIL/NIL Fallback): **PASSED**
- Finger Millet (Ragi) name normalization lookup: **PASSED**
- Brown Top Millet (Browntop) name normalization lookup: **PASSED**
- Period Info Year Boundary Check: **PASSED**
