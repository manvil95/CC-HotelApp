@isTest
public with sharing class roomMaintenanceTest {
    @TestSetup
    static void makeData() {
        MV_Hotel__c testHotel = new MV_Hotel__c(Name = 'Test Hotel', MV_TXT_City__c = 'Wroclaw', MV_SEL_Country__c = 'Poland', MV_NUM_TotalRooms__c = 0);
        insert testHotel;
    }

    static testMethod void roomMaintenanceTest() {
        list<MV_Hotel__c> hList = [SELECT Id, Name FROM MV_Hotel__c];
        roomMaintenance.generateRooms(hList);

        list<MV_Room__c> rommList = [SELECT Id, Name, MV_FLG_Jacuzzi__c, MV_SEL_Type__c, MV_FLG_MiniBar__c, MV_FLG_AirCondition__c, MV_NUM_RoomNumber__c, MV_Hotel__c FROM MV_Room__c];
        system.assertEquals(rommList.size(), 4);

        roomMaintenance.updateHotelRoomsCount(hList);

        list<MV_Hotel__c> hroom = [SELECT Id, Name, MV_NUM_TotalRooms__c FROM MV_Hotel__c];
        system.debug(hroom);

        system.assertEquals(hroom[0].MV_NUM_TotalRooms__c, 4);

        roomMaintenance.updateRoomNumbers(hList);

        AggregateResult[] ag = [SELECT MAX(MV_NUM_RoomNumber__c) maxNum, MIN(MV_NUM_RoomNumber__c) minNum FROM MV_Room__c];

        system.assertEquals(ag[0].get('maxNum'), 4);
        system.assertEquals(ag[0].get('minNum'), 1);
    }
}
