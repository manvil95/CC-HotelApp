trigger roomTrigger on Room__c (before insert) {

    switch on Trigger.operationType {

        WHEN BEFORE_INSERT {

            roomTriggerHandler.beforeInsert(Trigger.New);

    }
        WHEN AFTER_UPDATE {

            roomTriggerHandler.afterUpdate(Trigger.New,Trigger.old);

    }

}
}
