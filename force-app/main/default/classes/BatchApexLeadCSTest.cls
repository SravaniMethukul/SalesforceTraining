@isTest
public class BatchApexLeadCSTest {
    @testSetup
    public static void loadData(){
        List<Lead> leadlst = new List<Lead>();
        leadlst.add(new Lead(LastName='Test Lead 1', Company='AJSD', Status='Open - Not Contacted'));
        leadlst.add(new Lead(LastName='Test Lead 2', Company='AJSD', Status='Open - Not Contacted'));
        leadlst.add(new Lead(LastName='Test Lead 3', Company='AJSD', Status='Open - Not Contacted'));
        leadlst.add(new Lead(LastName='Test Lead 4', Company='AJSD', Status='Open - Not Contacted'));
        leadlst.add(new Lead(LastName='Test Lead 5', Company='AJSD', Status='Open - Not Contacted'));
        insert leadlst;
    }
    @isTest
    public static void testLeadBatch(){
        List<Lead> lst= [Select Id, LastModifiedById, Days_Since_Last_Activity__c from Lead];
        for(Lead l:lst){
            Test.setCreatedDate(l.Id,Date.today().addDays(-6));
        }
        System.debug(lst);
        Test.startTest();
        Database.executeBatch(new BatchApexLeadCS(),20);
        Test.stopTest();
        List<Lead> updatedlst= [Select Id, ownerId, location__c from Lead where Name Like 'Test Lead %'];
        Assert.arenotEqual(updatedlst[0].ownerId,'' , 'Records owner is not updated');
        List<Task> taskcreated = [Select Id from Task where whoId In: lst];
        Assert.areEqual(taskcreated, '', 'Records owner is not updated');
    }
}