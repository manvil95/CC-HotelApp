public with sharing class reservationItemStayDefault implements reservationLineI {
    public PricebookEntry reservationItem() {
        PricebookEntry i = [SELECT Id, Name, Product2Id, UnitPrice FROM PricebookEntry WHERE Product2.MV_FLG_DefaultReservation__c = TRUE AND Pricebook2.IsStandard = TRUE LIMIT 1];

        return i;
    }
}
