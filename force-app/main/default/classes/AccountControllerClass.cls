public class AccountControllerClass {
  /*@AuraEnabled
  public static void updateAnnualRevenue(String recId) {
    try {
      Account acc = new Account();
      acc.Id = recId;
      acc.AnnualRevenue = 16000;
      update acc;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }*/

  //@AuraEnabled(cacheable=true)
  /*public static List<Account> getAccountList(String rating) {
    try {
      System.debug('Entered Apex')
      List<Account> acclist = [
        SELECT Id, Name, AnnualRevenue, Industry, Rating
        FROM Account
        WHERE Rating = :rating
      ];
      return acclist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  public static List<Account> getAccountList(String rating, String industry) {
    try {
      List<Account> acclist = [
        SELECT Id, Name, AnnualRevenue, Industry, Rating
        FROM Account
        WHERE Rating = :rating AND Industry = :industry
      ];
      return acclist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }*/

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccountList() {
    try {
      List<Account> acclist = [
        SELECT Id, Name, AnnualRevenue, Industry, Rating
        FROM Account
        LIMIT 10
        OFFSET 25
      ];

      return acclist;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
