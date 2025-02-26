public class AccountControllerTwo {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAllAccounts(string inputValue) {
    try {
      List<Account> accList = [
        SELECT Id, Name, AccountNumber, BillingState
        FROM Account
        WHERE Name LIKE :('%' + inputValue + '%')
      ];
      return accList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
  public AccountControllerTwo() {
  }
}
