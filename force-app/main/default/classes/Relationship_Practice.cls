public class Relationship_Practice {
	//custom parent (Department) and custom child (employee)
    public static void customParentToChild(){
        List<Department__c> deplist = [Select Name, (Select Employee_Name__c From Employees__r) 
                                      From Department__c];
        for(Department__c d:deplist){
            System.debug('Department is');
            System.debug(d.Name);
			System.debug('Employees are');            
            for(Employee__c e:d.Employees__r){
                System.debug(e.Employee_Name__c);
            }
        }
    }
    
    //standard parent to child
    public static void standardParentAndChild(){
        List<Account> accList = [Select Name, (Select LastName From Contacts)
                                From Account];
        for(Account acc:accList){
            System.debug('Account is');
            System.debug(acc.Name);
            if(acc.contacts.size()>0){
                System.debug('Related Contacts are:');
                for(Contact c:acc.Contacts){
                    System.debug(c.LastName);
                }
            }
        }
    }
    
    //custom child to standard parent (always use __r in (custom child) to (custom or standard parent) relationship )
    public static void customChildToStandardParent(){
        List<Department__c> deplist = [Select Name, Account__r.Name From Department__c];
        for(Department__C d:deplist){
            System.debug(d.Name);
            System.debug(d.Account__r.Name);
        }
        
    }
    
}