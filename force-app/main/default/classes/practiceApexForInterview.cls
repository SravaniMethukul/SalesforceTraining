public with sharing class practiceApexForInterview {
  /*@AuraEnabled(cacheable=true)
  public static list<Contact> getContactRecords() {
    try {
      List<Contact> conlist = [SELECT Id, FirstName FROM Contact LIMIT 10];
      return conlist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }*/

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    try {
      list<Account> acclist = [SELECT Id, Name FROM Account LIMIT 10];
      return acclist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
