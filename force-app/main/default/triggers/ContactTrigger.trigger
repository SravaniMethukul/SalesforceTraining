trigger ContactTrigger on Contact (after insert, before insert, after update, before update, after delete,before delete, after undelete) {
    Switch On Trigger.OperationType{
        When before_insert{
            
        }
        when after_insert{
            ContactTriggerHandler.updateContactCountInAccount(Trigger.new, null, null);
            ContactTriggerHandler.createContactRelationOnContactCreation(Trigger.new);
        }
        when before_update{
            
        }
        when after_update{
            ContactTriggerHandler.updateContactCountInAccount(null,Trigger.oldmap,Trigger.newmap);
        }
        when before_delete{
            ContactTriggerHandler.onContactDeleteconRelDeleted(Trigger.old);
        }
        when after_delete{
            ContactTriggerHandler.updateContactCountInAccount(Trigger.old, null, null);
        }
        when after_undelete{
            ContactTriggerHandler.onContactUnDeleteconRelUnDeleted(Trigger.new);
        }
    }
}