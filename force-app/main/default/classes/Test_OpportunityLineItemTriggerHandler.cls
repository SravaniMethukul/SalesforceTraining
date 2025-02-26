@istest
public class Test_OpportunityLineItemTriggerHandler {
    @testSetUp
    public static void LoadData(){
        Id standardPB = Test.getStandardPricebookId();
        Product2 p = new Product2(Name='Product 1',ProductCode='PD01',IsActive=True);
        Product2 p1 = new Product2(Name='Product 2',ProductCode='PD02',IsActive=True);
        insert new List<Product2>{p,p1};
        
        Opportunity o=new Opportunity(Name='Opportunity test', CloseDate=date.Today(),StageName='Prospecting',Pricebook2Id=standardPB);
        insert o;
        
        PricebookEntry pbe1 = new PricebookEntry(Pricebook2Id=standardPB,Product2Id=p.Id,IsActive=True,unitPrice=2000);
        PricebookEntry pbe2 = new PricebookEntry(Pricebook2Id=standardPB,Product2Id=p1.Id,IsActive=True,unitPrice=1000);
        insert new List<PricebookEntry>{pbe1,pbe2};
    }
	@isTest
    public static void testupdateOpportunityProductCodeInsert(){
        List<Product2> prodlist = [Select Id,ProductCode From Product2];
        List<Opportunity> opplist = [Select Id,Name From Opportunity];
        OpportunityLineItem ol1 = new OpportunityLineItem(Product2Id=prodlist[0].Id,OpportunityId=opplist[0].Id,quantity=2,TotalPrice=4000);
        OpportunityLineItem ol2 = new OpportunityLineItem(Product2Id=prodlist[1].Id,OpportunityId=opplist[0].Id,quantity=3,TotalPrice=3000);
        
        Test.startTest();
        insert new List<OpportunityLineItem>{ol1,ol2};
        Test.StopTest();
        
        Opportunity opp =  [Select Id, Oppr_LineItems_ProductCode__c From Opportunity];
        assert.areEqual(opp.Oppr_LineItems_ProductCode__c, 'PD01,PD02', 'Product code not updated correctly');
        
    }
    @isTest
    public static void testupdateOpportunityProductCodeDelete(){
        List<Product2> prodlist = [Select Id,ProductCode From Product2];
        List<Opportunity> opplist = [Select Id,Name From Opportunity];
        OpportunityLineItem ol1 = new OpportunityLineItem(Product2Id=prodlist[0].Id,OpportunityId=opplist[0].Id,quantity=2,TotalPrice=4000);
        OpportunityLineItem ol2 = new OpportunityLineItem(Product2Id=prodlist[1].Id,OpportunityId=opplist[0].Id,quantity=3,TotalPrice=3000);
        insert new List<OpportunityLineItem>{ol1,ol2};
        Test.startTest();
        delete ol1;
        Test.StopTest();
        
        Opportunity opp =  [Select Id, Oppr_LineItems_ProductCode__c From Opportunity];
        assert.areEqual(opp.Oppr_LineItems_ProductCode__c, 'PD02', 'Product code not updated correctly');
        
    }
}