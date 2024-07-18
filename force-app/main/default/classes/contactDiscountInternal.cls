public with sharing class contactDiscountInternal implements IContactDiscount {
    public list<contact> calculateDiscount(list<contact> contactId) {
        list<Contact> contactsToUpdate = new List<Contact>();

        for (contact c : contactId) {
            c.MV_PER_Discount__c = 40;
            contactsToUpdate.add(c);
        }

        return contactsToUpdate;
    }
}
