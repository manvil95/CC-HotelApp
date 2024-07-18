public with sharing class HotelMapMarker implements IMapMarker{

    public list<sObject> getRecords(){

        return [SELECT Id,Name,MV_SEL_Country__c,MV_TXT_City__c,MV_TXT_PostalCode__c,MV_TXT_Street__c from MV_Hotel__c];
    }

    public list<Object> wrapRecordForUI(list<sObject> sObjectRecords){

        list<MapMarker> mapMarkersList = new list<MapMarker>();

            for(MV_Hotel__c h: (list<MV_Hotel__c>)sObjectRecords){

            MapMarker marker = new MapMarker();
           // MapLocation location = new MapLocation();

            marker.location.City = h.MV_TXT_City__c;
            marker.location.Country = h.MV_SEL_Country__c;
            marker.location.Street = h.MV_TXT_Street__c;
            marker.location.PostalCode = h.MV_TXT_PostalCode__c;


            marker.description = 'This is Hotel description.';
            marker.title = h.Name;
            //marker.location = location;

            mapMarkersList.add(marker);

            }

            return mapMarkersList;


    }


}