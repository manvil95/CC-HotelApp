public with sharing class vfCustomController {
    String myname = 'Kuba';

    public string getName() {
        return myname;
    }

    public list<Account> getAccList() {
        return [SELECT Id, Name FROM Account];
    }

    public list<Opportunity> getOppList() {
        return [SELECT Id, Name, Amount FROM Opportunity];
    }
}
