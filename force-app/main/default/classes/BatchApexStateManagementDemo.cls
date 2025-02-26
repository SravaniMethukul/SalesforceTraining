public class BatchApexStateManagementDemo implements Database.Batchable<Sobject>,Database.stateful{
    integer count = 0;
    public database.querylocator start(Database.BatchableContext bc){
       return database.getqueryLocator('Select Id, Name From Account'); 
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        count = count + 1;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('completed');
        System.debug('No of batches processed: '+count);
    }
    
}

//Database.executeBatch(new BatchApexStateManagementDemo(), 30);