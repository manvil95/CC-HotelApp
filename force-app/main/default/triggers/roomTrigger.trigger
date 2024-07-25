trigger roomTrigger on MV_Room__c(before insert, after update, after insert) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            roomTriggerHandler.beforeInsert(Trigger.New);
        }
        when AFTER_UPDATE {
            roomTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
        }
        when AFTER_INSERT {
            roomTriggerHandler.afterInsert(Trigger.New);
        }
    }
}
