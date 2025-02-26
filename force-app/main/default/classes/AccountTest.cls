@isTest
public class AccountTest {
    @isTest
    static void testLoadAccountData() {
        // Load data into Account object from the static resource
        List<Account> accountList = (List<Account>) Test.loadData(Account.sObjectType, 'AccountData');
        
        // Verify the data was loaded
        System.assertEquals(2, accountList.size());
        System.assertEquals('Test Account 1', accountList[0].Name);
        System.assertEquals('Technology', accountList[0].Industry);
        System.assertEquals(10000, accountList[0].AnnualRevenue);

        // Additional test assertions can go here
    }
}