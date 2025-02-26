@isTest
public class Test_AccountTriggerHandler {
    @TestSetup
    static void setup() {
        // Insert a test Account record
        Account testAcc1 = new Account(Name = 'Test Account 1', Rating='Hot');
        Account testAcc2 = new Account(Name = 'Test Account 2', Rating='Warm');
        insert new list<Account>{testAcc1,testAcc2};
    }

	@isTest
    public static void testBeforeUpdate() {
        Account testAccount1 = new Account(Name = 'Test Account Data 1', Rating='Hot', AnnualRevenue=2000);
        Account testAccount2 = new Account(Name = 'Test Account Data 2', Rating='Hot', AnnualRevenue=3000);
        insert new List<Account>{testAccount1,testAccount2};
        List<Account> oldAcct = [SELECT Id,AnnualRevenue,Rating FROM Account Where Name Like 'Test Account Data%'];
        for(Account a:oldAcct){
            a.AnnualRevenue=null;
        }
        // Call the beforeUpdate method
        Test.startTest();
        update oldAcct;
        Test.stopTest();
        
        // Verify that the AnnualRevenue has been set
        List<Account> updatedAccount = [SELECT Id,AnnualRevenue FROM Account Where Name Like 'Test Account Data%'];
        System.assertEquals(100000, updatedAccount[0].AnnualRevenue);
        System.assertEquals(100000, updatedAccount[1].AnnualRevenue);
    }
	@isTest
    public static void testUserCannotDeleteAccount(){
        List<Account> oldAccountList = [Select Id, Name From Account];
        Profile p = [SELECT Id FROM Profile WHERE Name='System administrator'];
        User u = new User(Alias = 'standt', email='methukulasravani@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles',Username='sravani@ajsd.com');
        insert u;
        System.runAs(u){
            Test.startTest();
            try {
                delete oldAccountList; 
            } catch (DmlException e) {
                System.assert(e.getMessage().contains('This user cannot delete the Account record'));
            }
            Test.stopTest();
        }
        List<Account> deletedlist = [Select Id, Name From Account];
        System.assertEquals(2, deletedlist.size(), 'Account was not deleted');
    }
    
    @isTest
    public static void testcreateContactOnNumberOfLocations(){
        // Create test accounts with specified Number_Of_Locations__c values
    	List<Account> accountList = new List<Account>{
        	new Account(Name = 'Account 1', Number_Of_Locations__c = 2),
        	new Account(Name = 'Account 2', Number_Of_Locations__c = 3)
    	};
        Test.startTest();
        insert accountList;
        Test.stopTest();
        // Fetch the updated accounts with related contacts 
        List<Account> updatedAccounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account Where Name Like 'Account%']; 
        System.debug('Accounts List after Contact Creation: ' + updatedAccounts); 
        // Debug statements to see the contacts count for each account 
        for (Account acc : updatedAccounts) 
        { 
            System.debug('Account: ' + acc.Id + ', Contact Count: ' + acc.Contacts.size()); 
        }
        for(Account a:updatedAccounts){
        	if(a.Id==updatedAccounts[0].id)
            	assert.areEqual(updatedAccounts[0].Contacts.size(),2,'contact count not updated');
            else if(a.Id==updatedAccounts[1].id)
                assert.areEqual(updatedAccounts[1].Contacts.size(),3,'contact count not updated');
        }
    }
}