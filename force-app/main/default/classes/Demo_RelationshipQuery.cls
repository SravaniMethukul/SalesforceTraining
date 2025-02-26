public class Demo_RelationshipQuery {
    
    //standard object, child to parent (Contact and account)
    public static void standardChildToParent(){
        List<Contact> clist = [Select lastname, Account.Name From Contact LIMIT 5];
        for(Contact con:clist){
            System.debug(con.lastname);
            System.debug(con.Account.Name);
        }
    }
    //custom object, child to parent (employee and department)
    public static void customChildToParent(){
        List<employee__c> elist = [Select employee_name__C, Department__r.Name From Employee__c LIMIT 5];
        for(Employee__c emp:elist){
            System.debug(emp.employee_name__C);
            System.debug(emp.Department__r.Name);
        }
    }
    //standard object, parent to child(account and Contact)
    public static void standardParentToChild(){
        List<Account> accList = [SELECT Name, (SELECT Lastname FROM Contacts) FROM Account LIMIT 5];
        for(Account a:accList){
            System.debug('----Account----');
            System.debug(a.Name);
            if(a.Contacts.Size()>0){
                System.debug('---- contact list----');
            	for(Contact c:a.Contacts){
                	System.debug(c.Lastname);
            	}
            }
        }
    }
    
    @testVisible
    //custom object, parent to child(department and employee)
    private static void customParentToChild(){
        List<Department__c> depList = [SELECT Name, (SELECT Employee_Name__c FROM Employees__r) FROM Department__c LIMIT 5];
        for(Department__c d:depList){
            System.debug('----Department----');
            System.debug(d.Name);
            if(d.Employees__r.Size()>0){
                System.debug('---- Employee list----');
            	for(Employee__c e:d.Employees__r){
                	System.debug(e.Employee_Name__c);
            	}
            }
        }
    }
}