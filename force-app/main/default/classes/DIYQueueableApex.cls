public class DIYQueueableApex implements queueable{
    List<AggregateResult> agglist;
    List<Account> acctoupdate = new List<Account>();
    public DIYQueueableApex(List<AggregateResult> agglist){
        this.agglist=agglist;
    }
    public void execute(QueueableContext cxt){
        for(AggregateResult a:agglist){
              	      //highopportunity_account.put((Id)a.get('AccountId'),
                     //                          (Decimal)a.get('Maximum_Amount'));
                    acctoupdate.add(new Account(Id=(Id)a.get('AccountId'),
                                               Highest_Opportunity_Amount__c=(Decimal)a.get('Maximum_Amount')));
            }
        if(!acctoupdate.isEmpty()){
            try {
                update acctoupdate;  // Update all the Accounts that need to be updated
            } catch (Exception e) {
                System.debug('Error occurred while updating Accounts: ' + e.getMessage());
            }
        }
    }
}