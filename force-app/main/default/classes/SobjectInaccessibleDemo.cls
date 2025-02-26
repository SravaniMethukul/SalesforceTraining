public class SobjectInaccessibleDemo {
    //Apex Security
    public static void demoInStrip(){
        SobjectAccessDecision sod = Security.StripInAccessible(AccessType.READABLE, [Select Name, Amount, Region__c From Opportunity]);
    	List<Opportunity> oppList = sod.getRecords();
        System.debug(oppList);
        System.debug(sod.getRemovedFields());
        System.debug(sod.getRemovedFields().get('Opportunity').Contains('Region__c'));
    }
    
    public static void demoForDynamicSoql(String sObjectName, List<String> fields){
        String field = String.join(fields,',');
        //Using escapesinglequotes (usually escapedsinglequotes is by default applied for static soql)
        String sobjectn = String.escapeSingleQuotes(sObjectName);
		String query = 'Select '+field+' From '+sobjectn;
        List<Sobject> lst = Database.query(query, AccessLevel.USER_MODE);
        for(Sobject so:lst)
        {
			System.debug(so.get(fields[0]));
        }
    }
    
    public static void demoForDynamicSoqlQueryWithBinds(String AccountName){
        Map<String, String> m = new Map<String, String>();
        m.put('AccountName',AccountName);// map contains key:Field name and value:parameter
		String query = 'Select Name From Account';
        String where_clause = ' Where Name=: AccountName';
        query+=where_clause;
        List<Sobject> lst = Database.queryWithBinds(query,m,AccessLevel.USER_MODE);
        System.debug(lst);
    }
    
    public static void DMLDemoAccessDemo(){
		Account acc = new Account();
        acc.Name = 'Test Apex Security Demo';
        insert as User acc;
    }
}