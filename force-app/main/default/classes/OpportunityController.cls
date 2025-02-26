public class OpportunityController {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts(String oppId) {
    try {
      List<Opportunity> accId = [
        SELECT Id, AccountId
        FROM Opportunity
        WHERE Id = :oppId
      ];
      List<Contact> conList = [
        SELECT Id, FirstName, LastName
        FROM Contact
        WHERE AccountId = :accId[0].AccountId
      ];
      return conList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
