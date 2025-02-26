trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete) {
	Switch On Trigger.OperationType{
        when after_insert{
            OpportunityLineItemTriggerHandler.updateOpportunityProductCode(Trigger.new);
        }
        when after_update{
           
        }
        when after_delete{
            OpportunityLineItemTriggerHandler.updateOpportunityProductCode(Trigger.old);
        }
    }
}