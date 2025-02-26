@istest
public class Test_ContactTriggerHandler {
	@TestSetUp
    public static void loadData(){
        Account a = new Account(Name='Account Test');
        Account a1 = new Account(Name='Account Test 1');
        insert new List<Account>{a,a1};
        Contact c = new Contact(LastName='Test contact 1', AccountId=a.Id);
        Contact c1 = new Contact(LastName='Test contact 2', AccountId=a.Id);
        Contact c2 = new Contact(LastName='Test contact 3', AccountId=a1.Id);
        List<Contact> conlist = new List<Contact>{c,c1,c2};
        insert conlist;
        System.debug('Contacts list: '+conlist);
    }
    
    @istest
    public static void testupdateContactCountInAccountWhenInsert(){
        Account a = new Account(Name='Account Contact Test');
        Account a1 = new Account(Name='Account Contact Test 1');
        insert new List<Account>{a,a1};
        List<Account> acclist = [Select Id,Contact_Count__c From Account Where Name Like 'Account Contact%'];
        Contact c = new Contact(LastName='Test contact 1', AccountId=a.Id);
        Contact c1 = new Contact(LastName='Test contact 2', AccountId=a.Id);
        Contact c2 = new Contact(LastName='Test contact 3', AccountId=a1.Id);
        List<Contact> conlist = new List<Contact>{c,c1,c2};
        System.debug('Contacts list: '+conlist);
        Test.startTest();
        insert conlist;
        Test.stopTest();
        List<Account> updatedAccount = [Select Id,Contact_Count__c From Account Where Name Like 'Account Contact%'];
        for(Account acc:updatedAccount){
            if(acc.Id==acclist[0].id)
            	assert.areEqual(Integer.valueOf(acc.Contact_Count__c),2,'contact count not updated');
            else if(acc.Id==acclist[1].id)
                assert.areEqual(Integer.valueOf(acc.Contact_Count__c),1,'contact count not updated');
        }
   }
    
    @istest
    public static void testupdateContactCountInAccountWhenUpdate(){
        List<Account> accounts = [SELECT Id FROM Account]; 
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact]; 
        system.debug('contacts: '+contacts);
        // Create new and old map 
        Map<Id, Contact> oldMap = new Map<Id, Contact>(); 
        Map<Id, Contact> newMap = new Map<Id, Contact>(); 
        for (Contact c : contacts) { 
            oldMap.put(c.Id, c);
            newMap.put(c.Id, c); 
        }
        Contact cupdate = newMap.values()[2];
        cupdate.AccountId=accounts[0].Id;
        Test.startTest();
        update cupdate;
        //update in map
        newMap.put(cupdate.Id, cupdate);
        Test.stopTest();
        List<Account> updatedAccount = [Select Id,Contact_Count__c From Account];
        for(Account a:updatedAccount){
            if(a.Id==accounts[0].id)
            	assert.areEqual(Integer.valueOf(a.Contact_Count__c),3,'contact count not updated');
            else if(a.Id==accounts[1].id)
                assert.areEqual(Integer.valueOf(a.Contact_Count__c),0,'contact count not updated');
        }
   }
   
   @istest
    public static void testupdateContactCountInAccountWhenDelete(){
        List<Account> accounts = [SELECT Id FROM Account]; 
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact]; 
        Test.startTest();
        delete contacts[0];
        Test.stopTest();
        List<Account> updatedAccount = [Select Id,Contact_Count__c From Account];
        for(Account a:updatedAccount){
            if(a.Id==accounts[0].id)
            	assert.areEqual(Integer.valueOf(a.Contact_Count__c),1,'contact count not updated');
            else if(a.Id==accounts[1].id)
                assert.areEqual(Integer.valueOf(a.Contact_Count__c),1,'contact count not updated');
        }
   }
    
	@istest
    public static void testcreateContactRelationOnContactCreation(){
        Contact c = new Contact(LastName='contact 1', Contact_Relationship__c=True);
        Contact c1 = new Contact(LastName='contact 2', Contact_Relationship__c=False);
        List<Contact> conlist = new List<Contact>{c,c1};
        Test.startTest();
        insert conlist;
        Test.stopTest();
        List<Contact_relationship__c> conrellist = [Select Name, Contact__c From Contact_relationship__c where Contact__c In: new list<Id>{c.Id,c1.Id}];
        assert.areEqual(1, conrellist.size(), 'Contact Relationship was not created for contact 1');
        assert.areEqual(c.Id, conrellist[0].Contact__c, 'The Contact_Relationship__c record is not linked correctly to contact 1');
   }
   
    @isTest
    public static void testonContactDeleteconRelDeleted(){
        Contact c = new Contact(LastName='contact 1', Contact_Relationship__c=True);
        Contact c1 = new Contact(LastName='contact 2', Contact_Relationship__c=True);
        List<Contact> conlist = new List<Contact>{c,c1};
        insert conlist;
        List<Contact_Relationship__c> conrellist = [Select Id, Contact__c From Contact_Relationship__c where Contact__c In: new list<Id>{c.Id,c1.Id}];
        Map<Id, Contact_Relationship__c> maplist = new Map<Id,Contact_Relationship__c>();
        for(Contact_Relationship__c co:conrellist){
            maplist.put(co.Id,co);
        }
        Test.startTest();
        List<Contact> conTodelete = [Select Id From Contact where Id In: new list<Id>{c.Id,c1.Id}];
        delete conTodelete;
        Test.stopTest();
        List<Contact_Relationship__c> updatedConRelList = [select Id, Contact__c 
        												   from Contact_Relationship__c 
        												   where Id IN :maplist.keySet()];
        for(Contact_Relationship__c ucon:updatedConRelList)
        	assert.areEqual(null, ucon.contact__c, 'Contact Id not removed from contact relationship record');
    }
    
    @isTest
    public static void testonContactUndeleteconRelUndeleted(){
        Contact c = new Contact(LastName='contact 1', Contact_Relationship__c=True);
        Contact c1 = new Contact(LastName='contact 2', Contact_Relationship__c=True);
        List<Contact> conlist = new List<Contact>{c,c1};
        insert conlist;
        List<Contact_Relationship__c> conrellist = [Select Id, Contact__c From Contact_Relationship__c where Contact__c In: new list<Id>{c.Id,c1.Id}];
        Map<Id, Contact_Relationship__c> maplist = new Map<Id,Contact_Relationship__c>();
        for(Contact_Relationship__c co:conrellist){
            maplist.put(co.Id,co);
        }
        delete conlist;
        Test.startTest();
        List<Contact> conToundelete = [Select Id From Contact where Id In: new list<Id>{c.Id,c1.Id} ALL ROWS];
        undelete conToundelete;
        Test.stopTest();
        List<Contact_Relationship__c> updatedConRelList = [select Id, Contact__c 
        												   from Contact_Relationship__c 
        												   where Id IN :maplist.keySet()];
        
       assert.areEqual(c.Id, updatedConRelList[0].contact__c, 'Contact Id is removed from contact relationship record');
       assert.areEqual(c1.Id, updatedConRelList[1].contact__c, 'Contact Id is removed from contact relationship record');
    }
}