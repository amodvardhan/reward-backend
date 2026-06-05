# Bug Fix Status Tracking

This document tracks the status of identified bugs and CRs.

## SIK Field Crop Failures (Part 2 of Audit)

| Bug / Inconsistency | Description | Affected Crops | Status | Verification Method |
| :--- | :--- | :--- | :---: | :--- |
| **1. Sowing Month Casing/Spacing** | Exact case-sensitive match failed on casing/spacing differences in the database | Cotton, Maize, Millets, Soybean | **FIXED** | Verified via `scratch_verify_sik_crops.js` for Cotton and others. |
| **2. Sowing Month Text Discrepancies** | Mismatches between `BLOCKING_PERIOD` and `FIELD_CROPS_ADVISORY` month values | Groundnut, Redgram, Greengram, Sorghum, Foxtail Millet, Sugarcane, Fieldbean, Castor, Proso Millet | **FIXED** | Verified via `scratch_verify_sik_crops.js` for Groundnut, Redgram, Greengram, Castor, etc. |
| **3. Advisory Crop Name Mismatches** | Mismatch in crop names between blocking/duration and advisory tables | Finger Millet (Ragi), Brown Top Millet, Rice (IR) | **FIXED** | Verified via `scratch_verify_sik_crops.js` using Finger Millet and Brown Top Millet. |
| **4. Null CROP_ID in Advisory Table** | `CROP_ID` was `NULL` for Castor in `FIELD_CROPS_ADVISORY` | Castor | **FIXED** | Updated database records to `CROP_ID = 23`. Verified in test runs. |
| **5. Weather Independence Fallback** | Late-stage weather-independent rows with NIL/NIL rainfall categories did not match | Blackgram, Greengram (155 DAS) | **FIXED** | Verified fallback using 155 DAS test cases. |
| **6. Year Boundary Restriction** | Rabi/late-year sowing date selection blocked by current-year-only bounds | Sugarcane, Sorghum, Rice(IR) | **FIXED** | Verified period info retrieves ranges for both current and previous year. |
| **7. Null CROP_ID in Horti Tables** | CROP_ID was NULL in HORTI_MONTHS_CROPS_ADVISORY and HORTI_WEEKS_CROPS_ADVISORY | Cucumber, Cauliflower, Pumpkin, French Bean, Banana, Mango, Pomegranate, Guava, Sapota, Papaya, Arecanut, Betel Vine, Drumstick, Lemon, Jackfruit | **FIXED** | Updated database rows and source SQL migration scripts to match against REWARD_CROP_MASTER. |
| **8. Harvested Crop Check** | API throws 404 instead of HARVESTED status for crop age exceeding crop duration + 30 days | Cotton (e.g. 338 DAS) | **FIXED** | Added check in handleAgricultureAdvisory to return HARVESTED status with 200 OK. |

