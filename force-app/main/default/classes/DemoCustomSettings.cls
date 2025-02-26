@isTest
public class DemoCustomSettings {
	@isTest(seeAlldata=true)
    public static void testCustomSettings(){
        Profile p = [Select Id from Profile where Name='Custom: Marketing Profile'];
        User u = new User(Alias='Standt', Email='sravanisravs1410@gmail.com',
                         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                         LocaleSidKey='en_US', ProfileId=p.Id, TimezoneSidKey='America/Los_Angeles',
                         userName='salesusersravani@testorg.com');
        system.runAs(u)
        {
            System.debug(Lead_Commission__c.getInstance(u.profileId).commission__c);
        }
    }
    
}