public with sharing class ContactTriggerHandler {


    public static void beforeUpdate(list<Contact> newContact, map<Id,contact> oldMap){


        list<contact> customerStatusRecalc = new list<contact>();

        for(contact c : newContact){

            if(c.MV_SEL_CustomerType__c != oldMap.get(c.Id).MV_SEL_CustomerType__c){

                system.debug('New Record != old record');

                customerStatusRecalc.add(c);
            }

        }

        if(!customerStatusRecalc.isEmpty()){

            system.debug(customerStatusRecalc);

       map<Id,contact> updatedContactsMap = new map<Id,Contact>(Guest_Service.discountCalculator(customerStatusRecalc));

       for(contact c :newContact){

        c.MV_PER_Discount__c = updatedContactsMap.get(c.Id).MV_PER_Discount__c;
        system.debug(updatedContactsMap.get(c.Id).MV_PER_Discount__c);

       }



        }

    }

}