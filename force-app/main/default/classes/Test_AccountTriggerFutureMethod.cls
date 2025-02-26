@isTest
public class Test_AccountTriggerFutureMethod {
	@isTest
    public static void test_contactupdate(){
        Account a = new Account(Name='Account Test 123', Phone='8919967887');
        insert a;
        Contact c= new Contact(LastName='Sravani Test', Phone='9949164545', AccountId = a.Id);
        Contact c1= new Contact(LastName='Hari Test', Phone='9959376000', AccountId = a.Id);
        insert new List<Contact>{c,c1};
        Test.StartTest();
        a.Phone = '9164013138';
        update a;
        Test.StopTest();
        List<Contact> conlist = [Select Id,Phone From Contact where AccountId=:a.Id];
        assert.areEqual(conlist[0].Phone, '9164013138', 'contact phone not updated');
        assert.areEqual(conlist[1].Phone, '9164013138', 'contact phone not updated');
    } 
}