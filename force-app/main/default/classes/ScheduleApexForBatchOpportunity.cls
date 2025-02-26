public class ScheduleApexForBatchOpportunity implements Schedulable {
    public void execute(SchedulableContext sc){
        Database.executeBatch(new BatchApexOpportunityDIY(), 20);
    }
}