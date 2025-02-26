public class RollBackDemo {
	
    public static void DemoTest(){
		System.savePoint s = Database.setSavePoint();
        Account acc = new Account(Name='Test Rollback');
        insert acc;
        try{
            Contact con = new Contact();
            insert con;
        }
        catch(Exception e){
            System.debug('Exception occoured');
            Database.rollback(s);
        }
        // when the rollback happens the created records won't be stored in recycle bin
        // they are completely removed from org
        List<Account> acclist = [Select Name From Account
                                Where Name='Test Rollback'];
        System.debug(acclist.size());
        
    }
}