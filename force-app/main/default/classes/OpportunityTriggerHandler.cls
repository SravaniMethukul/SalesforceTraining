public class OpportunityTriggerHandler {
    public static void updateHighestOppAmountInAccount(List<Opportunity> newlist){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp:newlist){
        	accIds.add(opp.AccountId);
        }
        List<Account> acctoupdate = new List<Account>();
        if(!accIds.isEmpty()){
        	List<AggregateResult> accAggregate = [Select AccountId, Max(Amount) Maximum_Amount
                                                     From Opportunity
                                                     Where AccountId IN: accIds
                                                     Group By AccountId];
            System.enqueuejob(new DIYQueueableApex(accAggregate));
            
           /* for(AggregateResult a:accAggregate){
              	      //highopportunity_account.put((Id)a.get('AccountId'),
                     //                          (Decimal)a.get('Maximum_Amount'));
                    acctoupdate.add(new Account(Id=(Id)a.get('AccountId'),
                                               Highest_Opportunity_Amount__c=(Decimal)a.get('Maximum_Amount')));
            }
        }
        if(!acctoupdate.isEmpty()){
            try {
                update acctoupdate;  // Update all the Accounts that need to be updated
            } catch (Exception e) {
                System.debug('Error occurred while updating Accounts: ' + e.getMessage());
            }
        }*/
		}
    }
    
    public static void updateOppLineItemProductCodeOnPriceBookupdate(List<Opportunity> newlist, Map<Id,Opportunity> oldmap){
        for(Opportunity o:newlist){
            if(o.Pricebook2Id!=oldMap.get(o.Id).Pricebook2Id){
                o.Oppr_LineItems_ProductCode__c='';
            }
        } 
    }
}