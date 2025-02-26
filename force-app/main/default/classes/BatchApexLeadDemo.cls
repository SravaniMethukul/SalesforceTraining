public class BatchApexLeadDemo implements Database.Batchable<sObject>, Database.Stateful{
    // root cause: apex update - doesnot support partial update
    // solution: Database.Update - partial update
    Integer recordsProcessed = 0, recordsFailed=0;
    List<string> failedRecords = new List<string>();
    public database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id, Name, Description From Lead where createdDate=LAST_N_DAYS:60 and status=\'Open - Not Contacted\'';
        return Database.getQueryLocator(query);
    }
    
    public void Execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead rec:scope){
            rec.status='Closed Lost';
        } 
        List<Database.SaveResult> srResult = Database.update(scope, false);// support partial update
        for(Database.SaveResult s:srResult){
            if(s.isSuccess()){
                recordsProcessed = recordsProcessed+1;
            }
            else{
                recordsFailed = recordsFailed+1;
                //s.getId()-return Id of failed record
                //url.getOrgDomainUrl().toExternalForm()+'/'+s.getId(); - to get record of Id failed
                failedRecords.add(url.getOrgDomainUrl().toExternalForm()+'/'+s.getId());
            }
        }
    }
    
    public void finish(Database.BatchableContext bc){
        AsyncApexJob asynclist = [Select Id,Status,JobItemsProcessed, TotalJobItems, NumberOfErrors From AsyncApexJob where Id=:bc.getJobId()];
        System.debug(asynclist);  
        String toAddress = 'methukulasravani@gmail.com'; // use custom label
        String subject = 'Lead Batch Job';
        String body = 'Hi Batch Job Status <br/> Total Jobs: '+asynclist.JobItemsProcessed; 
        body+='<br/> Total Records processed: '+recordsProcessed;
        body+='<br/> Total Errors: '+recordsFailed;
        for(String s:failedRecords){
            body+='<br/>'+s;
        }
        EmailHelper.doSendEmail(subject, body, toAddress);
    }
}

//Database.executeBatch(new BatchApexLeadDemo(), 20);