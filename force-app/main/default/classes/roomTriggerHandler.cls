public class roomTriggerHandler {
    public static void beforeInsert(list<MV_Room__c> roomList) {
        // Create map with Hotels and Rooms list
        Map<Id, List<MV_Room__c>> hotelWithRoom = new Map<Id, List<MV_Room__c>>();

        // Create list of Hotel Ids
        set<Id> hotelIds = new Set<Id>();

        for (MV_Room__c room : roomList) {
            hotelIds.add(room.MV_Hotel__c);
        }

        // Populate map with Hotel Ids and List of Rooms
        for (MV_Hotel__c hotel : [
            SELECT Id, MV_NUM_TotalRooms__c, (SELECT MV_NUM_RoomNumber__c FROM Rooms__r)
            FROM MV_Hotel__c
            WHERE Id IN :hotelIds
        ]) {
            hotelWithRoom.put(hotel.Id, hotel.rooms__r);
        }

        for (MV_Room__c rc : roomList) {
            if (rc.MV_FLG_Available__c == true && rc.MV_FLG_Occupied__c == true) {
                rc.addError('Room cannot be occupied and available at the same time' + rc.MV_NUM_RoomNumber__c + '. Please make sure just one checkbox is selected'); // Prevent Create
            } else {
                for (MV_Room__c dupCheck : hotelWithRoom.get(rc.MV_Hotel__c)) {
                    if (rc.MV_NUM_RoomNumber__c == dupCheck.MV_NUM_RoomNumber__c) {
                        rc.addError('This room number already exisit: ' + rc.MV_NUM_RoomNumber__c + '. Please choose different number.'); // Prevent Create
                    } else if (rc.MV_NUM_RoomNumber__c <= 0) {
                        rc.addError('Room Number cannot be negative: ' + rc.MV_NUM_RoomNumber__c + '. Please choose different number.'); // Prevent Create
                    }
                }
            }
        }
    }

    public static void afterUpdate(list<MV_Room__c> updateRecord, map<Id, MV_Room__c> oldMapValue) {
        //Create Apex Class to handle Service Rooms List
        //List of all hotels that needs to be updated
        list<Id> HotelToUpdate = new List<Id>();

        for (MV_Room__c r : updateRecord) {
            if (r.MV_FLG_ServiceRequired__c == true && oldMapValue.get(r.Id).MV_FLG_ServiceRequired__c == false) {
                HotelToUpdate.add(r.MV_Hotel__c);
            } else if (r.MV_FLG_ServiceRequired__c == false && oldMapValue.get(r.Id).MV_FLG_ServiceRequired__c == true) {
                HotelToUpdate.add(r.MV_Hotel__c);
            } else if (r.MV_FLG_Occupied__c == true && oldMapValue.get(r.Id).MV_FLG_Occupied__c == false) {
                HotelToUpdate.add(r.MV_Hotel__c);
            } else if (r.MV_FLG_Occupied__c == false && oldMapValue.get(r.Id).MV_FLG_Occupied__c == true) {
                HotelToUpdate.add(r.MV_Hotel__c);
            }
        }

        HotelDataUpdateQuable.HotelDataCountUpdate(HotelToUpdate);
    }

    public static void afterInsert(list<MV_Room__c> updateRecord) {
        //Create Apex Class to handle Service Rooms List
        //List of all hotels that needs to be updated
        list<Id> HotelToUpdate = new List<Id>();

        for (MV_Room__c r : updateRecord) {
            HotelToUpdate.add(r.MV_Hotel__c);
        }

        HotelDataUpdateQuable.HotelDataCountUpdate(HotelToUpdate);
    }
}
