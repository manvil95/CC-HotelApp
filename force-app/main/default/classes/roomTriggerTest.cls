@isTest
public class roomTriggerTest {
    static testMethod void testUnit() {
        //Create hotel to test
        MV_Hotel__c h = new MV_Hotel__c(Name = 'tst', MV_TXT_City__c = 'Nibylandia', MV_NUM_TotalRooms__c = 5);
        insert h;

        // Create 1 room to check against
        MV_Room__c r1 = new MV_Room__c(Name = 'testRoom', MV_NUM_RoomNumber__c = 1, MV_Hotel__c = h.Id);

        insert r1;

        list<MV_Room__c> rUpdate = new List<MV_Room__c>();

        // create 160 rooms test
        for (integer i = 0; i < 160; i++) {
            MV_Room__c r = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = 1, MV_Hotel__c = h.Id);
            rUpdate.add(r);
        }
        MV_Room__c r2 = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = 0, MV_Hotel__c = h.Id);
        rUpdate.add(r2);

        // Performe Test
        test.startTest();

        try {
            insert rUpdate;
        } catch (DmlException e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('This room number already exisit:') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        MV_Room__c rtest = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = 200, MV_Hotel__c = h.Id, MV_FLG_Available__c = true, MV_FLG_Occupied__c = true);

        try {
            insert rtest;
        } catch (DmlException e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Room cannot be occupied and available') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        Test.stopTest();

        list<MV_Room__c> roomsInserted = [SELECT Id FROM MV_Room__c];
        system.assertEquals(1, roomsInserted.size());
    }
}
