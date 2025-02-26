public class contactController {
  @AuraEnabled
  public static String insertContact(String lastName, String Mobile) {
    try {
      Contact con = new Contact();
      con.lastName = lastName;
      con.Phone = Mobile;
      insert con;

      return con.Id;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
