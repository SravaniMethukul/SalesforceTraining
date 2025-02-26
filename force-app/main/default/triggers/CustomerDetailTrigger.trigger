trigger CustomerDetailTrigger on Customer_Detail__c (before insert,after insert) {
    Switch On Trigger.OperationType{
        when after_insert{
            CustomerDetailTriggerHandler.addUserToAccountTeam(Trigger.new);
        }
    }
}