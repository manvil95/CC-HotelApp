# Refactor Hotel App

## Content

- [**Previous CC Hotel App**](#previous-cc-hotel-app)
  - [Quick Start](#quick-start)
  - [Overview](#overview)

---

## _Previous_ CC Hotel App

CC Hotel App is build to manage reservation for for CC hotel company. It includes LWC UI for support team to manage customer reservations

### Quick Start

- Open DevHub
- Create Scratch Org using `sfdx force:org:create -f project-scratch-def.json -a MyScratchOrg`
- Push metadata `sfdx force:source:push -u MyScratchOrg -f`
- Assign Permission Set `sfdx force:user:permset:assign --permsetname Hotel_User -u MyScratchOrg`
- Import Data - Rooms and Hotels `sfdx force:data:import:tree -p ./data/Hotel__c-Room__c-plan.json -u MyScratchOrg`
- Import Data - Contacts `sfdx force:data:import:tree -p ./data/export-contact-Contact-plan.json -u MyScratchOrg`
- **Open Hotel App and explore!**

### Overview

- Hotel Home App Tab - search for available rooms and make reservatios
- Hotels 360 - hotel reservation overview
- Spoonacular - integration with spoonacular API to query food recipes from external service (by id,by name,random recipe)

<br>
<div align="right">

[Top](#refactor-hotel-app)
</div>