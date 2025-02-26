public with sharing class AccountRecordsRetrieve {
  @AuraEnabled(cacheable=true)
  public static list<Account> getHighRevenueAccountRecords(Integer count) {
    // Check if the user has read access to the Account object
    if (!Schema.sObjectType.Account.isAccessible()) {
      throw new AuraHandledException(
        'You do not have access to Account records.'
      );
    }

    // Check if the user has read access to the specific fields
    if (
      !Schema.sObjectType.Account.fields.AnnualRevenue.isAccessible() ||
      !Schema.sObjectType.Account.fields.Name.isAccessible()
    ) {
      throw new AuraHandledException(
        'You do not have access to the required fields on the Account object.'
      );
    }

    try {
      return [
        SELECT id, Name, AnnualRevenue
        FROM Account
        ORDER BY AnnualRevenue DESC NULLS LAST
        LIMIT :count
      ];
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
