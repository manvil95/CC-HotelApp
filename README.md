# Refactor Hotel App

## Content

- [**Previous CC Hotel App**](#previous-cc-hotel-app)
  - [Quick Start](#quick-start)
  - [Overview](#overview)

---

## Metadata changed

### Objects Refactor

#### MV_Hotel__c

##### Fields

- CreatedById
- LastModifiedById
- MV_DIV_TrailingYearACV__c
- MV_FOR_RatingStars__c
- MV_NUM_AvailableRooms__c
- MV_NUM_RoomsOutOfService__c
- MV_NUM_TotalRentedRooms__c
- MV_NUM_TotalRooms__c
- MV_SEL_Country__c
- MV_SEL_Rating__c
- MV_TXT_City__c
- MV_TXT_PostalCode__c
- MV_TXT_Street__c
- Name
- OwnerId

##### Page Layout

- MV_Hotel__c-Hotel Layout


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
    - `sf org create scratch --target-dev-hub HotelDevHub --definition-file config/projectscratch-def.json --set-default --duration-days 30 --no-namespace --alias featHotel`
3. Generate password: 
    - `sf org generate password --target-org featHotel`
    - To see the password for the user: 
      - `sf org display user -o userName`
4. Connect VSCode to org and push metadata:
    - `sf project deploy start --ignore-conflicts | Out-File -FilePath output.txt`
5. Assign Permission Set: 
    - `sfdx force:user:permset:assign --permsetname Hotel_User -u featHotel`
    - `sf org assign permset --perm-set-name Hotel_User -u featHotel`
6. Import Data - Rooms and Hotels: 
    - `sfdx force:data:import:tree -p ./data/Hotel__c-Room__c-plan.json -u featHotel`

`sf org display user -o test-jg9evxegzomp@example.com`
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