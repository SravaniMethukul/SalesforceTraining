public class DIY_12_RefactorCode {
    public static void testClass(){
        List<Employee__c> emplist = [Select Id, Employee_name__c from Employee__c Limit 1];
        for(Employee__c emp:emplist)
        {
            emp.Employee_name__c = emp.Employee_name__c+' Refactor';
        }
        update emplist;
    }
    public static void testClass2(){
		List<Account> acclist = new List<Account>();
        for(Integer i=0;i<150;i++){
            Account acc=new Account();
            acc.Name = 'Test' + i;
            acclist.add(acc);
        }
        insert acclist;
    }
    public static void testClass3(){
        Contact con = new Contact();
        for(Account acc: [Select Id, Name from Account Limit 1]){
            con.AccountId = acc.Id;
            con.LastName = 'Surname ' + acc.Name;
        }
        insert con;
    }
    
    public static void testClass4(){
        List<Account> accList = [Select Id, Name From Account Where Name Like 'Suhas Test%'];
        delete accList;
    }
}