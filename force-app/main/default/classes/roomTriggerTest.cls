@isTest
public class roomTriggerTest {
    static testMethod void testUnit() {
        //Create hotel to test
        MV_Hotel__c h = new MV_Hotel__c(Name = 'tst', MV_TXT_City__c = 'Nibylandia', MV_NUM_TotalRooms__c = 5);
        insert h;

        // Create 1 room to check against
        Room__c r1 = new Room__c(Name = 'testRoom', Room_Number__c = 1, MV_Hotel__c = h.Id);

        insert r1;

        list<Room__c> rUpdate = new List<Room__c>();

        // create 160 rooms test
        for (integer i = 0; i < 160; i++) {
            Room__c r = new Room__c(Name = 'test', Room_Number__c = 1, MV_Hotel__c = h.Id);
            rUpdate.add(r);
        }
        Room__c r2 = new Room__c(Name = 'test', Room_Number__c = 0, MV_Hotel__c = h.Id);
        rUpdate.add(r2);

        // Performe Test
        test.startTest();

        try {
            insert rUpdate;
        } catch (DmlException e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('This room number already exisit:') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        Room__c rtest = new Room__c(Name = 'test', Room_Number__c = 200, MV_Hotel__c = h.Id, Available__c = true, occupied__c = true);

        try {
            insert rtest;
        } catch (DmlException e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Room cannot be occupied and available') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        Test.stopTest();

        list<Room__c> roomsInserted = [SELECT Id FROM Room__c];
        system.assertEquals(1, roomsInserted.size());
    }
}
