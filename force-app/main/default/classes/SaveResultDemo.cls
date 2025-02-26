public class SaveResultDemo {
    public static void DemoTest(){
        List<Account> accList = new List<Account>{
             new Account(Name='Test SaveResult 1'),
             new Account()
        	};
        Database.SaveResult[] sr = Database.insert(accList, false);
        for(Database.SaveResult s:sr){
           if(!s.isSuccess()){
              for(Database.Error error:s.getErrors()){
					System.debug(error.getMessage());
                    System.debug(error.getFields());
              }
           }
        }  
    }
}