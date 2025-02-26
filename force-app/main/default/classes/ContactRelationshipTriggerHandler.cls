public class ContactRelationshipTriggerHandler {
    public static void onOwnerUpdateNameChanges(List<Contact_Relationship__c> newlist,Map<Id,Contact_Relationship__c> oldmap){
        set<Id> ownerIds = new set<Id>();
        //owner Id change check with oldmap and newmap
        for(Contact_Relationship__c c:newlist){
        	if(c.OwnerId!=oldMap.get(c.Id).ownerId){
            	ownerIds.add(c.OwnerId);
            }
     	}
        Map<Id,User> uMap = new Map<Id,User>([Select Id, Name From User Where Id In: ownerIds]);
        for(Contact_Relationship__c c:newlist){
        	if(c.OwnerId!=oldMap.get(c.Id).ownerId){
            	//use .Name from map to get value
               	c.Contact_Relationship_Name__c = umap.get(c.ownerId).Name;
           	}
        }   
    }
}