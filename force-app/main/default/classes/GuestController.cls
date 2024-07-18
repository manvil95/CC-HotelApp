public class GuestController {
    @AuraEnabled(cacheable=true)
    public static list<Contact> guestListfromReservation(list<String> ids) {
        return [SELECT Id, LastName FROM contact WHERE Id IN (SELECT Guest_name__c FROM Reservation__c WHERE id = :ids)];
    }
}
