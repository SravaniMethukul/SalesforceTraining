public with sharing class ApexForAccount {
  @AuraEnabled(cacheable=true)
  public static list<Account> getAccounts() {
    try {
      List<Account> acclist = [SELECT Id, Name FROM Account LIMIT 10 OFFSET 25];
      return acclist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
