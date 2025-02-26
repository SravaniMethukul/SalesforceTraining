@isTest
public class QueueableDemoTestForRecursive {
    @testSetUp
    public static void loadData(){
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<15;i++){
            accounts.add(new Account(Name='Account Test '+i, Rating ='Hot'));
        }
        insert accounts;
    }
    
     @isTest
    public static void doTestQueueable(){
        Test.StartTest();
        AsyncOptions newasync = new AsyncOptions();
        newasync.MaximumQueueableStackDepth=10;
        System.enqueuejob(new QueueableDemo('Hot',2000,'0'), newasync);
        Test.StopTest();
        List<Account> accList = [Select name, Rating, owner.email, Number_Discount__c From Account where rating='Hot' and Number_Discount__c=20];
        Assert.areEqual(15, accList.size(),'Queueable failed to update account');
    }
}