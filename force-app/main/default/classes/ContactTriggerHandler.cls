public class ContactTriggerHandler {
	//Whenever a new contact record is created
	//The count of no of contacts in a account should be calculated and add the count in one of the field in account…
	//Similarly whenever a contact is deleted again the count of contacts should be updated in account..
    public static void updateContactCountInAccount(List<Contact> newlist, Map<Id,Contact> oldmap, Map<Id,Contact> newMap){
        if(RecursiveHandler.iscontantupdatedone){
            return;
        }
        RecursiveHandler.iscontantupdatedone=true;
        set<Id> accIds = new set<Id>();
        if(Trigger.isInsert || Trigger.isDelete){
        	if(newlist!=null){
        		for(Contact c:newlist){
            		if(c.AccountId!=null){
                		accIds.add(c.AccountId);
            		}
        		}
        	}
        }
        // try to use oldmap and newmap, if update record 
        if (Trigger.isupdate) 
        { 
            // use values instead of keyset
            for (Contact c : oldMap.Values()) 
            { 
                if (c.AccountId != null) { 
                    accIds.add(c.AccountId); 
                } 
            } 
            for (Contact c : newMap.Values()) 
            { 
                if (c.AccountId != null) { 
                    accIds.add(c.AccountId); 
                } 
            } 
        }
        System.debug('Accounts in set: '+accIds);
        List<Account> accList = [Select Id, Contact_Count__c, (Select Id, AccountId From Contacts) From Account
                                Where Id In:accIds];
        List<Account> acctoupdate = new List<Account>();
        
        for(Account a:accList){
        	if(a.contacts.size()>=0){
            	Account acc = new Account(Id=a.Id, Contact_Count__c=a.contacts.size());
                acctoupdate.add(acc);
            }
        }
        try{
        	if(!accToUpdate.isEmpty())
        		update accToupdate;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    public static void createContactRelationOnContactCreation(List<Contact> newlist){
        List<Contact_Relationship__c> clist = new List<Contact_Relationship__c>();
        for(Contact c:newlist){
            if(c.Contact_Relationship__c==True){
                Contact_Relationship__c cr = new Contact_Relationship__c(Contact_Relationship_Name__c=c.Full_Name__c+' CR', 
                                                                       Contact__c=c.Id);
                clist.add(cr);
            }        
        }
        try{
        	if(!clist.isEmpty())
        		insert clist;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    public static void onContactDeleteconRelDeleted(List<Contact> oldlist){
        Set<Id> cIds = new Set<Id>();
        for(Contact c:oldlist){
            cIds.add(c.Id);
        }
        List<Contact_Relationship__c> conrel = [Select Id From Contact_Relationship__c Where Contact__c In: cIds];
        try{
        	if(!conrel.isEmpty())
        		delete conrel;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    public static void onContactUnDeleteconRelUnDeleted(List<Contact> newlist){
        Set<Id> cIds = new Set<Id>();
        for(Contact c:newlist){
            cIds.add(c.Id);
        }
        List<Contact_Relationship__c> conrel = [Select Id From Contact_Relationship__c Where Contact__c In: cIds ALL ROWS];
        try{
        	if(!conrel.isEmpty())
        		undelete conrel;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}