trigger OpportunityTrigger on Opportunity (After insert, before update) {
    //for(Opportunity record:Trigger.New)//list of opportunity created now
    //{
    //    Decimal discount=DemoCustomMetadata.calculateDiscount(record.Type);
    //    record.Discount__c = discount;
    //}
    Switch on Trigger.operationType{
        When after_insert{
            OpportunityTriggerHandler.updateHighestOppAmountInAccount(Trigger.New);
        }
        When before_update{
            OpportunityTriggerHandler.updateOppLineItemProductCodeOnPriceBookupdate(Trigger.new,Trigger.oldMap);
        }
    }
    
    
}