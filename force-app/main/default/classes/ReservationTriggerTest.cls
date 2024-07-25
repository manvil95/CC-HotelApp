@isTest(SeeAllData=true)
public class ReservationTriggerTest {
    @isTest(SeeAllData=true)
    static void testMethod1() {
        PricebookEntry defaultPricebook = [SELECT Id, Name, Product2Id, UnitPrice FROM PricebookEntry WHERE Product2.MV_FLG_DefaultReservation__c = TRUE];
        Contact guest = [SELECT Id, Name, FirstName, LastName FROM Contact LIMIT 1];

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', MV_PER_Discount__c = 0);

        insert testContact;

        MV_Hotel__c testHotel = new MV_Hotel__c(Name = 'Test', MV_TXT_City__c = 'Test city');

        insert testHotel;

        MV_Room__c testRoom = new MV_Room__c(Name = 'test Room', MV_Hotel__c = testHotel.Id);

        insert testRoom;

        Reservation__c rr = new Reservation__c(
            Name = 'Reservation TestSetup',
            Guest_name__c = testContact.Id,
            MV_Room__c = testRoom.Id,
            Check_In_Date__c = date.newInstance(Date.today().year(), Date.today().month(), date.today().day()),
            Check_out_Date__c = date.newInstance(Date.today().year(), Date.today().month(), date.today().day()),
            Cancelation_fee_covered__c = false
        );

        try {
            insert rr;
        } catch (DmlException e) {
            system.debug(e.getMessage());
        }

        List<Reservation__c> newReservations = new List<Reservation__c>();

        for (integer i = 1; i < 3; i++) {
            Reservation__c r = new Reservation__c(
                Name = 'Reservation ' + i,
                Guest_name__c = guest.Id,
                MV_Room__c = testRoom.Id,
                Check_In_Date__c = i > 1 ? date.newInstance(Date.today().year(), Date.today().month(), date.today().day()) : date.newInstance(Date.today().year(), Date.today().month(), date.today().day() + 2),
                Check_out_Date__c = i > 1 ? date.newInstance(Date.today().year(), Date.today().month(), date.today().day() + 1) : date.newInstance(Date.today().year(), Date.today().month(), date.today().day() + 4)
            );

            newReservations.add(r);
        }

        try {
            // Database.Insert(newReservations, false);
            system.debug(newReservations);
            insert newReservations;
        } catch (DmlException e) {
            system.debug('Insert reserrvation test message: ' + e.getMessage());
            Boolean expectedExceptionThrown = e.getMessage().contains('Please choose different room or different date.') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        list<Reservation__c> testReservations = [SELECT Id, Name, Check_In_Date__c, Check_out_Date__c, MV_Room__c FROM Reservation__c WHERE MV_Room__c = :testRoom.Id];

        //  System.assertEquals(2, testReservations.size());

        Reservation__c r1 = new Reservation__c(
            Name = 'Reservation  test f',
            Guest_name__c = guest.Id,
            MV_Room__c = testRoom.Id,
            Check_In_Date__c = date.newInstance(Date.today().year(), Date.today().month() + 1, date.today().day()),
            Check_out_Date__c = date.newInstance(Date.today().year(), Date.today().month() + 1, date.today().day() + 2)
        );

        try {
            // Database.Insert(newReservations, false);
            insert r1;
            system.debug('inserted record = ' + r1);
        } catch (DmlException f) {
            system.debug(f.getMessage());
        }

        list<Reservation__c> rtest = [SELECT id, Name, Check_In_Date__c, Check_out_Date__c FROM Reservation__c WHERE MV_Room__c = :testRoom.Id];
        MV_Room__c roomTest = [SELECT id, MV_FLG_Available__c, MV_FLG_Occupied__c FROM MV_Room__c WHERE id = :testRoom.Id];

        system.debug(rtest);
        system.assertEquals(2, rtest.size());
        system.assertEquals(roomTest.MV_FLG_Occupied__c, true);

        // test delete reservation

        Reservation__c delReservation = [SELECT Id, Name FROM Reservation__c WHERE Name = 'Reservation TestSetup'];

        try {
            delete delReservation;
        } catch (DmlException d1) {
            system.debug(d1.getMessage());
            Boolean expectedExceptionThrown = d1.getMessage().contains('You can not cancel this reservation') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);
        }

        Reservation__c r1delete = new Reservation__c(
            Name = 'Reservation  test f',
            Guest_name__c = guest.Id,
            MV_Room__c = testRoom.Id,
            Check_In_Date__c = date.newInstance(Date.today().year(), Date.today().month(), date.today().day() + 5),
            Check_out_Date__c = date.newInstance(Date.today().year(), Date.today().month(), date.today().day() + 9),
            Cancelation_fee_covered__c = false,
            Breakfast__c = true,
            Breakfast_Type__c = 'Vegetarian'
        );

        try {
            insert r1delete;
        } catch (DmlException d3) {
            system.debug(d3.getMessage());
        }

        List<Reservation_line_item__c> testBreakfast = [SELECT id, Name FROM Reservation_line_item__c WHERE Reservation__c = :r1delete.Id];
        system.assertEquals(2, testBreakfast.size());

        try {
            delete r1delete;
        } catch (DmlException d2) {
            system.debug(d2.getMessage());
            Boolean expectedExceptionThrown = d2.getMessage().contains('You can not cancel this reservation') ? true : false;
            system.assertEquals(expectedExceptionThrown, false);
        }
    }
}
