public class AccountTriggerHandler {
    static boolean alreadyCreated=false;
    public static void beforeInsert(List<Account> accountoldList){
        for(Account a:accountoldList){
        	if(a.AnnualRevenue==null && a.Rating=='Hot'){
            	a.AnnualRevenue=100000;
            }
        }
    }
    
    public static void beforeUpdate(List<Account> accountoldList){
        for(Account a:accountoldList){
        	if(a.AnnualRevenue==null && a.Rating=='Hot'){
            	a.AnnualRevenue=100000;
            }
        }
    }
    
    public static void preventUserFromDeletingAccount(List<Account> oldlist){
        String usernameAdmin = System.label.System_admin_username;
        
        /*Profile p = [Select Id, Name From profile where Name='System administrator'];
        List<User> ulist = [Select Id, ProfileId, userName From User Where ProfileId=:P.Id];
        Map<String,Id> mlist = new Map<String,Id>();
        for(User u:ulist){
            mlist.put(u.UserName, u.Id);
        }
        for(Account a:oldlist){
            if(mlist.containskey(userInfo.getUserName())){
                a.addError('This user cannot delete the Account record');
            }
        }*/
        
       	String profilename = [Select Name from Profile where Id=:UserInfo.getProfileId()][0].Name;
        if(!profileName.equals(usernameAdmin)){
            for(Account a:oldlist){
                a.addError('This user cannot delete the Account record');
            }
        }
    }
    
    public static void createContactOnNumberOfLocations(List<Account> newlist){
        System.debug('Starting createContactOnNumberOfLocations'); 
        System.debug('Current recursive flag state: ' + RecursiveHandler.iscontactcreationdone);
        if(RecursiveHandler.iscontactcreationdone){
            return;
        }
   
        List<Contact> conToCreate = new List<Contact>();
        RecursiveHandler.iscontactcreationdone = true;
        for(Account a:newlist){
            System.debug(a);
            if(a.Number_Of_Locations__c>0){
                integer locations = a.Number_Of_Locations__c.intValue();
                System.debug(locations);
            	for(Integer i=1;i<=locations;i++){
                	Contact c = new Contact();
                    c.FirstName = a.Name;
                    c.LastName = 'test '+i;
                    c.AccountId =a.Id;
                	conToCreate.add(c);
                    System.debug(c);
            	}    
            }
        }
        System.debug(conToCreate);
        try{
            if(!conToCreate.isEmpty())
                insert conToCreate;
        }
        Catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    //Block user from deleting account record if it has open opp or open case
    //1. Get Account records with open opportunity and open case
    //
    public static void updateAccountRecordOnopenOpporOpenCase(List<Account> oldlist){
        List<Account> acclist = [Select Id, (Select Id, StageName From Opportunities Where StageName!='Closed Won' or StageName!='Closed Lost'),
                                 (Select Id, Status from Cases where status!='Closed') From Account where Id In:oldlist];
        // use list with id instead of map
        // use oldmap 
        List<Id> accId = new List<Id>();
        for(Account acc:accList){
            accId.add(acc.Id);
        }
        
       	for(Account a:oldList){
        	if(accId.contains(a.Id))
            	a.addError('Account cannot be deleted which has open opportunities or cases');
        }
    }
    
    //1. get the account records having contacts
    //2. then check if phone number is updated
    //3. if yes then update contact record
    public static void updatePhoneNumberOnContact(List<Account> newlist,Map<Id,Account> oldMap){
        List<Account> alist = [Select Id, (Select Id from Contacts) From Account where Id in:newlist];
        List<Id> accHavingCon = new List<Id>();
        for(Account a:alist){
            if(a.contacts.size()>0)
            	accHavingCon.add(a.Id);
        }
        List<Contact> conlist = [Select Id, Phone from contact where AccountId In:accHavingCon];
        for(Account a:newlist){
            if(oldMap.get(a.Id).Phone != a.Phone && accHavingCon.Contains(a.Id)){
                String conString = Json.serialize(conlist);
                AccountHelper.updateContact(conString, a.Phone);
            }
        }
    }
}