public class BatchApexLeadCS implements Database.Batchable<Sobject>, Database.Stateful{
	integer recordsProcessed=0, recordsfailed=0;
    List<String> failedRecords = new List<String>();
    List<Id> processedLeadIds = new List<Id>();
    List<String> catchResults = new List<String>();
    public Database.queryLocator start(Database.BatchableContext bc){
        //String query = 'Select Id, Location__c, Days_Since_Last_Activity__c From Lead Where Days_Since_Last_Activity__c >= Integer.valueOf(System.label.Number_Of_Days_not_active)';
        String query = 'Select Id, Location__c, Days_Since_Last_Activity__c From Lead Where Days_Since_Last_Activity__c >= 0';
        return Database.getquerylocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> leadlist){
        try{
        	for(Lead l: leadlist){
            	if(l.location__c!=null){
                    UserIdOnLocationNew__mdt metadataRecord = [Select DeveloperName, UserId__c from UserIdOnLocationNew__mdt where MasterLabel =: l.location__c LIMIT 1];
                	l.OwnerId = metadataRecord.UserId__c;
                	//leadlist[leadlist.size()] - leadlist[5] - thats why add try catch
            	}
        	}
        }
        catch(Exception e){
            System.debug(e.getMessage());
            catchResults.add(e.getMessage());
        }
        List<Database.SaveResult> results = database.update(leadlist, false);
        for (integer i = 0; i < results.size(); i++) {
            if(results[i].isSuccess()){
                recordsProcessed = recordsProcessed + 1;
                processedLeadIds.add(results[i].getId());
            }
            else{
                recordsfailed = recordsfailed + 1;
                failedrecords.add(url.getOrgDomainUrl().toExternalForm()+'/'+results[i].getId());
            }
        }
        if(!processedLeadIds.isEmpty())
        {
        	createTask(processedLeadIds);
        }
    }
    
    public void finish(Database.BatchableContext bc){
        AsyncApexJob async = [Select Id, JobItemsProcessed, TotalJobItems, NumberOfErrors From AsyncApexJob where Id=:bc.getJobId()];
        setValuesForEmail(async.JobItemsProcessed);
    }
    
    public void createTask(List<Id> ProcessedId){
        List<Task> tasks = new List<Task>();
        for (Id leadId : processedLeadIds) {
            tasks.add(new Task(
                Subject = 'Follow up with Lead', Status = 'Not Started', WhoId = leadId, Priority='Normal',
                Description = 'Follow up with lead after ownership updated.'));
        }
        if (!tasks.isEmpty()) {
            insert tasks;
        }
    }
    
    public void setValuesForEmail(Integer JobItemsProcessed){
        String toAddress = System.label.Email_Address;
        String subject = 'owner Id changed for leads due to no action';
		String body = 'Hi Team, <br/> records processed: '+recordsProcessed;
        body+='<br/>records failed: '+recordsfailed;
        body+='<br/>below is the list of leads for which action is not taken: ';
        for(String f:failedRecords){
            body+='<br/>record Id: '+f;
        }
        SendEmailHelper.sendEmail(subject, body, toAddress, catchResults);
    }
}

//Database.executeBatch(new BatchApexLeadCS(), 20);