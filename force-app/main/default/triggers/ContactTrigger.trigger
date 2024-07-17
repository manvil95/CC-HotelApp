trigger ContactTrigger on Contact (before update) {



    switch on Trigger.operationType {

    when BEFORE_UPDATE{

      ContactTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
      system.debug('Trigger before updated ended!');

     for(contact c : trigger.New){

        system.debug(c.MV_PER_Discount__c);
     }
    }
  }

}