public class CustomProjectHandler {
    public static void updateActiveFieldInOpportunity(List<Custom_Project__c> newlist){
        set<Id> oppIds = new set<Id>();
        for(Custom_Project__c c:newlist){
            if(c.status__c.equals('Active') && c.Opportunity__c!=null){
                oppIds.add(c.Opportunity__c);
            }
        }
        // update AND in where clause for Active_Customer_Project__c
        List<Opportunity> opplist = [Select Id, Active_Customer_Project__c From Opportunity where Id In:oppIds AND Active_Customer_Project__c!=true];
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        try{
            //no need to include line 13
            if(!oppIds.isEmpty()){
                for(Opportunity o:opplist){
                    Opportunity opp = new Opportunity(Id=o.Id, Active_Customer_Project__c=true);
                    oppToUpdate.add(opp);
                }
            }
            if(!oppToUpdate.isEmpty())
            	update oppToUpdate;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        } 
    }
}