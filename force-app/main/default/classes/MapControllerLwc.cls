public with sharing class MapControllerLwc {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    try {
      return [
        SELECT
          Id,
          Name,
          BillingStreet,
          BillingCountry,
          BillingCity,
          BillingState,
          BillingPostalCode
        FROM Account
        WHERE BillingPostalCode != NULL
        ORDER BY Name
        LIMIT 10
      ];
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
