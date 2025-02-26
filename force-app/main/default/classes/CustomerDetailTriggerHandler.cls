public class CustomerDetailTriggerHandler {
    public static void addUserToAccountTeam(List<Customer_Detail__c> newlist){
        List<AccountTeamMember> accTeamToUpdate = new List<AccountTeamMember>();
        for(Customer_Detail__c cd:newlist){
            if(cd.Account_Manager__c!=null){
            	AccountTeamMember a = new AccountTeamMember(
            					AccountId=cd.Account__c,
            					UserId=cd.Account_Manager__c,
								TeamMemberRole=System.label.TeamMemberRole);
            	accTeamToUpdate.add(a);
            }
        }
        
        try{
        	if(!accTeamToUpdate.isEmpty())
        		insert accTeamToUpdate;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}