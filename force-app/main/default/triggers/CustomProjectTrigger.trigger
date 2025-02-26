trigger CustomProjectTrigger on Custom_Project__c (before insert,after insert) {
    Switch on Trigger.OperationType{
        when after_insert{
            CustomProjectHandler.updateActiveFieldInOpportunity(Trigger.new);
        }
    }
}