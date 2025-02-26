public class ApexCaseStudy {
    public static void testDemo(){
        Integer year = DATE.TODAY().Year();
        System.debug(year);
        
        String userId = UserInfo.getUserId();
        String userName = UserInfo.getUserName();
        String userlocale = UserInfo.getLocale();
        User currentUser = [Select Id, Name, UserPreferencesLightningExperiencePreferred 
                            From user where Id=:userId];
        
        if(currentUser.UserPreferencesLightningExperiencePreferred==True){
            System.debug('prefered userInterface is lightening');
        }
        else
            System.debug('prefered userInterface is Classic');
        
        Integer length_of_loggedinusername = userName.length();
        System.debug('length of logged in user: '+length_of_loggedinusername);
        
        String sub_string_userName = userName.Substring(0,5);
        System.debug('sub_string_userName: '+sub_string_userName);
        
    }
    
    public static void week_start_date(){
        Date today_date = Date.TODAY();
        DateTime today_dt = (DateTime)today_date;
        //return mon,tue etc;
        String dayOfWeek = today_dt.Format('E');
        System.debug(dayOfWeek);
        //return 1,2 etc;
        integer Weekday = integer.valueOf(today_dt.Format('u'));
        System.debug(Weekday);
        
        Date week_start_date = today_date.addDays(-Weekday);
        System.debug(week_start_date);
    }
    
    public static void updateAccount(){
		List<Account> accList = [Select Name, billingstate From Account Where billingstate ='California'];
        for(Account a:accList){
            a.billingstate = 'Florida';
        }
        update accList;
        System.debug(accList);
    }
    
    public static void testSentence(){
        String str = 'she  saw   a    see    saw';
        List<String> lst = new List<String>();
        // use normalize space
        str = str.normalizespace();
        for(String s:str.split(' ')){
        	lst.add(s);
        }
        System.debug(lst);
        Map<String, integer> m = new Map<String,Integer>();
        for(String s:lst){
            if(!m.containsKey(s)){
                m.put(s, 1);
            }
            else{
				m.put(s, m.get(s)+1);
            }
        }
        System.debug(m);
        Set<String> st = new Set<String>(lst);
        for(String s:st){
            System.debug(s + ' appears (' + m.get(s) + ') times');
        }
    }
    
    public static void soslQuery(){
        List<List<Sobject>> result = [Find 'Arun Kumar OR ARAVIND' IN NAME FIELDS Returning Account(Name, Phone), Contact(LastName, Phone), Lead(Name, Phone)];
        for(List<Sobject> res : result ){
            for(Sobject s:res){
                String objecttype = String.valueOf(s.getsObjectType());
                if(objecttype=='Account')
                {
                    System.debug('Account NAME: '+s.get('Name'));
                    System.debug('Phone: '+s.get('phone'));
                }
                else if(objecttype=='Contact'){
                    System.debug('Contact Name: '+s.get('LastName'));
                    System.debug('Phone: '+s.get('Name'));
                }
                else if(objecttype=='Lead'){
                    System.debug('Lead Name: '+s.get('LastName'));
                    System.debug('phone: '+s.get('phone'));
                }
                /*if(s instanceof Account){
                    Account acc = (Account)s;
                    System.debug('Account NAME: '+acc.Name);
                    System.debug('Phone: '+acc.Phone);
                }
                else if(s instanceof Contact){
                    Contact con = (Contact)s;
                    System.debug('Contact Name: '+con.LastName);
                    System.debug('Phone: '+con.Phone);
                }
                else if(s instanceof Lead){
                    Lead l = (Lead)s;
                    System.debug('Lead Name: '+l.Name);
                    System.debug('phone: '+l.Phone);
                }*/
            }
        }
    }
    
    public static void soqlQuery(){
        List<Account> accList = [Select Name, (Select LastName From Contacts) From Account];
        if(!accList.isEmpty()){
            for(Account a:accList){
                System.Debug('Account Name: '+a.Name);
                if(a.contacts.size()>0){
                    for(Contact c:a.contacts)
                    	System.debug('Contact Lastname: '+c.LastName);
                }
                else{
                    System.debug('No contacts found for account: '+a.Name);
                }
            }
        }
    }
    
    public static void insertAccount(){
        List<Account> accl = [Select Id, Name From Account where Name='Ac02' limit 1];
        if(accl.size()>0){
        List<AggregateResult> op = [Select Sum(Amount) Total_opp_Amount From Opportunity
                                   Where AccountId=:accl[0].Id];
        for(AggregateResult res:op){
            System.debug('Total opportunity amount for Account '+accl[0].Name+' is: '+res.get('Total_opp_Amount'));
        }  
        }
        else{
            System.debug('No records found');
        }
    }
    
    public static void AggregateOpportunity(){
        List<AggregateResult> op = [Select Count(Id) Total_Opportunities, StageName From Opportunity
                                   Group by StageName];
        for(AggregateResult res:op){
            System.debug(res.get('StageName')+' '+res.get('Total_Opportunities'));
        }  
    }
    
}