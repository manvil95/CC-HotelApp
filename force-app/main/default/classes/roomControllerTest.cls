@isTest
public with sharing class roomControllerTest {
    @TestSetup
    static void makeData() {
        MV_Hotel__c hotel = new MV_Hotel__c(Name = 'Test Hotel', MV_SEL_Country__c = 'Poland', MV_TXT_City__c = 'Wroclaw');
        insert hotel;

        MV_Room__c r1 = new MV_Room__c(Name = 'Test Single Room 1', MV_Hotel__c = hotel.Id, MV_NUM_MaxNumberGuests__c = 5);
        insert r1;

        MV_Room__c r2 = new MV_Room__c(Name = 'Test Single Room 2', MV_Hotel__c = hotel.Id, MV_NUM_MaxNumberGuests__c = 5, MV_SEL_Type__c = 'Double', MV_NUM_RoomNumber__c = 2);
        insert r2;
    }

    static testMethod void roomControllerTest() {
        //Test rooms with all data

        roomController.FILTERSAPEX filters = new roomController.FILTERSAPEX();

        filters.city = 'Wroclaw';
        filters.country = 'Poland';
        filters.startDate = '2022-08-24';
        filters.endDate = '2022-08-28';
        filters.numberOfGuests = '5';
        filters.rooms = new List<String>{ 'Double' };
        filters.hotel = 'Test Hotel';

        list<MV_Room__c> rTest = roomController.roomDisplayList(filters);

        //Test rooms without type data

        roomController.FILTERSAPEX filtersWithoutType = new roomController.FILTERSAPEX();

        filtersWithoutType.city = 'Wroclaw';
        filtersWithoutType.country = 'Poland';
        filtersWithoutType.numberOfGuests = '5';
        filtersWithoutType.hotel = 'Test Hotel';

        list<MV_Room__c> rTest2 = roomController.roomDisplayList(filtersWithoutType);

        //Test other return methods
        List<MV_Hotel__c> hList = [SELECT Id FROM MV_Hotel__c];

        list<MV_Room__c> roomList = roomController.roomList(hlist);
        list<MV_Room__c> available = roomController.availableRooms(hlist);
        list<MV_Room__c> occupied = roomController.occupiedRooms(hlist);
        list<MV_Room__c> endReservation = roomController.endReservation();
    }
}
