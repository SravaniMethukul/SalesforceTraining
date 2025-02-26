public class SchedulableApexDemo implements Schedulable{
    public void execute(SchedulableContext sc){
       // Database.executeBatch(new BatchApexLeadDemo(), 20);
       Database.executeBatch(new BatchApexLeadCS(), 20);
    }
}

// how to execute from apex
// System.Schedule('Job title', cron expression, new classname())
// System.schedule('Lead Schedule', '0 0 22 * * ? *', new SchedulableApexDemo());