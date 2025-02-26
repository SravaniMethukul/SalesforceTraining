trigger UserTrigger on User (before insert, after insert) {
    Switch On Trigger.OperationType{
        when after_insert{
            UserTriggerHandler.createAccountAndAssignPermissionSet(Trigger.new);
        }
    }
}