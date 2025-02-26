@isTest
public class DIYQueueableApexTest {
	@TestSetup
    public static void loadDate(){
        Account a = new Account(Name='Account Test');
        insert a;
        Opportunity o= new Opportunity(Name='Opp Test 1', CloseDate=Date.Today(),stageName='Prospecting', AccountId=a.Id, Amount=200000);
    	Opportunity o1= new Opportunity(Name='Opp Test 2', CloseDate=Date.Today(),stageName='Prospecting', AccountId=a.Id, Amount=5000000);
        insert new List<Opportunity>{o,o1};
    }
    
    @isTest
    public static void testOpportunityAccountUpdation(){
        List<Account> acclist = [Select Id, Highest_Opportunity_Amount__c From Account where Name Like 'Account Test'];
        List<Opportunity> opplist = [Select Name,AccountId,Amount From Opportunity Where Name Like 'Opp Test %'];
        Test.startTest();
        OpportunityTriggerHandler.updateHighestOppAmountInAccount(opplist);
        Test.stopTest();
        assert.AreEqual(opplist[1].Amount, acclist[0].Highest_Opportunity_Amount__c, 'Highest amount updated is not right');
    }
}