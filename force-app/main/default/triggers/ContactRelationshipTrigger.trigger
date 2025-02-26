trigger ContactRelationshipTrigger on Contact_Relationship__c (before insert, before update, after update) {
	Switch On Trigger.OperationType{
        When before_update{
           ContactRelationshipTriggerHandler.onOwnerUpdateNameChanges(Trigger.new,Trigger.oldMap);
        }
        When after_update{
          
        }
    }
}