trigger hotelTrigger on MV_Hotel__c(after insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            // Create Standard Rooms
            roomMaintenance.generateRooms(Trigger.New);
            roomMaintenance.updateHotelRoomsCount(Trigger.New);
        }
    }

}
