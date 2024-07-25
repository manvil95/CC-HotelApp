public with sharing class RoomAvailableScheldule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        list<MV_Room__c> endOfRentListUpdate = new List<MV_Room__c>();
        list<MV_Room__c> startOfRentListUpdate = new List<MV_Room__c>();

        list<MV_Room__c> endOfRent = [SELECT Id, Name, MV_FLG_Available__c, MV_SEL_Type__c, MV_NUM_RoomNumber__c FROM MV_Room__c WHERE MV_FLG_Occupied__c = TRUE AND ID IN (SELECT MV_Room__c FROM Reservation__c WHERE Check_out_Date__c = TODAY)];

        list<MV_Room__c> startOfRent = [SELECT Id, Name, MV_FLG_Available__c, MV_SEL_Type__c, MV_NUM_RoomNumber__c FROM MV_Room__c WHERE MV_FLG_Occupied__c = TRUE AND ID IN (SELECT MV_Room__c FROM Reservation__c WHERE Check_In_Date__c = TODAY)];

        if (endOfRent.size() > 0) {
            for (MV_Room__c r : endOfRent) {
                r.MV_FLG_Available__c = true;
                r.MV_FLG_Occupied__c = false;

                endOfRentListUpdate.add(r);
            }
        }

        if (startOfRent.size() > 0) {
            for (MV_Room__c r : startOfRent) {
                r.MV_FLG_Available__c = false;
                r.MV_FLG_Occupied__c = true;

                startOfRentListUpdate.add(r);
            }
        }

        update endOfRentListUpdate;
        update startOfRentListUpdate;
    }
}
