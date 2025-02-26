public class ContactRetreive {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getRelatedContactRecords(String accId) {
    try {
      List<Contact> conList = [
        SELECT Id, FirstName, LastName, AccountId
        FROM Contact
        WHERE AccountId = :accId
      ];
      return conList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
