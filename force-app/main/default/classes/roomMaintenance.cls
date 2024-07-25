public class roomMaintenance {
    public class roomType {
        String name;
        String url;
    }

    public static void generateRooms(list<MV_Hotel__c> hotelList) {
        //Prepare data
        list<MV_Hotel__c> queryList = [SELECT Id, Name FROM MV_Hotel__c WHERE Id IN :hotelList];
        //Create list to upload
        list<MV_Room__c> uploadList = new List<MV_Room__c>();
        //Available rooms

        list<String> roomTypes = new List<String>{ 'Single', 'Double', 'King', 'President Suite' };

        list<roomType> roomList = new List<roomType>();

        for (Integer i = 1; i <= roomTypes.size(); i++) {
            roomType r = new roomType();
            r.name = roomTypes[i - 1];
            r.url = Consts.ROOM_IMAGE.IMAGE_SOURCE.ImageUrl + '/photo' + Integer.valueof((1 + Math.random() * 10)) + '.jpg';
            roomList.add(r);
        }

        for (MV_Hotel__c h : queryList) {
            for (Integer i = 1; i <= roomList.size(); i++) {
                MV_Room__c ht = new MV_Room__c(
                    MV_Hotel__c = h.Id,
                    Name = roomList[i - 1].name + ' Room ' + h.Name,
                    MV_SEL_Type__c = roomList[i - 1].name,
                    MV_FLG_MiniBar__c = true,
                    MV_FLG_Available__c = true,
                    MV_FLG_AirCondition__c = true,
                    MV_NUM_RoomNumber__c = i,
                    MV_FLG_Jacuzzi__c = roomList[i - 1].name == 'President Suite' ? true : false,
                    MV_URL_Photo__c = roomList[i - 1].url,
                    MV_NUM_MaxNumberGuests__c = roomList[i - 1].name == 'President Suite' ? 5 : roomList[i - 1].name == 'King' ? 4 : roomList[i - 1].name == 'Double' ? 2 : 1
                );
                uploadList.add(ht);
            }
        }
        insert uploadList;
    }

    public static void generateRooms(String hotelId) {
        //Prepare data
        list<MV_Hotel__c> queryList = [SELECT Id, Name FROM MV_Hotel__c WHERE Id = :hotelId];
        //Create list to upload
        list<MV_Room__c> uploadList = new List<MV_Room__c>();
        //Available rooms

        list<String> roomTypes = new List<String>{ 'Single', 'Double', 'King', 'President Suite' };

        list<roomType> roomList = new List<roomType>();

        for (Integer i = 1; i <= roomTypes.size(); i++) {
            roomType r = new roomType();
            r.name = roomTypes[i - 1];
            r.url = Consts.ROOM_IMAGE.IMAGE_SOURCE.ImageUrl + '/photo' + Integer.valueof((1 + Math.random() * 10)) + '.jpg';
            roomList.add(r);
        }

        for (MV_Hotel__c h : queryList) {
            for (Integer i = 1; i <= roomList.size(); i++) {
                MV_Room__c ht = new MV_Room__c(
                    MV_Hotel__c = h.Id,
                    Name = roomList[i - 1].name + ' Room ' + h.Name,
                    MV_SEL_Type__c = roomList[i - 1].name,
                    MV_FLG_MiniBar__c = true,
                    MV_FLG_Available__c = true,
                    MV_FLG_AirCondition__c = true,
                    MV_NUM_RoomNumber__c = i,
                    MV_FLG_Jacuzzi__c = roomList[i - 1].name == 'President Suite' ? true : false,
                    MV_URL_Photo__c = roomList[i - 1].url,
                    MV_NUM_MaxNumberGuests__c = roomList[i - 1].name == 'President Suite' ? 5 : roomList[i - 1].name == 'King' ? 4 : roomList[i - 1].name == 'Double' ? 2 : 1
                );
                uploadList.add(ht);
            }
        }
        insert uploadList;
    }

    public static void updateHotelRoomsCount(List<MV_Hotel__c> hotelList) {
        AggregateResult[] aggRooms = [SELECT MV_Hotel__c, count(Id) ct FROM MV_Room__c WHERE MV_Hotel__c IN :hotelList GROUP BY MV_Hotel__c];

        map<String, Integer> hotelwithRoomCount = new Map<String, Integer>();
        list<MV_Hotel__c> updateListHotels = new List<MV_Hotel__c>();

        for (AggregateResult agg : aggRooms) {
            hotelwithRoomCount.put(String.valueOf(agg.get('MV_Hotel__c')), Integer.valueOf(agg.get('ct')));
        }
        list<MV_Hotel__c> hotelsList = [SELECT ID, (SELECT Id FROM Rooms__r) FROM MV_Hotel__c WHERE id IN :hotelwithRoomCount.keySet()];

        for (MV_Hotel__c h : hotelsList) {
            h.MV_NUM_TotalRooms__c = hotelwithRoomCount.get(h.Id);
            updateListHotels.add(h);
        }
        update updateListHotels;
    }

    public static void updateRoomNumbers(List<MV_Hotel__c> hotelList) {
        AggregateResult[] aggRooms = [SELECT MV_Hotel__c, count(Id) ct FROM MV_Room__c WHERE MV_Hotel__c IN :hotelList GROUP BY MV_Hotel__c];

        map<String, Integer> hotelwithRoomCount = new Map<String, Integer>();
        list<MV_Room__c> updateListRoom = new List<MV_Room__c>();

        for (AggregateResult agg : aggRooms) {
            hotelwithRoomCount.put(String.valueOf(agg.get('MV_Hotel__c')), Integer.valueOf(agg.get('ct')));
        }

        list<MV_Hotel__c> hotelsList = [SELECT ID, (SELECT Id FROM Rooms__r) FROM MV_Hotel__c WHERE id IN :hotelwithRoomCount.keySet()];

        for (MV_Hotel__c h : hotelsList) {
            Integer roomNum = 1;
            for (MV_Room__c r : h.Rooms__r) {
                r.MV_NUM_RoomNumber__c = roomNum;
                updateListRoom.add(r);
                roomNum++;
            }
        }
        update updateListRoom;
    }
}
