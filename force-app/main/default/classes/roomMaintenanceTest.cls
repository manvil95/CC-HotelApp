@isTest
public with sharing class roomMaintenanceTest {

    @TestSetup
    static void makeData(){

        MV_Hotel__c testHotel = new MV_Hotel__c(Name = 'Test Hotel',MV_TXT_City__c='Wroclaw',MV_SEL_Country__c='Poland',MV_NUM_TotalRooms__c = 0);
        insert testHotel;
    }

    static testMethod void roomMaintenanceTest() {

        list<MV_Hotel__c> hList = [SELECT Id,Name From MV_Hotel__c];
        roomMaintenance.generateRooms(hList);

        list<Room__c> rommList = [SELECT Id, Name,jacuzzi__c,Type__c,Mini_Bar__c,Air_Condition__c,tv__c,Room_Number__c,MV_Hotel__c from Room__c];
        system.assertEquals(rommList.size(), 4);

        roomMaintenance.updateHotelRoomsCount(hList);

         list<MV_Hotel__c> hroom = [SELECT Id,Name,MV_NUM_TotalRooms__c From MV_Hotel__c];
         system.debug(hroom);

         system.assertEquals(hroom[0].MV_NUM_TotalRooms__c, 4);


         roomMaintenance.updateRoomNumbers(hList);

       AggregateResult[] ag = [SELECT MAX(Room_Number__c) maxNum,MIN(Room_Number__c) minNum from Room__c];

       system.assertEquals(ag[0].get('maxNum'), 4);
       system.assertEquals(ag[0].get('minNum'), 1);

    }

}