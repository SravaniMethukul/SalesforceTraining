@isTest
public class Test_CustomProjectHandler {
	@isTest
    public static void testupdateActiveFieldInOpportunity(){
        Opportunity o=new Opportunity(Name='Opp 1');
        List<Opportunity> oppList = new List<Opportunity>{
        		    new Opportunity(Name='Opp 1', CloseDate=Date.Today(),StageName='Prospecting'),
                    new Opportunity(Name='Opp 2', CloseDate=Date.Today(),StageName='Prospecting')};
        insert oppList;
        List<Custom_Project__c> cplist = new List<Custom_Project__c>{
            					new Custom_Project__c(Name='Project 1',status__c='Active',Opportunity__c=opplist[0].Id),
            					new Custom_Project__c(Name='Project 2',status__c='InActive',Opportunity__c=opplist[1].Id)};
        Test.startTest();
        insert cplist;
        Test.stopTest();
        List<Opportunity> updatedopplist = [Select Id, Active_Customer_Project__c From Opportunity];
        assert.areEqual(true, updatedopplist[0].Active_Customer_Project__c,'Active project is not checked');
        assert.areEqual(false, updatedopplist[1].Active_Customer_Project__c,'Active project is checked');
    }
}