@istest
public class BatchApexOpportunityDIYTest {
	@testSetup
    public static void loadData(){
        List<Opportunity> opplst = new List<Opportunity>();
        opplst.add(new Opportunity(Name='Test Opp 1', CloseDate = Date.today().addDays(-10), StageName='Prospecting', Description=''));
        opplst.add(new Opportunity(Name='Test Opp 2', CloseDate = Date.today().addDays(-10), StageName='Prospecting', Description='Added'));
        opplst.add(new Opportunity(Name='Test Opp 2', CloseDate = Date.today().addDays(-10), StageName='Prospecting', Description='Added'));
        insert opplst;
    }
    @isTest
    public static void testLeadBatch(){
        List<Opportunity> lst= [Select Id from Opportunity];
        for(Opportunity l:lst){
            Test.setCreatedDate(l.Id,Date.today().addDays(-20));
        }
        Test.startTest();
        Database.executeBatch(new BatchApexOpportunityDIY(),20);
        Test.stopTest();
        List<Opportunity> updatedlst= [Select Id from Opportunity where stageName='Closed' And CloseDate < Today];
        Assert.areEqual(2, updatedlst.size(), 'Records updated is not same');
    }
}