public class BatchApexOpportunityDIY implements Database.Batchable<Sobject>, Database.Stateful{
    Integer recordsFailed=0, recordsProcessed = 0;
    List<String> failedrecords = new List<String>();
    public Database.queryLocator start(Database.BatchableContext bc){
        String query = 'Select Id, StageName, CloseDate From Opportunity where CloseDate < Today and stageName In (\'Prospecting\')';
        return database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> opplist){
        for(Opportunity opp:opplist){
            opp.StageName='closed';
        }
        List<Database.SaveResult> results= Database.update(opplist, False);
        for(Database.SaveResult s: results){
            if(s.isSuccess()){
                recordsProcessed = recordsProcessed+1;
            }
            else{
                recordsFailed = recordsFailed +1;
                failedrecords.add(url.getOrgDomainUrl().toExternalForm()+'/'+s.getid());
            }
        }
    }
    
    public void finish(Database.BatchableContext bc){
        AsyncApexJob async = [Select Id, JobItemsProcessed,  TotalJobItems, NumberOfErrors From AsyncApexJob where Id=:bc.getJobId()];
        setValues(recordsProcessed, recordsFailed, failedrecords, async.JobItemsProcessed);
    }
    
    public static void setValues(Integer Recordsprocessed, Integer RecordsFailed, List<String> failedrecords, Integer JobItemsProcessed){
    	String toAddress = System.label.Email_Address;
        String Subject = 'Opportunity Job List';
        String body = 'Hi Batch Team <br/> Total jobs processed: '+JobItemsProcessed;
        body+='<br/>Records proceesed: '+Recordsprocessed;
        body+='<br/>Records Failed: '+RecordsFailed;
        for(String s:failedrecords){
            body+='<br/> Record Id: '+s;
        }
        SendEmailHelper.sendEmail(Subject, body, toAddress);
    }
}

// Database.executeBatch(new BatchApexOpportunityDIY(), 20);