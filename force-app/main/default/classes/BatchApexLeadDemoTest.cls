@isTest
public class BatchApexLeadDemoTest {
	@testSetup
    public static void loadData(){
        List<Lead> leadlst = new List<Lead>();
        leadlst.add(new Lead(LastName='Test Lead 1', Company='AJSD', Status='Open - Not Contacted', Description='Test'));
        leadlst.add(new Lead(LastName='Test Lead 2', Company='AJSD', Status='Open - Not Contacted', Description='Test'));
        leadlst.add(new Lead(LastName='Test Lead 3', Company='AJSD', Status='Open - Not Contacted', Description='Test'));
        leadlst.add(new Lead(LastName='Test Lead 4', Company='AJSD', Status='Open - Not Contacted', Description='Test'));
        leadlst.add(new Lead(LastName='Test Lead 5', Company='AJSD', Status='Open - Not Contacted', Description=''));
        insert leadlst;
    }
    @isTest
    public static void testLeadBatch(){
        List<Lead> lst= [Select Id from Lead];
        for(Lead l:lst){
            Test.setCreatedDate(l.Id,Date.today().addDays(-20));
        }
        Test.startTest();
        Database.executeBatch(new BatchApexLeadDemo(),20);
        Test.stopTest();
        List<Lead> updatedlst= [Select Id from Lead where status='Closed Lost' And CreatedDate=LAST_N_DAYS:60];
        Assert.areEqual(4, updatedlst.size(), 'Records updated is not same');
    }
}