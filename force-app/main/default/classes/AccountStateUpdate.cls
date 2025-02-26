public class AccountStateUpdate {
	
    public static void execute(List<Account> scope){
        List<Account> accList = new List<Account>();
        for(Account ac:scope){
            ac.billingstate = 'DX';
            acclist.add(ac);
        }
        System.debug(accList);
        if(acclist.size()>0){
            database.saveResult[] result = database.update(acclist, false);
            ErrorLog.databaseErrorLog(result, 'Account Update', 'AccountStateUpdate', 'execute', accList);
        }
        else{
            System.debug('Account list is empty');
        }
    }
}