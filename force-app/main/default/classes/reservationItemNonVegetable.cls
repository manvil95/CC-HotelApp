public class reservationItemNonVegetable implements reservationLineI {
    public PricebookEntry reservationItem() {
        PricebookEntry i = [
            SELECT Id, Name, Product2Id, UnitPrice
            FROM PricebookEntry
            WHERE Product2.MV_FLG_DefaultBreakfast__c = TRUE AND Pricebook2.IsStandard = TRUE AND Name = 'Breakfast - Non-Vegeterian'
            LIMIT 1
        ];

        return i;
    }
}
