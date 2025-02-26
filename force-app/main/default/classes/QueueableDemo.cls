public class QueueableDemo implements Queueable{
    String strRating;
    Integer batchSize; //2000
    String lastRecordId='0';
    public QueueableDemo(String rating, integer batchSize, String lastRecordId){
        strRating = rating;
        this.batchSize=batchSize;
        this.lastRecordId=lastRecordId;
    }
    /*public void Execute(QueueableContext cxt){
        System.debug('Started');
        List<Account> accList = [Select Id, Rating, owner.email From account where rating=:strRating Limit 15];
        for(Account a:acclist){
            a.Number_Discount__c = Integer.valueOf(label.Account_Discount);
        }
        update accList;
        System.debug(accList);
        List<AsyncApexJob> lst = [Select Id, status from AsyncApexJob Where Id=:cxt.getJobId()];
        System.debug('Job Id list: '+lst);
        if(!Test.isRunningTest()){
        	System.enqueuejob(new QueueableEmailUtilityHelper(accList));
        }
    }*/
    
    // using recursive call
   public void Execute(QueueableContext cxt){
        System.debug('Started');
        List<Account> accList = [Select Id, Rating, owner.email From account where rating=:strRating and Id>:lastRecordId Limit :batchSize];
        for(Account a:acclist){
            a.Number_Discount__c = Integer.valueOf(label.Account_Discount);
        }
        update accList;
        System.debug(accList);
        List<AsyncApexJob> lst = [Select Id, status from AsyncApexJob Where Id=:cxt.getJobId()];
        System.debug('Job Id list: '+lst);
        lastRecordId = accList[accList.size()-1].Id;
        if(accList.size()==batchSize){
        	System.enqueuejob(new QueueableDemo(strRating, 2000, lastRecordId));
        }
    }
}