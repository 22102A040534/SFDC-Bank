trigger MinimumBalanceTrigger on Bank_Account__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            BankAccountTriggerHandler.updateAccountStatus(Trigger.new);
        }
    }

}