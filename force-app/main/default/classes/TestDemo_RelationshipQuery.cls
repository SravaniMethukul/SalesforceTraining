@isTest
public class TestDemo_RelationshipQuery {
    
    @testSetUp
    public static void loadData(){
        //Test for the Contact Object (Child to parent)
        Account acc = new Account(Name='Account Test Class');
        //Test for Account and Contact (Parent to child)
        Account acc1 = new Account(Name='Sai Test');
        Account acc2 = new Account(Name='Sravani Test');
        List<Account> acclist = new List<Account>{acc,acc1,acc2};
        insert accList;
        
        Contact con = new Contact(LastName='Contact Test Class', AccountId=acc.Id);
        Contact con1 = new Contact(LastName='Contact Test Class 01', AccountId=acc.Id);
        Contact con2 = new Contact(Lastname='Sai Test Contact', AccountId=acc1.Id);
        Contact con3 =  new Contact(LastName='Sravani Test Contact', AccountId=acc1.Id);
        Contact con4 = new Contact(LastName='Hari Test Contact', AccountId=acc2.Id);
        List<Contact> conlist = new List<Contact>{con,con1,con2,con3,con4};
        insert conlist;
        
        //Test for employee and department (Child to parent)
        Department__c dep = new Department__c(Name='Department Test Class');
        //parent to child (Department and employee)
        //Department Records
        Department__c dep1 = new Department__c(Name='Department 01');
        Department__c dep2 = new Department__c(Name='Department 02');
        List<Department__C> deplist = new List<Department__c>{dep, dep1, dep2};
        insert deplist;
       
        Employee__c emp = new Employee__c(Employee_Name__c='Employee Test', Department__c=dep.Id);
        Employee__c emp1 = new Employee__c(Employee_Name__c='Employee Test 01', Department__c=dep.Id);
        Employee__c emp2 = new Employee__c(Employee_Name__c='Employee 01', Department__c=dep1.Id);
        Employee__c emp3 = new Employee__c(Employee_Name__c='Employee 02', Department__c=dep1.Id);
        Employee__c emp4 =  new Employee__c(Employee_Name__c='Employee 03', Department__c=dep2.Id);
        List<Employee__c> emplist = new List<Employee__c>{emp,emp1,emp2,emp3,emp4};
        insert emplist;
        
    }
	
    @isTest
    public static void test_query_child_to_parent(){
        
        List<Account> acc = [select Id, Name From Account Where Name = 'Account Test Class'];
        
        Test.StartTest();
        Demo_RelationshipQuery.standardChildToParent();
        Test.StopTest();
        
        //query results
        List<Contact> conl = [Select LastName, Account.Name From Contact Where AccountId=:acc[0].Id];
        assert.areequal(conl.size(),2,'The number of records is not equal');
        assert.areequal(conl[0].LastName, 'Contact Test Class', 'The Last Name is not equal');
        assert.areequal(Conl[1].LastName, 'Contact Test Class 01', 'The last name is not equal');
        assert.areequal(conl[0].Account.Name, 'Account Test Class', 'The account name is not same');
    } 
    
    @isTest
    public static void test_query_custom_child_to_parent(){
        List<Department__C> dep = [Select Id, Name From Department__c Where Name='Department Test Class'];
        
        //call the method
        Test.StartTest();
        Demo_RelationshipQuery.customChildToParent();
        Test.stopTest();
        
        //query results
        List<Employee__c> empl = [Select Employee_Name__c, Department__r.Name From Employee__c Where Department__c=:dep[0].Id];
        assert.areequal(empl.size(),2,'The number of records is not equal');
        assert.areequal(empl[0].Employee_Name__c, 'Employee Test', 'The Name is not equal');
        assert.areequal(empl[1].Employee_Name__c, 'Employee Test 01', 'The name is not equal');
        assert.areequal(empl[0].Department__r.Name, 'Department Test Class', 'The Department name is not same'); 
    } 
    
    @isTest
    public static void test_query_parent_to_child(){ 
         //call the method
        Test.StartTest();
        Demo_RelationshipQuery.standardParentToChild();
        Test.stopTest();
        
        //query results
        List<Account> queriedaccList = [Select Name, (Select LastName From Contacts) From Account Where Name='Sai Test' OR Name='Sravani Test'];
        // accounts validation
        assert.areequal(2, queriedaccList.size(), 'The number of accounts is not 2');
        assert.areequal(queriedaccList[0].Name, 'Sai Test', 'Account Name is not same');
        assert.areequal(queriedaccList[1].Name, 'Sravani Test', 'Account Name is not same');
        
        //contacts validation
        assert.areequal(2, queriedaccList[0].Contacts.size(), 'The number of contacts is not 2');
        assert.areequal(1, queriedaccList[1].Contacts.size(), 'The number of contacts is not 1');
        
        List<String> SaiTestContactNames = new List<String>();
        for(Contact c: queriedaccList[0].contacts){
            SaiTestContactNames.add(c.LastName);
        }
        
        assert.areequal(SaiTestContactNames.Contains('Sai Test Contact'), 'contact not found');
        assert.areequal(SaiTestContactNames.Contains('Sravani Test Contact'), 'contact not found');
    }
    
    @isTest
    public static void test_query_custom_parent_to_child(){
        
         //call the method
        Test.StartTest();
        Demo_RelationshipQuery.customParentToChild();
        Test.stopTest();
        
        //query results department to employee
        List<Department__c> querieddepList = [SELECT Name, (SELECT Employee_Name__c FROM Employees__r) FROM Department__c Where Name='Department 01' OR Name='Department 02'];
        //department validation
        assert.areequal(2, querieddepList.size(), 'Department count is not 1');
        //assert.areequal(1, querieddepList1.size(), 'Department count is not 1');
        assert.areequal(querieddepList[0].Name, 'Department 01', 'Department name is not same');
        assert.areequal(querieddepList[1].Name, 'Department 02', 'Department name is not same');
        
        //employees count for each department validation
        assert.areequal(2, querieddepList[0].employees__r.size(), 'employee Count is not same');
        assert.areequal(1, querieddepList[1].employees__r.size(), 'employee Count is not same');
        
        //employee name check
        List<String> empl = new List<String>();
        for(Employee__c e: querieddepList[0].Employees__r){
            empl.add(e.Employee_Name__c);
        }
        assert.areequal(empl.contains('Employee 01'), 'Employee not present in the list');
        assert.areequal(empl.contains('Employee 02'), 'Employee not present in the list');
    }
    
}