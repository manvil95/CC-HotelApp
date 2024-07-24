# Refactor Hotel App

## Content

- [**Previous CC Hotel App**](#previous-cc-hotel-app)
  - [Quick Start](#quick-start)
  - [Overview](#overview)

---

## Metadata changed

### Objects Refactor

#### MV_Hotel\_\_c

##### Fields

- CreatedById
- LastModifiedById
- MV_DIV_TrailingYearACV\_\_c
- MV_FOR_RatingStars\_\_c
- MV_NUM_AvailableRooms\_\_c
- MV_NUM_RoomsOutOfService\_\_c
- MV_NUM_TotalRentedRooms\_\_c
- MV_NUM_TotalRooms\_\_c
- MV_SEL_Country\_\_c
- MV_SEL_Rating\_\_c
- MV_TXT_City\_\_c
- MV_TXT_PostalCode\_\_c
- MV_TXT_Street\_\_c
- Name
- OwnerId

##### Page Layout

- MV_Hotel\_\_c-Hotel Layout

### Picklist Value Set

- MV_Core_Country
- MV_Core_CustomerType
- MV_Core_Decision
- MV_Core_Rating

## _Previous_ CC Hotel App

CC Hotel App is build to manage reservation for for CC hotel company. It includes LWC UI for support team to manage customer reservations

### Quick Start

1. Open DevHub
2. Create Scratch Org Using:
   - `sf org create scratch --target-dev-hub HotelDevHub --definition-file config/project-scratch-def.json --set-default --duration-days 30 --no-namespace --alias featHotel`
3. Generate password:
   - `sf org generate password --target-org featHotel`
   - To see the password for the user:
     - `sf org display user -o userName`
4. Connect VSCode to org and push metadata:
   - `sf project deploy start --ignore-conflicts | Out-File -FilePath output.txt`
5. Assign Permission Set:
   - `sfdx force:user:permset:assign --permsetname Hotel_User -u featHotel`
   - `sf org assign permset --perm-set-name Hotel_User -u featHotel`
6. Import Data - Rooms and Hotels: - `sfdx force:data:import:tree -p ./data/Hotel__c-Room__c-plan.json -u featHotel`
<!--- Open DevHub

- Create Scratch Org using `sfdx force:org:create -f project-scratch-def.json -a MyScratchOrg`
- Push metadata `sfdx force:source:push -u MyScratchOrg -f`
- Assign Permission Set `sfdx force:user:permset:assign --permsetname Hotel_User -u MyScratchOrg`
- Import Data - Rooms and Hotels `sfdx force:data:import:tree -p ./data/Hotel__c-Room__c-plan.json -u MyScratchOrg`
- Import Data - Contacts `sfdx force:data:import:tree -p ./data/export-contact-Contact-plan.json -u MyScratchOrg`
- **Open Hotel App and explore!**-->

### Overview

- Hotel Home App Tab - search for available rooms and make reservatios
- Hotels 360 - hotel reservation overview
- Spoonacular - integration with spoonacular API to query food recipes from external service (by id,by name,random recipe)

<br>
<div align="right">

[Top](#refactor-hotel-app)

</div>
