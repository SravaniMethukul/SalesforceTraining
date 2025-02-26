public class AccountHelper {
	@future
    public static void createAccount(String accToInsertString){
        List<Account> acclist = (List<Account>)Json.deserialize(accToInsertString, List<Account>.class);
        insert acclist;
    }
    
    @Future
    public static void updateContact(String contacts, String AccountPhone){
        List<Contact> conlist = (List<Contact>)Json.deserialize(contacts, List<Contact>.class);
        List<Contact> conToUpdate = new List<Contact>();
        for(Contact c:conlist){
            Contact c1 = new Contact(Id=c.Id, Phone=AccountPhone);
            conToUpdate.add(c1);
        }
        update conlist;
    }
}