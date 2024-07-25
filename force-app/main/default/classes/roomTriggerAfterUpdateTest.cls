@IsTest
public class roomTriggerAfterUpdateTest {
    static testMethod void testUnit() {
        //Create hotel to test
        MV_Hotel__c h = new MV_Hotel__c(Name = 'tst', MV_TXT_City__c = 'Nibylandia', MV_NUM_TotalRooms__c = 5, MV_FOR_RatingStars__c = 5);

        insert h;

        MV_Hotel__c h2 = new MV_Hotel__c(Name = 'tst2', MV_TXT_City__c = 'Nibylandia2', MV_NUM_TotalRooms__c = 5, MV_FOR_RatingStars__c = 5);

        insert h2;

        list<MV_Room__c> rUpdate = new List<MV_Room__c>();

        // create 160 rooms test
        for (integer i = 0; i < 160; i++) {
            MV_Room__c r = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = i + 1, MV_Hotel__c = h.Id, MV_FLG_Available__c = true);

            rUpdate.add(r);
        }
        MV_Room__c r2 = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = 161, MV_Hotel__c = h.Id, MV_FLG_ServiceRequired__c = true);

        rUpdate.add(r2);

        MV_Room__c r3 = new MV_Room__c(Name = 'test', MV_NUM_RoomNumber__c = 162, MV_Hotel__c = h.Id, MV_FLG_Occupied__c = true);

        rUpdate.add(r3);

        // Performe Test
        test.startTest();

        insert rUpdate;

        list<MV_Room__c> UpdateList = [SELECT Id, Name, MV_NUM_RoomNumber__c, MV_Hotel__c, MV_FLG_ServiceRequired__c, MV_FLG_Occupied__c, MV_FLG_Available__c FROM MV_Room__c];
        list<MV_Room__c> updateListFinal = new List<MV_Room__c>();

        for (MV_Room__c r : UpdateList) {
            if (r.MV_NUM_RoomNumber__c <= 50) {
                r.MV_FLG_ServiceRequired__c = true;
                r.MV_FLG_Available__c = false;
                updateListFinal.add(r);
            } else if (r.MV_NUM_RoomNumber__c > 50 && r.MV_NUM_RoomNumber__c <= 80) {
                r.MV_FLG_Available__c = true;
                r.MV_FLG_Occupied__c = false;
                updateListFinal.add(r);
            } else if (r.MV_NUM_RoomNumber__c == 161) {
                r.MV_FLG_Available__c = true;
                r.MV_FLG_Occupied__c = false;
                r.MV_FLG_ServiceRequired__c = false;
                updateListFinal.add(r);
            } else if (r.MV_NUM_RoomNumber__c == 162) {
                r.MV_FLG_Available__c = true;
                r.MV_FLG_Occupied__c = false;
                r.MV_FLG_ServiceRequired__c = false;
                updateListFinal.add(r);
            } else {
                r.MV_FLG_Available__c = false;
                r.MV_FLG_Occupied__c = true;
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
