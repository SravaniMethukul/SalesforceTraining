public class ContactHelper {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContact() {
    try {
      List<Contact> conList = [
        SELECT Id, FirstName, LastName
        FROM Contact
        LIMIT 10
      ];
      return conList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
