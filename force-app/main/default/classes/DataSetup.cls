public with sharing class DataSetup {
    public static void updateRoomImg() {
        list<MV_Room__c> roomList = [SELECT Id, Name FROM MV_Room__c];

        for (MV_Room__c r : roomList) {
            r.MV_URL_Photo__c = Consts.ROOM_IMAGE.IMAGE_SOURCE.ImageUrl + '/photo' + Integer.valueof((1 + Math.random() * 10)) + '.jpg';
        }
    }
}
