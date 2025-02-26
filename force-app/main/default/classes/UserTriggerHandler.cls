public class UserTriggerHandler {
    public static void createAccountAndAssignPermissionSet(List<User> userlist){
        List<Account> accToInsert = new List<Account>();
        List<PermissionSetAssignment> perlist = new List<PermissionSetAssignment>();
        for(User u:userlist){
            PermissionSet plist = [Select Id from permissionset where Name='Common_permission_set'];
            accToInsert.add(new Account(Name=u.LastName));
            perlist.add(new PermissionSetAssignment(AssigneeId=u.Id,PermissionSetId=plist.Id));
        }
        insert perlist;
        // convert list<Sobject> into string using class called json helps to convert into string
        AccountHelper.createAccount(Json.serialize(accToInsert));
    }
}