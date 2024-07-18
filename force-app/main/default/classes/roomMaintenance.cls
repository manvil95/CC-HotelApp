public class roomMaintenance {


    public class roomType{
        String name;
        String url;}

    public static void generateRooms(list<MV_Hotel__c> hotelList){


        //Prepare data
        list<MV_Hotel__c> queryList = [Select Id,Name from MV_Hotel__c where Id IN: hotelList];
        //Create list to upload
        list<Room__c> uploadList = new list <Room__c>();
        //Available rooms

       list<String> roomTypes = new list<String>{'Single','Double','King','President Suite'};

       list<roomType> roomList = new list<roomType>();

       for(Integer i=1;i<=roomTypes.size();i++){
        roomType r = new roomType();
        r.name = roomTypes[i-1];
        r.url = Consts.ROOM_IMAGE.IMAGE_SOURCE.ImageUrl + '/photo' + Integer.valueof((1+ Math.random() * 10)) + '.jpg';
        roomList.add(r);

       }


    for(MV_Hotel__c h:queryList){
        for(Integer i=1;i<=roomList.size();i++){

        Room__c ht = new Room__c(
        MV_Hotel__c = h.Id,
        Name = roomList[i-1].name + ' Room ' + h.Name,
        Type__c = roomList[i-1].name,
        Mini_Bar__c = true,
        Available__c = true,
        Air_Condition__c = true,
        tv__c = true,
        Room_Number__c=i,
        jacuzzi__c = roomList[i-1].name == 'President Suite' ? true : false,
        photo_url__c = roomList[i-1].url,
        Max_Number_of_Guests__c = roomList[i-1].name == 'President Suite' ? 5 : roomList[i-1].name == 'King' ? 4 : roomList[i-1].name == 'Double' ? 2 : 1
        );
      uploadList.add(ht);
        }
    }
       insert uploadList;
    }

        public static void generateRooms(String hotelId){


        //Prepare data
        list<MV_Hotel__c> queryList = [Select Id,Name from MV_Hotel__c where Id =: hotelId];
        //Create list to upload
        list<Room__c> uploadList = new list <Room__c>();
        //Available rooms

       list<String> roomTypes = new list<String>{'Single','Double','King','President Suite'};

       list<roomType> roomList = new list<roomType>();

       for(Integer i=1;i<=roomTypes.size();i++){
        roomType r = new roomType();
        r.name = roomTypes[i-1];
        r.url = Consts.ROOM_IMAGE.IMAGE_SOURCE.ImageUrl + '/photo' + Integer.valueof((1+ Math.random() * 10)) + '.jpg';
        roomList.add(r);

       }


    for(MV_Hotel__c h:queryList){
        for(Integer i=1;i<=roomList.size();i++){

        Room__c ht = new Room__c(
        MV_Hotel__c = h.Id,
        Name = roomList[i-1].name + ' Room ' + h.Name,
        Type__c = roomList[i-1].name,
        Mini_Bar__c = true,
        Available__c = true,
        Air_Condition__c = true,
        tv__c = true,
        Room_Number__c=i,
        jacuzzi__c = roomList[i-1].name == 'President Suite' ? true : false,
        photo_url__c = roomList[i-1].url,
        Max_Number_of_Guests__c = roomList[i-1].name == 'President Suite' ? 5 : roomList[i-1].name == 'King' ? 4 : roomList[i-1].name == 'Double' ? 2 : 1
        );
      uploadList.add(ht);
        }
    }
       insert uploadList;
    }

    public static void updateHotelRoomsCount(List<MV_Hotel__c> hotelList) {

        AggregateResult[] aggRooms = [SELECT MV_Hotel__c, count(Id) ct FROM Room__c WHERE MV_Hotel__c IN:hotelList group by MV_Hotel__c];

        map<String,Integer> hotelwithRoomCount = new map<String,Integer>();
        list<MV_Hotel__c> updateListHotels = new list<MV_Hotel__c>();

        for(AggregateResult agg: aggRooms){
        hotelwithRoomCount.put(String.valueOf(agg.get('MV_Hotel__c')), Integer.valueOf(agg.get('ct')));
        }
        list<MV_Hotel__c> hotelsList = [Select ID,(Select Id from Rooms__r) from MV_Hotel__c WHERE id IN: hotelwithRoomCount.keySet()];

        for(MV_Hotel__c h : hotelsList){

            h.MV_NUM_TotalRooms__c = hotelwithRoomCount.get(h.Id);
            updateListHotels.add(h);
        }
        update updateListHotels;
    }

    public static void updateRoomNumbers(List<MV_Hotel__c> hotelList) {
        AggregateResult[] aggRooms = [SELECT MV_Hotel__c, count(Id) ct FROM Room__c WHERE MV_Hotel__c IN:hotelList group by MV_Hotel__c];

        map<String,Integer> hotelwithRoomCount = new map<String,Integer>();
        list<Room__c> updateListRoom = new list<Room__c>();

        for(AggregateResult agg: aggRooms){
        hotelwithRoomCount.put(String.valueOf(agg.get('MV_Hotel__c')), Integer.valueOf(agg.get('ct')));
        }

        list<MV_Hotel__c> hotelsList = [Select ID,(Select Id from Rooms__r) from MV_Hotel__c WHERE id IN: hotelwithRoomCount.keySet()];

        for(MV_Hotel__c h : hotelsList){

            Integer roomNum = 1;
            for(Room__c r :h.Rooms__r){

            r.Room_Number__c = roomNum;
            updateListRoom.add(r);
            roomNum++;

            }
        }
        update updateListRoom;

    }

}