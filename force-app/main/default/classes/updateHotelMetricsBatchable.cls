public with sharing class updateHotelMetricsBatchable implements Database.Batchable<sObject> {

    public String query = 'SELECT Id,MV_DIV_TrailingYearACV__c from MV_Hotel__c';

    public Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

    public void execute(Database.BatchableContext BC, List<MV_Hotel__c> scope){

        list<AggregateResult> ReservationAmount = [SELECT sum(Reservation_Amount__c) amt, Room__r.MV_Hotel__c FROM Reservation__c
                                       where check_in_date__c = LAST_N_MONTHS:12 GROUP BY Room__r.MV_Hotel__c];

        map<Id,Decimal> aggACV = new map<Id,Decimal>();

        for(AggregateResult agg: ReservationAmount){
        aggACV.put((Id)agg.get('MV_Hotel__c'), (Decimal)agg.get('amt'));
        }

        List<MV_Hotel__c> hotelToUpdate = new List<MV_Hotel__c>();

        for(MV_Hotel__c h:scope){

            if(aggACV.containsKey(h.id)){
                    h.MV_DIV_TrailingYearACV__c = aggACV.get(h.id);
            }
            else{
                    h.MV_DIV_TrailingYearACV__c = 0;
                }

        hotelToUpdate.add(h);

        }

    update hotelToUpdate;

    }

   public void finish(Database.BatchableContext BC){
   }

}