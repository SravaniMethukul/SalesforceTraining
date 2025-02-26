public class DemoCustomMetadata {
    public static Decimal calculateDiscount(String type){
        Decimal discount=0;
        for(Opportunity_Discount__mdt record:Opportunity_Discount__mdt.getAll().values()){
            if(type.equals(record.MasterLabel))
                discount=record.discount__c;
        }
        return discount;
    }
	
}