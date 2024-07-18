@IsTest
public class roomTriggerAfterUpdateTest {
    static testMethod void testUnit() {
        //Create hotel to test
        MV_Hotel__c h = new MV_Hotel__c(Name = 'tst', MV_TXT_City__c = 'Nibylandia', MV_NUM_TotalRooms__c = 5, MV_FOR_RatingStars__c = 5);

        insert h;

        MV_Hotel__c h2 = new MV_Hotel__c(Name = 'tst2', MV_TXT_City__c = 'Nibylandia2', MV_NUM_TotalRooms__c = 5, MV_FOR_RatingStars__c = 5);

        insert h2;

        list<Room__c> rUpdate = new List<Room__c>();

        // create 160 rooms test
        for (integer i = 0; i < 160; i++) {
            Room__c r = new Room__c(Name = 'test', Room_Number__c = i + 1, MV_Hotel__c = h.Id, Available__c = true);

            rUpdate.add(r);
        }
        Room__c r2 = new Room__c(Name = 'test', Room_Number__c = 161, MV_Hotel__c = h.Id, service__c = true);

        rUpdate.add(r2);

        Room__c r3 = new Room__c(Name = 'test', Room_Number__c = 162, MV_Hotel__c = h.Id, occupied__c = true);

        rUpdate.add(r3);

        // Performe Test
        test.startTest();

        insert rUpdate;

        list<Room__c> UpdateList = [SELECT Id, Name, Room_Number__c, MV_Hotel__c, service__c, occupied__c, Available__c FROM Room__c];
        list<Room__c> updateListFinal = new List<Room__c>();

        for (Room__c r : UpdateList) {
            if (r.Room_Number__c <= 50) {
                r.service__c = true;
                r.Available__c = false;
                updateListFinal.add(r);
            } else if (r.Room_Number__c > 50 && r.Room_Number__c <= 80) {
                r.Available__c = true;
                r.occupied__c = false;
                updateListFinal.add(r);
            } else if (r.Room_Number__c == 161) {
                r.Available__c = true;
                r.occupied__c = false;
                r.service__c = false;
                updateListFinal.add(r);
            } else if (r.Room_Number__c == 162) {
                r.Available__c = true;
                r.occupied__c = false;
                r.service__c = false;
                updateListFinal.add(r);
            } else {
                r.Available__c = false;
                r.occupied__c = true;
                updateListFinal.add(r);
            }
        }
        update updateListFinal;

        Test.stopTest();

        MV_Hotel__c hotelData = [SELECT Id, MV_NUM_RoomsOutOfService__c, MV_FOR_RatingStars__c, MV_NUM_TotalRentedRooms__c FROM MV_Hotel__c WHERE Name = 'tst'];
        system.debug(hotelData);

        system.assertEquals(32, hotelData.MV_FOR_RatingStars__c);
        system.assertEquals(50, hotelData.MV_NUM_RoomsOutOfService__c);
    }
}
