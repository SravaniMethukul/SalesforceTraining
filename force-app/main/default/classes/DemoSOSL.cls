public class DemoSOSL {
    public static void fetchRecords(){
        List<List<sObject>> searchList = [Find 'United' IN NAME FIELDS returning Account(name), Contact(LastName)];
        List<Account> acclist = searchList[0];
        for(Account a:acclist){
            System.debug(a.Name);
        }
        
        List<Contact> conlist = searchList[1];
        for(Contact c:conlist){
            System.debug(c.LastName);
        }
        
        Account acc = [Select Name from Account Limit 1];
        system.debug(acc.Name);
        
        sObject acc1 = [Select Name from Account Limit 1];
        system.debug(((Account)acc).name);
    }
}