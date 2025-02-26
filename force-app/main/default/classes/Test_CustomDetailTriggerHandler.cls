@isTest
public class Test_CustomDetailTriggerHandler {
	@istest
    public static void testAddUserToAccountTeam(){
        Account a = new Account(Name='Account 1');
        Account a1 = new Account(Name='Account 2');
        insert new list<Account>{a,a1};
        user u = [Select Id from User where Name='SalesRep Priti'];
        Customer_Detail__c c = new Customer_Detail__c(Account__c=a.Id,Account_Manager__c=u.Id);
        Customer_Detail__c c1 = new Customer_Detail__c(Account__c=a1.Id,Account_Manager__c=u.Id);
        List<Customer_Detail__c> cdlist = new List<Customer_Detail__c>{c, c1};
        
        Test.startTest();
        insert cdlist;
        Test.stopTest();
        List<Account> accupdatedlist = [Select Id, (Select Id,userId From AccountTeamMembers) From Account where Name Like 'Account%'];
        for(Account acc:accupdatedlist){
        	assert.areEqual(1, acc.AccountTeamMembers.size(), 'Team member is not updated');
            assert.areEqual(u.Id, acc.AccountTeamMembers[0].userId, 'User Id is not updated correctly');
        }
    }
}