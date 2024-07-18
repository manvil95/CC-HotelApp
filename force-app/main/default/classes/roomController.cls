public class roomController {
    public class FILTERSAPEX {
        @AuraEnabled
        public list<String> rooms { get; set; }
        @AuraEnabled
        public String city { get; set; }
        @AuraEnabled
        public String hotel { get; set; }
        @AuraEnabled
        public String country { get; set; }
        @AuraEnabled
        public String startDate { get; set; }
        @AuraEnabled
        public String endDate { get; set; }
        @AuraEnabled
        public String numberOfGuests { get; set; }
    }

    @AuraEnabled(cacheable=true)
    public static list<Room__c> roomDisplayList(FILTERSAPEX filters) {
        FILTERSAPEX filterData = filters;
        String countryName;
        String cityName;
        String hotelName;
        Date hotelStartDate;
        Date hotelEndDate;
        Integer guestNo;

        list<String> logicList = new List<String>();
        String logicDatesList = '';
        String logic = '';
        String logicDate = '';
        String logicDate1 = '';
        String logicDate2 = '';
        list<String> typeList = new List<String>();

        String queryLogic;

        if (filterData != null) {
            if (filterData.country != null) {
                countryName = filterData.country;
                logicList.add('Hotel__r.MV_SEL_Country__c =: countryName');
            }
            if (filterData.city != null) {
                cityName = filterData.city;
                logicList.add('Hotel__r.MV_TXT_City__c =: cityName');
            }
            if (filterData.hotel != null) {
                hotelName = filterData.hotel;
                logicList.add('Hotel__r.Name =: hotelName');
            }

            if (filterData.numberOfGuests != null) {
                guestNo = Integer.valueOf(filterData.numberOfGuests);
                logicList.add('Max_Number_of_Guests__c >=: guestNo');
            }

            if (filterData.rooms != null) {
                typeList = filterData.rooms;
                logicList.add('Type__c IN: typeList');
            }

            if (filterData.rooms == null) {
                if (logicList.contains('Type__c IN: typeList')) {
                    logicList.remove(logicList.indexOf('Type__c IN: typeList'));
                }
            }

            if (filterData.startDate != null && filterData.endDate != null) {
                hotelStartDate = date.newInstance(Integer.valueOf(filterData.startDate.substring(0, 4)), Integer.valueOf(filterData.startDate.substring(5, 7)), Integer.valueOf(filterData.startDate.substring(8, 10)));

                hotelEndDate = date.newInstance(Integer.valueOf(filterData.endDate.substring(0, 4)), Integer.valueOf(filterData.endDate.substring(5, 7)), Integer.valueOf(filterData.endDate.substring(8, 10)));

                logicDatesList = '(Check_In_Date__c <=: hotelStartDate AND Check_out_Date__c >=: hotelEndDate) OR (Check_In_Date__c >=: hotelStartDate AND Check_out_Date__c <=: hotelEndDate)';
            }

            if (logicDatesList != '') {
                logicDate1 = ' AND Id NOT IN (Select Room__c FROM Reservation__c WHERE ' + logicDatesList + ' )';
                logicDate2 = ' Id NOT IN (Select Room__c FROM Reservation__c WHERE ' + logicDatesList + ' )';
            } else {
                logicDate1 = '';
                logicDate2 = '';
            }
            if (logicList.size() > 0) {
                logic = ' WHERE ' + String.join(logicList, ' AND ') + logicDate1;
            } else {
                logic = ' WHERE ' + logicDate2;
            }
        }

        queryLogic = 'Select Id,Hotel__r.Name,Hotel__r.MV_TXT_City__c,Hotel__r.MV_SEL_Country__c,Name, (SELECT Id, Name, Check_In_Date__c, Check_out_Date__c, Room__c FROM Reservations__r), Available__c,Type__c,Room_Number__c,photo_url__c,Max_Number_of_Guests__c FROM Room__c' + logic;

        list<Room__c> roomList = Database.query(queryLogic);

        return roomList;
    }

    public static list<Room__c> roomList(list<MV_Hotel__c> hlist) {
        list<Room__c> roomList = [SELECT Id, Name, Hotel__r.Name, Available__c, occupied__c, Mini_Bar__c, Jacuzzi__c, Air_Condition__c, Room_Number__c, Max_Number_of_Guests__c, Type__c, service__c FROM Room__c WHERE MV_Hotel__c IN :hlist];
        return roomList;
    }

    @AuraEnabled(cacheable=true)
    public static list<Room__c> roomList(String h) {
        list<Room__c> roomList = [SELECT Id, Name, Hotel__r.Name, Available__c, occupied__c, Mini_Bar__c, Jacuzzi__c, Air_Condition__c, Room_Number__c, Max_Number_of_Guests__c, Type__c, service__c FROM Room__c WHERE MV_Hotel__c = :h];

        return roomList;
    }

    public static list<Room__c> availableRooms(list<MV_Hotel__c> hlist) {
        list<Room__c> availableRooms = [SELECT Id, Name, Available__c, Type__c, Room_Number__c FROM Room__c WHERE MV_Hotel__c IN :hlist AND Available__c = TRUE];

        return availableRooms;
    }

    public static list<Room__c> occupiedRooms(list<MV_Hotel__c> hlist) {
        list<Room__c> occupiedRooms = [SELECT Id, Name, Available__c, Type__c, Room_Number__c FROM Room__c WHERE MV_Hotel__c IN :hlist AND occupied__c = TRUE];
        return occupiedRooms;
    }

    public static list<Room__c> endReservation() {
        list<Room__c> endReservation = [SELECT Id, Name, Available__c, Type__c, Room_Number__c FROM Room__c WHERE occupied__c = TRUE AND ID IN (SELECT Room__c FROM Reservation__c WHERE Check_out_Date__c = TODAY)];

        return endReservation;
    }
}
