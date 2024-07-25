public with sharing class ReservationController {
    @AuraEnabled(cacheable=true)
    public static list<Reservation__c> reservationList(list<String> rList) {
        return [SELECT Id, Name FROM Reservation__c WHERE MV_Room__c IN :rList];
    }
}
