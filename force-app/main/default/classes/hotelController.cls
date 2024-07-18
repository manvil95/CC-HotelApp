public class hotelController {


    public static void roomNumber() {
    list<Hotel__c> hotels = [Select Id,Name,MV_FOR_RatingStars__c FROM Hotel__c];
    Map<Id, Hotel__c> hotelMap = new Map<Id, Hotel__c>(hotels);
    }

    @AuraEnabled (cacheable = true)
    public static list<AggregateResult> countryList(){
        return  [SELECT MV_SEL_Country__c FROM Hotel__c WHERE MV_SEL_Country__c <> NULL GROUP BY MV_SEL_Country__c];
    }

       @AuraEnabled (cacheable = true)
    public static list<AggregateResult> cityList(String countryName){

        String Country = countryName;

        if(String.isEmpty(Country)){

            return  [SELECT MV_TXT_City__c FROM Hotel__c WHERE MV_TXT_City__c <> NULL GROUP BY MV_TXT_City__c];

        } else {

            return  [SELECT MV_TXT_City__c FROM Hotel__c WHERE MV_TXT_City__c <> NULL AND MV_SEL_Country__c =: Country GROUP BY MV_TXT_City__c];
        }


    }

    @AuraEnabled (cacheable = true)
    public static list<AggregateResult> hotelList(String countryName,String cityName){

        String CountryFilter = countryName;
        String CityFilter = cityName;

        list<String> formulaKeys = new list<String>{};
        String formula = '';

       if(!String.isEmpty(CountryFilter)){
        formulaKeys.add('MV_SEL_Country__c =: CountryFilter');
       }

      if(!String.isEmpty(CityFilter)){
        formulaKeys.add('MV_TXT_City__c =: CityFilter');
       }

      if(formulaKeys.size()>0){
        formula = ' WHERE ' + String.join(formulaKeys, ' AND ');
      }

        String query = 'SELECT Id,Name FROM Hotel__c' + formula + ' LIMIT 10';

        return Database.query(query);

}
    @AuraEnabled (cacheable = true)
    public static list<Hotel__c> hotelListDropdown(){

        return [SELECT Id,Name,MV_DIV_TrailingYearACV__c,MV_NUM_TotalRooms__c,MV_NUM_TotalRentedRooms__c,MV_NUM_RoomsOutOfService__c,MV_FOR_RatingStars__c,MV_SEL_Rating__c,MV_FOR_RatingStars__c,MV_TXT_City__c,MV_SEL_Country__c from Hotel__c];

}

  @AuraEnabled (cacheable = true)
    public static Hotel__c returnHotelData(String Hid){

        return [SELECT Id,Name,MV_DIV_TrailingYearACV__c,MV_NUM_TotalRooms__c,MV_FOR_RatingStars__c,MV_NUM_TotalRentedRooms__c,MV_NUM_RoomsOutOfService__c,MV_FOR_RatingStars__c,MV_SEL_Rating__c,MV_TXT_City__c,MV_SEL_Country__c from Hotel__c WHERE Id =: Hid];

    }
}