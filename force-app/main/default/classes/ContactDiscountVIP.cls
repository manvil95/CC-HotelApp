public with sharing class ContactDiscountVIP implements IContactDiscount {


    public list<contact> calculateDiscount(list<contact> contactId){

        list<Contact> contactsToUpdate = new list<Contact>();

        for(contact c : contactId){

            c.MV_PER_Discount__c = 70;
            contactsToUpdate.add(c);
        }

        return contactsToUpdate;
    }
}