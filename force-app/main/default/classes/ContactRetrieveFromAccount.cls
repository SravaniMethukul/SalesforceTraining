public with sharing class ContactRetrieveFromAccount {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getFetchRelatedContactRecord(String accId) {
    if (!Schema.sObjectType.Contact.isAccessible()) {
      throw new AuraHandledException(
        'You do not have access to Account records.'
      );
    }

    // Check if the user has read access to the specific fields
    if (
      !Schema.sObjectType.Contact.fields.FirstName.isAccessible() ||
      !Schema.sObjectType.Contact.fields.LastName.isAccessible() ||
      !Schema.sObjectType.Contact.fields.AccountId.isAccessible()
    ) {
      throw new AuraHandledException(
        'You do not have access to the required fields on the Contact object.'
      );
    }

    if (String.isBlank(accId)) {
      throw new AuraHandledException('Account ID is missing.');
    }

    try {
      System.debug('AccountId received: ' + accId);
      List<Contact> conList = [
        SELECT Id, FirstName, LastName
        FROM Contact
        WHERE AccountId = :accId
      ];
      if (!conList.isEmpty()) {
        return conList;
      } else {
        return new List<Contact>();
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
