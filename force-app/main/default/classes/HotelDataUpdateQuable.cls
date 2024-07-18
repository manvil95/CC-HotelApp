public class HotelDataUpdateQuable {
    @future
    public static void HotelDataCountUpdate(list<Id> recordIds) {
        map<Id, Integer> HotelServiceCT = new Map<id, Integer>();
        map<Id, Integer> HotelAvialableCT = new Map<id, Integer>();
        map<Id, Integer> HotelRentedleCT = new Map<id, Integer>();

        list<MV_Hotel__c> HotelUpdateList = new List<MV_Hotel__c>();

        //Prepare DATA

        AggregateResult[] aggService = [SELECT MV_Hotel__c, count(Id) ct FROM Room__c WHERE MV_Hotel__c IN :recordIds AND Service__c = TRUE GROUP BY MV_Hotel__c];

        AggregateResult[] aggAvailable = [SELECT MV_Hotel__c, count(Id) ct FROM Room__c WHERE MV_Hotel__c IN :recordIds AND service__c != TRUE AND occupied__c != TRUE GROUP BY MV_Hotel__c];

        AggregateResult[] aggOccupied = [SELECT MV_Hotel__c, count(Id) ct FROM Room__c WHERE MV_Hotel__c IN :recordIds AND occupied__c = TRUE GROUP BY MV_Hotel__c];

        for (AggregateResult ar : aggService) {
            HotelServiceCT.put((Id) ar.get('MV_Hotel__c'), (Integer) ar.get('ct'));
        }
        for (AggregateResult arAvailable : aggAvailable) {
            HotelAvialableCT.put((Id) arAvailable.get('MV_Hotel__c'), (Integer) arAvailable.get('ct'));
        }
        for (AggregateResult arOccupied : aggOccupied) {
            HotelRentedleCT.put((Id) arOccupied.get('MV_Hotel__c'), (Integer) arOccupied.get('ct'));
        }

        for (MV_Hotel__c h : [SELECT Id, MV_NUM_RoomsOutOfService__c FROM MV_Hotel__c WHERE Id IN :recordIds]) {
            if (aggService.size() == 0) {
                h.MV_NUM_RoomsOutOfService__c = 0;
            } else {
                h.MV_NUM_RoomsOutOfService__c = HotelServiceCT.get(h.Id);
            }
            h.MV_FOR_RatingStars__c = HotelAvialableCT.get(h.Id);
            h.MV_NUM_TotalRentedRooms__c = HotelRentedleCT.get(h.Id);

            HotelUpdateList.add(h);
        }
        update HotelUpdateList;
    }
}
