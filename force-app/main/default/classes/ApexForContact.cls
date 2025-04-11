public with sharing class ApexForContact {
  @AuraEnabled(cacheable=true)
  public static list<Contact> getContacts(String accountId) {
    try {
      List<Contact> contactlist = [
        SELECT Id, LastName
        FROM Contact
        WHERE AccountId = :accountId
      ];
      return contactlist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
