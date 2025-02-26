@isTest
public class Test_userTriggerHandlerFutureMethod {
	@isTest
    public static void testUserCreation(){
        Test.StartTest();
        //1. Make sure trigger is fired create a user
        Profile p = [Select id From Profile where Name = 'Standard Platform User'];
        User u = new User(Alias = 'standt', email='methukulasravani@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles',Username='sravani@ajsd.com');
        insert u;
        Test.StopTest();
        //2. assert account created
        //3. assert permission set assignment
        List<Account> acclist = [Select Name From Account where Name =: u.LastName];
        assert.areEqual(1, acclist.size(), 'Account is not created');
        PermissionSet plist = [Select Id from permissionset where Name='Common_permission_set'];
        List<PermissionSetAssignment> perlist = [Select Id from PermissionSetAssignment where AssigneeId=:u.Id AND PermissionSetId =:plist.id];
        assert.areEqual(1, perlist.size(), 'Permission set assignment is not created');
    }
}