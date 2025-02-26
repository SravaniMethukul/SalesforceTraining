public class OpportunityLineItemTriggerHandler {
    public static void updateOpportunityProductCode(List<OpportunityLineItem> newlist){
        List<Id> oppIds = new List<Id>();
        List<Opportunity> opplistToupdate = new List<Opportunity>();
        for(OpportunityLineItem o:newlist){
            oppIds.add(o.OpportunityId); // this gives the Id of opportunity for triggered opportunity line Item record
        }
        // this is used to get the opportunity line item from opportunity where lineitem is deleted
        List<OpportunityLineItem> opplinelist = [Select OpportunityId, Product2.ProductCode From OpportunityLineItem Where opportunityId In:oppIds];
        Map<Id, List<String>> mapOfproductCode = new Map<Id,List<String>>();
        if(!opplinelist.isEmpty()){
        	for(OpportunityLineItem ol:opplinelist){
                if(!mapOfproductCode.ContainsKey(ol.OpportunityId)){
                    mapOfproductCode.put(ol.opportunityId, new List<String>());
                }
                String productcodestr = ol.Product2.ProductCode;
                if(productcodestr!=null)
                    mapOfproductCode.get(ol.opportunityId).add(productcodestr);
        	}
            for(Id oppmap:mapOfproductCode.keySet()){
                List<String> strlist = mapOfproductCode.get(oppMap);
                String str = String.join(strlist,',');
                Opportunity o = new Opportunity(Id=oppmap, Oppr_LineItems_ProductCode__c=str);
                opplistToupdate.add(o);
            }
        }
        else{
            List<Opportunity> op = [Select Id, Oppr_LineItems_ProductCode__c From Opportunity Where Id In: oppIds];
            for(Opportunity o:op){
            	Opportunity o1 = new Opportunity(Id=o.Id, Oppr_LineItems_ProductCode__c='');
            	opplistToupdate.add(o1);
            }
        }
        try{
        	if(!opplistToupdate.isEmpty()){
            	update opplistToupdate;
            }
        }
        Catch(Exception e){
        	System.debug(e.getMessage());
        }
	}
}